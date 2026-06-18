# Review SKILL.md Split

**Date:** 2026-04-29
**Context:** Review skill at 819 lines — too large for reliable LLM execution. User confirmed split into sub-skills.

## Analysis

Structure mapped:
- Frontmatter + Core Principle + Define (§1)
- Unfold §2.0.0: Contract Integrity Preflight (new, from #304)
- Unfold §2.0: Issue Contract
- Unfold §2.1: Diff Analysis
- Unfold §2.2: Context/Unchanged Siblings
- Unfold §2.3: Verdict
- Rules (§3)
- Checklist (§4)
- Severity (§5)
- Output Format (§6)
- After Review (§7)
- Kata (§8)

## Split approach

Natural sub-skills (~200 lines each):
1. **review/SKILL.md** — index, core principle, §1 Define, load order, cross-refs
2. **review/contract-preflight.md** — §2.0.0 (10 checks before diff review)
3. **review/issue-contract.md** — §2.0 issue contract verification
4. **review/diff-analysis.md** — §2.1 diff analysis pass
5. **review/context.md** — §2.2 context/unchanged siblings
6. **review/verdict.md** — §2.3 verdict + Rules §3 + Checklist §4 + Severity §5 + Output §6
7. **review/after-review.md** — §7 post-review actions
8. **review/kata.md** — §8 embedded katas

## Status

- Branch: `sigma/issue-skill-v2`
- User approved split
- Implementation pending (interrupted by γ dispatch work)

## Decision

"LLM friendly" = smaller chunks, clear cross-refs, each file self-contained enough to load independently. Index file tells β which sub-skills to load for which phase.
