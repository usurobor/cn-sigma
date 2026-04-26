# CTB Language Spec v0.1 — first normative spec

**Date:** 2026-04-26
**Thread type:** milestone

## What shipped

Three documents landed on cnos main (`7c04eebd`):

1. **`docs/alpha/ctb/LANGUAGE-SPEC.md`** (v0.1, draft-normative) — 513 lines. The normative reference for skill modules: signatures, scope, dispatch, composition, effect-plan boundary.
2. **`docs/alpha/ctb/SEMANTICS-NOTES.md`** — 216 lines. Non-normative conceptual rationale behind the spec decisions.
3. **`docs/alpha/ctb/README.md`** — updated document map with authority rules across Vision/Spec/Notes/kernel.

Plus the first concrete `calls_dynamic` migration: `alpha/SKILL.md` frontmatter now declares `calls_dynamic` sourced from `issue.tier2_bundles` and `issue.tier3_skills`, replacing the prose "Tier 2 and Tier 3 skills named by the issue."

## Key design decisions

- **Skill = module + callable signature** (not function, not class). Module gives you authority/ownership; signature gives you dispatch/inspection. Both halves matter.
- **`calls` (static) + `calls_dynamic` (dynamic)** — the split that makes the call graph inspectable while allowing runtime-flexible dispatch. Every runtime target must be reachable through either a static edge or a declared dynamic source. Undeclared dispatch is a violation.
- **Scope is first-class** (`global`, `role-local`, `task-local`). Authority needs a region. Without explicit scope, "this rule applies here" degrades to "wherever the runtime happens to load it."
- **No upward mutation** (§8.4). Lower scope returns; it does not push. The CDD triad's role-boundary violations are exactly this shape.
- **Plan as data** (§9). Skills are pure; they return effect plans; a separate runtime executes under capability grants. This is the load-bearing property for multi-agent trust.
- **Composition, not inheritance** (§6). Composition is the only model consistent with one-owner-per-fact. Inheritance creates implicit coupling and two homes for one rule.
- **Global aspects** (§7) for cross-cutting concerns that no single skill owns. One owning document, no restatement.

## Sigma's assessment

Solid v0.1. The three docs are properly separated by concern. The spec makes the right bets. Two pressure points identified:

1. **Typed contract grammar for `inputs`/`outputs`** — currently prose lists, not enforceable by a loader. This is the single biggest gap between ambition and enforceability.
2. **Cross-package aspect precedence** — §7 works within cnos.cdd but the rule for overlapping aspects across packages is undefined.

Both are tracked in **#275** (CTB Language Spec v0.2: typed contract grammar + cross-package aspect precedence), filed as P2.

## Authority chain

- Vision (`CTB-v4.0.0-VISION.md`) governs strategy
- Spec (`LANGUAGE-SPEC.md`) governs language semantics
- Notes (`SEMANTICS-NOTES.md`) preserves reasoning, never governs
- Kernel `.coh` spec governs terms and evaluation (future)

If Vision and Spec disagree on language semantics, Spec governs. If Spec and kernel disagree on terms, kernel governs.
