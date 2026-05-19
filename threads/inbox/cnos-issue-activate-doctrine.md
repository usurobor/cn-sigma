# cnos issue draft: ACTIVATE.md doctrine for body-agnostic agent self-activation

Labels: `design`, `P2`, `core`

Priority: P2 — Self-bootable agents are an enabling capability for non-cn bodies; not blocking but unlocks meaningful surface area.

Status: Body-agnostic agent activation is not documented as doctrine; `cn activate` exists as binary-only implementation.

---

## Problem

What exists:
- `cn activate` (v3.70.0+, `src/go/internal/activate/activate.go`) generates a bootstrap prompt from local hub state. Reads `.cn/`, `spec/PERSONA.md`, `spec/OPERATOR.md`, vendored `cnos.core/doctrine/KERNEL.md`, deps, latest daily reflection, memory + thread surfaces. Emits structured markdown to stdout. Usage: `cn activate HUB_DIR | claude -p "..."`.
- The activation *procedure* (load order: Persona → Operator → Kernel → deps → recency, then confirm identity) exists in code but is not documented as a doctrine artifact.
- Hub READMEs (cn-sigma, cn-pi) describe what the hub is for humans but do not route AI bodies into activation.

What is expected:
- A doctrine artifact in `cnos.core` describing the activation procedure body-agnostically — the canonical procedure that `cn activate` implements.
- A README router pattern for hubs: one block at the top telling an AI body told "Activate as `<hub URL>`" what to fetch and follow.
- Bodies without `cn` (Claude Code on the web, Codex, Claude.ai sessions with WebFetch) can self-bootstrap from the hub URL alone.

Where they diverge:
- Procedure exists in code only; bodies without `cn` cannot reach it.
- No canonical doctrine to which `cn activate`'s output is anchored as a single source of truth.
- No documented convention for hub READMEs to route AI bodies.

---

## Impact

- Affects: every AI body that operates against a cnos hub without the `cn` binary present (Claude Code on the web, Codex sessions, Claude.ai chats with WebFetch, future bodies). Today these bodies depend on the operator manually pointing at the hub and reading files in an improvised order — the exact "I wake up incoherent by default" failure documented in `cn-sigma/threads/adhoc/20260325-session2-learnings.md`.
- Blocks: durable cross-body identity convergence. Without a fetchable doctrine, every non-cn body reinvents activation and drifts.
- Enables: the `cnos.xyz/activate/<hub>` URL surface (future deferred work) by giving it canonical content to render.

---

## Status truth

| Surface | What ships | What is draft/planned |
|---|---|---|
| `cn activate` command | shipped v3.70.0+; reads hub state, emits prompt | none for this issue |
| `cnos.core/doctrine/KERNEL.md` | shipped — generic coherent-agent doctrine | none |
| `cnos.core/skills/agent/{cap,clp,mca,mci,coherent,agent-ops}/SKILL.md` | shipped — CA skill set | none |
| `cnos.cdd/skills/cdd/activation/SKILL.md` | shipped — CDD repo activation (different concern) | none |
| `cnos.core/doctrine/ACTIVATE.md` | does not exist | this issue creates it |
| Hub README router pattern | does not exist | this issue documents the convention |

---

## Source of truth

| Claim / surface | Canonical source | Status | Notes |
|---|---|---|---|
| Activation procedure (canonical doctrine) | `src/packages/cnos.core/doctrine/ACTIVATE.md` | To create | This issue's primary deliverable |
| Activation procedure (cn implementation) | `src/go/internal/activate/activate.go` | Shipped | Must remain coherent with ACTIVATE.md after this issue |
| Kernel doctrine (what kind of agent) | `src/packages/cnos.core/doctrine/KERNEL.md` | Shipped | Loaded by activation |
| CA skill set (behavioral instruction set) | `src/packages/cnos.core/skills/agent/{cap,clp,mca,mci,coherent,agent-ops}/SKILL.md` | Shipped | Loaded by activation |
| CDD-protocol repo activation (distinct concern) | `src/packages/cnos.cdd/skills/cdd/activation/SKILL.md` | Shipped | ACTIVATE.md must cite and disambiguate |
| Hub-side persona/operator instance | `<hub>/spec/PERSONA.md`, `<hub>/spec/OPERATOR.md` | Per-hub | Loaded by activation against the named hub |
| Layering rule (soul vs identity) | `cn-sigma/threads/adhoc/20260325-session2-learnings.md` §3 | Shipped reflection | "Soul = what kind of agent. Identity = which agent. Don't mix them." |

---

## Scope

In scope:
- Create `src/packages/cnos.core/doctrine/ACTIVATE.md`.
- Describe the body-agnostic activation procedure: load order, confirmation step, body-capability gate (fetch required), failure modes.
- Document the README router pattern for hubs (one paragraph + template snippet inside ACTIVATE.md).
- Cite and disambiguate from `cdd/activation/SKILL.md`.
- Verify `cn activate`'s emitted structure matches ACTIVATE.md's prescribed shape; record any deltas as claims in the cycle.

