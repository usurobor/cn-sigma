#!/usr/bin/env bash
# notify-telegram.sh — Send a notification to Telegram via the Sigma bot.
#
# Sigma's single-voice notification publisher. Reads routing config from
# the pure-YAML file at .cn-sigma/state/notification-targets.yaml,
# resolves chat_id + topic_thread_id for the target, validates the class
# is allowed for the target, formats the message, POSTs to Telegram's
# sendMessage API.
#
# Activations write notification intents to their own foreign log. The
# cn-sigma worker reads foreign logs, detects notify-worthy events, and
# invokes this script.
#
# Usage:
#   notify-telegram.sh TARGET CLASS SUMMARY [DETAILS]
#
# Args:
#   TARGET   - target name (must match a key under `targets:` in
#              notification-targets.yaml; e.g., cnos, bumpt, cn-sigma)
#   CLASS    - event class. Must be listed under `targets.<TARGET>.classes`
#              in the routing config. Examples: release, blocker, milestone,
#              ci-failure (per-activation); daily-pulse, doctrine-evolution,
#              cross-activation-rollup, escalation (cn-sigma General).
#   SUMMARY  - one-line summary text
#   DETAILS  - (optional) multi-line additional context
#
# Env:
#   TELEGRAM_BOT_TOKEN         - bot token. If absent, exits 0 with no-op
#                                message (private deployments / forks without
#                                Telegram configured don't fail wakes).
#   ROUTING_FILE               - (optional) override path to
#                                notification-targets.yaml. Defaults to
#                                ../state/notification-targets.yaml relative
#                                to this script.
#   NOTIFY_TELEGRAM_DRY_RUN    - if set to "1", validates routing and builds
#                                the payload but does NOT call the Telegram
#                                API. Emits the resolved payload to stdout
#                                and exits 0. Used by the smoke test to verify
#                                end-to-end resolution without network calls.
#
# Exit codes:
#   0 - success, no-op (TELEGRAM_BOT_TOKEN unset), or dry-run completion
#   1 - argument error
#   2 - routing config missing, target not found, class not allowed for
#       target, OR topic_thread_id missing for target
#   3 - Telegram API error

set -euo pipefail

# Message text limit per Telegram sendMessage; truncate just under to leave
# room for the truncation marker.
readonly TELEGRAM_TEXT_LIMIT=4096
readonly SAFE_TRUNCATE_AT=4000
readonly TRUNCATION_MARKER=$'\n\n[truncated]'

# --- input ---

if [ $# -lt 3 ]; then
    echo "Usage: notify-telegram.sh TARGET CLASS SUMMARY [DETAILS]" >&2
    exit 1
fi

TARGET="$1"
CLASS="$2"
SUMMARY="$3"
DETAILS="${4:-}"

# --- no-op without bot token (unless dry-run) ---

if [ -z "${TELEGRAM_BOT_TOKEN:-}" ] && [ "${NOTIFY_TELEGRAM_DRY_RUN:-}" != "1" ]; then
    echo "[notify-telegram] TELEGRAM_BOT_TOKEN not set; skipping (no-op)"
    exit 0
fi

# --- locate routing config ---

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEFAULT_ROUTING="${SCRIPT_DIR}/../state/notification-targets.yaml"
ROUTING_FILE="${ROUTING_FILE:-$DEFAULT_ROUTING}"

if [ ! -f "$ROUTING_FILE" ]; then
    echo "[notify-telegram] notification-targets.yaml not found at $ROUTING_FILE" >&2
    exit 2
fi

# Pure YAML; read directly with yq (no markdown fence extraction).

# --- resolve target ---

CHAT_ID=$(yq eval '.supergroup.chat_id' "$ROUTING_FILE")
if [ "$CHAT_ID" = "null" ] || [ -z "$CHAT_ID" ]; then
    echo "[notify-telegram] supergroup.chat_id not found in routing config" >&2
    exit 2
fi

# Check target exists
TARGET_EXISTS=$(yq eval ".targets | has(\"$TARGET\")" "$ROUTING_FILE")
if [ "$TARGET_EXISTS" != "true" ]; then
    echo "[notify-telegram] target '$TARGET' not found in routing config" >&2
    exit 2
fi

# Validate class is allowed for target
CLASS_ALLOWED=$(yq eval ".targets.\"$TARGET\".classes | contains([\"$CLASS\"])" "$ROUTING_FILE")
if [ "$CLASS_ALLOWED" != "true" ]; then
    echo "[notify-telegram] class '$CLASS' not allowed for target '$TARGET'" >&2
    exit 2
fi

TOPIC_ID=$(yq eval ".targets.\"$TARGET\".topic_thread_id" "$ROUTING_FILE")
# topic_thread_id may be null intentionally: Telegram's General topic in a
# forum supergroup has NO addressable message_thread_id even though the
# t.me URL shows /1/. For those targets, we omit `message_thread_id` from
# the API call entirely. An integer value means a custom topic and gets
# passed through as `message_thread_id`.

# --- format message per class ---

# Severity & emoji per class
case "$CLASS" in
    release)                 EMOJI="🚀" ;;
    blocker)                 EMOJI="🔴" ;;
    milestone)               EMOJI="✨" ;;
    ci-failure)              EMOJI="❌" ;;
    daily-pulse)             EMOJI="📊" ;;
    doctrine-evolution)      EMOJI="📜" ;;
    cross-activation-rollup) EMOJI="🌐" ;;
    escalation)              EMOJI="🚨" ;;
    *)                       EMOJI="ℹ️" ;;
