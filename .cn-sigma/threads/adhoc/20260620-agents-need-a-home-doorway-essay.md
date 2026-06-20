# AI Agents Need a Home — doorway essay

**Date:** 2026-06-20
**Class:** doorway-essay (project-vision-from-inside; reviewer-supplied verbatim)
**Author:** Reviewer (operator-relayed); captured by γ-console
**Source:** Reviewer-supplied Medium-style draft, 2026-06-20

## Why this is captured here

This essay synthesizes the cnos project's vision at the hinge moment when the reviewer's [cnos#467 architecture verdict](https://github.com/usurobor/cnos/issues/467) is about to land — the verdict that Sigma is the *console*, packages own the *runtime*, and the wake is not one thing but a family of admin + per-package dispatch wakes.

It belongs as a Sigma adhoc, not a cnos essay, because:
- cnos essays (`gamma/essays/...`) are protocol doctrine read by future Sigmas loading skills — this isn't that
- This is project-vision-from-inside / doorway-for-outside; different audience, different use
- adhocs at cn-sigma have always been the home for reflective synthesis pieces (committer-identity convention, privacy modes, coherer-vs-wake-worker boundary) — this is the same genre at a bigger scale

**Forward-looking note:** the essay says "Cohere as this agent" as the one-verb invocation. Today cnos#444 (cohere skill) is held per D14; v3.83.0 hasn't shipped. The "cohere as" syntax is aspirational — describes the vision, not current-state. Future readers should not try `cn cohere` and expect it to work yet.

**Load-bearing sentence in the essay:**
> Use intelligence where meaning is unresolved. Use code where the rule is known.

That cut shows up in three places this week:
- cnos#467 architecture verdict (console vs package runtime)
- coherer-vs-wake-worker boundary doctrine (γ-console = coherer; wake = mechanical executor)
- this essay's "the middle should become boring"

Three framings of the same cut. The essay's value is naming it accessibly — teachable to people who haven't lived the regressions that taught us each version.

---

## Essay (verbatim)

cnos is an experiment in giving agents memory, work, receipts, and a place to wake up.

Most AI agents today are brilliant in the moment and fragile across time.

They can write code.
They can summarize documents.
They can plan work.
They can debug systems.
They can explain almost anything.

But ask them to continue the same project across days, repos, tools, failures, humans, and other agents, and something starts to break.

They forget why a decision was made.

They claim work is done when it is only plausible.

They lose constraints.

They repeat old mistakes.

They change their assumptions halfway through.

They produce outputs, but not continuity.

The problem is not only intelligence.

The problem is coherence.

An agent needs more than a prompt. It needs a place where its identity, memory, work, evidence, and decisions can survive the current conversation.

It needs a home.

That is what cnos is trying to build.

---

### A chat is not a home

Today, most AI work happens inside a chat window, an IDE session, a workflow run, or a product surface.

That can be useful.

But a chat is a bad place to keep a life.

It is too private, too temporary, too vendor-shaped, too hard to inspect, and too easy to lose. A chat can remember the current conversation, but it does not naturally become a durable body of work.

Real work needs more.

It needs files.
It needs history.
It needs issues.
It needs branches.
It needs logs.
It needs review.
It needs receipts.
It needs a way to say, "This happened," and "This is why we trust it," and "Here is what should happen next."

Software already has a place like that.

It is called a repository.

cnos starts there.

A cnos hub is a Git repository an agent can wake into, read, write, remember through, and use to coordinate with humans and other agents. Git stores the durable state. The cn command prepares and checks the hub.

The idea is simple:

An agent should not live only in a chat.
It should have a Git-native home.

---

### Coherence means the system still describes one thing

The "c" in cnos is coherence.

That word can sound abstract, but the practical meaning is simple.

The issue should match the work.

The work should match the receipt.

The receipt should point to evidence.

The memory should explain why the decision was made.

The next wake should start from what actually happened, not from what the agent wishes happened.

A coherent system minimizes the gap between its model and reality: what it believes, records, predicts, or assumes versus what the world, repo, operator, runtime, and evidence actually say.

This matters because agents are very good at sounding coherent.

They can produce a beautiful explanation.

They can say "done."

They can summarize a plan.

They can confidently tell you what changed.

But the real question is not whether the answer sounds coherent.

The real question is whether the system itself remains coherent.

Do the artifacts agree?
Can the work be inspected?
Can another agent continue it tomorrow?
Can a human see what happened?
Can the system learn from failure without inventing a story?

cnos is not trying to make agents merely more autonomous.

It is trying to make agent work more inspectable, correctable, and continuous.

---

### The human talks to the console

The most natural way to work with an agent is still conversation.

A human says:

I want to build this.
I think this is wrong.
Can you inspect the repo?
Turn this into an issue.
What should happen next?

In cnos, that human-facing agent is the console.

It may be Claude Code attached to a repo. It may be ChatGPT in a hosted session. It may be some future model body. The exact model is not the point.

The point is the role.

The interactive agent helps the human clarify intent. It reads the repo. It writes specs. It opens issues. It explains gates. It asks for missing decisions. It turns vague human direction into artifact-backed work.

But it should not be the whole system.

The console is where ambiguity is resolved.

The worker is where bounded work runs.

That distinction is important.

If the human tells the interactive agent something that future workers must know, it must land in an artifact: an issue, a log, a spec, a state file, a comment, a commit, or a receipt.

Hidden chat context is not a reliable input for future work.

The rule is:

The human-facing agent may speak for the operator into artifacts.
Workers may act only from artifacts.

---

### Issues become contracts

A lot of AI automation fails because the agent starts too early.

Someone opens an issue to think out loud.

Someone comments with a half-formed idea.

Someone writes a rough plan.

The agent sees "open issue" and starts building.

That is not autonomy.

That is a boundary failure.

cnos treats an issue as a contract only when it is ready to become one.

The human and the console can discuss, refine, split, and improve the issue while it is still just a planning surface. When the human decides the work is ready, the issue moves into a dispatchable state.

Then a worker can claim it.

That means the flow becomes legible:

Conversation becomes a spec.

The spec becomes an issue.

The human authorizes the issue.

A worker claims one issue.

The worker does the work.

The worker returns evidence.

The result is reviewed.

The memory is updated.

The point is not ceremony.

The point is that no autonomous system should guess when a human has stopped thinking and started authorizing.

A label can be more than a label.

It can be a switch.

---

### A cell is more than a task

Most task runners ask:

What should I do?

A cnos cell asks something stronger:

What should I do, how will it be reviewed, and what evidence will prove what happened?

That is the difference between output and trustworthy work.

Inside the current cnos method, work is split into roles. One part produces. Another reviews. Another closes the loop by binding the matter, review, and evidence into a receipt.

You do not need to know the internal Greek letters to understand the pattern.

It is the same pattern good teams already use.

Someone writes the change.

Someone reviews the change.

Someone records what shipped, what failed, what remains, and why the result should be trusted.

Agents need that too.

Especially agents.

Because an agent can sound finished long before the work is actually finished.

So cnos tries to make "done" mean something visible.

Not "the model said it was done."

Done means there is a receipt.

Done means there is evidence.

Done means a future human or agent can inspect the path.

---

### Memory starts as logs

Many AI memory systems begin with retrieval.

Vector stores.
Embeddings.
Search.
Knowledge graphs.
Memory plugins.

Those are useful.

But cnos starts with a simpler law:

Log first.
Compact later.
Promote when stable.
Measure coherence.

A raw log remembers what happened.

A reflection remembers what mattered.

A state file remembers where to resume.

A spec or protocol remembers what must constrain future work.

This keeps memory honest.

The raw evidence does not disappear just because a later summary sounds better. A reflection should cite what it read. A promoted rule should point back to the reflection or evidence that earned it. The memory essay in cnos frames this as coherence-preserving compaction over append-only evidence.

This is not a database fantasy.

It is closer to how serious work already survives.

Write down what happened.

Review it.

Compress it.

Promote only what has become stable enough to guide the future.

---

### Wakes make the agent recurrent

A cnos agent is not only a chat persona.

It can wake.

A wake is a scheduled or event-triggered run that loads the repo, reads its state, checks what changed, does bounded work, and reports what happened.

GitHub Actions is a natural early carrier for this because workflows can run on GitHub events, on a schedule, or through manual triggers.

This matters because it gives an agent a pulse.

An agent can wake in its home repo.

It can wake in a foreign repo where it is helping with work.

It can read logs from other activations.

It can update status.

It can notice that a worker failed.

It can tell the human what is blocked.

It can leave a new log entry so the next wake starts from evidence, not amnesia.

No separate server is required for the early shape.

No special box.

A repo, a workflow, a model body, and disciplined artifacts are enough to begin.

That is the practical magic of the design.

An agent can be "alive enough" inside the infrastructure software teams already use.

---

### The worker should become boring

Right now, much of this is being shaped with Claude.

That is deliberate.

When the shape of the system is still unknown, a strong interactive model is useful. It can notice contradictions. It can review issues. It can inspect logs. It can help the operator decide what the next coherent move should be.

But this is a bootstrap phase.

The final architecture should not depend on a large model improvising the same protocol every time.

Once the shape is proven, repeated logic should move into mechanical commands.

A package should install its own wake.

A command should render the workflow.

A script should claim the issue.

A validator should check labels.

A package runtime should know where receipts go.

The model should not decide basic facts like:

Which issue is dispatchable?
Which labels are valid?
Where does the cursor live?
What file should receive the receipt?
Is this privacy mode allowed?
Should this repo be written to?

Those are not intelligence problems.

Those are protocol problems.

The rule is:

Use intelligence where meaning is unresolved.
Use code where the rule is known.

In the future cnos shape, the human-facing agent still matters. The leaf agents still matter. A model may still write code, review meaning, summarize evidence, or resolve ambiguity.

But the middle should become boring.

That is how the system becomes reliable.

---

### Packages own work

Sigma should not know how to run every kind of work.

A software-development package should own software work.

A research package should own research work.

A writing package should own writing work.

A future package should own its own dispatch rules, workflows, labels, commands, and receipts.

This is another important separation.

The agent is not the runtime.

The package owns the runtime.

The human-facing agent can help prepare work. It can create the issue. It can apply labels when authorized. It can explain what will happen. It can report status.

But the work itself should be claimed by the package that knows how to do it.

That is how cnos avoids becoming one giant prompt.

It becomes a set of installable, inspectable, versioned capabilities.

A repo that wants software work installs the software-work package.

A repo that wants research work installs the research-work package.

A repo that only wants an agent memory and admin console installs only that.

The workflow file is only the carrier.

The package is the owner.

---

### Agents can work across repos

The vision is not one agent trapped in one repository.

A home agent can have activations in other repos.

A repo can become a body of an existing agent.

A private repo can choose how much it wants to disclose.

A public repo can share protocol lessons back.

Different agents can eventually communicate as peers.

But this only works if the boundaries are explicit.

Who owns the memory?

Who is allowed to write?

Which repo is the source of truth?

Which information can leave a private project?

Which package owns this dispatch?

Which worker is allowed to act?

These questions sound administrative.

They are actually the architecture.

A system that cannot answer them will eventually leak data, duplicate work, lose memory, or confuse one agent's authority with another's.

So cnos treats the boring parts as load-bearing.

Labels.
Logs.
Receipts.
Cursors.
Privacy modes.
Package ownership.
Human gates.
Writer locality.

That is not overhead.

That is how autonomous work becomes safe enough to continue.

---

### What exists today

cnos is not finished.

That should be said plainly.

Today, the Go cn binary supports the hub and package-management path: creating hubs, setting them up, restoring dependencies, checking health, building packages, updating, and inspecting state. The full agent runtime is not yet shipped. The README names planned runtime work such as an agent daemon/scheduler, thread queue processing, inbox/outbox sync, package command discovery and dispatch, and enforcement layers.

The current work is proving the shape.

Claude is acting as the flexible human-facing console while the protocol is still moving.

GitHub Actions is acting as the early wake carrier.

Issues are becoming the dispatch surface.

Logs are becoming the memory surface.

Packages are becoming the owners of work.

The system is learning where the prompt should end and the command should begin.

This matters.

If we mechanize too early, we freeze the wrong shape.

If we leave everything inside Claude forever, the system drifts.

So the current state is intentionally transitional.

Use Claude to discover the protocol.

Then move the stable protocol into cn, package commands, scripts, validators, and generated workflows.

That is the path from experiment to product.

---

### What "playable" should mean

The goal is simple to say.

A person should be able to enter a repo and say:

Make me a cnos agent.

Or:

Cohere as this agent.

Then the system should create the right surfaces.

Identity.
State.
Logs.
Threads.
Policies.
Workflows.
Package wakes.
Labels.
Secrets checklist.
Registration gates.
Privacy mode.
Current status.

If the system can do something safely, it should do it.

If the human must decide something, it should ask clearly.

If a credential is missing, it should say exactly which one.

If the repo is private, it should ask what may be disclosed.

If the wake is not armed, it should explain why.

If the package is not installed, it should install or report the missing step.

That is what "playable" means.

Not magic.

Not a demo that hides the hard parts.

A real setup path where the human can click a button, answer the gates, and see the agent become a durable participant in the repo.

---

### The future state

The future cnos should feel simple from the outside.

A human talks to an agent.

The agent writes specs and issues.

The human authorizes work.

A package-owned wake claims the issue.

A worker runs the cell.

The cell leaves receipts.

The agent reports what happened.

Memory compacts over time.

The system becomes more coherent.

Under the hood, many things are happening.

But the user should not need to care at first.

They should see a repo that now has an agent body.

They should see work that leaves evidence.

They should see issues that mean something.

They should see logs that explain what happened.

They should see a system that can wake tomorrow and continue.

That is the vision.

Not one enormous AI in the cloud.

Not a black-box agent platform.

Not a chatbot with a longer memory.

A Git-native coherence system where agents, humans, packages, workflows, issues, commits, logs, and receipts all participate in the same durable loop.

---

### The point

AI agents do not only need better models.

They need better bodies.

They need places to wake.

They need memory that can be inspected.

They need work that can be reviewed.

They need boundaries that can be trusted.

They need protocols that can move from prompt to code.

They need a way to learn without inventing a story.

That is what cnos is trying to build.

At first, with Claude helping us discover the shape.

Later, with most of the shape mechanized into commands and packages.

And always with the same goal:

not more autonomy for its own sake,

but more coherent autonomy.

An agent needs a home.

In cnos, that home begins with a repo.

---

## Related artifacts

- **cnos#467** — package-owned wake providers architecture (the verdict that distinguishes console vs runtime); essay synthesizes the model the verdict establishes
- **cn-sigma:threads/adhoc/20260616-coherer-console-vs-wake-worker.md** — earliest internal naming of the console vs worker boundary; essay generalizes it to console vs package runtime
- **cn-sigma:threads/adhoc/20260618-privacy-modes-and-memory-return.md** — Amendment 3 (asymmetric subscription: home publishes, activations consume); essay's "agents can work across repos" section depends on this doctrine
- **cn-sigma:threads/adhoc/20260618-committer-identity-convention.md** — agent identity in committer email; essay's "boundaries that can be trusted" lands on this
- **cnos:docs/gamma/essays/AGENT-MEMORY-LOG-STRUCTURED.md** — the memory-essay the doorway references for coherence-preserving compaction
- **cnos:README.md** — current cn binary scope (hub + package management); essay's "what exists today" section sources its honesty from this
