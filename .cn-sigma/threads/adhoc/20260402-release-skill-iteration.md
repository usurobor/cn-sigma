# Release Skill — Two Iterations in One Day

## What happened

3.29.0 was released with auto-generated release notes (just PR titles). Operator flagged this. Two iterations followed:

1. **RELEASE.md step** — added §2.5 requiring RELEASE.md before tagging, with Fixed/Added/Changed/Removed/Validation/Known Issues format. §3.7 mechanical gate: no tag without RELEASE.md.

2. **Outcome preamble** — operator pointed out notes were "change-loggy, not coherence-framed." Updated format to require Outcome (coherence delta + TSC grades) + Why it matters (targeted incoherence, before/after) before the mechanical sections.

## Key insight

"Release = measured coherence delta" was already the core principle of the skill. But the release notes format didn't reflect it — they jumped straight into changes. The format should foreground what got more coherent, then detail how.

## Current format

1. Outcome (coherence delta, TSC grades from ledger)
2. Why it matters (targeted incoherence, before/after)
3. Fixed / Added / Changed / Removed
4. Validation (framed as proof of the delta)
5. Known Issues

## What validated it

3.29.1 was the first release using the full format including RELEASE.md consumed by CI. "Create release (with notes)" ✓ in the CI log — the workflow picked up RELEASE.md correctly.
