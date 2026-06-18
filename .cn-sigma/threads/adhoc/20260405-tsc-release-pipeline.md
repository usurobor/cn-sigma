# tsc release pipeline — VERSION as single source

**Date:** 2026-04-05
**Context:** tsc v0.4.0 release, cnos v3.33.0 release

## What happened

- cnos PR #160 merged (installer hardening: checksum verification, redirect-based version detection)
- VERSION file in cnos was stale (3.32.0) after merge — RELEASE.md said 3.33.0 but VERSION wasn't bumped
- Compared versioning between cnos and tsc. cnos VERSION file approach is more coherent than tsc's prior pyproject.toml + dune-project dual-source
- tsc adopted VERSION-as-single-source pattern: dune build rule generates `build_version.ml` from VERSION file
- tsc gained `scripts/release.sh` — single command: bump, stamp, check, commit, tag, push
- cnos already had stamp-versions.sh + check-version-consistency.sh; tsc now mirrors this

## Dotenv loading (tsc v0.4.0)

- `engine/ocaml/bin/dotenv.ml`: loads `.tsc/.env`, env-wins precedence, permission warning if not 0600
- Credentials file is gitignored — must be created per-clone or use shell exports
- `.env` was initially created at repo root (wrong path); moved to `.tsc/.env` before any commit. Key never entered git history.

## cnos v3.33.0 — installer hardening

- Opened #161: self-update (`do_update` in `cn_agent.ml`) should verify SHA-256 like installer now does
- `cn_sha256.ml` already exists in repo — reuse for self-update checksum verification

## What to watch

- First cnos release with checksums.txt — verify it appears in GH release assets
- tsc release workflow has no checksum generation yet (follow cnos pattern when binary distribution matures)
- Self-update checksum verification (#161) is next hardening step
