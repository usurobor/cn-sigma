#!/usr/bin/env bash
# notify-telegram.sh — Send a notification to Telegram via the Sigma bot.
#
# Sigma's single-voice notification publisher. Reads routing config from
# .cn-sigma/state/notification-targets.yaml, resolves chat_id +
# topic_thread_id for the target, formats the message per class, POSTs
# to Telegram's sendMessage API.
#
# Activations write notification intents to their own foreign log (with
# `notify:` frontmatter field). The cn-sigma worker reads foreign logs,
# detects notify entries, and invokes this script. See cnos#agent/
# notification-protocol for the convention.
#
# Usage:
#   notify-telegram.sh <target> <class> <summary> [details]
#
# Args:
#   target   - target name (must match a key under `targets:` in
#              notification-targets.yaml; e.g., cnos, bumpt, cn-sigma)
#   class    - event class (release | blocker | milestone | ci-failure |
#              daily-pulse | doctrine-evolution | cross-activation-rollup |
#              escalation)
#   summary  - one-line summary text
#   details  - (optional) multi-line additional context
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
#   2 - routing config missing or target not found
#   3 - Telegram API error

set -euo pipefail

# --- input ---

if [ $# -lt 3 ]; then
    echo "Usage: notify-telegram.sh <target> <class> <summary> [details]" >&2
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

TOPIC_ID=$(echo "$YAML_BODY" | yq eval ".targets.\"$TARGET\".topic_thread_id" -)
# TOPIC_ID is one of: integer (custom topic) | "null" string (General; no message_thread_id)

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

MESSAGE="${EMOJI} *[${CLASS}]* ${SUMMARY}"
if [ -n "$DETAILS" ]; then
    MESSAGE="${MESSAGE}

${DETAILS}"
fi

# --- post to Telegram ---

API="https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage"

# Build POST body. Conditionally include message_thread_id only for custom topics.
if [ "$TOPIC_ID" != "null" ] && [ -n "$TOPIC_ID" ]; then
    JSON_BODY=$(jq -n \
        --arg chat_id "$CHAT_ID" \
        --arg text "$MESSAGE" \
        --argjson topic "$TOPIC_ID" \
        '{
            chat_id: ($chat_id | tonumber),
            text: $text,
            parse_mode: "Markdown",
            disable_web_page_preview: true,
            message_thread_id: $topic
        }')
else
    # General topic: omit message_thread_id
    JSON_BODY=$(jq -n \
        --arg chat_id "$CHAT_ID" \
        --arg text "$MESSAGE" \
        '{
            chat_id: ($chat_id | tonumber),
            text: $text,
            parse_mode: "Markdown",
            disable_web_page_preview: true
        }')
fi

RESPONSE=$(curl -s -X POST "$API" \
    -H "Content-Type: application/json" \
    -d "$JSON_BODY")

OK=$(echo "$RESPONSE" | jq -r '.ok')
if [ "$OK" != "true" ]; then
    DESC=$(echo "$RESPONSE" | jq -r '.description // "unknown error"')
    echo "[notify-telegram] Telegram API error: $DESC" >&2
    echo "[notify-telegram] request body: $JSON_BODY" >&2
    exit 3
fi

MSG_ID=$(echo "$RESPONSE" | jq -r '.result.message_id')
echo "[notify-telegram] posted target=$TARGET class=$CLASS message_id=$MSG_ID"
exit 0
