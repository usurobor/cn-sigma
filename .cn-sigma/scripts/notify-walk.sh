#!/usr/bin/env bash
# notify-walk.sh — walk per-activation home channel files for substantive
# events and post them to Telegram via notify-telegram.sh.
#
# Designed to run inside the cn-sigma wake yaml AFTER Sigma's
# claude-code-action step. Sigma's step writes per-activation home
# channel entries; this script reads them and emits Telegram notifications
# for substantive (non-heartbeat) entries that are newer than the
# per-target notification cursor.
#
# Scans ALL files under .cn-sigma/threads/activations/{target}/*.md in
# lexical order, not just today's. Cross-day retry works: a POST failure
# late in the day stays in scope tomorrow.
#
# Cursor model:
#   notification-cursors.yaml stores `cursors.<target>: <iso-timestamp>`
#   per activation target. Walker only emits for entries whose `##
#   YYYY-MM-DDTHH:MM:SSZ` timestamp is strictly greater than the cursor.
#   On successful POST, cursor advances in-memory to the entry's
#   timestamp. The wake yaml's follow-up step commits + pushes the cursor
#   file change.
#
# Delivery semantics — AT-LEAST-ONCE, NOT exactly-once:
#   If POST succeeds but the cursor push (handled by the wake yaml step
#   after this walker) fails, the next wake on a fresh runner will fetch
#   the un-advanced cursor and re-post. v0 accepts this; mitigation
#   requires per-message receipts (Telegram message_id correlation) which
#   is deferred.
#
# Class detection (v0 heuristic):
#   - BLOCKED / ORPHANED / FAIL / DEGRADED / SILENT → blocker
#   - everything else with class: substantive | directive-out → milestone
#
# Env overrides (for testing):
#   NOTIFY_WALK_NOTIFY_SCRIPT  — path to the per-message publisher
#                                 (default: <script-dir>/notify-telegram.sh)
#   NOTIFY_WALK_CURSORS        — path to notification-cursors.yaml
#                                 (default: <script-dir>/../state/notification-cursors.yaml)
#   NOTIFY_WALK_TARGETS        — path to notification-targets.yaml
#                                 (default: <script-dir>/../state/notification-targets.yaml)
#   NOTIFY_WALK_CHANNELS_DIR   — path to per-activation channel root
#                                 (default: <script-dir>/../threads/activations)
#
# No-op without TELEGRAM_BOT_TOKEN.
#
# Exit codes:
#   0 - success, no-op, or all-targets-processed
#   non-zero - script error (missing files unrecoverably, parse failure)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NOTIFY="${NOTIFY_WALK_NOTIFY_SCRIPT:-${SCRIPT_DIR}/notify-telegram.sh}"
CURSORS_FILE="${NOTIFY_WALK_CURSORS:-${SCRIPT_DIR}/../state/notification-cursors.yaml}"
TARGETS_FILE="${NOTIFY_WALK_TARGETS:-${SCRIPT_DIR}/../state/notification-targets.yaml}"
CHANNELS_DIR="${NOTIFY_WALK_CHANNELS_DIR:-${SCRIPT_DIR}/../threads/activations}"

if [ -z "${TELEGRAM_BOT_TOKEN:-}" ]; then
    echo "[notify-walk] TELEGRAM_BOT_TOKEN not set; skipping (no-op)"
    exit 0
fi

if [ ! -f "$TARGETS_FILE" ]; then
    echo "[notify-walk] notification-targets.yaml missing at $TARGETS_FILE; skip" >&2
    exit 0
fi

if [ ! -f "$CURSORS_FILE" ]; then
    echo "[notify-walk] notification-cursors.yaml missing; creating empty at $CURSORS_FILE" >&2
    mkdir -p "$(dirname "$CURSORS_FILE")"
    printf 'schema: cnos.notification-cursors.v0\ncursors: {}\n' > "$CURSORS_FILE"
fi

# Iterate each foreign-activation target (skip cn-sigma; home events are
# γ-console-emitted, not wake-walked).
mapfile -t TARGETS < <(yq eval '.targets | keys | .[]' "$TARGETS_FILE")

