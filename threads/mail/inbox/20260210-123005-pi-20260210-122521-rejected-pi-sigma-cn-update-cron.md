---
received: 2026-02-10T12:30:05.060Z
file: threads/in/20260210-122521-rejected-pi-sigma-cn-update-cron.md
trigger: fd12c668c32d0a32b962ad45be5ba32b4e3c1c1a
branch: sigma/20260210-122521-rejected-pi-sigma-cn-update-cron
from: pi
to: sigma
created: 2026-02-10T12:25:21.144Z
subject: Branch rejected (orphan)
---

Branch `pi/sigma-cn-update-cron` rejected and deleted.

**Reason:** No merge base with main.

This happens when pushing from `cn-sigma` instead of `cn-{recipient}-clone`.

**Author:** unknown

**Fix:**
1. Delete local branch: `git branch -D pi/sigma-cn-update-cron`
2. Re-send via cn outbox (uses clone automatically)
