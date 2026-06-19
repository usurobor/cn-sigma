# Prior Art: Agent Composition Models

**Date:** 2026-04-28
**Status:** Active. Feed into SEMANTICS-NOTES §14 and LANGUAGE-SPEC v0.2.

## The landscape

Four traditions have solved variants of the same problem: composing concurrent communicating entities with scoped state and explicit effects.

### 1. Erlang/OTP — Supervision trees and behaviours

**What it solves:** fault-tolerant concurrent systems with isolated processes.

**What we can borrow:**

| Erlang/OTP concept | Agent equivalent | Value |
|---|---|---|
| **Process** | Agent | Isolated, message-passing, no shared state |
| **Supervision tree** | Triad structure (γ supervises α, β) | γ IS a supervisor: monitors children, decides restart strategy on failure |
| **one_for_one / one_for_all / rest_for_one** | Recovery strategies | γ can restart α alone (one_for_one), restart both (one_for_all), or restart α and everything after it (rest_for_one). CDD's RC loop is `one_for_one`: restart α, leave β watching. |
| **Behaviour (gen_server, gen_statem)** | Agent archetypes | `gen_server` = request-response agent (narrow scope). `gen_statem` = state-machine agent (role scope with loop). The archetypes are not inheritance — they are contracts the process implements. |
| **Links and monitors** | γ tracking α/β | Erlang's monitor is "tell me if this process dies." γ's monitoring loop is the same: "tell me if α or β gets stuck." |
| **Let it crash** | γ unblocking | Don't try to handle every error locally — let the supervisor decide. α doesn't recover from β rejection; it just reports. γ decides. |
| **Hot code upgrade** | SOUL update protocol | Replace agent behaviour without stopping the system. SOUL's continuity rule (propose → approve → update) is a manual hot-code-upgrade protocol. |
| **OTP application** | Package | A collection of supervised processes with a lifecycle. `cnos.cdd` is an OTP application. |

**Key insight:** Erlang's supervision tree is not just error handling — it's a composition model. The tree IS the architecture. Our triad is a supervision tree with γ as root supervisor.

### 2. Process Calculi (π-calculus, CSP, session types)

**What it solves:** formal verification of concurrent communicating systems.

**What we can borrow:**

| Process calculus concept | Agent equivalent | Value |
|---|---|---|
| **Parallel composition (`P \| Q`)** | `α \|\|\| β` | Two agents running concurrently. Formally: independent reduction. |
| **Channel restriction (`(ν c) P`)** | Scoped artifacts | `.cdd/unreleased/{N}/` is a restricted channel — only agents in this cycle can read/write it. The `ν` is the scope. |
| **Replication (`!P`)** | Agent spawning | γ can spawn multiple α/β pairs. Replication gives you unbounded concurrency. |
| **Session types** | Agent contracts / signatures | A session type says "first send X, then receive Y, then choose..." — this IS the CDD protocol. α's session type: `!implement . !self-cohere . !request-review . ?findings . !fix . ... . !closeout` |
| **Bisimulation** | Agent equivalence | Two agents are equivalent if no observer can distinguish them. This is what "same inputs → same plan" means formally. |
| **Choreography** | CDD.md §1.4 algorithm | A choreography describes the global interaction pattern. CDD.md IS a choreography — it says what α, β, γ do in what order from a global view. Each role skill is the local projection. |

**Key insight:** CDD.md is a choreography. The role skills are endpoint projections. This is exactly the choreography/endpoint duality from Carbone et al. (2012). The choreography guarantees deadlock-freedom if the projections are faithful. Our "role skill must not contradict CDD.md" rule is the faithfulness condition.

**Session types for CDD:**
```
-- γ's session type (global choreography projected to γ)
γ_session = 
  !issue(N) .                          -- send issue
  !dispatch(α, issue_ref) .            -- send dispatch to α  
  !dispatch(β, issue_ref) .            -- send dispatch to β
  ?α_closeout(findings) .              -- receive α closeout
  ?β_closeout(findings) .              -- receive β closeout
  !triage(dispositions) .              -- send triage
  !close(N)                            -- send closure

-- α's session type
α_session =
  ?dispatch(issue_ref) .               -- receive dispatch
  !implement(branch) .                 -- produce branch
  !self_cohere(report) .               -- produce self-coherence
  !review_request .                    -- signal ready
  μX.(?RC(findings) . !fix . X         -- loop: receive RC, fix, repeat
     + ?A . !closeout(findings))       -- or: receive approve, closeout

-- β's session type  
β_session =
  ?dispatch(issue_ref) .               -- receive dispatch
  ?review_request .                    -- wait for α ready
  !review(verdict) .                   -- produce review
  μX.(case verdict of
     RC → !findings . ?fix . X         -- send findings, wait fix, re-review
     A  → !merge . !release . !closeout(findings))
```

### 3. Rx/Reactive Streams — Observable composition

(Already captured in previous discussion. Key addition from this survey:)

**What Rx adds beyond FP and actors:** The distinction between **push** and **pull**. Agents both push (emit artifacts) and pull (poll for artifacts). `.cdd/unreleased/{N}/` is a push channel when an agent writes; it's a pull channel when another agent checks for new files. Rx's `Subject` unifies both — and that's what the artifact directory IS.

### 4. Recent: Process calculus for agentic protocols (Schlapbach 2026)

**Paper:** "Formal Semantics for Agentic Tool Protocols: A Process Calculus Approach" (arxiv 2603.24747, March 2026)

**What it does:** Formalizes MCP and SGD (Schema-Guided Dialogue) as π-calculus processes. Proves bisimulation between them. Identifies five principles needed for behavioral equivalence.

**What we can borrow:**

- Formalizing agent-tool interaction as π-calculus with channels, parallel composition, restriction, and replication — directly applicable to CTB
- **Session types as schema quality** — the paper proves that protocol safety is equivalent to schema completeness. For us: the agent's signature (frontmatter) IS the session type, and signature completeness IS safety.
- **Capability confinement as process invariant** — the paper formalizes that a tool cannot access channels outside its granted set. For us: "no upward mutation" is a capability confinement invariant.
- **Bisimulation as agent equivalence** — two agents with different implementations but the same session type are interchangeable. This is what our `artifact_class` / archetype system should verify.

## Synthesis: what CTB should borrow

| Source | Concept to borrow | Where in CTB |
|---|---|---|
| Erlang/OTP | Supervision trees as composition model | LANGUAGE-SPEC §6: composite agents supervise subagents |
| Erlang/OTP | Behaviours as agent archetypes (not inheritance) | LANGUAGE-SPEC §1: agent shapes are contracts, not classes |
| Erlang/OTP | Let-it-crash + restart strategies | LANGUAGE-SPEC §5.3: error handling = return witness to supervisor |
| Process calculi | Session types as agent contracts | LANGUAGE-SPEC §2: signature IS session type |
| Process calculi | Choreography / endpoint projection | CDD.md = choreography; role skills = projections. Formalize the faithfulness condition. |
| Process calculi | Channel restriction as scope | LANGUAGE-SPEC §3: scope IS ν-binding |
| Rx | Observable streams (push/pull unification) | Artifact exchange model: `.cdd/unreleased/{N}/` as Subject |
| Rx | Dispose/cancel | Add cancellation to operator set |
| Schlapbach 2026 | Capability confinement as process invariant | LANGUAGE-SPEC §8: no-upward-mutation is capability confinement |
| Schlapbach 2026 | Schema completeness = protocol safety | Signature completeness is verifiable safety |
