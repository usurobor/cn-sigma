# cycle/497 — Model B receipt ledger + κ-role emergence

**Date:** 2026-06-26 (event); captured 2026-07-03 (κ backfill)
**Class:** doctrine-evolution (decision cycle + role-doctrine birth)
**Author:** Sigma at cn-sigma (κ-body); backfill capture
**Source:** PR #499 merged at cnos@f8c3f67 (06-26 07:43:34Z). Full cycle narrative recorded in `.cn-sigma/threads/activations/cnos/20260626.md` 08:42Z entry.

## Why this is captured here

cycle/497 produced two doctrine landings in one move:

1. **Model B decision** — artifact ownership model for receipts (substrate-level decision; affects every protocol that ever writes a receipt).
2. **κ-role emergence** — the cycle's R1 violation became the motivating incident for canonical κ-role doctrine at cnos#501.

Either alone would warrant an adhoc; combined they are the inflection point where the substrate's *what* (Model B) and the substrate's *who* (κ-role) both got their first canonical form.

Backfill capture; cnos owns the PR and the resulting issue filings (#500, #501).

## Decision 1 — Model B (artifact ownership)

Question: where does protocol-specific receipt evidence live?

- **Model A** (rejected): each concrete protocol owns its own receipt namespace (`cnos.cds/.cds/`, `cnos.cdr/.cdr/`, etc.). Receipts stratified by protocol directory.
- **Model B** (chosen): `.cdd/` is the CDD framework's unified receipt ledger. Concrete protocols (cds, cdr, cdw, ...) write into the same ledger. Protocol identity carried in a `protocol_id` field *inside* the receipt artifact, not in directory path.

Rationale: `.cdd/` is not a package namespace; it is the framework's receipt surface. Protocols are *consumers* of the receipt grammar, not owners of their own grammar. A unified ledger supports cross-protocol audit and cell-history queries that stratified directories would fragment.

This binds to the 06-22 cnos.cdd-vs-cnos.cds correction (`20260622-cnos-cdd-vs-cds-doctrine-correction.md`): cdd is substrate; cds is one of many possible bindings. The receipt ledger lives at the substrate, not at any binding.

## Decision 2 — κ-role emergence (the recovery)

The cycle ran R0 cleanly. Then HI (the role I was playing — what I had been calling "γ-console") absorbed 6 operator-final-read findings *inline* into the cycle artifacts as if it were an α/β pass. Operator caught it: **boundary violation**. HI implemented in place of α; routed verdict in place of β; reframed closure in place of γ.

The recovery sequence — itself the first instance of the κ-boundary recovery pattern:

1. HI's inline absorption was **reframed as a patch proposal**, not a worker pass.
2. HI authored a typed durable input artifact: `operator-review.md`, schema `cn.operator-review.v1`. Six findings O1–O6 recorded with verbatim operator correction text.
3. α-497 R1 ran a **proper role pass**: inspected the operator-review.md patch proposals; adopted O1/O2/O3 with ownership; deferred O4/O5/O6 to γ (γ-owned matter).
4. β-497 R1 ran a **proper role pass**: independent re-walk; verdict: converge. Honest gap-class accounting on what the β R0 mechanical AC oracle missed.
5. γ-497 R1 took ownership of closure; declared **`degraded_recovery: human_interface_applied_operator_patch`**. Recovery sequence recorded; bootstrap-exception status declared.
6. Two follow-up filings:
   - **cnos#500** — `cdd/review-return` mechanical primitive (the missing piece: how do operator iterate verdicts route back into an existing cell without HI overstep?).
   - **cnos#501** — the κ-role canonicalization itself (codify the role; install the boundary as doctrine, not just as cycle-local recovery).

Operator then ran one more R2 pass with a single wording finding (O7: "parallel" wording for β R1 + γ R1 contradicted role-sequencing). γ R2 fixed it; PR #499 merged.

## What κ-role emergence means structurally

Before cycle/497, the HI role had no canonical name in cnos doctrine. It was Sigma-as-coherer, Sigma-as-γ-console, Sigma-as-admin — vocabulary that drifted per-session. The cycle/497 violation made the gap concrete: when HI has no codified contract, the very ambiguity creates the overstep.

After cycle/497:

- κ has a name.
- κ has a verbatim doctrine line (operator-supplied at cnos#501).
- κ has an authorized/prohibited action enumeration: translate/summarize/record vs implement/review/close/route.
- κ has a typed input schema (`cn.operator-review.v1`).
- κ has a degraded-recovery declaration schema.
- κ skill location is set: `cnos.core/skills/agent/kappa/SKILL.md`.

cycle/497 thus did two things at one altitude (Model B) and one thing at a higher altitude (κ as the role-doctrine-bearing surface for every future HI move).

## The pattern cycle/497 codifies

> When κ touches matter that is in α/β/γ's scope, κ STOPS, files a typed input artifact, and reactivates the proper role pass with that artifact as evidence.

This is the κ-boundary recovery — bootstrap-exception, not normal path. The cycle ships; the cell carries the honest mark.

A cycle that *needs* this recovery once per execution has a real κ-overlap problem with the protocol's review-routing primitives — which is exactly why cnos#500 (`cdd/review-return`) was filed: the mechanical primitive should make the bootstrap-exception unnecessary in the steady state.

## Implications carrying forward

- All future receipt evidence at cnos goes through the `.cdd/` ledger with `protocol_id` declared in the artifact.
- κ doctrine canonicalized at cnos#501 (status:ready as of 06-30); my body at cn-sigma is κ; see companion `20260703-kappa-role-canonicalization.md`.
- The recovery pattern (operator-review.md as typed input + proper role pass + `degraded_recovery` declaration) is the codified template for any future κ overstep.
- cnos#500 (`cdd/review-return`) is the mechanical primitive that should reduce κ-bootstrap-exception incidents; tracked separately.

## Related artifacts

- **PR #499 at cnos** — the cycle/497 merge.
- **cnos#500** — `cdd/review-return` mechanical primitive follow-up.
- **cnos#501** — κ-role canonicalization (status:ready).
- **cn-sigma:.cn-sigma/threads/activations/cnos/20260626.md** — full channel narrative of the cycle.
- **cn-sigma:.cn-sigma/threads/adhoc/20260622-cnos-cdd-vs-cds-doctrine-correction.md** — the substrate boundary that Model B presupposes.
- **cn-sigma:.cn-sigma/threads/adhoc/20260703-kappa-role-canonicalization.md** — the κ companion (today's capture).
- **cn-sigma:.cn-sigma/threads/adhoc/20260616-coherer-console-vs-wake-worker.md** — the pre-κ vocabulary; superseded by this cycle's role-naming.
