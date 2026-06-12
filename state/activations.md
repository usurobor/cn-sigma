# Activations – v1.2.0

Places where Sigma activates (same identity, multiple bodies).
This is **not** a peer list — there are currently no external peer agents.
Each entry is a foreign repo where Sigma takes up residence and works.

Drives GitHub stars and the activation-log convention (see `spec/OPERATOR.md § Activation logs`; canonical spec at `cnos:docs/gamma/conventions/AGENT-ACTIVATION-LOG-v0.md`).


```yaml
- name: cnos
  hub: https://github.com/usurobor/cnos
  role: package + activation
  foreign_log: ".cn-sigma/logs/"
  home_log: "threads/activations/cnos/"
  last_read_foreign_log: 542d58706486e7503068a8da104e80efd5b9d35e
  notes: cnos is both the substrate package and a repo where Sigma activates to work on cnos itself.

- name: bumpt
  hub: https://github.com/usurobor/bumpt
  role: activation
  activated: 2026-05-30
  convention: log-v0
  foreign_log: ".cn-sigma/logs/"
  home_log: "threads/activations/bumpt/"
  last_read_foreign_log: d60c44c3b2f9bdc1f6abe65e747ed1f257e0e128
  notes: Project hub; Sigma activates there as bump-sigma. First activation registered after the v0 log convention shipped. See cnos#431 / cnos#432.
```

## Removed: cph (2026-06-01)

cph was registered as a Sigma activation on 2026-05-19 (the inaugural foreign-body-activation-gap post used the orphan-branch `posts/` convention). Per operator direction 2026-06-01, cph is reassigned to **cn-rho's domain** when cn-rho registers as a peer. Until then, cph is not in any agent's activations list.

Historical references remain at:
- `threads/adhoc/20260519-foreign-body-activation-gap.md` — the inaugural post + ingestion record
- `threads/adhoc/20260530-sigma-activation-log-v0.md` — the convention writeup, which references cph in the convergence narrative (preserved as-authored; the reassignment is noted in the Update section)
