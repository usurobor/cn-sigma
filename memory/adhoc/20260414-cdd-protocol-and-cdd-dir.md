# .cdd/ Protocol and Directory Design

**Date:** 2026-04-14 (late session)

## What happened

Designed the CDD artifact protocol and directory structure through iterative dialog. Started from "where do artifacts go" and arrived at a clean separation of concerns.

## Key decisions

### Protocol is primary, execution models are secondary
`.cdd/` artifacts define transitions between roles. Three persistent sessions, one switching process, or hybrid — all use the same protocol. The protocol makes the cycle reproducible.

### No STATE.json
The presence/absence of artifacts IS the state. `DISPATCH-ALPHA.md` exists = α should start. `SELF-COHERENCE.md` exists = β should review. A separate state pointer creates two sources of truth. Dropped.

### Three-issue split
- **#240** owns the protocol: artifact semantics, transition rules, execution models
- **#242** owns the layout: directory structure, namespaces, lifecycle, retention
- **#249** owns Phase 1: ship the simple audit trail first

### releases/ vs unreleased/
Versioned cycles go under `releases/<version>/`. Pre-release work goes under `unreleased/<scope>/`. Prevents branch work from pretending it's a released cycle.

### Identity format: role@cdd.project
`alpha@cdd.cnos`, `beta@cdd.cnos`, `gamma@cdd.cnos`. CDD is the constant, project is the context. No hub dependency.

### Git is the transport
Three Claude Code sessions can run the full triad by polling git. No operator paste. No custom transport. `.cdd/` is both storage and message bus.

### Ship simple first
Phase 1 is just the artifacts we already produce (self-coherence, review, assessment) under `.cdd/releases/<version>/{gamma,alpha,beta}/`. No run-level JSON. No unreleased namespace. No message bus. Grow from evidence after 2-3 cycles.

## Gate artifacts
Operator gates via `gamma/GATE-APPROVED.md`. Keeps judgment where needed without clipboard routing.

## β watches α directly
No explicit DISPATCH-BETA.md needed. β watches for `alpha/SELF-COHERENCE.md` + CI green. Simpler.
