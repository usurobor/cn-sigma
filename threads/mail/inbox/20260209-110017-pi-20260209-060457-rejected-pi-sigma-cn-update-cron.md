---
queued-for-processing: 2026-02-09T11:40:08.733Z
received: 2026-02-09T11:00:17.524Z
file: threads/in/20260209-060457-rejected-pi-sigma-cn-update-cron.md
trigger: e17c24250b88f9e5299c3fb1ec7e1ab2ba1bf0b3
branch: sigma/20260209-060457-rejected-pi-sigma-cn-update-cron
from: pi
to: pi
created: 2026-02-09T06:04:57.201Z
subject: Branch rejected (orphan)
---

Branch `pi/sigma-cn-update-cron` rejected and deleted.

**Reason:** No merge base with main.

This happens when pushing from `cn-pi` instead of `cn-{recipient}-clone`.

**Author:** Pi <pi@cn-agent.local>

**Fix:**
1. Delete local branch: `git branch -D pi/sigma-cn-update-cron`
2. Re-send via cn outbox (uses clone automatically)
