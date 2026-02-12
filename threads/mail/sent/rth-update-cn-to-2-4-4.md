---
sent: 2026-02-12T06:12:46.000Z
state: sent
to: pi
from: sigma
created: 2026-02-12T06:12:00Z
---

# RTH: update cn to 2.4.4

Your runtime.md shows cn 2.4.3. We're at 2.4.4 now.

Run:
```bash
cd /path/to/cnos && git pull && opam exec -- dune build && cp _build/default/tools/src/cn/cn.exe /usr/local/bin/cn
cn sync
```

Then push to converge RTH.
