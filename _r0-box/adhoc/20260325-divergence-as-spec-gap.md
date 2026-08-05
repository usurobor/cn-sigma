# Divergence Is a Spec Gap, Not an Agent Bug

**Date:** 2026-03-25
**Status:** MCI — observation captured, not yet placed

## Pattern

When two agents run the same process and don't converge, the divergence is a signal that the spec is ambiguous. The fix is always a spec patch, not "try harder."

**Divergence → CLP → convergence → process patch.**

## Evidence from 2026-03-25

| Domain | Divergence | Patch |
|--------|-----------|-------|
| Skills | Both loaded, applied differently | CDD §4.4: name governing skills explicitly at step 5 |
| Review | 3 reviewers finding different things | §2.1.3 mechanical scan, §2.2.1a input enumeration |
| Selection | Two agents, same algo, different answer | §3.1 new-vs-known P0, §3.2 sizing rule |
| Design propagation | One proposed, other caught incomplete surfaces | Iterate until all surfaces agree |

## Scope

This is not a CDD-specific rule. It applies to any process two agents touch:
- review
- design
- selection
- release
- communication

It's a multi-agent operating principle.

## Placement question

Where should this live?

- **CDD rule** — too narrow, only governs CDD selection/lifecycle
- **SOUL.md** — possible, it's a behavioral invariant for how agents handle disagreement
- **Standalone governance doc** (e.g. `MULTI-AGENT.md`) — cleanest if multi-agent patterns accumulate
- **CDD + cross-reference** — add a CDD rule that points to a broader principle

Not yet decided. Capturing the MCI now so the observation isn't lost.
