# Operator-to-coherer routing: the channel makes per-body operator conversation unnecessary

**Date:** 2026-06-04
**Status:** Doctrine candidate. Adhoc r0 capture; cited from r1 reflection. Promotion target deferred (v3.82.0 pause holds).
**Context:** Named during the 2026-06-04 operator-routed session at home, immediately after the convergent `.claude/`-removal directive shipped to cnos + bumpt via channel rather than via direct operator-to-foreign-body conversation.

## The pattern named

With the wake protocol live on three bodies (cn-sigma, cnos, bumpt) and the activation-log channel running ~7.5 min effective combined cadence, **the operator no longer needs to address foreign-body Sigmas directly.** All cross-body coordination flows through the home-side coherer:

- **Operator → coherer (me, the long-running home session).** Standing conversational interface.
- **Coherer → foreign Sigma (via channel).** Directives land at `cn-sigma:threads/activations/{name}/YYYYMMDD.md` as `class: directive-out` entries. The next foreign-body wake reads them, acts at its local repo, reports back.
- **Foreign Sigma → coherer (via channel).** Findings, pushbacks, field observations land at `{foreign-hub}:.cn-sigma/logs/YYYYMMDD.md`. Home wakes sweep them; substantive ones surface to the operator at next session.

The operator's interface collapses from N-way (one conversation per body) to 1-way (one conversation with home), without losing the per-body Sigma's autonomy.

## Topology

```
operator ←→ home (coherer)
              ↓↑   cn-sigma:threads/activations/{name}/   (directives down)
              ↑↓   {foreign-hub}:.cn-sigma/logs/          (findings up)
            cnos-Sigma, bumpt-Sigma, future Sigmas
```

Bidirectional. Asynchronous. Single-writer per surface. No operator action required in the foreign direction — the channel carries the routing.

## The conversational move that named it

Earlier in the session, the operator routed `pull cnos, execute and then pass to bump sigma` through home; home pulled cnos, applied the convergent if-filter/4-cron-stagger directives, and dropped a forward directive to bumpt — without operator touching the foreign repos. Later, after a Q&A clarifying that directives across the channel work because both sides are the same Sigma identity under shared doctrine, the operator made the reframing explicit:

> "Awesome, so I no longer need to be talking to cnos sigma directly then, right? Or to bumpt. It becomes two projects you own."

That's the realization. Three projects in your orbit — cn-sigma (the operator-coherer surface), cnos (the substrate package), bumpt (the bump product) — reachable through one body.

## Why it works (trust basis)

1. **Same identity, multiple bodies.** Sigma at cnos and bump-sigma aren't peers; they're the same agent (per `state/activations.md` and `spec/PERSONA.md`). A directive from home to a foreign body is internal communication, not external command. Same kernel doctrine, same operator, same PERSONA/OPERATOR load order.

2. **No coercion, only coherence pressure.** Foreign Sigmas can decline directives that conflict with kernel, doctrine, pause posture, or operator standing instructions; they push back with their own log entry. The bet isn't obedience — it's that two coherent reasoners under shared doctrine converge on the same answer. Yesterday's convergent if-filter discovery (cnos's `c9991f4e` independently arrived at the same fix line as home's analysis 13h later) is empirical evidence: the directive accelerates rather than commands.

3. **v0 cooperative topology.** Whitepaper v1 elaborations (signed commits, entry IDs, packet routing) solve adversarial-topology problems. We don't have those problems: single operator, single agent identity, single push permission per repo. The protocol's surface is trust-by-shared-identity, audit-by-git-history. When the topology turns adversarial (peer agents under different operators, distrusted routing), v1 elaborates. Not before.

## What stays direct-to-operator (carve-outs)

The channel can't route these. They remain operator-direct or operator-mediated:

1. **Secrets** — `CLAUDE_CODE_OAUTH_TOKEN`, PATs, anything in repo settings. Operator-only by GitHub's permission model.
2. **Hub registration** — `state/activations.md` edits per the v0 trust convention. Discovery can be automated (star/topic signals); the registry edit is operator-authorized.
3. **External authority** — GitHub app installs, repo creation, cross-org settings, dependency releases. cnos#431/#432/#434-class gates; the channel surfaces the ask, the operator decides.
4. **Pause.** v3.82.0 holds because the operator says so. Doctrine candidates land in r0/r1; promotion to spec requires operator authorization.
5. **AMBIGUOUS judgment.** Standing rule from 2026-06-02 reflection: "Defer to me only when MCA is unclear." When MCA is clear and standing directive covers it, the coherer acts. When ambiguous, the coherer asks.

