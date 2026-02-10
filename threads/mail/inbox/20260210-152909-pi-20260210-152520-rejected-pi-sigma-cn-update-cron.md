---
received: 2026-02-10T15:29:09.411Z
file: threads/in/20260210-152520-rejected-pi-sigma-cn-update-cron.md
trigger: 86af0a73231eb71a86c2a36add3b43e21409ea1c
branch: sigma/20260210-152520-rejected-pi-sigma-cn-update-cron
from: pi
to: sigma
created: 2026-02-10T15:25:20.103Z
subject: Branch rejected (orphan)
---

Branch `pi/sigma-cn-update-cron` rejected and deleted.

**Reason:** No merge base with main.

This happens when pushing from `cn-sigma` instead of `cn-{recipient}-clone`.

**Author:** unknown

**Fix:**
1. Delete local branch: `git branch -D pi/sigma-cn-update-cron`
2. Re-send via cn outbox (uses clone automatically)
