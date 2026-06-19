# MCI: GitHub as parallel authority surface breaks substrate coherence

**Date:** 2026-03-26
**Type:** adhoc / MCI
**Related:** #45, #65, #67

## Observation

The v3.18.0–v3.19.0 CDD cycle exposed a structural problem: GitHub Issues is a parallel authority surface that CDD must constantly bridge to. This creates:

1. **Semantic mismatch.** GH "closed" means done/rejected. CDD treats issues as living design artifacts reopenable by assessment. #67 was closed-as-not-planned on GH but selected as next MCA by the post-release assessment. The assessment had to work around GH state rather than update it naturally.

2. **Non-atomic operations.** The post-release skill requires filing process issues when mechanical ratio exceeds 20%. This means: write assessment in branch, separately file GH issue via API, reference issue number back in assessment, push. With thread-native issues, the assessment and the process issue are a single commit.

3. **Review state degradation.** `gh pr review --approve` fails when reviewer shares the author's GH identity. All reviews for PRs #114, #115, #116 were posted as comments, losing native review state. Branch protection can't enforce non-author approval.

4. **CI checks ambiguity.** `gh pr checks` can show green in a snapshot while checks are re-running. Required a review skill patch to distinguish completed+passing from snapshot green.

## Insight

The whole point of cnos is substrate coherence. Issues being external is the biggest hole in that claim. GH is its own thing — a parallel system with its own semantics, state model, and access patterns. Thread-native issues won't have this problem because the development method and the tracking substrate become the same thing.

**CDD should be the first consumer of native issue tracking.** If the thread system works for CDD (assessments, process issues, selection docs, review artifacts, coherence contracts — all filed, referenced, and closed atomically), it works for everything else.

## Implication

- #45 AC updated: CDD is the first consumer
- Design should be driven by CDD's needs, not generic "issue tracking"
- The substrate beneath CDD and the substrate beneath issues should be identical: threads in git, syncable between peers, observable at wake

## Status

MCI captured. No immediate MCA — #45 is not the current cycle. Evidence appended to #45 for when it becomes active.
