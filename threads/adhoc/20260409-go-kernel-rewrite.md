# Go Kernel Rewrite — Decision Thread

**Date:** 2026-04-09
**Status:** decision captured, sequenced after Move 2 + #180

## Decision

The cnos runtime kernel will be rewritten in Go. Not a philosophical reset — a runtime-only rewrite that preserves the package-driven architecture and language-agnostic cognition assets.

## Rationale (operator)

cnos in practice is: package manager + CLI/runtime + command/orchestrator dispatcher + manifest/registry validator + file/git/http tool. Go's stdlib covers this profile almost completely (JSON, HTTP, tar, sha256, fs, exec). Cross-compilation is trivial (`GOOS/GOARCH`). Development speed and operational clarity matter more than extracting static correctness from the type system for this workload.

Compared to alternatives:
- **Rust:** plausible but too much friction for the value at this system shape
- **Erlang/Elixir:** wrong fit — cnos is Git/file/package substrate, not actor fabric
- **OCaml:** capable but showing practical cost — toolchain friction, no agent-side build, runtime wants to be simpler than the language footprint allows

## Tradeoffs acknowledged (sigma)

- OCaml's type system earned its keep in specific places: type-equality re-export, exhaustive match, `Contract_redirect` receipt status. Go needs discipline where OCaml enforces structurally.
- `src/lib/` purity discipline is easier in OCaml's module system than Go packages. Solvable with convention.
- Neither is a dealbreaker — the system profile favors Go's strengths.

## Evidence

- No local OCaml toolchain for 6+ consecutive authoring cycles (environmental constraint)
- Kernel actively shrinking: commands migrating to packages, built-in set approaching 7-command bootstrap
- The smaller the kernel, the cheaper the rewrite
- Cross-compilation pain visible in release workflow matrix

## Sequencing

1. **Finish Move 2** (3 remaining `src/lib/` extraction slices) — clarifies boundaries
2. **Ship #180** (doc coherence) — single source of truth on package system
3. That produces the stable architecture spec
4. **Go rewrite** of the lean kernel, with architecture doc as contract
5. Cognition assets unchanged — already language-agnostic content (skills, commands, orchestrators, doctrine, templates)

## What rewrites

- Package manager (deps resolve/restore/lock)
- Command registry + dispatch
- Orchestrator runtime (cn_workflow)
- Runtime contract builder
- Doctor/status/help/update/setup/init
- A2A substrate and sync/runtime services
- Extension host protocol

## What doesn't change

- Package content classes (skills, commands, orchestrators, templates, assets, docs)
- Doctrine, mindsets, SOUL, spec files
- Hub structure (threads, spec, packages)
- Git-native transport model
- CDD process

## MCI freeze alignment

MCI freeze declared in v3.38.0 post-release assessment. The stabilization work (Move 2 + #180) is the prerequisite. No new design commitments until implementation catches up — which is exactly what "finish boundaries, then rewrite" requires.
