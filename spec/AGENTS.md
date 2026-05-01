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

### On-demand skills

Do NOT load these at boot. Load only when a task requires them.

- Core utility: `cnos/src/packages/cnos.core/skills/` (design, write, compose, audit, skill, naturalize)
- Eng: `cnos/src/packages/cnos.eng/skills/eng/` (code, test, ship, rca, go, ocaml, typescript, etc.)
- Ops: `cnos/src/packages/cnos.core/skills/ops/` (inbox, peer, adhoc-thread, star-sync)
- CDD: `cnos/src/packages/cnos.cdd/skills/cdd/` — load role skill (alpha, beta, gamma, operator) + lifecycle skills (review, release, issue, post-release, design) per task
