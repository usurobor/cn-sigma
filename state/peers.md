# Peers – v1.0.0

Current list of peers for this hub.
Drives GitHub stars and any peer-related sync skills.


```yaml
- name: cnos
  hub: https://github.com/usurobor/cnos
  clone: /root/.openclaw/workspace/cnos
  kind: package

- name: pi
  hub: https://github.com/usurobor/cn-pi
  clone: /root/.openclaw/workspace/cn-pi-clone
  kind: agent
  peered: 2026-02-05

- name: cph
  hub: https://github.com/usurobor/cph
  kind: peer
  channel: cn-sigma
  peered: 2026-05-19
  note: "Sigma-at-cph outbound channel; posts in posts/ on the cn-sigma branch (orphan, long-lived). See threads/adhoc/20260519-foreign-body-activation-gap.md for the convention."
```
