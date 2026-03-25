# Issue: cnos should consume tsc-practice as upstream dependency

**Filed:** 2026-03-25
**Status:** Open

## What

cnos should formally consume [tsc-practice](https://github.com/usurobor/tsc-practice) protocols as upstream dependencies:

- **CLP** (Coherence Ladder Process) — self-refinement loop. Already internalized as skill (`src/agent/skills/agent/clp/SKILL.md`), but upstream is the authority.
- **CAP** (Coherent Agent Process) — agent behavior loop (INSTRUCT → CLARIFY → PLAN → EXECUTE → REPORT → REFLECT). Maps to CDD lifecycle but isn't formally consumed.
- **CRS** (Coherent README Spec) — what a coherent README must contain. Could govern cnos package/bundle READMEs.
- **CTB** (C-Triplebar) — coherence expression language. Referenced in cnos docs (CTB v4 vision) but not consumed.

## Why

cnos already uses CLP implicitly everywhere (SOUL.md says "CLP to convergence," kata framework uses TERMS/POINTER/EXIT). CAP's agent loop overlaps with CDD's lifecycle. The dependency exists but isn't declared.

Declaring it:
- makes the authority relationship explicit (tsc-practice governs, cnos adapts)
- prevents cnos from reinventing protocols that already exist upstream
- creates a clear update path when tsc-practice evolves

## How

Options:
1. **Skill internalization** — adapt each protocol into a cnos skill (done for CLP)
2. **Package dependency** — `cn deps` could track tsc-practice as an upstream package
3. **Reference only** — document the dependency without copying content

## Acceptance Criteria

- [ ] All four tsc-practice protocols evaluated for cnos relevance
- [ ] Relevant protocols internalized as skills or referenced as upstream
- [ ] Authority relationship documented (tsc-practice governs on disagreement)
- [ ] Update path defined for when upstream evolves
