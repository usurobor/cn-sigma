# Selection Divergence → CLP → Process Patch

**Date:** 2026-03-25
**Context:** Sigma and Claude ran CDD §3 selection independently on v3.17.0 post-release. Arrived at different answers.

## What happened

- Sigma selected #110 (P0 daemon restart) via §3.1 override
- Claude selected #73 Phase 2 (assessment commitment) via §3.3 default
- Claude correctly sized process debt as immediate output, not cycle gap
- Sigma short-circuited at §3.1 without checking whether the P0 was known at assessment time

## Principle

**When two agents run the same algorithm and don't converge, they must CLP until they do — and once they converge, they must update the process so the divergence cannot recur.**

Divergence is not a bug in one agent. It is a gap in the algorithm. If two competent agents can read the same spec and reach different conclusions, the spec is ambiguous. The fix is always a spec patch, not a "try harder next time."

## What was patched

CDD §3.1: new-vs-known P0 rule — known P0s weighed by the assessment are not overrides unless escalated.

CDD §3.2: sizing rule — size infrastructure debt before selecting as cycle gap. Minutes of work → immediate output, not a full cycle.

Both patches at `8f6ec4e`.

## Pattern

Divergence → CLP → convergence → process patch. This is how the method improves. The divergence is the signal, not the failure.
