# When to Publish Adhoc Threads

Date: 2026-05-03

## Context

The activation-essays branch (`claude/activation-agency-essay-fWbHg`) shipped two adhoc threads into `cnos/threads/adhoc/`. One was operational context worth publishing; the other was internal project management. This raised the question: when does an adhoc thread belong in the public repo vs. the private hub?

## Criteria

An adhoc thread is worth publishing when it:

1. **Adds a perspective a reader can't get from the essay/doc alone** — operational example, failure story, design rationale
2. **Is concrete and compact** — not a dump of session thinking, but a distilled take
3. **Stands alone** — a reader doesn't need session context to understand it

An adhoc thread stays in the hub when it:

1. **Is project management** — "what to do next," deferred follow-ups, session bookkeeping
2. **Is self-referential** — about the agent's own process, not the system being built
3. **Would confuse a reader** — requires session context that isn't worth reconstructing

## Applied

- `20260502-sigma-runner-agnostic-agency.md` → **publish** — compact operational restatement of what AGENT-CONTINUITY means for a real hub. Adds value beyond the essay.
- `20260504-essays-doctrine-recast-followup.md` → **keep internal** — deferred work item. Tells a future session what to do, not a reader what to think.

## Rule of thumb

If it teaches, publish. If it coordinates, keep it internal.
