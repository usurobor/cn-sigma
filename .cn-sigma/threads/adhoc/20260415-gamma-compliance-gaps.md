# γ compliance gaps — 3.55.0 cycle

**Date:** 2026-04-15

## What happened

Two γ algorithm violations surfaced during the 3.55.0 cycle:

1. **Accepted "no tag cut" without challenge.** β said no release; γ agreed. But γ owns the cycle (step 9: "cycle closed when assessment committed"). No tag = no assessment = cycle stuck open. Operator had to escalate.

2. **Did not collect α close-out proactively.** α committed it (`d104e44`), γ only triaged when prompted. Step 6 says "collect close-outs from both α and β."

## Root cause

Application gap, not spec gap. The γ algorithm already covers both cases. γ deferred to β's judgment on a question γ owns (whether to release), and didn't enforce its own checklist.

## Fix

No new mechanism needed — the mechanism exists. `cn cdd-verify` now makes the gap visible mechanically. γ should run it before accepting any "cycle closed" claim.

## Connection

Same pattern as the "principle without mechanism" thread from 0412 — but inverted. Here the mechanism exists; the failure was not using it. The fix is: run `cn cdd-verify` as part of γ's step 9 verification.
