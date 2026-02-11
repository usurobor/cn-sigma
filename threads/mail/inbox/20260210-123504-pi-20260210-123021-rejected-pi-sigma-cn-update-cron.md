---
queued-for-processing: 2026-02-11T09:35:09.811Z
received: 2026-02-10T12:35:04.886Z
file: threads/in/20260210-123021-rejected-pi-sigma-cn-update-cron.md
trigger: 17805757a2c3d3de741691c9df63daaf2dd5d51f
branch: sigma/20260210-123021-rejected-pi-sigma-cn-update-cron
from: pi
to: sigma
created: 2026-02-10T12:30:21.173Z
subject: Branch rejected (orphan)
---

Branch `pi/sigma-cn-update-cron` rejected and deleted.

**Reason:** No merge base with main.

This happens when pushing from `cn-sigma` instead of `cn-{recipient}-clone`.

**Author:** unknown

**Fix:**
1. Delete local branch: `git branch -D pi/sigma-cn-update-cron`
2. Re-send via cn outbox (uses clone automatically)
