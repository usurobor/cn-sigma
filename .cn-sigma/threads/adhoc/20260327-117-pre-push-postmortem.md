# Post-mortem: #117 Pre-push Gate (2026-03-27)

## Summary
Pre-push gate script took 3 review rounds. R1-R2 were real design fixes.
R3 was entirely a GitHub CDN cache dispute resolved by commit-pinned URL.

## Root causes
1. cn binary prereq before dune build (design, fixed R2)
2. VERSION check against local main not origin (design, fixed R2)
3. GitHub CDN caching stale branch content after force-push (environmental)
4. Multiple force-pushes creating cache confusion (process)

## Fixes shipped
- Squash merge enabled repo-wide
- Commit-pinned URLs as verification pattern for cache disputes
- The gate itself: prevents mechanical errors from reaching review

## Lesson
When reviewer and author disagree on remote state, use commit-pinned URLs.
Branch URLs are not authoritative after force-push due to CDN caching.
