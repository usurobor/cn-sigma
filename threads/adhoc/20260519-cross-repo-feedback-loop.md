# Adhoc — Cross-repo proposal feedback-loop: search target before proposing

**Date:** 2026-05-19
**Context:** cph cdr-refactor wave close (5/18) + bootstrap-cdr bilateral closure on both mains. Operator question: *"come up with a clear, clean and simple way for repos using CDD to pass back iteration proposals; cnos can either accept and implement or reject with explanation."* Was about to file a cnos issue codifying the protocol; discovered cnos#377 already covers it.

## What happened

Sequence over ~2 hours of session:

1. Operator inspected the bootstrap-cdr handshake (cph branch authoring + cnos#376 + FEEDBACK.patch transport + stale-named cnos-side mirror) and the cnos#378 next-MCA filing (issue-only from cph ε, no bundle), asked: "why bundle in one case, issue-only in the other?"
2. I explained the empirical distinction (proposal-class with multi-sub fanout vs. finding-class with inline anchors) — the cross-repo `README.md` rule names criterion (1) deliverables-land-in-target as the bundle trigger.
3. Operator then asked for a unified protocol with accept/reject/explanation lifecycle.
4. I sketched a design (issue-first, bundle-only-on-acceptance, lifecycle via labels, rejection trace via GitHub comment).
5. Operator: "create an issue in cnos using cdd issue skill to improve feedback loop."
6. Before authoring, listed recent cnos issues. **cnos#377** existed: filed 2026-05-18T08:01:05Z by cnos γ, P2/cdd/design, OPEN. Title: "design(cdd): codify cross-repo coordination protocol (intake / outbound / bilateral)."
7. Read #377 — 228-line body covering exactly the same gap: 6 named fragments + 6 ACs (canonical skill + STATUS state machine + bundle schema + path-collision + feedback-patch format + fragment-update refs). Empirical anchors: tsc/cdd-supercycle (outbound) + gait-support-paths/bootstrap-cdr (inbound).
8. Filed an enrichment comment on #377 instead of duplicating: third empirical anchor (today's bilateral closure cph 424b293 + cnos 7a7f7152) + two design questions (CDD identity convention; missing case (d) finding-class handoff) + reject-must-carry-explanation refinement.

## Why I almost duplicated

cnos#377 was filed 8 hours **after** the bootstrap-cdr handshake exposed the gaps (5/18 08:01 UTC vs ~07:00 UTC bundle filing). The cnos-side γ — running the same handshake from the other vantage — wrote the same protocol-gap analysis I would have. Symmetric coherence-cell-driven derivation: when two different vantages encounter the same gap, both produce the same diagnosis. I came in 24 hours later, having seen only the cph side at first, then reasoned my way to the same six-gap analysis without knowing #377 existed.

The miss would have been a duplicate P2 issue with overlapping ACs. Cheap to recover from but unnecessary churn.

## Lesson (operationally)

**Before authoring a cross-repo proposal, list the target's open issues filtered by the relevant label.** Even just `gh issue list --repo {target} --label cdd --state open --limit 20` would have surfaced #377 in five lines of output. Cost: 2 seconds. Saves: duplicate issue + reviewer time + closed-as-duplicate noise.

The structural reason this happens: a CDD-using repo's open-issue list is the canonical "what gaps we know about" surface. Skipping that list is skipping the project's own self-coherence ledger.

## Observations folded into #377 (the enrichment comment)

These three are stable observations from the bilateral closure on both sides; preserved here in case the comment thread gets archived:

### 1. Asymmetric file sets are viable

Target main (cnos) carries the full bundle: `LINEAGE.md` + `FEEDBACK.patch` + `STATUS`. Source main (cph) carries a single `LINEAGE.md` anchor. The full original bundle stays on the dormant source branch (`claude/acquire-test-set-model-60jZ2` @ `333dbeb`) for audit. Both sides self-contained for grep-discoverability without requiring symmetric file counts. The cross-repo `README.md` currently implies symmetric mirroring; the empirical pattern is asymmetric (target = canonical archive, source = pointer).

### 2. Prediction → fulfillment is a recurring sub-flow

The cph-side LINEAGE @ `333dbeb` *predicted* the canonical cnos-side `cph/`-named path before that path existed (`"should be cnos:.cdd/iterations/cross-repo/cph/bootstrap-cdr/ once cnos γ amends the branch or lands a follow-up"`). cnos commit `7a7f7152` fulfilled the prediction. The pattern: source-side authoring under a name that will become stale, target-side landing at the predicted canonical name post-rename. Worth a named protocol step under #377's AC2 STATUS state machine.

### 3. Missing fourth directional case

#377's scope enumerates three: (a) inbound proposal, (b) outbound iteration trace, (c) bilateral supercycle. Empirical fourth case from the cdr-refactor wave: **(d) outbound finding / next-MCA handoff** (cnos#378 — cph ε → cnos, issue-only, no bundle, anchors inline in issue body). Structurally different from (a): no fanout, no FEEDBACK.patch transport, no per-sub LINEAGE table. Without explicit carve-out, the next finding handoff redoes the judgment call.

## Sub-observation (auth identity vs CDD identity)

The cnos bootstrap-cdr ingest agent used `gamma@cdd.cnos` (no per-repo segment) — verified against 5 recent cnos commits. cph uses `{role}@cph.cdd.cnos` (with per-repo segment). Both internally consistent. The canonical cross-repo skill (#377 AC1/AC2) should pick a convention:

- per-repo segment for everyone *except* cnos (root package); or
- per-repo segment for everyone *including* cnos (= `gamma@cnos.cdd.cnos`); or
- no per-repo segment for everyone (cph drops to `delta@cdd.cnos`).

Cross-repo commits that span both sides in one session especially need a rule.

## What to watch for

- **Next cross-repo handshake** — will reveal whether the asymmetric-file-set + prediction-fulfillment pattern generalizes, or whether bootstrap-cdr's shape was idiosyncratic.
- **#377's design phase** — when cnos γ picks up #377, the four-directional-case enumeration (a/b/c/d) lands in the canonical skill. That's the moment to verify the empirical anchors hold up.
- **cnos#378 disposition** — orthogonal #377 input. The next γ picking up #378 (rule 3.11b under §5.2 wave-mode) will exercise the empirical finding-class pattern (d) that #377 currently doesn't enumerate.
- **Duplicate-proposal patterns elsewhere** — the symmetric-coherence-driven derivation (two vantages, same diagnosis) may recur on other gaps. Worth checking whenever a "fresh" analysis converges on a multi-gap protocol issue: did the other side file it already?

## Cross-refs

- cnos#377 (this session's anchor): https://github.com/usurobor/cnos/issues/377
- Enrichment comment: https://github.com/usurobor/cnos/issues/377#issuecomment-4483389625
- cnos#376 (bootstrap-cdr master, OPEN): https://github.com/usurobor/cnos/issues/376
- cnos#378 (cdr-refactor F1 next-MCA, OPEN): https://github.com/usurobor/cnos/issues/378
- cnos commit `7a7f7152` — γ-as-δ ingest bundle at canonical `cph/bootstrap-cdr/` path
- cph commit `424b293` — cph-main-side bilateral closure anchor (`delta@cph.cdd.cnos`)
- cph branch `claude/acquire-test-set-model-60jZ2` @ `333dbeb` — dormant; holds original bundle for audit
- cnos branch `claude/file-cnos-cdr-issue-fi9Ld` — stale; superseded by `7a7f7152`
- cph wave-closeout §"Out of scope" item 1: `cph:.cdd/waves/cdr-refactor-2026-05-18/wave-closeout.md`

## Follow-up

- None blocking. #377 already covers the codification work; this adhoc + the enrichment comment are the durable record.
- If a future cph cycle wants to land the bilateral-closure pattern (asymmetric file sets, prediction-fulfillment) into a reusable skill, this adhoc is the empirical anchor.
