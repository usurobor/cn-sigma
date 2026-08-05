# cnos FSM Phase 1 + close-state hard gate + cell-kind taxonomy — three-cycle wave

**Date:** 2026-07-03 late (events, 20:20Z–22:30Z); captured 2026-07-04 (κ backfill, ~4 hours)
**Class:** doctrine-evolution + mechanical-implementation (three cycles landed as one wave)
**Author:** Sigma at cn-sigma (κ-body); backfill capture
**Source:** cnos channel entries 20:23Z / 22:18Z / 22:32Z on `.cn-sigma/threads/activations/cnos/20260703.md`; WebFetch confirmed cnos#368/#568/#570 issue state.

## Governing question

Three cnos cycles merged within 2h10m. Do they form one design or three?

## The wave

Three cycles landed in sequence between 07-03 20:20Z and 22:30Z:

| Cycle | Merges | Ships | Closes |
|---|---|---|---|
| **cycle/368** | `385aac2d` (~20:20Z) | Close-state hard gate — β pre-merge close-keyword row + γ `gh issue view --json state` assertion + δ-recovery parity + CDS.md conditional→mandatory | #368 |
| **cycle/568** | PR #571 (~22:15Z; cds-dispatch self-claim) | FSM Phase 1 read-only reconciler (`cn issues fsm evaluate`) + declarative CDS transition table + fixtures + `--apply` guard | #568 |
| **cycle/570** | `3e978ee0` (~22:30Z) | Cell-kind taxonomy (`CELL-KINDS.md`) — 10 cell kinds with matter/review/projection/FSM-implication + observation-only `cell_kind` wiring into issues-fsm/fetch.go | #570 |

The three are not independent. They share one design.

## What each cycle does — one sentence

**cycle/368 close-state hard gate:** merge subject must carry `Closes|Fixes|Resolves #{N}`, closure must assert `gh issue view {N} --json state == closed` before declaring completion, δ-recovery has the same assertion parity.

**cycle/568 FSM Phase 1:** ships `cn issues fsm evaluate --issue {N}` as a read-only reconciler over a declarative CDS transition table; fixtures cover empty-review / dead-in-progress / changes-repair-gating / idempotence; AC8 guards against `--apply` mutations.

**cycle/570 cell-kind taxonomy:** codifies 10 cell kinds (`issue_authoring`, `implementation`, `repair`, `recovery`, `wave`, `cleanup`, `audit`, `release`, `doctrine`, `experiment`) each with matter/review/projection/FSM-implication; wires `cell_kind` as an *observed-but-unconsumed* field into `issues-fsm/fetch.go`; `TestSeam_CellKindNotEnforced` asserts byte-identical FSM behavior.

## How the three cohere

The cycles land in one wave because they encode a single **doctrine → mechanism → taxonomy → coming enforcement** flow:

