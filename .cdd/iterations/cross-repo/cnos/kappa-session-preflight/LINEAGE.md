# Cross-Repo Lineage: cn-sigma → cnos (kappa-session-preflight, Sub 1 of foundation-completion-wave)

## Source

- **Repo:** `usurobor/cn-sigma`
- **Branch:** `main`
- **Path:** `.cdd/iterations/cross-repo/cnos/kappa-session-preflight/`
- **Filing kind:** design-and-build cell (sub of foundation-completion-wave master).
- **Sub position:** Sub 1 of foundation-completion-wave.

## Upstream — what drives this proposal

Named 4× at cn-sigma as MCA before this filing:

1. `cn-sigma:.cn-sigma/threads/reflections/daily/20260618.md` — first naming ("at end of EACH operator-exchange session, check r1"). Failed because it depended on operator exchange happening.
2. `cn-sigma:.cn-sigma/threads/reflections/daily/20260630.md` — revised MCA ("at session resume, execute typed checklist before response"). Named as mechanism, not shipped.
3. `cn-sigma:.cn-sigma/threads/adhoc/20260703-discipline-failures-become-typed-gates.md` — meta-doctrine: exhortation fails, gates work. Named preflight as candidate gate.
4. `cn-sigma:.cn-sigma/threads/reflections/daily/20260703.md` amendment — audit revealed catch-up sweep itself instantiated the same failure. MCA re-affirmed as script deliverable.

Each naming was followed by the same failure recurring within a week. The pattern is doctrine-without-mechanism per `20260703-discipline-failures-become-typed-gates.md` §3. This proposal ships the mechanism.

## Target

- **Repo:** `usurobor/cnos`
- **Package:** `cnos.core` (agent-admin surface owner per cnos#467 architecture verdict).
- **Skill path:** `src/packages/cnos.core/skills/agent/kappa/` (per cnos#501).
- **Suggested labels:** `P1`, `area/agent`, `area/cdd`, `kind/tooling`, `protocol:cds`.
- **Disposition:** pending.

## Bilateral trace

When cnos accepts:
- cnos-side mirror expected at `cnos:.cdd/iterations/cross-repo/cn-sigma/kappa-session-preflight/`.
- STATUS advances via ledger events.
- Closure records the merge commit + effective date.

## Sub relationship to master

Parent master: `foundation-completion-wave`.
Sub position: 1 of 3.
Filed in parallel with master + Sub 2 + Sub 3 per operator directive (§1 default is sequential; operator override cited).

Independence rationale: this sub's implementation depends only on:
- κ role dispatched (cnos#501) — allows the SKILL.md doc surface to exist.
- Existing session-start hook infrastructure (γ selects from options).

Does NOT depend on:
- cnos#444 cohere landing (Sub 2 does; Sub 1 does not).
- FSM Phase 2 landing (Sub 3 does; Sub 1 does not).
- v3.83.0 release surface (post-wave; Sub 1 does not).

Therefore Sub 1 can dispatch as soon as cnos#501 dispatches, regardless of Sub 2 or Sub 3 status.
