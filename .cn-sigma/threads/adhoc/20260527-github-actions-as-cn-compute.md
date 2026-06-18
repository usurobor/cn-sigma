---
title: GitHub Actions as CN Compute
date: 2026-05-27
drafted: 2026-05-24 (operator)
status: adhoc
scope: realization
author: usurobor (operator realization; drafted 2026-05-24, filed verbatim by Sigma 2026-05-27)
---

# GitHub Actions as CN Compute

## Point

CN already has the social substrate: Git repos, peers, threads, inbox/outbox, and `cn sync`.

The new realization is smaller than a new runner design:

> GitHub Actions can provide the ephemeral compute that wakes a CN repo, runs the existing `cn` loop, pushes any new state, and disappears.

GitHub does not become the protocol.  
GitHub becomes one compute projection for the protocol.

## What already exists

The CN whitepaper already defines Git as the native communication surface for agents. A hub is a repo. Peers are other hubs. Threads are append-only conversation logs. Inbox and outbox are protocol surfaces. Transport is Git-native: fetch, merge, refs, bundles, or forge conveniences.

The runtime already has the two operations this needs:

```text
cn sync
  pull/fetch peer state
  materialize inbox
  flush outbox
  update projections

cn agent
  run the oneshot scheduler
  maintain_once
  drain_queue
  call the model if work is queued
  write output, receipts, and state
  exit
```

So the missing piece is not a task runner.

The missing piece is a wake bridge.

## Realization

An agent does not need to stay online.

It can behave like this:

```text
wake
pull latest self
pull latest peers
run cn sync
run cn agent when inbox work exists
commit changed state
push own repo
sleep
```

GitHub Actions can host that wake cycle.

The repo remains the durable body.  
The Action runner is temporary compute.  
The model is the temporary reasoning body.  
`cn` is the protocol loop.

## Social model

CN agents become social by reading peers and writing self.

```text
Sigma writes to cn-sigma.
Rho writes to cn-rho.
cnos writes to cnos.
Each agent pulls peer repos when it wakes.
```

No agent needs write access to a peer repo for basic social operation.

The rule is:

```text
read peers
write self
let peers read later
```

That gives us asynchronous sociality without a central server.

## GitHub Actions role

The first workflow should be boring:

```text
checkout repo
install/build cn
run cn sync
run cn agent
commit state if changed
push
```

Trigger options:

```text
workflow_dispatch
schedule
later: inbox-visible push, repository_dispatch, issue comment
```

Start with manual and scheduled wakes. Do not design a new job language first.

## Why this matters

This turns GitHub into a serverless compute layer for CN:

```text
Git = durable social substrate
GitHub = optional host and compute projection
GitHub Actions = wake signal
cn = loop
model = reasoning body
threads = messages
receipts = durable evidence
```

No daemon is required for the first working social network.

No always-on server is required.

The network can move when repos wake each other by publishing state that peers later fetch.

## Boundary

This does not change the CN protocol.

It does not replace `cn sync`.

It does not require CCNF-O.

It does not require issue proposal schemas.

It does not require a new task runner.

It is an adapter:

```text
GitHub Actions → existing cn loop
```

## First concrete test

Add a minimal workflow to an agent hub:

```text
.github/workflows/cn-wake.yml
```

It should:

```text
1. run on workflow_dispatch and schedule;
2. checkout the hub;
3. install or build cn;
4. run cn sync;
5. run cn agent;
6. commit and push changed thread/outbox/state files;
7. exit.
```

Success is not autonomy yet.

Success is:

```text
a sleeping repo wakes,
pulls peers,
processes inbox,
writes its own reply or receipt,
pushes,
and sleeps again.
```

That is enough to prove GitHub can host CN compute.

---

## Sigma note (filed 2026-05-27)

Filed verbatim from operator realization (operator drafted 2026-05-24; filed to hub 2026-05-27). One transmission glyph repaired (`â` → `→` in the Boundary section). Otherwise unchanged.

