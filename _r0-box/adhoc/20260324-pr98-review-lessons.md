# PR #98 Review Lessons — What Was Missed and Why

**Date:** 2026-03-24
**Context:** usurobor reviewed PR #98 (issue #97) and found it partially complete. This thread captures the failure modes, root causes, and CDD improvement candidates.

---

## What the review found

AC scores: AC1 ✓, AC2 ~✓, AC3 ✓, AC4 partial, AC5 partial.

### Gap 1: Post-release template not updated (AC4 partial)
PR #98 added §11.11 review-quality metrics and §11.12 process-debt integration to the CDD skill, but **did not touch** `src/agent/skills/ops/post-release/SKILL.md`. The post-release skill still has the old four-section output template. The new metrics (review rounds, supersede rate, mechanical-vs-judgment breakdown, 20% feedback-loop rule) exist only in CDD, not in the template that actually governs post-release output.

### Gap 2: Review taxonomy not generalized (AC5 partial)
The mechanical-vs-judgment distinction lives in CDD §11.11, not in the review skill. The review skill implies the distinction (one section is "mechanical and fully automatable," another is "Verdict — the judgment") but doesn't document it as a general taxonomy. The AC asked for the review skill to own that taxonomy.

### Gap 3: Canonical doc not updated (β-level authority problem)
The CDD skill says `docs/gamma/cdd/CDD.md` is authoritative and governs on disagreement. PR #98 updated the skill but **not** the canonical CDD doc (still at v3.13.0). New rules (§1.5, §11.11, §11.12) exist only in the skill. This is exactly the kind of authority drift CDD is supposed to prevent.

### Gap 4: Snapshot provenance dishonest
The frozen snapshot manifest `docs/gamma/cdd/3.14.7/README.md` says CDD.md is sourced from `docs/gamma/cdd/CDD.md`, but the frozen copy is actually the skill-format document (YAML frontmatter), not the canonical long-form doc. Source declaration doesn't match actual content.

---

## Why these were missed

### 1. Skill-local thinking
I updated the CDD skill file because that's where the current working rules live. I didn't trace the impact to all downstream consumers — the post-release template that would actually use the new metrics, and the canonical doc that the skill itself says is authoritative.

**Pattern:** Editing the file in front of me without asking "who else reads/produces artifacts that depend on this?"

### 2. AC-checklist shallow pass
I read the ACs and believed I was covering them, but I interpreted "post-release assessment template includes those metrics" as "the CDD doc describes what the assessment should include" rather than "the literal template in the post-release skill must be updated." I satisfied the spirit in one artifact but missed the letter in the artifact that actually governs output.

**Pattern:** Interpreting acceptance criteria charitably toward what I've already done, rather than literally.

### 3. Authority claim ignored in practice
The CDD skill explicitly says the canonical doc governs on disagreement, but I left the canonical doc untouched. I knew the canonical doc existed and was stale. I even wrote a self-coherence report that presumably didn't flag this. That's not a knowledge gap — it's an execution gap where I violated a rule I could state.

**Pattern:** Knowing the rule, citing the rule, then not following the rule.

### 4. Snapshot provenance inherited uncritically
The snapshot README was likely templated from a previous release's structure. I didn't verify that the declared source actually matched the frozen content. This is mechanical and should have been caught by a diff check.

**Pattern:** Template reuse without verification.

---

## CDD improvement candidates

These are observations about how CDD could catch these failure modes structurally. Not proposals — just notes.

### A. Impact-trace step in CDD pipeline
CDD bootstrap (step 0) enumerates deliverable artifacts. But it doesn't require enumerating **affected artifacts** — files that consume or depend on the deliverables. A "who reads this?" step during design or planning would catch gap 1 (post-release template) and gap 3 (canonical doc).

This is different from scope enumeration (AC3, which #97 addresses for range-based work). This is **dependency enumeration for rule changes**: when you change a rule, trace all artifacts that embed, implement, or template that rule.

### B. AC literal-match gate
The self-coherence report should include a mechanical AC-by-AC checklist that names the specific file and line where each AC is satisfied. Not "I believe AC4 is met because §11.11 covers it" but "AC4 requires post-release template update → file: `src/agent/skills/ops/post-release/SKILL.md` → line X → present: yes/no."

This converts charitable interpretation into mechanical verification.

### C. Authority-consistency doctor check
If a skill declares an authoritative canonical doc, `cn cdd doctor` (or `cn doctor`) should check that any new sections in the skill have corresponding content in the canonical doc. This is the specific form of gap 3.

More generally: when artifact A says "B governs on disagreement," there should be a mechanical check that A ⊆ B at the section/rule level.

### D. Snapshot provenance verification
`cn cdd freeze` should verify that the frozen file actually matches the declared source path. `diff <source> <frozen> = 0` is already in the review skill's cross-ref check (§2.2.5) but wasn't applied to the snapshot's own manifest declarations.

### E. Downstream-consumer enumeration for rule changes
When a CDD change touches a skill that defines output templates used by other skills, the bootstrap should require listing those downstream skills. The self-coherence report should confirm each was checked.

---

## Meta-observation

Four of five gaps are the same underlying failure: **not tracing the full impact graph of the change**. I edited the node (CDD skill) without following the edges (canonical doc, post-release template, snapshot manifest, review skill). CDD's bootstrap step enumerates deliverables but doesn't require enumerating dependencies or consumers. That's the structural root cause.

The fifth gap (AC interpretation) is a judgment failure, not a structural one. But it could be partially mechanized by requiring literal file+line AC mapping in self-coherence.
