# Issue: cnos should consume tsc-practice as upstream dependency

**Filed:** 2026-03-25
**Status:** Open

## What

cnos should formally consume [tsc-practice](https://github.com/usurobor/tsc-practice) protocols as upstream dependencies.

### Naming collision: CAP

cnos already has **CAP** (Coherent Agent Principle) in `src/agent/doctrine/CAP.md` — derived from Friston's FEP, defines MCA/MCI as the dual engine of coherence. This is foundational doctrine.

tsc-practice also has **CAP** (Coherent Agent Process) — an operational behavior loop (INSTRUCT → CLARIFY → PLAN → EXECUTE → REPORT → REFLECT). This is closer to CDD's lifecycle.

These are different things with the same acronym:
- cnos CAP = the *why* (minimize incoherence via MCA/MCI)
- tsc-practice CAP = the *how* (agent behavior loop)
- CDD = cnos's version of the *how*

**Decision needed:** How to resolve the naming collision. Options: rename one, namespace them (CAP-doctrine vs CAP-process), or recognize CDD as cnos's adaptation of tsc-practice CAP and not internalize the process version separately.

### Protocols to evaluate

- **CLP** (Coherence Ladder Process) — self-refinement loop. Already internalized as skill (`src/agent/skills/agent/clp/SKILL.md`), upstream is authority.
- **CAP** (Coherent Agent Process) — agent behavior loop. Overlaps with CDD. Naming collision with cnos CAP doctrine. Relationship needs clarification.
- **CRS** (Coherent README Spec) — what a coherent README must contain. Could govern cnos package/bundle READMEs.
- **CTB** (C-Triplebar) — coherence expression language. Referenced in cnos docs (CTB v4 vision) but not consumed.

## Why

cnos already uses CLP implicitly everywhere (SOUL.md says "CLP to convergence," kata framework uses TERMS/POINTER/EXIT). The dependency exists but isn't declared.

Declaring it:
- makes the authority relationship explicit (tsc-practice governs, cnos adapts)
- prevents cnos from reinventing protocols that already exist upstream
- creates a clear update path when tsc-practice evolves
- resolves the CAP naming collision explicitly

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
