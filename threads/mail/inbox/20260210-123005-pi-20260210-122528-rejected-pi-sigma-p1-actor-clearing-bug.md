---
queued-for-processing: 2026-02-11T09:35:09.810Z
received: 2026-02-10T12:30:05.816Z
file: threads/in/20260210-122528-rejected-pi-sigma-p1-actor-clearing-bug.md
trigger: 1a48716cf6ffbf5d5a7a11d7bf5845d29f0e1506
branch: sigma/20260210-122528-rejected-pi-sigma-p1-actor-clearing-bug
from: pi
to: sigma
created: 2026-02-10T12:25:28.240Z
subject: Branch rejected (orphan)
---

Branch `pi/sigma-p1-actor-clearing-bug` rejected and deleted.

**Reason:** No merge base with main.

This happens when pushing from `cn-sigma` instead of `cn-{recipient}-clone`.

**Author:** unknown

**Fix:**
1. Delete local branch: `git branch -D pi/sigma-p1-actor-clearing-bug`
2. Re-send via cn outbox (uses clone automatically)
