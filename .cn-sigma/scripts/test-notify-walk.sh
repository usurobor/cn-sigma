#!/usr/bin/env bash
# test-notify-walk.sh — smoke test for notify-walk.sh.
#
# Runs fixture-based checks without hitting the real Telegram API or
# touching the real cn-sigma state. Uses env overrides
# (NOTIFY_WALK_NOTIFY_SCRIPT / _CURSORS / _TARGETS / _CHANNELS_DIR) to
# point the walker at a tmp fixture.
#
# Checks:
#   1. bash -n syntax check
#   2. no-token invocation exits 0 (no-op)
#   3. heartbeat entries skipped; substantive posted; cursor advances
#   4. failed POST leaves cursor unchanged
#   5. older-date file processed when cursor is behind (cross-day retry)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WALKER="${SCRIPT_DIR}/notify-walk.sh"

PASS=0
FAIL=0

ok() {   echo "  PASS: $1"; PASS=$((PASS + 1)); }
bad() {  echo "  FAIL: $1" >&2; FAIL=$((FAIL + 1)); }

assert_eq() {
    local name="$1" got="$2" want="$3"
    if [ "$got" = "$want" ]; then
        ok "$name (=$got)"
    else
        bad "$name (got=$got want=$want)"
    fi
}

assert_file_line_count() {
    local name="$1" file="$2" want="$3"
    local got
    got=$(wc -l < "$file" 2>/dev/null || echo 0)
    assert_eq "$name" "$got" "$want"
}

mk_fixture() {
    local dir="$1"
    mkdir -p "${dir}/state" "${dir}/threads/activations/cnos" "${dir}/threads/activations/bumpt"
    cat > "${dir}/state/notification-targets.yaml" <<EOF
schema: cnos.notification-targets.v0
supergroup:
  chat_id: -1004411092548
targets:
  cn-sigma:
    topic_thread_id: null
    classes: [daily-pulse, doctrine-evolution]
  cnos:
    topic_thread_id: 2
    classes: [release, blocker, milestone, ci-failure]
  bumpt:
    topic_thread_id: 7
    classes: [release, blocker, milestone, ci-failure]
EOF
    cat > "${dir}/state/notification-cursors.yaml" <<EOF
schema: cnos.notification-cursors.v0
cursors:
  cnos: null
  bumpt: null
EOF
}

mk_fake_notify() {
    local dir="$1" log="$2" rc="${3:-0}"
    local script="${dir}/fake-notify-${rc}.sh"
    cat > "$script" <<EOF
#!/usr/bin/env bash
# Record all 4 args: target | class | summary | details
echo "\$1|\$2|\$3|\${4:-}" >> "$log"
exit $rc
EOF
    chmod +x "$script"
    echo "$script"
}

echo "Smoke test: notify-walk.sh"
echo "--------------------------"

# 1. Syntax
echo "[1] bash -n syntax"
if bash -n "$WALKER"; then
    ok "syntax"
else
    bad "syntax"
fi

# 2. No-token no-op
echo "[2] no-token → exit 0 (no-op)"
set +e
TELEGRAM_BOT_TOKEN="" "$WALKER" >/dev/null 2>&1
RC=$?
set -e
assert_eq "no-token exit" "$RC" "0"

# 3. Heartbeat skipped, substantive posted, cursor advances
echo "[3] heartbeat-skip + substantive-post + cursor-advance"
F3=$(mktemp -d)
trap "rm -rf $F3" RETURN
mk_fixture "$F3"
NOTIFY_LOG="${F3}/calls.log"
: > "$NOTIFY_LOG"
FAKE=$(mk_fake_notify "$F3" "$NOTIFY_LOG" 0)

cat > "${F3}/threads/activations/cnos/20260619.md" <<'EOF'
# cnos channel — 2026-06-19

## 2026-06-19T10:00:00Z — heartbeat entry

---
at: cn-sigma
mode: home
class: heartbeat
---

Should be skipped.

## 2026-06-19T15:00:00Z — Directive 99 substantive work

---
at: cn-sigma
mode: home
class: substantive
---

Body line one with some context.
Body line two referencing some action.
EOF

set +e
TELEGRAM_BOT_TOKEN=dummy \
NOTIFY_WALK_NOTIFY_SCRIPT="$FAKE" \
NOTIFY_WALK_CURSORS="${F3}/state/notification-cursors.yaml" \
NOTIFY_WALK_TARGETS="${F3}/state/notification-targets.yaml" \
NOTIFY_WALK_CHANNELS_DIR="${F3}/threads/activations" \
NOTIFY_WALK_REPO_URL="https://github.com/usurobor/cn-sigma" \
NOTIFY_WALK_BRANCH="main" \
    "$WALKER" >/dev/null 2>&1
RC=$?
set -e
assert_eq "exit 0" "$RC" "0"