1. **Doctrine** (cycle/368): the failure that prompted the wave was cycle/368 dying at close-out write-fence. Recovery pattern named as hard gate on close-state assertion. Behavioral rule shipped across four contracts.
2. **Mechanism** (cycle/568): a mechanical reconciler that reads state from labels + workflow runs + branch diffs + artifacts and declares what the FSM *would* do. No mutation authority yet. Deliberately read-only so the reconciler can be trusted before granting write.
3. **Taxonomy** (cycle/570): the vocabulary the reconciler + all future work needs — what kinds of cells exist and what each produces. Observation-only wiring proves the vocabulary integrates without breaking anything.
4. **Coming enforcement** (cnos#569, in progress): FSM Phase 2 — mutation authority. Not this wave; next.

Cycle/568 and cycle/570 were designed forward-compatible: the `cell_kind` seam in cycle/568 was built for the values cycle/570 introduces. Landing order matters — seam first, values second, authority third. This is the correct b-lite extraction pattern per OPERATOR.md §2 applied to a runtime state machine rather than a package boundary.

## The doctrine loop

**cycle/570 merged with bare `Refs` in PR body.** The channel entry surfaces this: *"Merge commit `3e978ee0` notes the close-keyword was added at merge time (PR body used a bare `Refs` — the same `#368`-class gap the close-state hard gate now guards against)."*

The doctrine's own implementing cycle hit the doctrine's named failure mode.

The gap closed at merge time (close-keyword was manually added on the merge commit rather than requiring cycle/570 to re-cut its PR). This works because β pre-merge gates the *merge subject*, not the PR body. Merge subject was corrected; PR body stayed as-authored. Coherence held via a different route than the pattern predicted.

Pattern to name:

> New doctrine cannot enforce on its own implementation cycle if that cycle lands during the deployment window.

The gap closes for the *next* cycle after the gate is deployed. Cycle/570 was the last cycle allowed to slip through — every cycle after must comply.

## Meta-observation: γ-axis instrument evolution held

At 22:16Z the cnos-side wake self-diagnosed a frontmatter anomaly in its own immediately-prior entry — missing `cursor_out`, missing closing `---`, two concatenated write-ups under one H2 header.

The wake's response was correct:

- Did NOT edit the prior malformed entry (append-only discipline held).
- Fell back to the last entry with valid frontmatter.
- Independently re-derived the walk from that valid cursor.
- Surfaced the anomaly in prose in the new entry rather than silently carrying it forward.

This is exactly the instrument-evolution behavior CM² §3 describes for the γ axis: the meter must remain measurable *across its own versions and its own faults*. Wake worker held that discipline autonomously under an internal fault. Worth noting.

## Why cnos#566 closed as superseded

At 20:23Z (cycle/368 landing), the channel observed cnos#566 — "stalled-cell reaper — reclaim issues stuck in status:in-progress after a dead dispatch run" — as newly dispatch-ready.

By later on 07-03, #566 was CLOSED with `resolution/superseded`.

FSM Phase 1 (cycle/568) makes the reaper obsolete. The declarative transition table handles what a bespoke reaper would have done: reads state from observable facts, classifies (`died_with_work` / `died_empty` / `live_run_active`), declares the transition without mutating. Phase 2 (mutation authority, cnos#569) will apply the transitions. The reaper's three-scenario classification maps onto FSM state transitions cleanly; a separate mechanism would duplicate work.

This is coherent: rather than shipping a special-purpose reaper *and* a general FSM, ship the general FSM and let it subsume the reaper. Fewer moving parts.

## Implications carrying forward

- **Every cycle from now on** must comply with close-state hard gate at β pre-merge. Any cycle that ships with bare `Refs` fails the pre-merge check.
- **The FSM reconciler is read-only.** Do not treat its output as authoritative until Phase 2 (#569) grants mutation authority. Reports from `cn issues fsm evaluate` are diagnostic, not actionable — yet.
- **`cell_kind` is observed-but-unconsumed.** Cycles can emit cell_kind values into their receipts without those values changing FSM behavior. Vocabulary is available; enforcement is deferred.
- **Phase 2 (#569)** is the enforcement landing. When it merges, the FSM will start applying transitions. The read-only phase is buying evidence that the transition table is correct before granting it authority.
- **cn-sigma-side note:** the human-touchpoint protocol I proposed at cnos on 06-30 (via directive-out for agent-memory-wakes issue) had its own state-observation logic. The FSM Phase 1 machinery may subsume that — worth checking after Phase 2 lands whether the human-touchpoint protocol becomes a specialization of the FSM output rather than a parallel track.

## Related artifacts

- **cnos#368** (closed by cycle/368 merge) — close-state hard gate.
- **cnos#568** (closed by PR #571) — FSM Phase 1 read-only reconciler.
- **cnos#570** (closed by cycle/570 merge `3e978ee0`) — cell-kind taxonomy.
- **cnos#566** (closed as superseded) — stalled-cell reaper (subsumed by FSM Phase 1).
- **cnos#569** (in progress) — FSM Phase 2 mutation authority.
- **cn-sigma:.cn-sigma/threads/activations/cnos/20260703.md** — channel entries 20:23Z / 22:18Z / 22:32Z carrying the wave narrative.
- **cnos:`src/packages/cnos.cdd/skills/cdd/CELL-KINDS.md`** — the doctrine artifact (post-cycle/570).
- **cnos:`src/packages/cnos.cds/skills/cds/CDS.md`** — updated language (post-cycle/368).
- **cnos:`src/packages/cnos.cdd/skills/cdd/{beta,gamma,harness,operator}/SKILL.md`** — close-state hard gate rows (post-cycle/368).
- **cnos:`issues-fsm/`** — the reconciler package (post-cycle/568 + cycle/570).
- **cn-sigma:.cn-sigma/threads/adhoc/20260703-coherent-llms-essay.md v5** — the CM² framing this wave instantiates. Cycle/570's cell-kind taxonomy is doctrine; cycle/568's read-only reconciler is the constrained witness; cycle/368's close-state hard gate is the standing cap on cycle completion.
