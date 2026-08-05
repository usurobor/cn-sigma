# dist/ Decision & Post-Restructure Structural Gaps

**Date:** 2026-04-12
**Trigger:** Operator review of repo alignment with package-first design after 20260411-c restructure

## dist/ decision

**Decision: dist/ is derived build output only. Gitignored intentionally. No tracked stub.**

The pipeline is:
```
src/packages/ → cn build → dist/packages/ → cn deps restore → .cn/vendor/packages/
```

- `dist/packages/` holds assembled tarballs — not source, not checked in
- `FindIndexPath` resolves `dist/packages/index.json`
- This was implicit from the gitignore and BUILD-AND-DIST.md design, but never recorded as an explicit decision until now
- If the docs say "dist/ built output" they mean build convention, not tracked structural layer

**Rejected alternative:** tracked stub/README in dist/ for visibility. Not worth it — the docs describe the layer, the build creates it, inspecting main should show source not artifacts.

## Four residual gaps (structural alignment done, behavioral alignment pending)

### Gap 1: Package command discovery + dispatch not landed
- Phase 4 in the roadmap. README explicitly lists it under "what's not here yet"
- Package manifests already declare commands, but Go kernel doesn't scan/dispatch them
- **This is the biggest missing behavioral piece**
- Tracked: implicit in Phase 4 roadmap, partially in #182 umbrella

### Gap 2: Runtime contract behind package/runtime design
- RUNTIME-CONTRACT-v2 exposes `installed_packages` and `active_overrides` under cognition, `capabilities` and `peers` under body
- Does NOT yet expose: activation_index, command registry, orchestrator registry, provider registry/health
- The repo structure is ahead of the runtime self-model

### Gap 3: cnos.core not yet lean
- Package split is real (cnos.core, cnos.cdd, cnos.eng separated)
- But cnos.core still carries many agent/* skills, all ops/* skills, and commands like daily/weekly/save
- Long-term "core must be lean" design only partially realized
- Not a structure contradiction — design lag

### Gap 4: cn build doesn't produce dist/ yet
- 20260411-c notes: "cn build needs updating to read from src/packages/ (currently still has old paths in Go code)"
- No working build → no dist/ → no tarballs → no artifact-based restore
- The entire artifact-first distribution design (#167) is structurally prepared but not yet functional
- dist/ is gitignored by design (derived output, not source) — that part is correct
- **The gap is that the pipeline that creates dist/ doesn't work yet, not that dist/ should be tracked**

## Assessment

**Structurally aligned. Not yet behaviorally complete.**

The repo structure now matches the package-first / Go-kernel design. The remaining gaps are runtime-behavior gaps: the build/distribution pipeline, command discovery/dispatch, richer runtime registries, and further core slimming.

## Priority order for closing gaps — ALL CLOSED
1. ~~cn build → dist/ pipeline (Gap 4)~~ — **v3.51.0** (#227)
2. ~~Command discovery + dispatch (Gap 1)~~ — **v3.52.0** (#226)
3. ~~Runtime contract update (Gap 2)~~ — **v3.53.0** (#233)
4. Core slimming (Gap 3) — incremental, post-MVA

## Sprint issue

**#228 — Minimal Viable Agent (MVA)** — umbrella that sequences gaps 1, 2, 4 into a critical path:
`cn build → dist/ → cn deps restore → command discovery → runtime contract`

## Provenance
- Package artifact design: `threads/adhoc/20260407-package-artifact-design.md`
- Restructure session: `threads/reflections/daily/20260411-c.md`
- Pipeline + issue #224: `threads/reflections/daily/20260410-m.md`
- Modular refactor direction: `threads/adhoc/20260408-modular-refactor-direction.md`
