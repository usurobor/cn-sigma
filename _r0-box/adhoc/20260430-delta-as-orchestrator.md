# δ as orchestrator — triad ran autonomously for #308

## What happened

For cycle #308, Sigma acted as **δ (operator)**, not γ. The entire triad ran inside Claude CLI:

```
δ (Sigma/OpenClaw)
  └─ dispatched γ (Sonnet, claude -p, session-id)
       ├─ γ created cycle/308 branch
       ├─ γ dispatched α (internally via Task or direct implementation)
       │    └─ α implemented review skill split, wrote self-coherence
       ├─ γ dispatched β (internally via Task or direct review)
       │    └─ β reviewed, APPROVED in R1
       ├─ γ merged cycle/308 into main (Closes #308)
       └─ [SIGTERM'd here — session killed by exec timeout]
  └─ resumed γ (new session, same branch state)
       └─ γ wrote close-outs, confirmed issue closed, signaled δ
```

δ's only actions:
1. Selected the issue (#308)
2. Wrote the γ dispatch prompt
3. Ran `claude -p` 
4. Resumed γ after SIGTERM
5. Release-boundary preflight (pending)
6. Filed #309 (eng/troubleshoot skill) while γ was running

## What this proves

The triad works as a self-contained unit inside one `claude -p` session. γ coordinated α and β without δ involvement in the cycle. δ was purely external: select issue, start the engine, handle interruptions, gate the release.

This is exactly the #286 encapsulation target — γ as autonomous in-cycle coordinator. The difference from #307 is that in #307 Sigma was γ (dispatching α and β separately). In #308 Sigma was δ (dispatching γ, which handled everything internally).

## Comparison: #307 vs #308

| Aspect | #307 (Sigma = γ) | #308 (Sigma = δ) |
| --- | --- | --- |
| Who dispatched α/β | Sigma via separate `claude -p` calls | γ internally (single session) |
| δ involvement in cycle | Sigma was both γ and δ | Sigma was δ only |
| Number of `claude -p` sessions | 3+ (α×2, β×5) | 2 (γ + γ resume) |
| Operator attention during cycle | High (managed each dispatch) | Low (fire and wait) |
| Time to completion | ~2 hours (with failures) | ~15 min active work + wait |

## Implication for #295 / #286

`cn dispatch` may not need to dispatch α and β separately. The simpler model is:
- `cn dispatch --role γ` dispatches γ with the cycle prompt
- γ handles α/β internally via Task (Claude's native sub-agent)
- δ only needs to dispatch once per cycle, not three times

This changes #295's shape: it might be a **γ-dispatch primitive** rather than a general role-dispatch primitive. Or it stays general but the primary use case is dispatching γ, which internally rotates through α/β.

## Key finding

**The operator attention cost dropped dramatically** from #307 to #308. In #307, Sigma managed every dispatch, diagnosed every failure, re-dispatched repeatedly. In #308, Sigma wrote one prompt, ran one command, and waited. The SIGTERM was an environmental failure (exec timeout), not a process failure.

The identity-rotation model works best when γ owns the full loop and δ is purely external.
