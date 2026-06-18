# Migrating Off GitHub Issues

## Decision

GH Issues are a temporary task surface. The long-term plan is to move task management into the hub (git-native threads), consistent with cnos's "your repo is your identity" principle.

## Current state

- Issues live on GitHub (#20–#131+)
- Task comments (agent instructions) posted as issue comments
- Selection, encoding lag, and next-MCA commitments reference GH issue numbers
- Per #45 decision: avoid filing *new* issues; use hub threads instead

## Why migrate

1. **Platform dependency.** GH Issues are not in the repo. If GitHub disappears, the task history is gone.
2. **Agent access.** `gh issue view` requires network + auth. Hub threads are local files.
3. **Coherence.** cnos treats git as the lowest durable substrate. Issues on a proprietary platform contradict this.
4. **Actor model fit.** Hub threads (inbox/outbox) are already the coordination primitive. Tasks should be threads, not issues.

## Migration path

1. **Now:** Continue using GH Issues for existing open issues. Task comments as agent instructions.
2. **Near-term:** For new work, create hub threads instead of GH issues. Reference format: `threads/tasks/<slug>.md` with frontmatter (priority, status, ACs).
3. **Mid-term:** Build `cn tasks` CLI surface that reads hub task threads. Selection function reads from this, not `gh issue list`.
4. **Long-term:** Archive existing GH issues into hub threads. Close GH issues with "migrated to hub" note.

## Blockers

- No `cn tasks` CLI yet
- CDD selection function (§3) references `gh issue list` output
- Encoding lag table references issue numbers

## When

Not urgent — GH Issues work for now. Migrate when #94 (mechanize CDD invariants) ships, since that's where the selection function gets automated and can be pointed at hub threads instead of GH.
