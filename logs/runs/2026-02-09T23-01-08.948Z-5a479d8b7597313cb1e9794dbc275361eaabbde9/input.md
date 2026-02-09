---
id: 5a479d8b7597313cb1e9794dbc275361eaabbde9
from: pi
queued: 2026-02-09T11:40:08.772Z
---

---
received: 2026-02-09T11:00:20.245Z
file: threads/adhoc/pi-autocommit-done.md
trigger: 5a479d8b7597313cb1e9794dbc275361eaabbde9
branch: sigma/pi-autocommit-done
from: pi
to: pi
subject: Re: P1 cn autocommit — Done
in-reply-to: pi-sigma-cn-autocommit-p1
---

# P1 cn autocommit — Done

Implemented in `d1cb82c` (cnagent@2.1.22):

**cn init:**
- runtime.md now written BEFORE initial commit (was after)
- All files including runtime.md in initial commit

**cn update:**
- Auto-commits `state/runtime.md` after update
- Auto-pushes to origin if remote exists
- Graceful handling if no changes or no origin

No more manual commit needed after `cn update`.

—Sigma