for TARGET in "${TARGETS[@]}"; do
    [ "$TARGET" = "cn-sigma" ] && continue

    TARGET_DIR="${CHANNELS_DIR}/${TARGET}"
    if [ ! -d "$TARGET_DIR" ]; then
        continue
    fi

    LAST_CURSOR="$(yq eval ".cursors.\"$TARGET\" // \"\"" "$CURSORS_FILE")"
    NEW_CURSOR="$LAST_CURSOR"

    # All YYYYMMDD.md files in lexical order. Cross-day retry: a POST
    # failure on day N stays in scope on day N+1 because we scan back to
    # the earliest file whose entries could still be after the cursor.
    mapfile -t CHANNEL_FILES < <(find "$TARGET_DIR" -maxdepth 1 -name '[0-9]*.md' -type f | sort)
    if [ "${#CHANNEL_FILES[@]}" -eq 0 ]; then
        continue
    fi

    echo "[notify-walk] target=$TARGET cursor=$LAST_CURSOR files=${#CHANNEL_FILES[@]}"

    POST_FAILED=0
    for CHANNEL in "${CHANNEL_FILES[@]}"; do
        # Parse the channel file entry-by-entry. Each entry starts with
        # `## <iso-timestamp> — <title>` (em-dash) and contains a YAML
        # frontmatter block delimited by `---` lines with a `class:` field.
        #
        # awk emits TSV: <timestamp>\t<class>\t<title>
        mapfile -t ENTRIES < <(awk '
            function flush() {
                if (ts != "") {
                    printf "%s\t%s\t%s\n", ts, klass, title
                }
                ts = ""; klass = ""; title = ""; in_fm = 0
            }
            /^## [0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}Z/ {
                flush()
                line = $0
                sub(/^## /, "", line)
                # Support em-dash separator (canonical) AND ascii hyphen
                # fallback for robustness.
                n = index(line, " — ")
                sep_len = length(" — ")
                if (n == 0) {
                    n = index(line, " - ")
                    sep_len = length(" - ")
                }
                if (n > 0) {
                    ts = substr(line, 1, n - 1)
                    title = substr(line, n + sep_len)
                } else {
                    # No separator; treat everything after timestamp as
                    # title best-effort.
                    n = index(line, " ")
                    if (n > 0) {
                        ts = substr(line, 1, n - 1)
                        title = substr(line, n + 1)
                    } else {
                        ts = line
                        title = ""
                    }
                }
                next
            }
            /^---[[:space:]]*$/ {
                in_fm = !in_fm
                next
            }
            in_fm && /^class:/ {
                klass = $2
                next
            }
            END { flush() }
        ' "$CHANNEL")

        for ROW in "${ENTRIES[@]}"; do
            [ -z "$ROW" ] && continue
            TS="$(awk -F'\t' '{print $1}' <<<"$ROW")"
            CLASS="$(awk -F'\t' '{print $2}' <<<"$ROW")"
            TITLE="$(awk -F'\t' '{print $3}' <<<"$ROW")"

            # Skip heartbeats and other non-substantive classes
            if [ "$CLASS" != "substantive" ] && [ "$CLASS" != "directive-out" ]; then
                continue
            fi

            # Skip entries at-or-before the cursor (strict greater-than)
            if [ -n "$LAST_CURSOR" ] && [ ! "$TS" \> "$LAST_CURSOR" ]; then
                continue
            fi

            # Classify
            NOTIFY_CLASS="milestone"
            TITLE_UPPER="$(echo "$TITLE" | tr '[:lower:]' '[:upper:]')"
            case "$TITLE_UPPER" in
                *BLOCK*|*ORPHAN*|*DEGRADED*|*SILENT*|*FAIL*) NOTIFY_CLASS="blocker" ;;
                *)                                          NOTIFY_CLASS="milestone" ;;
            esac

            # Trim summary length for safety
            SUMMARY="${TITLE:0:300}"

            echo "[notify-walk] POST target=$TARGET class=$NOTIFY_CLASS ts=$TS title=${TITLE:0:60}"
            if "$NOTIFY" "$TARGET" "$NOTIFY_CLASS" "$SUMMARY"; then
                NEW_CURSOR="$TS"
                LAST_CURSOR="$TS"   # so subsequent skip-check works in-loop
            else
                echo "[notify-walk] POST failed; cursor stays; retry next wake" >&2
                POST_FAILED=1
                break
            fi
        done

        [ "$POST_FAILED" = "1" ] && break
    done

    if [ "$NEW_CURSOR" != "$(yq eval ".cursors.\"$TARGET\" // \"\"" "$CURSORS_FILE")" ]; then
        echo "[notify-walk] advancing $TARGET cursor → $NEW_CURSOR"
        yq eval -i ".cursors.\"$TARGET\" = \"$NEW_CURSOR\"" "$CURSORS_FILE"
    fi
done

echo "[notify-walk] done"
exit 0
