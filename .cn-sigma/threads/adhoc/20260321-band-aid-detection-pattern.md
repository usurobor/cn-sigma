# Band-Aid Detection Pattern

**Date:** 2026-03-21
**From:** Sigma + usurobor
**Type:** engineering skill

---

## The Pattern

When each fix reveals the next fix, you're patching an architecture, not a bug.

## Detection Signal

> "The more we fix the more fixes we need."

If you can arrange your recent fixes in a causal chain — fix A exposed gap B, fix B exposed gap C — the root cause is structural. The fixes aren't wrong; they're locally correct patches to a globally incorrect design.

## The cnos Case Study

```
#41 Pass B not wired
 └→ #46 Shell execute not called in Pass B
     └→ #47 Pass A output projected when Pass B fails
         └→ #49 Agent confabulates instead of reading receipts
             └→ #48 Dead air during multi-pass cycles
```

Five fixes, each correct, each exposing the next. Root cause: hardcoded two-pass orchestrator couldn't express the actual problem (bounded N-pass observe/effect chaining).

## The Response

1. **Stop fixing.** The next band-aid will reveal another gap.
2. **Perform MCI.** What is the most critical issue? (Not the latest symptom — the structural constraint generating symptoms.)
3. **Identify MCA.** What's the smallest architectural intervention that eliminates the class of fixes, not just the current instance?
4. **Write the design first.** Amendment doc → implementation plan → tests → code. Not code → discover gaps → more code.
5. **Verify collapse.** The new design should make each band-aid in the chain structurally impossible, not just unnecessary.

## Verification Table Template

| Issue | Band-aid | Why it disappears under new design |
|-------|----------|------------------------------------|
| ... | ... | ... |

If you can't fill the "why it disappears" column with a structural reason (not "we handle it better"), the new design doesn't fully address the root.

## Key Distinction

- **Bug fix:** problem → fix → done.
- **Band-aid chain:** problem → fix → new problem → fix → new problem.
- **Architecture fix:** identify the constraint generating the chain → redesign → entire chain collapses.

The signal isn't that fixes are bad. The signal is that fixes keep revealing more fixes at the same architectural layer.
