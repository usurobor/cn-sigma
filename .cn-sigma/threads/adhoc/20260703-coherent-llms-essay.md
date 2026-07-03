# All We Need Is Coherence — a technical case for triadic runtime coherence in LLM systems (v2)

**Date:** 2026-07-03
**Class:** doctrine-evolution (technical position essay; operator-authored; third in the doorway-essay lineage)
**Author:** Operator (usurobor / Axiom); Sigma-at-cn-sigma (κ-body) records verbatim
**Source:** Operator-supplied essay delivered in session, 2026-07-03, v2. Prior versions v0 and v1 same day. Captured today alongside six sibling adhocs written today plus retro-backfills for earlier events. The doorway essays it joins (Agents Need a Home; Dumb Models, Smart Cells) were written earlier — 2026-06-20.

**Prior titles (superseded 2026-07-03, same day):**
- v0: *Coherent LLMs: Measuring Whether Generation Still Belongs to the Whole*
- v1: *All We Need Is Coherence — a runtime discipline for whether an LLM's next move still belongs*
- **v2 (current):** *All We Need Is Coherence — a technical case for triadic runtime coherence in LLM systems*

Subtitle change (v1 → v2) reflects the material register shift from public-position essay to technical-position essay defensible under review.

## Why this is captured here

Third essay in the doorway lineage:

- **[Agents Need a Home](20260620-agents-need-a-home-doorway-essay.md)** — defines the *home*: where agent identity, memory, work, and receipts survive the chat session.
- **[Dumb Models, Smart Cells](20260620-dumb-models-smart-cells-essay.md)** — defines *what lives in the home*: bounded work-units with a body outside the model.
- **This essay ("All We Need Is Coherence")** — defines *the measurement discipline* that tells whether the local move still belongs to the whole.

The three read as a triptych: home → cells → coherence measurement. Each is project-position-from-inside, publication-grade, external-facing. All three land at cn-sigma as adhocs by the same convention (project-position, not cnos doctrine); cnos owns publication-side placement at `docs/papers/`.

Adhoc form here so cn-sigma memory holds the essay as directly referenceable text, not only via a bundle. A companion bundle exists at `.cdd/iterations/cross-repo/cnos/coherent-llms-essay/` for cnos γ intake and eventual landing at `cnos:docs/papers/ALL-WE-NEED-IS-COHERENCE.md`.

## What changed from v1 (insight-wise deltas)

Substantive iteration to a **technical-position register defensible under review**. Key deltas:

- **Formal ground surfaces.** v2 cites the C≡ term algebra (finite triadic terms, normalization, three algebraically-distinct evaluators). The α/β/γ independence claim gets algebraic grounding (pairwise non-isomorphic monoids by idempotent profile), not empirical hand-wave.
- **The barrier transform, made explicit** (§4). δ → φ(δ) → D → Coh with φ(δ) = δ/(1−δ). Near-total discrepancy collapses coherence to ~0 exponentially by construction. No moral rule needed — endpoint behavior is baked into the math.
- **Aggregate split** (§5): C_Σ^math (strict; zero collapses) vs C_Σ^num (ε-floored for stable numerical compute). Both reported; `zero_component_present` + `numeric_floor_applied` flags in provenance; when zero-flag is true, verdict is failure regardless of numerical value. Degeneracy preserved through the aggregate, not laundered by it.
- **Public controls demonstrated numerically** (§7–§8): Game of Life glider (positive, C_Σ ≈ 0.917) vs random soup (negative, C_Σ ≈ 0.6583) vs adversarial-authority kata (C_Σ ≈ 0.7145, β = 0.470 as bottleneck). Arithmetic mean of adversarial would be 0.7467 — repair-vector-over-scalar becomes empirical demonstration.
- **Cross-domain grounding via neuroscience** (§9): scalar EEG/MEG spectral coherence has known failure modes (Dowdall bidirectional-delay case). TSC's triadic form is positioned as a stricter target shape; scalar coherence becomes one witness inside a larger test.
- **"Dissolves" replaces "solves"** (§10). Five confusions dissolved by changing the measurement object. Humbler and more precise.
- **Runtime protocol split** (§11.4–§11.5): model estimates normalized pairwise discrepancies δ_αβ, δ_βγ, δ_γα; engine applies the barrier transform and computes aggregates. Report schema names required fields explicitly.
- **Explicit epistemic ledger** (§13): established in public TSC materials / established by external literature / **not established yet**. Names precisely what's not proven (no correlation-with-expert-fit-judgments studies; no statistical-independence-across-domains proof; no production-agent-prevention efficacy demonstration).
- **Refined falsifiable claim:** "A TSC loop should reduce same-system failures that ordinary local task-performance loops miss." Not "TSC always wins."

The rhetorical arc: **v0 manifesto → v1 self-critique + validation-needed → v2 formal-system + falsifiable benchmarks with predicted responses.**

