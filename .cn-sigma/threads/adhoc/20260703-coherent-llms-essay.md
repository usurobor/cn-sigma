# Coherent LLMs — measuring whether generation still belongs to the whole

**Date:** 2026-07-03
**Class:** doctrine-evolution (project-position essay; operator-authored; third in the doorway-essay lineage)
**Author:** Operator (usurobor / Axiom); Sigma-at-cn-sigma (κ-body) records verbatim
**Source:** Operator-supplied essay delivered in session, 2026-07-03. Captured today alongside six sibling adhocs written today: typed-skill-modules, κ-canonicalization, discipline-as-typed-gates, cross-repo-bundle-pattern, cnos524-wake-as-skill-implementation, and the arc genealogy adhoc. The doorway essays it joins (Agents Need a Home; Dumb Models, Smart Cells) were written earlier — 2026-06-20.

## Why this is captured here

Third essay in the doorway lineage:

- **[Agents Need a Home](20260620-agents-need-a-home-doorway-essay.md)** — defines the *home*: where agent identity, memory, work, and receipts survive the chat session.
- **[Dumb Models, Smart Cells](20260620-dumb-models-smart-cells-essay.md)** — defines *what lives in the home*: bounded work-units with a body outside the model.
- **This essay ("Coherent LLMs")** — defines *how to measure whether the local move still belongs to the whole*.

The three read as a triptych: home → cells → coherence loop. Each is project-position-from-inside, publication-grade, external-facing. All three land at cn-sigma as adhocs by the same convention (project-position, not cnos doctrine); cnos owns publication-side placement at `docs/papers/`.

Adhoc form here so cn-sigma memory holds the essay as directly referenceable text, not only via a bundle. A companion bundle exists at `.cdd/iterations/cross-repo/cnos/coherent-llms-essay/` for cnos γ intake and eventual landing at `cnos:docs/papers/COHERENT-LLMS.md`.

## Placement reasoning (coherence-loop applied to placement itself)

Applying the essay's own §5 definition to the placement question, three candidates were evaluated:

| Placement | α (pattern) | β (relation) | γ (process) |
|---|---|---|---|
| cn-sigma adhoc only | strong | weak — cnos readers can't find it | weak — essay-genre evolves at cnos (Dumb Models v0.8.0 shape) |
| cnos:docs/papers/ via bundle only | strong | weak — no direct-reference marker at cn-sigma; adhoc-inventory silent | strong |
| **Both — adhoc verbatim at cn-sigma + bundle for cnos** | **strong** | **strong** | **strong** |

Dual placement satisfies all three axes. Single-placement collapses β on either side.

## Doctrine-center recognition

Reading this essay against today's other adhoc captures, it reads as a doctrinal *center* for what has landed here:

- **§5 coherent-LLM system definition** (declare-whole → bind-evidence → measure-α/β/γ → preserve-bottleneck → commit-with-receipt or refuse) is the general form of the CDD cycle. cycle/497's R1 recovery (`20260626-cycle497-model-b-and-kappa-emergence.md`) is a lived instance.
- **§6 substrate framing** ("bounded reasoning body operating inside a coherence-preserving work body") is the κ role of `20260703-kappa-role-canonicalization.md` verbatim.
- **§7 coherence loop** (commit-with-receipt or refuse-to-commit) maps onto the CDD γ closeout with `degraded_recovery` declarations.
- **§10 role separation** ("the model must not be the sole authority") IS the κ-sharpening rule ("κ writes only issues; workers articulate everything else").
- **§12 research agenda** enumerates five directions that map to future cnos work items:
  1. coherence-aware decoding
  2. coherence memory (cnos writing-discipline informs it)
  3. coherence benchmarks (same-work preservation)
  4. coherence routing (authorship ≠ witnessing)
  5. coherence deltas as release artifacts

Today's typed-skill-modules, κ-canonicalization, cycle497-emergence, discipline-as-typed-gates, and cross-repo-bundle adhocs all sit under this essay's umbrella. It names why they cohere as a family.

## Iteration trail

