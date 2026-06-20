# Scripts

Operational scripts invoked by the cn-sigma wake or by operators / γ-console session.

## `notify-telegram.sh`

Sends a notification to Telegram via the Sigma bot, per the routing config at `.cn-sigma/state/notification-targets.yaml`.

### Convention

cn-sigma is the sole publisher of operator-facing notifications. Foreign activations (cnos, bumpt, future) emit structured foreign-log entries; cn-sigma's wake walks those logs, detects notify-worthy events, and invokes this script. Operators can also call directly for ad-hoc notifications.

### Usage

```bash
notify-telegram.sh TARGET CLASS SUMMARY [DETAILS]
```

| Arg | Description |
|---|---|
| `TARGET` | Routing target name. Must be a key under `targets:` in `notification-targets.yaml`. Currently: `cn-sigma`, `cnos`, `bumpt`. |
| `CLASS` | Event class. Must be listed under `targets.<TARGET>.classes` in the routing config (validated). Examples: `release`, `blocker`, `milestone`, `ci-failure` (per-activation); `daily-pulse`, `doctrine-evolution`, `cross-activation-rollup`, `escalation` (cn-sigma General). |
| `SUMMARY` | One-line summary text (appears in the message header). |
| `DETAILS` | Optional multi-line additional context (appears below the summary). |

### Environment

| Variable | Required | Description |
|---|---|---|
| `TELEGRAM_BOT_TOKEN` | for actual posting | Bot API token. If unset, the script exits 0 with a no-op message (private deployments without Telegram don't fail wakes). |
| `ROUTING_FILE` | no | Optional override path to `notification-targets.yaml`. Defaults to `<script-dir>/../state/notification-targets.yaml`. |

### Exit codes

| Code | Meaning |
|---|---|
| `0` | Success, OR no-op (token unset) |
| `1` | Argument error |
| `2` | Routing config missing, target not found, OR class not allowed for target |
| `3` | Telegram API error (response `ok: false`) |

### Examples

```bash
# Daily pulse to General (cn-sigma)
./notify-telegram.sh cn-sigma daily-pulse \
    "2026-06-19 pulse: PR #10 merged; D29/D30/D31 dispatched" \
    "Full report: https://github.com/usurobor/cn-sigma/blob/main/.cn-sigma/threads/pulse/20260619.md"

# Blocker to Cnos topic
./notify-telegram.sh cnos blocker \
    "D24/AI1 orphaned (~36h)" \
    "Wake yaml change on dead branch; Edit permission gap.
Operator options:
(a) manual wake.yml apply
(b) grant Edit permission to cnos session"

# Release to Cnos topic
./notify-telegram.sh cnos release \
    "v3.83.0 cut; cohere wave landed" \
    "https://github.com/usurobor/cnos/releases/tag/v3.83.0"
```

### Routing resolution

The script reads `notification-targets.yaml` and resolves:

- `chat_id` from `supergroup.chat_id` (single supergroup; shared across all topics).
- `topic_thread_id` from `targets.<TARGET>.topic_thread_id`. All targets currently have an explicit integer (General = 1, Cnos = 2, Bumpt = 7); the script requires a non-null value and passes it as `message_thread_id` to Telegram's `sendMessage` API. (Telegram supergroups with forum topics enabled treat the default thread as topic 1; we pass it explicitly for consistency.)
- `classes` from `targets.<TARGET>.classes` (list). The requested class must be a member; otherwise exit 2.

### Format

- Header: `<emoji> [<class>] <summary>` (plain text; no Markdown `parse_mode`)
- Body: `details` text if provided, separated by blank line
- Emoji per class:
  - 🚀 release
  - 🔴 blocker
  - ✨ milestone
  - ❌ ci-failure
  - 📊 daily-pulse
  - 📜 doctrine-evolution
  - 🌐 cross-activation-rollup
  - 🚨 escalation
  - ℹ️ (fallback for unknown classes — though class validation should prevent this)

Plain text was chosen deliberately for v0: caller-supplied summary/details routinely contain underscores, brackets, links, and hashes that break Telegram's Markdown parsing. HTML with explicit escaping is a possible v1 upgrade for richer formatting.

### Dependencies

- `bash` (POSIX-compatible)
- `yq` (v4+; standard on ubuntu-latest)
- `jq`
- `curl`

All available by default on GitHub Actions `ubuntu-latest` runners.

### Idempotency note

This script is a single-message poster — it does NOT manage cursors. The cursor mechanism (`.cn-sigma/state/notification-cursors.yaml`; per-target last-notified foreign-log SHA) is managed by the wake-yaml caller that walks foreign logs and invokes this script per notify entry. Calling this script twice with the same args posts twice — duplication suppression is the caller's responsibility.

### Smoke test

`test-notify-telegram.sh` (same directory) runs three quick checks without hitting the Telegram API:

```bash
./test-notify-telegram.sh
```

Asserts: syntax check passes; no-token invocation exits 0; unknown target exits 2. CI runs this on every PR touching the scripts directory (see `.github/workflows/notify-script-test.yml`).

### Status

- **v0**: ad-hoc invocation supported (this PR). Class validation, plain-text format, explicit topic_id.
- **v0+**: wake yaml integration to walk foreign logs and auto-invoke (follow-up PR after this lands).
- **v1**: foreign-log walker bundled; per-target cursor advance; HTML formatting with escape; privacy gate (P0 activations MUST NOT trigger publish).
