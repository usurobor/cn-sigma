# Dumb Models, Smart Cells — doorway essay (companion to "Agents Need a Home")

**Date:** 2026-06-20
**Class:** doorway-essay (project-position-from-inside; reviewer + operator iterated)
**Author:** Reviewer-drafted; γ-console iterated; operator finalized
**Source:** Two-round Bohmian iterate between reviewer's draft, γ-console's revision proposal, and operator's three sharpening corrections

## Why this is captured here

Second doorway essay in 24 hours. Pairs with [yesterday's "Agents Need a Home"](20260620-agents-need-a-home-doorway-essay.md):

- **"Agents Need a Home"** defines the *home*: a Git-native place where agent identity, memory, work, and receipts survive the chat session
- **"Dumb Models, Smart Cells"** defines *what lives in it*: bounded work-units with a body outside the model, surrounded by a system that decides what counts as done

Read together, the pair establishes the cnos position in two complementary axes — *where work persists* and *who owns the work* — before the architecture verdicts (cnos#467 package-owned runtime; cnos#460 privacy-as-explicit-policy; cnos#459 single Sigma identity) land in protocol form.

Captured as Sigma adhoc, not cnos essay, for the same reasons as the first:
- cnos essays at `gamma/essays/` are protocol doctrine read by future Sigmas loading skills
- this is project-position-from-inside / doorway-for-outside; different audience, different use
- adhocs at cn-sigma have always been the home for reflective synthesis pieces (committer-identity, privacy modes, coherer-vs-wake-worker boundary); essay is same genre, manifesto register

## Iteration trail (Bohmian dialogue)

Original reviewer draft → γ-console iterate verdict (3 changes: compress duplicated Unix-vs-product sections; preempt the "dumb" reader-bail by moving "dumb is a boundary" earlier; add a "where work lives" section that sets up the cell before its load-bearing trio fires) → operator accepted iterate + sharpened with 3 corrections:

1. **Added "receipt owns evidence" to the first ownership list** — restores structural symmetry with the closing stanza
2. **Changed cell definition from GitHub-specific to abstract-plus-example** — keeps the concept portable across implementations (research package, content-ops package, future packages); the GitHub-specific version would have foreclosed that portability
3. **Added "the work has a body outside the model"** — makes the cognitive-lock-in argument concrete; without it, "lock-in is cognitive" reads as abstraction

Operator's call: "I would not make it longer. The current compression is right."

The pair-with-prior-essay observation: this essay's *cell* concept hangs on yesterday's *home* concept. A cell needs a body somewhere; the body lives in a home. The two essays compose without overlap.

## Forward-looking notes

- Same as yesterday's essay: "Cohere as this agent" syntax referenced obliquely (here implicit in "smart system") is aspirational — cnos#444 still held per D14
- "Receipts over vibes" closing tagline — load-bearing for the project's posture; quotable
- The abstract cell definition lays the doctrinal groundwork for future package authors (research, content-ops, etc.); they'll implement cells with their own artifact shapes

---

## Essay (verbatim)

# Dumb Models, Smart Cells

Every agent builder picks a camp.

Either the LLM is the system, or the system is the system.

One answer makes the model smarter every quarter. The other answer makes the model replaceable every quarter.

cnos picks the second.

## Two camps

A "smart model" architecture absorbs more responsibility into the vendor runtime.

Native tools. Memory. Workflow. Connectors. Background tasks. Hosted agents. Permissions. Logs.

Each feature is useful on its own.

Together they turn the vendor's product into your operating environment.

The work no longer lives in your system. It lives in someone else's.

A "smart system" architecture inverts that.

The repo owns state.
The runtime owns effects.
The protocol owns handoff.
The receipt owns evidence.
The package owns local cognition.

The model receives a bounded job, makes one move, returns output.

The system decides what to keep, reject, store, review, hand off.

The model is powerful inside the call.

The system is sovereign across calls.

## Dumb is a boundary, not an insult

A dumb model can still reason well.

It can write code, summarize evidence, draft plans, inspect files, propose changes, explain tradeoffs.

It just doesn't own the system.

It doesn't get implicit authority.

It doesn't mutate reality without a governed path.

It doesn't become the only place where memory lives.

It doesn't turn chat history into infrastructure.

The model can be smart inside the call.

The system must be smarter across calls.

## The Unix posture

When you build the second way, the model behaves like `grep`, `awk`, or a compiler pass.

Explicit input.

Explicit output.

No hidden ownership of the workflow.

This is the Unix posture: power comes from composition, not from any one tool.

A Unix-shaped tool can be replaced, wrapped, piped, inspected from outside. It does not need to know the whole system to be useful inside it.

That posture lets the system survive when the model is wrong, slow, expensive, unavailable, or obsolete.

Models will change.

Vendors will change.

APIs will change.

Prices will change.

Capabilities will change.

The work should not disappear when any of that changes.

## The product-suite shape

The opposite shape is the polished feature-rich product.

That is often good for users.

It is dangerous for infrastructure.

The more the product owns, the harder it is to leave.

The more it hides, the harder it is to audit.

The more it integrates, the more your system inherits its assumptions.

This is the natural shape of commercial AI products.

They want model, memory, workflow, tools, files, logs, permissions, and deployment in one owned environment.

That is not conspiracy.

It is the business model.

Feature growth creates lock-in.

## Lock-in is cognitive

Vendor lock-in does not begin when you sign a contract.

It begins when your work loses an independent body.

If your agent memory lives in a vendor product, you are locked in.

If your workflow lives in a vendor product, you are locked in.

If your audit trail lives in a vendor product, you are locked in.

If your definition of "done" lives in a vendor product, you are locked in.

The lock-in is not only economic.

It is cognitive.

Your system forgets how to describe itself without the vendor.

A dumb-LLM architecture prevents that.

The model becomes a worker, not the workplace.

The vendor becomes a provider, not the substrate.

The system keeps its own memory, receipts, and continuity.

## Where work lives: the cell

If the model is dumb and the system is smart, where does coherent work actually live?

In a cell.

A cell is the bounded unit where intent, state, matter, evidence, review, receipt, decision, and handoff stay together.

A message enters.

Work is produced.

Evidence is bound.

Review happens.

A receipt closes the loop.

A decision determines what crosses the boundary.

In a Git-backed cell, that may look like an issue, branch, diff, review, receipt, and handoff. In another domain, it may look like a document, dataset, model run, approval, audit packet, or operational decision.

The implementation can change.

The invariant is the same: the work has a body outside the model.

The model may enter the cell.

The model may act inside the cell.

The model may produce matter for the cell.

But the model is not the cell.

The cell survives the call.

The receipt survives the model.

The repo survives the vendor.

## Why open source wins this way

Open source cannot win by copying feature-rich vendor products one feature at a time.

That game favors the vendor: faster integration, harder polish, subsidized usage, more of the stack collapsed into owned environments.

Open source wins where Unix won: small parts, stable interfaces, inspectable state, community composition, replaceable components.

For agent systems, that means:

> the repo owns state,
> the runtime owns effects,
> the protocol owns handoff,
> the receipt owns evidence,
> the package owns local cognition,
> the model owns only the bounded move it was asked to make.

That is an open architecture.

A community can build tools around it.

A team can replace one model with another.

A domain can add its own packages.

A reviewer can inspect what happened.

A future agent can continue from durable state instead of guessing from chat.

## The choice

You can build around smart products.

Or you can build smart systems out of bounded, replaceable executors.

You can let the vendor runtime become the place work lives.

Or you can make work durable outside the vendor.

You can treat the LLM as the operating system.

Or as one tool inside a coherent operating surface.

cnos chooses the second path.

Dumb models.

Smart cells.

Durable state.

Governed effects.

Receipts over vibes.

The model should be smart enough to move the work forward.

It should be dumb enough not to own the work.

---

## Related artifacts

- **[20260620-agents-need-a-home-doorway-essay.md](20260620-agents-need-a-home-doorway-essay.md)** — first doorway essay (defines the home; this one defines what lives in it). Pair reads as: home + cells.
- **cnos#467** — package-owned wake providers architecture verdict; the "package owns local cognition" line in this essay's two-camps section anchors on that verdict
- **cn-sigma:.cn-sigma/threads/adhoc/20260616-coherer-console-vs-wake-worker.md** — earliest internal naming of the boundary doctrine; this essay's "model can be smart inside the call; system must be smarter across calls" generalizes it to the model/system axis
- **cn-sigma:.cn-sigma/threads/adhoc/20260618-privacy-modes-and-memory-return.md** — Amendment 3 (asymmetric subscription); the "vendor becomes a provider, not the substrate" framing depends on this boundary
- **cnos:docs/gamma/essays/AGENT-MEMORY-LOG-STRUCTURED.md** — memory-essay; the "system keeps its own memory" line in lock-in-is-cognitive section sources from there
- **cnos:README.md** — current cn binary scope; "what exists today" anchor (same as yesterday's essay)

## Standing

Internal canonical record landed. External publication is a separate move whenever operator chooses — say the word and γ-console drafts the operator-facing version.
