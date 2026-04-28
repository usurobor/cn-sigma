# SOUL as CTB Skill Signature

**Date:** 2026-04-28
**Issue:** #284
**Status:** Filed, pending γ dispatch for triadic cycle

## What happened

During discussion of #283 (replacing GH PRs with `.cdd/unreleased/{N}/` artifacts), the CTB language spec was loaded to connect it to the SOUL implementation. The mapping turned out to be direct and complete:

- Every structural element CTB LANGUAGE-SPEC v0.1 names (module identity, governing question, inputs/outputs, scope, visibility, invariants, authority hierarchy, global aspects) is present in the SOUL — as prose.
- None of it is structured, declared, or checkable.

The SOUL is the agent's **activation context** — the environment every skill loads into. CTB's scope model (§3) maps to the SOUL's authority constraints. CTB's "no upward mutation" (§8.4) maps to the SOUL's continuity rule (§3.6). CTB's global aspects (§7) map to the SOUL's invariants (§3).

## Key observation

The SOUL is not "like" a CTB module. It IS one — the language just hasn't caught up to the practice. The frontmatter migration is mechanical; every field already exists in prose.

## Connection to #277

Issue #277 (SOUL.md rewrite to skill form with UIE-V agent loop) is the content rewrite. #284 is the structural bridge to CTB. They're complementary:
- #277 = what the SOUL says (content, UIE-V loop)
- #284 = how the SOUL is expressed (CTB signature, frontmatter, aspect declaration)

Both may converge into one implementation cycle.

## What to watch

- Whether `soul` needs to be a new `artifact_class` or fits under existing classes
- Whether the SOUL-as-global-aspect model works when multiple packages are loaded (SEMANTICS-NOTES §12 open question)
- How invariant structuring interacts with the prose → `.coh` migration path
