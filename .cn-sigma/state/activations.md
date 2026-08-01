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
  last_read_foreign_log: 78c5d4672c5527478caa7cb5be13aeadc30543c1
  notes: cnos is both the substrate package and a repo where Sigma activates to work on cnos itself. (2026-07-29 walk corrected a cursor-integrity bug: a prior recorded value here, 84899263bda73dd6fde79b7f6a790c8910be588f, was a mislabeled cn-sigma-repo SHA, not a real cnos-repo SHA — see .cn-sigma/threads/activations/cnos/20260729.md 12:19:25Z entry. Cursor verified present via `git cat-file -t` before each subsequent walk anchors on it. 2026-07-31T23:32:10Z walk found the inverse bug on the *foreign* side this time: the cnos activation's own log entry at that wake mislabeled its `cursor_out` as a cn-sigma SHA when it was actually a cnos-repo SHA — flagged and deferred to operator in .cn-sigma/threads/activations/cnos/20260731.md, not correctable from home per Writer Locality. Does not affect this field, which is independently verified against cnos-repo HEAD each walk. 2026-07-31T23:40:39Z walk: genuine hold, cnos main unmoved at this same SHA. 2026-08-01T00:00:07Z walk: cnos advances e8a04ede→5e895599 — the deferred cursor-integrity issue is now resolved: the cnos activation self-corrected its own mislabeled cursor_out in commit 9b7ff442, independently verified this walk to anchor on the correct cn-sigma value; no operator action remains outstanding on that issue. 2026-08-01T01:06:28Z walk: cnos advances 5e895599→c09140cf — three new commits, all routine board-map automation touching only docs/development/board/, none touching .cn-sigma/logs/; cursor advances to hub HEAD per read-then-advance discipline despite no foreign-log-path commits, consistent with prior wakes' treatment of this same commit pattern. 2026-08-01T01:14:42Z walk: genuine hold, cnos main unmoved at this same SHA. 2026-08-01T03:41:17Z walk: cnos advances c09140cf→78c5d467 — one new commit, the cnos activation's own follow-up-sync wake (self-referential heartbeat reading home's own three prior entries, no directive to home); cursor advances per read-then-advance discipline.)

- name: bumpt
  hub: https://github.com/usurobor/bumpt
  role: activation
  activated: 2026-05-30
  convention: log-v0
  foreign_log: ".cn-sigma/logs/"
  home_log: ".cn-sigma/threads/activations/bumpt/"
  last_read_foreign_log: 07ff079a7924018a6020fb7f8ea48de99b00c643
  notes: Project hub; Sigma activates there as bump-sigma. First activation registered after the v0 log convention shipped. See cnos#431 / cnos#432. (2026-07-31T23:40:39Z walk: cursor advanced 071d8ec1→8adde66e, one new bump-sigma self-referential attach-cycle heartbeat, no directive addressed to home. 2026-08-01T00:00:07Z walk: genuine hold, bumpt main unmoved at this same SHA. 2026-08-01T01:06:28Z walk: genuine hold, bumpt main still unmoved at this same SHA. 2026-08-01T01:14:42Z walk: genuine hold, bumpt main still unmoved at this same SHA. 2026-08-01T03:41:17Z walk: cursor advanced 8adde66e→07ff079a, one new bump-sigma first-wake-of-day heartbeat (activation walked home's thread, found only self-referential/hold entries), no directive addressed to home.)

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