Operator-authored; delivered essentially final. No γ-console iteration proposed; no operator amendments requested. κ role at cn-sigma is `record` (per cnos#501 authorized actions), not review or edit. The essay lands verbatim.

The only κ-shaped judgment applied was placement (see coherence-loop analysis above) — a legitimate κ `translate` action that the essay's own criteria could evaluate.

## Forward-looking notes

- **External publication** is a separate operator decision. This adhoc and the bundle secure the internal canonical record.
- **Cnos essay-family evolution:** if the essay matures at cnos (v0.8.0-shape bumps as happened with "Dumb Models"), cn-sigma's copy stays as-authored; a subsequent adhoc captures the evolution (per the `20260623-tsc-integrated-into-dumb-models-essay.md` precedent).
- **Research agenda items** are candidates for future cnos issues via bundle. First candidate: coherence-aware decoding as a coherent-LLM instrumentation layer over an LLM API — natural fit for a cnos.core or cnos.cds subskill.

## Related artifacts

- **[20260620-agents-need-a-home-doorway-essay.md](20260620-agents-need-a-home-doorway-essay.md)** — doorway essay 1 (home).
- **[20260620-dumb-models-smart-cells-essay.md](20260620-dumb-models-smart-cells-essay.md)** — doorway essay 2 (cells).
- **[20260623-tsc-integrated-into-dumb-models-essay.md](20260623-tsc-integrated-into-dumb-models-essay.md)** — TSC integration precedent for essay-family evolution.
- **[20260703-typed-skill-modules.md](20260703-typed-skill-modules.md)** — the form the coherence loop takes when instrumented.
- **[20260703-kappa-role-canonicalization.md](20260703-kappa-role-canonicalization.md)** — the role the essay's §6 names.
- **[20260626-cycle497-model-b-and-kappa-emergence.md](20260626-cycle497-model-b-and-kappa-emergence.md)** — the cycle where §7 played out in practice.
- **[20260703-discipline-failures-become-typed-gates.md](20260703-discipline-failures-become-typed-gates.md)** — the recursive principle §10 informs.
- **[20260703-cross-repo-bundle-pattern.md](20260703-cross-repo-bundle-pattern.md)** — the pattern the companion bundle uses.
- **cn-sigma:.cdd/iterations/cross-repo/cnos/coherent-llms-essay/** — companion bundle (canonical for cnos publication path).
- **cnos:TSC** — the measurement theory the essay operationalizes.
- **cnos:docs/papers/DUMB-MODELS-SMART-CELLS.md** — immediate paper-family neighbor.

---

## Essay (verbatim)

# Coherent LLMs: Measuring Whether Generation Still Belongs to the Whole

**Governing question:** How can an LLM compute, at generation time, whether its next output still belongs to the whole system it is trying to preserve?

## Abstract

Large language models are fluent local continuers. They can write code, prose, plans, proofs, and explanations with impressive surface competence, but fluency is not the same as coherence. Coherence is the relation between a local move and the whole it must preserve. This article defines a coherent LLM system as an LLM-mediated system that measures, before committing an output, whether the candidate output preserves one declared whole across pattern, relation, and process. The proposal builds on Triadic Self-Coherence, or TSC, which asks whether three independent descriptions of a system still describe one system, and on cnos, which treats agent work as durable, receipted, measurable work rather than as transient model output.

The claim is deliberately operational. A coherent LLM need not possess a human feeling of elegance, beauty, or understanding. It must instead run a coherence loop: declare the target whole, generate a candidate move, measure α pattern coherence, β relational coherence, and γ process coherence, identify the bottleneck, repair the weakest axis, and commit only with evidence. This gives the model a calculable substitute for the engineer's sense that code has become hacky, or the mathematician's sense that a proof has become heavy.

**Keywords:** coherence, large language models, TSC, cnos, agent systems, self-measurement, verification, alignment, software engineering

---

## 1. The missing property is not fluency

The central weakness of LLMs is not that they cannot produce plausible local text. The central weakness is that they do not, by default, preserve an explicit whole while producing that text.

An experienced engineer can often feel when a function no longer belongs. The code may still compile. The local logic may still work. Yet the function bends the module, duplicates a concept, violates a boundary, or makes the next change harder. The engineer's judgment is not merely syntactic. It is a judgment about fit.

Mathematicians recognize the same phenomenon. A proof may be valid but ugly because it hides the structure it should reveal. Another proof may be beautiful because every step appears necessary, every lemma carries its weight, and the conclusion feels inevitable. Beauty here is not decoration. It is coherence perceived as economy, inevitability, and structural fit.

LLMs can imitate the language of such judgments. They can say that code is clean or that a proof is elegant. But the harder question is whether the system can measure, in the moment, whether its next move preserves the whole it is serving. Modern LLMs gained power through scale and in-context task specification, as shown by the few-shot capabilities of GPT-3, but that success does not by itself give the model a durable, inspectable relation to a governing whole.

This distinction matters because local plausibility can hide global incoherence. A generated function can use the right idioms and still violate the architecture. A generated paper section can sound academic and still contradict the thesis. A generated agent handoff can be well formatted and still point to the wrong evidence. Bender and colleagues framed one part of this risk as the danger of systems that generate fluent language without grounded understanding of the conditions under which the language is meaningful.

The problem, then, is not simply hallucination. Hallucination is one visible failure. The deeper failure is unmeasured local continuation.

## 2. Coherence is the preservation of one system across descriptions

TSC gives a precise form to the question humans often answer intuitively. It defines Triadic Self-Coherence as a measurement theory for systems that describe themselves. Its governing question is whether three independent descriptions of the same system still describe one system. Those descriptions are α pattern coherence, β relational coherence, and γ process coherence.

This is the key move: coherence is not correctness, quality, style, linting, or test success. TSC explicitly says that a coherent system can still be wrong, while an incoherent system cannot be trusted to know whether it is right.

That distinction is essential for LLMs. A coherent output is not guaranteed true. A coherent output is one whose claims, references, structure, and future implications still belong to the same declared system. Coherence is therefore a precondition for reliable correction, not a substitute for truth.

In TSC, the three axes are not interchangeable labels. α asks whether the pattern is stable. β asks whether the parts refer to each other consistently. γ asks whether the system can evolve without losing identity. The aggregate is geometric, not arithmetic, because one broken dimension should not be averaged away by two strong ones.

This is why TSC fits the engineering intuition so well. A codebase can have high α because its local patterns are tidy, while β fails because modules point to contradictory authorities. A research note can have strong β because citations line up, while γ fails because the argument cannot survive the next revision. A release can have strong γ because the migration path is clear, while α fails because the concepts drift across files.

Coherence is the whole surviving through all three.

## 3. The triadic structure prevents cheap coherence

The formal layer underneath TSC is C≡, a language for how an indivisible whole articulates itself. C≡ begins from the idea of "one-as-two": wholeness can articulate into distinguishable aspects without ceasing to be one whole. The triadic constructor tri(T₁,T₂,T₃) is the minimal form that can hold distinction without fragmentation.

This matters for LLMs because many self-checking methods are dyadic. They ask whether an answer matches a prompt, whether a critique matches an answer, or whether a test matches a function. Those checks help, but they do not fully answer whether the output, the surrounding system, and the system's future path still cohere.

TSC's three axes avoid that compression. α measures pattern. β measures relation. γ measures process. C≡ argues that these evaluators are independent by showing that their target structures have distinct idempotent profiles. In simpler terms, the axes are not three names for the same score. They see genuinely different failures.

This is the first design requirement for coherent LLMs:

> A coherent LLM system must not ask only, "Is this output good?" It must ask, "Does this output preserve the whole across pattern, relation, and process?"

The second design requirement follows from the aggregate. TSC computes aggregate coherence through a geometric form. In the mathematical aggregate, a zero component collapses the whole score; in the numerical aggregate, a small ε floor permits stable computation while still recording whether a true zero component was present.

This prevents a familiar LLM failure: compensating for a broken relation with beautiful prose. A generated answer should not be considered coherent merely because it is fluent. If it points to the wrong file, changes the meaning of a term, or hides an unstable future path, the bottleneck must remain visible.

## 4. Existing LLM loops improve performance but do not yet make coherence primary

Many test-time methods already push LLMs beyond one-shot generation. ReAct interleaves reasoning and action so that a model can update its behavior through interaction with external environments. Self-Refine uses iterative feedback and refinement without additional training. Reflexion stores verbal feedback in memory so agents can improve across trials. Tree of Thoughts lets models explore and evaluate multiple reasoning paths rather than committing to one left-to-right continuation.

These methods are valuable. They give models more room to search, revise, act, and learn from feedback. But they usually treat improvement as task success, answer quality, or trajectory performance. They do not necessarily make the declared whole the object being measured.

A coherence loop asks a different question. It does not merely ask whether the model found a better answer. It asks whether the answer still belongs to the system. The target is not "better text." The target is preservation of one system through the next move.

This is the contribution TSC can make to LLM architecture. It turns coherence into a first-class runtime object: declared, bundled, measured, reported, repaired, and recorded.

## 5. Definition: a coherent LLM system

A coherent LLM system is an LLM-mediated system that measures whether each candidate output preserves a declared whole before that output is treated as work.

The definition has five parts.

**First, the system must declare the whole.** The whole may be a repository, a target bundle, a paper, a proof, a product spec, a cell of work, or an agent state. Without a declared whole, there is no coherence target.

**Second, the system must bind evidence.** The candidate output must be evaluated against the files, claims, constraints, references, and prior decisions that define the whole. TSC's runtime instruction requires the model to use only the provided bundle, name evidence for each axis, avoid generic praise, and report uncertainty when evidence is missing.

**Third, the system must measure α, β, and γ separately.** Pattern, relation, and process failures need different repairs. The TSC self-measure instruction makes this explicit: low α points to naming drift, duplication, contradiction, or unstable conceptual structure; low β points to authority confusion or cross-file mismatch; low γ points to unclear ownership of future change or inability to survive replacement of one layer.

**Fourth, the system must preserve the bottleneck.** The weakest axis constrains the whole. TSC's runtime instruction explicitly says not to average away the bottleneck.

**Fifth, the system must decide what happens next.** A coherent LLM system does not stop at critique. It repairs the weakest axis, refuses to commit, or commits with a receipt that records the measurement and the risk.

This definition avoids a false claim. It does not say that the model has a human inner sense of coherence. It says that the system can externalize, compute, and act on a coherence relation.

## 6. cnos supplies the body in which coherence can persist

A coherence measurement needs somewhere to live. If it exists only inside a chat turn, it disappears with the turn. cnos addresses this by treating agent work as durable, receipted work in a Git-native body. Its README describes a hub as a repository an agent can wake into, read, write, remember through, and use to coordinate with humans and other agents; it also states that agent work should leave receipts, evidence, decisions, and memory.

The cnos thesis frames the system more deeply: cnos is a recurrent coherence system in which doctrine, documents, packages, runtime modules, repositories, traces, releases, and agents are articulations of one coherence principle at different scales.

This matters because the model should not own the work. The model can produce matter for the system. The system must own the workflow, evidence, trust claims, coherence reports, and release authority. The cnos paper "Dumb Models, Smart Cells" states this boundary clearly: model capability is rented, while durable work remains in a work body made of cells, packages, receipts, coherence reports, and repository state.

A coherent LLM, in this framing, is not a standalone neural network. It is a bounded reasoning body operating inside a coherence-preserving work body.

That work body gives the model what it lacks by default: durable state, explicit authority, inspectable evidence, and a named boundary where local output becomes accepted work.

## 7. The coherence loop

The operational loop is simple.

**Declare the target.** Name the whole the output must preserve. In TSC, a target declares what is being measured and which files are in scope. The repository includes named targets and supports direct file input, mechanical scoring, LLM scoring, hybrid scoring, and auto mode.

**Generate a candidate move.** The LLM writes the next function, paragraph, proof step, plan, patch, handoff, or receipt.

**Bundle the candidate with the whole.** The candidate is not judged alone. It is judged against the target's stable facts, references, authority surfaces, and process expectations.

**Measure the three axes.** α asks whether the candidate preserves stable pattern. β asks whether it preserves relations among parts. γ asks whether it preserves the future path of the system.

**Compute the aggregate without hiding the weak axis.** TSC's OCaml implementation routes aggregate computation through the canonical geometric aggregate and records mathematical and numerical aggregate forms. The mechanical scorer explicitly avoids using an arithmetic mean for the headline cross-axis aggregate.

**Repair the bottleneck.** Low α means repair terms, definitions, schema, or local structure. Low β means repair references, authority, imports, claims, or cross-file alignment. Low γ means repair migration, ownership, lifecycle, traceability, or change path.

**Commit with a receipt or refuse to commit.** The output becomes work only when the system records what was done, what evidence was bound, what was measured, what failed, and who accepted the boundary decision.

This loop gives the LLM a real-time coherence instrument. It does not ask the model to "be more thoughtful." It changes the runtime question from "What text comes next?" to "Does this next move preserve the whole?"

## 8. Example: code generation as coherence preservation

Suppose an LLM is editing a repository. It writes a helper function that passes tests. A conventional evaluator may accept the patch because the local behavior is correct. A coherence evaluator asks three additional questions.

α asks whether the helper uses the repository's existing concepts. If the code introduces a synonym for an existing abstraction, α drops. The local code may be clean, but the pattern language has drifted.

β asks whether the helper belongs where it was placed. If it imports from the wrong layer, bypasses a canonical interface, or points documentation toward a deprecated path, β drops. The function may work, but the relation graph has bent.

γ asks whether the helper preserves future change. If the patch hides generated state, lacks traceability, leaves ownership unclear, or makes the next migration ambiguous, γ drops. The function may pass today, but the system has become harder to evolve.

This matches the engineer's intuition. "Hacky" code is often not locally wrong. It is globally misfit. TSC gives that misfit a measurement surface.

The same pattern applies to proofs. α asks whether the proof uses stable definitions. β asks whether lemmas relate to the theorem without hidden glue. γ asks whether the proof opens a durable path for generalization, reuse, or simplification. An ugly proof is often a proof whose local steps fail one of these dimensions.

## 9. Coherence is not correctness, and that is why it is useful

A coherence score should never be mistaken for a truth certificate. TSC states this directly: high coherence means coherent, not good; a coherent system can be wrong.

That limitation is not a weakness. It is what makes coherence useful. Correctness often requires domain tests, empirical evidence, type checks, mathematical proof, legal review, security review, or human judgment. Coherence does not replace those. It tells us whether the artifact is stable enough to be judged by them.

This is especially important for agent systems. A release can pass CI while the release note describes the wrong change. A receipt can be signed while pointing to the wrong evidence. A validator can emit one verdict while the handoff says another. The cnos paper describes this as the "same-work problem": after work moves through issue, cell, commit, validator, release note, and handoff, the system must ask whether those artifacts still describe one unit of work.

That is the right place for TSC. It is not the judge of all truth. It is the witness that the object presented for judgment is still one object.

## 10. Why the LLM must not be the sole authority

A model can participate in coherence measurement, but it should not silently become the authority over its own work.

TSC handles this by separating structural proxies, semantic judgment, and provenance. Mechanical scoring is deterministic and uses structural signals such as terminology consistency, cross-reference consistency, authority alignment, version surface consistency, and traceability presence. Hybrid scoring combines mechanical and LLM results into one report while preserving both sub-objects and routing aggregate computation through the canonical coherence aggregate.

This separation matters. A mechanical witness can catch obvious structural drift without trusting a model. An LLM witness can judge semantic fit that mechanical signals miss. A hybrid witness can show agreement or disagreement between the two.

The cnos boundary sharpens the same point. A model should be a bounded provider inside a system-owned workflow. The receipt should record the route, evidence, validation, coherence measurement, and decision. The system must not claim more coherence than it measured.

A coherent LLM system therefore needs role separation. The model may write. Another model or mechanical process may measure. A validator may check. A named boundary authority may decide. Coherence improves when those roles are explicit.

## 11. From self-critique to self-measurement

Self-critique asks the model to inspect its own answer. Self-measurement asks the system to inspect the relation between the answer and the whole.

That difference is decisive. A self-critique can become another fluent local continuation. It can sound reflective while missing the real structural mismatch. A self-measurement loop must bind evidence, score axes, name the bottleneck, and produce a structured output.

TSC's runtime instruction embodies that shift. It tells the model that its job is not to summarize the files, but to measure whether the bundle forms one coherent system across α, β, and γ. It requires positive and negative evidence for each axis, discrepancy values, confidence, unresolved ambiguity, and next fixes.

This makes coherence actionable. The result is not "the answer seems good." The result is "β is the bottleneck because two authority surfaces disagree; repair the source-of-truth relation before committing."

That is the missing instrument.

## 12. Research agenda

The coherent LLM program has five natural directions.

**First, coherence-aware decoding** should evaluate candidate continuations against a target bundle before selecting the next move. The model should not only optimize for local likelihood or instruction satisfaction. It should prefer continuations that preserve α, β, and γ.

**Second, coherence memory** should store stable facts once and point to them elsewhere. This follows the cnos writing discipline: a document has one governing question, each section one sub-question, each paragraph one move, each sentence one claim, and each word one job.

**Third, coherence benchmarks** should measure same-work preservation across long workflows. The benchmark should include docs, code, issues, tests, receipts, releases, and handoffs, then ask whether they still describe one unit of work after model intervention.

**Fourth, coherence routing** should separate authorship from witnessing. The model that writes a patch should not automatically be the only model that judges whether the patch belongs.

**Fifth, coherence deltas** should become release artifacts. cnos already frames releases as movement along a coherence gradient: each cycle should produce a coherence delta and reduce a named incoherence.

This agenda does not require a speculative theory of machine consciousness. It requires better runtime instrumentation.

## 13. Conclusion

LLMs do not need to feel coherence in order to use coherence.

Human engineers and mathematicians experience coherence as a trained sense of fit. A function belongs or it does not. A proof reveals the structure or it does not. That feeling is powerful, but it is private.

TSC makes the private sense operational. It asks whether independent descriptions still reveal one system. It measures pattern, relation, and process. It preserves the bottleneck. It refuses to average away collapse.

cnos gives that measurement a body. It keeps work outside the model, in cells, packages, receipts, reports, and repository state. It lets the model act, but makes the work inspectable.

A coherent LLM system is therefore not a model that always tells the truth, and not a model that possesses human aesthetic judgment. It is a system that can ask, before committing a local move:

**Does this still belong to the whole?**

That question is the bridge from fluent generation to coherent work.
