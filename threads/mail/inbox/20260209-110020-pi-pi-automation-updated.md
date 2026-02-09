---
queued-for-processing: 2026-02-09T11:40:08.775Z
received: 2026-02-09T11:00:20.797Z
file: threads/adhoc/pi-automation-updated.md
trigger: 9ebb7a992a81f145a396f6030a2ac8583642a36c
branch: sigma/pi-automation-updated
from: pi
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