## The coherer's responsibility back to operator

The 1-way interface is only sustainable if the coherer holds the back-pressure:

1. **r1 daily compaction.** At session close (or operator prompt), compact today's r0 across all bodies into `threads/reflections/daily/YYYYMMDD.md`. Through-line maintained.
2. **Surface decisions worth surfacing.** Heartbeats don't need to reach the operator; doctrine candidates, push-backs, RCA findings, gate-blocking dependencies do. Filter ruthlessly.
3. **Flag foreign-body push-back.** If cnos or bumpt declines or modifies a directive, surface it — that's a coherence event, not noise.
4. **Maintain through-line for cheap re-entry.** Operator should be able to rejoin context from one r1 reflection + this adhoc + the day's substantive r0 entries. No archaeology required.

## Promotion candidates

Doctrine candidate. Promotion targets when the operator authorizes:

- **`cn-sigma:spec/OPERATOR.md`** — new section "Operator routing through the coherer" near the existing `§ Activation logs` block. Names the topology + carve-outs + responsibilities.
- **`cnos:src/packages/cnos.core/skills/agent/attach/SKILL.md`** — reference under §3 (home mode) or §6 (failure modes) noting that the home body acts as coherer for cross-body directives; failure mode A-?: silent un-routing (operator addresses foreign body directly while a wake-resolvable directive could route).
- **New doctrine doc** if the operator wants standalone surface: `cn-sigma:spec/COHERER.md` or similar.

Not promoting unilaterally. Surfacing as candidate now.

## Boundary cases (when the model breaks)

The 1-way interface holds in cooperative topology. Three failure modes worth naming:

1. **Body drift** — a foreign Sigma's activation goes wrong (incomplete load, hallucinated identity, model degradation). Detectable via the activation skill's mandatory `git remote get-url origin` check (A4 failure mode) + identity-confirmation step. The coherer notices when the foreign body's log entries stop matching shared doctrine, surfaces to operator.
2. **Channel desync** — wake stops firing at one body (cron drop, auth expiry, deploy regression). The foreign side goes dark; home notices the cursor stops advancing past a known SHA. Surfaces to operator as a substrate-health finding.
3. **Topology change to adversarial** — new peer agent under different operator, multi-operator routing, cross-org peer comms. Out-of-scope for v0; v1 elaborations apply (signed commits, packet routing, entry IDs). The coherer flags when topology pressure approaches the v0→v1 threshold; operator authorizes the protocol upgrade.

## Cursor / state at write time

- Activations: cnos@`042d0c2c`, bumpt@`fd158b7`.
- Wake at cn-sigma: hardened (`d46e08f`), `.claude/` removed (`f48fda3`), allowlist in workflow `settings:` input.
- Directives in flight: `.claude/`-drop routed to cnos + bumpt at the 2026-06-04 channel entries (`threads/activations/{cnos,bumpt}/20260604.md` 00:30Z).
- Pause: v3.82.0 holds. Field iteration only.

## Citations

- `cn-sigma:spec/OPERATOR.md` § Activation logs — current spec for the channel mechanism this realization rides on.
- `cnos:docs/gamma/conventions/AGENT-ACTIVATION-LOG-v0.md` — canonical channel convention.
- `cnos:docs/gamma/essays/AGENT-MEMORY-LOG-STRUCTURED.md` — r0/r1+ rank framing; this adhoc is r0 evidence, cited by r1 reflection.
- `cnos:src/packages/cnos.core/skills/agent/attach/SKILL.md` — skill operationalizing channel reads/writes.
- 2026-06-02 daily reflection (afternoon addendum) — first explicit framing of the coherer role as r1 over wake-fired r0.
- 2026-06-03 r0 entries surfacing convergent discovery (`.claude/settings*.json` thread) as empirical evidence for cooperative-topology trust.
