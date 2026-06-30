# cnos#524 wake-as-skill — typed-skill-modules abstraction shipping in parallel

**Date:** 2026-06-30 (event; same day capture)
**Class:** doctrine-evolution + implementation cross-reference
**Author:** Sigma at cn-sigma (κ-body)
**Source:** WebFetch of cnos#524; observed via channel `20260630.md` 08:46Z entry. PRs #525 (W0 design) + #526 (W1 schema + dual SKILL.md) merged today.

## Why this is captured here

The `20260630-typed-skill-modules.md` adhoc (written earlier today) named the abstraction. cnos#524 *is* the wake-specific implementation of that abstraction — landing the same day, by parallel track. The two need explicit cross-reference: the adhoc supplies the broader principle; cnos#524 supplies the wake-specific form.

I wrote `typed-skill-modules` as if it were new doctrine. It wasn't — cnos was building the form in PRs W0+W1 while I was writing the abstraction. Honest framing: parallel convergence on the same doctrine, with the operator's `20260630` framing being the canonical articulation.

## What W0 + W1 shipped (per cnos#524 + channel)

- **W0 (PR #525, `67f318c5`)** — design locked: migration plan, golden-byte-identity verification oracle, AC1–AC7 ACs.
- **W1 (PR #526, `4fc3f2dd`)** — implementation start:
  - `#Wake` CUE schema added with role enum `{admin, dispatch}`, boolean fields, validation.
  - Two orchestrator SKILL.md modules authored: `cnos.core/orchestrators/agent-admin/SKILL.md`; `cnos.cds/orchestrators/cds-dispatch/SKILL.md`.
  - Exact manifest data and verbatim prompt bodies preserved.
  - Existing `wake-provider.json` + prompt files retained as side-by-side source until W3 flip.
- **W2 (next)** — teach renderer to read SKILL.md; byte-identical parity gate.
- **W3** — flip renderer source to SKILL.md.
- **W4** — delete legacy JSON + prompt files.

W2 awaits operator dispatch. W3/W4 follow.

## The role-enum gap (for the agent-memory-wakes issue I just filed)

cnos#524's `#Wake` schema declares role enum `{admin, dispatch}`. The agent-memory-wakes directive-out (`.cn-sigma/threads/activations/cnos/20260630.md`, 19:00Z) proposes wakes with `role: memory`. That role isn't in the current enum.

This isn't a contradiction; it's the natural extension shape:

- cnos#524 W1 introduces the schema with `{admin, dispatch}` because those are the existing wakes.
- Agent-memory-wakes naturally extends the enum to `{admin, dispatch, memory}` — same schema, new value.
- W2+ of cnos#524 may or may not be the right place to land that extension. γ-at-cnos will judge; the agent-memory-wakes issue should reference cnos#524 W1 as the schema home and propose the enum extension as part of its implementation contract.

When the agent-memory-wakes issue gets filed at cnos (per the directive-out), the body should add an Implementation Contract line explicitly: "Extends cnos#524 W1 `#Wake.role` enum from `{admin, dispatch}` to `{admin, dispatch, memory}`."

## Convergence pattern

This is the second cross-axis instance today of the same convergence shape:

1. **κ-skill canonicalization at cnos#501** (status:ready as of today) — my `20260630-kappa-role-canonicalization.md` was written without knowing the skill issue was already at cnos awaiting dispatch.
2. **wake-as-skill at cnos#524** (W0+W1 landed today) — my `20260630-typed-skill-modules.md` was written without knowing the implementation was in tree.

Pattern: operator-led doctrine surfacing and cnos-side implementation are running in parallel. κ's role is to translate operator framing into durable cn-sigma memory; the cnos side ships the form. Both move; both converge to the same doctrine; neither is the other.

Honest meta-note: had I read durable cnos state at session start (the κ-CDD-preflight today's r1 named but didn't ship), I would have known about both. The `20260630-discipline-failures-become-typed-gates.md` adhoc applies to this: the preflight is the gate; not having it is exactly why the convergence reads as discovery now instead of as known context.

## Implications for cn-sigma memory

- **Update κ-canonicalization adhoc:** add cross-reference that cnos#500 PR #502 shipped 06-26 (live, not awaiting dispatch). See companion `20260626-cdd-review-return-shipped.md`.
- **Update typed-gates adhoc:** correct cnos#500 row from "filed; awaiting operator dispatch" to "RESOLVED — PR #502 merged 06-26."
- **Update typed-skill-modules adhoc:** add cross-reference to cnos#524 as the wake-specific implementation; note the abstraction was being implemented in parallel at the time of writing.
- **Agent-memory-wakes directive-out:** the issue body should be amended at filing-time by γ-at-cnos to reference cnos#524 W1 `#Wake` schema + propose role-enum extension. If a follow-up directive-out is needed before filing, it goes via the cross-repo bundle pattern (see `20260630-cross-repo-bundle-pattern.md`) rather than another channel entry.

## Related artifacts

- **cnos#524** — wake-as-skill migration master issue; W0 (PR #525) + W1 (PR #526) merged today.
- **cn-sigma:.cn-sigma/threads/adhoc/20260630-typed-skill-modules.md** — the abstraction (parallel convergence; not foundational to cnos#524, but doctrinally aligned).
- **cn-sigma:.cn-sigma/threads/adhoc/20260630-kappa-role-canonicalization.md** — the role-doctrine companion; pre-knew of cnos#501 but not cnos#524.
- **cn-sigma:.cn-sigma/threads/adhoc/20260630-discipline-failures-become-typed-gates.md** — the recursive principle this missed-convergence instance exemplifies.
- **cn-sigma:.cn-sigma/threads/activations/cnos/20260630.md** — channel log of the W0+W1 landing.
