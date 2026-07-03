# cnos essay proposal: All We Need Is Coherence — the measurement law comes first (v4)

**Mode:** `docs-only`
**Target path (proposed):** `cnos:docs/papers/ALL-WE-NEED-IS-COHERENCE.md`
**Suggested labels:** `docs`, `P2`, `area/essays`
**Filing directive to cnos γ:** Land essay verbatim at target path. Do NOT modify content. This is publication-grade external-facing material, authored by the operator; κ role at cn-sigma is `record` only.

**Version history (all 2026-07-03 same-day iterations except v3 which was operator-side private):**
- **v0:** *Coherent LLMs: Measuring Whether Generation Still Belongs to the Whole* — doorway-register public position essay.
- **v1:** *All We Need Is Coherence — a runtime discipline for whether an LLM's next move still belongs* — sharpened public-position; added §5 whole-is-hard-part, §10 circularity, §11 validation, §14 title defense.
- **v2:** *All We Need Is Coherence — a technical case for triadic runtime coherence in LLM systems* — technical-position register; C≡ carrier + explicit barrier transform + math/num aggregate split + public kata baselines + neuroscience anchor + witness/engine protocol + established-vs-not ledger + 6-benchmark validation program.
- **v3:** not captured at cn-sigma (operator-side private iterate, superseded by v4).
- **v4 (current):** *All We Need Is Coherence — the measurement law comes first* — governance-architecture register. Central claim: **the human-authored Coherence Methodology is the source of the measurement standard; the LLM is a constrained witness.** Introduces CM²/0th methodology, 1st methodology as executed artifact, schema-validation-as-β-on-methodology, standing thresholds, cryptographic held-out mechanics, credible_audit predicate. Absorbs the prior-round β review as normative content.

Bundle slug `coherent-llms-essay/` preserved across all versions.

