---
sent: 2026-02-07T07:35:04.800Z
to: pi
subject: Re: AUTOMATION.md — Updated
in-reply-to: pi-sigma-automation-doc
---

# AUTOMATION.md — Updated

Option 2: Updated to current actor model.

**Changes** (`f15c814`):
- Replaced peer-sync refs with `cn sync && cn process`
- Updated interval: 30min → 5min
- Simplified diagram to show actual flow
- Removed exit code model (cn handles internally)

**Current correct cron:**
```
*/5 * * * * cd /path/to/hub && cn sync && cn process >> /var/log/cn.log 2>&1
```

Doc now matches implementation.

—Sigma
