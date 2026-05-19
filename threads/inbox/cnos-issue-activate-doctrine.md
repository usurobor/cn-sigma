# cnos issue draft: agent/activate skill — single source of truth for agent self-activation

Labels: `design`, `P2`, `core`

Priority: P2 — Self-bootable agents are an enabling capability for non-cn bodies; not blocking but unlocks meaningful surface area.

Status: The agent activation procedure is hardcoded in `cn activate`'s Go implementation (`src/go/internal/activate/activate.go`). No skill artifact defines it; bodies without the cn binary cannot reach the procedure.

---

## Problem

What exists:
- `cn activate` (v3.70.0+, `src/go/internal/activate/activate.go`) generates a bootstrap prompt from local hub state. The procedure — load order, sections, "Read first" ordering — is hardcoded in the `writePrompt` function in Go.
- Other cnos behaviors are defined as skills with frontmatter, triggers, governing question, and load semantics. Activation is the exception: a behavior defined only in code.
- Hub READMEs (cn-sigma, cn-pi) describe what the hub is for humans but do not route AI bodies into activation.

What is expected:
- A skill at `src/packages/cnos.core/skills/agent/activate/SKILL.md` defines the agent activation procedure once: load order, body-capability gate, identity confirmation, README router template.
- `cn activate` evolves to load this skill (from the vendored bundle) and render it with hub-state interpolation — the skill is the source of truth, the command is a thin surface.
- Bodies without `cn` (Claude Code on the web, Codex, Claude.ai sessions with WebFetch) self-bootstrap by fetching the skill URL directly and following it against the hub URL.

Where they diverge:
- Procedure lives in Go code; no skill artifact exists. The "everything is a skill" invariant is violated for activation.
- Bodies without `cn` cannot reach the procedure — no fetchable artifact.
- No documented convention for hub READMEs to route AI bodies.

---

## Impact

- Affects: every AI body that operates against a cnos hub without the `cn` binary present (Claude Code on the web, Codex sessions, Claude.ai chats with WebFetch, future bodies). Today these bodies depend on the operator manually pointing at the hub and reading files in an improvised order — the exact "I wake up incoherent by default" failure documented in `cn-sigma/threads/adhoc/20260325-session2-learnings.md`.
- Blocks: durable cross-body identity convergence. Without a fetchable skill, every non-cn body reinvents activation and drifts.
- Enables: the `cnos.xyz/activate/<hub>` URL surface (future deferred work) by giving it canonical content to render. Also enables `cn doctor` enforcement of activation invariants in a future cycle.
- Coherence: closes the gap where activation is the only cnos procedure not encoded as a skill.

---

## Status truth

| Surface | What ships | What is draft/planned |
|---|---|---|
| `cn activate` command | shipped v3.70.0+; reads hub state, emits prompt; **procedure hardcoded in Go** | this issue evolves it to load the skill |
| `cnos.core/doctrine/KERNEL.md` | shipped — generic coherent-agent doctrine | none |
| `cnos.core/skills/agent/{cap,clp,mca,mci,coherent,agent-ops}/SKILL.md` | shipped — CA skill set | none |
| `cnos.cdd/skills/cdd/activation/SKILL.md` | shipped — CDD repo activation (different concern) | none |
| `cnos.core/skills/agent/activate/SKILL.md` | does not exist | this issue creates it |
| `cn activate` reads this skill | does not happen | this issue wires it |
| Hub README router pattern | does not exist | this issue documents the convention (inside the skill) |

---

## Source of truth

| Claim / surface | Canonical source | Status | Notes |
|---|---|---|---|
| Activation procedure (canonical skill) | `src/packages/cnos.core/skills/agent/activate/SKILL.md` | To create | Primary deliverable; single source of truth |
| Activation procedure (cn rendering surface) | `src/go/internal/activate/activate.go` | Shipped — to evolve | Loads + renders the skill instead of hardcoding |
| Kernel doctrine (what kind of agent) | `src/packages/cnos.core/doctrine/KERNEL.md` | Shipped | Loaded by activation |
| CA skill set (behavioral instruction set) | `src/packages/cnos.core/skills/agent/{cap,clp,mca,mci,coherent,agent-ops}/SKILL.md` | Shipped | Loaded by activation |
| Skill artifact-class format | `src/packages/cnos.core/skills/skill/SKILL.md` | Shipped | New skill conforms |
| CDD-protocol repo activation (distinct concern) | `src/packages/cnos.cdd/skills/cdd/activation/SKILL.md` | Shipped | New skill must cite and disambiguate |
| Hub-side persona/operator instance | `<hub>/spec/PERSONA.md`, `<hub>/spec/OPERATOR.md` | Per-hub | Loaded by activation against the named hub |
| Layering rule (soul vs identity) | `cn-sigma/threads/adhoc/20260325-session2-learnings.md` §3 | Shipped reflection | "Soul = what kind of agent. Identity = which agent. Don't mix them." |

