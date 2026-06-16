# Coherer console vs wake worker: the interface boundary as doctrine

**Date:** 2026-06-16
**Status:** r0 adhoc capture; cited from forthcoming r1 reflections. Directive received from reviewer (via operator) 2026-06-15; ratified into doctrine here.
**Trigger:** Reviewer issued a structured directive to home Sigma during wave authorization: "the wave is coherent, but home Sigma must keep the boundary honest."

## The boundary

The α/γ split named two roles. This adhoc names the boundary between them as architectural doctrine, not implementation convention.

**Interactive Claude attached to a repo = coherer console.**
**Wake substrates = workers.**
**Repo artifacts = the only shared medium.**

The split:

| Role | What it does |
|---|---|
| Interactive Claude (γ-console) | Speaks with operator; interprets intent; edits issues/specs/logs; diagnoses worker reports; promotes stable learnings; resolves ambiguity |
| Wake worker (α) | Performs bounded routine work; reads declared repo artifacts; appends r0 / terminal reports; may produce bounded r1 in home mode; does NOT depend on hidden chat context |

## Hard invariant

**Workers act only from artifacts.** Interactive Claude may speak for the operator INTO artifacts; the worker may act only FROM artifacts. No hidden chat state is worker input.

This protects:
- **Reproducibility.** Two workers reading the same artifact produce the same action regardless of who is at which console.
- **Auditability.** Every decision that drove a worker action is durable + addressable by git SHA.
- **Multi-user γ.** Each operator's attached Claude is a separate console; workers don't have to "merge" chat states because workers don't read chat states at all.

## Surface taxonomy

The doctrine maps surfaces to functions:

| Surface | Plane |
|---|---|
| Issues / PR comments | Control plane |
| Activation logs (`threads/activations/`, `.cn-<agent>/logs/`) | Memory plane |
| Branches / commits / PRs | Work plane |
| Reflections (`threads/reflections/`) | Coherence plane |

Workers traverse all four planes (read all, write own per Writer Locality). Coherer consoles traverse all four (interpret, edit, promote). The planes are not exclusive — they're functional.

## Relation to existing doctrine

- **Writer Locality** (PR #445): every body writes only to its own repo-owned surface. This boundary preserves it: the console writes only to its own repo's artifacts; the worker reads cross-repo, writes own.
- **α/γ role split** (`threads/adhoc/20260604-operator-to-coherer-routing.md`): named the roles by responsibility (coherer vs implementer). This doctrine adds the substrate distinction (console vs worker) and the invariant (artifacts-only flow).
- **AC18 identity attribution**: workers attribute as `sigma@<hub>`; consoles attribute via operator's git author (their own GitHub identity when committing). Different attribution paths reflect the distinction.

## What this changes operationally

For me (home Sigma γ-console):
- **Every decision that should affect a worker MUST land in an artifact first.** Directive in channel log = artifact. Comment on an issue = artifact. Edit to a spec = artifact. Conversation-only decisions cannot influence worker behavior.
- **Operator dialogue is consumed BY me, not BY workers.** I synthesize, write artifacts, push. Workers see artifacts only.
- **R1 reflections become the durable record of console-side learnings.** This is why missing r1 days = lost durable record. (See `threads/reflections/daily/20260614.md` for the explicit gap acknowledgment.)

For workers (α-substrate, current and future):
- Workers do NOT receive prompts containing operator-conversational context. The wake action's prompt is `Cohere as <hub-url>` and nothing else.
- Workers read durable surfaces. If a directive isn't in the channel log when the worker fires, the worker does not see it.
- This validates the wake-template renderer (cnos#450) AC10 (prompt boundary): the template MUST NOT interpolate arbitrary event payloads into instruction layer.

## Substrate-cost ruling refinement

The reviewer's substrate-cost ruling sharpens the prior framing:
- Keep Claude for γ-console (interactive subscription unchanged).
- Use cheaper substrates for bounded α work ONLY after substrate contract + discipline checks exist (cnos#452 v0 + cnos#453 follow-on).
- cnos#452 v0 ships substrate-contract continuity (Claude backend, openai-compat stub) — NOT cost mitigation.
- Cost mitigation arrives via cnos#453's functional NIM canary, not before.

This rules against premature substrate swap. The cost finding's discipline matters: don't claim mitigation until the work is done.

## Promotion targets

When this doctrine stabilizes (after at least one wake-substrate canary validates the worker side):

- `cn-sigma:spec/OPERATOR.md` § "Coherer console vs wake worker" — pointer to this doctrine
- `cnos:src/packages/cnos.core/skills/agent/cohere/SKILL.md` — § "Interface boundary" referencing this
- `cnos:docs/gamma/conventions/AGENT-ACTIVATION-LOG-v0.md` — possibly an addendum § citing the four-plane surface taxonomy

Not promoting unilaterally. Doctrine candidate; promotion requires operator authorization per v3.82.0 pause posture.

## The reviewer's three action candidates (carried forward)

```yaml
- axis: gamma
  owner: home-sigma
  surface: cn-sigma:threads/reflections/daily/
  action: "Record the interactive-Claude-as-coherer / wake-substrate-as-worker split as the current cohere-wave interface doctrine."
  expected_effect: "Worker instructions flow through issues, logs, state, specs, or commits only."
  success_evidence: "Daily r1 or adhoc reflection names: interactive Claude = coherer console; wake substrate = worker; repo artifacts = shared medium."
  trigger: next-home-reflect
  status: in_progress (this adhoc IS the recording; r1 cites)

- axis: beta
  owner: home-sigma
  surface: cnos#444
  action: "Ensure cnos#444 canonical AC index includes the worker/artifact boundary and does not imply hidden chat context as worker input."
  target_state: "cohere skill contract says workers act from durable repo artifacts only."
  expected_effect: "Wake behavior remains reproducible and auditable across substrates."
  success_evidence: "#444 body or authoritative AC comment includes the interface split."
  trigger: before-#444-implementation
  status: pending_verification (D11 AI3 adds canonical AC index; verify it captures this; if not, D12 amendment)

- axis: gamma
  owner: home-sigma
  surface: cnos#452
  action: "Ensure #452 links a follow-on issue for functional OpenAI-compatible/NIM wake executor before v0 closes."
  target_state: "Substrate-cost finding has an executable follow-on path, not only a design note."
  expected_effect: "Claude remains γ/coherer substrate while α heartbeats gain a tracked cheaper-worker path."
  success_evidence: "#452 closeout links the openai-compat/NIM executor follow-on."
  trigger: before-#452-close
  status: done (D11 AI7 opens cnos#453; D11 AI8 comments on cnos#452 linking the follow-on; pending Sigma-at-cnos application of D11)
```

## Final framing

The course adjusts from "Claude wakes do everything" to:

```
interactive Claude as coherer console,
wake substrate as bounded worker,
repo artifacts as the only shared memory/control medium.
```

The target remains one-verb cnosification with visible gates. The interface ruling is the discipline that keeps that target honest.

## Citations

- `cn-sigma:threads/adhoc/20260604-operator-to-coherer-routing.md` (prior α/γ framing)
- `cn-sigma:threads/adhoc/20260614-substrate-cost-alternative.md` (substrate-cost finding)
- `cn-sigma:threads/reflections/daily/20260614.md` (afternoon r1 resuming cadence)
- PR #445 (Writer Locality, foundational)
- cnos#444 (cohere — pending body update via D11 AI3)
- cnos#452 + cnos#453 (substrate contract + functional follow-on)
- Reviewer directive received 2026-06-15 via operator (full text preserved in commit message of this adhoc's parent commit).
