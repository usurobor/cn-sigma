# Sub 0.25: shortest human quickstart for backend selection (design oracle)

**Parent:** #596 (wave: wake-substrate provider boundary).
**Filing kind:** docs-only / issue-authoring support. The guide is the wave's **optimization target** — backend contracts, generated-workflow changes, executor behavior, fallback reports, and canary observation are valid only insofar as they make this guide true.
**Mode:** docs-only.
**Order:** after Sub 0 (#597 status-truth reconciliation); before #452/#453 implementation. Sub 0.5 (implementation mock/golden artifact pack) derives from this guide.

## Optimization target (the north star)

> A human can safely **choose, canary, inspect, and roll back** a wake backend **without understanding the implementation boundary.**

## Problem

**Exists:** the wake-substrate wave (#596) has a coherent architecture (renderer ≠ executor ≠ model ≠ policy), but no shortest human-facing usage guide. Implementation could optimize around internal schemas rather than the safe operator workflow.

**Expected:** a concise `QUICKSTART.md` that answers the seven human questions below and names the human-visible status/report/install surfaces. It is the design oracle every later artifact is checked against.

**Divergence:** #596 starts from system structure (backend contract) rather than the operator's shortest safe path. This cell flips the wave to user-first while preserving the architecture boundary.

## Impact

- Without it, humans may not know how to inspect, canary, promote, or roll back a backend.
- β review would lack a simple user-visible oracle for whether the design is actually usable.

## Required guide questions

1. What happens if the human does nothing?
2. How does the human see which backend a wake uses?
3. How does the human try a non-default backend safely?
4. How does the human inspect the result?
5. How does the human promote a backend?
6. How does the human roll back?
7. What must the human never do?

## Scope

**In:** write a concise `QUICKSTART.md` mock (the design oracle). Mock lives in this bundle now (`QUICKSTART.md` beside this file); the shipped guide lands at a repo-convention path — recommended `src/packages/cnos.core/skills/agent/wake-substrate/examples/QUICKSTART.md` (package-examples first), `docs/wake-backends/QUICKSTART.md` alternative.
**Out (non-goals):** no runtime implementation; no workflow install; no backend-selection behavior change; commands may be mock names until #452 pins the CLI/API.

## Acceptance criteria

- **AC1 — default safe path first.** Guide opens with: most users do nothing; production stays `claude-code` unless explicitly changed. (oracle: first section; negative: guide leads with schema/internals → fail. surface: `QUICKSTART.md`.)
- **AC2 — inspect backend.** Guide shows how to see the backend a wake uses. (oracle: a `status`-class command + expected output naming `backend`.)
- **AC3 — safe canary.** Guide shows how to canary `openai-compat` **without** production write authority. (oracle: canary command with an explicit no-write flag; negative: any canary path that grants write authority → fail.)
- **AC4 — inspect terminal report.** Guide shows how to read the report, including `outcome` and `fallback`. (oracle: a `report`-class command + report fields.)
- **AC5 — promotion behind operator approval.** Guide shows promotion only after clean canary + operator approval; `openai-compat` not a production write backend yet. (oracle: promotion section states the gate.)
- **AC6 — rollback.** Guide shows rollback to `claude-code` + a verify step. (oracle: rollback section.)
- **AC7 — "never do this".** Guide lists safety rules: no hand-editing generated YAML; no openai-compat production write w/o approval; a model endpoint is not a tool policy; no silent fallback. (oracle: explicit list.)
- **AC8 — one screen.** Guide fits one screen / one printed page. (oracle: length check.)

## Proof plan

- **oracle:** `QUICKSTART.md` exists at a stable path.
- **positive:** a human can follow it to answer — what backend is active? how do I try another safely? how do I know what happened? how do I roll back?
- **negative:** the guide does NOT require editing generated workflow YAML; does NOT grant `openai-compat` production write authority; does NOT expose schema internals as the primary user interface.
- **operator-visible:** #596 comment links the guide and states which later artifacts derive from it.
- **known gap:** the guide is a target oracle until implementation lands; commands may be mock names until #452 defines the final CLI/API surface.

## Dispatch gate this cell installs

- **#452 may not dispatch** until the quickstart exists and names the human-visible status/report/install surfaces it expects.
- **#453 may not dispatch beyond hermetic design** until the quickstart defines what safe canary, refusal, fallback, and rollback look like to the human.

## Design rule (applies to every later artifact)

> If a schema, fixture, generated-workflow diff, executor behavior, or terminal report does not help make the human quickstart true, it is probably extra.

Clean center: **human guide first → artifact oracle second → implementation third → canary last.**