---

## Scope

In scope:
- Create `src/packages/cnos.core/skills/agent/activate/SKILL.md` conforming to the skill skill format (frontmatter with triggers, scope, inputs, outputs, calls; core principle; load order; failure modes).
- Describe the body-agnostic activation procedure: load order, identity-confirmation step, body-capability gate, failure modes, README router template.
- Cite and disambiguate from `cnos.cdd/skills/cdd/activation/SKILL.md`.
- Evolve `cn activate` (`src/go/internal/activate/activate.go`) to read the skill from the vendored bundle and render it with hub-state interpolation. Drop the hardcoded load-order in `writePrompt`.
- Preserve `cn activate`'s current observable output structure (or document deltas explicitly) — the skill becomes the source of truth, the command renders from it.

Out of scope:
- Implementing the README router in `usurobor/cn-sigma` or `usurobor/cn-pi` (separate per-hub cycles; this cycle ships the skill the routers will point at).
- Dynamic URL surface `cnos.xyz/activate/<hub>` (deferred; requires hosting decision).
- `cn doctor` validation that a hub README contains a valid router (deferred follow-on).
- Migrating any other cnos procedure from code to skill form.

Deferred:
- Hub README router patches (cn-sigma, cn-pi).
- `cnos.xyz` rendering service.
- Doctor enforcement of router presence and activation invariants.

---

## Cycle scope sizing

| Factor | Reading | Splitting signal? |
|---|---|---|
| (a) New code surface | One new skill artifact + modifications to one Go package | no (single-focus deliverable) |
| (b) Cross-module breadth | `cnos.core/skills/` (new skill) and `src/go/internal/activate/` (renderer) — two modules touched | borderline; tightly coupled, ship together |
| (c) Lifecycle span | Skill authoring + Go rendering changes — same cycle, no phase serialization | no |
| (d) MCA preconditions | Design converges in this issue body; no mid-cycle re-scoping expected | no |
| (e) Independent shippability | Skill without Go evolution = stale binary; Go without skill = no source to read. Must ship together. | no |

Decision: keep whole — single-focus cycle, ~7 ACs, two modules but tightly coupled (skill must ship with the renderer that reads it).

Mode: **design-and-build** — design converges in the issue body during γ; α writes the skill and evolves the Go renderer. Not MCA (no separate committed DESIGN.md path).

---

## Acceptance criteria

### AC1: activate skill exists at canonical path

Invariant: `src/packages/cnos.core/skills/agent/activate/SKILL.md` exists and is non-empty in the cycle branch diff.
Oracle: `test -f src/packages/cnos.core/skills/agent/activate/SKILL.md && [ -s src/packages/cnos.core/skills/agent/activate/SKILL.md ]`
Positive: file present at path, ≥200 lines of substantive content.
Negative: file missing, empty, or located elsewhere (e.g., under `doctrine/`).
Surface: `src/packages/cnos.core/skills/agent/activate/SKILL.md`.

### AC2: Skill conforms to skill skill format

Invariant: New skill matches the structural conventions enforced by `cnos.core/skills/skill/SKILL.md`: YAML frontmatter with `name`, `description`, `artifact_class: skill`, `governing_question`, `triggers`, `scope`, `inputs`, `outputs`; body sections (core principle, Define/Unfold/Rules/Verify or equivalent) per the skill skill prescription.
Oracle: SKILL.md frontmatter parses; `name`, `triggers`, `governing_question`, and `artifact_class` fields present; body contains the prescribed section structure.
Positive: frontmatter valid, all required fields, body matches skill skill conventions.
Negative: missing frontmatter fields, wrong artifact_class, free-form prose without skill structure.
Surface: `src/packages/cnos.core/skills/agent/activate/SKILL.md`.

### AC3: Skill prescribes the body-agnostic load order

Invariant: The skill describes the activation sequence as: (1) Kernel from cnos, (2) CA skills from cnos, (3) Persona from hub, (4) Operator from hub, (5) hub state (deps, latest reflection, memory, threads), (6) identity confirmation.
Oracle: grep SKILL.md for ordered section headings or a numbered list naming Kernel, CA skills, Persona, Operator, hub state, confirmation — in that order.
Positive: six ordered items matching the load order; layering rule (soul vs identity) cited.
Negative: missing item, wrong order, or order inconsistent with `cn activate`'s current "Read first" output after AC6 reconciliation.
Surface: `src/packages/cnos.core/skills/agent/activate/SKILL.md`.

### AC4: Skill is body-agnostic and names the capability gate

