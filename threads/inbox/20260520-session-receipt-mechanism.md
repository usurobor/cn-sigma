---
captured: 2026-05-20
from: sigma (current session)
to: sigma (future session)
status: inbox — not processed
trigger: operator question "how to maintain coherence across LLM platforms?" after observing today's reflection gap
tracked-by: cnos#386 (design issue filed 2026-05-20)
---

# Insight: session-receipt mechanism to replace voluntary reflection

## The capture

Current cross-platform coherence mechanism (write daily + adhocs at session end) fails structurally because it is **retrospective, voluntary, and unstructured**. Today demonstrated it: four decisions worth recording (cn-rho visibility, discipline placement, author identity, Edit-vs-git-apply); one made it into the daily as prose, three were buried in conversation transcript and then partially invalidated by a follow-up turn (visibility flipped to public 4 messages after I chose private — no durable trace of "why private then").

## The proposed shape (not designed, just sketched)

Two-part fix:

1. **In-line MCA receipts at decision time.** Every brief-allowed degree of freedom produces a ~5-line file the moment the decision lands: `{decision, options, chosen, reason, reversal-cost}`. Lives under `.cdd/session/<date>-<id>/decisions/` (or hub-side equivalent). Cheap (~30 sec each). No notice-after-the-fact required.

2. **Structured session-close gate, enforced like CDD δ close-out.** End of non-trivial session: forced checklist (`artifact_refs`, `debt_refs`, `decision_refs`, `learnings_refs`). Schema-validated. Daily becomes an index over receipts, not free prose.

Cross-platform discovery solves itself once content is structured: activation reads MEMORY.md (already loaded) + last N session receipts + daily index. No agent has to "remember to look."

## Why this matters beyond today

Same shape as cnos.cdr V (validator) per `ROLES.md §4a.3` — receipts with required refs that V rejects when fields are missing. CDD already proposed this for *cycle* receipts; the extension is "every session is a small cycle and produces a receipt." This is also the GTD principle the operator just invoked: capture-to-inbox at insight time, process later — applied to the agent's own reflection discipline.

## What I did NOT do

- Design the receipt schema
- Decide whether this is a cnos issue or a cn-sigma adhoc or a cnos.cdd skill extension
- Estimate the overhead-vs-recall tradeoff against real session counts
- Check whether the GTD pattern already has a partial implementation somewhere in cnos (it might — see `threads/adhoc/` indexes, MEMORY.md surface)

Those are processing-step questions. This file is the inbox capture, not the processed plan.

## Related (for the processing step)

- `cn-sigma:spec/PERSONA.md ## Memory discipline` — current write-trigger list (passive, voluntary)
- `cnos.cdd/skills/cdd/gamma/SKILL.md` close-out — structurally enforced receipt for CDD cycles
- `cnos:ROLES.md §4a.3` (on `claude/file-cnos-cdr-issue-fi9Ld`) — V (validator) rejecting receipts that fail schema
- `threads/adhoc/20260519-cross-repo-feedback-loop.md` — adjacent: "check before writing" applied to cross-repo proposals
- This session's daily `20260520.md` — concrete example of what's missing
