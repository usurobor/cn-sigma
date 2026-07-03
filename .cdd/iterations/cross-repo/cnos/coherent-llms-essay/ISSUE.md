# cnos essay proposal: All We Need Is Coherence — the measurement law comes first (v5)

**Mode:** `docs-only`
**Target path (proposed):** `cnos:docs/papers/ALL-WE-NEED-IS-COHERENCE.md`
**Suggested labels:** `docs`, `P2`, `area/essays`
**Filing directive to cnos γ:** Land essay verbatim at target path. Do NOT modify content. This is publication-grade external-facing material, authored by the operator; κ role at cn-sigma is `record` only.

**Version history (all 2026-07-03 same-day iterations):**
- **v0:** *Coherent LLMs: Measuring Whether Generation Still Belongs to the Whole* — doorway-register.
- **v1:** *All We Need Is Coherence — a runtime discipline for whether an LLM's next move still belongs* — sharpened public-position; +§5, §10, §11, §14.
- **v2:** *All We Need Is Coherence — a technical case for triadic runtime coherence in LLM systems* — technical-position register; C≡ + barrier + aggregate split + neuroscience + validation program.
- **v3:** not captured at cn-sigma (operator-side private).
- **v4:** *All We Need Is Coherence — the measurement law comes first* — governance-architecture; CM/CM²/1st methodology; my prior β-review absorbed as normative content.
- **v5 (current):** *All We Need Is Coherence — the measurement law comes first* (title kept). **Narrower claim, stronger stance.** Standing elevated to first-class in the TSC stack. Records what has shipped, what remains, and the exact next artifact.

Bundle slug `coherent-llms-essay/` preserved across all versions.

