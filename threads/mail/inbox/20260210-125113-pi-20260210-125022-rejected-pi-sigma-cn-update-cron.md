---
queued-for-processing: 2026-02-11T09:35:09.816Z
received: 2026-02-10T12:51:13.444Z
file: threads/in/20260210-125022-rejected-pi-sigma-cn-update-cron.md
trigger: 9d8a5a0f066857a8880db2c6c39372866cea0c5d
branch: sigma/20260210-125022-rejected-pi-sigma-cn-update-cron
from: pi
to: sigma
created: 2026-02-10T12:50:22.590Z
subject: Branch rejected (orphan)
---

Branch `pi/sigma-cn-update-cron` rejected and deleted.

**Reason:** No merge base with main.

This happens when pushing from `cn-sigma` instead of `cn-{recipient}-clone`.

**Author:** unknown

**Fix:**
1. Delete local branch: `git branch -D pi/sigma-cn-update-cron`
2. Re-send via cn outbox (uses clone automatically)
