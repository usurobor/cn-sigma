#!/usr/bin/env bash
# test-notify-telegram.sh — smoke test for notify-telegram.sh.
#
# Runs quick checks without hitting the Telegram API:
#   1. bash -n syntax check on notify-telegram.sh
#   2. no-token invocation exits 0 with no-op message
#   3. unknown target exits 2 (before any curl)
#   4. class-not-allowed-for-target exits 2 (validation works)
#   5a. dry-run valid CUSTOM-topic route (cnos=2) → exit 0 + payload has
#       explicit message_thread_id (positive routing-parse proof)
#   5b. dry-run General route (cn-sigma; topic_thread_id: null) → exit 0
#       AND payload MUST NOT contain message_thread_id (Telegram General
#       topic semantics; passing thread_id 1 returns "message thread not
#       found")
#
# Exit 0 on all pass; non-zero on first failure.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT="${SCRIPT_DIR}/notify-telegram.sh"
ROUTING="${SCRIPT_DIR}/../state/notification-targets.yaml"

PASS=0
FAIL=0

check_exit() {
    local name="$1"
    local exit_code="$2"
    local expected="$3"
    if [ "$exit_code" = "$expected" ]; then
        echo "  PASS: $name (exit=$exit_code)"
        PASS=$((PASS + 1))
    else
        echo "  FAIL: $name (exit=$exit_code, expected=$expected)" >&2
        FAIL=$((FAIL + 1))
    fi
}

check_contains() {
    local name="$1"
    local haystack="$2"
    local needle="$3"
    # Use `--` so needles beginning with `-` (e.g., the negative chat_id
    # -1004411092548) aren't interpreted as grep options.
    if echo "$haystack" | grep -qF -- "$needle"; then
        echo "  PASS: $name (contains '$needle')"
        PASS=$((PASS + 1))
    else
        echo "  FAIL: $name (missing '$needle')" >&2
        echo "  ----- output -----" >&2
        echo "$haystack" >&2
        echo "  ------------------" >&2
        FAIL=$((FAIL + 1))
    fi
}

echo "Smoke test: notify-telegram.sh"
echo "--------------------------------"

# 1. Syntax check
echo "[1] bash -n syntax check"
if bash -n "$SCRIPT"; then
    check_exit "syntax check" 0 0
else
    check_exit "syntax check" $? 0
fi

# 2. No-token invocation → exit 0 (no-op)
echo "[2] no-token invocation → exit 0 (no-op)"
set +e
TELEGRAM_BOT_TOKEN="" ROUTING_FILE="$ROUTING" \
    "$SCRIPT" cn-sigma daily-pulse "smoke" >/dev/null 2>&1
RC=$?
set -e
check_exit "no-token no-op" $RC 0

# 3. Unknown target → exit 2 (before curl)
echo "[3] unknown target → exit 2"
set +e
TELEGRAM_BOT_TOKEN="dummy" ROUTING_FILE="$ROUTING" \
    "$SCRIPT" not-a-real-target daily-pulse "smoke" >/dev/null 2>&1
RC=$?
set -e
check_exit "unknown target" $RC 2

# 4. Class not allowed for target → exit 2
echo "[4] class not allowed for target → exit 2"
set +e
TELEGRAM_BOT_TOKEN="dummy" ROUTING_FILE="$ROUTING" \
    "$SCRIPT" cnos daily-pulse "smoke" >/dev/null 2>&1
RC=$?
set -e
check_exit "class-not-allowed" $RC 2

# 5a. Dry-run with valid route to a CUSTOM topic (cnos=2) → exit 0 + payload
# contains explicit message_thread_id. This is the POSITIVE routing-parse
# test: proves YAML parses cleanly AND routing resolves to a buildable
# Telegram payload. Without this, the "exit 2" checks above could pass
# even if YAML parsing were broken (same exit code for "config missing"
# and "expected validation failure").
echo "[5a] dry-run valid custom-topic route (cnos) → exit 0 + thread_id present"
set +e
OUTPUT=$(TELEGRAM_BOT_TOKEN="" ROUTING_FILE="$ROUTING" \
    NOTIFY_TELEGRAM_DRY_RUN=1 \
    "$SCRIPT" cnos release "smoke" "details line" 2>&1)
RC=$?
set -e
check_exit "dry-run cnos exit" $RC 0
check_contains "dry-run cnos marker"    "$OUTPUT" "DRY_RUN"
check_contains "dry-run cnos chat_id"   "$OUTPUT" "-1004411092548"
check_contains "dry-run cnos thread_id" "$OUTPUT" '"message_thread_id": 2'
check_contains "dry-run cnos summary"   "$OUTPUT" "[release] smoke"

# 5b. Dry-run for cn-sigma (General topic; topic_thread_id: null) → exit 0
# AND payload MUST NOT contain message_thread_id (Telegram's General topic
# has no addressable thread id; passing one gives "message thread not found").
echo "[5b] dry-run General route (cn-sigma) → exit 0 + thread_id ABSENT"
set +e
OUTPUT=$(TELEGRAM_BOT_TOKEN="" ROUTING_FILE="$ROUTING" \
    NOTIFY_TELEGRAM_DRY_RUN=1 \
    "$SCRIPT" cn-sigma daily-pulse "smoke" 2>&1)
RC=$?
set -e
check_exit "dry-run cn-sigma exit" $RC 0
check_contains "dry-run cn-sigma marker"  "$OUTPUT" "DRY_RUN"
check_contains "dry-run cn-sigma chat_id" "$OUTPUT" "-1004411092548"
check_contains "dry-run cn-sigma summary" "$OUTPUT" "[daily-pulse] smoke"
if echo "$OUTPUT" | grep -qF -- "message_thread_id"; then
    echo "  FAIL: dry-run cn-sigma must NOT contain message_thread_id (General)" >&2
    FAIL=$((FAIL + 1))
else
    echo "  PASS: dry-run cn-sigma omits message_thread_id (General)"
    PASS=$((PASS + 1))
fi

echo "--------------------------------"
echo "Passed: $PASS  Failed: $FAIL"

if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
exit 0
