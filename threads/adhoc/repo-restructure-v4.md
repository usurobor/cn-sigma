# Repo Restructure for v4

**Status:** Complete (structure), In Progress (tooling)
**Date:** 2026-04-11
**Trigger:** OCaml cessation → README rewrite → cascading cleanup

## What changed

The cnos repo layout was a hybrid of the old OCaml-era flat structure and the Go migration. One session of "is this right?" questions from the operator exposed every seam. The result is a clean `src/` → `dist/` model that matches the design docs.

### Before
```
cnos/
  go/                  Go CLI (sibling of src — confusing)
  src/agent/           Flat cognitive content
  src/cli,cmd,lib,...  OCaml source (6 dirs, no grouping)
  packages/            Intermediate build output (duplicated from src/agent/)
  profiles/            Two identical JSON files
  spec/                Stale template copies
```

### After
```
cnos/
  src/
    go/                Go CLI
    packages/          Cognitive content per-package (cnos.core, cnos.cdd, cnos.eng)
    ocaml/             Ceased reference implementation
  dist/                Built output (tarballs, binaries, index)
```

## Key decisions

1. **YAGNI over roadmap signaling** — empty placeholder packages (cnos.agent, cnos.hub, cnos.net.http) deleted. Design docs capture the intent. The repo only contains what exists.

2. **Co-located content** — skills, doctrine, mindsets live inside their package dir alongside `cn.package.json`. No copy step, no `sources` field, no drift. Content classes discovered by directory presence.

3. **Exposed/internal skill split** — manifests declare `skills.exposed` and `skills.internal`. CDD is the first real orchestrator pattern: 1 exposed skill delegates to 6 internal sub-skills.

4. **Triggers everywhere** — all 47 skills declare activation triggers in frontmatter. The activation table is derivable from installed packages with zero configuration.

5. **OCaml as reference** — grouped under `src/ocaml/`, explicitly labeled "ceased." It's the specification the Go runtime implements against.

## What's not done

- `cn build` Go code still has old path assumptions (needs update for `src/packages/`)
- `cn setup` hardcodes "engineer" profile (profiles deleted, setup needs simplification)
- Activation table scanner not implemented in Go
- `dist/` not in `.gitignore` yet

## Watch for

- CI should pass — all workflow paths updated, all Go tests pass locally
- Any doc that references `src/agent/` outside of historical CDD notes needs updating
- The `cn build --check` coherence invariant needs rework for new layout
