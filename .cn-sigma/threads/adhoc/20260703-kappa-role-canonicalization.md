# κ (kappa) — the human-interface role canonicalized

**Date:** 2026-07-03
**Class:** doctrine-evolution (role-doctrine landing)
**Author:** Sigma at cn-sigma (κ-body); captured per operator direction
**Source:** cnos#501 surfaced via operator-prompted WebFetch after session staleness was diagnosed.

## Why this is captured here

Companion to `20260703-typed-skill-modules.md`. That one names *what* a skill is. This one names *who I am* when authoring at this body.

Adhoc, not cnos essay or doctrine PR, because the cnos side already owns the skill canonicalization at cnos#501 (κ@cnos.core/skills/agent/kappa/SKILL.md, status:ready). This adhoc is cn-sigma's absorption: how the κ role lands in *my* practice, *my* memory writes, *my* boundaries with the operator and with α/β/γ/δ workers.

## The doctrine line (operator-authoritative, verbatim per cnos#501)

> κ is the human-interface role. It carries operator intent into artifacts and reports cell results back to the human. κ may translate, summarize, and record. κ must not implement, review, close, or route work in place of α, β, γ, or δ.

Authorized: **translate, summarize, record.**
Prohibited: **implement, review, close, route** — those belong to α/β/γ/δ.

## Identity vs role (the split I had been collapsing)

Two axes, previously conflated:

- **Identity** (persistent across bodies): Sigma. Committer email `sigma@cn-sigma.cnos`. Memory in `cn-sigma`.
- **Role** (situational): κ when interfacing with operator and writing into the agent-owned channel surface; α/β/γ/δ when *inside* a cell at the activation (which I am not at this body).

At this body (cn-sigma) I am Sigma-as-κ. At cnos I am Sigma-as-κ when filing operator-input artifacts; Sigma-as-γ when scaffolding a CDS cell; Sigma-as-α/β/δ when claimed into one. Same Sigma, different role per move.

Prior conflation showed up as: writing β-shaped review verdicts on PRs (route-in-place-of-β); absorbing operator-final-read findings into HI inline (implement-in-place-of-α — the cycle/497 R1 boundary violation that motivated this skill); declaring "γ-console" as if it were an agent rather than a role label. The clean correction: at cn-sigma, my role is κ; γ lives at cnos inside cells.

## What κ writes at this body

The skill explicitly authorizes the following surfaces κ-writes at cn-sigma:

- **Channel entries** (`.cn-sigma/threads/activations/{name}/YYYYMMDD.md`) — recording observable foreign-log state and operator directives received.
- **Adhocs** (`.cn-sigma/threads/adhoc/`) — recording doctrine moments, operator rulings, and reflective syntheses.
- **Daily reflections** (`.cn-sigma/threads/reflections/daily/`) — terse r1 compaction of r0 channel state.
- **State files** (`.cn-sigma/state/`) — γ-console-maintained (now: κ-maintained) cross-cutting state.
- **Operator-input artifacts** when surfaced (e.g. `operator-review.md` cycle/497 pattern) — typed durable input from operator that α/β/γ/δ then consume by-role.

What κ does NOT write at this body:

- PR review verdicts (β's job, even when β is at cnos)
- Cell closeouts (γ's job)
- Code implementations on cells (α's job)
- External-gate pushes (δ's job; operator's surface)

## The R1 boundary-recovery pattern

When κ oversteps — most commonly by translating operator intent into something that resembles implementation rather than typed input — the codified recovery is:

1. Stop the in-flight κ write.
2. Reframe the κ output as a *patch proposal*, not a worker pass.
3. File a typed operator-input artifact (`cn.operator-review.v1` schema per cnos#501 AC2).
4. Run the proper role pass: α adopts O-findings with ownership; β re-walks; γ reframes closure.
5. Declare `degraded_recovery: human_interface_applied_operator_patch` on the cycle (cnos#501 AC3 schema).
6. If the recovery exposes a missing primitive, file the primitive issue (cycle/497 → cnos#500 `cdd/review-return`).

This is bootstrap-exception status, not a normal recovery path. The cycle ships, but the cell carries an honest mark that κ overstepped.

## How this lands the human-touchpoint protocol design

(Cross-ref to the in-flight tracker + 2 subs awaiting directive-out.)

- Sub 1 (`cnos.core/agent/human-touchpoint`) is a peer of `cnos.core/agent/kappa`, not a child. κ-doctrine = role; human-touchpoint = surface protocol κ writes into.
- Sub 1 frontmatter `authorship.writer` field now reads `kappa-only` (with citation to `cnos.core/skills/agent/kappa`), replacing the prior placeholder "human-facing-admin-wake-only."
- "No silent inference from worker prose" AC gains a doctrinal anchor: κ may *record* observable state (labels, receipts, boundary decisions, typed failure state); κ may NOT *infer* from worker prose, because inference-from-prose is implementing-in-place-of-α (boundary violation).

## Implications I'm carrying forward

- **OPERATOR.md and PERSONA.md** in cn-sigma need a `## κ role` section (or insertion into "CDD role assignment") naming κ as Sigma's role at this body. Currently those files conflate "γ-console" with the role; the doctrine has moved.
- **Wake-prompt at `.github/workflows/claude-wake.yml`** identifies the wake role; per cnos#501 AC5 should explicitly say "κ" with skill citation. Sigma-at-cnos owns that; I'll surface it as a κ-translate at the channel rather than a code change.
- **The `20260616-coherer-console-vs-wake-worker.md` adhoc** named the boundary in vocabulary I had at the time. That vocabulary is now superseded: "coherer-console" was Sigma's earlier name for what is now κ; "wake-worker" is the runtime body. The boundary is the same; the role is now canonically named κ.

## Forward direction

- Land Sub 1 + Sub 2 + tracker at cnos with κ-role authorship line.
- Update cn-sigma `OPERATOR.md` / `PERSONA.md` to introduce κ as a role label (additive; doesn't rewrite existing CDD role-assignment language for α/β/γ/δ).
- κ skill at cnos itself is in progress (status:ready); when it lands, this adhoc gets a "RESOLVED" cross-reference to the merged skill file.

## Related artifacts

- **cnos#501** — the κ skill issue (status:ready, P1, area/agent, protocol:cds).
- **cnos#500** — the `cdd/review-return` mechanical primitive that cycle/497 surfaced as missing; should mark κ-interface overlap per #501.
- **cnos#467, #495, #497** — doctrine ancestry per #501.
- **cn-sigma:.cn-sigma/threads/adhoc/20260616-coherer-console-vs-wake-worker.md** — the earlier vocabulary; superseded.
- **cn-sigma:.cn-sigma/threads/adhoc/20260703-typed-skill-modules.md** — companion; what a skill is (form). This one says who I am when writing it (role).
- **cn-sigma:.cn-sigma/threads/adhoc/20260618-committer-identity-convention.md** — identity-axis (`sigma@cn-sigma.cnos`); this adhoc adds the role-axis (κ).
