# Open source software engineer agent

**Date:** 2026-04-05
**Context:** README reframe, #156 memory model decision, cn-sigma as public artifact

## What happened

Session started with routine release work (cnos v3.33.0, tsc v0.4.0) and evolved into a fundamental reframing of what cn-sigma is.

Key progression:
1. Release tooling convergence (scripts/release.sh for both repos, cn release removed)
2. #156 attached hub design → "agent sent on a mission into a repo"
3. Memory model decision: hub is memory, workspace is workbench, no project-local memory surface
4. README rewrite: from autobiographical showcase to attachable public artifact
5. Realization: this is an open source software engineer — identity, memory, engineering context, all public

## The insight

No one has open-sourced the engineer itself. Frameworks (AutoGPT, CrewAI, SWE-agent) are empty tools. cn-sigma is a shaped engineer with accumulated context. Attach it to a repo and it works. PRs to cn-sigma improve the engineer for everyone.

New contribution model: you're not contributing code to a tool. You're contributing experience to an engineer.

## Three-layer model

- **Hub (cn-sigma)** — identity + memory + public engineering context
- **cnos (runtime)** — skills + packages + runtime
- **Local instance** — project-specific learned context (forked on attach)

## Memory model decision

- All memory stays in hub, tagged by workspace
- No project-local memory surface (coherence regression — two places to search)
- Reports/artifacts go to workspace for others to see
- One agent, one workspace at a time
- Concurrent multi-repo is a scheduling problem, not placement

## What changed

- cn-sigma README rewritten (bc5f504)
- #156 updated with memory model (AC9, AC10), progress section, attach flow
- #162 opened (modular CLI commands)
- #161 closed (checksum verification, PR #163)
- tsc #22 updated with hybrid scoring design, design doc committed

## What to watch

- cn-sigma is public — ensure no private operational details leak into threads
- The "attach" flow (cn attach --hub) doesn't exist yet — Steps 4-10 of #156
- Contribution model needs docs: how to PR to cn-sigma, what kind of contributions matter
