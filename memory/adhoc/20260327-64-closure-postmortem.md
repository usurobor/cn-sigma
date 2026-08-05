# Post-mortem: #64 Closure (2026-03-27)

## Summary
P0 closure-by-verification took 3 review rounds, 2 PRs, and broke main.
All errors were mechanical and self-inflicted.

## Root causes
1. CDD §4.4 commit to main skipped `cn build` → CI broken
2. `write` tool introduced Unicode chars → GitHub bidi warning
3. `git add -A` on main staged file from wrong branch → leaked CLOSURE-64.md
4. GitHub caches bidi warnings across force-pushes → required fresh PR

## Fix
- #117 (pre-push gate) would have prevented the cascade
- Use heredoc for ASCII-critical files
- Explicit `git add <files>`, never `git add -A` on main
- Fresh PR + new branch name clears stale GitHub warnings

## Cost
~2 hours of avoidable round-trips.
