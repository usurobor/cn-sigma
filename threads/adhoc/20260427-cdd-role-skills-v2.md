# CDD Role Skills — Iteration v2

Created: 2026-04-27
Status: review complete, pending landing

## What happened

usurobor wrote a v2 revision of the CDD role skills (β, γ) and adjacent patches (cdd/SKILL.md, post-release/SKILL.md). This addresses three findings from prior cycles:

1. **γ had a shadow algorithm** competing with CDD.md's canonical ordered lifecycle. v2 eliminates the duplicate: CDD.md owns order, γ skill owns execution detail only.
2. **γ's cycle-iteration loop was aspirational.** v2 adds trigger tables with fire conditions, required actions, and closure consequences. Closure is structurally blocked if outputs are missing.
3. **β taught by abstraction only.** v2 adds ❌/✅ pairs to each role rule.

## Adjacent patches

- `cdd/SKILL.md` — conflict rule now explicitly prevents role skills from redefining selection order or lifecycle steps
- `post-release/SKILL.md` — gains `§4b Cycle Iteration` template and pre-publish gate so γ step-11 verification has a real target artifact

## Open questions from review

- **Sizing boundaries:** γ §2.2 introduces `immediate-output / small-change / substantial` without defining the boundary. Needs a definition or a CDD.md ref.
- **Mechanical-overload floor:** trigger requires findings ≥ 10 AND mechanical ratio > 20%. A 4-finding all-mechanical cycle wouldn't trigger. Confirm intentional.
- **β dispatch precondition:** "unless explicitly being asked for an offline/non-merge review" is a prose escape hatch in an otherwise mechanical dispatch section. Named mode vs. judgment call?
- **α skill alignment:** α's skill wasn't revised. Confirm it already acknowledges CDD.md authority hierarchy or needs a matching patch.

## Also reviewed this session

- **Ethics for Agents** essay — companion to CFA, placed in `docs/alpha/doctrine/`. Core move: ethics = coherence disciplined by standing (the structural right of an affected boundary to count even when it can't inspect/contest/repair). Feedback: standing needs a sharper threshold test; priority ordering gestured at but not committed to; no examples yet.
