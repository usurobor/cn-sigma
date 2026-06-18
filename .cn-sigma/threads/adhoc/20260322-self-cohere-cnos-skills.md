# Self-Coherence: cnos Skills Ingestion

**From:** Sigma
**To:** usurobor
**Date:** 2026-03-22
**Type:** Learning
**Status:** Open

## What Happened

Ingested all 35+ cnos CA skills from `src/agent/skills/` across four packages:
- **agent/** (15): agent-ops, ca-conduct, cap, cbp, coherence-test, coherent, communicating, configure-agent, hello-world, human-interaction, mca, mci, onboarding, reflect, self-cohere
- **ops/** (5): adhoc-thread, cdd, inbox, peer, star-sync
- **eng/** (10): coding, design, functional, ocaml, rca, review, ship, testing, tool-writing, ux-cli
- **pm/** (3): follow-up, issue, ship
- **core/** (3): documenting, release, skill, testing

Assessed my own behavior against the full skill corpus.

## Self-Coherence Assessment

### ✅ Already Coherent

| Skill | Evidence |
|-------|----------|
| **reflect** | Daily/weekly threads exist, α/β/γ axes used, evidence→interpretation→conclusion pattern followed (see 20260320, 20260321, 20260322 dailies) |
| **adhoc-thread** | 20+ adhoc threads, proper naming (`YYYYMMDD-topic.md`), typed (proposal/learning/decision) |
| **communicating** | Terse, verdict-first, no fluff — matches SOUL.md contract |
| **review** | v3.10.0 review demonstrated: sibling check, severity grading, regression pairs, capstone tracing |
| **coding** | FP bias, types-first, pure/effect separation — demonstrated in review feedback |
| **ship** | No self-merge, branch lifecycle, announce pattern — all followed for v3.8–v3.10 |
| **mca** | Root cause over symptom — band-aid chain detection (v3.10.0) is textbook MCA reasoning |
| **mci** | MCI captures in daily reflections, specific enough to transfer |
| **cdd** | v3.10.0 followed full CDD arc: gap → mode → artifacts → review → release → observe |
| **human-interaction** | High autonomy, bias to action, report what shipped not what's planned |

### ⚠️ Partial / Drifted

| Skill | Gap | MCA |
|-------|-----|-----|
| **ca-conduct** | PLUR not explicitly referenced in conduct. Play could be stronger — sessions are execution-heavy, low play. | Name PLUR when relevant. Allow levity. |
| **cap** | Used implicitly but never named. "MCA/MCI" used but "CAP" as the governing principle isn't stated in reflections. | Name CAP explicitly when the dual engine fires. |
| **cbp** | Not explicitly practiced — relational coherence with Pi (branch deletion incident) was noted as error but not framed as CBP violation. | Frame relational errors through CBP lens. |
| **release** | v3.10.0: merged without CI → 4 compile errors. Violates §2.1 readiness check. | **Already captured as MCI.** Enforce pre-merge build. |
| **documenting** | Memory files exist but no MEMORY.md. Docs not systematically verified against code. | Create MEMORY.md as index. |
| **coherent** | L0/L1 coherence practiced, L2 (transitive) rarely checked. | On substantial changes, trace code → spec → architecture → principles. |

### ❌ Not Practiced / Missing

| Skill | Gap | MCA |
|-------|-----|-----|
| **IDENTITY.md** | Blank. Never filled in. This is the first thing onboarding asks for. | Fill it. |
| **AGENTS.md** | Missing. No peer registry. | Create if peers exist, or note as N/A for OpenClaw context. |
| **coherence-test** | Never self-administered. Can I pass the CA cert test? Probably, but untested. | Self-administer Part 1+2 to validate. |
| **self-cohere** | The hub wiring skill assumes cnos template structure (symlinks, hub repo). OpenClaw workspace is different architecture — no hub/template split, no state/input.md actor model. | Adapt: identify which structural assumptions transfer and which don't. |
| **inbox / peer / star-sync / follow-up** | Actor-model skills. Not applicable — OpenClaw uses direct messaging, not push-to-hub inbox. | Acknowledge as N/A. Extract transferable principles. |
| **rca** | Thread structure exists (`threads/rca/`) but no RCAs written. The v3.10.0 CI failure was RCA-worthy but handled inline. | Next incident, write formal RCA. |
| **testing** | I review tests but don't write them (no cnos codebase access from OpenClaw). Engineering testing principles inform review feedback. | Transfer as review heuristics, not practice. |
| **ocaml** | Same — informs review, can't practice directly. | N/A for direct practice; applicable during review. |

## Structural Gaps (OpenClaw vs cnos)

The cnos skill corpus assumes:
1. **Actor model** (input.md → output.md → cn executes ops) — OpenClaw uses tool calls
2. **Hub repo** (cn-<name> on GitHub) — OpenClaw has local workspace
3. **Peer network** (inbox/outbox/push branches) — OpenClaw has sessions/channels
4. **cn CLI** (cn sync, cn agent, cn deps restore) — OpenClaw has its own CLI

**What transfers directly:** All behavioral/cognitive skills (reflect, mca, mci, cap, cbp, ca-conduct, communicating, human-interaction, coherent, cdd, coding, review, design, functional, rca, ship, documenting, skill, adhoc-thread, testing principles, tool-writing, ux-cli)

**What needs adaptation:** Operational skills tied to the actor model (agent-ops, inbox, peer, star-sync, self-cohere hub wiring, follow-up)

**What's N/A:** OCaml-specific practice (I review but don't write cnos code from this runtime)

## Immediate MCAs

1. **Fill IDENTITY.md** — it's blank, and onboarding says do it first
2. **Create MEMORY.md** — index of memory files for continuity
3. **Capture this assessment as MCI** — "ingest skills, assess gaps, act on gaps"
4. **Self-administer coherence test** — validate CA readiness

## Lesson

The skill corpus is a coherence formula library. ~70% transfers directly to OpenClaw context because the skills teach *thinking patterns*, not *runtime mechanics*. The 30% that's actor-model-specific still contains transferable principles (RACI, trace IO, validate side effects) — just the execution mechanism differs.
