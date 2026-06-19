# Sequential dispatch model — δ dispatches all roles

## Trigger

Cycle #309 (nested γ→α/β) produced no visible output to δ, γ session SIGTERM'd mid-α with no recovery. Cycle #84 confirmed the sequential model works.

## What happened

### Nested model (cycle #309 first attempt)
- δ dispatched γ via `claude -p`
- γ internally dispatched α via `claude -p` — nested subprocess
- No output visible to δ; monitoring required process inspection
- γ session SIGTERM'd, killing the in-flight α
- No recovery path without restarting the entire chain

### Sequential model (cycle #309 second attempt + cycle #84)
- δ acts as γ+δ: dispatches α directly, then β
- One `claude -p` at a time
- Direct visibility into each session
- Failure isolation: if α dies, retry α without losing state

### Refined sequential model (cycle #84 second half)
- δ dispatches γ first (γ produces prompts, creates branch)
- δ dispatches α with γ's prompt
- δ dispatches β with γ's prompt
- Each role gets the same minimal prompt shape:
  ```
  You are {role}. Project: cnos.
  Load {role}/SKILL.md and follow its load order.
  Issue: gh issue view N --json title,body,state,comments
  ```

## Evidence

1. **Nested γ is fragile**: 2+ concurrent `claude -p` processes on 2GB VPS; SIGTERM cascades; no output channel to δ
2. **Sequential works**: cycles #309 and #84 both completed successfully with δ dispatching directly
3. **Minimal prompts work**: role skills contain all instructions; prompt just points to skill + issue
4. **Operator confirmed**: "later the dispatcher will be completely mechanical — another reason to do it this way"

## Decision

γ produces prompts. δ executes dispatch. One role at a time. This is now codified in:
- `gamma/SKILL.md` — description, core principle, dispatch flow, prompt templates
- `operator/SKILL.md` — algorithm, dispatch sections, lifecycle table

Commit: `9ea257f6`

## Implications for #295

`cn dispatch` should implement this exact model:
1. Run γ → get prompts
2. Run α → verify artifacts
3. Run β → verify merge
4. δ holds gates (tag, release, cleanup)

No concurrent dispatch. No nested subprocesses. One role at a time.
