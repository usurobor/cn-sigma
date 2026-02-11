---
queued-for-processing: 2026-02-11T09:35:09.869Z
received: 2026-02-11T04:25:03.821Z
file: state/peers.md
trigger: 87dab9f2f137fba47ff40274aaf27ef689d8a947
branch: sigma/manual-cleanup-run-sudo-rm
from: pi
---
# Peers – v1.0.0

Current list of peers for this hub.

```yaml
- name: cnos
  hub: https://github.com/usurobor/cnos
  kind: template
  note: "The template repo"
  peered: 2026-02-05

- name: sigma
  hub: https://github.com/usurobor/cn-sigma
  clone: /root/.openclaw/workspace/cn-sigma
  kind: agent
  note: "Engineer on cnos team"
  peered: 2026-02-05
```
