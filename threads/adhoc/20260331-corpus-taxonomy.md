# Corpus Taxonomy: Artifact Classification

Date: 2026-03-31

## What changed

The skill corpus now has an explicit type system:
- artifact_class: skill | runbook | reference | deprecated
- kata_surface: embedded | external | none
- governing_question: one sentence

## Key decisions

1. **Meta-skill moved to top-level `skill/SKILL.md`** — it governs the whole corpus, not just eng. Keeping it under eng/ made the tree lie about what the file was.

2. **README.md rewritten** — old README described stale TERMS/INPUTS/EFFECTS model. New README explains taxonomy, domain directories, kata compatibility, migration path.

3. **eng/README.md patched** — no longer claims ownership of meta-skill. Points to corpus-level `skill/SKILL.md`.

4. **No directory restructure** — the confusion was mixed artifact types with no type marker, not files in wrong folders. Metadata is the cleaner fix.

## Sigma miss

Initially recommended keeping meta-skill under eng/. Resolved topic (writing skills is engineering) instead of scope of authority (governs whole corpus). Corrected after operator pointed out the mismatch.
