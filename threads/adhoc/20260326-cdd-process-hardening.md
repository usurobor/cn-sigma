# CDD Process Hardening — v3.20.0 Cycle

**Date:** 2026-03-26
**Type:** adhoc / trace

## What happened

Single-session CDD iteration cycle. Started with PR #114 review, ended with 7 skill/spec patches, a release, and two new issues.

## Changes made

### Review skill
- §2.2.9 — module-truth audit: when a change is about model correctness, scan full touched module for same-kind assumptions
- §2.3.7 — review divergence is a review-skill gap: when reviewers diverge, patch the skill not the reviewer
- §3.7 — CI gate strictness: green means completed+passing, not a snapshot

### Post-release skill
- Pre-publish gate: mechanical checklist for all required template fields
- §5.4 — active skill re-evaluation: trace each review finding back to declared active skills
- §5.6 — CDD self-coherence measurement: α/β/γ on the cycle itself

### CDD spec + executable skill
- §2.4 — CAP tie-break: when in doubt, cite existing (MCA) before reinventing (MCI)
- §3.3a — authority-sync: editing paired surfaces (skill ↔ spec) requires updating both in same commit
- §10.1 — CLP β gate on immediate skill/spec patches

### Eng skills
- eng/ocaml §3.3 — path resolution must validate or return Result
- eng/testing §2.7 — negative space mandatory at e2e level

### USER.md
- Autonomy defaults: "act don't ask" anti-patterns in cnos template + instance

## Trigger chain

Each change was motivated by a specific observed failure:
1. PR #114 review missed stale cnos.pm → §2.2.9 (module-truth audit)
2. Two reviewers diverged on same PR → §2.3.7 (divergence = skill gap)
3. CI snapshot showed green but checks were re-running → §3.7 (CI strictness)
4. PR #116 missing First AC + unfiled process issue → pre-publish gate
5. Skill edit didn't update canonical spec → §3.3a + CLP β gate
6. Agent kept asking instead of acting → USER.md autonomy defaults
7. PR #118 path resolution returned bare path → eng/ocaml §3.3
8. PR #118 e2e tests had no failure modes → eng/testing §2.7
9. Review findings not traced back to skill quality → §5.4 (active skill re-evaluation)

## Assessment

This is the most productive single CDD iteration session to date. Every change traces to a concrete observed failure. No speculative additions. The review skill patches from earlier cycles (v3.16.2) are demonstrably paying off in metrics (63% → 33% mechanical ratio).
