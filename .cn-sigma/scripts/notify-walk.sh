#!/usr/bin/env bash
# notify-walk.sh — walk today's per-activation home channel files for
# substantive events and post them to Telegram via notify-telegram.sh.
#
# Designed to run inside the cn-sigma wake yaml AFTER Sigma's
# claude-code-action step. Sigma's step writes per-activation home
# channel entries; this script reads them and emits Telegram notifications
# for substantive (non-heartbeat) entries that are newer than the
# per-target notification cursor.
#
# Cursor model:
#   notification-cursors.yaml stores `cursors.<target>: <iso-timestamp>`
#   per activation target. Walker only emits for entries whose `##
#   YYYY-MM-DDTHH:MM:SSZ` timestamp is strictly greater than the cursor.
#   On successful POST, cursor advances to the entry's timestamp.
#
# Class detection (v0 heuristic):
#   - BLOCKED / ORPHANED / FAIL / degraded / SILENT → blocker
#   - RELEASE / v<X.Y.Z> / LANDED / MERGED → milestone (v1 will split
#     release vs milestone via tag detection)
#   - everything else with class: substantive → milestone
#
# No-op without TELEGRAM_BOT_TOKEN.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NOTIFY="${SCRIPT_DIR}/notify-telegram.sh"
CURSORS_FILE="${SCRIPT_DIR}/../state/notification-cursors.yaml"
TARGETS_FILE="${SCRIPT_DIR}/../state/notification-targets.yaml"
CHANNELS_DIR="${SCRIPT_DIR}/../threads/activations"
DATE="$(date -u +%Y%m%d)"

if [ -z "${TELEGRAM_BOT_TOKEN:-}" ]; then
    echo "[notify-walk] TELEGRAM_BOT_TOKEN not set; skipping (no-op)"
    exit 0
fi

if [ ! -f "$TARGETS_FILE" ]; then
    echo "[notify-walk] notification-targets.yaml missing; skip" >&2
    exit 0
fi

if [ ! -f "$CURSORS_FILE" ]; then
    echo "[notify-walk] notification-cursors.yaml missing; creating empty" >&2
    mkdir -p "$(dirname "$CURSORS_FILE")"
    printf 'schema: cnos.notification-cursors.v0\ncursors: {}\n' > "$CURSORS_FILE"
fi

# Iterate each foreign-activation target (skip cn-sigma; home events are
# γ-console-emitted, not wake-walked).
CHANGED=0
mapfile -t TARGETS < <(yq eval '.targets | keys | .[]' "$TARGETS_FILE")

for TARGET in "${TARGETS[@]}"; do
    [ "$TARGET" = "cn-sigma" ] && continue

    CHANNEL="${CHANNELS_DIR}/${TARGET}/${DATE}.md"
    if [ ! -f "$CHANNEL" ]; then
        continue
    fi

    LAST_CURSOR="$(yq eval ".cursors.\"$TARGET\" // \"\"" "$CURSORS_FILE")"
    NEW_CURSOR="$LAST_CURSOR"

    echo "[notify-walk] target=$TARGET cursor=$LAST_CURSOR channel=$CHANNEL"

    # Parse the channel file entry-by-entry. Each entry starts with
    # `## <iso-timestamp> — <title>` and contains a YAML frontmatter block
    # delimited by `---` lines with a `class:` field.
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
            # Header form: "## <ts> — <title>"
            line = $0
            sub(/^## /, "", line)
            n = index(line, " — ")
            if (n > 0) {
                ts = substr(line, 1, n - 1)
                title = substr(line, n + length(" — "))
            } else {
                ts = $2
                title = ""
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

        # Skip heartbeats and uncategorized
        [ "$CLASS" != "substantive" ] && [ "$CLASS" != "directive-out" ] && continue

        # Skip entries at-or-before the cursor
        if [ -n "$LAST_CURSOR" ] && [ "$TS" \< "$LAST_CURSOR" -o "$TS" = "$LAST_CURSOR" ]; then
            continue
        fi

        # Classify
        NOTIFY_CLASS="milestone"
        TITLE_UPPER="$(echo "$TITLE" | tr '[:lower:]' '[:upper:]')"
        case "$TITLE_UPPER" in
            *BLOCK*|*ORPHAN*|*DEGRADED*|*SILENT*|*FAIL*) NOTIFY_CLASS="blocker" ;;
            *RELEASE*|*V3.*|*V4.*|*LANDED*)             NOTIFY_CLASS="milestone" ;;
            *)                                          NOTIFY_CLASS="milestone" ;;
        esac

        # Trim summary length for safety
        SUMMARY="${TITLE:0:300}"

        echo "[notify-walk] POST target=$TARGET class=$NOTIFY_CLASS ts=$TS title=${TITLE:0:60}"
        if "$NOTIFY" "$TARGET" "$NOTIFY_CLASS" "$SUMMARY"; then
            NEW_CURSOR="$TS"
        else
            echo "[notify-walk] POST failed; cursor stays at $LAST_CURSOR; will retry next wake" >&2
            # Don't advance further on failure; stop processing this target
            break
        fi
    done

    if [ "$NEW_CURSOR" != "$LAST_CURSOR" ]; then
        echo "[notify-walk] advancing $TARGET cursor: $LAST_CURSOR -> $NEW_CURSOR"
        yq eval -i ".cursors.\"$TARGET\" = \"$NEW_CURSOR\"" "$CURSORS_FILE"
        CHANGED=1
    fi
done

# Commit + push cursor advance if changed.
if [ "$CHANGED" = "1" ]; then
    git add "$CURSORS_FILE"
    if ! git diff --cached --quiet; then
        git -c user.email="sigma@cn-sigma.cnos" -c user.name="Sigma" \
            commit -m "notify-walk: advance notification cursors"
        git push origin main || {
            echo "[notify-walk] push failed; cursor commit landed locally only" >&2
            exit 0
        }
    fi
fi

echo "[notify-walk] done"
exit 0