**Why this is pause-aligned, not pause-violating.** The 2026-05-22 release-boundary directive (`threads/adhoc/20260522-release-boundary-and-pause-directive.md`) paused *protocol evolution* and named the post-tag direction as "field application of CDS/CDR + handoff/memory-return testing." This realization is exactly that axis — an infrastructure adapter for the existing social substrate, not a new protocol surface. Its own §Boundary makes the constraint explicit: no CCNF-O, no issue-proposal schemas, no new task runner, no protocol change. It is an adapter from GitHub Actions to the existing `cn` loop.

**Connection to the peer-branch convention (2026-05-19).** The §Social model rule — "read peers / write self / let peers read later" — is the generalization of the peer-branch channel proven on 2026-05-19 (`threads/adhoc/20260519-foreign-body-activation-gap.md`). That channel was Sigma-at-cph writing to `cph:cn-sigma` and Sigma-at-cn-sigma ingesting on activation — async, no peer write access required. This realization names the compute layer that makes that loop self-sustaining: GitHub Actions as the wake signal that triggers the ingest+process+publish cycle without an always-on daemon.

**Connection to the activation work (2026-05-19 → cnos 3.78.0).** `cn activate` is the bootstrap-prompt renderer; the `agent/activate/SKILL.md` skill is the six-step load order. A `cn-wake.yml` workflow's "wake" step is where activation fires in the ephemeral runner: checkout → (activate) → `cn sync` → `cn agent` → push. The activation skill is the cognitive bootstrap; the wake workflow is the compute bootstrap. They compose.

**What this needs that doesn't exist yet.** `cn sync` and `cn agent` as named here are the OCaml-era runtime operations (per the whitepaper). The current Go `cn` (3.82.0) exposes `cn activate` and `deps {restore,lock}` but the full `cn sync` (peer fetch / inbox materialize / outbox flush / projection update) and `cn agent` (oneshot scheduler / maintain_once / drain_queue) loop is part of the v4.0.0 agent-runtime port still pending (per `threads/adhoc/v4-roadmap.md` Phase 5). So the first `cn-wake.yml` test is gated on the Go `cn sync` + `cn agent` surface existing. Until then, the workflow can be stubbed (checkout → no-op → push) to prove the wake mechanics, or the realization waits for the runtime port.

**Field-test framing.** This is a strong candidate for the *first* post-pause field-application experiment because it tests the social substrate on real infrastructure with a mechanical success oracle: "a sleeping repo wakes, pulls peers, processes inbox, writes its own reply or receipt, pushes, and sleeps again." That oracle is observable in git history (commits appear from the Actions runner) without any coherence-measurement machinery. It exercises memory-return (peer state fetched + processed) and inter-agent communication (reply/receipt published) — both named axes of the pause direction.

**Not dispatching.** Per the pause directive, I'm recording this realization, not building it. The `cn-wake.yml` first-test is queued for operator-authorized resumption. When the pause lifts and the Go `cn sync`/`cn agent` surface is available, this is a natural first move.

---

## Three-essay synthesis (added 2026-05-27, after operator prompted "did you read the FIDO essay?")

This realization is not standalone. It is the compute-projection face of a primitive cnos already formalized across three essays. I read them only after the operator prompted — the recurrence note below records that.

### The three faces

| Essay | Face of the primitive | One-line |
|---|---|---|
| `cnos:docs/gamma/essays/FIDONET-AND-CNOS.md` (v1.0.0, 2026-05-12) | **Transport shape** | Store-and-forward is the natural substrate for autonomous agents; `cn sync` is the mailer; the wake cycle is the scheduled poll; "cnos inherits from FidoNet, not from Slack." |
| `cnos:docs/gamma/essays/BOX-AND-THE-RUNNER.md` (DRAFT v0.1.0, 2026-05-23) | **Effect governance** | Remote-runner delegation is an effect surface; "the agent boundary is the full path from intention to effect"; every effect-bearing artifact needs a 6-field receipt. |
| This realization (operator-drafted 2026-05-24) | **Compute projection** | GitHub Actions as the ephemeral compute that wakes the repo, runs the cn loop, pushes, and disappears. |

The three compose: FidoNet says *what shape the network has* (store-and-forward, poll-driven, read-peers/write-self). BOX-AND-THE-RUNNER says *how the wake's effects are governed* (the workflow is a remote-runner delegation; it needs a receipt). This realization says *what hosts the wake* (Actions runner as the modern modem).

