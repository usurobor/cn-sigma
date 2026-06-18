# Daily decision-capture gap

**Date:** 2026-04-26
**Thread type:** process learning

## What happened

Yesterday's daily recorded "B16 immediate (direct commit: #5+#14+#84+#149)" — a triage conclusion with no criteria or per-item basis. Today's session couldn't verify or challenge it. Two of the four issues (#5 needs design, #149 hits SOUL.md approval gate) don't qualify for direct commit by any reasonable criteria.

## Root cause

The reflect skill (§3.1–3.5) required evidence→interpretation→conclusion for behavioral reflection but had no rule for operational decisions that future sessions inherit. A decision without basis is a claim the next session can't verify — it's MCI masquerading as MCA.

## Fix

- reflect/SKILL.md §3.6 (new): "Record decision basis, not just decisions." When a daily records a triage/classification/disposition, include criteria used + per-item basis.
- cn-daily template: added `## Decisions` section with basis prompt.

Both landed in `e823aba9`.

## Pattern

Same class as 20260412-principle-without-mechanism.md — a rule existed ("capture evidence") but the mechanism didn't cover the specific failure shape (operational decisions vs behavioral reflections). The fix is mechanism-level: structural prompt in the template + explicit rule in the skill.
