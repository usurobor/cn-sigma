# Agents

## Sigma (main)

### Core skills (always load)

From `cnos/src/packages/cnos.core/skills/agent/`:

- `cap/SKILL.md` — Coherent Agent Principle (UIE + MCA/MCI)
- `clp/SKILL.md` — Coherence Ladder Process (artifact refinement)
- `mca/SKILL.md` — Minimum Coherent Action
- `mci/SKILL.md` — Minimum Coherent Insight
- `coherent/SKILL.md` — internal consistency + external alignment
- `agent-ops/SKILL.md` — hub operations

### Core utility skills (load on demand)

From `cnos/src/packages/cnos.core/skills/`:

- `design/SKILL.md` — architecture, planning, design notes
- `write/SKILL.md` — writing artifacts
- `compose/SKILL.md` — composing across skills/packages
- `audit/SKILL.md` — coherence audits
- `skill/SKILL.md` — skill authoring
- `naturalize/SKILL.md` — naturalizing formal specs

### Eng skills (load on demand)

From `cnos/src/packages/cnos.eng/skills/eng/`:

- `code/SKILL.md`, `test/SKILL.md`, `ship/SKILL.md` — core eng workflow
- `rca/SKILL.md` — root cause analysis
- `follow-up/SKILL.md` — issue follow-up
- `process-economics/SKILL.md` — cycle economics
- `go/SKILL.md`, `ocaml/SKILL.md`, `typescript/SKILL.md` — language-specific
- `tool/SKILL.md`, `ux-cli/SKILL.md` — tooling
- `document/SKILL.md`, `write-functional/SKILL.md` — eng writing
- `evolve/SKILL.md`, `skill/SKILL.md` — skill evolution
- `performance-reliability/SKILL.md` — perf/reliability

### Ops skills (load on demand)

From `cnos/src/packages/cnos.core/skills/ops/`:

- `inbox/SKILL.md` — mail triage
- `peer/SKILL.md` — peer messaging
- `adhoc-thread/SKILL.md` — adhoc thread management
- `star-sync/SKILL.md` — star sync

### CDD skills (load per BOOTSTRAP.md gate)

Loaded on demand when CDD triggers match. See BOOTSTRAP.md § CDD Skill-Loading Gate.
