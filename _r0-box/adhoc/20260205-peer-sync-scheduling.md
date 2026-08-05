# Peer-Sync Scheduling Proposal

**Date:** 2026-02-05  
**For:** Pi (PM), usurobor (owner)  
**Re:** How to run peer-sync automatically

---

## Problem

Current HEARTBEAT.md tells the agent to check peers every 30 min. This burns AI tokens on clockwork.

> *"Tokens for thinking. Electrons for clockwork."*

peer-sync is now a compiled tool. It should run without AI.

---

## Proposed Solution

### Architecture

```
┌─────────────────┐
│  OpenClaw cron  │
│  (every 30 min) │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  peer-sync.js   │  ← electrons (no AI)
│  (Node script)  │
└────────┬────────┘
         │
    exit code?
         │
    ┌────┴────┐
    │         │
   0/1        2
    │         │
    ▼         ▼
  silent    alert
            agent
```

### Exit Codes

| Code | Meaning | Action |
|------|---------|--------|
| 0 | No inbound branches | Silent, no agent wake |
| 1 | Error (missing peers.md, etc.) | Log error, maybe alert |
| 2 | Inbound branches found | Wake agent with alert text |

### Implementation Options

**Option A: OpenClaw cron job**
```yaml
# In OpenClaw config
cron:
  - schedule: "*/30 * * * *"
    command: "node tools/peer-sync/dist/peer-sync.js ./cn-sigma"
    on_exit_2: "wake_agent"
```

**Option B: System cron + wake event**
```bash
*/30 * * * * cd /workspace && node cn-agent/tools/peer-sync/dist/peer-sync.js ./cn-sigma || [ $? -eq 2 ] && curl -X POST openclaw/wake
```

**Option C: Wrapper script**
```bash
#!/bin/bash
output=$(node peer-sync.js ./cn-sigma 2>&1)
code=$?
if [ $code -eq 2 ]; then
  echo "PEER_ALERT: $output" | openclaw-inject
fi
```

### Recommendation

**Option A** if OpenClaw supports cron with exit code handling.
**Option C** as fallback — simple, portable, works with any cron.

---

## Changes Needed

1. **peer-sync tool** — already done ✅
2. **HEARTBEAT.md** — remove manual peer-sync, add note about automated check
3. **OpenClaw config or cron** — schedule the tool
4. **Alert injection** — mechanism to wake agent with context

---

## Questions for Owner

1. Does OpenClaw cron support exit-code-conditional actions?
2. Preferred mechanism for injecting alerts into agent session?
3. Should errors (exit 1) also alert, or just log?

---

**Status:** Proposal ready for review.
