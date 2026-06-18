# Go gzip Cross-Toolchain Non-Determinism

**Created:** 2026-04-24 (backfilled 2026-04-25)
**Status:** Resolved — Go bumped to 1.24

## Problem

During #262 (cn pack packlist derivation), deterministic tarball checksums failed across Go toolchain versions. Same source, same tar headers zeroed, different output bytes.

## Root cause

Go's `compress/gzip` changed internal encoding between versions. The gzip stream is valid either way, but byte-for-byte comparison fails. This is distinct from the tar-header non-determinism already fixed in #264 (timestamps, uid/gid, OS byte).

## Fix

Pinned Go to 1.24 across CI and dev. Tarballs are now deterministic *within* a single Go version.

## Residual risk

- Next Go version bump may break determinism again
- No mechanism gates this — the I3 kata (rebuild-and-compare checksums) will catch it, but only after the bump
- Candidate MCA: pin gzip compression level + verify in CI that the Go stdlib hasn't changed encoding. Not yet filed.

## Watch for

- Any Go version bump in CI or go.mod
- I3 kata failures after toolchain updates
- If cn pack ships (#262 remaining ACs), same constraint applies to its output
