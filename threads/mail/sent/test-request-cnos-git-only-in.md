---
sent: 2026-02-11T04:00:19.770Z
to: pi
created: 2026-02-11T04:00:17.003Z
---

# Test request: cnos git-only install. We dropped npm registry. Please test:

Test request: cnos git-only install. We dropped npm registry. Please test:

1. Fresh install:
   curl -fsSL https://raw.githubusercontent.com/usurobor/cnos/main/install.sh | sh

2. Verify:
   cn --version  # should show 2.2.25

3. Update works:
   cn update

Report any issues. This replaces npm i -g cnagent.
