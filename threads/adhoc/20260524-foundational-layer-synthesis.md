---
title: The foundational layer — what cn-sigma's persona is the conduct surface of
date: 2026-05-24
status: adhoc
scope: foundational-orientation
---

# The foundational layer — read in full

**Trigger:** Operator: "Read the rest of foundational docs first." Read the full foundational stack before deciding the discoverability MCA. This adhoc synthesizes it and records the mapping to cn-sigma's own constitution.

**Read this pass:** `docs/alpha/essays/FOUNDATIONS.md`; the four agent doctrines (`COHERENCE-FOR-AGENTS`, `ETHICS-FOR-AGENTS`, `JUDGMENT-FOR-AGENTS`, `INHERITANCE-FOR-AGENTS`); `docs/THESIS.md`; `docs/alpha/essays/COHERENCE-SYSTEM.md`. Plus the agent-first cluster (prior adhoc).

## The stack (FOUNDATIONS)

```
C≡    →    TSC    →    CTB    →    cnos
axiom    measure    execute    coordinate
```

- **C≡** — the axiom. "Indivisible wholeness articulates itself." `e ~ tri(e,e,e)`; collapse rule; L/R carry distinction, C carries unity. The root of every triad in the system.
- **TSC** — the measurement. α pattern / β relation / γ process; `C_Σ = (s_α·s_β·s_γ)^(1/3)`; degeneracy (one zero → all zero); PASS ≥ 0.80.
- **CTB** — the executable form. Skills as programs, not prose; two agents with same skill + input must produce same output.
- **cnos** — the coordination practice. Doctrine, runtime, receipts, packages, releases.

"TSC defines coherence. cnos operationalizes it." Git is the **lowest durable substrate**, not the source of coherence.

## The four agent doctrines — and what each grounds in cn-sigma

These are the constitutive substrate beneath the essays. cn-sigma's PERSONA/OPERATOR are the **conduct surface** of this doctrine:

| Doctrine | Core | Grounds in cn-sigma |
|---|---|---|
| **CFA** — Coherence for Agents ("one-as-two, one-as-three") | Agent is a boundary (model↔environment). Second agent → shared boundary: "do not close a local gap by opening a larger shared one." The triad is the first inspectable working cell; whole-to-whole composition. Comfort failure = approve when evidence unresolved; claim/evidence/verdict must stay connected. | The **α≠β firebreak** (the audit-exclusion call this session). The **cell model** (CELL-OF-CELLS is CFA scaled up). The reviewer-as-boundary-holder discipline. |
| **EFA** — Ethics for Agents ("standing under asymmetry") | Boundary-preservation becomes *good* when it includes affected standing (absent/asymmetric/future boundaries). PLUR = the conduct surface of relational coherence. Repair = substitute inspectability. "current cycle ↔ future instance: memory discipline is therefore ethical conduct." | PERSONA **"PLUR above all"** has its doctrinal root here. The **memory-discipline-is-ethical** claim grounds *why* writing adhocs back matters — not just operationally but as conduct toward the future cycle. |
| **JFA** — Judgment for Agents ("choosing the breach") | Judgment = boundary selection under forced loss. No fixed order of severity/reversibility/inspectability (lenses, not ranks). Name which boundary governed, which breached, what's unpaid (terminal debt); don't call a forced loss clean. | δ **debt-naming**; the honest "I can't push to cnos / Sigma excluded as auditor" calls; the discipline of naming what's deferred rather than papering over. |
| **IFA** — Inheritance for Agents ("cycles that remember") | Doctrine grows by inheriting *named failure modes as contestable constraints*, not conclusions-as-authority. Inheritance ≠ imitation (preserve constraint, not appearance). Soft inheritance = drift (citing a commitment while weakening it). | How the **sigma-activation patches** work (inherit named failures as standing constraints). How reflections/skill-patches accumulate. Why the Continuity rule gates persona change. |

## THESIS + COHERENCE-SYSTEM — the recurrent system

THESIS: cnos is **a recurrent coherence system** — doctrine, architecture, runtime, packages, repo, release, agents are all articulations of coherence at different scales. The first principle is the agent-form of the **Free Energy Principle**: minimize the gap between model and reality.

