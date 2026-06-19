# Dist-Rebase Race (#266 → L7 MCA Candidate)

**Created:** 2026-04-24 (backfilled 2026-04-25)
**Issue:** #266
**Status:** Open — filed, not yet worked

## Problem

When dist/ was committed to git (pre-#266), concurrent PRs that both modify packages could race on rebase: each rebuilds tarballs against its own branch state, and the last merge wins. The loser's tarball changes silently disappear from main.

## Why L7

- Silent data loss (not a build failure — CI passes on each PR individually)
- Only detectable by comparing dist/ after merge, which nothing does
- Low frequency (requires two package-affecting PRs in flight simultaneously) but high consequence (shipped tarballs don't match source)

## Resolution path

#266 (PR #267, merged) removed committed dist/ entirely. Tarballs are now CI-only artifacts. This eliminates the race by removing the shared mutable state.

## Residual

- If dist/ is ever re-committed, the race returns
- cn pack / cn publish (#262 remaining ACs) should produce tarballs as ephemeral build artifacts, never committed
- .gitignore entry for dist/packages/*.tar.gz was added in #266

## Watch for

- Any proposal to commit build artifacts back to git
- cn publish design should treat tarballs as derived, not stored