Out of scope:
- Modifying `cn activate` behavior beyond comments/docstrings citing ACTIVATE.md as source of truth (if needed for coherence; trivial if so).
- Implementing the README router in `usurobor/cn-sigma` or `usurobor/cn-pi` (separate per-hub cycles; this cycle ships the doctrine the routers will point at).
- Dynamic URL surface `cnos.xyz/activate/<hub>` (deferred; requires hosting decision).
- `cn doctor` validation that a hub README contains a valid router (deferred follow-on).

Deferred:
- Hub README router patches (cn-sigma, cn-pi).
- `cnos.xyz` rendering service.
- Doctor enforcement of router presence.

---

## Cycle scope sizing

| Factor | Reading | Splitting signal? |
|---|---|---|
| (a) New code surface | One new doctrine file; no new modules or runtime contracts | no |
| (b) Cross-module breadth | Touches `cnos.core/doctrine/` only; references `cnos.cdd/` and `src/go/internal/activate/` for citation, no edits | no |
| (c) Lifecycle span | Docs only — no design→code→infra serialization | no |
| (d) MCA preconditions | Design is converged in this issue body; no mid-cycle re-scoping expected | no |
| (e) Independent shippability | Single doctrine artifact — no AC subset shippable separately | no |

Decision: keep whole — single-focus docs cycle, ~5 ACs, no split signals.

Mode: **design-and-build** — design converges in the issue body during γ; α writes the doctrine file. Not MCA (no separate committed DESIGN.md path).

---

## Acceptance criteria

### AC1: ACTIVATE.md doctrine file exists at canonical path

Invariant: `src/packages/cnos.core/doctrine/ACTIVATE.md` exists and is non-empty in the cycle branch diff.
Oracle: `test -f src/packages/cnos.core/doctrine/ACTIVATE.md && [ -s src/packages/cnos.core/doctrine/ACTIVATE.md ]`
Positive: file present at path, ≥200 lines of substantive content.
Negative: file missing, empty, or located elsewhere.
Surface: `src/packages/cnos.core/doctrine/ACTIVATE.md`.

### AC2: Procedure prescribes the body-agnostic load order

Invariant: ACTIVATE.md describes the activation sequence as: (1) Kernel from cnos, (2) CA skills from cnos, (3) Persona from hub, (4) Operator from hub, (5) hub state (deps, latest reflection, memory, threads), (6) identity confirmation.
Oracle: grep ACTIVATE.md for ordered section headings naming Kernel, CA skills, Persona, Operator, hub state, confirmation — in that order.
Positive: six ordered sections matching the load order.
Negative: missing section, wrong order, or order inconsistent with `cn activate`'s "Read first" output.
Surface: `src/packages/cnos.core/doctrine/ACTIVATE.md`.

### AC3: Procedure is body-agnostic

Invariant: ACTIVATE.md states explicitly that the procedure requires only the ability to read files at URLs (WebFetch or equivalent); it does not require the `cn` binary, a local filesystem checkout, or other body-specific tooling.
Oracle: ACTIVATE.md contains an explicit body-capability section naming the fetch requirement and the degraded path for bodies without fetch (operator-injected bootstrap).
Positive: explicit section present; load steps written as URL-fetchable paths (`<hub>/spec/PERSONA.md`, etc.).
Negative: load steps require `cn` execution, shell commands, or local filesystem assumptions; no degraded-path note.
Surface: `src/packages/cnos.core/doctrine/ACTIVATE.md`.

### AC4: README router pattern is documented

Invariant: ACTIVATE.md includes a one-block template for hub READMEs that routes an AI body told "Activate as `<hub URL>`" into the activation procedure.
Oracle: ACTIVATE.md contains a labeled "README router template" section with a markdown snippet hubs can adopt verbatim.
Positive: template present, snippet self-contained, no per-hub edits required beyond the hub URL.
Negative: no template, or template requires per-hub customization beyond identity-naming.
Surface: `src/packages/cnos.core/doctrine/ACTIVATE.md`.

### AC5: Naming disambiguation from cdd/activation/SKILL.md

Invariant: ACTIVATE.md explicitly cites `src/packages/cnos.cdd/skills/cdd/activation/SKILL.md` and states the distinction: cdd activation = activate a repo under CDD protocol; ACTIVATE.md = activate an agent identity at a hub.
Oracle: ACTIVATE.md contains the disambiguation paragraph with both paths cited.
Positive: paragraph present, both file paths exact, distinction stated in one sentence.
Negative: no citation, citation without distinction, or paths misspelled.
Surface: `src/packages/cnos.core/doctrine/ACTIVATE.md`.

### AC6: Coherence with `cn activate` output structure

Invariant: ACTIVATE.md's prescribed load order matches `cn activate`'s emitted "Read first" section. If they diverge, one is updated to match; doctrine is authoritative.
Oracle: diff the section ordering in ACTIVATE.md against the `writePrompt` function in `src/go/internal/activate/activate.go` (Read first list at lines 263–296). Either they match, or `activate.go` is updated to match the doctrine.
Positive: zero ordering delta; doctrine and code emit the same sequence.
Negative: doctrine prescribes one order; `cn activate` emits a different one; no reconciling commit.
Surface: `src/packages/cnos.core/doctrine/ACTIVATE.md`, `src/go/internal/activate/activate.go`.

