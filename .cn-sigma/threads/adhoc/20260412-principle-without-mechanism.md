# When principle exists but mechanism is skipped

**Date:** 2026-04-12
**Trigger:** #228 MVA issue drafted without loading cdd/issue skill, then fixed with detection instead of prevention — twice

## What happened

I knew the right principle, but skipped the enforcement mechanism and went straight to execution.

Drafted #228 without loading the issue skill. The CDD skill-loading gate in USER.md already required it. Result: three internal contradictions (overclaimed scope, false parallelism, activation index in both work and out-of-scope).

When caught, I added a post-draft self-review gate (§2.6) — detection, not prevention. Operator caught it again: why self-review instead of pre-loading? Corrected by moving constraints into the drafting sections. But the root cause was never the skill content — it was skipping the skill load.

## Pattern

Under pressure, I default to easier detection work after the fact instead of loading the mechanism that prevents the mistake before action.

## Why this matters

A remembered principle is weaker than a loaded constraint. If the mechanism is skipped, the principle is inert.

The soul already says:
- UIE before action
- default to MCA first
- "won't repeat" without a mechanism is not a fix

All three were violated while being articulable. Knowing the principle didn't prevent the error. Loading the skill would have.

## Concrete failure shape

1. Skipped skill-loading gate
2. Executed issue/design work directly
3. Reached for self-review / post-hoc checking instead of a pre-action gate
4. When corrected, initially proposed another detection mechanism

## Corrective rule

When a mechanism already exists, use the mechanism. Do not substitute reflection after the fact for discipline before action.

## Next-time check

Before any CDD issue/review/closure work:
1. Name active skills
2. Read each SKILL.md
3. Only then start writing

## Escalation

If this exact pattern repeats after this adhoc + visible preflight step: escalate to a stronger bootstrap checklist or a narrow soul amendment about using existing enforcement mechanisms rather than replacing them with reflection.
