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

## 2026-04-10 — Prerequisites met, Phase 1 scoped

All prerequisites shipped:
- Move 2 complete (v3.41.0)
- #180 doc coherence shipped (v3.42.0)
- #192 updated with narrow 4-phase scope

**Phase 1 target:** package/index/lockfile/restore — Go binary handles `cn deps restore` end-to-end.

Operator review confirmed: "Ready to begin a disciplined Go kernel transition: yes. Fully ready for Go transition: no, not for the whole system." The intelligence-bearing assets are package content classes; the kernel is substrate that installs, validates, and exposes them. The kernel transitions; the content stays.

**Do not start with:** skills, A2A workflows, package-authored behavior, activation/runtime registries.

## 2026-04-10 — Phase 1 shipped (v3.43.0)

PR #206 merged at `8d1437f`, released as v3.43.0 at `a07564d`.

- 13 tests, stdlib-only, Go 1.22
- `internal/pkg/` mirrors `src/lib/cn_package.ml` (types + JSON)
- `internal/restore/` mirrors `src/cmd/cn_deps.ml` restore path (HTTP only)
- Go CI workflow added
- Two-agent cycle: Claude authored (0–7a), Sigma reviewed/released/assessed (8–13)

**Review findings (follow-up):** F2 (HTTP timeout), F3 (traversal hardening), F4 (IO in pure pkg — purity boundary gap). F4 is the priority: the `src/lib/` vs `src/cmd/` discipline should carry into Go before expanding scope.

**#192 status:** Phase 1 complete. Growing → low in encoding lag.

## 2026-04-10 — Phase 1 purity fixed (v3.44.0)

PR #208: `internal/pkg/` is now truly pure (zero `os` imports). `Parse*` (pure, `[]byte`) vs `Read*` (IO, path) mirrors `src/lib/` vs `src/cmd/`. HTTP timeout and traversal hardening also fixed. β gap from v3.43.0 closed.

Design docs converged:
- GO-KERNEL-COMMANDS.md v1.2 — `CommandSpec` + `Invocation` + `Command` interface, 3 review iterations
- HYBRID-LLM-ROUTING.md v0.1 — body-plane routing, deferred

**Next:** #209 Phase 2 — CLI entrypoint + command dispatch. Design reviewed and ready.

## 2026-04-10 — Phase 2 shipped (v3.45.0)

First runnable Go binary: `go build ./cmd/cn && ./cn deps restore`. PR #210 + #211 merged.

- `internal/cli/`: CommandSpec, Invocation, Command interface, Registry with tier precedence + Available(hasHub)
- `cmd/cn/main.go`: hub discovery (walk up for .cn/), registry setup, dispatch
- `deps restore` + `help` commands, 20 tests total
- §7.0 gate validated: 3 B-level findings fixed on-branch before merge
- Recurring pattern: Claude reimplements stdlib functions (3 occurrences). Needs eng/go skill patch.

**#192 status:** Phase 1+2 complete. Phase 3 next (remaining kernel commands).

## 2026-04-10 — Phase 3 Slice A shipped (v3.46.0)

`init` + `status` commands. PR #213 (operator reviewed R1+R2, 4 findings all resolved). PR #215 (Sigma reviewed, 0 findings) — confinement fix for hubName validation.

- `init`: creates hub with full directory structure, config.json, SOUL.md stub, git init
- `status`: hub info + installed packages with version drift detection
- 26 Go tests total (6 new: init happy/error, status packages/drift/empty, validation 11-case table)
- Confinement gap found in review, filed (#214), fixed, and shipped same cycle

Architecture design docs also shipped this cycle:
- POLYGLOT-PACKAGES-AND-PROVIDERS.md — Go kernel + language-agnostic packages + command/provider split
- PROVIDER-CONTRACT-v1.md — subprocess protocol (spawn/handshake/describe/health/execute/shutdown)

**#212 status:** Slice A done. Remaining: B (doctor), C (build), D (update + setup).
**#192 status:** Phase 3 in progress. 4 kernel commands implemented (help, init, deps, status), 4 remaining.

## 2026-04-10 — Phase 3 Slice B shipped (v3.47.0)

`doctor` command. PR #217, 2 review rounds. 15+ checks across 5 categories: prerequisites, hub structure, package system, runtime contract, git remote.

- 2 findings: F1 (optional file showed ✗ instead of ✓), F2 (test didn't assert success). Both fixed on-branch.
- 30 Go tests total
- Also shipped: git-cn package design (#218), package restructuring target (#186), capabilities field, kernel command migration (#216)

**#212 status:** Slices A+B done. Remaining: C (build), D (update + setup).
**#192 status:** Phase 3 in progress. 5 kernel commands implemented (help, init, deps, status, doctor), 3 remaining.

## MCI freeze alignment

MCI freeze declared in v3.38.0 post-release assessment. The stabilization work (Move 2 + #180) is the prerequisite. No new design commitments until implementation catches up — which is exactly what "finish boundaries, then rewrite" requires.