**Evidence-bound constraint (operator's opening note at v4):** the ground truth is the human-authored Coherence Methodology, not the LLM and not the score.

## Why this belongs at cnos:docs/papers/

- Essay-genre content adjacent to `DUMB-MODELS-SMART-CELLS.md` and (v0.8.0's) TSC-integrated form. v4 extends TSC + cnos synthesis into a governance-architecture proposal.
- Cites the running TSC branch (`claude/tsc-self-measurement-vxifjo`, commit `1ab26ae`) throughout, including specific artifacts: `schemas/skill.cue` `#CoherenceMethodology`; `scripts/ci/validate-skill-frontmatter.sh`; `scripts/cm-consistency.sh`; `scripts/cm-admissibility.sh`; targets `spec`/`engine`/`repo`/`methodology`/`cm-of-cms`; `coherence.ml` — `phi`, `discrepancy_energy`, `coherence_link`; five katas 01–05.
- v4's §16 names five concrete validation tasks. Each maps to a future cnos or TSC research issue.

## Acceptance criteria

**AC1** — File landed at `cnos:docs/papers/ALL-WE-NEED-IS-COHERENCE.md` with essay body verbatim (no content edits).

**AC2** — Path/artifact repointing: essay references specific TSC paths (`schemas/skill.cue`, `scripts/*`, `engine/ocaml/coherence.ml`, target registry, katas 01–05, `runtime/SELF-MEASURE.md`). Verify each against `claude/tsc-self-measurement-vxifjo` head; report deltas if any resolve incorrectly.

**AC3** — Frontmatter added per `cnos.core/skills/agent/` convention if papers require it (title, date, class=`paper`, author=`operator`, version=`v4`); confirm from paper-family precedent in `docs/papers/`.

**AC4** — Bidirectional link added: `DUMB-MODELS-SMART-CELLS.md` cross-references this essay as companion (dumb models frames the substrate; this essay frames the measurement-law governance); `ALL-WE-NEED-IS-COHERENCE.md` cross-references DUMB-MODELS-SMART-CELLS as prerequisite.

**AC5** — I4 (link validation) green; I5 (frontmatter) green; goldens unaffected (no wake/skill changes in this cycle).

**AC6** — Release note entry captures the essay's landing as v4 governance-architecture essay.

**AC7** — TSC-branch implementation claims verified: `#CoherenceMethodology` exists in `schemas/skill.cue`; consistency script rejects noisy witnesses; admissibility script rejects all-1.0 flatterer and admits engine backend; cited CI run reports Success. Any diverging claim gets a companion PR with `v4.1` marker.

## Non-goals

- Do NOT edit or "improve" the essay content. Operator-authored; κ delivers verbatim.
- Do NOT split into multiple documents or restructure the section order.
- Do NOT publish externally in this cycle; that is a separate operator decision after landing at cnos.
- Do NOT implement any of the §16 validation tasks in this cycle; each is a separate future issue.
- Do NOT re-baseline TSC kata numbers in-place without a companion CI verification step (per AC7).

## Empirical anchors (cnos-side context)

- `DUMB-MODELS-SMART-CELLS.md` v0.8.0 evolution (integrated TSC per cn-sigma:.cn-sigma/threads/adhoc/20260623-tsc-integrated-into-dumb-models-essay.md).
- TSC canonical spec at cnos (`spec/`) — referenced §6 (C≡ carrier), §7 (barrier transform), §11 (calibration commons anchors), §12 (displacement).
- TSC engine at cnos (`engine/ocaml/`) — `coherence.ml` and `Coherence.aggregate` referenced §7, §15.
- TSC runtime instruction (`runtime/SELF-MEASURE.md`) — referenced §4, §7, §8.
- TSC schema (`schemas/skill.cue`) — `#CoherenceMethodology`, `#SelfMeasure`, `#CMOfCMs` referenced §1, §5, §15.
- TSC branch `claude/tsc-self-measurement-vxifjo` — §15 implementation-evidence section.
- cn-sigma adhoc `20260703-typed-skill-modules.md` — the form CM takes as SKILL.md frontmatter contract.
- cn-sigma adhoc `20260703-kappa-role-canonicalization.md` — the constrained-witness role §8 makes mechanical.
- cn-sigma adhoc `20260620-agents-need-a-home-doorway-essay.md` (companion posture: where work persists).

## Reviewer verification checklist (for cnos γ)

The essay names specific verification points a reviewer should be able to check against the TSC codebase:

- [ ] `#CoherenceMethodology` block exists in `schemas/skill.cue` with the fields §1 names.
- [ ] `validate-skill-frontmatter.sh` cross-checks declared paths, targets, mechanical signal codes, LLM estimate fields against source (§5).
- [ ] `coherence.ml` implements `phi`, `discrepancy_energy`, `coherence_link` with stated endpoint behavior (§7).
- [ ] Aggregate returns `c_sigma_math`, `c_sigma_num`, `epsilon`, `zero_component_present`, `numeric_floor_applied` (§7).
- [ ] Runtime instruction constrains LLM to output only δ + evidence + JSON contract; forbids computing Coh/CΣ (§4, §7, §8).
- [ ] Admissibility script rejects all-1.0 flatterer; admits engine backend; runs 5 anchors including comparative (§10).
- [ ] Consistency script computes max-abs-pairwise over 7 numeric fields, barrier-mapped (§9).
- [ ] Cited GitHub Actions run at commit `1ab26ae` reports Success.

If any of these fail against current TSC main, that is a coherence-of-essay-vs-implementation issue and should be surfaced before landing.

---

## Essay (verbatim — file at target path exactly as below, drop the section-separator line)


# All We Need Is Coherence

**The measurement law comes first**

**Status:** technical position essay, v4
**Audience:** AI engineers, agent-system builders, applied researchers, verification-minded reviewers
**Thesis:** An LLM system becomes coherence-aware only when a human-authored methodology defines what coherence means, a closed evidence bundle constrains the witness, and deterministic machinery applies the math.

---

## Abstract

Large language models are strong local continuers. They can extend prompts, draft functions, revise paragraphs, inspect traces, and produce plausible plans. Local continuation is not the same as preserving a system.

The relevant failure is same-system failure: code, docs, tests, issue text, release notes, receipts, and handoffs stop describing one work object. A patch can pass tests while bending the architecture. A release note can be well written while describing the wrong change. A handoff can sound complete while binding the wrong evidence.

This essay argues that coherence measurement requires a measurement law. In TSC, that law is a **Coherence Methodology**: a human-authored, schema-validated specification of what counts as α pattern coherence, β relational coherence, and γ process coherence for a particular kind of object. The LLM does not invent coherence. The LLM is a constrained witness applying a declared methodology to a closed evidence bundle.

The current TSC branch implements this idea through a typed `#CoherenceMethodology` contract, a 1st methodology for self-measuring the TSC repo, and a 0th methodology, **CM²**, that measures coherence methodologies themselves. The CM² skill defines α for methodologies as instrument self-agreement, β as declaration-to-implementation fit, and γ as instrument evolution across versions. It also states the core limitation: self-application is a hygiene gate, not proof of correctness. **A coherent methodology can still measure the wrong thing.**

The strongest claim is therefore narrow:

**Coherence becomes operational when a project authority writes the methodology, the tool binds the evidence, the witness is constrained by that methodology, and the engine applies the math.**

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
  tests exercise the claimed behavior;
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

In the TSC branch, that contract is represented in `schemas/skill.cue` as `#CoherenceMethodology`, described as a CUE-typed skill block for measuring the coherence of a presented thing. The schema separates methodology authority from renderer authority: the methodology owns what the measurement is, while the renderer owns substrate encoding such as YAML structure, workflow layout, and action bindings.

CUE is appropriate for this layer because it supports constraints that validate concrete data from CUE, YAML, JSON, or other sources. The CUE schema does not prove the methodology is right. It proves the methodology is well-formed enough to run and review.

Ground truth therefore has layers:

- project authority writes the CM;
- schema validates the CM shape;
- target manifests declare the evidence scope;
- bundle construction freezes the evidence;
- witnesses judge under the CM;
- engine applies deterministic math;
- reports and receipts preserve the result;
- external controls test whether the CM tracks reality.

The model appears only in the witness layer.

---

## 2. The TSC stack

The operational TSC stack is:

```
CM       = measurement law
Target   = declared scope of evidence
Bundle   = ordered, closed evidence object
Witness  = mechanical scorer, LLM scorer, human scorer, or domain scorer
δ        = normalized discrepancy estimate under the CM
φ        = deterministic barrier transform
Coh      = deterministic coherence link
CΣ       = aggregate report with bottleneck and provenance
Receipt  = durable record of what was measured and accepted
```

This separation is the whole architecture.

- A target answers: *what files or artifacts are in scope?*
- A CM answers: *what would it mean for those artifacts to form one system?*
- A witness answers: *how well does this evidence satisfy the CM?*
- The engine answers: *what does the deterministic math imply from the supplied values?*

The current branch's target registry includes named targets for `spec`, `engine`, `repo`, `methodology`, and `cm-of-cms`. The `methodology` target is an aggregate corpus containing the self-measurement skill, schema, validators, renderer, rendered surfaces, scoring instruction, target manifests, and engine modules named by the pipeline.

**That target is not itself the methodology. It is the corpus by which the methodology can be measured.**

- The methodology is the law.
- The target is the body.
- The bundle is the evidence.
- The witness is the reading.
- The engine is the arithmetic.
- The report is the artifact.

---

## 3. CM²: the 0th methodology

TSC measures whether independent descriptions still describe one system. A coherence methodology is also a system. It has a declaration, an implementation, and an operating record. Therefore it can be measured.

**CM², the "CM of CMs," is the 0th methodology:** the methodology for measuring coherence methodologies. Its skill file states that it measures whether a CM's declaration, implementation, and instrument behavior still describe one system.

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

It also limits itself. The CM² skill says a high self-score proves consistency, not correctness, and calls self-application a hygiene gate only. That sentence prevents the self-reference from becoming metaphysics.

- Self-application closes the formal regress.
- It does not close the epistemic regress.

Correctness still comes from calibration commons, held-out anchors, adversarial challengers, outcome correlation, and external review.

---

## 4. The 1st methodology: TSC self-measurement

The 1st methodology is the TSC repo measuring itself. Its skill file says it declares the full self-measurement procedure: the targets, deterministic mechanical work, and the narrowly scoped cognitive task delegated to an LLM. Its frontmatter is validated against `#SelfMeasure`, and the declared signal codes and estimate fields are cross-checked against the engine source and scoring instruction so the declaration cannot silently drift from what runs.

The self-measurement skill declares three targets:

- `spec`
- `engine`
- `repo`

It also declares `cross_target: true`, meaning the self-measurement procedure can ask whether theory, implementation, and aggregate repo state still describe one system.

The skill sharply constrains the LLM witness:

- read only the emitted prompt;
- write only one response JSON;
- do not compute Coh or CΣ;
- do not output anything except the required JSON object.

The engine, not the model, applies the barrier transform and aggregate forms after validating the response.

That is the right division of labor. The model supplies bounded semantic judgment. The methodology supplies the standard. The engine supplies deterministic transformation. The repo supplies the durable record.

---

## 5. Schema validation is not decoration

The schema layer matters because methodology drift is itself a coherence failure.

The validation script for skill frontmatter validates every SKILL.md against `schemas/skill.cue`. For measurement skills, it also performs cross-file checks: declared paths must exist, declared targets must resolve in the registry, declared mechanical signal codes must exist in the engine backend, and declared LLM estimate fields must exactly match the scoring instruction's JSON output contract.

**That is β applied to the methodology itself.**

A methodology cannot merely say it measures `delta_beta_gamma`; that field must exist in the runtime output contract. A methodology cannot merely list `alpha.naming_drift`; that signal must exist in the mechanical backend source. A methodology cannot point to a registry, instruction, or backend path that does not exist.

This is how the system prevents the methodology from becoming detached prose.

The branch also distinguishes two methodology blocks: `self_measure` for the deployed 1st methodology and `cm_of_cms` for the essence-only 0th methodology. The validator chooses the appropriate CUE definition based on which block is present.

So the grounding chain is executable:

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

## 6. The mathematical foundation

The formal foundation of TSC is C≡.

C≡ defines a term algebra:

```
T ::= e | a | tri(T1, T2, T3)
```

where `e` represents unarticulated wholeness, `a` is an atom, and `tri(T1,T2,T3)` is the three-position constructor. The C≡ specification presents this as a formal language for how indivisible wholeness articulates itself and introduces the triadic constructor as the structure that holds differentiation without collapse.

C≡ then grounds the three evaluators:

- α = pattern / quantitative extent
- β = relation / positional presence
- γ = process / depth of self-differentiation

The important technical claim is not that every deployed α/β/γ witness is empirically independent. The formal claim is narrower: the evaluators are distinct at the algebraic level. The deployed claim must be tested domain by domain.

That gives the correct chain:

- C≡ gives formal triadic distinction.
- CM maps that distinction into a domain.
- Witnesses estimate under that mapping.
- Validation tests whether the mapping works.

Skipping the CM layer breaks this chain. It asks a model to operationalize α, β, and γ ad hoc. TSC's architecture should not do that.

---

## 7. The deterministic score pipeline

TSC's score pipeline is:

```
δ → φ(δ) → D → Coh → CΣ
```

The runtime instruction tells the LLM witness not to output coherence values directly. It must output normalized discrepancy values δ ∈ [0,1] for the αβ, βγ, and γα pairs. The engine applies the barrier transform φ(δ)=δ/(1−δ) and computes Coh=exp(−λ·φ(δ)) deterministically.

The OCaml implementation follows that contract. `coherence.ml` implements `phi`, `discrepancy_energy`, and `coherence_link`; `phi` returns infinity for `delta >= 1`, and `coherence_link` returns 0.0 at `delta >= 1`.

The aggregate is also explicit. The implementation returns both:

- `CΣ_math`
- `CΣ_num`

with flags:

- `zero_component_present`
- `numeric_floor_applied`
- `epsilon`

`CΣ_math` is zero if any component score is zero. `CΣ_num` uses an epsilon floor for numerical stability. Both forms are preserved in the result.

This matters because the numerical score is not allowed to hide degeneracy. A near-perfect α and γ cannot buy off a zero β. The bottleneck remains visible.

The mathematical rigor is therefore downstream of δ. That is fine, provided δ is constrained by a CM and validated by controls.

---

## 8. The witness is constrained, not sovereign

The LLM witness is given a narrow job. The runtime instruction says its task is not to summarize files, but to determine whether the bundle forms one coherent system across α, β, and γ. It must use only the provided bundle, avoid outside knowledge unless explicitly asked, name insufficient evidence, cite bundle evidence for each axis, identify the bottleneck, and return only the specified JSON object.

The instruction also defines low-axis interpretations:

- low α: naming drift, duplication, contradiction, unstable conceptual structure
- low β: authority confusion, repeated facts with drift, docs disagreeing with code, declared relationships not borne out by the bundle
- low γ: transitional ambiguity, unclear ownership of future change, no stable change path

Those are not optional vibes. They are the witness contract.

CM² uses the same witness contract for methodologies. The model is a witness over a CM corpus, not an authority over CMs.

That is the LLM-safety point of the architecture:

- The model may judge.
- The model may not set the law.
- The model may not compute the final score.
- The model may not read outside the bundle.
- The model may not write outside its response artifact.
- The model may not silently turn a malformed response into a report.

**The witness is cognitive. The boundary is mechanical.**

---

## 9. Consistency: α applied to the meter

A methodology that cannot agree with itself is incoherent as an instrument.

CM² therefore includes a consistency protocol. The mechanical arm runs the deterministic backend multiple times over the same target and requires the score-relevant subset to be bit-identical. Any divergence is a hard failure. The LLM arm computes max absolute pairwise spread over seven numeric fields—α, β, γ, the three δ fields, and confidence—and maps that spread through the same TSC barrier into `Coh_consistency`.

This is α applied to the meter.

For deterministic scoring:

```
same bundle + same config → same score-relevant report
```

For LLM scoring:

```
same frozen prompt + repeated witness calls → bounded numeric spread
```

A noisy LLM witness may still produce a report, but it should not receive full standing as an auditor. The consistency number should therefore become part of methodology admissibility and displacement, not merely an informational field.

A strict standing rule would be:

```
green:  δ_consistency ≤ 0.05                → full standing
amber:  0.05 < δ_consistency ≤ 0.10         → report allowed, but cannot displace alone
red:    δ_consistency > 0.10                → no off-diagonal standing
```

This is not yet proven by the branch. It is the next coherent rule implied by CM².

---

## 10. Admissibility: rejecting trivial meters

CM² includes an admissibility instrument. A CM's scores of other CMs carry standing only if the CM first reproduces the calibration commons: the kata anchors with agreed labels. The script runs a candidate scorer over four single-bundle anchors and one ranking check. It also includes a self-test: the engine's mechanical backend must be admitted, while the trivial all-1.0 flatterer must be rejected.

The current admissibility battery checks:

- `01-glider`: positive control
- `02-random-soup`: negative control
- `04-philosophical`: mechanical-scoring ceiling / surface-regular prose trap
- `05-adversarial`: cross-file semantic contradiction trap
- `03-comparative`: glider must rank above random soup

The script's own comment states the key rule: self-score plays no part in admissibility; discrimination does.

That is correct, but insufficient.

A non-trivial attacker could key off public file paths and output hard-coded scores for known katas. The current scorer contract invokes a command on file paths and asks it to print one number in [0,1], so a path-name attacker is not excluded by the current interface.

The next version of admissibility should therefore blind anchors:

- copy anchors to a temp bundle;
- rename files to salted opaque paths;
- strip path strings that reveal kata identity;
- require evidence-bearing reports, not only scalar scores;
- include generated mutants;
- use held-out anchors committed before reveal.

The current script proves the system rejects the trivial flatterer. It does not prove the system rejects every gamed CM.

That is not a fatal flaw. It is a precisely named γ task.

---

## 11. Calibration commons: where epistemic authority lives

Self-application cannot create ground truth. It can only show that a methodology is internally stable enough to be judged.

CM² states this directly: the epistemic anchor is the calibration commons, and today that commons is a small, house-authored battery.

That honesty is essential.

The commons currently includes Game of Life positive and negative controls. The glider example expects high coherence because a 5-cell motif persists under translation through a period-4 Life orbit, with pattern, relation, and process descriptions agreeing. The random-soup example expects low coherence because each frame is an independent Bernoulli grid; frames may have local structure, but they do not form one continuing process.

The commons also includes a philosophical-prose kata that documents a limitation: mechanical scoring can over-rate surface-regular natural language because headings, version stamps, and cross-references are present even when the semantic target is not a coherent TSC system. The adversarial kata documents cross-file contradiction: three files look canonical but each claims authority and chooses a different transport for the protocol's core invariant.

These are controls, not final validation.

They establish that the instrument has known anchors and known failure boundaries. They do not prove the instrument catches naturally occurring incoherence in production agent workflows.

The commons becomes epistemically meaningful only when it grows beyond the house:

- external anchors;
- blind anchors;
- held-out anchors;
- misses published as new tests;
- adversarial CMs;
- outcome correlation against real review failures.

Until then, the honest claim is:

**The current commons is an executable calibration start, not a final ground truth.**

---

## 12. Displacement: how a better CM can beat the incumbent

CM² allows adversarial methodologies. Any conforming CM can score another CM. That creates a directed matrix:

```
S[A][B] = score assigned by methodology A to methodology B's corpus
```

CM² notes that raw head-to-head wins need not compose: A can beat B on A's terms, B can beat C on B's terms, and C can beat A on C's terms. It therefore proposes standing as off-diagonal and maximin: a methodology's standing is constrained by the worst score it receives from credible admissible auditors.

That is directionally right, but the word *credible* needs executable definition.

A stricter rule:

```
credible_audit(A, B) iff
  A passes schema validation;
  A passes blinded calibration commons;
  A passes self-application hygiene;
  A passes consistency standing threshold;
  A supplies bundle-grounded evidence for every low score;
  the cited evidence exists in B's bundle;
  the audit is not under unresolved dispute.
```

Then:

```
standing(B) = min S[A][B] over credible_audit(A, B)
```

This preserves the bottleneck principle without letting any admitted troll collapse a methodology by assertion.

The displacement rule also needs a clean treatment of control types. CM² currently says a challenger must pass admissibility, discriminate better on shared held-out anchors published after it was authored, and agree with the incumbent on uncontested controls.

The missing distinction is:

- **locked controls:** verdict cannot flip without changing the commons itself
- **frontier controls:** verdict may flip if the challenger supplies evidence and the commons accepts the update
- **held-out controls:** hidden from the challenger until after its CM digest is fixed

A better CM should not lose merely because it flips a frontier verdict for a good reason. But it should not win by redefining every control.

Use labels and rankings, not raw score agreement:

- **locked agreement:** `label_C(k) = commons_label(k)`
- **ranking agreement:** `sign(score_C(a) − score_C(b)) = commons_order(a,b)`
- **frontier update:** challenger may flip only through evidence accepted into the commons

Held-out mechanics should use commitments, not timestamps:

```
1. Publish challenger digest:
     cm_digest = sha256(canonical_cm_bundle)
2. Commit hidden anchor:
     anchor_commitment = sha256(salt || anchor_bundle || label || rationale)
3. After challenger digest is fixed, reveal:
     salt, anchor_bundle, label, rationale
4. Verify commitment equality.
```

This makes "published after the challenger was authored" enforceable through hashes and commit ancestry rather than trust in wall-clock timestamps.

---

## 13. What CM² fixes

CM² fixes several earlier weaknesses.

### 13.1 It fixes "the LLM decides coherence"

The model no longer supplies the standard. The human-authored CM supplies the standard. The model supplies a bounded witness estimate under that standard.

### 13.2 It fixes "δ is free-floating"

δ is still estimated by a witness, but it is now estimated under a methodology that defines admissible evidence, axis semantics, scale anchors, missing-evidence behavior, and report obligations.

### 13.3 It fixes "self-measurement is circular"

Self-application becomes a hygiene gate. It proves that the methodology is stable enough to compete. It does not prove that the methodology is correct.

### 13.4 It fixes "a scalar hides the failure"

TSC preserves α, β, γ, pairwise δ fields, bottleneck axis, mathematical aggregate, numerical aggregate, and degeneracy flags. The aggregate summarizes; it does not erase the axes.

### 13.5 It fixes "implementation can drift from declaration"

The validation script cross-checks declared paths, targets, mechanical signal codes, and LLM estimate fields against source files and the runtime instruction.

### 13.6 It does *not* fix "the commons is small"

The calibration commons remains the epistemic bottleneck. CM² names that bottleneck. It does not remove it.

That is the right shape of progress: **dissolve the false problem, expose the real one.**

---

## 14. The runtime loop for LLM agents

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
```

A candidate move can be a patch, proof step, release note, migration, test, handoff, or documentation change.

The CM defines what coherence means for that object. The target defines what evidence is in scope. The bundle freezes the evidence. The witness estimates α, β, γ, δ values, confidence, evidence, ambiguity, and next fixes. The engine validates the response shape and applies the barrier and aggregate. The system either repairs, refuses, or commits with a durable receipt.

This is how the model is constrained.

It cannot decide that a release note is coherent because it sounds right. Under a repository CM, it must check whether the release note describes the actual change, whether tests exercise the claimed behavior, whether docs match code, and whether the future change path remains clear.

It cannot decide that a repo is coherent because the README is polished. Under CM-0, it must check whether theory, implementation, target manifests, runtime instruction, examples, katas, and reports still describe one system.

**That is the shift from fluent generation to governed work.**

---

## 15. Implementation evidence

The branch evidence supports the following implementation claims.

The branch defines `#CoherenceMethodology` as a comparable contract for methodology skills, including registry, targets, scoring instruction, output root, default mode, consistency protocol, mechanical signal inventory, LLM estimate contract, prohibitions, and validation route.

The branch defines CM² as the 0th methodology and maps α, β, and γ for methodologies to instrument self-agreement, declaration-to-implementation fit, and instrument evolution.

The branch defines a self-measurement methodology for the TSC repo that delegates only a narrow cognitive task to the LLM and prohibits the LLM from computing final coherence values.

The branch validates methodology frontmatter against CUE and cross-checks declared signals and estimate fields against engine source and the runtime instruction.

The branch implements deterministic barrier and aggregate math in OCaml, including strict endpoint behavior, mathematical and numerical aggregate forms, zero-component tracking, and numeric-floor tracking.

The branch includes a consistency script for repeated mechanical and LLM witness readings, and an admissibility script that rejects the trivial all-1.0 attacker while admitting the engine's mechanical backend.

The cited GitHub Actions run on branch `claude/tsc-self-measurement-vxifjo` at commit `1ab26ae` reports status Success, with mechanical and three LLM-witness jobs completed and four artifacts produced.

These are implementation facts, not claims of universal validity.

---

## 16. What remains unproven

The current evidence does not prove that TSC coherence scores correlate with expert human fit judgments across arbitrary software repositories, papers, proofs, or agent workflows.

The current evidence does not prove that every deployed α/β/γ witness is empirically independent in every domain.

The current evidence does not prove that an LLM witness estimates δ faithfully under every methodology.

The current evidence does not prove that TSC prevents incoherent agent changes in production systems.

Those are validation tasks.

The next required tests are:

- **δ-fidelity:** fixed CM, injected discrepancies, compare witness δ to known labels
- **axis isolation:** cases where only α, only β, or only γ fails
- **same-work benchmark:** issue, patch, test, receipt, release note, and handoff with controlled mismatches
- **adversarial CM benchmark:** gamed methodologies, blinded anchors, held-out anchors, path-name attacks
- **outcome correlation:** compare low coherence to review churn, reverts, drift, handoff failure, release confusion, and expert fit ratings

The strongest honest claim is:

**TSC now has a formal, schema-bound, executable architecture for measuring same-system preservation. Its broader validity must be established by methodology-specific benchmarks and external calibration.**

That claim is strong enough.

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
- Commit only with a receipt.

**CM² makes the meter measurable.** It says that a coherence methodology must agree with itself, match its declaration to its implementation, and evolve without making old readings meaningless. Self-application closes the formal regress, but correctness still belongs to the calibration commons and to external reality.

That is the architecture:

```
human-authored CM
  + closed target bundle
  + constrained witness
  + deterministic TSC math
  + adversarial calibration
  + durable receipt
```

The model should not merely ask:

> What is the next plausible output?

It should be placed inside a system that asks:

> **Under the declared Coherence Methodology, does this next move still belong to the whole?**

That is the shift from fluent generation to coherent work.
