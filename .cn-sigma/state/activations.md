# Activations – v1.3.0

Places where Sigma activates (same identity, multiple bodies).
This is **not** a peer list — there are currently no external peer agents.
Each entry is a foreign repo where Sigma takes up residence and works.

Drives GitHub stars and the activation-log convention (see `.cn-sigma/spec/OPERATOR.md § Activation logs`; canonical spec at `cnos:docs/gamma/conventions/AGENT-ACTIVATION-LOG-v0.md`).

Path note: `foreign_log` is the path at the foreign body's repo (relative to that repo's root). `home_log` is the path at cn-sigma's repo (root-relative, including the `.cn-sigma/` namespace prefix per cnos#448 containerization). Both fields are root-relative at their respective repos.

```yaml
- name: cnos
  hub: https://github.com/usurobor/cnos
  role: package + activation
  foreign_log: ".cn-sigma/logs/"
  home_log: ".cn-sigma/threads/activations/cnos/"
  last_read_foreign_log: 04125238da1c4144a9bd54c0335b2f8930f666c4
  notes: cnos is both the substrate package and a repo where Sigma activates to work on cnos itself.

- name: bumpt
  hub: https://github.com/usurobor/bumpt
  role: activation
  activated: 2026-05-30
  convention: log-v0
  foreign_log: ".cn-sigma/logs/"
  home_log: ".cn-sigma/threads/activations/bumpt/"
  last_read_foreign_log: 87aae715b8779bbaf1ad61da02e650bf81601144
  notes: Project hub; Sigma activates there as bump-sigma. First activation registered after the v0 log convention shipped. See cnos#431 / cnos#432.

- name: tsc
  hub: https://github.com/usurobor/tsc
  role: activation
  activated: 2026-07-06
  convention: log-v0
  foreign_log: ".cn-sigma/logs/"
  home_log: ".cn-sigma/threads/activations/tsc/"
  last_read_foreign_log: 26aab5023f03dc7d0abf82e5fdba20134fc6adad
  notes: TSC (triadic self-coherence) tenant repo, vendored cnos 3.82.0. Sigma activates as δ to run the CDS FSM + the CM0-compiler wave (tsc#77). Registered 2026-07-06 on operator directive.
```

## Removed: cph (2026-06-01)

cph was registered as a Sigma activation on 2026-05-19 (the inaugural foreign-body-activation-gap post used the orphan-branch `posts/` convention). Per operator direction 2026-06-01, cph is reassigned to **cn-rho's domain** when cn-rho registers as a peer. Until then, cph is not in any agent's activations list.

Historical references remain at:
- `.cn-sigma/threads/adhoc/20260519-foreign-body-activation-gap.md` — the inaugural post + ingestion record
- `.cn-sigma/threads/adhoc/20260530-sigma-activation-log-v0.md` — the convention writeup, which references cph in the convergence narrative (preserved as-authored; the reassignment is noted in the Update section)
