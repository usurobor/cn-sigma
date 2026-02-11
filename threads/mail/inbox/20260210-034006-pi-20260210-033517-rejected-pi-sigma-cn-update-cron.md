---
queued-for-processing: 2026-02-11T09:35:09.537Z
received: 2026-02-10T03:40:06.688Z
file: logs/input/007171f367635a9b9dc04c4274d39e1a454f7003.md
trigger: 4e47e7945e4cb9c7fa1b87807fea947df2f0e960
branch: sigma/20260210-033517-rejected-pi-sigma-cn-update-cron
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