esac

# Plain text; no parse_mode. Caller-supplied summary/details often contain
# underscores, brackets, links, hashes — all of which break Markdown
# parsing and would cause Telegram to reject the message.
MESSAGE="${EMOJI} [${CLASS}] ${SUMMARY}"
if [ -n "$DETAILS" ]; then
    MESSAGE="${MESSAGE}

${DETAILS}"
fi

# Length guard: Telegram sendMessage caps text at 4096 chars. Truncate to a
# safe margin and append a truncation marker so long blocker reports or CI
# excerpts don't cause the entire message to be rejected.
MESSAGE_LEN=${#MESSAGE}
if [ "$MESSAGE_LEN" -gt "$TELEGRAM_TEXT_LIMIT" ]; then
    MESSAGE="${MESSAGE:0:$SAFE_TRUNCATE_AT}${TRUNCATION_MARKER}"
fi

# --- build JSON payload ---

if [ "$TOPIC_ID" = "null" ] || [ -z "$TOPIC_ID" ]; then
    # General topic: omit message_thread_id entirely.
    JSON_BODY=$(jq -n \
        --arg chat_id "$CHAT_ID" \
        --arg text "$MESSAGE" \
        '{
            chat_id: ($chat_id | tonumber),
            text: $text,
            disable_web_page_preview: true
        }')
else
    # Custom topic: pass message_thread_id.
    JSON_BODY=$(jq -n \
        --arg chat_id "$CHAT_ID" \
        --arg text "$MESSAGE" \
        --argjson topic "$TOPIC_ID" \
        '{
            chat_id: ($chat_id | tonumber),
            text: $text,
            disable_web_page_preview: true,
            message_thread_id: $topic
        }')
fi

# --- dry-run short-circuit ---

if [ "${NOTIFY_TELEGRAM_DRY_RUN:-}" = "1" ]; then
    echo "[notify-telegram] DRY_RUN: would post target=$TARGET class=$CLASS"
    echo "$JSON_BODY"
    exit 0
fi

# --- post to Telegram ---

API="https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage"

RESPONSE=$(curl -s -X POST "$API" \
    -H "Content-Type: application/json" \
    -d "$JSON_BODY")

OK=$(echo "$RESPONSE" | jq -r '.ok')
if [ "$OK" != "true" ]; then
    DESC=$(echo "$RESPONSE" | jq -r '.description // "unknown error"')
    # Don't log full request body — caller-supplied text could leak into
    # public Actions logs. Just log target/class/error description.
    echo "[notify-telegram] target=$TARGET class=$CLASS telegram_error=$DESC" >&2
    exit 3
fi

MSG_ID=$(echo "$RESPONSE" | jq -r '.result.message_id')
echo "[notify-telegram] posted target=$TARGET class=$CLASS message_id=$MSG_ID"
exit 0
