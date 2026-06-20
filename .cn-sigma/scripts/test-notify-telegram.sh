#!/usr/bin/env bash
# test-notify-telegram.sh — smoke test for notify-telegram.sh.
#
# Runs three quick checks without hitting the Telegram API:
#   1. bash -n syntax check on notify-telegram.sh
#   2. no-token invocation exits 0 with no-op message
#   3. unknown target exits 2 before any curl
#
# Exit 0 on all pass; non-zero on first failure.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT="${SCRIPT_DIR}/notify-telegram.sh"
ROUTING="${SCRIPT_DIR}/../state/notification-targets.yaml"

PASS=0
FAIL=0

check() {
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

echo "Smoke test: notify-telegram.sh"
echo "--------------------------------"

# 1. Syntax check
echo "[1] bash -n syntax check"
if bash -n "$SCRIPT"; then
    check "syntax check" 0 0
else
    check "syntax check" $? 0
fi

# 2. No-token invocation → exit 0 (no-op)
echo "[2] no-token invocation → exit 0 (no-op)"
set +e
TELEGRAM_BOT_TOKEN="" ROUTING_FILE="$ROUTING" \
    "$SCRIPT" cn-sigma daily-pulse "smoke" >/dev/null 2>&1
RC=$?
set -e
check "no-token no-op" $RC 0

# 3. Unknown target → exit 2 (before curl)
echo "[3] unknown target → exit 2 (rejected before curl)"
set +e
TELEGRAM_BOT_TOKEN="dummy" ROUTING_FILE="$ROUTING" \
    "$SCRIPT" not-a-real-target daily-pulse "smoke" >/dev/null 2>&1
RC=$?
set -e
check "unknown target" $RC 2

# 4. Bonus: class-not-allowed → exit 2 (bonus check; not required by reviewer)
echo "[4] class not allowed for target → exit 2"
set +e
TELEGRAM_BOT_TOKEN="dummy" ROUTING_FILE="$ROUTING" \
    "$SCRIPT" cnos daily-pulse "smoke" >/dev/null 2>&1
RC=$?
set -e
check "class-not-allowed" $RC 2

echo "--------------------------------"
echo "Passed: $PASS  Failed: $FAIL"

if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
exit 0
