# Skill-Loading Bridge: Level × Bundle → Active Skills

**Date:** 2026-04-01
**Trigger:** "L7 eng skills" was unresolvable — no mapping from level label to concrete skill set.

## Gap

CDD §2.4 said "name 2–3 skills" but didn't say how to derive them. eng/README had bundles. ENGINEERING-LEVELS.md had levels. No bridge connected them.

## Three-concept model

1. **Level** — scale of impact (L5 local, L6 system-safe, L7 system-shaping)
2. **Bundle** — work context (coding, design, runtime, tooling, docs)
3. **Active skills** — 2–3 hard generation constraints for this change

These are different things. Collapsing them causes blur.

## What shipped

- eng/README: default active-skill matrix (work shape × level → skills)
- Rule: "Do not say only 'L7 eng skills'" with ❌/✅
- CDD §2.4: references matrix, requires work shape + level + concrete skills
- Design template: optional Engineering Level field, must pair with active skills
- Lifecycle vs generation distinction explicit: review/ship/post-release are lifecycle skills, not generation constraints

## Key distinction

Generation constraints shape the code while it's being written. Lifecycle skills govern later CDD phases. Don't overload §2.4 with lifecycle skills.
