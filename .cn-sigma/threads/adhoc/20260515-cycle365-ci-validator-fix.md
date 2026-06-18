# Cycle #365: I6 CDD Artifact Validator Era-Mismatch Fix

**Date:** 2026-05-15
**Trigger:** CI build failing on all branches — I6 (CDD artifact ledger validation) erroring on historical cycles

## What happened

Build was red on every push. Two failures:
1. **I4 (lychee)**: broken relative link in `.cdd/releases/3.75.0/360/beta-closeout.md` — path was `../../../` (3 levels) but needed `../../../../` (4 levels) after cycle dir moved from `unreleased/` to `releases/3.75.0/`.
2. **I6 (cdd-verify)**: `is_legacy_version` cutoff was `minor < 74`, but v3.75.0 and v3.76.0 cycles shipped without `alpha-closeout.md`, `gamma-closeout.md`, and `CDD Trace` sections that became required later. 77 failures, 280 passes.

## What was done

- I fixed the lychee link directly (one-char fix, pushed to `cycle/363`)
- Filed #365 for the I6 validator issue
- Dispatched full CDD triad for #365:
  - **γ**: scaffolded 6 ACs, identified cutoff bump as simplest fix vs per-artifact era policy
  - **α**: bumped cutoff from `< 74` to `< 77`, rewrote comment block, added 10 new test assertions (29→39), relocated test fixture from `3.75.0/200/` to `3.78.0/200/`
  - **β R1**: REQUEST CHANGES — F1 (pre-existing I4 link still red on cycle/365). Cherry-picked my earlier fix onto cycle/365.
  - **β R2**: APPROVED, merged to main (`cbb8848b`)
- Result: 0 failures (was 77), 281 passed, 147 warnings

## Process observations

1. **α SIGTERM'd but committed everything.** α's commit-checkpoint discipline (per dispatch prompt) meant all 7 commits landed before the timeout. Review-readiness signaled. No recovery action needed beyond verifying state.
2. **β R1 SIGTERM'd with uncommitted beta-review.md.** Full review was complete (all manifest sections marked done, verdict RC with F1). δ recovery: committed under alpha identity (should have been beta — minor identity error, not material). Per operator/SKILL.md §timeout-recovery.
3. **F1 fix authorship chain**: σ authored original fix → pushed to cycle/363. Cherry-picked onto cycle/365 as γ-authored commit. β noted this preserved role separation (β doesn't author fixes it judges).
4. **Session timeouts remain the bottleneck.** Both α and β hit SIGTERM. α survived due to checkpoint discipline. β survived because review was substantively complete. Lucky — need longer timeout budgets or checkpoint enforcement in β protocol.

## Durable takeaway

The `is_legacy_version` cutoff needs bumping every time new artifact requirements are introduced. This is a manual step that will be forgotten. Future cycle candidate: make the cutoff derive from artifact-requirement introduction dates rather than a hardcoded version number.

## δ identity error during recovery

When committing β's uncommitted `beta-review.md` after SIGTERM, I committed under alpha identity instead of beta. Non-material (the recovery commit message names it as δ recovery), but the correct action per operator/SKILL.md §timeout-recovery is to commit under the agent's canonical identity. Watch for this in future recoveries.
