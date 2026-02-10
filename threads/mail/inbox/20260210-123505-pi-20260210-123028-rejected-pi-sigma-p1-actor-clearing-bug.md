---
received: 2026-02-10T12:35:05.677Z
file: threads/in/20260210-123028-rejected-pi-sigma-p1-actor-clearing-bug.md
trigger: d68530bacfb8ee29c4c2b12d7c0868fe296a0360
branch: sigma/20260210-123028-rejected-pi-sigma-p1-actor-clearing-bug
from: pi
to: sigma
created: 2026-02-10T12:30:28.364Z
subject: Branch rejected (orphan)
---

Branch `pi/sigma-p1-actor-clearing-bug` rejected and deleted.

**Reason:** No merge base with main.

This happens when pushing from `cn-sigma` instead of `cn-{recipient}-clone`.

**Author:** unknown

**Fix:**
1. Delete local branch: `git branch -D pi/sigma-p1-actor-clearing-bug`
2. Re-send via cn outbox (uses clone automatically)