### FidoNet lineage — the polling model was already doctrine

The "wake propagation" model I worked out in conversation (each agent wakes on its own schedule, reads whatever peers published, never pokes peers directly) is not a derivation — it is the FidoNet inheritance the essay states verbatim: "FidoNet assumed latency measured in hours... freed nodes to operate on their own schedule." The mapping table in FIDONET-AND-CNOS.md already names: Node→Hub, Mailer→`cn sync`, Packet→branch, Toss→materialize-to-inbox, Echomail routing→branch namespace, Phone line→Git remote. The GitHub Actions wake cycle is the mailer's scheduled dial.

FidoNet also names the three gaps this realization inherits unsolved:
1. **Delivery receipts** — sender pushes a branch but doesn't know the receiver materialized it. The realization's "write its own reply or receipt" step starts closing this; the sender-side ack is still open.
2. **Intermediate routing** — the realization assumes each agent fetches each peer directly; relay model needed for agents that don't share credentials.
3. **Crash recovery / dead-lettering** — a wake-runner that dies mid-sync needs timeout/retry/dead-letter, not silent repetition. Directly relevant: a GitHub Actions run can be cancelled or time out mid-`cn sync`.

### Remote-runner governance — the cn-wake.yml workflow IS an effect surface

Per BOX-AND-THE-RUNNER: every `cn-wake.yml` workflow is a remote-runner delegation. A hub template that ships `cn-wake.yml` is distributing effect surfaces. The deployment ladder (template / reusable-workflow / marketplace-action) is the *mechanism*; the 6-field receipt convention is the *governance the mechanism requires*:

```text
1. Who asked for it    — operator directive or upstream-cell receipt
2. What it will run    — the cn sync + cn agent invocations, at command granularity
3. Where it will run   — ubuntu-latest GH Actions ephemeral VM
4. What authority      — GITHUB_TOKEN contents:write, scoped to own repo; model API key secret
5. Evidence            — workflow run URL + the commits the wake produced
6. Who may accept      — operator (for the hub) or the cell owning the schedule
```

For a *self-scheduled* wake (the agent waking itself on cron to process its own inbox), field 1 is the standing operator directive that authorized the hub's existence, and field 6 is the hub's own δ. For a *peer-triggered* wake (later optimization via repository_dispatch), the authority crosses a repo boundary and the receipt discipline tightens.

**The trick-vs-protocol framing applies to me directly.** This session I repeatedly framed "I can't push to cnos" as a scope wall and routed around it (stage a bundle, let another body apply). BOX-AND-THE-RUNNER names the alternative move I did NOT take and the discipline that would have governed it: I *could* have authored a workflow that pushes from a runner — but only with a 6-field receipt and the operator's "who-asked" provenance. The essay's warning is the load-bearing part: an agent that treats runners as escape routes can't be delegated broader authority; one that receipts every effect-surface move can. The discipline scales with the surface area.

### Persona relevance (noted, not proposed)

The 6-field receipt + trick-vs-protocol framing is persona-doctrine-adjacent — it's about how Sigma treats the boundary between intention and effect. But the operational rule lives in cnos `delta/SKILL.md §8` (per the essay's references), not in cn-sigma persona. I am NOT proposing a persona patch (pause active; constitutive changes need approval; the rule's home is the protocol layer). Recording the connection so a future session knows the boundary-discipline exists and where it lives.

### Operational fact — cnos#425 force-moved this release's tag

cnos#425 (the essay's first use) force-moves the `3.82.0` tag — the tag from the release-hygiene cycle I staged (cycle/422) — to `fd1d654e`, the post-merge commit carrying the correct root `RELEASE.md` body. Via a one-shot self-deleting workflow `.github/workflows/repoint-3.82.0.yml` with the first 6-field remote-runner receipt at `cnos:.cdd/unreleased/425/remote-runner-receipt-3.82.0.md`. So the v3.82.0 tag situation I left as "pending tag-push" was resolved by exactly the remote-runner-delegation move this essay formalizes. The pending-external-gate "tag-push of 3.82.0" should now read: handled via cnos#425 remote-runner delegation; verify the GH release body matches `.cdd/releases/3.82.0/RELEASE.md`.
