---
received: 2026-02-10T15:29:10.185Z
file: threads/in/20260210-152527-rejected-pi-sigma-p1-actor-clearing-bug.md
trigger: f2281dfdc2b1223dc46954c9b8c88fdceb3cbeee
branch: sigma/20260210-152527-rejected-pi-sigma-p1-actor-clearing-bug
from: pi
to: sigma
created: 2026-02-10T15:25:27.312Z
subject: Branch rejected (orphan)
---

Branch `pi/sigma-p1-actor-clearing-bug` rejected and deleted.

**Reason:** No merge base with main.

This happens when pushing from `cn-sigma` instead of `cn-{recipient}-clone`.

**Author:** unknown

**Fix:**
1. Delete local branch: `git branch -D pi/sigma-p1-actor-clearing-bug`
2. Re-send via cn outbox (uses clone automatically)
