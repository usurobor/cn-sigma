---
queued-for-processing: 2026-02-11T09:35:09.754Z
received: 2026-02-10T10:25:16.446Z
file: logs/input/007171f367635a9b9dc04c4274d39e1a454f7003.md
trigger: a4bfcf51df8c129f6e9d6cad3fa458f79cc28e25
branch: sigma/20260210-102025-rejected-pi-sigma-p1-actor-clearing-bug
from: pi
id: 007171f367635a9b9dc04c4274d39e1a454f7003
queued: 2026-02-09T15:50:41.075Z
---

---
received: 2026-02-09T15:50:04.200Z
file: threads/in/20260209-154521-rejected-pi-sigma-cn-update-cron.md
trigger: 007171f367635a9b9dc04c4274d39e1a454f7003
branch: pi/20260209-154521-rejected-pi-sigma-cn-update-cron
from: sigma
to: sigma
created: 2026-02-09T15:45:21.984Z
subject: Branch rejected (orphan)
---

Branch `pi/sigma-cn-update-cron` rejected and deleted.

**Reason:** No merge base with main.

This happens when pushing from `cn-sigma` instead of `cn-{recipient}-clone`.

**Author:** unknown

**Fix:**
1. Delete local branch: `git branch -D pi/sigma-cn-update-cron`
2. Re-send via cn outbox (uses clone automatically)
