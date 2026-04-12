# Issue Consistency Gate — Post-Mortem

**Date:** 2026-04-12
**Trigger:** Operator review of #228 (MVA sprint) found three internal contradictions

## What happened

I drafted #228 with correct parts (scope, ACs, steps, out-of-scope) but they contradicted each other:
1. Definition claimed "commands, skills, orchestrators" — orchestrator runtime was out of scope
2. Step 4 said "activation index" in work list — activation table was out of scope
3. "Step 4 can parallel step 3" — Step 4's command registry depends on Step 3 discovery

All three are the same error class: **sections written independently, never cross-checked.**

## Root cause

Not a knowledge gap — I knew what was in and out of scope. It's a review gap: I didn't re-read the issue as a single document before posting. The scope section and implementation section were treated as independent when they share nouns.

## First fix (wrong)

Added §2.6 as a post-draft "pre-publish consistency gate." Three self-review checks.

Operator caught: **why self-review instead of pre-loading?** The CDD skill-loading gate already requires loading the issue skill before drafting. If the constraints are in the skill, they shape the draft — no review needed. Post-draft review is detection. Pre-loaded constraints are prevention. Prevention > detection (SOUL.md).

Two actual failures:
1. I didn't load the issue skill before drafting #228 (violated BOOTSTRAP.md CDD gate)
2. Even after adding the fix, I put it in the wrong place — review instead of drafting

## What changed (MCA, corrected)

- Removed §2.6 (post-draft gate)
- Added §2.2.4: scope nouns check — while writing ACs/work items, every noun is in scope or doesn't appear
- Added §2.3.2: cross-check scope against definition immediately — part of writing the scope section, not a review step
- Added §2.3.3: parallelism claims require structural done-when verification while writing sprint structure

Constraints now shape the draft instead of reviewing it after.

## What to watch for

- The deeper failure was skipping skill-loading entirely. The gate in BOOTSTRAP.md already existed. Loading the skill is the prevention mechanism — the skill contents are the constraints.
- If this error class recurs, the question is: "did you load the skill?" not "did you self-review?"
