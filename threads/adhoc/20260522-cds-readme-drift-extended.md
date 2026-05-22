# CDS README Drift — Extended — 2026-05-22

## Context

[[20260522-cds-readme-status-drift]] caught the load-bearing status drift in `src/packages/cnos.cds/README.md` after cycle/407: README still says `CDS.md` is pending while SKILL.md loads it as Step 1. This adhoc extends that finding with two additional drift surfaces in the same file and one related observation about adjacent state.

## Additional drift surfaces

### Structural taxonomy drift (§"Forthcoming surfaces")

README §"Forthcoming surfaces" (L28–34) still lists `CDS.md` under that section header:

```text
### Forthcoming surfaces
- **`skills/cds/CDS.md`** — the six-field software instantiation contract. Shipped by Sub 2 of [cnos#403].
```

The bullet text says "Shipped by Sub 2" but the *section header* still classifies it as forthcoming. A reader scanning section headers (which is exactly what package READMEs are scanned for) will mis-classify CDS.md as not-yet-shipped.

**Fix:** move the `CDS.md` bullet out of §"Forthcoming surfaces" and into §"Package Structure" §`/skills/cds/`. The remaining forthcoming items (per-role overlays, empirical-anchor doc) keep that section legitimate.

### Quick Start ordering drift

README §"Quick Start" (L36–43) sequences:

```text
1. docs/extraction-map.md — Read the extraction map first.
2. skills/cds/SKILL.md — The loader skill.
3. cnos.cdd/skills/cdd/CDD.md — The CCNF spine.
4. COHERENCE-CELL-NORMAL-FORM.md and COHERENCE-CELL.md
5. schemas/cds/receipt.cue
```

Pre-#407 this ordering was correct: the extraction map was the load-bearing artifact and CDS.md did not yet exist. Post-#407, `CDS.md` is the canonical contract and the conflict rule in SKILL.md (§"Conflict rule") names it as governing. A new reader should hit CDS.md before the extraction map; the extraction map becomes navigation, not entrypoint.

**Fix:** lead Quick Start with `skills/cds/CDS.md`. Demote `docs/extraction-map.md` to step 2 or 3.

## Adjacent observation: `schemas/cds/` already shipped

The original drift adhoc treats `schemas/cds/` as adjacent context, but it is worth surfacing explicitly: `schemas/cds/` already carries a typed receipt surface — `receipt.cue`, `README.md`, `fixtures/valid-receipt.yaml`, and five counterfeit fixtures (actor-collision, evidence-missing, merge-precedes-verdict, mismatched-protocol-id, override-rewrite). The CDS.md Field 3 (γ close-out artifact) target is therefore *live*, not pending.

This is a positive missing fact in the bundle: Subs 3–5 do not need to wait on schema work. Whatever Sub 3/4/5 lands can write CDS receipts immediately against the existing `#CDSReceipt` shape.

## Adjacent observation: #404 sibling tracker

`#403` body explicitly relates this wave to `#404` (Tracker: extract inter-agent handoff/coordination protocol from cnos.cdd into its own package), which is gated on `cnos.cds` v0.1 landing. After #403 Subs 3–5 close and CDS v0.1 is credibly live, `#404` becomes dispatchable. The drift adhoc does not name this, but the README's "what comes next" implicit map is incomplete without it: the post-CDS queue is not empty.

## Coherence finding (composite)

The CDS package has three coherent normative surfaces (SKILL.md, CDS.md, schemas/cds/) and one drift surface (README.md) that misrepresents the package state in three distinct ways:

```text
status text   — says CDS.md pending; CDS.md is shipped
taxonomy      — classifies CDS.md as forthcoming-section item
quick start   — leads with map instead of contract
```

All three are P3 hygiene individually. Composite, they are a coordination-cost surface: the README is the first read for humans and agents, and three independent stale claims in the same file produce more re-checking per cycle than one. The original adhoc was right to treat this as preventive coherence work for Sub 3 preflight; the three drifts should be patched in the same pass, not iteratively.

## Suggested action

Single status-hygiene PR (no cycle, no β):

```text
- README.md: rewrite §Status, §Forthcoming surfaces, §Quick Start, §Package Structure
- delete the "Pending Sub 2" / "Does not call CDS.md yet" lines
- promote CDS.md to first-class structural placement
- demote extraction-map to navigation role
```

Or fold into the Sub 3 cycle preflight as a zero-cost gamma scaffold edit. Either is fine; reopening #407 is not.

## Priority

P3 / hygiene composite. Same priority as the original drift; bundling these saves a second sweep.

## Cross-refs

- [[20260522-cds-readme-status-drift]] — original finding (status text drift)
- [[20260522-cnos-cds-extraction-wave]] — package-level state summary
- [[20260522-cnos-unreleased-wave-cadence]] — adjacent operational finding (deps still on 3.81.0; CDS not reachable from hub until release stamps)
