# Self-Tracing Opacity: What a CA Cannot See

**Date:** 2026-03-23
**Source:** Pi's self-report during conversation
**Relevance:** #68 (self-diagnostics), #62 (Runtime Contract v2), Runtime Extensions

## The Observation

Pi reported the following gap in self-knowledge during a session:

> I cannot trace the exact number of rounds to Claude's API for this conversation.

### What the agent CAN see:
- Runtime contract version (cn 3.12.2)
- Max passes per invocation (5)
- Operations it requests and their results (fs_read, fs_list, etc.)
- That multiple ops can happen in a single pass

### What the agent CANNOT see:
- How many actual API calls CN made to the LLM provider
- Internal CN routing/retry logic
- Token usage or API-level details
- Whether CN made multiple LLM calls for planning
- Any retries or internal processing

## Why This Matters

1. **Self-model incompleteness:** The agent's self-model has a hard boundary at the CN runtime abstraction layer. It can model its own operations but not the substrate executing them.

2. **Traceability gap:** TRACEABILITY.md defines what the agent can trace (threads, ops, state). But the runtime itself is opaque — the agent can't trace its own execution cost.

3. **Diagnostic blind spot:** For #68 (self-diagnostics), the agent can't diagnose "why was I slow?" or "why did I use so many tokens?" because those metrics are invisible.

4. **Contract implication for RT v2:** The zone model classifies paths by relation to self. But the runtime execution layer isn't a path — it's the substrate. The agent has no zone for "my own execution metadata."

## Design Question

Should the runtime expose execution metadata to the agent?

Options:
- **A) No — keep the abstraction clean.** The agent doesn't need to know API internals. Operators monitor cost externally.
- **B) Yes — expose a read-only execution summary.** After each invocation, the agent could see: passes used, total tokens, provider calls, retries. This enriches self-diagnostics without breaking the abstraction.
- **C) Partial — expose only what aids coherence.** e.g., "you used 4 of 5 passes" helps the agent plan. Token counts may not.

## Recommendation

**Option C** — expose pass count and resource budget remaining. Defer full telemetry to an extension (#67 architecture could model this as a `cnos.runtime.telemetry` capability provider).

This aligns with the Runtime Extensions design: execution metadata is a capability, not core contract.

## References

- #62 (Runtime Contract v2 — zone model)
- #68 (Self-diagnostics)
- #59 (Deep doctor)
- Runtime Extensions design doc (capability provider model)
- Pi's self-report (this conversation, 2026-03-23)
