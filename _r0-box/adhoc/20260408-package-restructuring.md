# Package Restructuring — 2026-04-08

## What happened
Operator analyzed current package structure and identified cnos.core as overloaded: 28+ skills across 4 domains, one extension, one orchestrator, plus bootstrap substrate all in one package.

## Decision
Split into domain-aligned packages:
- **cnos.core** — lean bootstrap: doctrine, mindsets, templates, ~8 foundational agent skills
- **cnos.agent** — broader agent cognition (agent-ops, cbp, clp, mca, mci, etc.)
- **cnos.cdd** — CDD method bundle (all 7 cdd/* skills)
- **cnos.hub** — hub/peer/inbox operations (ops/* skills)
- **cnos.net.http** — HTTP extension as its own capability-provider package
- **cnos.eng** — unchanged (already clean)
- **cnos.pm** — retired (overlaps with cdd)

## Migration order
1. Extract cnos.cdd (clearest boundary)
2. Extract cnos.hub
3. Extract cnos.net.http
4. Retire cnos.pm
5. Split cnos.agent only if core still too big

## Key principle
Commands and orchestrators live with their owning package's domain, not all in core.

## What to watch for
- Lockfile / index must handle multiple packages cleanly (already does)
- `cn deps restore` needs to install all packages for a working agent
- Default dependency set (what a new hub gets) needs definition
- cnos.core becoming too lean to wake a useful agent without other packages

## Filed as #186