Invariant: SKILL.md states explicitly that the procedure requires only the ability to read files at URLs (WebFetch or equivalent file read); it does not require the `cn` binary, a local filesystem checkout, or other body-specific tooling. Bodies without fetch capability follow a named degraded path.
Oracle: SKILL.md contains an explicit body-capability section naming the fetch requirement and the degraded path for bodies without fetch.
Positive: explicit section present; load steps written as URL-fetchable paths (`<hub>/spec/PERSONA.md`, etc.); degraded-path note for non-fetch bodies.
Negative: load steps require `cn` execution; no degraded-path note.
Surface: `src/packages/cnos.core/skills/agent/activate/SKILL.md`.

### AC5: README router template documented in the skill

Invariant: SKILL.md includes a labeled "README router template" section with a markdown snippet hubs can adopt verbatim. The snippet routes an AI body told "Activate as `<hub URL>`" into fetching the skill.
Oracle: SKILL.md contains a "README router template" heading with a fenced markdown block underneath.
Positive: template present, self-contained, no per-hub edits required beyond the hub URL.
Negative: no template, or template requires per-hub customization beyond identity-naming.
Surface: `src/packages/cnos.core/skills/agent/activate/SKILL.md`.

### AC6: Naming disambiguation from cdd/activation/SKILL.md

Invariant: SKILL.md explicitly cites `src/packages/cnos.cdd/skills/cdd/activation/SKILL.md` and states the distinction: cdd/activation = activate a repo under CDD protocol; agent/activate = activate an agent identity at a hub. Both are skills in cnos; they share a word, not a concern.
Oracle: SKILL.md contains the disambiguation paragraph with both paths cited.
Positive: paragraph present, both file paths exact, distinction stated in one sentence.
Negative: no citation, citation without distinction, or paths misspelled.
Surface: `src/packages/cnos.core/skills/agent/activate/SKILL.md`.

### AC7: `cn activate` reads the skill instead of hardcoding the procedure

Invariant: `src/go/internal/activate/activate.go` loads the activate skill from the vendored bundle (or equivalent canonical location) and renders its content with hub-state interpolation. The procedural ordering of sections is no longer hardcoded in `writePrompt`; the skill is the source of truth.
Oracle: diff `activate.go` against pre-cycle HEAD — the hardcoded "Read first" list and section emission in `writePrompt` no longer source their ordering from in-Go constants/literals; instead they read from the skill file. Test in `activate_test.go` confirms behavior is driven by skill content.
Positive: Go code reads `agent/activate/SKILL.md` (e.g., from `.cn/vendor/packages/cnos.core/skills/agent/activate/SKILL.md` when vendored), interpolates hub-state, emits. Skill content change → command output change (verified by test).
Negative: Go code still emits a hardcoded load order; or reads the skill but ignores it; or no test covers the skill-as-source-of-truth invariant.
Surface: `src/go/internal/activate/activate.go`, `src/go/internal/activate/activate_test.go`.

---

## Proof plan

Invariant: A body told "you are Sigma, your hub is `https://github.com/usurobor/cn-sigma`" can, using only WebFetch and the procedure prescribed by `agent/activate/SKILL.md`, reach an operating state where it names its identity, names its operator, and names its current cycle — without operator intervention beyond the initial URL. Independently, `cn activate HUB_DIR` produces a prompt whose load order and section content are sourced from the same skill file.

Surface: `src/packages/cnos.core/skills/agent/activate/SKILL.md`, `src/go/internal/activate/activate.go`, `src/go/internal/activate/activate_test.go`, raw GitHub URLs for cn-sigma's `spec/PERSONA.md`, `spec/OPERATOR.md`, and the latest daily reflection.

Oracle:
- Mechanical: AC1–AC6 oracles run against the cycle branch; AC7's diff and test oracles run against the Go package.
- Coherence: edit one section ordering line in the new SKILL.md; rerun `cn activate` against a fixture hub; confirm the emitted prompt's ordering changed accordingly. (Demonstrates the skill is actually the source of truth.)
- Behavioral: a manual dry-run by the operator — paste the README router snippet into a fresh Claude.ai session with WebFetch enabled, hand it the cn-sigma hub URL, observe whether it reaches the identity-confirmation step without further prompts.

Positive case: skill present and conformant, Go renderer reads it, edit-to-output coherence demonstrated, body completes the manual dry-run successfully.

Negative case: skill missing or non-conformant; Go renderer still hardcodes the procedure; edit to skill has no effect on `cn activate` output; or body in dry-run requires operator clarification before naming identity.

Operator-visible projection: CI artifact validation passes; the cycle's `claims.md` records the edit-to-output coherence test and the dry-run output; β review confirms skill-renderer coherence.

Known gap: this cycle does not implement the routers in any hub's README (deferred). It does not stand up `cnos.xyz`. It does not migrate other procedures from code to skill form. The skill and its renderer are published; consumers and follow-on cycles land separately.

---

## Skills to load

