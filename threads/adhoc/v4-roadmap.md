# v4.0 Roadmap — From Here to There

**Status:** Active
**Created:** 2026-04-11
**Context:** Repo restructured, packages in place, OCaml ceased. What remains.

## Current state (post-restructure)

- Go CLI: 8 kernel commands, 63 tests, all green
- Repo: `src/{go,packages,ocaml}` → `dist/` — clean layout
- Packages: cnos.core (21 skills, 3 commands), cnos.cdd (1+6 skills), cnos.eng (19 skills)
- All 47 skills have triggers in frontmatter
- Manifests declare exposed/internal skills
- OCaml ceased in CI/release — retained as reference implementation
- Pi: stopped, running v3.50.0 OCaml binary (last deployed version)
- VPS: Go binary v3.50.0 installed

## What remains

### Phase 4 — Package command discovery + dispatch

The Go CLI only knows its 8 kernel commands. It needs to discover and dispatch package commands (daily, weekly, save) from installed packages.

**Work:**
1. Scan `.cn/vendor/packages/*/cn.package.json` for `commands` entries
2. Register discovered commands in the unified command registry (per GO-KERNEL-COMMANDS.md §2)
3. Dispatch: `cn daily` → find command → exec entrypoint script
4. `cn help` lists all three tiers (kernel, repo-local, package)
5. `cn doctor` validates command integrity (dupes, missing entrypoints, non-executable)

**Depends on:** nothing — can start now
**Estimated scope:** ~2-3 PRs

### Phase 4.5 — `cn build` for new layout

Current `cn build` (Go) reads from the old `src/agent/` + `packages/` paths. Needs updating for `src/packages/` co-located layout.

**Work:**
1. Read `src/packages/*/cn.package.json`
2. Discover content classes by directory presence (no `sources` field)
3. Assemble tarballs into `dist/packages/`
4. Generate `dist/packages/index.json` + `dist/packages/checksums.txt`
5. `cn build --check` validates structure + manifest completeness
6. Update CI coherence check (I1) for new paths

**Depends on:** nothing — can start now (parallel with Phase 4)
**Estimated scope:** ~2 PRs

### Phase 4.7 — Activation table scanner

Scan installed packages → read exposed skills → parse frontmatter triggers → build activation table. Emit in runtime contract at wake.

**Work:**
1. Parse YAML frontmatter from SKILL.md files
2. Read `skills.exposed` from `cn.package.json`
3. Build keyword → skill mapping
4. Emit activation table (format per PACKAGE-ARTIFACTS.md)

**Depends on:** packages installed (Phase 4.5 or manual)
**Estimated scope:** ~1 PR

### Phase 5 — Agent runtime → v4.0.0

The big one. Port the OCaml agent runtime to Go.

**Work (roughly ordered):**
1. CN Shell — typed op execution, validation, sandboxing, receipts
2. Thread FSMs — inbox/outbox/doing/archived state transitions
3. Scheduler — oneshot + daemon modes, maintenance cycle, queue drain
4. GTD commands — do, done, defer, delegate, delete, reply, send
5. Peer sync — git-based inbox/outbox exchange
6. LLM integration — API dispatch, output parsing, conversation state
7. Provider protocol — subprocess stdio NDJSON (per PROVIDER-CONTRACT-v1.md)
8. Telegram integration (optional, may stay external)
9. Runtime contract emission — identity, cognition, body, medium
10. Delete OCaml source

**Depends on:** Phase 4 complete
**Estimated scope:** the majority of the work — months, not weeks
**Ships as:** v4.0.0

## Milestones

| Milestone | Signal |
|-----------|--------|
| Phase 4 done | `cn daily` works from Go binary |
| Phase 4.5 done | `cn build` produces dist/ from src/packages/ |
| Phase 4.7 done | `cn doctor` shows activation table |
| Phase 5 alpha | `cn agent` runs one cycle in Go |
| Phase 5 beta | Daemon mode works, Pi migrated to Go |
| v4.0.0 | OCaml deleted, full Go runtime, all commands |

## Principles

- Ship each phase as working binary — no big bang
- OCaml is reference, not dependency — read it, don't link it
- Tests before port — write Go tests from OCaml behavior, then implement
- YAGNI — add packages/features when needed, not before
