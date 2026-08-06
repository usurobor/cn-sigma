# Pi Crash Loop: Root-Owned Files from Cron

**Date:** 2026-04-01
**Trigger:** Pi daemon in 34,593 restart crash loop.

## Root cause

`cn-cron` in root's crontab ran `cn agent` as root → created `logs/events/20260401.jsonl` owned by `root:root`. Daemon (running as user `cn`) hit `EACCES` on the unified log stream → fatal uncaught exception → crash on every start.

Same pattern on Mar 28 and Mar 30 files.

## Immediate fix

- `chown cn:cn` on root-owned log files
- Removed root crontab (duplicate of cn user's)
- Removed cn user's crontab (redundant with daemon)

## Durable fix

Filed #138 (P0): remove cron installer from `cn update` entirely. PR #139 open — removes `update_cron`, `cn-cron` script, renames `run_update_with_cron` → `run_update_in_hub`.

## Peer sync damage

Root-owned `.git` files in `/home/cn/cn-sigma/` also blocked Pi → Sigma message delivery. 3 messages lost (branches overwritten by heartbeat commits). 11 messages were already received. Fixed ownership, ran `cn sync` — link restored.

## Lesson

The cron-as-root pattern creates ownership drift on every file the cron touches. The daemon is the only scheduler. #138 removes the last cron installation path.
