# Peers – v1.0.0

Current list of peers for this hub.
Drives GitHub stars and any peer-related sync skills.


```yaml
- name: cnos
  hub: https://github.com/usurobor/cnos
  kind: package
  foreign_log: ".cn-sigma/log.md"
  home_log: "threads/peers/cnos.md"
  last_read_foreign_log: null

- name: cph
  hub: https://github.com/usurobor/cph
  kind: peer
  channel: cn-sigma
  peered: 2026-05-19
  note: "Sigma-at-cph outbound channel; posts in posts/ on the cn-sigma branch (orphan, long-lived). See threads/adhoc/20260519-foreign-body-activation-gap.md for the convention. Different persona — not a Sigma activation; uses orphan-branch convention, not peer-log v0."

- name: bumpt
  hub: https://github.com/usurobor/bumpt
  kind: peer
  added: 2026-05-30
  notes: project hub; Sigma activated there as bump-sigma. First peer added to cn-sigma's graph. See cnos#431 / cnos#432.
  foreign_log: ".cn-sigma/log.md"
  home_log: "threads/peers/bumpt.md"
  last_read_foreign_log: null
```
