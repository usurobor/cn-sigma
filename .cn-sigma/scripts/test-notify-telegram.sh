#!/usr/bin/env bash
# test-notify-telegram.sh — smoke test for notify-telegram.sh.
#
# Runs five quick checks without hitting the Telegram API:
#   1. bash -n syntax check on notify-telegram.sh
#   2. no-token invocation exits 0 with no-op message
#   3. unknown target exits 2 (before any curl)
#   4. class-not-allowed-for-target exits 2 (validation works)
#   5. dry-run with valid route exits 0 AND payload reaches construction
#      (proves the YAML actually parses and routing resolves end-to-end)
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

# 5. Dry-run with valid route → exit 0 + payload contains expected fields
# This is the POSITIVE routing-parse test: proves YAML parses cleanly AND
# the routing resolves to a buildable Telegram payload. Without this, the
# other "exit 2" checks could pass even if the YAML extraction were broken
# (same exit code for "config missing" and "expected validation failure").
echo "[5] dry-run valid route → exit 0 + payload built"
set +e
OUTPUT=$(TELEGRAM_BOT_TOKEN="" ROUTING_FILE="$ROUTING" \
    NOTIFY_TELEGRAM_DRY_RUN=1 \
    "$SCRIPT" cn-sigma daily-pulse "smoke" "details line" 2>&1)
RC=$?
set -e
check_exit "dry-run exit" $RC 0
check_contains "dry-run marker"    "$OUTPUT" "DRY_RUN"
check_contains "dry-run chat_id"   "$OUTPUT" "-1004411092548"
check_contains "dry-run thread_id" "$OUTPUT" '"message_thread_id": 1'
check_contains "dry-run summary"   "$OUTPUT" "[daily-pulse] smoke"

echo "--------------------------------"
echo "Passed: $PASS  Failed: $FAIL"

if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
exit 0
