---
title: Cell design needs no CDD refactor — field-test first
date: 2026-05-27
status: adhoc
scope: architecture-judgment
---

# Cell design needs no CDD refactor

**Trigger:** Operator asked: "Do we need to refactor CDD to implement cell design cleanly?" This adhoc records the judgment.

## The question

Does CDD need restructuring to cleanly express the recursive-cell model from `CELL-OF-CELLS.md`?

## The answer: no — and the essay says so explicitly

`CELL-OF-CELLS.md` (DRAFT v0.2.0) pre-answers its own implication question:

- **§11 (Relation to CCNF):** "CCNF is the normal form of one cell. Cell-of-cells is the law of many cells… This reframes three CCNF phrases *without changing the kernel*… The kernel stays compact. The system model explains its boundaries."
- **§17 (What this document does not change):** explicitly lists — does NOT rewrite CDD.md, change CCNF equations, add schemas, create a new package. "It names the system-level model *already implied by the current package architecture*."

The cell design is the **reading** of the v3.82.0 architecture, not a change order against it. The refactor already happened: the #366→#403 arc compressed CDD.md to the CCNF spine (#402), extracted CDS/CDR/handoff as realizations, shipped V (`cdd-verify`) + receipt schemas, and seated δ/ε as boundary/stream roles. That arc *was* the structural work that makes the cell model expressible.

## Refactor vs build — the distinction that matters

| Surface | Status |
|---|---|
| Static cell structure (CCNF kernel; kernel/realization split; δ+V at boundary; ε across stream) | **Clean. No refactor.** The arc did it. |
| Dynamic recursive composition (§8: accepted child receipt *becomes* parent matter; the steering loop) | **Implied but not built.** This is DECREASING-INCOHERENCE Waves 1-6 — paused. Net-new construction, not a CDD refactor. |
| Six open design questions (§18: non-tree cells, authority across boundaries, retraction, public-scale enclosing cells, persona hubs, cycle-vs-cell) | **Genuinely unclean — but open *design*, not refactor debt.** |

What feels "not yet clean" is the unbuilt steering loop and the six open questions. Neither is fixed by restructuring what exists.

## Why refactoring now would be the wrong move

Refactoring CDD to "cleanly implement cell design" before field-testing whether the current expression is insufficient is **speculative design without evidence of need** — which my own discipline (`spec/OPERATOR.md` "Focus less on: speculative design without evidence of need") rejects, and which the v3.82.0 pause explicitly defers ("field evidence gates next theory expansion").

The cell design is clean enough to field-test as-is. Field-testing is what surfaces whether any refactor is warranted. §18.6 (cycle vs cell) is the most likely place a real strain shows up — but only CCNF-O work would force it, and that's gated.

## Recommendation

No refactor. The honest next move is not "make CDD cleaner" — it's: deploy CDS/CDR/handoff on real work (the `agent-gh-deployment` tracker is the deployment-infra enabler), watch where the cell model strains, and let *that* evidence specify any refactor. Absent a named, field-surfaced incoherence, refactoring is polishing an untested structure.

If field use surfaces a concrete strain (e.g., a wave that genuinely can't be modeled as either one cell or a clean graph of cells), that becomes a named incoherence worth a design cycle — at which point the refactor has evidence behind it.

## Connection to the external-audit request (same session)

The operator also requested an external coherence audit of cdd/cds/cdr. That audit is the right *first* check before any refactor talk: it gives an independent coherence read on whether the current expression actually holds together. A refactor proposal that arrives *before* the audit would be presupposing its own conclusion. Order: audit → field-test → (if evidence warrants) refactor. See `.cdd/iterations/cross-repo/cnos/coherence-audit-request/`.