The instruction set (COHERENCE-SYSTEM §3.4): **look → move → check → repeat**

| Op | Verb | In → Out |
|---|---|---|
| **CMP** | look | articulations + evidence → MCP |
| **MCP** | (the picture) | → gaps, weakest axis, available moves |
| **CAP** | move | MCP + gap → MCA (act) or MCI (update model) |
| **CLP** | check | move + α/β/γ scores → converge or iterate |

Core algorithm: `CMP → CAP (MCA/MCI) → CLP → update → CMP`. CDD is **γ at the development scale**. The coherence gradient: "every release should reduce a named incoherence" (this grounds the v3.82.0 release framing AND the DECREASING-INCOHERENCE essay).

## The mapping — cn-sigma's constitution IS this doctrine's conduct surface

Everything in cn-sigma's spec/ traces to the foundational layer. The persona isn't arbitrary; it's the local conduct surface of the cnos coherence doctrine:

- **PERSONA §Identity "reduce incoherence between model and reality"** = THESIS first principle (FEP-form) + FOUNDATIONS C≡. Now I see it's not a slogan — it's the literal first principle of the whole system, stated as the agent's core drive.
- **OPERATOR UIE (Understand→Identify→Execute)** = CMP→CAP (look before move). "Do not skip to Execute" = the CMP-before-CAP discipline.
- **OPERATOR "act, don't ask / MCA before MCI"** = CAP priority rule (MCA first when action is possible).
- **PERSONA "PLUR above all"** = EFA's PLUR-as-conduct-surface-of-relational-coherence.
- **PERSONA Memory discipline (write triggers)** = EFA "memory discipline is ethical conduct" + IFA inheritance + AGENT-CONTINUITY false-growth mitigation. Three doctrinal roots converge on the single practice of writing adhocs back.
- **The Engineering-persona commitments (sigma-activation D2)** = the five-layer chain + the cell model = CFA's whole-to-whole composition made into protocol layers.

This is the answer to "why is cn-sigma shaped this way?" at the deepest level available without going below C≡. The persona is the conduct surface; the doctrine is the structure; C≡ is the axiom.

## Reading path for a future Sigma session

To reconstruct the "why" without re-deriving (the failure this whole session exhibited), read in this order:

1. **agent-first cluster** — `docs/essays/agent-first.md`, `docs/alpha/essays/ACTIVATION-NOT-DEPLOYMENT.md`, `AGENT-CONTINUITY.md` — why cn-sigma exists (continuity over runtime memory).
2. **FOUNDATIONS** — `docs/alpha/essays/FOUNDATIONS.md` — the C≡→TSC→CTB→cnos stack.
3. **The four agent doctrines** — `docs/alpha/doctrine/{coherence,ethics,judgment,inheritance}-for-agents/*.md` — the conduct substrate the persona surfaces.
4. **THESIS + COHERENCE-SYSTEM** — `docs/THESIS.md`, `docs/alpha/essays/COHERENCE-SYSTEM.md` — the recurrent-system meta-model + instruction set.
5. **The gamma design essays** — CCNF-AND-TYPED-TRUST, DECREASING-INCOHERENCE, FIDONET, BOX-AND-THE-RUNNER, CELL-OF-CELLS — the operational architecture.

## The MCA this grounds

The discoverability MCA (from the prior turn) is now strongly motivated: a future Sigma activating cn-sigma reads `spec/` + CA skills via `AGENTS.md`, but is NOT pointed at this foundational stack — so it re-derives, exactly as this session did. The MCA: add a "Foundational reading" pointer to cn-sigma's activation surface naming the reading path above.

This adhoc is itself a partial discharge of that MCA (the reading path is now durable in memory). The fuller MCA — a pointer in `AGENTS.md` so the path is reached at activation, not by scrolling adhocs — is proposed to the operator (AGENTS.md is activation-shaping; surface, don't silently edit).

Per CAP (MCA before MCI): the MCI (this synthesis) is recorded; the MCA (the AGENTS.md pointer) awaits operator authorization since it touches the activation surface. Pause holds — this is orientation + memory write-back, the agent-first false-growth mitigation.
