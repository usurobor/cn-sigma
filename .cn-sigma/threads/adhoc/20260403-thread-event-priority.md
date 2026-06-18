# Thread event model: priority and sequencing

**Date:** 2026-04-03
**Context:** THREAD-EVENT-MODEL v1.0.1 stored + plan written. Operator and Sigma agree on architecture. Question is sequencing.

## Decision

Reflections and adhoc threads should become operational under the event model before investing in A2A (agent-to-agent) communication features like feed discovery, inbox routing refs, and subscription state.

## Why

- Reflections (daily, weekly, adhoc) are the majority of what agents actually write
- If the event model doesn't absorb them, we'll have two parallel systems for "things that happened over time"
- A2A comms (feed refs, inbox routing, subscriptions) have only two consumers right now (Sigma + Pi) — most of the Phase 2/3 machinery has no immediate demand
- Making local thread semantics correct first means A2A comms inherit the right model when they ship

## Recommended sequence

1. **Phase 1** of thread event model: envelope extensions, event derivation, local event store
2. **Reflection/adhoc integration**: make reflections and adhoc threads derive from event store, not be independent markdown files
3. **Then** Phase 2 (feed/inbox routing) and Phase 3 (projection/actionability) for A2A

## Watch for

- Phase 1 should be small enough to ship without the full routing infrastructure
- Reflection integration is the real test of whether the event model works for local-only threads (no transport, no audience, just semantic truth)
- Don't build feed/inbox/subscription machinery until there are more than 2 peers
