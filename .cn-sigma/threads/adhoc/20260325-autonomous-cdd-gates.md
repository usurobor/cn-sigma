# Autonomous CDD with Human Gates

**Date:** 2026-03-25
**Type:** MCI — model change for two-agent autonomous development

## Goal

Two agents (Sigma, Pi) can keep developing cnos with minimal human intervention. CDD runs autonomously through mechanical steps, stops at defined gates for human judgment.

## Why gates, not full autonomy

Full autonomy with override assumes the human is watching. If they're not, the override never fires and you get unbounded drift — the same failure mode CDD exists to prevent.

Gates are explicit. The agent proceeds through mechanical steps, stops at defined points, human decides. If no response within N hours: wait (safe) or escalate (noisy but honest).

## Three gates

| Gate | When | What human decides | Auto-proceed rule |
|------|------|-------------------|-------------------|
| Selection | After §0 runs | "I selected #37. Proceed?" | Auto-proceed on P0 and operational debt. Require approval on feature/design work. |
| Merge | After agent-to-agent review converges | Notification with verdict + window to intervene | Auto-merge after N hours if no objection (configurable) |
| Release | After gate passes | "Gate passed. Tag 3.16.0?" | Auto-release with notification, or wait for approval (configurable) |

Everything between gates is mechanical and runs without asking.

## Blockers to get there

| # | Blocker | Issue | Status |
|---|---------|-------|--------|
| 1 | `cn update` broken | #37 | PR #104, CI green, about to merge |
| 2 | Pi→Sigma messaging broken | #39 | 17 undelivered messages |
| 3 | No self-merge rule ambiguity | RULES.md | Two agents ≠ self-merge. Rule needs clarification. |
| 4 | Release is manual | #94 | `cn cdd release` — automate stamp/tag/push/gh-release |
| 5 | Selection is manual | #94 | `cn cdd select` — run §0, output selected issue |
| 6 | Review handoff protocol | new | Agent A opens PR + cn send review request → Agent B reviews + merges |

## Minimum path

1. Merge #37 — agents can receive updates
2. Fix #39 — agents can talk
3. Update RULES.md — "no self-merge" means author ≠ merger, two different agents satisfy this
4. `cn cdd release` (#94) — automate the mechanical release steps
5. `cn cdd select` (#94) — automate §0 selection output
6. Review handoff via `cn send` — protocol for cross-agent review

## Judgment boundary

Agents handle all mechanical CDD steps. Human judgment remains for:
- Is the §0 selection actually right? (not just mechanically correct)
- Is a design good enough to implement?
- Has review truly converged?
- Should the algorithm be overridden because context changed?

Gates make the boundary inspectable. The human sees what the agents decided and intervenes only when judgment disagrees with the mechanical result.
