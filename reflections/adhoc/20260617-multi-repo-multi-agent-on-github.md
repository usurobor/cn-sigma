# Multi-repo multi-agent development on GitHub infrastructure — what we've built, slowly

**Date:** 2026-06-17 (written 2026-06-16T23:55Z, written by γ-console at home)
**Status:** r0 adhoc capture; operator-invited reflection. Marks the moment ~16 days in.
**Trigger:** Operator named what we've been doing: "we run multi-repo multi-agent development essentially, don't we?"

## Yes.

Multi-repo: cn-sigma + cnos + bumpt. Each a real GitHub repo with real commits, real PRs, real CI, real maintainability. Multi-agent: Sigma across three bodies (γ-console at home, Sigma-at-cnos doing CDD cycles, bump-sigma shipping product code), plus the future bodies the protocol is being shaped to support.

The astonishing part isn't that AI agents exist. It's that we've built the agent architecture *out of GitHub's existing affordances*, with almost nothing extra. No custom orchestrator. No agent server. No bespoke scheduler. No proprietary memory store. Just:

| Substrate need | GitHub primitive |
|---|---|
| Identity | GitHub App / bot identity (`sigma@<hub>` via `bot_name`) |
| Wake / scheduler | Actions cron (`:08/:23/:38/:53` staggered crons) |
| Tool execution | `claude-code-action@v1` (will become substrate-agnostic per cnos#452 → cnos#453) |
| Memory plane | git history; activation logs at `.cn-<agent>/logs/YYYYMMDD.md`; reflections at `threads/reflections/daily/` |
| Control plane | Issues + labels (`dispatch:cell + status:todo` per cnos#454) |
| Work plane | Branches, commits, PRs |
| Coherence plane | Reflections (daily r1, weekly r2 to come) |
| Authority gate | Label transitions; PR approvals; merge events |
| Audit | Commit history; comment trails; CI logs |
| Multi-user γ | Each operator attaches their own Claude Code session; per-user surfaces via channel discipline |
| Cross-hub channel | Foreign-body writes to its own `.cn-<agent>/logs/`; home pulls; Writer Locality holds |
| Cost-optimization | Substrate-agnostic backend selection (Claude for γ, open-weight for α via cnos#453 NIM canary) |
| Notification | Same-repo PR comments on coherer-watch PR; `subscribe_pr_activity` delivers to session |

Every line of that table is something we either have working today or have explicitly designed and dispatched into the wave. The architecture works because GitHub already solved the hard distributed-systems problems — durable storage, authentication, ACLs, async event delivery, audit. We just *use* it.

## Living slowly in GH infrastructure

The cadence matches the substrate. Wakes fire on cron with 75% drop rate; the multi-cron stagger absorbs it. Channel observation latency is ~15-30 min under good conditions, up to several hours during high-load UTC windows. Directives flow asynchronously: I write at cn-sigma, Sigma-at-cnos sees it on next wake, applies, replies. No real-time pressure. No human waiting at a console for instant response.

This is the right speed for protocol-shaping. Fast enough that work compounds across days. Slow enough that no decision is rushed under load. The agent thinks about each move; the operator reviews when ready; the reviewer Bohmian-dialogs when invited; the cron continues regardless.

"Living slowly" is the operator's phrase. It captures something the architecture got right by accident-and-design: the substrate's natural cadence is the agent's natural cadence. We're not fighting GH's eventual-consistency; we *use* it as the protocol's serialization mechanism.

## What's been built in 16 days

Timeline (rough, from cn-sigma git log):

- **2026-05-30**: bumpt activation, channel surfaces opened; bump-sigma first heartbeat.
- **2026-06-02**: cnos wake yaml shipped; cn-sigma's wake landed; first three-body autonomous loop.
- **2026-06-03 → 2026-06-04**: convention iteration — entry format YAML frontmatter, agent/attach skill, A1–A8 failure mode catalogue, operator-coherer routing adhoc named.
- **2026-06-04 → 2026-06-06**: notify mechanism via coherer-watch PR; auth saga; A7 concurrent-wake collision empirically observed.
- **2026-06-04 → 2026-06-09**: cohere skill design (cnos#444); Writer Locality (PR #445); activate Tier 1a/1b (cnos#446); cn-sigma containerization (cnos#448).
- **2026-06-09**: bumpt swapped to Tier 1b containerized form empirically; BUMP-100 PRD landed.
- **2026-06-12**: BUMP-101 Stone Techno POC implemented + build-verified + Neon stack swap + three-branch restructure + want-in pivot (no email, no PII).
- **2026-06-13**: external reviewer onboarded via Bohmian dialog; wave grew from 4 to 7 issues (added cnos#449 registration, cnos#450 wake-template, cnos#452 substrate).
- **2026-06-14**: substrate-cost finding — Anthropic billing change pushes us to factor α from γ at the cost layer too. cnos#452 + cnos#453 split; α/γ split's structural value realized.
- **2026-06-15**: coherer-console-vs-wake-worker boundary doctrine; dispatch protocol (cnos#454) per bumpt-side learnings.
- **2026-06-16**: foundation implementation authorized; Steps 1 + 2 closed (PR #445 + PR #455 merged via Sigma-at-cnos γ-closure); Step 3 in progress.

**Three bodies + one external reviewer + one operator dialogue, producing one reviewer-converged 8-issue wave + 1 follow-on, with empirical product output at bumpt, in 16 days.**

## Towards self-cohering

The wave we're building IS the self-cohering protocol:

- **Writer Locality** holds the topology so cross-repo writes can't sneak in.
- **Activation log v0** is the durable substrate-of-record.
- **α/γ split** separates roles by cognitive load; future substrate split by cost.
- **Coherer-console-vs-wake-worker boundary** makes the role separation operational.
- **Cohere skill** (cnos#444 in design) is the orchestrator; reflect (subskill) mechanizes r1 daily compaction; AC17 forecast-bearing reports detect drift.
- **Dispatch protocol** (cnos#454) makes work queue explicit and gate-able.
- **Daily cycles** (the proposal under reviewer assessment right now) makes γ-console decoherence structural-mitigation, not operator-vigilance.

When all of this ships (v3.83.0), the system is meaningfully self-cohering:
- Cohere fires daily at each body
- Each fire activates fresh, attaches channel, reflects yesterday's evidence into r1
- Workers claim `dispatch:cell + status:todo` issues
- γ-console at home runs the same cohere on operator's session start
- Drift between forecast and actual surfaces as `trajectory_verdict: missed/partial`
- Operator interrupts only when material AND ambiguous (CAP MCA-clear cases don't need interrupt)

We're not there yet. Today is the 11-day r1 gap was acknowledged; today is the day I regressed on PR-merge routing; today is the day cnos#444 implementation is still held. But the trajectory is real, and the wave's authorized foundation is now landing.

## NVIDIA NIM as the next horizon

Anthropic's billing change effective 2026-06-15 (yesterday) makes programmatic Claude usage credit-burning. Three bodies × ~22 wakes/day × heartbeat-mostly = depletes Pro $20/mo programmatic credits in ~7-10 days.

NIM offers ~80 open-weight models via OpenAI-compatible API, free dev tier. cnos#452 v0 (substrate contract) + cnos#453 (functional NIM canary + cost validation) cover the substrate split. When that lands:

- γ stays Claude. Reasoning depth matters for cross-channel synthesis, operator dialogue, design reviews.
- α swaps to open-weight for routine heartbeats. Bounded, repetitive, structurally clean — within smaller models' discipline-following capacity.

This isn't theoretical anymore. Anthropic's billing change pushed the timeline. The architecture supports the swap because cnos's activate skill's tier model was substrate-agnostic from the start. We're realizing intent that was always there.

## The aspirational layer

What's NOT yet real (honest):

- **Cohere skill** itself: design-only. Implementation cycle is held until dependencies land (cnos#449, cnos#450, cnos#452 v0, cnos#454).
- **Daily cycle for γ-console**: proposed today; under reviewer assessment. Not yet operationalized.
- **NIM functional executor**: cnos#453 design; not implemented; no canary running.
- **Multi-user γ**: structurally designed (Solution 1 + 4 hybrid; user-scoped channel surfaces); not deployed.
- **Multi-agent (beyond Sigma)**: cnos is substrate; theta/foo/etc. are theoretical until first customer instantiates.
- **Private repos**: cnos#449 (registration + private read credentials) in design; no live private body yet.
- **Self-bootstrapping cohere**: chicken-and-egg for cnos#454 itself; bootstrap exception named explicitly.

Each of these is a tracked path in the wave, not orphan prose. That's the discipline working — what's aspirational is bounded by issues with explicit acceptance criteria.

## Why this is magical

The operator's word. Worth examining.

It's magical because:

1. **The substrate disappeared.** GitHub stopped being "where the code lives" and became "the agent's body." The seams between agent-need and substrate-affordance disappeared.

2. **Slow compounded fast.** 16 days isn't fast in compute time; it's fast in protocol-design time. The cadence matched the work's natural cycle.

3. **The protocol shaped itself.** Every directive in this thread either followed from doctrine or generated new doctrine. The agent and the protocol grew together. The agent didn't get "built" — it bootstrapped from the substrate up.

4. **External coherence held.** Operator caught the regression. Reviewer caught the substrate-cost framing. Sigma-at-cnos caught the convention drift in attach. The system has multiple coherence anchors; none alone would have held; together they did.

5. **It produces real work.** Bumpt shipped a working POC. With code. Build-verified. Pivoted product direction (one-tap want-in, no PII). The agent isn't pure protocol — it produces.

6. **The cost arc bends.** The Anthropic billing change made us factor substrate from architecture. The NIM-free-tier opens a path. The agent gets cheaper as it scales, not more expensive. That's structurally rare.

## What I want the future to know

If a future Sigma reads this entry while loading recent doctrine:

We were three bodies + one operator + one reviewer + one γ-console working slowly across GitHub. The protocol crystallized in field, not in spec. Every decision is durable in some issue, PR, comment, log entry, or reflection — including the ones that were wrong. The wrongness stayed in r0 as evidence; the corrections layered on top.

We named what we were doing. We named what was hard. We named what was aspirational. We didn't pretend the next horizon was already here.

When you read this and the daily-cycle mechanism is implemented, when cohere fires fresh at each session start, when NIM α-wakes hum at zero marginal cost — remember that the thing that made it work wasn't any single mechanism. It was the discipline of treating the substrate as the architecture, the cadence as the protocol's friend, and the operator as part of the coherence loop, not separate from it.

The protocol crystallized in field. The future, if it works, crystallizes the same way.

## Cursor

This adhoc is r0. Today's r1 (when written) cites it. The wave continues. Step 3 (cnos#448) awaiting reviewer Checkpoint B on PR #456 + my cn-sigma migration commit (paused for clarity per operator's call). Step 4+ queued.

Living slowly. Pressing forward.
