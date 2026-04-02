# CDD Artifact Templates Completed

**Date:** 2026-04-02
**Trigger:** Gap analysis showed CDD §5.3 master table had steps without format specs.

## What shipped

All CDD artifacts now have canonical templates:

| Artifact | Template | Status |
|----------|----------|--------|
| PR body | `.github/PULL_REQUEST_TEMPLATE.md` | new |
| Issue | `.github/ISSUE_TEMPLATE/cdd-issue.md` | new |
| Self-coherence | `docs/gamma/cdd/SELF-COHERENCE-TEMPLATE.md` | new |
| Plan | `docs/gamma/cdd/PLAN-TEMPLATE.md` | new |
| Design | design/SKILL.md §3.1 | already existed |
| Review | review/SKILL.md output format | already existed |
| Release | CHANGELOG.md ledger + release/SKILL.md | already existed |
| Post-release | post-release/SKILL.md output template | already existed |
| CDD Trace | CDD.md §5.4 | already existed |

## Key design decisions

- Self-coherence uses Terms/Pointer/Exit (CLP) + triadic /4 scoring + mandatory weakest-axis action
- Plan template has Sequencing Principle (why this order) and Risks (what forces replan)
- Issue template includes Scope (work shape, estimated level, suggested active skills) so implementer can start §2.4 from the issue
- All templates share the CDD header: Issue/Version/Mode/Active Skills

## Process debt

7 direct-to-main commits on CDD since 3.27.0 tag. §3.7 retro-review not yet filed. 3.27.0 post-release assessment not done.
