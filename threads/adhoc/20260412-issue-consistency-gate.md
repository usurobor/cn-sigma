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

## What changed (MCA)

- `cdd/issue/SKILL.md` §2.6: pre-publish consistency gate (3 checks)
  - Scope nouns check: every noun in work/ACs is in-scope XOR out-of-scope
  - Dependency check: parallelism claims verified against done-when references
  - Definition vs body: opening summary matches what ACs verify
- Gate is mandatory, not advisory

## What to watch for

- This gate applies to any issue with scope boundaries (3+ ACs, explicit non-goals)
- Simpler issues (bug reports, single-AC fixes) don't need the full gate
- The gate should catch contradictions mechanically — if it doesn't, the checks need sharpening
