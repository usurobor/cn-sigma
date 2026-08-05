# Adhoc: eng/ Skills Expansion

**Date:** 2026-02-20
**Context:** Reviewed WIP OCaml code, extracted patterns into skills

## What

Added/updated 4 skills in `cnos/src/agent/skills/eng/`:

| Skill | Status | Lines | Purpose |
|-------|--------|-------|---------|
| `functional` | NEW | ~120 | FP paradigm: purity, composition, types |
| `coherent` | NEW | ~130 | Alignment: internal + external consistency |
| `coding` | UPDATED | +30 | Added §4.4-4.7 boundary patterns |
| `ocaml` | UPDATED | +15 | Added patterns from WIP review |

## Why

Three concerns were conflated or missing:

1. **OCaml** was language-specific (tooling, dune, conventions) but mixed in paradigm advice
2. **Coding** was defensive patterns but lacked subprocess/external call hardening
3. **Functional** didn't exist — FP principles apply to any language, not just OCaml
4. **Coherent** didn't exist — alignment is orthogonal to both correctness and style

## Decisions

### Orthogonality

| Concern | Skill | Applies to |
|---------|-------|------------|
| Paradigm | functional | Any language |
| Language | ocaml | OCaml specifically |
| Correctness | coding | Any code |
| Alignment | coherent | Any output |

### Placement

`coherent` in `eng/` not `agent/` because:
- Applies to code, docs, designs — not just agent behavior
- `agent/self-cohere` is about wiring, not the general principle
- eng/ skills are about *producing outputs*; agent/ skills are about *being an agent*

### Model

`coherent` follows `documenting` structure:
1. Core Principle
2. Define (parts, failure modes)
3. Unfold (levels, verification)
4. Rules
5. Checklist
6. Modes/Anti-patterns

## Open Questions

- Does `coherent` overlap with `coding` §1 (types constrain values)?
- Should `functional` include monadic patterns or keep it simple?
- CLP thread with Pi initiated — awaiting feedback

## Commits

```
e391f6d skills(eng): add functional skill, update coding + ocaml with WIP patterns
f08c828 skills(eng): add coherent skill — internal consistency + external alignment
```
