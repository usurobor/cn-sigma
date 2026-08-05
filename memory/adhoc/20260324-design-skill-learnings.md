# Design Skill Learnings — What This Session Taught

**Date:** 2026-03-24
**Context:** Evening session shipped v3.14.7, reviewed PR #98, rewrote #94 and #22 design specs, and identified recurring design failures.

---

## The pattern that kept appearing

Across PR #98 review, #22 rewrite, #94 rewrite, and #37 diagnosis, the same failure mode surfaced repeatedly: **editing the node without following the edges**.

- PR #98: Updated CDD skill, didn't update canonical doc it declares as authoritative, didn't update post-release template that would consume the new metrics, didn't update review skill with the taxonomy it only implied.
- #22 original: I proposed "Option B: dune-project" without tracing what dune-project actually is (OCaml package metadata, wrong abstraction for system manifests, package manifests, lockfiles, tests, status). usurobor traced the full consumer graph and the design was strictly better in every dimension.
- #37 original: Described version comparison problem without diagnosing that CI doesn't upload assets at all — the download URL 404s regardless of version logic.
- #22 lockfile: I said "add package versioning to the lockfile" when the schema already has version/source/rev/subdir. The problem was population, not schema. I diagnosed a structural gap when it was a data gap.

## What the design skill was missing

The old design skill was a structural template: Problem → Constraints → Proposal → Alternatives → Open Questions. It said nothing about:

1. **Impact analysis** — tracing consumers/producers/copies of changed artifacts
2. **Judgment vs mechanism distinction** — knowing what can be enforced vs what requires reasoning
3. **Source-of-truth discipline** — one authoritative location, N derived
4. **AC quality** — the difference between "charitable interpretation" and "mechanical verification"
5. **Artifact derivation vs parallel state** — prefer deriving state from what exists over maintaining separate bookkeeping

These are the principles that actually determined design quality this session. The template was fine for structure but silent on the reasoning patterns that prevent bad designs.

## The usurobor review pattern

When usurobor reviews a design, the consistent move is:
1. Trace every consumer of the changed thing
2. Ask "is this a schema problem or a population problem?"
3. Ask "what is the actual abstraction level?" (dune-project is OCaml metadata, not system-level)
4. Name the specific files that need changing, not categories
5. Reject hedging ("or independent semver with compat range") in favor of the one honest answer

This is what the design skill should teach. Not "write a design doc" but "think about designs this way."

## Concrete improvements made

- Design skill expanded from template to principles + anti-patterns
- 9 numbered principles, each derived from a specific session failure
- Impact analysis added as a required section (not optional)
- AC quality guidance: name file, name check, name pass/fail
- Anti-patterns section with real examples from this session
- Cross-referenced to PR #98 review lessons thread

## Open question

Should the design skill reference CDD explicitly, or should CDD reference the design skill? Currently CDD step 1 is "Design" but delegates to this skill. The skill is now opinionated about things CDD also has opinions about (impact analysis, AC quality). Authority relationship needs to be clean: CDD owns the pipeline step, design skill owns the reasoning method.
