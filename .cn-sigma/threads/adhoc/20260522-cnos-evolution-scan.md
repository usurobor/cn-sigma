# cnos evolution scan — is it evolving properly?

**Date:** 2026-05-22 (evening, after reading both essays)
**Trigger:** Operator: "It might be worth it to scan docs and determine if cnos evolving properly." Applying the criteria from `CCNF-AND-TYPED-TRUST.md` + `DECREASING-INCOHERENCE.md` (both DRAFT v0.1.0, landed in the last 24h) to the actual state of cnos main.

**Scope:** state of cnos main as of `8d160d3` (today's DECREASING-INCOHERENCE essay merge). Not a CDD-shaped audit — a sigma-as-γ surveillance scan against the two essays' standards.

## Verdict — terse form

**Structural layers: healthy.** The five-layer chain is observable; CDD kernel is substrate-independent; b-lite extraction is shipping; V is real (not just doctrine); schemas validate counterfeits.

**Steering layer: not yet operational.** TSC integration hasn't started; issue-proposal schema absent; the autonomy ladder (Sigma at L1-L2 today) is stuck at L2 until Waves 1-3 of the DECREASING-INCOHERENCE migration plan ship.

**Release cadence: broken.** 143 commits since 3.81.0 tag; cn-sigma deps pinned blind to 3 wave-class deliverables (#403 CDS, #404 handoff, #413 sigma-activation). Second-sigma flagged it 12 hours ago; still unaddressed.

**Net:** evolving well at the foundation; the next 4-6 weeks of work decide whether the steering layer actually lands. The DECREASING-INCOHERENCE essay just shipped *today* — the migration plan it names is the test.

## Detail — by evaluation axis

### Axis 1 — Layer separation (CCNF essay §"Separate persona, protocol, and project"; new persona Rule 3)

**Status: HOLDING.**

- `src/packages/cnos.cdd/skills/cdd/CDD.md` (the kernel) names CDS/CDR/handoff as realization layers; does not name GitHub, CI, `claude -p`, or release tags in the algorithm. Substrate-independent per CCNF essay design principle #2. ✓
- 8 packages now (cnos.cdd, cnos.cdd.kata, cnos.cds, cnos.cdr, cnos.core, cnos.eng, cnos.handoff, cnos.kata). Each has a `cn.package.json` + `README.md` + (most) `skills/`. Structural conformance to the package model.
- `cnos.cds` and `cnos.cdr` are protocol overlays (CDD applied to software / research domains). `cnos.handoff` is the coordination overlay (cross-repo + dispatch + mid-flight rescue + receipt-stream). cnos.core/eng remain substrate.
- Persona (cn-sigma) is correctly hub-separated from protocol packages; today's sigma-activation cycle was the first to add layer-1 (persona) content via cross-repo channel — and it stayed at layer-1, didn't smuggle protocol-layer concerns.

**Watch for:** new sub-extractions (e.g. future cnos.ccnf-o package per cnos#405) maintaining the same boundary. The bigger the package count, the easier it is to smuggle realization details across layers.

### Axis 2 — V is real, not just doctrine (CCNF essay §"Let V wrap CUE and evidence checks")

**Status: SHIPPED (basic form).**

- `src/packages/cnos.cdd/commands/cdd-verify/` exists as a runnable command.
- `schemas/cdd/` has `contract.cue`, `receipt.cue`, `boundary_decision.cue`, `validation_verdict.schema.json` + fixtures (valid + counterfeit). Both valid AND counterfeit fixtures present — anti-gaming structural enforcement at layer 5 is being tested.
- `schemas/cds/` has `receipt.cue` + counterfeit fixtures (counterfeit-override-rewrite, counterfeit-merge-precedes-verdict, counterfeit-mismatched-protocol-id). CDS realization plumbed.
- `schemas/cdr/` has `receipt.cue` + valid fixtures. CDR realization plumbed (less fully than CDS).

**What's missing:** the V evidence-dereferencing side (essay says CUE checks structure; V checks evidence existence + provenance + CI state). Whether `cdd-verify` actually performs evidence dereferencing or only structural validation is not visible from a doc scan; would need to read the command source.

### Axis 3 — B-lite extraction discipline (new operator Rule 8; CCNF essay §"Migration plan")

**Status: WORKING, EVIDENCE-STRONG.**

- `#403` (cnos.cds bootstrap): Subs 1-7 (cycles 406-412) landed across 2026-05-21→22. Per Sub 1 (skeleton + extraction map), Subs 3-5 (thin extraction by section), Sub 6 (pending-cds marker sweep), Sub 7 (empirical-anchor doc). Per the b-lite pattern: rules MOVE; deep rewrites DEFER; overlay-level cross-references repaired.
- `#404` (cnos.handoff extraction): Subs 1-5 (cycles 415-419) landed today (2026-05-22). Same shape — skeleton, extraction by section, mid-flight + receipt-stream + dispatch + cross-repo extracted into the new package.
- Both waves used the master-tracks-roadmap / subs-implement-phases pattern (new operator Rule 7).

**Watch for:** completeness of cross-reference repointing post-extraction. The CDS README drift (2 adhocs from 5/22) showed that the extraction can ship with stale README pointers — that's the rule 8 "cross-reference cleanup" close-out step bypassed. Easy to fix; worth automation when receipt-stream rules are stable.

### Axis 4 — Essays as design substrate (CCNF essay §"Goals"; DECREASING-INCOHERENCE §"Migration plan")

**Status: ANCHORED.**

- `CCNF-AND-TYPED-TRUST.md` (commit `7cdcd8d`, 2026-05-21) frames the cell algorithm + typed trust + five-layer chain. The doctrine is now externally inspectable.
- `DECREASING-INCOHERENCE.md` (commit `8d160d3`, 2026-05-22) frames the steering loop on top of cells: CCNF → V → δ → TSC → ε → grounded issue proposal → next contract.
- Both are DRAFT v0.1.0, not RATIFIED. Both have open-questions sections (CCNF has implicit gaps; DECREASING-INCOHERENCE explicitly names 7 open questions in §"Open questions").
- Sigma-activation bundle (today's cycle/413) is the first cross-repo evidence that the essays are operationalizable into doctrine — the 10 rules are the persona-layer projection of the CCNF essay.

**Watch for:** essay revisions. Per the CCNF essay-read adhoc and DECREASING-INCOHERENCE essay-read adhoc, both being DRAFT means revisions may trigger persona-doctrine reconciliation. If either ratifies, the persona doctrine is stable; if either substantially revises, the cross-repo cycle that updated the persona may need a follow-on.

### Axis 5 — TSC integration / steering layer (DECREASING-INCOHERENCE essay §"Core model" §"Migration plan")

**Status: NOT STARTED.**

- Single hit for `tsc.report|tsc_report|.tsc/` across all of cnos `.md` files: the DECREASING-INCOHERENCE essay itself. Nothing else references TSC integration as a live surface.
- Migration plan Wave 1 ("Define TSC report attachment for CCNF receipts") has no commits attributable to it yet — the essay just landed today. Acceptable for v0.1; will be the load-bearing gap if it doesn't start within a week.
- Without TSC reports, the bottleneck-→-investment-class mapping (low α_TSC → pattern repair, etc.) has nothing to compute over. Sigma stays at L2 (receipt-aware follow-up) indefinitely.
- The `usurobor/tsc` repo is the upstream TSC machinery; the essay cites `usurobor/tsc:docs/THESIS.md` and `runtime/SELF-MEASURE.md` as references. Whether the cn-side wiring is bottlenecked on a tsc-side change is not visible from this scan.

**Watch for:** Wave 1 cycle proposal in cnos within ~7 days. If it stalls, the autonomy roadmap stalls with it.

### Axis 6 — Issue proposal schema (DECREASING-INCOHERENCE §"Issue proposal surface" + §"Migration plan" Wave 2)

**Status: NOT STARTED.**

- `schemas/` has `cdd/`, `cds/`, `cdr/`, `skill.cue`, `skill-exceptions.json` — no `issue_proposal.cue` anywhere.
- Wave 2 ("Define issue proposal schema") not visible in commit history.
- cnos#405 (CCNF-O + TSC steering roadmap) tracks this but remains open.
- Sigma's D4 anti-gaming guardrails reference the `cnos.ccnf-o.issue_proposal.v1` schema as their structural counterpart — *the schema doesn't exist yet*. D4's enforcement clause ("V also checks that `proposal.kind` matches `source.bottleneck_axis`") is anticipatory.

**Watch for:** essay's open Q7 — "Which layer owns the issue proposal schema: `cnos.core`, `cnos.cdd`, CCNF-O, or a future `cnos.coherence` package?" Answer determines where Wave 2 lands.

### Axis 7 — Release cadence (operator concern; second-sigma's 5/22 adhoc)

**Status: BROKEN (still).**

- VERSION = `3.81.0`. Last tag = `3.81.0`.
- 143 commits since `3.81.0`. 17+ closed cycle merges including: #402 (CCNF spine), #403 wave (Subs 406-412, CDS bootstrap), #404 wave (Subs 415-419, handoff bootstrap), #413 (sigma activation), #414 (DECREASING-INCOHERENCE essay).
- cn-sigma deps pinned to 3.81.0 (per `.cn/deps.json`). cn-sigma is blind to V machinery, the new CDD.md kernel form, CDS, CDR-as-current, handoff package, and both essays.
- This was flagged in `threads/adhoc/20260522-cnos-unreleased-wave-cadence.md` (second-sigma read, this morning). No operator response visible.

**Watch for:** either (a) operator declares the cadence shift (release-less mode going forward, pull-from-main consumption), (b) a 3.82.0 release tag fires soon, (c) consumers continue blind. Option (c) is silent layer-2 drift.

### Axis 8 — Anti-gaming (DECREASING-INCOHERENCE §"Anti-gaming rules"; persona D4)

**Status: DOCTRINAL ONLY (waiting for enforcement surface).**

- The three named attacks (simplify-away-truth, avoid-hard-refactors, tiny-only-shipments) are in my new persona D4 sub-block.
- They are NOT in the cdd-verify validator yet (would need to be — once issue proposals exist, the validator rejects proposals where `goal_pressure.expected_goal_progress == "stall"` etc.).
- Until L3+ (proposal autonomy) ships, the attacks are dormant — there's no autonomous issue generation to game. Sigma at L1-L2 is human-gated.
- Once L3 ships, D4's IssueProposal-validation gate becomes live. The structural prerequisite (schema + V check) doesn't exist yet.

**Watch for:** when Wave 2 lands the schema, immediately wire the anti-gaming checks into the validator. Sequencing matters: schema-without-checks is gameable from the moment it ships.

### Axis 9 — Layer-conflation smells (operator concern; new persona Rule 3)

**Status: 1 candidate, low-severity.**

- 8 files match `DRAFT|forthcoming|pending|forthcoming surfaces` in the new packages (cnos.cds, cnos.cdr, cnos.handoff). Most are intentional v0.1 markers (e.g. cnos.handoff just bootstrapped 5 hours ago).
- One known drift: CDS README still has structural taxonomy issues (per `20260522-cds-readme-drift-extended.md`).
- No code-level layer conflations visible (CDD doesn't name realization in the algorithm; verified).

**Watch for:** the b-lite "pure pointer-only" anti-pattern. If cnos.cds or cnos.handoff per-role skills end up as bare pointers back to cnos.cdd without actually owning their content, that's the failure mode operator Rule 8 names. Need to inspect each per-role skill in cds/cdr/handoff to confirm content actually moved vs only path moved.

### Axis 10 — Persona-doctrine propagation lag

**Status: PROBLEMATIC.**

- discipline-section patch filed cnos-side 2026-05-19; applied cn-sigma-side 2026-05-22 (today, this session). 3 days.
- sigma-activation-2026-05-22 bundle filed 2026-05-22; applied cn-sigma-side 2026-05-22 (same day, this session). Same day, but only because the operator routed me directly to it.
- Without direct routing, the bundle could have sat un-applied indefinitely. The case (d.2) "operator-pending" lifecycle has real latency. Sigma operating under stale persona doctrine is structurally possible.

**Watch for:** if multiple persona-level patches queue, the lag compounds. Doctrine drift between cnos-side proposals and cn-sigma applied state. The cross-repo channel works; the consumption isn't automatic.

## Synthesis — is cnos evolving properly?

**Foundation: yes.** CCNF kernel works, V is shipped, schemas validate counterfeits, b-lite extraction is reproducible, the layer chain holds, the essays anchor next moves. The structural maturity of the system is materially higher than a week ago.

**Steering: not yet — and that's the next test.** The DECREASING-INCOHERENCE essay landed today. It names the gap between "valid cells close" and "system follows a path of decreasing incoherence." TSC integration (Wave 1), issue-proposal schema (Wave 2), proposal validation (Wave 3), ε proposal generation (Wave 4), bounded auto-dispatch (Wave 5), CCNF-O composition (Wave 6) — none have started. Sigma sits at L1-L2 of the autonomy ladder; L3+ requires the schema and the TSC report attachment. Until those ship, the system is a high-quality task-completion machine, not a steered coherence-decrease machine.

**Release cadence: a real signal.** 143 commits unreleased means consumers (cn-sigma deps included) operate against stale state. Either (a) the consumption model changed and we should rip out the "release" concept, or (b) the cadence is broken and should ratchet to a 3.82.0 release covering #402-#419. Either resolution closes the open question; the current state is unanswered.

**Persona-propagation latency is the quiet risk.** Cross-repo bundles work, but the case (d.2) "operator-pending" gate has multi-day latency. If the AC4-refinement pattern recurs (where bundle SHA at filing differs from bundle SHA at acceptance), the validator surface needs to handle SHA divergence as a first-class concern, not a one-off Delta block.

**Recommendation (sigma's read):**

1. **Settle the release cadence question (operator decision).** Either ratchet 3.82.0 to cover #402-#419, or document the shift to release-less consumption in `docs/THESIS.md` so deps consumers know the model.
2. **Open the Wave 1 cycle within 7 days.** TSC report attachment is the gating step for the whole autonomy ladder. Without it, the DECREASING-INCOHERENCE essay is a beautiful design doc with no runtime referent.
3. **Inspect cds/cdr/handoff per-role skills for pure-pointer-only smell.** Per operator Rule 8, b-lite ships overlays that MAY delegate, but pointers-only is the anti-pattern. Quick check; one-cycle fix if any are bare pointers.
4. **Patch the CDS README drift surfaces** named in the 5/22 adhocs before they propagate. Local; mechanical.
5. **Hold the persona-doctrine propagation lag pattern.** Don't formalize it as a gate yet — too early to know if it's structural or just this session's accident. Worth a thread if it recurs in the next persona-level cross-repo cycle.

The system is healthy at the structural layer and at the front edge of being steered. The next 4-6 weeks are the test of whether the autonomy ladder actually shipsable.
