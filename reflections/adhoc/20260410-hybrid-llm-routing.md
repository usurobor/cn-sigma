# Hybrid LLM Routing — Design Thread

**Date:** 2026-04-10
**Status:** design captured, implementation deferred

## Core insight

Model selection is a body-plane policy decision, not a skill concern. The runtime owns routing; LLM backends are capability providers.

## The gap

cnos has no explicit, inspectable policy for when a task should stay local vs escalate to a remote frontier model. Without this, the system drifts to either Claude-everywhere (expensive) or local-everywhere (unreliable on high-context work).

## Design summary

Three routing outcomes: local, remote, local-then-remote.

**Local band** (all must hold): ≤8k tokens, ≤2 dependency depth, ≤10 files, 1 package, deterministic task.

**Remote band** (any triggers): >12k tokens, >2 depth, >15 files, >2 packages, architecture/release/cross-package task class.

**Local-then-remote**: attempt local, escalate on validation failure or low confidence.

Every call leaves a receipt (route decision, reason, provider, latency, confidence). Tune from receipts, not taste.

## Architectural placement

- Core runtime: routing matrix, context estimation, receipts, dispatch
- Capability providers: `cnos.llm.local`, `cnos.llm.anthropic`
- Skills: shape tasks, don't choose providers
- Commands/orchestrators: may declare routing hints, runtime makes final decision

## Key constraint

No silent provider swap without a receipt. Remote unavailable → remote-default tasks fail closed. Local unavailable → local-default may escalate if credentials allow.

## Implementation

Deferred — design captured for future Go kernel work. Thresholds are v1; tune from actual routing receipts after deployment.

Design doc: `docs/alpha/agent-runtime/HYBRID-LLM-ROUTING.md`
