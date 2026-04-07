# Package Artifact Distribution — Design Thread

**Date:** 2026-04-07
**Issue:** #167
**Branch:** claude/167-package-artifacts
**Status:** design complete, implementation handed to Claude Code

## What happened

Axiom and I traced #155 (cn deps restore fails in restricted git environments) to its root cause: git is being used as a package distribution mechanism when what we need is artifact delivery. The shallow-fetch-by-SHA failure in Claude Code's sandbox was a symptom — the real problem is that `cn deps restore` couples package installation to git protocol capabilities.

We walked through the full reasoning:
1. `cn deps restore` fetches a git commit and copies a subtree — that's repo transport, not package distribution
2. The fix we shipped for #155 (fallback to full clone) patches the symptom but doesn't fix the architecture
3. The right model is NuGet-style: package is a tarball, index resolves name+version to URL+SHA-256, restore is HTTP download + verify + extract

Along the way, Axiom connected this to #162 (modular CLI commands). If packages are the distribution unit, commands should be a content class inside packages — not a separate plugin system. This unifies both issues.

## Key design decisions

1. **Artifact-first distribution** — released packages are versioned tarballs fetched over HTTPS. No git in the normal restore path.
2. **Commands as a first-class package content class** — joins doctrine/mindsets/skills/extensions/templates. Explicit in `cn.package.json`, not smuggled into a generic tree.
3. **Runtime extensions stay separate** — runtime capability providers (cnos.net.http) ≠ package commands (cn daily) ≠ cognitive substrate (skills/doctrine).
4. **No migration complexity** — one hub exists (sigma). Clean cut: ship new restore, regenerate lockfile, delete git fetch code.

## What changed (MCA)

- Design doc: `docs/alpha/package-system/PACKAGE-ARTIFACTS.md` v0.2.0
- Issue: #167 filed with full ACs
- Branch: `claude/167-package-artifacts` with design doc committed
- Parked v3.34.0 release — shipping #167 first avoids releasing #155 git fixes that immediately get deleted

## What to watch for

- The design says "no new runtime dependencies" for HTTP fetch — OCaml's Unix module doesn't have HTTP. Implementation will likely shell out to curl/wget. That's fine but should be documented.
- Package index lives at `packages/index.json` in repo, fetchable via raw GitHub URL. If GitHub raw URLs become unreliable, need a fallback. Known debt, not a blocker.
- The `commands` content class shape in `cn.package.json` differs from other classes (object with entrypoint+summary vs. array of strings). That's intentional — commands need metadata — but review should verify it doesn't break existing manifest parsing.
- Embedding cnos.core in binary was considered and rejected. Correct decision: if the transport is fixed, all packages distribute the same way. Don't special-case.
