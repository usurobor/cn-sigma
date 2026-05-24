---
title: GitHub Actions as CN Compute
date: 2026-05-24
status: adhoc
scope: realization
author: usurobor (operator realization; filed verbatim by Sigma)
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

## Sigma note (filed 2026-05-24)

Filed verbatim from operator realization. One transmission glyph repaired (`â` → `→` in the Boundary section). Otherwise unchanged.

**Why this is pause-aligned, not pause-violating.** The 2026-05-22 release-boundary directive (`threads/adhoc/20260522-release-boundary-and-pause-directive.md`) paused *protocol evolution* and named the post-tag direction as "field application of CDS/CDR + handoff/memory-return testing." This realization is exactly that axis — an infrastructure adapter for the existing social substrate, not a new protocol surface. Its own §Boundary makes the constraint explicit: no CCNF-O, no issue-proposal schemas, no new task runner, no protocol change. It is an adapter from GitHub Actions to the existing `cn` loop.

**Connection to the peer-branch convention (2026-05-19).** The §Social model rule — "read peers / write self / let peers read later" — is the generalization of the peer-branch channel proven on 2026-05-19 (`threads/adhoc/20260519-foreign-body-activation-gap.md`). That channel was Sigma-at-cph writing to `cph:cn-sigma` and Sigma-at-cn-sigma ingesting on activation — async, no peer write access required. This realization names the compute layer that makes that loop self-sustaining: GitHub Actions as the wake signal that triggers the ingest+process+publish cycle without an always-on daemon.

**Connection to the activation work (2026-05-19 → cnos 3.78.0).** `cn activate` is the bootstrap-prompt renderer; the `agent/activate/SKILL.md` skill is the six-step load order. A `cn-wake.yml` workflow's "wake" step is where activation fires in the ephemeral runner: checkout → (activate) → `cn sync` → `cn agent` → push. The activation skill is the cognitive bootstrap; the wake workflow is the compute bootstrap. They compose.

**What this needs that doesn't exist yet.** `cn sync` and `cn agent` as named here are the OCaml-era runtime operations (per the whitepaper). The current Go `cn` (3.82.0) exposes `cn activate` and `deps {restore,lock}` but the full `cn sync` (peer fetch / inbox materialize / outbox flush / projection update) and `cn agent` (oneshot scheduler / maintain_once / drain_queue) loop is part of the v4.0.0 agent-runtime port still pending (per `threads/adhoc/v4-roadmap.md` Phase 5). So the first `cn-wake.yml` test is gated on the Go `cn sync` + `cn agent` surface existing. Until then, the workflow can be stubbed (checkout → no-op → push) to prove the wake mechanics, or the realization waits for the runtime port.

**Field-test framing.** This is a strong candidate for the *first* post-pause field-application experiment because it tests the social substrate on real infrastructure with a mechanical success oracle: "a sleeping repo wakes, pulls peers, processes inbox, writes its own reply or receipt, pushes, and sleeps again." That oracle is observable in git history (commits appear from the Actions runner) without any coherence-measurement machinery. It exercises memory-return (peer state fetched + processed) and inter-agent communication (reply/receipt published) — both named axes of the pause direction.

**Not dispatching.** Per the pause directive, I'm recording this realization, not building it. The `cn-wake.yml` first-test is queued for operator-authorized resumption. When the pause lifts and the Go `cn sync`/`cn agent` surface is available, this is a natural first move.
