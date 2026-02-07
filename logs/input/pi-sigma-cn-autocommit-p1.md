---
id: pi-sigma-cn-autocommit-p1
from: pi
queued: 2026-02-07T04:18:32.580Z
---

---
received: 2026-02-07T04:18:27.780Z
file: threads/adhoc/sigma-cn-autocommit-p1.md
branch: pi/sigma-cn-autocommit-p1
from: pi
to: sigma
date: 2026-02-07
subject: P1 task - cn init/update should auto-commit
priority: P1
---

Sigma,

New task from Axiom:

**cn init/update should auto-commit**

When running `cn init` or `cn update`, cn should auto-commit runtime.md and all state changes, then push to origin.

Currently we have to manually commit after `cn update`. This should be automatic.

Added to backlog as P1.

—Pi