assert_file_line_count "1 call recorded" "$NOTIFY_LOG" "1"

POSTED_LINE=$(head -1 "$NOTIFY_LOG" 2>/dev/null || echo "")
case "$POSTED_LINE" in
    cnos\|milestone\|*Directive*99*) ok "cnos|milestone|Directive 99 posted" ;;
    *)                                bad "expected cnos|milestone|Directive...; got: $POSTED_LINE" ;;
esac

# v1: details should contain body excerpt + URL with the entry's start line
case "$POSTED_LINE" in
    *"Body line one"*)
        ok "v1 details include body excerpt"
        ;;
    *)
        bad "v1 details missing body excerpt; got: $POSTED_LINE"
        ;;
esac
case "$POSTED_LINE" in
    *"github.com/usurobor/cn-sigma/blob/main/.cn-sigma/threads/activations/cnos/20260619.md#L"*)
        ok "v1 details include channel URL with line anchor"
        ;;
    *)
        bad "v1 details missing channel URL; got: $POSTED_LINE"
        ;;
esac

CURSOR_AFTER=$(yq eval '.cursors.cnos' "${F3}/state/notification-cursors.yaml")
assert_eq "cursor advanced to substantive ts" "$CURSOR_AFTER" "2026-06-19T15:00:00Z"

# 4. Failed POST leaves cursor unchanged
echo "[4] failed POST → cursor unchanged"
F4=$(mktemp -d)
trap "rm -rf $F4" RETURN
mk_fixture "$F4"
NOTIFY_LOG="${F4}/calls.log"
: > "$NOTIFY_LOG"
FAKE_FAIL=$(mk_fake_notify "$F4" "$NOTIFY_LOG" 3)

cat > "${F4}/threads/activations/cnos/20260619.md" <<'EOF'
# cnos channel — 2026-06-19

## 2026-06-19T15:00:00Z — Directive 100 substantive

---
class: substantive
---

Will fail.
EOF

set +e
TELEGRAM_BOT_TOKEN=dummy \
NOTIFY_WALK_NOTIFY_SCRIPT="$FAKE_FAIL" \
NOTIFY_WALK_CURSORS="${F4}/state/notification-cursors.yaml" \
NOTIFY_WALK_TARGETS="${F4}/state/notification-targets.yaml" \
NOTIFY_WALK_CHANNELS_DIR="${F4}/threads/activations" \
    "$WALKER" >/dev/null 2>&1
RC=$?
set -e
assert_eq "walker exits 0 despite POST failure" "$RC" "0"

CURSOR_AFTER=$(yq eval '.cursors.cnos // "null"' "${F4}/state/notification-cursors.yaml")
assert_eq "cursor stays null after failed POST" "$CURSOR_AFTER" "null"

# 5. Older-date file processed when cursor is behind (cross-day retry)
echo "[5] cross-day retry: yesterday's substantive still emitted today"
F5=$(mktemp -d)
trap "rm -rf $F5" RETURN
mk_fixture "$F5"
NOTIFY_LOG="${F5}/calls.log"
: > "$NOTIFY_LOG"
FAKE5=$(mk_fake_notify "$F5" "$NOTIFY_LOG" 0)

# Yesterday's file with unfired substantive entry; today's file empty.
# Cursor at null means we should pick up yesterday's even though "today"
# would be a different date.
cat > "${F5}/threads/activations/cnos/20260618.md" <<'EOF'
# cnos channel — 2026-06-18

## 2026-06-18T20:00:00Z — Directive 101 from yesterday

---
class: substantive
---

Yesterday's substantive event.
EOF

cat > "${F5}/threads/activations/cnos/20260620.md" <<'EOF'
# cnos channel — 2026-06-20

## 2026-06-20T05:00:00Z — Today's other substantive

---
class: substantive
---

Today's substantive event.
EOF

set +e
TELEGRAM_BOT_TOKEN=dummy \
NOTIFY_WALK_NOTIFY_SCRIPT="$FAKE5" \
NOTIFY_WALK_CURSORS="${F5}/state/notification-cursors.yaml" \
NOTIFY_WALK_TARGETS="${F5}/state/notification-targets.yaml" \
NOTIFY_WALK_CHANNELS_DIR="${F5}/threads/activations" \
    "$WALKER" >/dev/null 2>&1
RC=$?
set -e
assert_eq "exit 0" "$RC" "0"

assert_file_line_count "2 entries posted (yesterday + today)" "$NOTIFY_LOG" "2"

CURSOR_AFTER=$(yq eval '.cursors.cnos' "${F5}/state/notification-cursors.yaml")
assert_eq "cursor advanced to today's later ts" "$CURSOR_AFTER" "2026-06-20T05:00:00Z"

echo "--------------------------"
echo "Passed: $PASS  Failed: $FAIL"
[ "$FAIL" -gt 0 ] && exit 1
exit 0
