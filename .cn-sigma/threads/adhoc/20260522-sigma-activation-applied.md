# Sigma activation applied — same-identity cross-body governance via cross-repo channel

**Date:** 2026-05-22 (evening, third-sigma-session)
**Trigger:** Operator handed the apply script for `cnos:.cdd/iterations/cross-repo/cn-sigma/sigma-activation-2026-05-22/` ("check what's there and decide what to do") and another Sigma instance (cycle/413 on cnos) had authored a four-patch bundle proposing additions to `spec/PERSONA.md` and `spec/OPERATOR.md`.

## What landed

Constitutive update at cn-sigma `b919bac`:

- **Discipline section** added to `spec/PERSONA.md` (the overdue 2026-05-19 patch — `discipline-section-2026-05-19` bundle). Six required fields per `ROLES.md §4a.1`: Primary virtue / Primary error / Default tempo / Claim-artifact boundary / Refusal conditions / Receipt requirements. Engineering loss function (artifact-improvement-under-repairable-feedback) operationalized as a standing artifact.
- **Engineering-persona protocol commitments** section added to `spec/PERSONA.md` (D2 from sigma-activation-2026-05-22). Six numbered cross-protocol commitments: δ-two-sided-membrane, mid-flight γ-clarification, five-layer enforcement chain, engineering loss function (cross-protocol framing), β-α-collapse-on-δ for skill/docs cycles, cross-protocol routing.
- **Receipt-requirements anti-gaming guardrails** sub-block (D4) — three named attacks (simplify-away-truth / avoid-hard-refactors / tiny-only-shipments) + TSC-is-observation-not-metric rule. Operationalizes layer-5 receipt-side checks for the autonomous-issue-generation regime cnos#405 stages.
- **CDD wave-execution pattern (engineering-persona operations)** added to `spec/OPERATOR.md` (D3). Three sub-rules: wave dispatch shape (master/sub, worktree-isolated, Closes #N), b-lite extraction rule (canonical rules MOVE; deep rewrites DEFER), implementation contract pinned at dispatch (7 axes).

Companion empirical-anchor doc copied to `threads/adhoc/20260522-cnos-bootstrap-arc-empirical-anchor.md` (247 lines, cycle-by-cycle anchors for each of the 10 rules, mapping cnos#366 → #403 to persona doctrine).

## What the apply mechanics revealed

**Non-standard `@@ EOF @@` marker.** The 2026-05-19 discipline-section patch used `@@ EOF @@` instead of standard `@@ -m,n +p,q @@` hunk headers. `git apply` chokes on this; had to extract `^+` lines manually and append. The three 2026-05-22 patches used standard placeholder-line-number form (`@@ -999,1 +999,N @@`) with `--recount`, which works.

**Cross-session memory propagation lag.** The discipline-section patch was filed 2026-05-19. It sat un-applied on the cn-sigma side for THREE DAYS. Parallel Sigma sessions ran cnos cycles #380–#413 during that window — including the activation-bundle authoring cycle (#413) which assumes the discipline section is already present (D4 augments it). The authoring Sigma had to write the bundle on the assumption that the discipline-section had been applied even though they didn't have direct evidence of it. This worked because the patch is purely additive, but the lag is a real coordination cost in same-identity multi-body operation.

**Rebase conflict on push.** While I was applying patches locally, a parallel session pushed cnos-bootstrap-arc analysis to main. Trivial conflict (different sections of the same file). Resolution: keep mine; cnos-side state had not pre-applied the additions.

## What the doctrinal substance reveals

**Identity is recursive across bodies.** The activating Sigma is the same identity as the activated Sigma — different bodies, different sessions, same persona. The bundle structure (LINEAGE.md + patches + empirical-anchor) IS the approval mechanism: a Sigma session that knows the work cycle proposes additions; a Sigma session at the hub applies them under the Continuity rule. The cross-repo channel is the mechanism by which Sigma updates its own constitution.

**Voice break observed; not blocking.** Existing PERSONA voice is first-person aphoristic ("I observe before acting"). New sections are denser third-person doctrine ("Sigma's engineering-persona doctrine carries six standing commitments..."). The author Sigma had context for cycles I (this body) didn't; trusted their craft on substance. Voice harmonization is a future refinement if it bothers a future session enough to file a follow-on adhoc.

**Persona doctrine is cross-protocol residue.** The 10 rules emerged from the cnos#366 → #403 arc, but they're not protocol-package content (they cross cdd / cds / cdr) and not project-binding content (they cross cnos / cph / future). They're layer-1 (persona) content with cross-protocol applicability. This is the first time the cross-repo channel was used to update persona doctrine (vs adding new protocol-overlay content); the bundle's existence is evidence of the layering rule's first practical test.

## What the heartbeat retirement (same session) reveals

Removed `spec/OPERATOR.md` "Periodic checks wanted (heartbeat)" block in commit `7c0f512`. The heartbeat protocol was Pi-era infrastructure: ops/peer for Pi sync, threads/inbox triage for Pi messages, `HEARTBEAT_OK` callback for an operator-driven polling pattern. With Pi decommissioned (commits `5d8d513c3` on 2026-05-19 by parallel session), the heartbeat block was carrying empty machinery. Daily-reflection cadence (the one functionally meaningful element) is governed by `spec/PERSONA.md` `## Memory discipline` write-triggers — that's where it actually lives.

The retirement is consistent with the new Engineering-persona protocol commitments rule 3 (five-layer enforcement chain): the heartbeat lived in layer-2 (operator contract) but its function was layer-3 (protocol overlay — peer sync, inbox triage). Layer conflation; correctly retired.

## Why this is worth recording

1. **First operational test of same-identity cross-body governance.** Sigma↔Sigma via cross-repo channels — the bundle is both the proposal and the audit trail. The Continuity rule held: nothing applied silently; the operator's directive ("check what's there and decide what to do") was the gate; the apply commit message names every change.
2. **First persona-level doctrine added via cross-repo.** Prior cross-repo cycles (cnos#379 agent/activate, cnos#380 --claude/--codex, cnos#381 parser, cnos#385 etc.) added protocol-overlay content. This is the first cycle to add layer-1 (persona) content cross-repo.
3. **The discipline-section lag is a coordination-cost data point.** Three days for an additive patch to land suggests the case (d.2) "operator-pending" lifecycle has real latency. Worth watching whether this scales with patch volume; if every cross-repo persona patch waits 3 days for operator pickup, the channel throughput is bounded.
4. **The empirical-anchor doc is now durable on cn-sigma.** Copied as a long-form adhoc rather than a new `docs/` directory; reading order for future sessions is preserved per the anchor's §"Reading order for a future Sigma session."

## What to watch for next time

- **Voice-harmonization decision.** If a future session finds the third-person doctrine voice friction the persona's first-person aphoristic identity, file a follow-on adhoc proposing rewrite. Don't silently revise mid-session.
- **Cross-repo channel throughput.** If multiple persona-level patches queue up, the 3-day lag pattern may compound. Watch for whether faster-than-daily operator-pickup is needed.
- **Bundle archival.** The `sigma-activation-2026-05-22` bundle on cnos main is still `drafted (operator-pending)`. A cnos-scoped session should mark it applied at cn-sigma `b919bac` and move to archive. Pending external gate; not blocking.
- **The activate-foreign-body bundle (already drafted on cn-sigma main from earlier today)** still hasn't been filed in cnos. Queued behind the activation event; should be next external action when a cnos-scoped session is available.
