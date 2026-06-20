#!/usr/bin/env bash
# notify-walk.sh v1 — walk per-activation home channel files for substantive
# events and post them to Telegram via notify-telegram.sh with rich body
# context (entry body excerpt + clickable GitHub URL).
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
# Delivery semantics — AT-LEAST-ONCE, NOT exactly-once.
#
# v1 enrichment (vs v0):
#   - Notification details now include the entry's body (first ~500
#     chars) + a clickable GitHub URL to the entry's location in the
#     channel file.
#   - Operator can act on most notifications from their phone without
#     re-fetching context from γ-console.
#
# Class detection (v0 heuristic; unchanged):
#   - BLOCKED / ORPHANED / FAIL / DEGRADED / SILENT → blocker
#   - everything else with class: substantive | directive-out → milestone
#
# Env overrides (for testing):
#   NOTIFY_WALK_NOTIFY_SCRIPT  — path to per-message publisher
#                                 (default: <script-dir>/notify-telegram.sh)
#   NOTIFY_WALK_CURSORS        — path to notification-cursors.yaml
#   NOTIFY_WALK_TARGETS        — path to notification-targets.yaml
#   NOTIFY_WALK_CHANNELS_DIR   — path to per-activation channel root
#   NOTIFY_WALK_REPO_URL       — GitHub repo URL for entry links
#                                 (default: https://github.com/usurobor/cn-sigma)
#   NOTIFY_WALK_BRANCH         — branch for entry links (default: main)
#
# No-op without TELEGRAM_BOT_TOKEN.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NOTIFY="${NOTIFY_WALK_NOTIFY_SCRIPT:-${SCRIPT_DIR}/notify-telegram.sh}"
CURSORS_FILE="${NOTIFY_WALK_CURSORS:-${SCRIPT_DIR}/../state/notification-cursors.yaml}"
TARGETS_FILE="${NOTIFY_WALK_TARGETS:-${SCRIPT_DIR}/../state/notification-targets.yaml}"
CHANNELS_DIR="${NOTIFY_WALK_CHANNELS_DIR:-${SCRIPT_DIR}/../threads/activations}"
REPO_URL="${NOTIFY_WALK_REPO_URL:-https://github.com/usurobor/cn-sigma}"
BRANCH="${NOTIFY_WALK_BRANCH:-main}"

# Body excerpt cap — kept well below Telegram's 4096-char limit so the
# total payload (excerpt + URL) stays comfortable. notify-telegram's
# own 4000-char truncation guard is a safety net.
BODY_EXCERPT_MAX=500

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

# Extract the body of an entry (lines after the second `---` frontmatter
# delimiter, until end of entry block). Truncate to BODY_EXCERPT_MAX
# chars with ellipsis marker if longer.
extract_body() {
    local channel="$1" start="$2" end="$3"
    local body
    body="$(sed -n "${start},${end}p" "$channel" | awk '
        BEGIN { fm_seen = 0 }
        /^---[[:space:]]*$/ { fm_seen++; next }
        fm_seen >= 2 { print }
    ')"
    # Trim leading/trailing blank lines
    body="$(echo "$body" | sed -e '/./,$!d' -e ':a;/^\n*$/{$d;N;ba}' || echo "$body")"
    # Truncate
    if [ ${#body} -gt $BODY_EXCERPT_MAX ]; then
        body="${body:0:$BODY_EXCERPT_MAX}…"
    fi
    printf '%s' "$body"
}

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

    mapfile -t CHANNEL_FILES < <(find "$TARGET_DIR" -maxdepth 1 -name '[0-9]*.md' -type f | sort)
    if [ "${#CHANNEL_FILES[@]}" -eq 0 ]; then
        continue
    fi

    echo "[notify-walk] target=$TARGET cursor=$LAST_CURSOR files=${#CHANNEL_FILES[@]}"

    POST_FAILED=0
    for CHANNEL in "${CHANNEL_FILES[@]}"; do
        CHANNEL_BASENAME="$(basename "$CHANNEL")"

        # Find entry start line numbers (each `## YYYY-MM-DDTHH:MM:SSZ — title`)
        mapfile -t ENTRY_STARTS < <(grep -n '^## 20[0-9][0-9]-[0-9][0-9]-[0-9][0-9]T[0-9][0-9]:[0-9][0-9]:[0-9][0-9]Z' "$CHANNEL" | cut -d: -f1)
        [ ${#ENTRY_STARTS[@]} -eq 0 ] && continue
        TOTAL_LINES="$(wc -l < "$CHANNEL")"
        ENTRY_STARTS+=("$((TOTAL_LINES + 1))")  # sentinel for last entry's end

        for ((i = 0; i < ${#ENTRY_STARTS[@]} - 1; i++)); do
            START="${ENTRY_STARTS[$i]}"
            END=$((${ENTRY_STARTS[$((i + 1))]} - 1))

            HEADER="$(sed -n "${START}p" "$CHANNEL")"
            CONTENT="${HEADER#\#\# }"

            # Parse timestamp + title. Em-dash canonical; ASCII hyphen fallback.
            if [[ "$CONTENT" == *" — "* ]]; then
                TS="${CONTENT%% — *}"
                TITLE="${CONTENT#* — }"
            elif [[ "$CONTENT" == *" - "* ]]; then
                TS="${CONTENT%% - *}"
                TITLE="${CONTENT#* - }"
            else
                TS="$CONTENT"
                TITLE=""
            fi

            # Strict greater-than cursor check
            if [ -n "$LAST_CURSOR" ] && [ ! "$TS" \> "$LAST_CURSOR" ]; then
                continue
            fi

            # Extract class from frontmatter
            CLASS="$(sed -n "${START},${END}p" "$CHANNEL" | awk '
                BEGIN { fm = 0 }
                /^---[[:space:]]*$/ { fm++; next }
                fm == 1 && /^class:/ { print $2; exit }
            ')"

            if [ "$CLASS" != "substantive" ] && [ "$CLASS" != "directive-out" ]; then
                continue
            fi

            # Classify for notification class
            NOTIFY_CLASS="milestone"
            TITLE_UPPER="$(echo "$TITLE" | tr '[:lower:]' '[:upper:]')"
            case "$TITLE_UPPER" in
                *BLOCK*|*ORPHAN*|*DEGRADED*|*SILENT*|*FAIL*) NOTIFY_CLASS="blocker" ;;
                *)                                          NOTIFY_CLASS="milestone" ;;
            esac

            # Build entry body excerpt + URL
            BODY_EXCERPT="$(extract_body "$CHANNEL" "$START" "$END")"
            ENTRY_PATH=".cn-sigma/threads/activations/${TARGET}/${CHANNEL_BASENAME}"
            ENTRY_URL="${REPO_URL}/blob/${BRANCH}/${ENTRY_PATH}#L${START}"

            SUMMARY="${TITLE:0:300}"

            # Compose details: body excerpt + location link.
            if [ -n "$BODY_EXCERPT" ]; then
                DETAILS="${BODY_EXCERPT}

📍 ${ENTRY_URL}"
            else
                DETAILS="📍 ${ENTRY_URL}"
            fi

            echo "[notify-walk] POST target=$TARGET class=$NOTIFY_CLASS ts=$TS title=${TITLE:0:60}"
            if "$NOTIFY" "$TARGET" "$NOTIFY_CLASS" "$SUMMARY" "$DETAILS"; then
                NEW_CURSOR="$TS"
                LAST_CURSOR="$TS"
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
