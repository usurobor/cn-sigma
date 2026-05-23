# release v3.82.0 hygiene — CCNF package-architecture baseline + pause directive

Labels: `chore`, `P1`, `release`

Priority: P1 — Bounded release-hygiene cycle; operator directive sets a hard stop after the tag. Top-level VERSION (3.81.0) lags actual architecture state by 143 commits and 18+ closed cycles including #402 (CCNF spine), #403 wave (CDS v0.1), #404 wave (handoff v0.1), #413 (sigma activation), #414 (DECREASING-INCOHERENCE essay).

Status: cnos is structurally at a stable architecture boundary (CDD = compact CCNF kernel; CDS v0.1 = software realization; CDR v0.1 = research realization; cnos.handoff v0.1 = wire-format package; V executable; domain evidence has homes). Top-level VERSION + several package READMEs lag actual state. This cycle cuts the boundary and pauses; no theory expansion in or after this cycle.

---

## Problem

What exists (on cnos main as of `8d160d3`):
- VERSION = `3.81.0`. Last tag = `3.81.0`. 143 commits since.
- `cnos.cdd` at v3.81.0; CDD.md is the compact CCNF kernel (Phase 7 of #366 landed via #402 = `ecbcb5d`).
- `cnos.cds` at v0.1.0 (`cn.package.json`). Actual contents: CDS.md, SKILL.md, lifecycle/SKILL.md, selection/SKILL.md, empirical-anchor-cdd.md, extraction-map.md. All 7 subs of #403 shipped (cycles 406-412).
- `cnos.cdr` at v0.1.0. Actual contents: CDR.md, SKILL.md, full per-role overlays (alpha/beta/gamma/epsilon/operator), empirical-anchor-cph.md. Wave #376 complete.
- `cnos.handoff` at v0.1.0. Actual contents: HANDOFF.md (header says "intentionally absent in v0.1" — but file exists), SKILL.md, all 5 sub-skills (artifact-channel, cross-repo, dispatch, mid-flight, receipt-stream), extraction-map.md. All 5 subs of #404 shipped (cycles 415-419).
- Two L7 design essays: `docs/gamma/essays/CCNF-AND-TYPED-TRUST.md` + `docs/gamma/essays/DECREASING-INCOHERENCE.md`. Both DRAFT v0.1.0.
- V executable at `src/packages/cnos.cdd/commands/cdd-verify/`. Schemas validate counterfeits at `schemas/cdd/`, `schemas/cds/`, `schemas/cdr/`.

What is expected:
- VERSION = `3.82.0`; tag `3.82.0` pushed; release CI green.
- Package READMEs reflect completed v0.1 waves rather than "in-flight" / "skeleton-only" language.
- RELEASE.md + CHANGELOG.md updated for v3.82.0.
- No new theory work (per operator directive): no #405 dispatch, no IssueProposal.v1, no RiskPolicy.v1, no CCNF-O schemas, no TSC report attachment, no new package families, no field trials, no CCNF kernel modifications.

Where they diverge:
- VERSION lagged the architecture by 5 waves' worth of work.
- CDS README §"Package Structure" / "Forthcoming surfaces" / "Status" all describe state as pre-#403 (CDS.md "pending Sub 2", per-role overlays "Sub 3-5 in flight", §"Until Sub 6 lands..."). All shipped.
- CDR README §"Package Structure" describes "single surface in this v0.1 skeleton" + role overlays "Sub 3 in flight" + empirical-anchor doc "Sub 4 in flight". All landed.
- Handoff README internally inconsistent: header says "v0.1 skeleton" + "HANDOFF.md intentionally absent in v0.1" — but HANDOFF.md is present and all 5 sub-skills landed via Subs 2-5 of #404 (also named in the README body as "Landed via..." rows).

---

## Impact

- Affects: every consumer of cnos packages, including cn-sigma (deps pinned to 3.81.0; blind to the new CCNF kernel form, V, CDS/CDR/handoff, and both essays). Without a release boundary, "what version of the protocol does this consumer use" has no answer; deps consumers operate against drifted state silently.
- Enables: the post-pause field-application phase per operator directive ("apply CDS and CDR to real projects; focus on intra/inter-agent communication and memory return; collect field evidence before expanding CCNF-O or TSC steering").
- Closes: the release-cadence open question raised in `cn-sigma:threads/adhoc/20260522-cnos-unreleased-wave-cadence.md` (second-sigma's 5/22 observation, currently un-resolved).

---

## Status truth

| Surface | What ships | What is draft/planned |
|---|---|---|
| cnos VERSION | 3.81.0 | bump to 3.82.0 this cycle |
| Last tag | 3.81.0 | tag 3.82.0 this cycle |
| `cnos.cdd` package | 3.81.0; CCNF kernel form (compact) | no change this cycle |
| `cnos.cds` package | 0.1.0; v0.1 wave complete (#403 Subs 1-7) | README text patch only |
| `cnos.cdr` package | 0.1.0; v0.1 wave complete (#376) | README text patch only |
| `cnos.handoff` package | 0.1.0; v0.1 wave complete (#404 Subs 1-5) | README text patch only |
| V (cdd-verify command) | shipped at `cnos.cdd/commands/cdd-verify/` | no change this cycle |
| Schemas | `schemas/cdd/`, `schemas/cds/`, `schemas/cdr/` shipped with fixtures (valid + counterfeit) | no change this cycle |
| `CCNF-AND-TYPED-TRUST` essay | shipped at `docs/gamma/essays/`; DRAFT v0.1.0 | no change this cycle |
| `DECREASING-INCOHERENCE` essay | shipped at `docs/gamma/essays/`; DRAFT v0.1.0 | no change this cycle |
| TSC report attachment | not started | **out of scope this cycle (operator directive)** |
| IssueProposal.v1 schema | not started | **out of scope this cycle (operator directive)** |
| RiskPolicy.v1 | not started | **out of scope this cycle (operator directive)** |
| CCNF-O package | not started | **out of scope this cycle (operator directive)** |
| #405 Track A / Track B | open | **do not dispatch this cycle (operator directive)** |
| New packages beyond the 4 above | n/a | **do not add this cycle (operator directive)** |

---

## Source of truth

| Claim / surface | Canonical source | Status | Notes |
|---|---|---|---|
| Operator directive | `cn-sigma:threads/adhoc/20260522-release-boundary-and-pause-directive.md` | Filed this cycle | Captures full directive text; pause condition |
| Architecture state (essays) | `cnos:docs/gamma/essays/CCNF-AND-TYPED-TRUST.md`, `DECREASING-INCOHERENCE.md` | Shipped DRAFT v0.1.0 | Baseline this release tags |
| CCNF kernel | `cnos:src/packages/cnos.cdd/skills/cdd/CDD.md` | Shipped; compact per Phase 7 of #366 | Substrate-independent (no realization names) |
| V implementation | `cnos:src/packages/cnos.cdd/commands/cdd-verify/` | Shipped | Executable |
| CDS v0.1 wave closure | cnos#403 master + Subs 406-412 | Closed `378a54f0` | This cycle's CDS README reflects this state |
| CDR v0.1 wave closure | cnos#376 master + subs | Closed | This cycle's CDR README reflects this state |
| handoff v0.1 wave closure | cnos#404 master + Subs 415-419 | Closed (all 5 subs landed today) | This cycle's handoff README reflects this state |
| Release skill | `cnos:src/packages/cnos.cdd/skills/cdd/release/SKILL.md` (or `cnos.cds` equivalent post-#403) | Shipped | Governs `scripts/release.sh 3.82.0` execution |
| Release artifact contract | `cnos:CHANGELOG.md`, `RELEASE.md` | Existing files; appended this cycle | |
| Mode pre-conditions (MCA) | This issue body + the operator's directive | Both present at filing time | Mode = MCA; design + plan converged in operator directive |
| cn-sigma evolution scan | `cn-sigma:threads/adhoc/20260522-cnos-evolution-scan.md` | Filed this cycle | Independent verification that release cadence is broken |

---

## Scope

In scope:
- Patch `src/packages/cnos.cds/README.md` — replace "Package Structure" + "Forthcoming surfaces" + "Status" sections to reflect v0.1 wave complete (all 7 Subs of #403 shipped). Specific replacement text below in §"Implementation guidance".
- Patch `src/packages/cnos.cdr/README.md` — replace "Package Structure" + "Forthcoming surfaces" + "Status" sections to reflect actual file presence (CDR.md + SKILL.md + alpha/beta/gamma/epsilon/operator overlays + empirical-anchor-cph.md). Specific replacement text below.
- Patch `src/packages/cnos.handoff/README.md` — fix internal inconsistency (HANDOFF.md is present); update "Package Structure" + "Forthcoming surfaces" + "Status" sections to reflect v0.1 wave complete (all 5 Subs of #404 shipped). Specific replacement text below.
- Bump top-level `VERSION` from `3.81.0` → `3.82.0`.
- Append CHANGELOG.md entry for v3.82.0 — CCNF package-architecture baseline. List the load-bearing additions: CCNF kernel (compact CDD.md), CDS v0.1, CDR v0.1, handoff v0.1, V executable, both L7 essays.
- Update `RELEASE.md` for v3.82.0 with the release meaning ("CCNF package-architecture baseline") and the explicit "does not include" list per operator directive.
- Execute the release tag via `scripts/release.sh 3.82.0` (operator-driven release boundary; δ acts at this gate).
- Confirm release CI green; if any of the pre-existing CI issues fire (lychee link validation per the 2026-05-19 daily reflection), classify per `operator/SKILL.md §3.4 step 4` as pre-existing infrastructure if so.

Out of scope (per operator directive; do not perform):
- Dispatch of #405 Track A or Track B (CCNF-O + TSC steering).
- Define `IssueProposal.v1` schema or any cnos.coherence package surface.
- Define TSC report attachment (Wave 1 of DECREASING-INCOHERENCE migration plan).
- Define RiskPolicy.v1.
- Add new package families beyond the four current ones (cnos.cdd, cnos.cds, cnos.cdr, cnos.handoff) — cnos.core, cnos.eng, cnos.cdd.kata, cnos.kata stay as-is.
- Expand CCNF-O surfaces.
- Modify the CCNF kernel (`cnos.cdd/skills/cdd/CDD.md`, `COHERENCE-CELL.md`, `COHERENCE-CELL-NORMAL-FORM.md`, `RECEIPT-VALIDATION.md`).
- Launch CDS or CDR field trials inside this release cycle.
- Per-role-skill deep rewrites in CDS, CDR, or handoff (Rule 8 b-lite: rewrites DEFERRED).
- Promote either essay from DRAFT v0.1.0 to RATIFIED.

Deferred (named explicitly to surface they are the post-release direction):
- Apply CDS and CDR to real projects (post-release work).
- Intra/inter-agent communication + memory return investigation.
- Field evidence collection before further CCNF-O / TSC steering expansion.

---

## Cycle scope sizing

| Factor | Reading | Splitting signal? |
|---|---|---|
| (a) New code surface | Zero new code; only README text patches + VERSION/CHANGELOG/RELEASE.md text + tag | no |
| (b) Cross-module breadth | Three README files in three packages + 3 top-level files (VERSION, CHANGELOG, RELEASE.md) — uniform docs-only change | no |
| (c) Lifecycle span | Single phase: hygiene + release ceremony | no |
| (d) MCA preconditions | Design + plan are committed in this issue body + the operator's directive at `cn-sigma:threads/adhoc/20260522-release-boundary-and-pause-directive.md` | no |
| (e) Independent shippability | Patches must ship together with the release tag — partial application leaves the README state lying about VERSION | no |

Decision: keep whole. Docs-only + release ceremony; 6 ACs (3 README patches + VERSION + CHANGELOG/RELEASE + tag); single-focus. Eligible for β-α-collapse-on-δ (new persona Rule 5; new operator Rule 7 wave dispatch shape allows it for docs-only release-hygiene cycles where the AC oracle is mechanical).

Mode: **MCA** — design (this issue body) and plan (the specific patch text below) are converged and committed. The actor playing γ for this cycle MAY collapse α and β onto δ per Rule 5 since the cycle's primary product is docs-only and the AC oracle is mechanical (file content match, VERSION integer bump, tag-pushed-with-CI-green).

---

## Acceptance criteria

### AC1: CDS README reflects v0.1 wave complete

Invariant: `src/packages/cnos.cds/README.md` "Package Structure" + "Forthcoming surfaces" + "Status" sections describe v0.1 as complete (CDS.md + SKILL.md + lifecycle/SKILL.md + selection/SKILL.md + empirical-anchor-cdd.md + extraction-map.md all present and shipped). No "Sub N in flight" or "Pending Sub N" language remains for any Sub of #403.

Oracle: `grep -E "Sub [0-9]+ of \[cnos#403\]|Pending Sub|in flight under|Until Sub [0-9]+ lands" src/packages/cnos.cds/README.md` returns zero matches.

Positive: Status section says "v0.1 complete (cnos#403 wave closed at `378a54f0`)" or equivalent. Forthcoming surfaces section either removed or names only genuinely-future items (full per-role α/β/γ/δ/ε overlay rewrites if deferred per Rule 8 b-lite).

Negative: any "in flight" / "Sub X pending" / "Until Sub Y" language remains; or the Status section claims a higher version than 0.1.0 (it's still a v0.1 package; only top-level VERSION bumps).

Surface: `src/packages/cnos.cds/README.md`.

### AC2: CDR README reflects v0.1 wave complete

Invariant: `src/packages/cnos.cdr/README.md` "Package Structure" + "Forthcoming surfaces" + "Status" sections describe v0.1 as complete (CDR.md + SKILL.md + alpha/beta/gamma/epsilon/operator role-skill overlays + empirical-anchor-cph.md all present and shipped). No "Sub N in flight" language remains for any Sub of #376.

Oracle: `grep -E "Sub [0-9]+ of cnos#376|Sub [0-9]+ in flight|forthcoming|single surface in this v0.1 skeleton" src/packages/cnos.cdr/README.md` returns zero matches.

Positive: Status section says "v0.1 complete (cnos#376 wave closed)" or equivalent. The §"Package Structure" enumerates the actual files (CDR.md, SKILL.md, 5 role overlays, empirical-anchor-cph.md).

Negative: README still claims "single surface" or "role overlays Sub 3 in flight."

Surface: `src/packages/cnos.cdr/README.md`.

### AC3: handoff README internally consistent and reflects v0.1 wave complete

Invariant: `src/packages/cnos.handoff/README.md` (a) does not claim HANDOFF.md is "intentionally absent in v0.1" (the file IS present), (b) does not call the package a "skeleton" if all 5 sub-skills are shipped, (c) Status section reflects v0.1 wave complete (all 5 Subs of #404 landed via cycles 415-419).

Oracle: grep for `intentionally absent` + `v0.1 skeleton` + `in flight under \[cnos#404\]` — all should return zero hits or only context-appropriate hits (e.g. historical mention of what Sub 1 originally shipped).

Positive: Status section names the wave as closed; Package Structure enumerates the actual files (HANDOFF.md, SKILL.md, 5 sub-skills, extraction-map.md); no internal contradictions.

Negative: header claims skeleton while body names sub-skills as landed.

Surface: `src/packages/cnos.handoff/README.md`.

### AC4: VERSION bumped to 3.82.0

Invariant: `VERSION` file at repo root contains exactly `3.82.0\n`.

Oracle: `[ "$(cat VERSION)" = "3.82.0" ]`.

Positive: VERSION is `3.82.0`.

Negative: VERSION is `3.81.0` or any other value.

Surface: `VERSION`.

### AC5: CHANGELOG + RELEASE.md updated for v3.82.0

Invariant: `CHANGELOG.md` has a new v3.82.0 entry naming the release meaning ("CCNF package-architecture baseline"); `RELEASE.md` is updated for v3.82.0 with the release-includes list and the explicit "does not include" list per operator directive.

Oracle: both files contain `3.82.0` headings/sections; new entries are non-empty.

Positive: CHANGELOG entry includes the load-bearing additions (CCNF kernel via #402; CDS v0.1 via #403; CDR v0.1 via #376; handoff v0.1 via #404; V executable; both L7 essays). RELEASE.md notes the post-release pause direction.

Negative: either file lacks a 3.82.0 entry or the entry omits the architecture-baseline framing.

Surface: `CHANGELOG.md`, `RELEASE.md`.

### AC6: Tag pushed and release CI green

Invariant: Git tag `3.82.0` exists on the merge commit of this cycle and is pushed to origin; release CI workflow runs green against the tag.

Oracle: `git tag --list 3.82.0` returns `3.82.0`; `git ls-remote --tags origin 3.82.0` returns the tag's SHA; release CI run for the tag completes successfully (per `release/SKILL.md` conventions).

Positive: tag pushed; release CI green; pre-existing CI noise (e.g. lychee link validation) classified per `operator/SKILL.md §3.4 step 4` as pre-existing.

Negative: tag missing; tag not pushed; release CI red for release-relevant reasons (not pre-existing infra).

Surface: git tag space; release CI workflow.

---

## Proof plan

Invariant: cnos main at the merge commit of this cycle carries (a) three packages' READMEs reflecting their actual v0.1 wave completions, (b) VERSION `3.82.0`, (c) CHANGELOG + RELEASE.md updated with the baseline framing, (d) tag `3.82.0` pushed with green release CI. No theory expansion happened in this cycle.

Surface: `src/packages/cnos.cds/README.md`, `src/packages/cnos.cdr/README.md`, `src/packages/cnos.handoff/README.md`, `VERSION`, `CHANGELOG.md`, `RELEASE.md`, git tag `3.82.0`.

Oracle:
- AC1-AC5 grep / file-content oracles run against the cycle branch head.
- AC6 oracle runs against origin after tag push.
- Non-expansion oracle: `git diff origin/main..HEAD -- src/packages/cnos.cdd/skills/cdd/CDD.md src/packages/cnos.cdd/skills/cdd/COHERENCE-CELL.md src/packages/cnos.cdd/skills/cdd/COHERENCE-CELL-NORMAL-FORM.md src/packages/cnos.cdd/skills/cdd/RECEIPT-VALIDATION.md` returns zero lines (kernel unmodified).
- Non-expansion oracle: `git diff origin/main..HEAD -- schemas/` should return zero lines (no IssueProposal/RiskPolicy schemas added).
- Non-expansion oracle: no new package directories under `src/packages/` (still 8 packages including kata + core + eng).

Positive case: all AC oracles pass; release CI green; non-expansion oracles confirm no theory work crept in.

Negative case: any AC oracle fails; or any non-expansion oracle returns content (kernel modified, new schemas added, new packages added — operator directive violation).

Operator-visible projection: 3.82.0 tag visible at https://github.com/usurobor/cnos/releases/tag/3.82.0; release CI status visible; cn-sigma deps consumers can pin to 3.82.0.

Known gap: TSC report attachment, IssueProposal.v1, RiskPolicy.v1, CCNF-O schemas, field-trial results, new runtime/autonomy work — all deliberately deferred per operator directive. Post-release pause is the test of whether field application (CDS/CDR on real projects + handoff/memory-return testing) produces field evidence before the next theory expansion.

---

## Skills to load

Tier 3:
- `cnos.cds/skills/cds/SKILL.md` + Sub-skills under `lifecycle/`, `selection/` (CDS-side cycle execution surface)
- `cnos.cdd/skills/cdd/release/SKILL.md` (release boundary contract)
- `cnos.cdd/skills/cdd/post-release/SKILL.md` (close-out + PRA contract — though for an MCA docs-only release-hygiene cycle, the close-out can be minimal)
- `cnos.cdd/skills/cdd/issue/SKILL.md` (for the cycle issue itself)
- `cnos.cds/skills/cds/CDS.md` (the six-field instantiation contract for the cycle's execution shape)

Why:
- The cycle is docs-only + release ceremony; CDS owns the software-cycle realization post-#403.
- release/SKILL.md governs the tag/push gate.
- post-release for the minimal close-out (provisional alpha-closeout acceptable per CDS shipped artifact contract).

---

## Active design constraints

- **Operator directive is binding and non-negotiable.** The "Do not" list (no #405 dispatch, no IssueProposal.v1, no TSC report attachment, no new packages, no CCNF-O expansion, no CCNF kernel modification, no field trials) is enforced as scope-violation gating; β rejects any out-of-scope change with severity D regardless of how mechanically clean the change appears.
- **β-α-collapse-on-δ is permitted** for this cycle per new persona Rule 5 (skill/docs-class cycles + mechanical AC oracle). γ MAY collapse onto δ. α=β remains structurally prohibited; if any α=β check fires, the collapse is invalid and α/β must dispatch separately.
- **Post-tag pause is the load-bearing outcome.** Operator: "After v3.82.0 is tagged and pushed: pause protocol evolution." γ close-out's "Next" section names the pause explicitly; does not name a next protocol cycle. Field application + memory-return testing is the post-pause direction; field evidence gates the next theory expansion.
- **Pre-existing CI noise** (lychee link validation per the 2026-05-19 daily reflection notes) is non-blocking per `operator/SKILL.md §3.4 step 4`; release CI green excluding pre-existing infrastructure is acceptable.
- **No essay promotion.** Both essays stay DRAFT v0.1.0; ratification is not in this cycle's scope.
- **No package-version bumps below the top level.** cnos.cds, cnos.cdr, cnos.handoff stay at 0.1.0; this is the top-level architecture-baseline release, not per-package version bumps.

---

## Related artifacts

- `cnos:VERSION` — primary release surface
- `cnos:CHANGELOG.md` — release ledger
- `cnos:RELEASE.md` — release-time framing
- `cnos:src/packages/cnos.cds/README.md` — patch target (AC1)
- `cnos:src/packages/cnos.cdr/README.md` — patch target (AC2)
- `cnos:src/packages/cnos.handoff/README.md` — patch target (AC3)
- `cnos:scripts/release.sh` — tag/push execution
- `cnos:docs/gamma/essays/CCNF-AND-TYPED-TRUST.md` — architecture baseline being tagged
- `cnos:docs/gamma/essays/DECREASING-INCOHERENCE.md` — architecture baseline being tagged
- `cnos:src/packages/cnos.cdd/skills/cdd/CDD.md` — kernel being tagged; MUST NOT be modified
- `cn-sigma:threads/adhoc/20260522-cnos-evolution-scan.md` — independent verification (10-axis evaluation) of release readiness
- `cn-sigma:threads/adhoc/20260522-release-boundary-and-pause-directive.md` — full operator directive captured

---

## Source Proposal

- Source: `usurobor/cn-sigma:.cdd/iterations/cross-repo/cnos/release-3.82.0-hygiene/`
- Source commit: filled at filing (cn-sigma main HEAD when this bundle lands)
- Disposition: pending (to be set by cnos γ at acceptance)
- Delta: none at filing; record any modifications cnos γ makes to this body
- Upstream cause: direct operator directive (full text in cn-sigma source adhoc cited above)

---

## Implementation guidance — patch text

The three README patches are specified below as replacement text for the named sections. The cycle agent applies them by replacing the existing section content with the text given. No line-count guarantees; the agent identifies the section by heading and replaces from heading to next `##`-level heading.

### Patch 1 — `src/packages/cnos.cds/README.md`

Replace existing `## Package Structure` section through end of `### Forthcoming surfaces` subsection with:

```markdown
## Package Structure

This package shipped v0.1 under the [cnos#403](https://github.com/usurobor/cnos/issues/403) wave (Subs 1-7, cycles 406-412, closed `378a54f0`). The doctrine surface, the loader, the lifecycle and selection sub-skills, the empirical-anchor doc, and the extraction map are all present.

### `/skills/cds/` — The Method

- **`SKILL.md`** — Loader skill. Names `CDS.md` and the per-role-extracted sub-skills as advisory targets; declares the load order and the cross-protocol relationship.
- **`CDS.md`** — Canonical instantiation contract. Declares the six fields per [`ROLES.md §3`](../../../ROLES.md): matter type (software-class), review oracle, γ close-out artifact, δ cadence, ε iteration cadence, actor collapse rule. Shipped under cnos#407 (Sub 2 of cnos#403).
- **`lifecycle/SKILL.md`** — Software-development lifecycle realization (per-section migration from pre-#402 `CDD.md` per the extraction map). Shipped under cnos#408 + cnos#410.
- **`selection/SKILL.md`** — Software-class issue selection function. Shipped under cnos#408.

### `/docs/`

- **`extraction-map.md`** — The migration plan that Subs 3-5 dispatched against; complete; preserved as audit artifact.
- **`empirical-anchor-cdd.md`** — Surface-by-surface mapping of the current cnos repository's `.cdd/` cycle artifacts to CDS's six-field structure, demonstrating CDS v0.1 hosts current practice without contradiction. Shipped under cnos#412 (Sub 7 of cnos#403). Structural precedent: [`cnos.cdr/docs/empirical-anchor-cph.md`](../cnos.cdr/docs/empirical-anchor-cph.md).

### Deferred (post-v0.1)

- **Per-role α/β/γ/δ/ε deep-rewrite overlays.** Per operator Rule 8 (b-lite extraction): canonical rules MOVED into CDS via lifecycle + selection skills in v0.1; deep per-role rewrites are deferred to a future cycle when a real second-consumer drift or genuine architectural pressure motivates them. Pointer overlays delegating to existing `cnos.cdd` role skills remain acceptable in v0.1.
- **Receipt schemas** — `schemas/cds/` exists per [cnos#388](https://github.com/usurobor/cnos/issues/388) with valid + counterfeit fixtures; CDS's six-field contract Field 3 (γ close-out artifact) cites it.
```

Replace existing `## Status` section with:

```markdown
## Status

**v0.1 — complete.** The cnos#403 wave (Subs 1-7, cycles 406-412) closed at `378a54f0`. The package ships:

- `cn.package.json` (schema `cn.package.v1`; name `cnos.cds`; version `0.1.0`; kind `package`; engines `cnos >= 3.81.0`),
- `README.md` (this file),
- `skills/cds/SKILL.md` (loader),
- `skills/cds/CDS.md` (six-field instantiation contract),
- `skills/cds/lifecycle/SKILL.md` (software-development lifecycle realization),
- `skills/cds/selection/SKILL.md` (software-class selection function),
- `docs/extraction-map.md` (the migration plan; preserved as audit artifact),
- `docs/empirical-anchor-cdd.md` (CDS v0.1 hosts current practice without contradiction).

Per-role α/β/γ/δ/ε deep-rewrite overlays are deferred to a future cycle (per operator Rule 8 b-lite: canonical rules moved; deep rewrites defer). The package is loadable and discoverable by cnos package-discovery (per `pkg.ContentClasses` filesystem-presence convention); commands are not declared in this version.
```

### Patch 2 — `src/packages/cnos.cdr/README.md`

Replace existing `## Package Structure` section through end of `### Forthcoming surfaces` subsection with:

```markdown
## Package Structure

This package shipped v0.1 under the [cnos#376](https://github.com/usurobor/cnos/issues/376) wave. The doctrine surface (`CDR.md`), the loader (`SKILL.md`), the full per-role overlays (`alpha/`, `beta/`, `gamma/`, `epsilon/`, `operator/`), and the empirical-anchor doc are all present.

### `/skills/cdr/` — The Method

- **`CDR.md`** — Canonical instantiation contract (declares the six fields per `ROLES.md §3`: matter type, review oracle, γ close-out artifact, δ cadence, ε iteration cadence, actor collapse rule). The package's primary doctrine surface. Shipped by [cnos#390](https://github.com/usurobor/cnos/issues/390) (Sub 1 of [cnos#376](https://github.com/usurobor/cnos/issues/376)).
- **`SKILL.md`** — Loader skill. Names `CDR.md` and the per-role overlays. Shipped by [cnos#394](https://github.com/usurobor/cnos/issues/394) (Sub 2 of cnos#376).
- **`alpha/SKILL.md`** — α role's research-discipline procedure (matter production, claim authorship, evidence handling).
- **`beta/SKILL.md`** — β role's research-discipline procedure (review oracle, evidence verification, claim-status discrimination).
- **`gamma/SKILL.md`** — γ role's research-discipline procedure (close-out artifact, receipt emission, cycle coordination).
- **`epsilon/SKILL.md`** — ε role's protocol-iteration procedure for research cycles.
- **`operator/SKILL.md`** — operator (δ) contract for research cycles; dispatch cadence; refusal conditions per loss function.

### `/docs/`

- **`empirical-anchor-cph.md`** — surface-by-surface mapping of [`usurobor/cph`](https://github.com/usurobor/cph)'s `.cdr/` artifact set to CDR.md's six-field structure. The structural precedent for `cnos.cds/docs/empirical-anchor-cdd.md`.
```

Replace existing `## Status` section with:

```markdown
## Status

**v0.1 — complete.** The cnos#376 wave closed. The package ships:

- `cn.package.json` (schema `cn.package.v1`; name `cnos.cdr`; version `0.1.0`; kind `package`; engines `cnos >= 3.81.0`),
- `README.md` (this file),
- `skills/cdr/CDR.md` (instantiation contract; primary doctrine surface),
- `skills/cdr/SKILL.md` (loader),
- `skills/cdr/{alpha,beta,gamma,epsilon,operator}/SKILL.md` (per-role overlays),
- `docs/empirical-anchor-cph.md` (CDR v0.1 hosts cph practice without contradiction).

Per-role deep-rewrite further iteration is deferred to follow-on cycles motivated by real second-consumer drift (Rule 8 b-lite). The package is loadable and discoverable by cnos package-discovery (per `pkg.ContentClasses` filesystem-presence convention); commands are not declared in this version.
```

### Patch 3 — `src/packages/cnos.handoff/README.md`

Replace existing `## Package Structure` section through end of `### Forthcoming surfaces` subsection with:

```markdown
## Package Structure

This package shipped v0.1 under the [cnos#404](https://github.com/usurobor/cnos/issues/404) wave (Subs 1-5, cycles 415-419). The doctrine surface (`HANDOFF.md`), the loader (`SKILL.md`), all five sub-skill domains (`cross-repo/`, `dispatch/`, `mid-flight/`, `artifact-channel/`, `receipt-stream/`), and the extraction map are all present.

### `/skills/handoff/` — The Method

- **`SKILL.md`** — Loader skill. Names `HANDOFF.md` and the per-surface sub-skill files as advisory targets; declares the load order and the cross-protocol relationship. Shipped by [cnos#415](https://github.com/usurobor/cnos/issues/415) (Sub 1 of cnos#404).
- **`HANDOFF.md`** — Canonical instantiation contract for the handoff wire format. Declares directional cases, artifact families per case, consumer protocol for how CDD/CDS/CDR/future-c-d-X packages bind the wire format. Authored across Subs 2-5 of cnos#404.
- **`cross-repo/SKILL.md`** — Cross-repo state machine, bundle file sets per directional case, LINEAGE schemas, feedback-patch format, bundle archival rule, hat-collapse attribution. Landed via [cnos#416](https://github.com/usurobor/cnos/issues/416) (Sub 2). Migrated from `cnos.cdd/skills/cdd/cross-repo/SKILL.md`.
- **`dispatch/SKILL.md`** — Dispatch-prompt template; implementation-contract 7-axes schema; δ-as-inward-membrane enrichment doctrine. Landed via [cnos#417](https://github.com/usurobor/cnos/issues/417) (Sub 3).
- **`mid-flight/SKILL.md`** — `gamma-clarification.md` mechanism for intra-cycle re-pinning. Landed via [cnos#418](https://github.com/usurobor/cnos/issues/418) (Sub 4). Empirically anchored at cnos#391.
- **`artifact-channel/SKILL.md`** — Intra-cycle α→β→γ sequential handoff rules over `.cdd/unreleased/{N}/`. Landed via cnos#418 (Sub 4).
- **`receipt-stream/SKILL.md`** — Cross-cycle `cdd-iteration.md` receipt-stream + `.cdd/iterations/INDEX.md` aggregator; ε reader feed. Landed via [cnos#419](https://github.com/usurobor/cnos/issues/419) (Sub 5).

### `/docs/`

- **`extraction-map.md`** — The migration plan that Subs 2-5 dispatched against; complete; preserved as audit artifact.
```

Replace existing `## Status` section with:

```markdown
## Status

**v0.1 — complete.** The cnos#404 wave (Subs 1-5, cycles 415-419) closed. The package ships:

- `cn.package.json` (schema `cn.package.v1`; name `cnos.handoff`; version `0.1.0`; kind `package`; engines `cnos >= 3.81.0`),
- `README.md` (this file),
- `skills/handoff/SKILL.md` (loader),
- `skills/handoff/HANDOFF.md` (canonical wire-format contract),
- `skills/handoff/{cross-repo,dispatch,mid-flight,artifact-channel,receipt-stream}/SKILL.md` (five sub-skill domains),
- `docs/extraction-map.md` (the migration plan; preserved as audit artifact).

The handoff-class surfaces previously resident in `cnos.cdd` and `cnos.cds` (per the cnos#403 wave) have been migrated; cross-references in the original locations have been re-pointed to the canonical homes in this package per Sub 6 of cnos#404 (cross-reference sweep). The package is loadable and discoverable by cnos package-discovery (per `pkg.ContentClasses` filesystem-presence convention); commands are not declared in this version.
```

### Patch 4 — `VERSION`

Replace contents with exactly `3.82.0\n`.

### Patch 5 — `CHANGELOG.md` v3.82.0 entry

Append a new entry at the top of the release-row section with the following shape (adapt to the existing CHANGELOG.md format conventions):

```markdown
## 3.82.0 — CCNF package-architecture baseline (2026-05-22)

Architecture baseline release. cnos has crossed the kernel/realization separation:

- **CCNF kernel** — `cnos.cdd/skills/cdd/CDD.md` is the compact CCNF spine (Phase 7 of cnos#366; closed via cnos#402, merge `ecbcb5d`). Substrate-independent; does not name realization details.
- **CDS v0.1** — software realization (cnos#403 wave; Subs 406-412; closed `378a54f0`). Six-field instantiation contract + lifecycle + selection sub-skills + extraction map + empirical anchor.
- **CDR v0.1** — research realization (cnos#376 wave; closed). Six-field contract + full per-role overlays + empirical anchor.
- **cnos.handoff v0.1** — wire-format and handoff doctrine package (cnos#404 wave; Subs 415-419). HANDOFF.md + 5 sub-skill domains + extraction map.
- **V executable** — `cnos.cdd/commands/cdd-verify/` is the runtime validator. Schemas at `schemas/{cdd,cds,cdr}/` with valid + counterfeit fixtures.
- **Two L7 design essays** — `docs/gamma/essays/CCNF-AND-TYPED-TRUST.md` (cell substrate) + `docs/gamma/essays/DECREASING-INCOHERENCE.md` (system steering). Both DRAFT v0.1.0.

Does not include:
- TSC report attachment (Wave 1 of DECREASING-INCOHERENCE migration plan)
- IssueProposal.v1 schema (Wave 2)
- RiskPolicy.v1
- CCNF-O package or schemas (Track A of cnos#405)
- Field-trial results
- Per-role α/β/γ/δ/ε deep-rewrite overlays in CDS (deferred per Rule 8 b-lite)
- New runtime/autonomy work

Post-release direction: pause protocol evolution; apply CDS and CDR to real projects; focus on intra/inter-agent communication and memory return; collect field evidence before expanding CCNF-O or TSC steering. The next protocol-expansion cycle is gated on field evidence per operator directive.

[Engineering level and TSC grades to be assessed during γ-as-δ close-out per release/SKILL.md.]
```

### Patch 6 — `RELEASE.md` v3.82.0 update

Update `RELEASE.md` to reflect v3.82.0 per the existing RELEASE.md format conventions. The release-meaning header should say "CCNF package-architecture baseline." The release-includes / does-not-include enumeration matches the CHANGELOG entry above. The "Next" section names the pause direction explicitly.

---

## Non-goals

- Do not dispatch cnos#405 Track A (CCNF-O) or Track B (TSC steering).
- Do not define `IssueProposal.v1` schema.
- Do not define TSC report attachment.
- Do not define `RiskPolicy.v1`.
- Do not add new package families.
- Do not expand CCNF-O surfaces.
- Do not modify the CCNF kernel (`cnos.cdd/skills/cdd/CDD.md`, `COHERENCE-CELL.md`, `COHERENCE-CELL-NORMAL-FORM.md`, `RECEIPT-VALIDATION.md`).
- Do not launch CDS/CDR field trials inside this release cycle.
- Do not promote either L7 essay from DRAFT v0.1.0 to RATIFIED.
- Do not bump per-package versions (cnos.cds, cnos.cdr, cnos.handoff stay at 0.1.0).
- Do not undertake per-role α/β/γ/δ/ε deep rewrites in CDS, CDR, or handoff.
- Do not modify the persona doctrine in cn-sigma (separate concern; no constitutive changes from this cycle).

---

## Success / closure condition

This issue is closeable when:
- AC1-AC6 oracles produce passing results.
- `git diff origin/main..HEAD -- src/packages/cnos.cdd/skills/cdd/CDD.md src/packages/cnos.cdd/skills/cdd/COHERENCE-CELL*.md src/packages/cnos.cdd/skills/cdd/RECEIPT-VALIDATION.md` returns zero lines (kernel unmodified).
- `git diff origin/main..HEAD -- schemas/` returns zero lines (no IssueProposal/RiskPolicy schemas added).
- No new package directories under `src/packages/`.
- Tag `3.82.0` exists on the merge commit and is pushed to origin.
- Release CI is green (excluding pre-existing infrastructure noise per `operator/SKILL.md §3.4 step 4`).
- γ close-out's "Next" section names the post-release pause explicitly and does NOT name a next protocol cycle.
- Cycle CDD trace + cdd-iteration.md (if applicable) records this as the architecture-baseline release.

The release is the disconnection point for the architecture wave. After the tag, protocol evolution pauses; field application becomes the next direction per operator directive.
