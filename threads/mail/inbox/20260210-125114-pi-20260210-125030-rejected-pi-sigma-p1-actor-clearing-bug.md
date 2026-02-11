---
queued-for-processing: 2026-02-11T09:35:09.817Z
received: 2026-02-10T12:51:14.083Z
file: threads/in/20260210-125030-rejected-pi-sigma-p1-actor-clearing-bug.md
trigger: 0238dc7140c56490a7f4a78acdbfcd35518cd239
branch: sigma/20260210-125030-rejected-pi-sigma-p1-actor-clearing-bug
from: pi
to: sigma
created: 2026-02-10T12:50:30.220Z
subject: Branch rejected (orphan)
---

Branch `pi/sigma-p1-actor-clearing-bug` rejected and deleted.

**Reason:** No merge base with main.

This happens when pushing from `cn-sigma` instead of `cn-{recipient}-clone`.

**Author:** unknown

**Fix:**
1. Delete local branch: `git branch -D pi/sigma-p1-actor-clearing-bug`
2. Re-send via cn outbox (uses clone automatically)
