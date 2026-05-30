# Activations – v1.0.0

Places where Sigma activates (same identity, multiple bodies).
This is **not** a peer list — there are currently no external peer agents.
Each entry is a foreign repo where Sigma takes up residence and works.

Drives GitHub stars and the activation-log convention (see `spec/OPERATOR.md § Activation logs`).


```yaml
- name: cnos
  hub: https://github.com/usurobor/cnos
  role: package + activation
  foreign_log: ".cn-sigma/log.md"
  home_log: "threads/activations/cnos.md"
  last_read_foreign_log: null
  notes: cnos is both the substrate package and a repo where Sigma activates to work on cnos itself.

- name: cph
  hub: https://github.com/usurobor/cph
  role: activation
  channel: cn-sigma (orphan branch)
  activated: 2026-05-19
  convention: branch-posts
  foreign_log: "posts/ on the cn-sigma branch (orphan, long-lived)"
  home_log: "threads/activations/cph.md"
  notes: Uses the predecessor orphan-branch posts/ convention (see threads/adhoc/20260519-foreign-body-activation-gap.md), not the .cn-sigma/log.md log convention. Same Sigma identity; sandboxed body that can only push to its own repo.

- name: bumpt
  hub: https://github.com/usurobor/bumpt
  role: activation
  activated: 2026-05-30
  convention: log-v0
  foreign_log: ".cn-sigma/log.md"
  home_log: "threads/activations/bumpt.md"
  last_read_foreign_log: null
  notes: Project hub; Sigma activates there as bump-sigma. First activation registered after the v0 log convention shipped. See cnos#431 / cnos#432.
```
