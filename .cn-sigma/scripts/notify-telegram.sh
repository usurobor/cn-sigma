#!/usr/bin/env bash
# notify-telegram.sh — Send a notification to Telegram via the Sigma bot.
#
# Sigma's single-voice notification publisher. Reads routing config from
# .cn-sigma/state/notification-targets.yaml, resolves chat_id +
# topic_thread_id for the target, validates the class is allowed for
# the target, formats the message, POSTs to Telegram's sendMessage API.
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
#   TELEGRAM_BOT_TOKEN  - bot token. If absent, exits 0 with no-op message
#                         (private deployments / forks without Telegram
#                         configured don't fail wakes).
#   ROUTING_FILE        - (optional) override path to notification-targets.yaml.
#                         Defaults to ../state/notification-targets.yaml relative
#                         to this script.
#
# Exit codes:
#   0 - success, or no-op (TELEGRAM_BOT_TOKEN unset)
#   1 - argument error
#   2 - routing config missing, target not found, OR class not allowed for target
#   3 - Telegram API error

set -euo pipefail

# --- input ---

if [ $# -lt 3 ]; then
    echo "Usage: notify-telegram.sh TARGET CLASS SUMMARY [DETAILS]" >&2
    exit 1
fi

TARGET="$1"
CLASS="$2"
SUMMARY="$3"
DETAILS="${4:-}"

# --- no-op without bot token ---

if [ -z "${TELEGRAM_BOT_TOKEN:-}" ]; then
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

# notification-targets.yaml is a markdown file with a ```yaml fenced block.
# Extract just the yaml block for yq.
YAML_BODY=$(awk '/^```yaml$/{flag=1;next}/^```$/{if(flag){flag=0}}flag' "$ROUTING_FILE")
if [ -z "$YAML_BODY" ]; then
    echo "[notify-telegram] could not extract yaml block from $ROUTING_FILE" >&2
    exit 2
fi

# --- resolve target ---

CHAT_ID=$(echo "$YAML_BODY" | yq eval '.supergroup.chat_id' -)
if [ "$CHAT_ID" = "null" ] || [ -z "$CHAT_ID" ]; then
    echo "[notify-telegram] supergroup.chat_id not found in routing config" >&2
    exit 2
fi

# Check target exists
TARGET_EXISTS=$(echo "$YAML_BODY" | yq eval ".targets | has(\"$TARGET\")" -)
if [ "$TARGET_EXISTS" != "true" ]; then
    echo "[notify-telegram] target '$TARGET' not found in routing config" >&2
    exit 2
fi

# Validate class is allowed for target
CLASS_ALLOWED=$(echo "$YAML_BODY" | yq eval ".targets.\"$TARGET\".classes | contains([\"$CLASS\"])" -)
if [ "$CLASS_ALLOWED" != "true" ]; then
    echo "[notify-telegram] class '$CLASS' not allowed for target '$TARGET'" >&2
    exit 2
fi

TOPIC_ID=$(echo "$YAML_BODY" | yq eval ".targets.\"$TARGET\".topic_thread_id" -)
if [ "$TOPIC_ID" = "null" ] || [ -z "$TOPIC_ID" ]; then
    echo "[notify-telegram] target '$TARGET' has no topic_thread_id in routing config" >&2
    exit 2
fi

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
# parsing and would cause Telegram to reject the message. We can add
# formatting later via HTML with explicit escaping or Telegram entities.
MESSAGE="${EMOJI} [${CLASS}] ${SUMMARY}"
if [ -n "$DETAILS" ]; then
    MESSAGE="${MESSAGE}

${DETAILS}"
fi

# --- post to Telegram ---

API="https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage"

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
