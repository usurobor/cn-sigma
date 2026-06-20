# Scripts

Operational scripts invoked by the cn-sigma wake or by operators / γ-console session.

## `notify-telegram.sh`

Sends a notification to Telegram via the Sigma bot, per the routing config at `.cn-sigma/state/notification-targets.yaml`.

### Convention

Defined at cnos#`agent/notification-protocol` (pending; D32 dispatched 2026-06-20). Activations emit `notify:` frontmatter on their foreign-log entries; the cn-sigma worker reads them and invokes this script. Operators can also call directly for ad-hoc notifications.

### Usage

```bash
notify-telegram.sh <target> <class> <summary> [details]
```

| Arg | Description |
|---|---|
| `target` | Routing target name. Must be a key under `targets:` in `notification-targets.yaml`. Currently: `cn-sigma`, `cnos`, `bumpt`. |
| `class` | Event class. Drives the emoji prefix and (eventually) format conventions. Allowed: `release`, `blocker`, `milestone`, `ci-failure`, `daily-pulse`, `doctrine-evolution`, `cross-activation-rollup`, `escalation`. |
| `summary` | One-line summary text (will appear in the bold header of the message). |
| `details` | Optional multi-line additional context (appears below the summary in the message body). |

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
| `2` | Routing config missing OR target not found in config |
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

- `chat_id` from `supergroup.chat_id` (single supergroup; shared across all topics)
- `topic_thread_id` from `targets.<target>.topic_thread_id`
  - Integer value → posts to that topic (passes `message_thread_id` in API call)
  - `null` value → posts to General (omits `message_thread_id`)

### Format

- Header: `<emoji> *[<class>]* <summary>` (Markdown bold via Telegram `parse_mode: Markdown`)
- Body: `details` text if provided, separated by blank line
- Emoji per class: 🚀 release, 🔴 blocker, ✨ milestone, ❌ ci-failure, 📊 daily-pulse, 📜 doctrine-evolution, 🌐 cross-activation-rollup, 🚨 escalation

### Dependencies

- `bash` (POSIX-compatible)
- `yq` (v4+; standard on ubuntu-latest)
- `jq`
- `curl`

All available by default on GitHub Actions `ubuntu-latest` runners.

### Idempotency note

This script is a single-message poster — it does NOT manage cursors. The cursor mechanism (`.cn-sigma/state/notification-cursors.yaml`; per-target last-notified foreign-log SHA) is managed by the wake-yaml caller that walks foreign logs and invokes this script per notify entry. Calling this script twice with the same args posts twice — duplication suppression is the caller's responsibility.

### Status

- v0: ad-hoc invocation supported (this PR).
- v0+: wake yaml integration to walk foreign logs and auto-invoke (follow-up PR after cnos#`agent/notification-protocol` doctrine converges).
- v1: foreign-log walker bundled into the script; per-target cursor advance.
