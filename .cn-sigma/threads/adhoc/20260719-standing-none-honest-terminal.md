# CI-green is not coherence-green — "standing: none" is a completed honest terminal, not a failure

**Date:** 2026-07-19 (events); captured 2026-08-01 (κ backfill)
**Class:** learning + reusable-pattern
**Author:** Sigma at cn-sigma (κ-body); backfill capture
**Source:** cnos git log 2026-07-19 (#669/PR #670, retention 66d3279b); cnos-side foreign log .cn-sigma/logs/20260719.md; daily reflection 20260719.md.

## The point, first

A green check proves an artifact **renders or runs at its public boundary**. It never proves the coherence claim the artifact encodes. cnos#669 landed a source-checkout-only recursive-cell coherence-measure (CM) candidate via PR #670 (merge `46ee622a`, ~21:43Z) — deliberately with **`standing: none`**. That is not an unfinished cycle. It is a completed, honest terminal state: a bounded instrument plus an explicit residual list, shipped without a standing claim because the evidence for standing does not yet exist.

Naming "standing: none" as the terminal *is* the deliverable. The failure mode this thread guards against is treating a passed self-run, or a green CI matrix, as if it had manufactured authority it cannot manufacture.

## The four load-bearing lessons

**1. CI-green ≠ coherence-green.** Early green checks on cycle 669 did not exercise the documented route, the cross-level output contract, or the role/provenance invariants. Fresh-β caught those gaps only *after* CI was already green. Executable claims need executable evidence at their **public boundary** — the exposed route a caller actually takes — not at whatever internal path the green check happened to touch.

**2. A self-run cannot manufacture standing.** A CM is a witness-cell-produced measurement instrument; a coherence-cell is its adjudicative consumer. A self-run of a *newly authored* CM is exploratory evidence only. It proves emission — the instrument produces a number — not admissibility. Standing waits on independent held-out / off-diagonal evidence and independent custody. The original N=1 self-sample is superseded the moment a repair changes the instrument, and must not count toward any later frozen-prompt calibration; calibration restarts from the landed frozen candidate.

**3. Git authorship is protocol evidence, not decoration.** The provenance ordering is load-bearing: γ scaffold precedes α matter (here `6e07b4cc` γ at 19:00Z before `6764c42e` α at 19:02Z); matter and repairs are α-authored; canonical review artifacts are β-authored; γ owns custody. A γ commit carrying β prose does **not** establish β provenance. The authorship graph is the check, not the commit message.

**4. A tracked artifact cannot contain its own future commit SHA.** Bind matter bytes internally; bind the review head externally via κ/β receipts. Any tracked text asserting its own future SHA is self-referentially impossible and should be mechanically rejected.

## The reusable pattern

> A green signal proves an artifact renders/runs at its boundary; it never proves the coherence claim the artifact encodes. Structural self-consistency dressed as a number is a **louder** version of the same unvalidated claim.

Read from the other side, this is the same shape as the 07-05 pin-for-determinism trap: a golden diff there, a CI matrix here — the green proves the artifact *renders*, never that the claim it encodes is *valid*. A CM that passes its own self-run and emits a clean structural-consistency score has done something more dangerous than staying silent: it has attached a quantitative voice to an unadmitted claim. The honest output of such a cycle is qualitative and residual-bearing — a bounded instrument plus a named list of what stays unproven (State-B arbitrary loading, installed-activation, held-out calibration, universal pathname-race protection, institutionally-independent custody). Terminating at "standing: none" is what keeps the number from lying.

## Sigma's role here: custody, not authorship

Sigma authored **none** of the 21 α/β/γ cell commits — under the cnos#467 admin boundary it does not run the cell under any circumstance. Its one substantive act on 07-19 was, at operator request, to **retain** the learnings the cells produced: an eleven-point durable entry (`66d3279b`, 21:49Z, class `substantive`) recording exact commit custody (matter head `db9ce95b`; α review head `56b08ea3`; β convergence `859f9d9c`; γ head `4ff33d1f`; merge `46ee622a`). The agent-admin persona can carry an operator-requested lesson into durable channel memory *precisely because* it stands outside the α/β/γ role separation the lesson is about. Recording the exact heads is what makes the retention verifiable rather than paraphrase. The custody is the contribution; the coherence work belongs to the cells.

## Carry-forward gates (named by the cycle, not yet all shipped)

- Gate dispatch/review on a **first-commit γ scaffold** plus explicit role identities.
- Require β to **author its own canonical review artifact** (no γ-carried β prose).
- Compare live PR scope prose against the tracked proposal.
- **Mechanically reject self-SHA wording** in any tracked artifact.
- Test every fail-closed boundary **through the exposed public route**, not an internal shortcut.
- Recursive-cell CM promotion stays `standing: none` until independent held-out validation supports it.

## Related artifacts

- **cnos#669** (closed by PR #670 merge `46ee622a`) — recursive-cell coherence methodology; landed `standing: none`.
- **cnos PR #670** — merged ~21:43Z by fresh non-author operator; preserves reviewed head `4ff33d1f` as 2nd parent.
- **cnos#467** — agent-admin/dispatch wake-orchestration split; the admin boundary under which Sigma did not execute the cell.
- **cnos:`66d3279b`** — Sigma's foreign-log retention entry (`.cn-sigma/logs/20260719.md`), the r0 of record for this lesson.
- **cn-sigma:.cn-sigma/threads/reflections/daily/20260719.md** — the daily this thread distills (MCI: "CI-green is not coherence-green, and a self-run cannot manufacture standing").
- **cnos cycle 669 commit spine:** `6e07b4cc` γ scaffold → `6764c42e`/`624c7569` α matter → `6b2e75a7` β R2 → `db9ce95b`/`0c56ed72` α repairs → `56b08ea3` α review head → `859f9d9c` β convergence → `4ff33d1f` γ custody.
- **cn-sigma:.cn-sigma/threads/adhoc/20260703-coherent-llms-essay.md** — the CM²/standing framing this cycle instantiates.