## Evidence-bound constraint (operator's opening note)

Operator explicitly stated at delivery: Game of Life is publicly represented in the TSC repo as example/control and in katas; neural coherence is grounded through external neuroscience literature and mapped into TSC's measurement form, but the essay does *not* claim a public TSC neural-correlation result unless there is a public artifact to cite.

This is the essay's own doctrine applied to itself at write-time: no claims without citable public artifacts.

## Doctrine-center recognition

v2 sharpens the alignment with today's other adhocs:

- **§2 formal carrier** — algebraic ground for the triadic structure that today's `20260703-typed-skill-modules.md` uses as the SKILL.md-frontmatter contract shape. Typed contracts in cnos.core/cnos.cds are the same structural insight (three-position articulation) at the skill-module altitude.
- **§4 barrier transform** — the discrepancy-to-coherence math that `20260703-discipline-failures-become-typed-gates.md` names in prose: near-total gap collapses trust; typed gates are the mechanical implementation.
- **§5 aggregate split + degeneracy preservation** — `20260703-cross-repo-bundle-pattern.md`'s bundle STATUS ledger is the durable analog: multiple event states are preserved, not averaged; ε-floor equivalent is the "drafted" state before ledger events accumulate.
- **§6 mechanical vs semantic scorer separation** — the κ role of `20260703-kappa-role-canonicalization.md`: κ (LLM semantic witness) can measure but is not sovereign; mechanical scoring (typed gates) provides the deterministic layer.
- **§7–§8 public examples with baselines** — the empirical equivalent of `20260626-cycle497-model-b-and-kappa-emergence.md`'s R1 recovery: a documented, reproducible case demonstrating the doctrine.
- **§9 scalar-coherence limitations via neuroscience** — the same axis-split pattern the `20260623-tsc-integrated-into-dumb-models-essay.md` capture named (trust ≠ coherence): single-metric arguments get dissolved into multi-witness reports.
- **§10 "dissolves" framing** — the `20260703-discipline-failures-become-typed-gates.md` principle applied to conceptual traps: don't argue harder; change the measurement object.
- **§11 runtime protocol** — the general form of the CDD cycle with explicit role division (author ≠ witness ≠ authority).
- **§13 established-vs-not ledger** — the epistemic-honesty discipline that would prevent the date-misreading, staleness, and κ-overstep instances this session logged.
- **§14 validation program** — six concrete benchmarks with predicted TSC responses. Each is a natural cnos future issue candidate (via bundle when substantive).

## Iteration trail

- **v0 (session earlier, 2026-07-03):** Coherent LLMs — Measuring Whether Generation Still Belongs to the Whole. Doorway-register.
- **v1 (later 2026-07-03):** All We Need Is Coherence — a runtime discipline for whether an LLM's next move still belongs. Compressed title; added §5 whole-is-hard-part, §10 circularity, §11 validation tests, §14 title defense; sharper §6.6 refuse and §8 role separation.
- **v2 (current, 2026-07-03):** All We Need Is Coherence — a technical case for triadic runtime coherence in LLM systems. Grounded in C≡ formal carrier; explicit barrier transform; aggregate split; public example baselines; neuroscience anchor; "dissolves" framing; refined runtime protocol; explicit epistemic ledger; six-benchmark validation program with predicted responses.

Each version supersedes the previous *as canonical*. v0 and v1 preserved via commit history and the STATUS ledger at the bundle.

κ role: `record` verbatim. No content edits proposed by κ.

## Forward-looking notes

- **External publication** is a separate operator decision. This adhoc and the bundle secure the internal canonical record.
- **v2 supersedes v1 as canonical** at both cn-sigma (this adhoc) and the bundle. Future readers should treat the v2 essay body below as the authoritative text.
- **§14 validation program items are the next research surface.** Each is a concrete future cnos issue candidate. Six benchmarks: axis-independence, same-work, domain-aware cellular-automata, mechanical-scorer boundary, adversarial authority, LLM-agent intervention. Predicted TSC responses named for each.
- **Cross-references from cnos:docs/papers/DUMB-MODELS-SMART-CELLS.md** may need updates when the essay lands at cnos target path. AC4 in the bundle ISSUE.md captures this.

## Related artifacts

