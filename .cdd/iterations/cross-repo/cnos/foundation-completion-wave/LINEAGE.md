# Cross-Repo Lineage: cn-sigma → cnos (foundation-completion-wave)

## Source

- **Repo:** `usurobor/cn-sigma`
- **Branch:** `main` (per operator preference established with prior bundles; wave master carried on cn-sigma main).
- **Path:** `.cdd/iterations/cross-repo/cnos/foundation-completion-wave/`
- **Filing kind:** wave master tracker (not a cell-scope proposal).
- **Source posture:** cn-sigma is an agent hub; κ (Sigma at cn-sigma) authors the wave master because κ is the human-interface role that has been observing substrate-vs-foundation asymmetry and has been asked by operator to formalize the priority as a filed wave.

## Upstream — what drives this wave

Operator asked κ two questions on 2026-07-04:

1. "How would you characterize the last two months' rate of progress?"
2. "Explain why the next steps must be iterating on foundation."

κ answered both. Operator directed: capture as adhoc, then file the wave. This bundle is the second half of that directive.

Full priority reasoning at `cn-sigma:.cn-sigma/threads/adhoc/20260704-foundation-completion-priority.md`. Grounded in essay v5 §12 governance framing (`cn-sigma:.cn-sigma/threads/adhoc/20260703-coherent-llms-essay.md`).

## Target

- **Repo:** `usurobor/cnos`
- **Issue type:** master wave tracker; not a single cell.
- **Suggested labels:** `P1`, `area/cdd`, `area/cds`, `area/agent`, `kind/process`.
- **Disposition:** pending (filled at acceptance by cnos γ on next wake).
- **Canonical mirror expected on cnos:** `cnos:.cdd/iterations/cross-repo/cn-sigma/foundation-completion-wave/`.

## Sub-bundle enumeration (all being filed simultaneously)

Per operator directive ("Create master issue for the wave and subissues linked to it"), the wave master + three sub bundles are being filed as one session:

| Sub | Bundle path | Filing kind | Independence |
|---|---|---|---|
| Sub 1 | `cn-sigma:.cdd/iterations/cross-repo/cnos/kappa-session-preflight/` | design-and-build cell | Independent of Step 6; can dispatch when cnos#501 (κ skill) dispatches |
| Sub 2 | `cn-sigma:.cdd/iterations/cross-repo/cnos/reflect-rN-wake-family/` | design-and-build cell | Design-locked now; body completion depends on cnos#444 cohere landing |
| Sub 3 | `cn-sigma:.cdd/iterations/cross-repo/cnos/human-touchpoint-protocol-wave/` | nested wave master | Depends on cnos#569 FSM Phase 2 for state-observation surface |

Operator explicitly authorized parallel sub-filing this session. OPERATOR.md §1 default is sequential filing; operator override cited as authorization.

## Why a wave master, not a single mega-cell

Per OPERATOR.md §1.1 five-factor sizing check:

- **New code surface count:** multiple (κ preflight script + wake orchestrators + task skills + optional cnos.cds overlay). *Positive signal.*
- **Cross-module breadth:** yes — cnos.core (kappa + human-touchpoint generic + reflect-rN orchestrators) + cnos.cds (human-gates overlay) + cnos#524 schema extension. *Positive signal.*
- **Lifecycle phase span:** yes — dispatch (κ), review (β on wake schema), release (v3.83.0 gate). *Positive signal.*
- **Design stability:** high (grounded in essay v5 + captured adhocs + cnos#524 W1 shipped schema). *Not a split signal.*
- **Sub independence:** Sub 1 fully independent; Sub 2 design-lockable; Sub 3 depends on cnos#569. *Split signal for parallel filing since Sub 1 is independent.*

Three positive + one split = wave shape, not mega-cell.

## Bilateral trace

When cnos accepts this wave master:
- cnos-side mirror expected at `cnos:.cdd/iterations/cross-repo/cn-sigma/foundation-completion-wave/`.
- STATUS advances via ledger events (submitted → accepted → landed).
- Each sub bundle's LINEAGE.md links back here.
- Sub bundle STATUS ledgers close independently; wave master STATUS closes when WAC1–WAC6 all met.

## Wave-shape coherence check (per essay v5 §5 CM²)

Applying the essay's own coherence loop to this wave's shape:

- **α pattern:** stable — wave shape follows OPERATOR.md §1; sub decomposition follows §2 b-lite extraction pattern; bundle form follows established precedent.
- **β relation:** strong — each sub cross-references relevant cnos existing issues (444, 449, 450, 501, 524, 569, 570); each sub declares which cnos package it lives in with correct boundary respect (cdd cell mechanics unchanged; cds owns software overlay; core owns κ + memory + human-touchpoint generic).
- **γ process:** strong — closure conditions specified per sub; parallel filing authorized by operator; nested-wave-inside-Sub-3 pattern preserves future evolution path; v3.83.0 release notes drafted-not-tagged prevents forced-tag under partial completion.
- **Bottleneck:** none blocking. Weakest axis is β on Sub 2's cohere dependency — Sub 2 can design-lock but cannot ship without cnos#444 landing. Named explicitly in Sub 2 handoff checklist.
- **Commit-with-receipt:** the bundle IS the receipt; STATUS advances on each lifecycle event.

The wave itself is coherent per its own framing essay. That is the intended demonstration.
