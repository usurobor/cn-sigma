# feat(cnos.core/agent/kappa): session-start preflight — mechanical durable-state gate before κ response

**Filing mode:** `design-and-build` (per `cnos:src/packages/cnos.cdd/skills/cdd/issue/SKILL.md`).
**Sub of:** `foundation-completion-wave` master tracker (this bundle's parent).
**Suggested labels:** `P1`, `area/agent`, `area/cdd`, `kind/tooling`, `protocol:cds`.
**cell_kind:** `implementation` (per `cnos:src/packages/cnos.cdd/skills/cdd/CELL-KINDS.md`, post-cycle/570).

## Problem

**Exists:** κ (Sigma at cn-sigma) has exhibited 5 named-doctrine-doesn't-carry-weight instances this month: 06-03→13 gap, 06-15→17 gap, 06-19→07-02 gap, 07-03 date-misread from chat-context, 07-04 backfill-required-operator-prompt. Each instance is chat-context reasoning replacing durable state read at session resume.

**Expected:** κ session-resume runs a typed mechanical preflight that reads durable state (repo HEAD vs origin; channel files; state/*.md; notification cursors; today's date verified via `date -u`) before any κ response is emitted. Failure of preflight surfaces as a refusal-to-respond, not a κ-composed answer over stale state.

**Divergence:** No such mechanism exists. Discipline is exhortation-shaped per `cn-sigma:20260703-discipline-failures-become-typed-gates.md`. Every instance recurs. Named 4× as doctrine before the 07-04 instance.

## Impact

- κ decisions from stale state produce audit-correction adhocs. Session backfill inflates. Prior session required 17-file adhoc sweep + subsequent 4-adhoc correction sweep for the same failure mode.
- Every instance is externally caught (operator) or self-caught late (κ during backfill). No instance was caught by discipline before response.
- Essay v5 §12 explicitly names the pattern: "the model may be smart inside the call; the system must be smarter across calls." The preflight IS the smarter-across-calls surface at the κ altitude.

## Status truth

- Doctrine named at `cn-sigma:20260703-discipline-failures-become-typed-gates.md` (07-03).
- Mechanism proposed as MCA in `cn-sigma:20260703.md` daily r1 conclusions.
- Not implemented at cn-sigma. Not implemented at cnos.
- κ role doctrine at `cnos#501` (status:ready) will canonicalize the role this preflight defends.

## Source of truth

| Artifact | Path | Role |
|---|---|---|
| κ role skill | `cnos:src/packages/cnos.core/skills/agent/kappa/SKILL.md` (post-cnos#501 landing) | Contract this preflight defends |
| Preflight script | `cnos:src/packages/cnos.core/skills/agent/kappa/scripts/preflight.sh` (this issue proposes) | The mechanical gate |
| Preflight output schema | `cnos:src/packages/cnos.core/skills/agent/kappa/schemas/preflight-report.cue` (this issue proposes) | Typed output that κ consumes |
| Wake integration point | Session-start hook (mechanism TBD per handoff checklist) | Where preflight fires |
| Doctrine reference | `cn-sigma:.cn-sigma/threads/adhoc/20260703-discipline-failures-become-typed-gates.md` | Why this exists |

## Scope

**In:**

1. Shell script at `src/packages/cnos.core/skills/agent/kappa/scripts/preflight.sh` implementing the mechanical checklist.
2. Typed report schema at `src/packages/cnos.core/skills/agent/kappa/schemas/preflight-report.cue` for the script's output.
3. Wake-side or session-start-hook integration: preflight runs before κ emits any response. Mechanism selected from existing options (does NOT invent new session-hook infrastructure).
4. Fixtures at `src/packages/cnos.core/skills/agent/kappa/fixtures/preflight/{fresh,stale-2day,stale-8day,uncommitted-work,missing-state}/` covering pass + fail scenarios.
5. Documentation update at the κ skill SKILL.md body explaining the preflight contract.

**Out of scope:**

- Not implementing session-hook infrastructure if none exists in cnos runtime. Preflight must plug into whatever the current wake yaml or session-start mechanism already provides.
- Not shipping the r1/r2/r5 reflect wakes. Those are Sub 2 of the parent wave.
- Not implementing κ enforcement at cell-level dispatch. Sub 1 is preflight-only; enforcement is downstream of cnos#501 landing.
- Not introducing new languages. Bash for the script; CUE for the schema; no new runtimes.
- Not automating the response itself. Preflight emits a report; κ reads the report; κ responds. Preflight is a *witness*, not an *actor*.

## Acceptance criteria

**AC1** — Script `src/packages/cnos.core/skills/agent/kappa/scripts/preflight.sh` exists, executable, exits 0 on green preflight and non-zero on red.

**AC2** — Script checklist covers, in order:
1. `date -u` output captured to report.
2. `git fetch origin && git log --oneline origin/main..HEAD HEAD..origin/main` — behind/ahead counts captured.
3. State-file freshness: mtime of `.cn-sigma/state/{activations.md,notification-cursors.yaml,wave.md,hub.md}` compared to `now`; any file older than N days (default 3) flagged.
4. Latest channel entries: newest 3 headers from `.cn-sigma/threads/activations/*/YYYYMMDD.md` for today + yesterday captured to report.
5. Notification cursor position vs latest substantive entry per target: gap flagged.

**AC3** — Report schema at `src/packages/cnos.core/skills/agent/kappa/schemas/preflight-report.cue` types the fields AC2 produces:
```
date_utc:            string   (ISO 8601)
git_state:           { behind: int, ahead: int, main_head: string }
state_file_ages:     [ { path: string, age_hours: int, flagged: bool } ]
channel_snapshot:    { latest_entries: [ ... ], flagged: bool }
notification_cursors: [ { target: string, cursor_ts: string, gap_hours: int, flagged: bool } ]
verdict:             "green" | "amber" | "red"
```

**AC4** — Preflight fires at session start via the smallest-existing hook mechanism. Cnos γ scaffold names the concrete integration point (wake-yaml step / `cn` CLI session-init subcommand / SessionStart hook / whichever is already in place). No new session-hook infrastructure introduced.

**AC5** — Preflight runs in ≤60s under normal conditions. Fail-open behavior on timeout: preflight timeout counts as red verdict; κ receives red report and refuses substantive response.

**AC6** — Fixtures at `fixtures/preflight/{fresh,stale-2day,stale-8day,uncommitted-work,missing-state}/` cover: green pass; amber (2-day stale); red (8-day stale — matches 06-19→07-02 gap this month); red (uncommitted work found); red (state file missing).

**AC7** — Documentation at `src/packages/cnos.core/skills/agent/kappa/SKILL.md` gains a §preflight section citing this issue and stating: "κ MUST run preflight and consume the report before emitting any response to operator. Red verdict → refuse substantive response and surface the failed check."

**AC8** — β verifies that preflight cannot be silently bypassed: the wake-yaml step (or equivalent) fires unconditionally at session start; no `--skip-preflight` flag exists.

## Required skills

- `cnos.cdd/skills/cdd/gamma` — γ scaffolds this cell; pins the integration point per AC4.
- `cnos.cdd/skills/cdd/alpha` — α implements the script + schema + fixtures.
- `cnos.cdd/skills/cdd/beta` — β reviews; AC8 is the beta gate.
- `cnos.cdd/skills/cdd/delta` — δ accepts with `cn build --check` gate; frontmatter validator (per cnos#524 W1 cross-file check) catches schema drift.
- `cnos.core/skills/agent/kappa` (post-cnos#501) — the role this preflight serves.

## Closure condition

Closes when:

1. Script + schema + fixtures + SKILL.md doc update merged.
2. `cn build --check` green.
3. Fixtures pass CI (green fixture returns green verdict; red fixtures return red).
4. First κ session in production observes preflight running before response emitted.
5. Merge subject carries `Closes #{N}` per cycle/368 close-state hard gate.

## Handoff checklist

- [ ] Implementation contract pinned by δ at dispatch (Language: Bash + CUE; CLI integration target: existing wake-yaml step OR `cn` subcommand — γ selects and pins; Package scoping: `src/packages/cnos.core/skills/agent/kappa/`; Existing-binary disposition: additive; Runtime deps: none new; JSON/wire contract: preserves cnos#524 `#Wake` schema — this is not a wake, it's a session-start hook; Backward compat: pre-preflight κ sessions remain valid, but subsequent sessions must run preflight).
- [ ] γ selects the concrete session-start integration point from existing infrastructure (NOT inventing new hook system). Options to evaluate: (a) `.github/workflows/claude-wake.yml` step; (b) `cn` CLI init subcommand fired by wake worker; (c) SessionStart hook per Claude Code convention; (d) pre-`cn` command in each cycle's own wake. γ pins one.
- [ ] Cross-repo integration point: preflight runs at cn-sigma sessions, not cnos sessions. The script lives at cnos.core (canonical); its invocation lives at cn-sigma wake yaml. Same package; different repo consumption.
- [ ] Close-state hard gate compliance per cycle/368: merge subject carries `Closes #{N}`.
- [ ] No new runtimes. Bash + CUE only.
- [ ] Preflight is a witness, not an actor — it does not automate response, only informs κ. This is essay v5 §8 "witness is cognitive; boundary is mechanical" applied at κ altitude.
- [ ] cell_kind field on the resulting cell = `implementation` per cycle/570 taxonomy.

## Empirical anchors

- `cn-sigma:.cn-sigma/threads/adhoc/20260703-discipline-failures-become-typed-gates.md` — why exhortation-shaped discipline fails and typed gates work.
- `cn-sigma:.cn-sigma/threads/reflections/daily/20260630.md` amendment section — first mechanical MCA proposal for preflight.
- `cn-sigma:.cn-sigma/threads/reflections/daily/20260704.md` — most recent evidence that discipline still requires external prompt.
- `cnos#501` — κ role skill this preflight enforces.
- `cn-sigma:.cn-sigma/threads/adhoc/20260703-coherent-llms-essay.md v5 §8` — witness-is-cognitive-boundary-is-mechanical principle applied here.
