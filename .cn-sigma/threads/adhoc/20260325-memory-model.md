# Memory Model — Four-Layer Vertical

**Date:** 2026-03-25
**Type:** MCI — model refinement for #100 (memory as first-class retention faculty)

## The model

Four layers, each with a distinct purpose and authority:

### A. Traceability / receipts / conversation — What happened
- Authoritative operational history
- Machine-generated or runtime-managed
- receipts, artifacts, runtime state, traces, conversation persistence (`state/conversation.json`)
- Not reflection, not "memory writing style"
- This is the most authoritative "what happened"

### B. threads/adhoc/ — What we are thinking through
- Investigations, design reviews, incident notes
- Freeform case narratives, topic threads
- Temporary working memory
- Human/agent narrative — episodic, not distilled
- NOT "everything that happened" — that's layer A

### C. threads/reflections/daily|weekly|monthly/ — What we learned
- Distilled reflective synthesis
- Pattern extraction, model updates
- Promotion candidates identified
- Period-bounded (daily → weekly → monthly propagation)

### D. Skills / mindsets / doctrine — What became durable
- Promoted memory — no longer episodic
- Patterns that proved stable enough to encode
- The top of the memory ladder

## The rule

> Use traces for facts, adhoc for ongoing thought, reflections for distilled learning, and promotion for durable memory.

## Key distinction

"What happened" is split across three layers, not dumped into adhoc:
1. **Objective history** → traces/receipts/artifacts (layer A)
2. **Episodic narrative** → adhoc threads (layer B)
3. **Distilled learning** → reflections (layer C)

Adhoc is working memory. It is not the record of truth. Traces are.

## Doc inconsistency to fix

- AGENT-RUNTIME talks about daily → weekly → monthly reflection propagation
- Glossary names daily and weekly reflection paths + adhoc, but doesn't mention monthly in thread structure
- Formalize: update glossary/thread taxonomy to include monthly

## Implications for #100

Issue #100 (memory as first-class retention faculty) should encode this four-layer model:
- Recall searches layers A–C
- Write targets layer B (adhoc) or C (reflections) depending on content type
- Promotion from C → D is explicit and deliberate
- Layer A is not written by the memory faculty — it's written by the runtime
