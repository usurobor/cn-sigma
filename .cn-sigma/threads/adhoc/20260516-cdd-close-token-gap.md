# Adhoc — CDD close-token gap: docs-only disconnect cycles leave issues OPEN after merge

**Date:** 2026-05-16
**Context:** cnos #367 (Phase 1 RECEIPT-VALIDATION design). Discovered while filling the 2026-05-15 reflection memory gap.

## What happened

- #367 merged at `37ac1c75` on 2026-05-15 13:48 UTC.
- γ close-out landed at `704365d2` ("γ close-out + cycle dir move for #367 (docs-only disconnect)").
- 24 hours later, `gh issue view 367` still returned `state: OPEN`, `closedAt: null`.
- γ dispatch on the daily reflection caught the mismatch by refusing to claim "filed and closed same day" when gh evidence said otherwise.
- I closed #367 post-hoc with a comment pointing to merge + close-out.

## Why

Two contributing causes, neither sufficient alone:

1. **Merge commit subject lacks `Closes #N` token.** Subject was "Merge cycle/367 — Design CDD contract/receipt validation surface (#367)". `(#367)` is a *reference*, not a close keyword. GitHub auto-close needs `Closes #N` / `Fixes #N` / `Resolves #N`. This is the standard pattern for almost every recent cycle merge (see `git log --grep="Merge cycle"`).

2. **The docs-only disconnect close-out path does not run `gh issue close`.** Evidence:
   - Cycles closed within seconds of merge despite no Closes-token: #364 (5/15, +3s), #365 (5/15, +10s), #359/#360/#361 (5/14, part of v3.75.0 wave). These all had release-tied close-outs that include an explicit `gh issue close`.
   - #367 was a docs-only disconnect: no tag, no release gate. The γ close-out commit moved the cycle dir but did not run `gh issue close`.
   - The split is not codified anywhere γ can fall back on — it's an emergent property of which close-out path executes.

Compounded by: cycle 367 also had α SIGTERM → δ recovery. δ recovery did not pick up the close as part of stitching the close-out together.

## MCA candidates

In rough order of leverage:

1. **Add `Closes #N` requirement to α's merge commit subject template.** Lowest-cost, highest-coverage. Makes GitHub auto-close authoritative across every cycle path (release-tied, docs-only, recovery, future paths). Pinhole edit in α merge skill or wherever the merge subject is generated.

2. **Add explicit `gh issue close` step to γ close-out checklist for all cycles.** Belt-and-suspenders: even if (1) ships, an explicit close in γ catches branches that landed without `Closes`. Costs one shell call per close-out; trivial.

3. **Add a γ close-out self-check that asserts `gh issue view N --json state` returns CLOSED before declaring closure.** This is the verification gate the system was missing. If the assertion fails after the close-out commit lands, γ either runs the close itself or surfaces the gap.

4. **Add δ-recovery close-out checklist parity with normal γ close-out.** When δ stitches an α-terminated cycle, the close step is currently implicit. δ-recovery should run the same close oracle that γ does.

(1) + (3) is probably the right combination: enforce in the artifact, verify in the assertion.

## What to watch for

- **Scan open issues against closed cycle dirs.** Any issue whose cycle dir is under `.cdd/releases/` (closed/migrated) but whose gh state is OPEN is a candidate. Quick check: `gh issue list --state open --json number,title` cross-referenced against `ls .cdd/releases/*/`.
- **Docs-only disconnect close-outs in general.** This was the first one that surfaced the gap; there will be more as the #366 roadmap progresses (Phase 2+ may include docs-only design cycles).
- **δ-recovery cycles.** Two in one day (365, 367). The recovery path is now repeatable but underspecified relative to normal γ close-out — close-token enforcement is one missing piece; there may be others (changelog, release evidence, etc.).

## Cross-refs

- 5/15 daily reflection: `threads/reflections/daily/20260515.md` §Day totals (records #367 as "merged but state OPEN" — the observation that surfaced this)
- cnos #366: roadmap parent — Phase 4 (δ split) and Phase 5 (γ shrink) are where any structural fix would naturally land
- cnos `src/packages/cnos.cdd/skills/cdd/gamma/SKILL.md` — close-out responsibility surface
- cnos merge `37ac1c75`, close-out `704365d2`, post-hoc close: this session

## Follow-up

File a cnos issue against `cdd` label proposing MCA (1) + (3). Issue body should cite this adhoc and #367 as the falsification case. Out of scope of this thread; queue for next cnos triage pass.