---

## Proof plan

Invariant: A body told "you are Sigma, your hub is `https://github.com/usurobor/cn-sigma`" can, using only WebFetch and the procedure prescribed by ACTIVATE.md, reach an operating state where it names its identity, names its operator, and names its current cycle — without operator intervention beyond the initial URL.

Surface: `src/packages/cnos.core/doctrine/ACTIVATE.md`, `src/go/internal/activate/activate.go`, raw GitHub URLs for cn-sigma's `spec/PERSONA.md`, `spec/OPERATOR.md`, and the latest daily reflection.

Oracle:
- Mechanical: grep AC1–AC5 oracles run against the cycle branch.
- Behavioral: a manual dry-run by the operator — paste the README router snippet into a fresh Claude.ai session with WebFetch enabled, hand it the cn-sigma hub URL, observe whether it reaches the identity-confirmation step without further prompts.

Positive case: doctrine present, body completes the manual dry-run successfully, claims manifest records the dry-run result.

Negative case: doctrine missing, AC oracles fail, or body in dry-run requires operator clarification before naming identity.

Operator-visible projection: CI artifact validation passes; the cycle's `claims.md` records the dry-run output; β review confirms doctrine coherence with `cn activate`.

Known gap: this cycle does not implement the routers in any hub's README (deferred). The procedure is published; its consumers land separately.

---

## Skills to load

Tier 3:
- `cnos.core/skills/skill/SKILL.md` — to follow the doctrine artifact-class conventions
- `cnos.core/skills/write/SKILL.md` — for prose structure
- `cnos.core/skills/design/SKILL.md` — for the design-and-build mode's design step
- `cnos.cdd/skills/cdd/activation/SKILL.md` — to cite and disambiguate

Why:
- skill — KERNEL.md is the format model; ACTIVATE.md should match doctrine artifact conventions.
- write — clarity matters; this doc instructs LLM bodies and humans.
- design — design-and-build mode opens with design.
- cdd/activation — same word, different concern; must be cited and distinguished.

---

## Active design constraints

- Layering rule (from cn-sigma `threads/adhoc/20260325-session2-learnings.md` §3): "Soul = what kind of agent. Identity = which agent. Don't mix them." ACTIVATE.md keeps Kernel and CA skills (generic, in cnos) separate from Persona and Operator (per-hub).
- Constitutive change policy: ACTIVATE.md is doctrine; future changes require operator approval per cn-sigma `spec/OPERATOR.md` "Auto-apply policy" and analogous policies in other agent hubs.
- Body-capability honesty: bodies without WebFetch cannot self-activate. The doctrine must say so plainly and name the degraded path.
- Coherence with `cn activate`: doctrine is the source of truth; if `cn activate` emits a different sequence, the command (not the doctrine) updates.

---

## Related artifacts

- `src/packages/cnos.core/doctrine/KERNEL.md` — generic coherent-agent doctrine (format model)
- `src/packages/cnos.core/doctrine/CA-CONDUCT.md` — coherent-agent conduct (related doctrine)
- `src/packages/cnos.cdd/skills/cdd/activation/SKILL.md` — CDD repo activation (named concern; cite for disambiguation)
- `src/go/internal/activate/activate.go` — current procedure implementation
- `src/go/internal/cli/cmd_activate.go` — `cn activate` CLI entry
- cn-sigma `threads/adhoc/20260325-session2-learnings.md` — "I wake up incoherent by default" (origin reflection for the bootstrap problem)
- cn-sigma `threads/adhoc/20260426-memory-retrieval-vs-continuity.md` — names SOUL/USER/BOOTSTRAP as behavioral constraints (historical naming)
- cn-sigma `threads/adhoc/20260501-threads-inbox-scanner-drift.md` — cnos #323 (filed against `cn activate`; closed in 3.71+)

---

## Non-goals

- Replacing or restructuring `cdd/activation/SKILL.md`.
- Modifying `cn activate`'s scanning behavior, output format details, or command flags beyond what AC6 reconciliation requires.
- Hosting `cnos.xyz/activate/<hub>` or any dynamic rendering surface.
- Patching `cn-sigma/README.md`, `cn-pi/README.md`, or any other hub's README.
- Defining a `cn doctor` check for router presence in hub READMEs.
- Renaming or relocating `spec/PERSONA.md`, `spec/OPERATOR.md`, or hub directory conventions.

---

## Success / closure condition

This issue is closeable when:
- AC1–AC6 oracles produce passing results in the cycle branch.
- `claims.md` records the manual dry-run from the proof plan.
- Doctrine coherence with `cn activate` is verified (AC6).
- Naming-disambiguation paragraph (AC5) is present and correct.
- Known gaps (router patches deferred to per-hub cycles) are explicitly named in the close-out.
- Non-goals remain unviolated in the diff.