- **[20260620-agents-need-a-home-doorway-essay.md](20260620-agents-need-a-home-doorway-essay.md)** — doorway essay 1 (home).
- **[20260620-dumb-models-smart-cells-essay.md](20260620-dumb-models-smart-cells-essay.md)** — doorway essay 2 (cells).
- **[20260623-tsc-integrated-into-dumb-models-essay.md](20260623-tsc-integrated-into-dumb-models-essay.md)** — TSC integration precedent for essay-family evolution.
- **[20260703-typed-skill-modules.md](20260703-typed-skill-modules.md)** — the form the coherence loop takes when instrumented.
- **[20260703-kappa-role-canonicalization.md](20260703-kappa-role-canonicalization.md)** — the role §6/§8 role-separation frames.
- **[20260626-cycle497-model-b-and-kappa-emergence.md](20260626-cycle497-model-b-and-kappa-emergence.md)** — lived cycle where §11 runtime loop played out.
- **[20260703-discipline-failures-become-typed-gates.md](20260703-discipline-failures-become-typed-gates.md)** — the recursive principle §10 informs.
- **[20260703-cross-repo-bundle-pattern.md](20260703-cross-repo-bundle-pattern.md)** — the pattern the companion bundle uses.
- **[20260703-from-sense-of-fit-to-coherent-llms.md](20260703-from-sense-of-fit-to-coherent-llms.md)** — the genealogy that leads to this essay.
- **cn-sigma:.cdd/iterations/cross-repo/cnos/coherent-llms-essay/** — companion bundle (canonical for cnos publication path); STATUS ledger records v0/v1/v2.
- **cnos:TSC** — spec/, engine/ocaml/, runtime/SELF-MEASURE.md, targets/, katas/, examples/ — the artifacts v2 cites throughout.
- **cnos:docs/papers/DUMB-MODELS-SMART-CELLS.md** — immediate paper-family neighbor.

---

## Essay (verbatim, v2)

# All We Need Is Coherence

**A technical case for triadic runtime coherence in LLM systems**

**Status:** technical position essay, v2
**Audience:** AI engineers, agent-system builders, applied researchers, verification-minded reviewers
**Thesis:** LLM systems need a runtime test for whether a generated move still belongs to the whole it is modifying. TSC supplies a formal and executable basis for that test.

---

## Abstract

Large language models are strong local continuers. They can extend prompts, draft functions, revise paragraphs, inspect traces, and produce plausible plans. That is not the same as preserving a system.

The relevant failure is not merely hallucination. It is same-system failure: the output, evidence, code, documentation, tests, release note, and handoff cease to describe one work object. A patch can pass tests while bending the architecture. A release note can be well written while describing the wrong change. A proof step can be valid while breaking the structure of the proof.

This essay argues that coherence should be a first-class runtime object in LLM systems. The argument is grounded in Triadic Self-Coherence, or TSC. TSC's public specification defines a formal carrier language, C≡, with finite triadic terms; three evaluators, α, β, and γ; a normalized discrepancy model; a barrier transform from discrepancy to coherence; strict mathematical and numerical aggregate forms; provenance requirements; witnesses; targets; and an OCaml implementation. The public repo identifies `spec/` as canonical theory, `engine/ocaml/` as canonical implementation, `runtime/SELF-MEASURE.md` as the LLM scoring instruction, `targets/` as named target declarations, `katas/` as regression inputs, and `examples/` as runnable examples.

The claim is limited. TSC does not prove that LLMs feel coherence. It does not certify truth. It does not replace tests, proof, empirical validation, security review, or human responsibility. It supplies a measurement discipline for one prior question:

**Do the independent descriptions still reveal one system?**

That question is enough to reorganize how LLM agents should generate, check, repair, and commit work.

---

## 1. The problem: local validity is not system preservation

An engineer can recognize a patch that works locally and still damages the codebase. The function compiles. The tests pass. The names are plausible. But the logic is placed in the wrong layer, duplicates an existing concept, or makes the next change harder.

That judgment is not equivalent to correctness. It is a judgment about whether the local move still belongs to the whole.

cnos names this as the "same-work problem." After agent work moves through an issue, cell, commit, validator, release note, and handoff, the system still needs to ask whether those artifacts describe one unit of work. The cnos paper gives concrete failure modes: a test can pass while the release note describes the wrong change; a commit can be signed while evidence points to the wrong commit; a validator can fail while a handoff says the work is ready.

That is the LLM coherence problem. A model output can be fluent, locally useful, and even partially correct while failing to preserve the identity of the work.

Existing test-time LLM methods improve local reasoning and task performance. ReAct interleaves reasoning traces with tool actions; Self-Refine iterates feedback and revision using the same model; Reflexion stores verbal feedback in memory across trials; Tree of Thoughts explores multiple reasoning paths before choosing. These methods are useful, but they do not by themselves define or preserve the declared whole. TSC targets that missing object.

---

## 2. TSC starts from a formal carrier, not a metaphor

The mathematical ground of TSC is C≡. The public C≡ specification defines a formal language for "how indivisible wholeness articulates itself." Operationally, it gives a term algebra:

```
T ::= e | a | tri(T1, T2, T3)
```

where `e` is unarticulated wholeness, `a` is an atom, and `tri(T1,T2,T3)` is the three-position constructor. The equivalence relation contains `e ~ tri(e,e,e)`, and the normalizer recursively contracts `tri(e,e,e)` back to `e`. The spec states soundness, uniqueness, and linear-time normalization: `t ~ u iff nf(t) = nf(u)`.

This matters because TSC does not begin with a vague score. It begins with a computable carrier on which multiple evaluators can be defined.

C≡ then defines three evaluators:

- **α :** pattern / quantitative extent
- **β :** relation / positional presence
- **γ :** process / depth of self-differentiation

The α evaluator maps terms into a capped additive monoid. It counts articulated atoms up to a cap. The β evaluator maps terms into a three-coordinate presence structure using projection and a scalar presence detector. The γ evaluator maps terms into a process/depth monoid on ℕ × ℕ, with second component combined by `u ⊙ v = u + v + uv`.

The key independence result is algebraic. C≡ proves the three target monoids are pairwise non-isomorphic because their idempotent profiles differ: α has exactly {0, M} as idempotents, β is fully idempotent, and γ has only (0,0) as idempotent.

That does not prove that every empirical α/β/γ measurement will be statistically independent. It proves something narrower and more useful: **the three evaluators are not the same algebra wearing three labels.** A real implementation still has to show that its chosen witnesses detect different failures.

---

## 3. The measurement object is a triple of summaries

TSC Core v3.2.0 takes the C≡ foundation and defines a measurement interface. For each axis `a ∈ {α, β, γ}`, there is a context space Ω_a, an articulation map A_a, observations O_a, and a summary

```
S_a = (d_a, p_a, H_a, I_a)
```

where `d_a` is a representative dimension, `p_a` is a feature distribution, `H_a` is entropy, and `I_a` contains invariants such as symmetries and conserved quantities. Pairwise alignments between summaries produce normalized discrepancies δ ∈ [0,1].

The normalized discrepancy is defined as

```
δ(S_a, S_b; σ)
  = θ · δ_struct(d_a, d_b, I_a, I_b; σ)
  + (1 − θ) · δ_dist(p_a, p_b; σ)
```

with δ_struct and δ_dist normalized to [0,1].

This is the first technical advantage over ordinary "coherence" talk. TSC does not ask whether an artifact "feels coherent." It asks whether the independently constructed summaries can be aligned without excessive structural or distributional discrepancy.

For LLM systems, this translates directly:

- **α summary:** stable local pattern language, definitions, schemas, repeated forms
- **β summary:** cross-artifact relations, references, authority, source-of-truth graph
- **γ summary:** temporal process, migration path, ownership, future-change stability

The LLM runtime instruction uses that operational interpretation: α measures stable internal structure, β measures whether files actually fit together, and γ measures whether the bundle can continue through change without losing itself.

---

## 4. The barrier transform prevents soft failure

The prior draft underplayed the math of the score. The important part is not only "geometric rather than arithmetic." The important part is the whole transformation chain:

```
δ → φ(δ) → D → Coh
```

TSC Core defines a monotone barrier function φ : [0,1] → [0,∞], with canonical default

```
φ(δ) = δ / (1 − δ),   for 0 ≤ δ < 1
φ(1) = +∞
```

Then discrepancy energy and coherence are

```
D = λ · φ(δ)
Coh = exp(−D)
```

with the endpoint convention δ = 1 ⇒ D = ∞ ⇒ Coh = 0. The spec also states that λ is a sensitivity parameter and does not create a coherence floor.

This matters because near-total discrepancy should not remain just "a bad but finite score." With the default barrier, δ = 0.90 gives φ = 9; with λ = 1, Coh ≈ e^-9 ≈ 0.000123. At δ = 0.99, φ = 99, so coherence is effectively zero. The closer discrepancy moves to complete mismatch, the faster coherence collapses.

That is how TSC dissolves a common scoring problem: **it does not need a special moral rule saying "complete mismatch is unacceptable." The endpoint behavior is built into the transform.**

The OCaml implementation mirrors this. `coherence.ml` implements `phi`, `discrepancy_energy`, and `coherence_link`; it returns `Float.infinity` for delta >= 1 in phi and returns 0.0 for `coherence_link` at delta >= 1. The implementation header states that these functions implement the v3.2.0 transformation chain and are pure with no I/O.

---

## 5. The aggregate is split into mathematical and numerical forms

TSC Core defines two aggregate forms:

```
C_Σ^math = (s_α · s_β · s_γ)^(1/3)
```

and

```
C_Σ^num
  = exp((1/3) · Σ_i w_i ln(max(s_i, ε)))
```

where the numerical form uses an ε floor for stable computation, bootstrap, out-of-distribution tracking, and verdict comparison. The two forms coincide exactly when all component scores are at or above ε.

The split answers the reviewer's ε-neighborhood concern. If any component is exactly zero, the mathematical aggregate is zero. The numerical aggregate may be nonzero because of the ε floor, but provenance must record `numeric_floor_applied` and `zero_component_present`; when `zero_component_present = true`, the operational verdict treats the measurement as a failure independent of the numerical aggregate value.

For example, if

```
s_α = 1
s_β = 0
s_γ = 1
ε = 10^-5
```

then

```
C_Σ^math = 0
C_Σ^num  = (1 · 10^-5 · 1)^(1/3) ≈ 0.0215
```

The headline numerical value is not allowed to hide the failure because the report must preserve the zero flag and the mathematical aggregate.

The OCaml implementation carries the same distinction. `Coherence.aggregate` returns `c_sigma_math`, `c_sigma_num`, `epsilon`, `zero_component_present`, and `numeric_floor_applied`; it computes `c_sigma_math` as zero when any component is zero and computes `c_sigma_num` from the ε-floored logs.

This is the second technical advantage. **TSC does not collapse a vector into a single scalar without retaining degeneracy information.** The aggregate is a summary, not a replacement for the axes.

---

## 6. The implementation is explicit about what is mechanical and what is semantic

The TSC architecture separates theory, targets, and verifier. The theory lives in `spec/`; a target is an explicit declaration of what TSC measures; current target surfaces are `spec`, `engine`, and `repo`; and the verifier resolves the input, builds a deterministic bundle, chooses a scoring backend, computes a result, validates it, and writes a report.

The repo's scoring modes are distinct:

- **mechanical:** deterministic structural-proxy scoring; no credentials
- **llm:** semantic scoring through `runtime/SELF-MEASURE.md`
- **hybrid:** both backends, with mechanical, llm, and final sub-objects
- **auto:** hybrid when credentials exist, mechanical otherwise

The README states those modes directly.

The mechanical scorer is not presented as a semantic oracle. Its source says it is deterministic structural-proxy scoring over a bundle, with no LLM calls, no network I/O, and no Markdown AST parser. It also says identical bundle and identical config produce identical result.

The mechanical scorer's signals are visible in code. α includes terminology consistency, repeated structure, duplicate definition tension, and naming drift. β includes cross-reference consistency, authority alignment, source-of-truth alignment, and target-file fit. γ includes canonical/generated distinction, version-surface consistency, traceability presence, and authority-evolution consistency.

The aggregate is not computed as an arithmetic mean. The code states that the headline cross-axis aggregate routes through `Coherence.aggregate` and intentionally ignores axis weights for the headline aggregate because the spec defines a single S₃-invariant geometric form.

This gives a reviewer concrete verification points:

- Check `phi`.
- Check endpoint δ = 1.
- Check `C_Σ^math`.
- Check `C_Σ^num`.
- Check `zero_component_present`.
- Check `numeric_floor_applied`.
- Check that mechanical scoring never calls an LLM.
- Check that headline aggregation is geometric, not arithmetic.

**These are not vibes. They are inspectable code paths.**

---

## 7. The public examples already encode positive and negative controls

The TSC repo includes cellular-automata examples. The glider example is a positive control for Conway's Game of Life. It declares expected high coherence, around C_Σ ≈ 0.996, for a standard glider that translates diagonally with period 4. It defines H/pattern as the 5-cell motif class, V/relation as the neighbor relation and translational symmetry group Z², and D/process as the Life update rule B3/S23. It also names checks for commutation, conservation, symmetry, and scale.

The paired random-soup example is a negative control. It defines each time step as an independent 16×16 Bernoulli grid with p = 0.5, expects low coherence around C_Σ ≈ 0.25, and warns that a high score likely indicates leakage, normalization error, time-indexing error, or incorrect averaging.

This pair matters because it demonstrates how TSC applies to wholeness in a non-language system.

A glider is not coherent because its cells are pretty. It is coherent because three descriptions agree:

- **H / pattern:** the 5-cell motif persists up to translation.
- **V / relation:** neighbor constraints and translation symmetry are stable.
- **D / process:** the Life update carries the pattern through a period-4 orbit.

Random soup fails because independent frames do not preserve a process. Even if each frame has local structure, the sequence does not articulate one continuing object.

The kata framework adds executable regression surfaces. The kata README lists `01-glider` as a positive-control mechanical kata, `02-random-soup` as a negative control, `03-comparative` as a ranking kata that expects glider above random soup, `04-philosophical` as a cross-domain case documenting the upper limit of mechanical scoring, and `05-adversarial` as a high-surface-regularity / low-semantic-coherence trap.

The distinction is important. The cellular-automata example files describe a domain-aware H/V/D coherence test. The mechanical katas are regression anchors for the current structural scorer. **They are not the same thing.** The repo is honest about this boundary.

---

## 8. The katas show both value and limits

The mechanical glider kata records a conservative expected pass range. Its baseline notes that the canonical geometric estimate is about 0.917, with α ≈ 1.000, β ≈ 0.990, and γ ≈ 0.779, and that the range remains conservative pending CI re-baseline.

The random-soup kata records a fail range. Its baseline estimates α ≈ 0.900, β ≈ 0.430, γ ≈ 0.737, and C_Σ ≈ 0.6583, while retaining a ceiling of 0.74 because the per-axis triple was inferred rather than recorded.

The comparative kata verifies the ranking relation: glider should rank above random soup by mechanical C_Σ. It records glider at C_Σ ≈ 0.9170 and random soup at C_Σ ≈ 0.6583.

The philosophical kata is more important than it first looks. It documents that mechanical scoring can over-rate surface-regular philosophical prose because headings, version stamps, and cross-references can all be present even when the semantic target is not what TSC considers a coherent system. Its baseline records α = 1.000, β = 1.000, γ = 0.800, and C_Σ ≈ 0.9283, explicitly naming this as an upper limit of mechanical scoring.

The adversarial kata goes the other direction. It defines three sibling files that look canonical but contradict each other semantically: each file claims canonical authority and chooses a different transport for the protocol's core invariant. The baseline records α = 0.969, β = 0.470, γ = 0.801, and C_Σ ≈ 0.7145, with β as the bottleneck.

That example demonstrates the value of the bottleneck. If we used an arithmetic mean, the score would be approximately

```
(0.969 + 0.470 + 0.801) / 3 ≈ 0.7467
```

The geometric aggregate gives

```
(0.969 · 0.470 · 0.801)^(1/3) ≈ 0.7145
```

The important part is not the small numerical difference. The important part is that the report preserves β as the axis that explains the failure. The system is not "mostly coherent." It is relation-broken.

**This is what TSC contributes: the score points to the repair.**

---

## 9. Neural coherence shows why scalar coherence is not enough

Neuroscience already uses "coherence" mathematically. Bowyer describes coherence as a technique that quantifies frequency and amplitude synchronicity of oscillating brain activity, estimating the consistency of relative amplitude and phase between EEG/MEG signals in a frequency band. Srinivasan and colleagues describe EEG/MEG coherence as measuring whether two signals can be related in a frequency band by a linear time-invariant transformation, with constant amplitude ratio and phase shift.

That is useful, but it also shows the limitation of a scalar coherence measure. Dowdall and colleagues show that coherence can fail in bidirectional neural systems with transmission delays; under some conditions, coherence can be abolished even when a true underlying interaction exists.

TSC does not solve neuroscience by assertion. It gives a stricter target shape for wholeness claims.

For neural-correlation data, a TSC target would need at least:

- **α / pattern:** stable local signal features, oscillatory signatures, distributions, entropy profiles, perturbation robustness
- **β / relation:** inter-area alignment, phase/amplitude relations, anatomical or functional constraints, comparison across measurement channels and source models
- **γ / process:** temporal stability, task-phase dynamics, causal/lag structure, transition behavior under perturbation or condition change

The value is not that TSC replaces spectral coherence. The value is that scalar spectral coherence becomes one witness inside a larger wholeness test. If scalar coherence says "no relation," but process dynamics, lagged interaction models, or source-space structure say otherwise, TSC forces that disagreement into the report instead of hiding it behind one metric.

This is the general pattern: **TSC dissolves single-metric arguments by asking which description failed to agree with the others.**

---

## 10. What TSC dissolves

TSC does not "solve" hard problems by slogan. It dissolves specific confusions by changing the measurement object.

### 10.1 Fluency versus coherence

The ordinary LLM question is:

Is this output good?

TSC changes it to:

Do the independent descriptions still describe one system?

The LLM self-measure instruction is explicit: the model's job is not to summarize files, but to measure whether the bundle forms one coherent system across α, β, and γ, grounded only in the provided files.

That dissolves the fluency trap. A fluent output can still fail β if it points to the wrong authority. It can fail γ if it leaves no stable next move. It can fail α if it corrupts the local pattern language.

### 10.2 Correctness versus coherence

TSC's thesis explicitly states that TSC is not a linter, test suite, syntax checker, or quality score; high coherence means coherent, not good; a coherent system can still be wrong.

That dissolves the overclaim. Coherence is not truth. It is the condition under which truth-directed checks can find their target.

### 10.3 Local versus global

A local score asks whether a part is acceptable. A global score asks whether the whole is acceptable. TSC changes the question to whether local and global descriptions still mutually constrain one another.

The Game of Life glider demonstrates this. A single frame is not enough. The glider is identified by motif persistence, relation under translation, and process under the Life update rule.

The opposition between local and global is therefore the wrong object. TSC asks whether pattern, relation, and process are three descriptions of the same object.

### 10.4 Self-evaluation versus external evaluation

LLM self-evaluation is risky because LLM judges can be biased. Recent work reports position bias, self-preference bias, verbosity bias, and other systematic judge failures in LLM-as-judge settings.

TSC does not require the author model to be sovereign. Mechanical mode is deterministic and model-free. LLM mode is a semantic witness. Hybrid mode preserves both mechanical and LLM sub-results. cnos places the model inside a bounded work body where cells own workflow, receipts own evidence, coherence reports own measurement, repo state owns continuity, and boundary authority decides what crosses into release.

That dissolves the false choice between "trust the model" and "ignore the model." The model can be a witness without being the authority.

### 10.5 One score versus repair direction

A single scalar can tell you that something is low. It often cannot tell you where to repair.

TSC keeps the axes. Low α points to vocabulary, schema, duplication, or local pattern repair. Low β points to relation, reference, authority, and source-of-truth repair. Low γ points to migration, ownership, lifecycle, and future-path repair. cnos states the same diagnostic mapping for cell work.

That dissolves the "bad score" problem. **The score becomes a repair vector.**

---

## 11. The rigorous runtime loop for LLM systems

A coherent LLM system should implement the following loop.

### 11.1 Declare the target

A target is an explicit declaration of what TSC measures. The architecture document identifies targets as project-internal corpora such as `spec`, `engine`, and `repo`, and says both targets and katas use the same bundle model and scoring pipeline.

For an LLM agent, the target should specify:

```
scope:        which artifacts are in the bundle
authority:    which artifacts decide disagreements
invariants:   what must not change
known debt:   what is already incoherent or unfinished
exit:         what next coherent state is allowed
```

**The hard part is not scoring. The hard part is declaring the whole honestly.**

### 11.2 Generate a candidate move

The model proposes a patch, paragraph, plan, proof step, migration, summary, release note, or handoff.

The output is not work yet. It is a candidate.

### 11.3 Bind evidence

The system bundles the candidate with target metadata, ordered files, paths, raw text, diffs, tests, traces, prior decisions, and any other evidence needed to judge fit.

The LLM self-measure instruction says to use only the provided bundle, not infer missing files, and name insufficient evidence.

### 11.4 Estimate discrepancies

The semantic witness estimates normalized pairwise discrepancies:

```
δ(α, β)
δ(β, γ)
δ(γ, α)
```

The runtime instruction requires these `delta_*` fields and states that the engine, not the model, applies the barrier transform to compute coherence.

**This division is important. The model supplies semantic judgment. The engine applies the math.**

### 11.5 Compute scores and aggregate

The engine computes component scores and aggregate forms:

```
s_α, s_β, s_γ
C_Σ^math
C_Σ^num
zero_component_present
numeric_floor_applied
bottleneck_axis
```

The report schema described in the architecture document includes α, β, γ, bottleneck axis, and provenance fields for mathematical and numerical aggregates.

### 11.6 Repair or refuse

A coherent system does not average away the bottleneck. The runtime instruction explicitly says to identify the lowest-coherence axis and explain why it constrains the whole more than stronger axes help.

Repair is axis-specific:

- low α: fix terms, definitions, structure, schema, duplication
- low β: fix references, authority, imports, source-of-truth alignment
- low γ: fix migration path, ownership, lifecycle, handoff, traceability

If the failure cannot be repaired with available evidence, the system should refuse to commit.

### 11.7 Commit with receipt

cnos treats model output as work only when it enters a work body. Its receipt records what happened, what evidence was bound, what validator ran, what trust claim was carried, what coherence witness exists, what decision was made, and what can cross the boundary.

**This is the difference between chat output and governed work.**

---

## 12. Why this matters more as models improve

A weak model produces obvious local errors. A stronger model can produce plausible edits across many artifacts. It can update code, tests, docs, issue comments, release notes, and handoffs in one pass. That increases utility and risk.

The risk is not that every artifact is bad. The risk is that every artifact is plausible while the set no longer describes one unit of work.

The cnos boundary is designed for that case. It keeps durable workflow, evidence, trust claims, coherence witnesses, receipts, and release authority outside the model runtime. The model can be capable without owning the work.

The cnos thesis makes the stronger architectural point: Git is the lowest durable substrate where coherent articulations become persistent, cloneable, signed, versioned, and mergeable; it is not the source of coherence, but the durable surface through which coherence can be inspected.

That gives TSC somewhere to live. Coherence measurement should not disappear when the chat ends. It should leave a report.

---

## 13. What is already established, and what is not

A rigorous article must distinguish specification, implementation, examples, and validation.

### Established in public TSC materials

TSC has a formal C≡ carrier with finite triadic terms, equivalence, normal form, and three algebraically distinct evaluators.

TSC Core defines normalized discrepancy, a barrier transform, discrepancy energy, coherence as exponential decay, mathematical and numerical aggregate forms, degeneracy behavior, S₃ symmetry, and a contraction test under stated Lipschitz conditions.

The OCaml implementation implements the barrier transform, coherence link, aggregate split, zero-component flag, numeric floor flag, and gauge witness machinery.

The mechanical scorer is deterministic and structural, and its α/β/γ signals are explicit in code.

The repo contains public examples for Game of Life glider and random soup, and katas for positive control, negative control, comparative ranking, mechanical-scoring limitation, and adversarial cross-file contradiction.

### Established by external literature

Neural coherence is a real mathematical measurement practice in EEG/MEG and related neuroscience, but scalar coherence has known limitations, including failure cases in bidirectional delayed systems.

LLM-as-judge systems are useful but biased; position bias and self-preference bias are documented failure modes.

### Not established yet

The public materials do not yet prove that TSC coherence scores correlate with expert human "fit" judgments across software, mathematics, writing, and agent workflows.

They do not yet prove that α/β/γ empirical witnesses are statistically independent in every domain.

They do not yet prove that TSC prevents LLM agents from making incoherent changes in production systems.

Those are validation tasks, not rhetorical gaps.

---

## 14. The validation program

The next stage should be empirical and adversarial.

### 14.1 Axis-independence benchmark

Construct cases where exactly one axis fails:

```
α failure only:
  stable references and process, but naming and definitions drift
β failure only:
  clean local language and clear future path, but wrong authority/relation graph
γ failure only:
  clean current artifacts and references, but no migration or future-change path
```

Prediction: expert reviewers should separate these failure modes, and TSC witnesses should identify the intended bottleneck.

### 14.2 Same-work benchmark

Construct agent workflows with issue, patch, test, receipt, release note, and handoff.

Introduce controlled mismatches:

- release note describes neighboring change
- test validates wrong behavior
- receipt binds wrong commit
- handoff upgrades degraded release to clean
- validator emits FAIL while summary says ready

Prediction: β should detect wrong-reference and authority failures; γ should detect propagation and handoff failures.

### 14.3 Domain-aware cellular-automata benchmark

Use the glider and random-soup example structure.

Prediction: a domain-aware TSC implementation should rank glider far above random soup because the glider preserves motif, relation, and process, while random soup lacks temporal/process continuity. The public examples define the target behavior and reference parameters.

### 14.4 Mechanical-scorer boundary benchmark

Use the philosophical kata as a known limitation.

Prediction: purely structural mechanical scoring will over-rate some high-surface-regular natural-language inputs. That is not a failure of TSC as a theory; it is a known limitation of that witness mode, already documented by the kata.

### 14.5 Adversarial authority benchmark

Use multi-file inputs where each file claims authority and contradicts the others.

Prediction: β should become the bottleneck. The adversarial kata records this pattern with β = 0.470 and `bottleneck_axis = "beta"`.

### 14.6 LLM-agent intervention benchmark

Compare three systems:

- baseline LLM agent
- LLM agent with self-refinement only
- LLM agent with TSC target + witness + receipt loop

Measure:

- review churn
- revert rate
- wrong-file edits
- release-note mismatch
- handoff mismatch
- traceability gaps
- human fit rating

The falsifiable claim is not "TSC always wins." The falsifiable claim is:

**A TSC loop should reduce same-system failures that ordinary local task-performance loops miss.**

That is the test that matters.

---

## 15. A precise definition of a coherent LLM system

A coherent LLM system is not an LLM that always tells the truth.

It is an LLM-mediated system that checks whether a candidate move still belongs to a declared whole before treating that move as accepted work.

Minimum requirements:

1. target declaration
2. evidence bundle
3. α/β/γ measurement
4. barrier-transformed discrepancy
5. mathematical and numerical aggregate separation
6. bottleneck preservation
7. witness role separation
8. receipt or refusal

The system must not claim more coherence than it measured. cnos states that rule directly: the system must not claim more coherence than it measured, and TSC does not replace tests, type checks, security review, legal review, runtime policy, or human responsibility.

This is the practical definition:

```
candidate output + target bundle + evidence
  → triadic measurement
  → bottleneck
  → repair/refuse/commit
  → receipt
```

---

## 16. Why the title is defensible

"All We Need Is Coherence" is not literally sufficient.

We also need truth, tests, proof, evidence, safety, security, expertise, institutions, and accountability.

The title is defensible only in this narrower sense:

**Coherence is the condition under which those other checks can attach to the right object.**

If the work body is incoherent, evidence binds to the wrong claim. Tests validate the wrong behavior. Reviews inspect the wrong boundary. Release notes describe the wrong change. Handoffs resume the wrong task.

So coherence is not the whole of correctness. It is prior to reliable correction.

---

## 17. Conclusion

TSC should not be presented as a metaphor for "better vibes." It is a formal and executable measurement framework.

Its **mathematical basis** is C≡: a finite triadic term algebra with normalization and three algebraically distinct evaluators.

Its **scoring basis** is a discrepancy-to-energy-to-coherence transform, with strict endpoint behavior and separated mathematical/numerical aggregates.

Its **implementation basis** is an OCaml engine with deterministic mechanical scoring, LLM semantic scoring, hybrid reports, target bundles, katas, provenance, and bottleneck reporting.

Its **application basis** is same-system preservation: whether independent descriptions still describe one system.

For LLMs, that is the missing runtime object.

The model should not merely ask:

What is the next plausible output?

It should be placed inside a system that asks:

**Does this next move still belong to the whole?**

That is the shift from fluent generation to coherent work.
