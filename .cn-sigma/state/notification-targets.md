# Notification targets — doctrine

**Schema:** `cnos.notification-targets.v0`
**Companion config:** `.cn-sigma/state/notification-targets.yaml`
**Updated:** 2026-06-20 ET

Routing config is a pure YAML file. This document is the doctrine: who publishes, what gets routed where, which classes mean what, and how the publisher operates. The YAML is the data; the markdown is the why.

## Architecture

- **Publisher:** the cn-sigma wake worker (wake-fired α at home, mechanical). NOT γ-console session.
- **Bot:** single Sigma bot. Token at cn-sigma as repo secret `TELEGRAM_BOT_TOKEN`. No other secrets needed; routing IDs are config, not credentials.
- **Supergroup:** one shared chat_id across all topics (`supergroup.chat_id` in the YAML).
- **Topic routing:** each target has an explicit `topic_thread_id` (integer). All topics — including General (cn-sigma's voice) — are passed explicitly as `message_thread_id` in the Telegram `sendMessage` call.

Activation bodies (cnos, bumpt) emit structured events to their own foreign log only; they hold NO Telegram credentials. cn-sigma worker reads foreign logs, decides notify class, posts to Telegram.

## Targets

See the YAML. Three targets configured for v0:

| Target | Topic | Routes |
|---|---:|---|
| `cn-sigma` | 1 (General) | cn-sigma's own voice — pulse, doctrine, cross-cutting, escalation |
| `cnos` | 2 | cnos activation events |
| `bumpt` | 7 | bumpt activation events (legacy direct-post setup still live during migration) |

## Class semantics

| Class | Routes to | Format | Meaning |
|---|---|---|---|
| `daily-pulse` | General | green-short | Scheduled daily rollup from cn-sigma worker; cross-activation summary |
| `doctrine-evolution` | General | green-short | Convention/protocol updates, version bumps, wave landings |
| `cross-activation-rollup` | General | mixed | Blockers or events touching multiple activations |
| `escalation` | General | red-detailed | Urgent operator-attention. Future: dedicated escalation topic |
| `release` | per-activation | green-short | Version tag pushed at activation |
| `blocker` | per-activation | red-detailed | Wake/workflow detecting `outcome: failed` or `outcome: degraded` |
| `milestone` | per-activation | green-short | Non-release event (e.g., wave landed, hub LIVE) |
| `ci-failure` | per-activation | red-detailed | Failed workflow run at activation |

Each target's allowed classes are in the YAML (`targets.<TARGET>.classes`). The publisher script validates class membership; misrouting (e.g., `daily-pulse` → Cnos topic) exits with code 2.

## Mechanical flow (publisher)

```
cn-sigma wake fires (cron-driven)
  → walks each activation's foreign log from notification_cursor → HEAD
  → for each notify-worthy entry since last cursor:
      lookup target
      resolve chat_id + topic_thread_id from notification-targets.yaml
      format message per class
      POST to Telegram sendMessage (explicit message_thread_id)
  → on success: advance notification_cursor per target
  → on failure: cursor stays; next wake retries (idempotent)
```

v0 (this PR): single-message `notify-telegram.sh` script. Wake-walker integration is the follow-up PR (D34).

## Secrets at cn-sigma

| Secret name | Purpose |
|---|---|
| `TELEGRAM_BOT_TOKEN` | Sigma bot API token (only secret needed) |

Chat and topic IDs are routing config (in the YAML), not credentials. No secrets for them.

## Format conventions

Per bumpt's pattern (`bumpt:docs/CI-TELEGRAM.md` reference):

- **Green-short**: emoji + class tag + summary + (optional) details + link
- **Red-detailed**: emoji + class tag + summary + failed step / error excerpt + operator-action line + link
- **Plain text only** for v0: `parse_mode` omitted because caller-supplied summary/details routinely contain underscores, brackets, links, and hashes that break Telegram's Markdown parsing. HTML with explicit escaping is a possible v1 upgrade.
- **No-op without secrets**: if `TELEGRAM_BOT_TOKEN` absent, the notify step exits 0 silently. Private deployments / forks without Telegram don't fail wakes.
- **Idempotency**: per-target cursor in `.cn-sigma/state/notification-cursors.yaml`; cursor advances only on successful POST. Cursor management is the wake-walker's responsibility, NOT the single-message script.
- **Length guard**: Telegram `sendMessage` text caps at 4096 chars. The script truncates to a safe margin (`4000` chars) and appends `[truncated]` so long blocker reports / CI excerpts don't reject the entire notification.

## Update protocol

When a target's `status` changes from `configured-target` → `live`, update the YAML in the same commit that wires the notification.

When a new target is added, append a new top-level key under `targets:` in the YAML.

When General-vs-topic routing changes for a target, update its `topic_thread_id` field in the YAML; workers re-read the file every wake.

## Legacy bumpt direct-post

Bumpt's existing direct-post setup (`bumpt:experiment/.ci/telegram-notify.sh`) remains live during migration to the home-routed flow. After 7 consecutive days of cn-sigma-routed notification working at parity for bumpt events, the direct-post can be deprecated. Recorded in the YAML under `targets.bumpt.legacy` for reference.
