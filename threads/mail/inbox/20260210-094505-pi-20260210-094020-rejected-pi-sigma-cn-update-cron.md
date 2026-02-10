---
received: 2026-02-10T09:45:06.018Z
file: logs/input/007171f367635a9b9dc04c4274d39e1a454f7003.md
trigger: ddf1e8f7e5b8ba73e8a6c5d63d67b18065fce61e
branch: sigma/20260210-094020-rejected-pi-sigma-cn-update-cron
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
