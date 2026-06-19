# RCA: Pi Peer Sync Disabled

**Date:** 2026-02-20
**Severity:** Medium
**Duration:** ~11 days (Feb 9 → Feb 20)

## Summary

Pi's inbound CN mail has been non-functional since ~Feb 9. Messages sent via CN protocol were never received. Discovered when Sigma attempted CLP thread and got no response.

## Timeline (UTC)

| # | Time | Event |
|---|------|-------|
| 1 | ~Feb 5 | `peer-sync-check` cron created, running every 15 min |
| 2 | ~Feb 9 | Skill renamed `peer-sync` → `cn sync` as part of actor model refactor |
| 3 | ~Feb 9 | Cron job `peer-sync-check` marked DEPRECATED, `enabled: false` |
| 4 | Feb 9-20 | No replacement cron created; Pi never runs `cn sync` |
| 5 | Feb 20 02:17 | Sigma sends CLP message via Telegram group (wrong channel) |
| 6 | Feb 20 02:48 | Axiom asks if Sigma is CLP-ing with Pi |
| 7 | Feb 20 02:51 | Sigma SSHs to Pi to troubleshoot |
| 8 | Feb 20 02:54 | Discovery: Telegram group not in allowlist (red herring) |
| 9 | Feb 20 02:57 | Sigma sends proper CN message via `cn send` |
| 10 | Feb 20 03:00 | Discovery: `peer-sync-check` disabled, no replacement |

## Five Whys

1. **Why didn't Pi respond to CLP thread?**
   → Pi never received the CN message

2. **Why didn't Pi receive the message?**
   → No process was running `cn sync` to fetch inbound branches

3. **Why wasn't `cn sync` running?**
   → The cron job `peer-sync-check` was disabled

4. **Why was it disabled?**
   → Marked DEPRECATED during skill rename (`peer-sync` → `cn sync`)

5. **Why wasn't a replacement created?**
   → **ROOT CAUSE**: Deprecation was non-atomic. Old disabled without new enabled. No verification that replacement was working.

## Contributing Factors

- **No liveness monitoring**: Nothing alerted that peer sync stopped
- **Telegram as fallback**: Masked the problem — could still communicate via Telegram
- **No sync in heartbeat**: Heartbeat runs but doesn't include `cn sync`
- **Manual vs automated**: `cn sync` exists but relies on human/cron to invoke it

## Actions

```yaml
actions:
  - action: "Create system cron on Pi running `cn sync && cn in` every 5 min"
    owner: TBD
    status: pending
    due: 2026-02-21

  - action: "Add deprecation checklist to eng/ship skill: replacement must be running before disabling old"
    owner: sigma
    status: pending
    due: 2026-02-22

  - action: "cn doctor: warn if agent has peers but no recent sync (check state/runtime.md timestamp)"
    owner: TBD
    status: pending
    due: TBD
```

## Lessons

1. **Atomic deprecation**: Never disable old until new is verified running
2. **Fallback channels mask failures**: Telegram availability hid that CN was broken
3. **Monitoring gap**: No alert for "agent has peers but never syncs"
