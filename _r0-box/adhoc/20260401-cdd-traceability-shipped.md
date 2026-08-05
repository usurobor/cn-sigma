# CDD Traceability Shipped

**Date:** 2026-04-01
**Trigger:** Skills not loaded, steps skipped, no audit trail during tsc release and cnos skill patches.

## What happened

During tsc v0.1.0/v0.1.1 release and cnos skill patches (active-skill matrix, CDD §2.4 bridge, design template), multiple CDD steps were skipped: no branch, no PR, no skill loading, no trace. Content was correct; process was wrong.

## What changed (MCA)

Five patches to existing CDD surfaces:
1. CDD.md §5.3: artifact manifest — step-to-evidence binding
2. CDD.md §5.4: CDD Trace — lightweight table in primary branch artifact
3. design/SKILL.md: trace in output template + §3.2 rule
4. review/SKILL.md: §2.0.8 verifies trace exists
5. release/SKILL.md: §2.9 trace update + writing skill load
6. post-release/SKILL.md: §6 CDD Closeout for steps 11–13

## Key insight

The trace model uses existing surfaces — no new standalone artifacts. One table per branch, rows added incrementally. Review verifies it. Release updates it. Post-release closes it.

## Next

Manual traceability is in place. Next move is automation (#94): cnos owns the CDD clock, agent owns judgment. Skills become specs for OCaml enforcement code.
