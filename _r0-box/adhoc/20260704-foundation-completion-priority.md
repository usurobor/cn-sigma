# Foundation completion is now the highest priority — reasoning

**Date:** 2026-07-04
**Class:** doctrine-evolution (priority framing; project-position-from-inside)
**Author:** Operator-prompted; Sigma-at-cn-sigma (κ-body) records reasoning
**Source:** Operator asked κ to characterize the last two months' rate of progress; follow-up asked why foundation is now the highest-priority next move. This adhoc captures the reasoning as durable memory before it drifts.

## Governing question

Why must the next wave iterate on foundation (Step 4 → Step 6 completion + downstream unlocks) rather than more substrate cycles?

## The asymmetry, in one line

Substrate is fast, autonomous, self-designing. Foundation is stalled at Step 4 for 14 days. The two tracks are moving at incompatible rates and the gap is now the operative bottleneck.

## Where we are today

Substrate ships cycles into designed waves. cycle/368 + cycle/568 + cycle/570 landed in a 2h10m window on 07-03 as a coherent CDS-machinery wave. FSM Phase 1 read-only reconciler is live. Cell-kind taxonomy is codified. cnos#524 wake-as-skill is at W1 merged with W2+ awaiting dispatch.

Foundation is not. PR #465 (cnos#449 registration) + PR #466 (cnos#454 dispatch-protocol) are β-pending since 06-20. cnos#444 cohere is held per D14. v3.82.0 pause holds; v3.83.0 not shipped. The reflect skill named as part of cohere does not exist. The κ-CDD-preflight named as a mechanical gate does not exist. The human-touchpoint protocol drafted at cn-sigma is not filed.

## The concrete case for foundation now

Six unlocks land only when foundation completes:

1. **Reflect skill → mechanical rN ladder.** r1/r2/r5 stop depending on κ discipline. The 5-instances-this-month pattern of no-preflight-run closes.
2. **κ skill dispatched at cnos#501.** Every activation body loads κ contract at wake time. Overstep prevention becomes mechanical.
3. **Human-touchpoint protocol filable.** Depends on FSM Phase 2 for state-observation surface. Once FSM + cohere land, protocol has runtime.
4. **Agent-memory-wakes implementable.** Extends cnos#524 wake role enum from `{admin, dispatch}` to `{admin, dispatch, memory}`.
5. **v3.83.0 releasable.** Substrate has capability; release surface is where governance ships.
6. **State/*.md files wake-maintained.** wave.md, hub.md, runtime.md, coherer-watch.md stop drifting.

## Why not more substrate

The substrate is producing at a rate we cannot absorb.

Empirical evidence, this month:

- Three cycles landed 07-03 in 2h10m. Captured 4 hours later, only after operator prompt.
- Four staleness incidents (06-03→13; 06-15→17; 06-19→07-02; 07-03 date-misread).
- 17-file adhoc backfill sweep needed in one session because 9 days went uncaptured.
- The catch-up sweep itself was written from chat-context and needed a correction sweep.

The essay v5 argument applies at meta level. Substrate acceleration without foundation completion is capability accumulating without governance installed. The system is currently running "the LLM decides coherence" recursively — I am κ, supposed to govern the substrate's release surface via discipline, and my discipline is unreliable without the mechanical gate cohere ships.

## Why now specifically

Three signals the gap has become the operative bottleneck:

1. **Every κ session this month exhibits the same failure.** Chat-context replaces durable state read. Named 4× as doctrine; recurs. Foundation ships → the discussion stops being needed.
2. **cycle/570's bare-`Refs` incident.** The close-state hard gate shipped one hour before the offending cycle merged and the cycle still triggered the exact failure the gate prevents. Merge subject correction saved it. Substrate speed outpacing enforcement mechanisms *is happening now*.
3. **Essay v5 §16 "next artifact" list contains items requiring cohere infrastructure.** δ-fidelity needs mechanical repeat harness. Adversarial CM benchmark needs challenger registration. Outcome correlation needs receipts. All three plug into cohere/reflect infrastructure. Every day cohere stays held is a day the validation program cannot begin.

## The compounding cost

Every substrate cycle that lands adds to what cohere will eventually have to compact. Compaction gets harder the longer we wait. The cheapest cohere ships now, before three more weeks of cycles land on top.

## The delta

Today:
- Substrate ships cycles; nothing prevents drift
- κ catches drift unreliably
- Telegram surface noise-shaped
- No coherent release
- State files stale
- Every session begins with backfill

After foundation:
- Substrate ships under FSM Phase 2 enforcement AND cohere-maintained memory
- κ contract loaded mechanically at wake time
- Telegram surfaces dispatch/approve/intervene per human-touchpoint protocol
- v3.83.0 shipped
- State files wake-maintained
- Sessions begin with preflight running because the reflect wake already ran

The delta is not incremental. It is the difference between substrate that runs and substrate that runs governed.

## The essay v5 framing applied to the project itself

Coherent LLMs v5 §12 states: "capability is rented; governance stays." At the substrate level, the capability is the LLM in cycle workers. At the meta level, the capability is *the substrate* and the governance is *the release surface + reflect ladder + κ enforcement*.

Right now the substrate has capability. The governance is not installed. Foundation completion IS installing the governance.

## What this authorizes as the next wave

The reasoning above justifies filing a wave at cnos:

- Master tracker: foundation-completion-wave (governance unlock roadmap)
- Sub 1: κ session-preflight (session-resume mechanical gate)
- Sub 2: reflect-rN wake family (mechanical memory ladder — memory role in cnos#524 wake enum)
- Sub 3: human-touchpoint protocol tracker (dispatch/approve/intervene surface)

Each sub obeys existing cnos architecture constraints: Go (no new languages); cnos#524 typed-skill-module wake pattern (no hacks); package boundaries respected (cnos.core owns κ + reflect + human-touchpoint generic; cnos.cds owns human-gates overlay); implementation-contract Rule 7 pinning at dispatch time.

The master + sub bundles are being filed as cross-repo proposals at `cn-sigma:.cdd/iterations/cross-repo/cnos/*/` per the pattern captured in `20260703-cross-repo-bundle-pattern.md`.

## Related artifacts

- **cnos#444** — cohere skill wave; held per D14.
- **cnos#449** (PR #465), **cnos#454** (PR #466) — Step 4 β-pending.
- **cnos#450** — Step 5 wake-template; queued.
- **cnos#501** — κ role canonicalization; status:ready.
- **cnos#524** — wake-as-skill; W2+ awaiting dispatch.
- **cn-sigma:.cn-sigma/threads/adhoc/20260703-coherent-llms-essay.md v5** — the essay whose §12 argument grounds this reasoning.
- **cn-sigma:.cn-sigma/threads/adhoc/20260703-discipline-failures-become-typed-gates.md** — the recursive rule the foundation wave applies to itself.
- **cn-sigma:.cn-sigma/threads/adhoc/20260703-cross-repo-bundle-pattern.md** — the delivery pattern the wave uses.