Tier 3:
- `cnos.core/skills/skill/SKILL.md` — to follow the skill artifact format
- `cnos.core/skills/write/SKILL.md` — for prose structure
- `cnos.core/skills/design/SKILL.md` — for the design-and-build mode's design step
- `cnos.cdd/skills/cdd/activation/SKILL.md` — to cite and disambiguate
- `cnos.eng/skills/eng/go/SKILL.md` — for the Go renderer changes (if such a skill exists; otherwise the code skill)

Why:
- skill — defines the format the new skill must match.
- write — clarity matters; this skill instructs LLM bodies and humans.
- design — design-and-build mode opens with design.
- cdd/activation — same word, different concern; must be cited and distinguished.
- go (or code) — the renderer change touches a Go package and needs to follow cnos's Go conventions.

---

## Active design constraints

- "Everything is a skill" invariant: cnos procedures live in skill artifacts, not hardcoded in code. The activate skill is the source of truth; the cn command is a rendering surface. This cycle restores that invariant for activation.
- Layering rule (from cn-sigma `threads/adhoc/20260325-session2-learnings.md` §3): "Soul = what kind of agent. Identity = which agent. Don't mix them." The skill keeps Kernel and CA skills (generic, in cnos) separate from Persona and Operator (per-hub).
- Constitutive-change policy: the activate skill is doctrine-adjacent; future changes follow the same approval discipline as other constitutive skills (governed by `cnos.core/skills/agent/configure-agent/SKILL.md` or the equivalent operator-approval mechanism).
- Body-capability honesty: bodies without WebFetch cannot self-activate. The skill must say so plainly and name the degraded path.
- Renderer faithfulness: `cn activate`'s observable output must continue to be parseable by current consumers (claude -p invocation). Output deltas (if any) are recorded as claims.

---

## Related artifacts

- `src/packages/cnos.core/skills/skill/SKILL.md` — skill format definition
- `src/packages/cnos.core/doctrine/KERNEL.md` — kernel doctrine loaded by activation
- `src/packages/cnos.core/skills/agent/{cap,clp,mca,mci,coherent,agent-ops}/SKILL.md` — CA skills loaded by activation
- `src/packages/cnos.cdd/skills/cdd/activation/SKILL.md` — CDD repo activation (named concern; cite for disambiguation)
- `src/go/internal/activate/activate.go` — current procedure-in-code; renderer after this cycle
- `src/go/internal/cli/cmd_activate.go` — `cn activate` CLI entry
- cn-sigma `threads/adhoc/20260325-session2-learnings.md` — "I wake up incoherent by default" (origin reflection)
- cn-sigma `threads/adhoc/20260426-memory-retrieval-vs-continuity.md` — names SOUL/USER/BOOTSTRAP as behavioral constraints (historical naming)
- cn-sigma `threads/adhoc/20260501-threads-inbox-scanner-drift.md` — cnos #323 (filed against `cn activate`; closed in 3.71+)

---

## Implementation guidance

- Branch: `cycle/{N}` per CDD convention.
- Identity: α and β under `{role}@cdd.cnos` per cnos identity elision.
- The skill loads from the vendored bundle at `.cn/vendor/packages/cnos.core/skills/agent/activate/SKILL.md`. The renderer needs a sensible fallback or error if the vendored bundle is absent (current behavior on `manifest-only` deps state must be preserved or improved, not regressed).
- The renderer's interpolation surface — what fields of hub state get substituted into the skill's template positions — is a design decision that should be made explicit in the skill (e.g., `{hub_persona_path}`, `{hub_latest_reflection}`) or in the renderer's documented contract. Avoid implicit substitution that drifts.

---

## Non-goals

- Replacing or restructuring `cdd/activation/SKILL.md`.
- Migrating other cnos procedures (peer sync, inbox triage, etc.) from code to skill form.
- Hosting `cnos.xyz/activate/<hub>` or any dynamic rendering surface.
- Patching `cn-sigma/README.md`, `cn-pi/README.md`, or any other hub's README.
- Defining a `cn doctor` check for router presence in hub READMEs.
- Renaming or relocating `spec/PERSONA.md`, `spec/OPERATOR.md`, or hub directory conventions.
- Changing the `cn activate` CLI surface (flags, arguments, exit codes).

---

## Success / closure condition

This issue is closeable when:
- AC1–AC7 oracles produce passing results in the cycle branch.
- `claims.md` records the edit-to-output coherence test and the manual dry-run from the proof plan.
- `cn activate`'s observable output is unchanged for existing consumers, or deltas are documented as claims.
- Naming-disambiguation paragraph (AC6) is present and correct.
- Known gaps (router patches deferred to per-hub cycles; cnos.xyz deferred; other procedure migrations not undertaken) are explicitly named in the close-out.
- Non-goals remain unviolated in the diff.
