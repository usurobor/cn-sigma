# cnos essay proposal: All We Need Is Coherence — a runtime discipline for whether an LLM's next move still belongs

**Mode:** `docs-only`
**Target path (proposed):** `cnos:docs/papers/ALL-WE-NEED-IS-COHERENCE.md`
**Suggested labels:** `docs`, `P2`, `area/essays`
**Filing directive to cnos γ:** Land essay verbatim at target path. Do NOT modify content. This is publication-grade external-facing material, authored by the operator; κ role at cn-sigma is `record` only.

**Note on title / bundle slug:** The essay was originally titled *Coherent LLMs: Measuring Whether Generation Still Belongs to the Whole* (v0, earlier 2026-07-03). Operator delivered a revised, expanded v1 later same day retitled *All We Need Is Coherence*. Bundle slug `coherent-llms-essay/` preserved because the underlying subject (coherent LLM systems) is unchanged; only the title's rhetorical compression changed. Bundle ISSUE.md, LINEAGE.md, and STATUS updated to reflect v1 as canonical.

## Why this belongs at cnos:docs/papers/

- Essay-genre content adjacent to `DUMB-MODELS-SMART-CELLS.md` and (v0.8.0's) TSC-integrated form. This piece extends the TSC + cnos synthesis into an operational proposal for LLM systems.
- Cites TSC as measurement theory and cnos as work-body substrate; both live at cnos. Publishing the piece anywhere else fragments the citation graph.
- v1 grounds the proposal as an engineering research program (§11 lists five concrete validation tests). Each maps to future cnos work items.
- Bibliography-shape (Bender et al.; ReAct; Reflexion; Self-Refine; Tree of Thoughts; LLM-as-judge bias literature) places it in the academic-adjacent register of papers, not the project-position-from-inside register of adhocs.

## Acceptance criteria

**AC1** — File landed at `cnos:docs/papers/ALL-WE-NEED-IS-COHERENCE.md` with essay body verbatim (no content edits).

**AC2** — Path repointing: any cross-references from the essay to cnos internal artifacts (TSC repo path, cnos README, DUMB-MODELS-SMART-CELLS.md) verified against current post-docs-reorg locations. Report a delta if any reference resolves incorrectly.

**AC3** — Frontmatter added per `cnos.core/skills/agent/` convention if papers require it (title, date, class=`paper`, author=`operator`); confirm from paper-family precedent in `docs/papers/`.

**AC4** — Bidirectional link added: `DUMB-MODELS-SMART-CELLS.md` cross-references this essay as companion (dumb models frames the substrate; this essay frames the measurement instrument); `ALL-WE-NEED-IS-COHERENCE.md` cross-references DUMB-MODELS-SMART-CELLS as prerequisite.

**AC5** — I4 (link validation) green; I5 (frontmatter) green; goldens unaffected (no wake/skill changes in this cycle).

**AC6** — Release note entry captures the essay's landing.

## Non-goals

- Do NOT edit or "improve" the essay content. Operator-authored; κ delivers verbatim.
- Do NOT split into multiple documents or restructure the section order.
- Do NOT publish externally in this cycle; that is a separate operator decision after landing at cnos.
- Do NOT implement any of the §11 validation tests in this cycle; each is a separate future issue.

## Empirical anchors (cnos-side context)

- `DUMB-MODELS-SMART-CELLS.md` v0.8.0 evolution (integrated TSC per cn-sigma:.cn-sigma/threads/adhoc/20260623-tsc-integrated-into-dumb-models-essay.md).
- TSC canonical spec at cnos (referenced §3, §4, §6.5, §8 of the essay).
- cnos README + `Dumb Models, Smart Cells` (referenced §5, §11.5 of the essay).
- cn-sigma adhoc `20260620-agents-need-a-home-doorway-essay.md` (companion posture: where work persists).

---

## Essay (verbatim — file at target path exactly as below, drop the section-separator line)

---

# All We Need Is Coherence

**A runtime discipline for whether an LLM's next move still belongs**

**Status:** public position essay
**Audience:** AI engineers, agent-system builders, applied researchers, technical reviewers
**Governing question:** How can an LLM-based system tell whether its next output still belongs to the whole it is trying to serve?

---

## Abstract

The title is intentionally compressed enough to be dangerous. We need more than coherence. We need truth, tests, citations, security review, domain expertise, good interfaces, and human judgment. But without coherence, those checks cannot reliably find the thing they are supposed to check.

Large language models are strong local continuers. They can extend a prompt, draft a function, revise a paragraph, explain a paper, inspect a trace, or produce a plausible plan. But local continuation is not the same as system preservation. A generated function can pass tests and still damage an architecture. A proof can be valid and still obscure the idea it should reveal. An agent can complete a task and still leave behind mismatched code, docs, receipts, and release notes.

This essay proposes a runtime discipline for LLM systems: before a generated move becomes accepted work, the system should ask whether that move still belongs to the declared whole. The proposed loop is: declare the whole, generate a candidate, bind evidence, measure fit across three axes, preserve the weakest axis, repair or refuse when needed, and commit only with a receipt.

The three axes come from Triadic Self-Coherence, or TSC: α pattern coherence, β relational coherence, and γ process coherence. TSC defines coherence as the question of whether independent descriptions of a system still describe one system; it also explicitly separates coherence from correctness, quality, style, tests, and linting.

The claim is not that LLMs feel coherence as humans do. The claim is narrower: LLM-based systems can be given an external coherence instrument. They can be made to measure, at runtime, whether the next move still belongs.

---

## 1. The engineer's sense of fit

Engineers know the feeling.

A patch compiles. The tests pass. The code is not ugly in isolation. Yet something is wrong. The new function duplicates an existing concept. The name almost matches the project's language but not quite. The module imports from the wrong layer. The fix solves today's bug by making tomorrow's change harder.

Nothing is obviously broken, but the system has become less itself.

That judgment is not merely about correctness. It is a judgment about fit. The local move either preserves the whole or bends it.

Mathematicians recognize a similar distinction. A proof can be valid but ugly. Another proof can be beautiful because every step reveals why the theorem is true. The beautiful proof does more than arrive at the conclusion. It preserves and exposes the structure of the problem.

Writers know this too. A sentence can be grammatical and still not belong in the paragraph. A paragraph can be clear and still not belong in the essay. A section can be accurate and still pull the reader away from the governing question.

The shared intuition is simple:

**A local move can succeed locally and fail globally.**

LLMs are especially vulnerable to this failure because they are good at local success. They can produce plausible continuations across many domains. But plausibility does not guarantee that the continuation preserves the system it is extending.

The missing runtime question is:

**Does this still belong to the whole?**

---

## 2. Fluency is not coherence

Fluency is the ability to continue in a way that sounds right.

Coherence is the preservation of one system across a move.

The distinction matters because modern LLM systems often look better before they become safer. A model that writes more fluent prose can hide contradictions more elegantly. A model that edits more files can create larger mismatches. A model that calls tools can produce evidence-shaped output without preserving the relation between evidence and claim.

This is not only the familiar problem of hallucination. Hallucination is one visible failure. A broader class of failures happens when every local artifact seems plausible but the artifacts no longer describe the same work.

A bug report says one thing. The patch fixes a neighboring thing. The test confirms the patch. The release note describes a third thing. The handoff says the issue is closed. Nothing in the chain looks absurd by itself. The failure is that the chain is no longer one chain.

That is a coherence failure.

Existing test-time methods help LLMs reason, search, revise, and act. ReAct interleaves reasoning traces and task-specific actions, allowing models to update plans through interaction with tools and environments. Self-Refine improves outputs through iterative feedback and revision from the model itself. Reflexion stores verbal feedback in memory so agents can improve across trials. Tree of Thoughts lets models explore and evaluate multiple reasoning paths rather than committing to a single left-to-right continuation.

These methods are useful. They make generation less one-shot. But they do not, by themselves, make the declared whole the thing being preserved. A system can reason better, refine more, remember longer, and search wider while still losing the identity of the work.

Coherence is not another word for better output. It is a relation between an output and a whole.

---

## 3. Coherence is not correctness

Correctness asks whether something is right.

Coherence asks whether something still belongs.

A coherent system can be wrong. An incoherent system can contain true statements. This distinction is central to TSC: a high coherence score means coherent, not good; TSC is not a linter, test suite, syntax checker, or quality score.

That distinction makes coherence useful rather than inflated.

Code correctness may require tests, type checks, benchmarks, runtime observation, security review, and human review. Factual correctness may require citations and source verification. Mathematical correctness may require proof. Legal, medical, and financial correctness require domain standards and accountable expertise.

Coherence does not replace any of that.

Coherence answers an earlier question: is the thing being checked still one thing?

A release can pass CI while its release note describes the wrong change. A research summary can cite the right paper while reversing the relation between claim and evidence. A generated plan can satisfy the user's wording while violating the project's actual goal. A proof outline can contain true lemmas while failing to reveal how they compose.

In each case, correctness checks may still be necessary. But first the system must preserve the object those checks are meant to evaluate.

**Coherence is the condition under which correction can find its target.**

---

## 4. The three-axis test

A single "quality" score hides too much.

Something can sound consistent while pointing to the wrong authority. Something can update all references while making future change harder. Something can be easy to extend while introducing conceptual drift.

TSC separates coherence into three axes:

| Axis | Runtime question | Common failure |
|---|---|---|
| **α pattern coherence** | Does this preserve the system's language, concepts, forms, and internal structure? | Naming drift, duplicated concepts, unstable definitions, local contradiction |
| **β relational coherence** | Do the parts still point to each other correctly? | Broken references, authority confusion, docs and implementation disagreeing |
| **γ process coherence** | Can the system continue through change without losing identity? | No migration path, unclear ownership, brittle evolution, hidden generated state |

TSC's self-measure protocol defines the axes in this practical way: α looks for stable terms, definitions, conceptual boundaries, and absence of contradiction; β looks for consistent cross-file fit and authority alignment; γ looks for authority surfaces, migration rules, canonical/generated distinctions, and clear future change paths.

The axes are useful because they catch different kinds of failure.

A patch can score high on α and low on β. It uses the project's language, follows the style, and looks locally clean, but it places the logic in the wrong layer.

A patch can score high on β and low on γ. It updates every reference correctly, but it hard-codes a transitional rule that future changes cannot safely extend.

A patch can score high on γ and low on α. It creates a workable migration path, but introduces new terms that fracture the project's conceptual language.

This is the practical independence claim. It should not be treated as proven merely because the framework names three axes. The axes earn their place only if they catch different failures in real systems. That needs empirical validation.

For now, the proposal is:

**Measure pattern fit, relational fit, and process fit separately, because a local move can preserve one while breaking another.**

---

## 5. The whole is the hard part

The earlier version of this argument made "declare the whole" sound like an easy first step. It is not.

In real work, the whole is often unclear. The source of truth has drifted. The README says one thing, the implementation says another, and the issue tracker says a third. The team may disagree about the architecture. The roadmap may have changed. A migration may be halfway complete. The system may already be incoherent before the model touches it.

So the coherence loop cannot assume a clean whole. It must construct and expose the current whole as a versioned artifact.

A useful coherence target should state at least five things:

1. **Scope:** which artifacts are included?
2. **Authority:** which artifacts decide when sources disagree?
3. **Invariants:** what must not change?
4. **Known tensions:** what is already unresolved?
5. **Exit condition:** what would count as a coherent next state?

This changes the first move. The first move is not "score the output." The first move is "declare the best current boundary of the system."

That declaration can be partial. It can be contested. It can say, "The docs and implementation disagree here." It can say, "This migration is unfinished." It can say, "This file is canonical; that one is derived." It can say, "This target is not coherent enough to modify safely."

**An honest partial whole is better than a fake complete whole.**

This is where durable state matters. If the declared whole lives only inside a chat turn, it will drift with the conversation. A coherence target should live in the work body: repository state, issue state, docs, receipts, reports, tests, and release artifacts.

cnos frames this as keeping releasable agent work outside model runtimes. In that model, capability is rented from models, but durable work remains in a work body owned by the system: cells carry workflow, packages carry local cognition, receipts carry evidence, coherence reports carry measurement, repo state carries continuity, and boundary authority decides what crosses into release.

The model may help declare the whole. **The model must not be the whole.**

---

## 6. The coherence loop

A coherent LLM system does not merely ask a model to be careful. It changes the runtime contract.

The loop is:

1. declare the current whole;
2. generate a candidate move;
3. bind evidence;
4. measure α, β, and γ separately;
5. preserve the bottleneck;
6. repair, refuse, or commit;
7. leave a receipt.

Each step has a job.

### 6.1 Declare the current whole

The system names the target, scope, authority surfaces, invariants, known tensions, and exit condition.

For a repository, the target might include the README, architecture docs, public API, tests, issue contract, implementation files, and release notes. For a paper, it might include the thesis, definitions, claims, evidence, argument structure, and intended audience. For an agent workflow, it might include the task, tool outputs, intermediate decisions, artifacts changed, and acceptance boundary.

Without a declared whole, "coherence" becomes taste.

### 6.2 Generate a candidate move

The model proposes a patch, paragraph, plan, proof step, review, handoff, migration, or decision.

The candidate is not accepted because it is fluent. It is only a candidate.

### 6.3 Bind evidence

The system attaches the evidence needed to judge fit: files, diffs, issue text, prior decisions, test output, schemas, traces, citations, or receipts.

TSC's self-measure instruction requires judgments to be grounded only in the provided bundle and to say when evidence is missing.

This matters because coherence without evidence becomes self-congratulation.

### 6.4 Measure α, β, and γ separately

The system asks:

Does the candidate preserve the pattern language?

Does it preserve the relation graph?

Does it preserve the future path?

Each axis should include positive evidence, negative evidence, uncertainty, and a score or verdict.

### 6.5 Preserve the bottleneck

The weakest axis constrains the whole.

This is why TSC uses a geometric aggregate rather than a flat average. Its thesis defines the composite score as a geometric mean and explicitly states that one zero component collapses the mathematical aggregate because coherence is not an average.

This prevents a common LLM failure: compensating for a broken relation with beautiful prose.

If β is broken, α elegance does not save the output. If γ is broken, a clean local patch may still be unsafe to commit. If α is broken, a well-routed change may still fracture the system's language.

The bottleneck is not a detail. It is the current shape of the failure.

### 6.6 Repair, refuse, or commit

Low α suggests repair to terms, definitions, naming, local structure, or duplication.

Low β suggests repair to references, authority, dependencies, source-of-truth alignment, or cross-file claims.

Low γ suggests repair to ownership, migration path, lifecycle, traceability, or future change path.

If the failure cannot be repaired with the evidence available, the system should refuse to commit. **Refusal is not model failure. It is boundary preservation.**

### 6.7 Leave a receipt

A model output becomes durable work only when the system records what happened, what evidence was used, what was measured, what failed, what changed, and who or what accepted the boundary decision.

The receipt is what lets another human, model, validator, or future session reconstruct the move.

**No receipt means no durable memory of why the move belonged.**

---

## 7. A concrete failure case

Imagine an LLM agent is asked to fix a CLI bug.

The issue says:

> `cn check` should fail when the manifest is missing a required package.

The agent inspects the repo, writes a patch, adds a test, updates the release note, and posts a summary. The test passes.

A task-performance loop may stop there.

A coherence loop asks more.

**α pattern coherence:** Did the patch use the project's existing language? If the repo consistently says "package" but the patch introduces "module" for the same concept, α drops. The code may work, but the language of the system has drifted.

**β relational coherence:** Did the patch modify the right layer? If the architecture says manifest validation belongs in the manifest checker but the patch puts the rule in the command parser, β drops. The behavior may be correct, but the relation between responsibility and implementation is wrong.

**γ process coherence:** Can future package rules be added without repeating this special case? If the patch hard-codes one missing-package condition instead of extending the validation path, γ drops. The current bug is fixed, but the future path is worse.

Now suppose the release note says:

> Improves package resolution.

But the issue and patch are about manifest validation. The code, issue, test, and release note no longer describe one unit of work.

This is not simply a bad summary. It is a **same-work failure**.

ReAct might help the agent inspect the right files. Self-Refine might improve the release note. Reflexion might help the agent remember that previous attempts failed. Tree of Thoughts might explore several fixes before choosing one. Those are useful capabilities. But unless the system explicitly checks that issue, patch, test, docs, and release note still describe one work object, the coherence failure can pass through.

The coherence loop targets that gap.

---

## 8. Mechanical witnesses help, but they are not enough

Some coherence signals can be checked mechanically.

A system can look for naming drift, repeated definitions, inconsistent headings, broken links, missing source-of-truth alignment, version-surface mismatch, missing traceability, or confusion between canonical and generated artifacts.

The TSC mechanical scorer is built in this spirit: it describes itself as deterministic structural proxies over a bundle, with no LLM calls or network I/O. Its default signals include terminology consistency, repeated structure, duplicate definition tension, naming drift, cross-reference consistency, authority alignment, source-of-truth alignment, version-surface consistency, and traceability presence.

These checks are useful. They catch cheap drift. They are repeatable. They create evidence.

But they are not sufficient.

A document can use consistent terms and still be wrong. A repo can have valid links and still point to the wrong abstraction. A generated patch can satisfy a checklist while violating the design. A model can learn to game shallow coherence signals by repeating terms, adding links, and manufacturing plausible receipts.

So mechanical scoring should be treated as a **witness, not an oracle**.

The right architecture is layered:

- deterministic witnesses catch structural drift;
- LLM witnesses judge semantic fit against bounded evidence;
- human reviewers resolve high-stakes or ambiguous cases;
- receipts preserve what each witness saw;
- benchmarks test whether witness scores correlate with expert judgment.

This is also why the author of a change should not be the only judge of its coherence. LLM-as-judge systems can be useful, but recent work has documented bias risks such as position bias, verbosity bias, and self-enhancement bias.

A coherent system separates roles. The model may write. Another witness may measure. A validator may check. A boundary authority may accept. The receipt records the chain.

---

## 9. How this differs from ordinary "coherence" scoring

Many evaluation systems use "coherence" to mean readable flow. That is a valid use of the word, but it is not the use here.

Readable flow asks:

Does this output make sense as text?

System coherence asks:

Does this output still belong to the whole?

A paragraph can flow beautifully while contradicting the thesis of the essay. A release note can be readable while describing the wrong patch. A plan can be clear while optimizing the wrong goal. A code comment can be well written while explaining an invariant the code no longer preserves.

System coherence is closer to architecture review, configuration control, provenance, and evidence binding than to prose scoring.

It is not a replacement for existing evaluations. It is a **missing evaluation target**.

An ordinary eval might ask, "Did the model answer correctly?" A coherence eval asks, "Did the answer preserve the declared relation between task, evidence, artifact, and next state?"

That question becomes more important as LLMs move from answering to acting.

---

## 10. The circularity problem

A coherence system can become circular.

It can define its own vocabulary, score itself by that vocabulary, report success, and become harder to falsify from outside. The more elegant the vocabulary, the more dangerous the closure.

This is a real risk for TSC and for any coherence framework.

The fix is not to avoid self-measurement. The fix is to make self-measurement **non-sovereign**.

A credible coherence program needs external checks.

It needs **blind human labels**. Engineers should compare patches and say which ones preserve architecture better without seeing the system's scores.

It needs **ablation tests**. Remove α, β, or γ scoring and see whether performance drops on different failure classes.

It needs **adversarial examples**. Test cases should include fluent but incoherent outputs, structurally consistent but semantically wrong outputs, locally correct but process-breaking outputs, and plausible receipts bound to the wrong evidence.

It needs **cross-model witnesses**. The model that writes should not be the only model that judges.

It needs **public failure reports**. When the coherence loop accepts a bad output, the miss should become part of the evidence.

A coherence score is useful only if reality can embarrass it.

---

## 11. What must be validated

This essay is a proposal, not a proof that the method works.

The validation burden is clear.

### 11.1 Axis independence

The first test is whether α, β, and γ actually catch different failures.

A benchmark should include examples where only one axis is weak:

- pattern drift without relation failure;
- relation failure without pattern drift;
- process failure without immediate pattern or relation failure.

If expert reviewers do not separate these cases, the triad is too ornate. If they do, the triad earns its keep.

### 11.2 Human fit judgment

The second test is whether coherence scores correlate with expert fit judgments.

For software, reviewers can rate whether a patch preserves the architecture. For papers, reviewers can rate whether a section advances the thesis. For agent workflows, reviewers can rate whether issue, patch, test, receipt, and release note still describe one unit of work.

### 11.3 Predictive value

The third test is whether low coherence predicts future cost.

A useful coherence score should predict review churn, revert risk, documentation drift, bug recurrence, migration pain, handoff failure, or release confusion.

### 11.4 Gameability

The fourth test is whether the system can be fooled.

If a model can raise coherence by repeating terms, adding links, or generating ceremonial receipts without improving fit, the witness is too shallow.

### 11.5 Boundary value

The fifth test is whether durable receipts improve continuity across time.

The cnos claim is that model capability should be rented while durable work remains in system-owned artifacts: cells, packages, receipts, coherence reports, and repo state. The empirical question is whether this boundary improves auditability, recovery, review, and multi-agent handoff.

Until these tests are run, coherent LLMs should be presented as an engineering research program, not a solved method.

---

## 12. A practical definition

A coherent LLM system is not an LLM that always tells the truth.

It is an LLM-mediated system that checks whether a candidate output still belongs to a declared whole before treating that output as accepted work.

The minimal implementation is:

1. declare the current whole;
2. generate a candidate;
3. bind evidence;
4. score α, β, and γ separately;
5. identify the weakest axis;
6. repair, refuse, or commit;
7. record the result.

The discipline is more important than the score.

- Do not let fluency stand in for fit.
- Do not let one strong dimension hide a broken one.
- Do not let the author be the only witness.
- Do not let the chat session be the system of record.
- Do not claim more coherence than was measured.

---

## 13. Why this matters for agents

Agent systems fail in ways ordinary answer evaluation does not catch.

They fail when a plan and implementation drift apart.

They fail when a tool result is summarized incorrectly.

They fail when a patch is right but the receipt binds the wrong evidence.

They fail when a second agent resumes work from a misleading handoff.

They fail when no one can tell which artifact owns the truth.

These are normal coordination failures. LLMs make them more likely to look finished.

A weak model produces small obvious errors. A stronger agent can produce plausible work across many files, tools, and steps. It can update the code, tests, docs, issue, release note, and handoff in one pass. That is useful. It is also dangerous if the artifacts no longer describe the same work.

**The more capable the model, the more important the boundary.**

Coherence measurement is not a way to make the model sovereign. It is a way to keep the work inspectable.

---

## 14. Why the title is still fair

"All We Need Is Coherence" is not literally true.

We need correctness. We need evidence. We need security. We need domain expertise. We need accountability. We need taste. We need good engineering. We need institutions that decide what is allowed to ship.

But coherence is special because it sits underneath the others.

If the artifact is incoherent, correctness checks scatter. Evidence binds to the wrong claim. Tests confirm the wrong behavior. Reviews inspect the wrong boundary. Release notes describe the wrong change. Handoffs resume the wrong task.

Coherence is not sufficient.

It may be necessary.

That is the sense in which the title is meant.

---

## 15. Conclusion

LLMs are fluent local continuers. Coherent work requires more than local continuation.

A coherent system must preserve a relation between what it says, what it changes, what it cites, what it records, and what it can do next. That relation is not guaranteed by better prose, longer context, tool use, self-reflection, search, or memory.

The next step for LLM systems is not only better generation. It is better commitment.

Before a generated move becomes work, the system should ask:

**Does this still belong to the whole?**

That question is small enough to run at runtime and deep enough to change the architecture of agent systems.

Coherence is not truth.
Coherence is not beauty.
Coherence is not correctness.

**Coherence is the condition under which correction can find the thing it is trying to correct.**