**Evidence-bound constraint (operator's opening note at v5):** the article's claim is narrower and stronger — CM² earns standing only through methodology, bundle closure, constrained witnesses, deterministic math, and calibration that can reject tuned games. The essay records what has actually shipped versus what remains architectural.

## Why this belongs at cnos:docs/papers/

- Essay-genre content adjacent to `DUMB-MODELS-SMART-CELLS.md` and (v0.8.0's) TSC-integrated form. v5 extends the synthesis into a governance-architecture-with-earned-standing proposal.
- Cites the running TSC branch (`claude/tsc-self-measurement-vxifjo`) throughout, including specific artifacts and implementation state: `#CoherenceMethodology`; `#SelfMeasure`; `#CMOfCMs`; `scripts/ci/validate-skill-frontmatter.sh`; `scripts/cm-consistency.sh`; **the current `scripts/cm-admissibility.sh` self-test outcomes (engine admitted; all-1.0 flatterer rejected; public-path lookup-table gamer rejected)**; targets `spec`/`engine`/`repo`/`methodology`/`cm-of-cms`; `coherence.ml` — `phi`, `discrepancy_energy`, `coherence_link`.
- v5's §16 names a concrete next artifact — the held-out anchor system with five attacker files. Each attacker becomes a regression test. This ties the essay to a specific implementation deliverable.

## Acceptance criteria

**AC1** — File landed at `cnos:docs/papers/ALL-WE-NEED-IS-COHERENCE.md` with essay body verbatim (no content edits).

**AC2** — Path/artifact repointing: essay references specific TSC paths (`schemas/skill.cue`, `scripts/*`, `engine/ocaml/coherence.ml`, target registry, katas 01–05, `runtime/SELF-MEASURE.md`). Verify each against `claude/tsc-self-measurement-vxifjo` head; report deltas if any resolve incorrectly.

**AC3** — Frontmatter added per `cnos.core/skills/agent/` convention if papers require it (title, date, class=`paper`, author=`operator`, version=`v5`).

**AC4** — Bidirectional link added: `DUMB-MODELS-SMART-CELLS.md` cross-references this essay as companion (dumb models frames the substrate; this essay frames the measurement-law + calibration-ceiling governance); `ALL-WE-NEED-IS-COHERENCE.md` cross-references DUMB-MODELS-SMART-CELLS as prerequisite.

**AC5** — I4 (link validation) green; I5 (frontmatter) green; goldens unaffected.

**AC6** — Release note entry captures the essay's landing as v5.

**AC7** — TSC-branch implementation claims verified. Specifically:
- `#CoherenceMethodology` exists in `schemas/skill.cue` with the fields §2/§5 name.
- `scripts/cm-admissibility.sh` self-test rejects all-1.0 flatterer AND public-path lookup-table gamer, AND admits engine backend (§8's three self-test outcomes).
- Anchors staged into neutral case directories with public paths removed and `kata.toml` stripped (§8).
- Consistency script computes max-abs-pairwise over 7 numeric fields, barrier-mapped (§12).
- Any divergent claim gets a companion PR with `v5.1` marker.

**AC8** — §12 β-inconsistency (schema/body disagreement on whether LLM consistency gates or reports) surfaced to TSC γ before landing. Either the schema or body should be updated per the coherent rule the essay prescribes (mechanical = hard gate; LLM = report + off-diagonal-standing denied below floor).

## Non-goals

- Do NOT edit or "improve" the essay content. Operator-authored; κ delivers verbatim.
- Do NOT split into multiple documents or restructure the section order.
- Do NOT publish externally in this cycle; that is a separate operator decision after landing at cnos.
- Do NOT implement any of the §16 next-artifact files in this cycle; that is a separate TSC-branch issue.
- Do NOT re-baseline TSC kata numbers in-place without a companion CI verification step.

## Empirical anchors (cnos-side context)

- `DUMB-MODELS-SMART-CELLS.md` v0.8.0 evolution (integrated TSC per cn-sigma:.cn-sigma/threads/adhoc/20260623-tsc-integrated-into-dumb-models-essay.md).
- TSC canonical spec at cnos (`spec/`) — referenced §6 (barrier transform), §7 (calibration commons), §8 (admissibility), §12 (consistency).
- TSC engine at cnos (`engine/ocaml/`) — `coherence.ml` referenced §6.
- TSC runtime instruction (`runtime/SELF-MEASURE.md`) — referenced §4, §6.
- TSC schema (`schemas/skill.cue`) — `#CoherenceMethodology`, `#SelfMeasure`, `#CMOfCMs` referenced §1, §2, §5, §12.
- TSC branch `claude/tsc-self-measurement-vxifjo` — §8 admissibility state cited.
- cn-sigma adhoc `20260703-typed-skill-modules.md` — the form CM takes as SKILL.md frontmatter contract.
- cn-sigma adhoc `20260703-kappa-role-canonicalization.md` — the constrained-witness role §4 makes mechanical.
- cn-sigma adhoc `20260620-agents-need-a-home-doorway-essay.md` (companion posture: where work persists).

## Reviewer verification checklist (for cnos γ)

The essay names specific verification points a reviewer should be able to check against the TSC codebase. Compared to v4, several checks now expect the *updated* admissibility state:

- [ ] `#CoherenceMethodology` block exists in `schemas/skill.cue` with `standing_scope`, registry, targets, cross-target, scoring instruction, consistency protocol, mechanical signal inventory, LLM estimate contract (§2, §5).
- [ ] `validate-skill-frontmatter.sh` cross-checks declared paths, targets, mechanical signal codes, LLM estimate fields against source (§5).
- [ ] `coherence.ml` implements `phi`, `discrepancy_energy`, `coherence_link` with stated endpoint behavior (§6).
- [ ] Aggregate returns `c_sigma_math`, `c_sigma_num`, `epsilon`, `zero_component_present`, `numeric_floor_applied` (§6).
- [ ] Runtime instruction constrains LLM to output only δ + evidence + JSON contract; forbids computing Coh/CΣ (§4, §6).
- [ ] **`scripts/cm-admissibility.sh` stages anchors into neutral case directories, removes public paths, removes adjacent `kata.toml`, shuffles case order, preserves interior filenames, requires score+evidence JSON (§8).**
- [ ] **`scripts/cm-admissibility.sh` self-test rejects public-path lookup-table gamer alongside all-1.0 flatterer, admits engine backend (§8).**
- [ ] **Standing scope for public-commons admissibility is capped at `house-authored-public-commons` (§8, §9).**
- [ ] Consistency script computes max-abs-pairwise over 7 numeric fields, barrier-mapped (§12).
- [ ] **Schema/body agreement on LLM consistency gating status resolved per §12 coherent rule (mechanical hard gate + LLM off-diagonal-standing floor).**

If any of these fail against current TSC branch head, that is a coherence-of-essay-vs-implementation issue and should be surfaced before landing.

---

## Essay (verbatim — file at target path exactly as below, drop the section-separator line)


# All We Need Is Coherence

**The measurement law comes first**

**Status:** technical position essay, v5
**Audience:** AI engineers, agent-system builders, applied researchers, verification-minded reviewers
**Thesis:** An LLM system becomes coherence-aware only when a human-authored methodology defines what coherence means, a closed evidence bundle constrains the witness, deterministic machinery applies the math, and calibration limits how far the result may be trusted.

---

## Abstract

Large language models are strong local continuers. They can extend prompts, draft functions, revise paragraphs, inspect traces, and produce plausible plans. Local continuation is not the same as preserving a system.

The relevant failure is same-system failure: code, docs, tests, issue text, release notes, receipts, and handoffs stop describing one work object. A patch can pass tests while bending the architecture. A release note can be well written while describing the wrong change. A handoff can sound complete while binding the wrong evidence.

This essay argues that coherence measurement requires a measurement law. In TSC, that law is a **Coherence Methodology**: a human-authored, schema-validated specification of what counts as α pattern coherence, β relational coherence, and γ process coherence for a particular kind of object. The LLM does not invent coherence. The LLM is a constrained witness applying a declared methodology to a closed evidence bundle.

The current TSC branch defines a comparable `#CoherenceMethodology` contract in CUE, separates methodology authority from renderer authority, requires declared targets, a scoring instruction, consistency protocol, mechanical signal inventory, LLM estimate contract, prohibitions, and standing scope. The same schema defines `#SelfMeasure`, the 1st methodology applied to the TSC repo, and `#CMOfCMs`, the 0th methodology that measures coherence methodologies themselves.

The strongest claim is narrow:

**Coherence becomes operational when a project authority writes the methodology, the tool binds the evidence, the witness is constrained by that methodology, the engine applies the math, and the resulting standing is capped by the calibration actually earned.**

TSC does not replace truth, tests, proof, security review, empirical validation, or human responsibility. It gives those checks a stable object to attach to.

---

## 1. The source of ground truth

The central correction is this:

- The LLM is not the source of coherence.
- The score is not the source of coherence.
- The Coherence Methodology is the source of the measurement standard.

Without a methodology, asking an LLM whether a system is coherent is only a stylized judgment. The model may return α, β, γ, discrepancy values, evidence, and a bottleneck. But if the criteria were not fixed before judgment, the model can silently move the standard.

A Coherence Methodology, or CM, fixes the standard. It says what object is being measured, what evidence is in scope, which surfaces have authority, what each axis means in the domain, how discrepancy is estimated, what counts as a bottleneck, and what the report must contain.

For a repository, a CM can say:

```
α / pattern:
  code follows project standards;
  docs follow document standards;
  tests exist where behavior is claimed;
  names, schemas, concepts, and module boundaries are stable.

β / relation:
  docs match code;
  tests exercise claimed behavior;
  target manifests include the intended surfaces;
  release notes describe the actual change;
  no file claims authority contradicted by another authority surface.

γ / process:
  future change path is clear;
  generated and canonical files are distinguished;
  migration state is explicit;
  release boundaries are visible;
  the next coherent repair follows from the report.
```

This is not a model preference. It is a measurement contract.

CUE is appropriate for this layer because CUE constraints can validate concrete values from CUE, YAML, JSON, or other sources. In TSC, the CUE schema owns field shape, type, and enum constraints, while the validation script owns file discovery, frontmatter extraction, and cross-file checks that keep measurement declarations honest.

Ground truth therefore has layers:

- project authority writes the CM;
- schema validates the CM shape;
- target manifests declare the evidence scope;
- bundle construction freezes the evidence;
- witnesses judge under the CM;
- engine applies deterministic math;
- reports and receipts preserve the result;
- external controls test whether the CM tracks reality.

**The model appears only in the witness layer.**

---

## 2. The TSC stack

The operational TSC stack is:

```
CM        = measurement law
Target    = declared scope of evidence
Bundle    = ordered, closed evidence object
Witness   = mechanical scorer, LLM scorer, human scorer, or domain scorer
δ         = normalized discrepancy estimate under the CM
φ         = deterministic barrier transform
Coh       = deterministic coherence link
CΣ        = aggregate report with bottleneck and provenance
Receipt   = durable record of what was measured and accepted
Standing  = how far the result may be trusted
```

This separation is the architecture.

- A target answers: *what files or artifacts are in scope?*
- A CM answers: *what would it mean for those artifacts to form one system?*
- A witness answers: *how well does this evidence satisfy the CM?*
- The engine answers: *what does the deterministic math imply from the supplied values?*
- Standing answers: *how far has this measurement earned trust?*

The `#CoherenceMethodology` contract encodes this distinction. It requires a registry, targets, cross-target setting, scoring instruction, generated output root under `.tsc/`, default mode, consistency protocol, optional admissibility instrument, declared standing scope, mechanical backend and signal inventory, and LLM estimate contract. It also states that **standing scope promotes only when mechanics change, such as registered challengers and revealed held-out anchors, not by prose.**

- The methodology is the law.
- The target is the body.
- The bundle is the evidence.
- The witness is the reading.
- The engine is the arithmetic.
- The report is the artifact.
- **The standing scope is the trust boundary.**

---

## 3. CM²: the 0th methodology

TSC measures whether independent descriptions still describe one system. A coherence methodology is also a system. It has a declaration, an implementation, and an operating record. Therefore it can be measured.

**CM², the "CM of CMs," is the 0th methodology:** the methodology for measuring coherence methodologies. Its skill file states that a CM is measurable by the same triadic instrument because it has a declaration, implementation, and instrument behavior.

For ordinary corpora, the triad is:

- α = pattern coherence
- β = relational coherence
- γ = process coherence

For methodologies, CM² specializes the triad:

- **α = instrument self-agreement**
- **β = declaration ↔ implementation fit**
- **γ = instrument evolution**

A methodology weak on α is noisy: it cannot give the same reading on the same input.
A methodology weak on β is marketing: it claims a measurement it does not perform.
A methodology weak on γ is historically unusable: its numbers cannot be compared across its own versions.

This is the crucial move. **CM² makes the meter measurable.**

It also limits itself. A high self-score proves consistency, not correctness. Self-application is a hygiene gate only. A coherent methodology can still measure the wrong thing.

- Self-application closes the formal regress.
- It does not close the epistemic regress.

Correctness still comes from calibration commons, held-out anchors, adversarial challengers, outcome correlation, and external review.

---

## 4. The 1st methodology: TSC self-measurement

The 1st methodology is the TSC repo measuring itself. It asks whether the theory, implementation, runtime instruction, targets, examples, katas, reports, and release surfaces still describe one system.

The runtime instruction constrains the LLM witness. It says the task is not to summarize files but to measure whether the bundle forms one coherent system across α, β, and γ. It requires the witness to use only the provided bundle, not infer missing files, name insufficient evidence, report normalized δ values, cite evidence, identify the bottleneck, and output only the required JSON object.

This is the correct division of labor:

- CM supplies the standard.
- Target supplies the scope.
- Bundle supplies the evidence.
- LLM supplies bounded semantic estimates.
- Engine validates and computes.
- Report preserves the result.

The LLM must not compute final coherence values. The runtime instruction requires δ values and says the engine applies the barrier transform and computes coherence deterministically.

That boundary matters. If the LLM both sets the standard and grades the output, the system is circular. If the CM sets the standard and the engine applies the math, the LLM becomes a constrained witness.

---

## 5. Schema validation is not decoration

Methodology drift is a coherence failure.

A CM can claim one thing while the engine does another. It can declare a signal that does not exist. It can require an output field the runtime instruction does not ask for. It can point to a target not registered in the target registry.

The validation script exists to catch those failures. It validates every SKILL.md frontmatter block against `schemas/skill.cue`; for measurement skills, it also vets the typed methodology definition, checks declared paths, checks that declared targets resolve in the registry, checks that every declared mechanical signal code exists in the backend source, and checks that declared LLM estimate fields exactly match the scoring instruction's JSON output contract.

**That is β applied to the methodology itself.**

The grounding chain is executable:

```
methodology declaration
  → CUE validation
  → path existence checks
  → target resolution checks
  → mechanical-signal checks
  → LLM-output-contract checks
```

This does not prove the CM is correct. It proves the CM cannot silently claim one measurement and run another.

---

## 6. The deterministic math

The score pipeline is:

```
δ → φ(δ) → D → Coh → CΣ
```

The runtime instruction requires the witness to output normalized discrepancy values δ ∈ [0,1] for the αβ, βγ, and γα pairs. The engine then applies the canonical barrier transform φ(δ)=δ/(1−δ) and computes coherence as Coh=exp(−λ·φ(δ)).

The OCaml implementation follows that contract. `coherence.ml` implements `phi`, `discrepancy_energy`, and `coherence_link`; `phi` returns infinity for `delta >= 1`, and `coherence_link` returns 0.0 at `delta >= 1`.

The aggregate keeps two forms:

- `CΣ_math`
- `CΣ_num`

with flags:

- `zero_component_present`
- `numeric_floor_applied`
- `epsilon`

`CΣ_math` is zero if any component score is zero. `CΣ_num` uses an epsilon floor for numerical stability. Both forms are preserved in the result.

This design prevents a broken axis from disappearing inside an average. Strong α and γ cannot buy off a zero β. The bottleneck remains part of the report.

The rigor is downstream of δ. That is why the CM and calibration layers matter. **The math makes a validated signal flow correctly; it cannot make an unconstrained witness truthful.**

---

## 7. Calibration commons: controls, not proof

The calibration commons is where the methodology begins to touch reality.

The Game of Life glider example is a positive control. It expects high coherence because a 5-cell motif persists under translation through a period-4 Life orbit, with pattern, relation, and process descriptions agreeing. The random-soup example is a negative control. It expects low coherence because each time step is an independent Bernoulli grid; frames may have local structure, but they do not form one continuing process.

The adversarial kata is a different kind of control. It contains three sibling files that look canonical but contradict one another across files; each claims authority and chooses a different transport for the protocol's core invariant. The kata expects failure and names β as the bottleneck axis.

These controls are useful. They are not final validation.

They show that the instrument has anchors, expected failures, and regression surfaces. They do not prove the instrument catches naturally occurring incoherence in production agent workflows.

The commons becomes epistemically stronger only when it grows beyond the public house-authored set:

- external anchors;
- blind anchors;
- held-out anchors;
- misses published as new tests;
- adversarial CMs;
- outcome correlation against real review failures.

Until then, the honest claim is:

**The current commons is an executable calibration start, not final ground truth.**

---

## 8. Admissibility: what is now fixed

Earlier versions treated path blinding as future work. That is stale.

The current admissibility script stages every anchor into a neutral case directory before the scorer sees it. It removes the public `katas/` path, removes adjacent `kata.toml`, shuffles case order, preserves interior filenames, and requires the candidate scorer to return a JSON object containing both score **and evidence**. It rejects a low score with no evidence as unfalsifiable.

The script's self-test requires three outcomes:

- engine mechanical backend admitted;
- trivial all-1.0 flatterer rejected;
- public-path lookup-table gamer rejected.

The public-path gamer is now a regression case. The old path-keyed attack is closed.

This is progress, but the standing remains capped. The script explicitly preserves interior filenames because filenames are part of the measured artifact, and it names the residual leak: public basenames can still be memorized. For that reason, standing earned by this public battery is scoped only to `house-authored-public-commons`; held-out anchors are the only mechanism that can lift that scope.

Therefore current admissibility means:

- the candidate is not the trivial flatterer;
- the candidate is not the old public-path lookup table;
- the candidate can reproduce the public commons under staged paths;
- the candidate has *not* earned external standing.

It does not mean:

- the candidate measures coherence in general;
- the candidate cannot be tuned to the public five;
- the candidate can judge other CMs with full standing;
- the calibration commons is independent of the house.

**This distinction must stay visible. Otherwise the public commons becomes a credential rather than a test.**

---

## 9. The residual gamer

The remaining public-commons attack is simple.

A candidate can ignore coherence and key off preserved public basenames or public file contents. It can output scores tuned to the five public anchors and attach boilerplate evidence to satisfy the JSON contract.

That candidate measures nothing.

It can still pass the public battery because public anchors are public. The current script acknowledges this by capping standing scope at `house-authored-public-commons`.

The only real closure is held-out anchors.

The requirement is not more prose. The requirement is a commit-reveal mechanism:

```
1. Challenger registers a canonical CM digest.
2. Anchor author commits:
     sha256(salt || anchor_bundle || label || rationale || loss_function)
3. After the challenger digest is fixed, anchor author reveals:
     salt, anchor bundle, label, rationale, loss function.
4. Evaluator verifies:
     sha256(salt || anchor_bundle || label || rationale || loss_function)
   equals the prior commitment.
5. The challenger and incumbent are evaluated on the same revealed anchor.
6. Standing may promote only if the challenger beats the incumbent
   under the predeclared loss.
```

A held-out anchor is valid for a challenger only if the challenger's digest was fixed before reveal and the anchor content was not present in the challenger's registered bundle.

That gives the program a real second result:

- public basename/content gamer may pass public commons;
- the same gamer fails held-out anchors.

**Until that result exists, standing above public commons is architecturally described but empirically unearned.**

---

## 10. Evidence is not just existence

The current evidence rule blocks one failure: a low score with no evidence. That is necessary.

It is not sufficient.

A hostile auditor can cite real evidence and cherry-pick it. It can point to genuine debt notes, TODOs, unresolved limitations, or transitional docs and assign a catastrophic γ score while ignoring counterevidence that the debt is bounded, tracked, or already under repair.

So `credible_audit` cannot mean only:

- the cited evidence exists in the object bundle

It must mean:

- the cited evidence exists;
- the cited evidence is relevant to the claimed axis failure;
- the severity follows the CM's scale;
- counterevidence was considered or declared absent;
- the audit is not under unresolved dispute.

This creates a new required object: a **dispute record**.

```
audit_status:
  uncontested
  disputed
  accepted
  rejected
  provisional

adjudicator:
  house
  external_steward
  quorum
  automated_label
  mixed

standing_effect:
  accepted low audit enters maximin standing;
  disputed audit is reported but does not collapse standing;
  rejected audit is archived as a failed challenge;
  provisional audit affects only provisional standing.
```

If the house is the only adjudicator, house authority re-enters through the dispute layer. Therefore **the adjudicator must be named, and the standing effect must be explicit.**

A low audit should not collapse standing merely because it cites a real file. It should collapse standing only when its evidence, relevance, severity, and counterevidence treatment survive the dispute process.

---

## 11. Locked, frontier, and held-out controls

The locked/frontier distinction is useful, but it creates a new authority surface.

If the house can classify a contestable judgment as locked, the incumbent can freeze its own ground truth. If every control remains frontier, challengers can churn the commons by relabeling everything.

The default should be:

> new controls are frontier

A control becomes locked only after promotion:

```
locked_control(c) iff
  c has a public label and rationale;
  c has survived N independent CM readings;
  c has no active dispute;
  c has non-house provenance or stewardship;
  c has remained label-stable across a declared operating window.
```

Before those conditions hold, a challenger may flip the control by supplying evidence that survives commons review.

Held-out controls are separate. Their role is not long-term stability; their role is adversarial evaluation after challenger registration.

So the commons has three classes:

- **frontier:** contestable, evidence can flip it
- **locked:** stable enough to serve as public ground
- **held-out:** hidden until after challenger commitment

This prevents the incumbent from freezing house judgments while preserving a path to stable public ground.

---

## 12. Consistency: α applied to the meter

A methodology that cannot agree with itself is incoherent as an instrument.

CM² therefore includes a consistency protocol. The mechanical arm requires identical repeated results for the deterministic backend. The LLM arm samples repeated witness outputs against the same frozen prompt, computes the max absolute pairwise difference over numeric fields, and maps that spread through the TSC barrier into `Coh_consistency`.

This is α applied to the meter.

There is one current β issue to resolve before publication: the schema and body need to agree on whether LLM consistency is merely reported or gates off-diagonal standing. The `#CoherenceMethodology` standing field allows values such as `reported-not-gating`, `passed`, and `failed`, while the CM² body says the LLM arm is a standing gate below the floor.

The coherent rule is:

```
mechanical consistency:
  hard gate

LLM consistency:
  report always published;
  off-diagonal standing denied below the floor
```

That preserves evidence of instability without letting unstable witnesses act as auditors.

---

## 13. What CM² fixes

CM² fixes several earlier weaknesses.

### 13.1 It fixes "the LLM decides coherence"

The model no longer supplies the standard. The human-authored CM supplies the standard. The model supplies a bounded witness estimate under that standard.

### 13.2 It fixes "δ is free-floating"

δ is still estimated by a witness, but it is estimated under a methodology that defines admissible evidence, axis semantics, scale anchors, missing-evidence behavior, and report obligations.

### 13.3 It fixes "self-measurement is circular"

Self-application becomes a hygiene gate. It proves that the methodology is stable enough to compete. It does not prove that the methodology is correct.

### 13.4 It fixes "a scalar hides the failure"

TSC preserves α, β, γ, pairwise δ fields, bottleneck axis, mathematical aggregate, numerical aggregate, and degeneracy flags. The aggregate summarizes; it does not erase the axes.

### 13.5 It fixes "implementation can drift from declaration"

The validation script cross-checks declared paths, targets, mechanical signal codes, and LLM estimate fields against source files and the runtime instruction.

### 13.6 It does *not* fix "the commons is small"

The calibration commons remains the epistemic bottleneck. CM² names that bottleneck. It does not remove it.

That is progress: **dissolve the false problem, expose the real one.**

---

## 14. What remains unproven

The current evidence does not prove that TSC coherence scores correlate with expert human fit judgments across arbitrary software repositories, papers, proofs, or agent workflows.

The current evidence does not prove that every deployed α/β/γ witness is empirically independent in every domain.

The current evidence does not prove that an LLM witness estimates δ faithfully under every methodology.

The current evidence does not prove that TSC prevents incoherent agent changes in production systems.

The current evidence does not prove that public-commons admissibility gives standing beyond the public house-authored commons.

Those are validation tasks.

The next required tests are:

- **δ-fidelity:** fixed CM, injected discrepancies, compare witness δ to known labels
- **axis isolation:** cases where only α, only β, or only γ fails
- **same-work benchmark:** issue, patch, test, receipt, release note, and handoff with controlled mismatches
- **adversarial CM benchmark:** gamed methodologies, blinded anchors, held-out anchors, path-name attacks, basename attacks, boilerplate-evidence attacks, cherry-pick attacks
- **outcome correlation:** compare low coherence to review churn, reverts, drift, handoff failure, release confusion, and expert fit ratings

The strongest honest claim is:

**TSC now has a formal, schema-bound, executable architecture for measuring same-system preservation. Its broader validity must be established by methodology-specific benchmarks, held-out anchors, adversarial challengers, and external calibration.**

That claim is strong enough.

---

## 15. Why this matters for LLM agents

LLM agents fail in ways ordinary answer evaluation does not catch.

They fail when a tool result is summarized incorrectly.

They fail when a patch is right but the receipt binds the wrong evidence.

They fail when a release note describes a neighboring change.

They fail when a second agent resumes from a misleading handoff.

They fail when docs, code, tests, and issue state no longer describe one unit of work.

A coherent LLM agent should not run as:

```
prompt → answer
```

It should run as:

```
human-authored CM
  → target manifest
  → evidence bundle
  → candidate move
  → constrained witness report
  → deterministic TSC math
  → bottleneck
  → repair / refuse / commit
  → receipt
  → standing scope
```

A candidate move can be a patch, proof step, release note, migration, test, handoff, or documentation change.

The CM defines what coherence means for that object. The target defines what evidence is in scope. The bundle freezes the evidence. The witness estimates α, β, γ, δ values, confidence, evidence, ambiguity, and next fixes. The engine validates the response shape and applies the barrier and aggregate. The system either repairs, refuses, or commits with a durable receipt.

The model cannot decide that a release note is coherent because it sounds right. Under a repository CM, it must check whether the release note describes the actual change, whether tests exercise the claimed behavior, whether docs match code, and whether the future change path remains clear.

The model cannot decide that a repo is coherent because the README is polished. Under CM-0, it must check whether theory, implementation, target manifests, runtime instruction, examples, katas, and reports still describe one system.

**That is the shift from fluent generation to governed work.**

---

## 16. The next artifact

The next coherent artifact is not another essay section. It is a **held-out anchor system**.

Minimum files:

```
schemas/heldout-anchor.cue
schemas/challenger-registration.cue
scripts/cm-register-challenger.sh
scripts/cm-heldout-commit.sh
scripts/cm-heldout-reveal.sh
scripts/cm-heldout-evaluate.sh
scripts/cm-heldout-self-test.sh
anchors/heldout/commitments/
anchors/heldout/reveals/
anchors/heldout/results/
attackers/path-gamer.py
attackers/basename-gamer.py
attackers/flatterer.py
attackers/evidence-boilerplate-gamer.py
attackers/cherry-pick-assassin.py
```

Acceptance tests:

```
path-gamer:
  rejected by public blinded admissibility

basename-gamer:
  may pass public commons
  must fail held-out anchors

flatterer:
  rejected everywhere

evidence-boilerplate-gamer:
  rejected when low scores cite no relevant evidence

cherry-pick-assassin:
  enters dispute, not maximin standing,
  unless evidence relevance and severity survive adjudication
```

This would produce the next measured result:

- public commons can be gamed by basename/content memorization;
- held-out anchors reject the same gamer.

**That result matters more than expanding the manifesto.**

---

## 17. Why the title is defensible

"All We Need Is Coherence" is not literally sufficient.

We also need truth, tests, proof, security, evidence, domain expertise, accountability, and judgment.

The title is defensible only in this technical sense:

**Coherence is the condition under which those other checks can attach to the right object.**

If the work body is incoherent, tests validate the wrong behavior, evidence binds to the wrong claim, reviews inspect the wrong boundary, release notes describe the wrong change, and handoffs resume the wrong task.

Coherence is not correctness.

**Coherence is what lets correction find its target.**

---

## 18. Conclusion

The key insight is not:

> Ask the LLM whether the output is coherent.

That is too weak.

The key insight is:

- Write the methodology.
- Validate the methodology.
- Bind the evidence.
- Constrain the witness.
- Apply deterministic math.
- Preserve the bottleneck.
- **Cap standing by calibration actually earned.**
- Commit only with a receipt.

**CM² makes the meter measurable.** It says that a coherence methodology must agree with itself, match its declaration to its implementation, and evolve without making old readings meaningless. Self-application closes the formal regress, but correctness still belongs to calibration, adversarial testing, held-out evidence, and external reality.

That is the architecture:

```
human-authored CM
  + closed target bundle
  + constrained witness
  + deterministic TSC math
  + adversarial calibration
  + held-out anchors
  + dispute process
  + durable receipt
```

The model should not merely ask:

> What is the next plausible output?

It should be placed inside a system that asks:

> **Under the declared Coherence Methodology, does this next move still belong to the whole, and how far has this measurement earned standing?**

That is the shift from fluent generation to coherent work.
