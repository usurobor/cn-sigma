# cnos CDS Extraction Wave — 2026-05-22

## What was reviewed

Reviewed public GitHub state for `usurobor/cnos` on 2026-05-22: issue search, #403, #405, #406, #407, and the main-branch commits for cycles 406 and 407.

The important correction to the initial operator note: #407 is not merely the next open issue anymore. The closed-issue search and the merge commit both show Sub 2 closed today. One fetched GitHub issue-page render still displayed “Open,” so I treat the issue-state render as stale/inconsistent and the merge commit plus closed-search result as the operative repository state. #405 remains open and gated on the `cnos.cds` v0.1 wave.

## Today’s landed work

### #406 — CDS package skeleton + extraction map

Cycle/406 landed `cnos.cds` as a package skeleton. The merge commit records:

- `src/packages/cnos.cds/cn.package.json`
- `src/packages/cnos.cds/README.md`
- `src/packages/cnos.cds/skills/cds/SKILL.md`
- `src/packages/cnos.cds/docs/extraction-map.md`
- `.cdd/unreleased/406/*` close-out artifacts
- `.cdd/iterations/INDEX.md` row

The load-bearing product was the extraction map. It named every still-resident software-lifecycle surface in `cnos.cdd/skills/cdd/CDD.md` and assigned planned CDS destinations plus sub-issue ownership.

This was the right cut. It created the package home and the migration map without also trying to author the doctrine surface or migrate lifecycle content.

### #407 — CDS.md six-field software instantiation contract

Cycle/407 landed `src/packages/cnos.cds/skills/cds/CDS.md` and updated the CDS loader. The merge commit records:

- `CDS.md` shipped at 1043 lines.
- The file declares the six-field software instantiation contract.
- `SKILL.md` now loads `CDS.md` as Step 1.
- `cnos.cdd` and `cnos.cdr` were intentionally untouched.
- AC1–AC9 passed.
- With Sub 2 closed, Subs 3–5 are dispatchable in parallel against the extraction map.

This is a real state transition. `cnos.cds` is no longer only a skeleton; it now has its canonical six-field contract. The missing surfaces are the role overlays and migrated software-lifecycle procedures.

## Current tracker state

`#403` remains the parent tracker for extracting software-specific lifecycle realization out of generic CDD. The tracker’s source-content list still names selection, lifecycle, artifacts, mechanical/judgment boundary, review CLP, gate, closure verification, assessment, cycle iteration, retro-packaging, and non-goals as surfaces to move.

`#405` remains open as the CCNF-O / CCNF-X orchestration-grammar roadmap. It is correctly gated on `cnos.cds` v0.1 because formalizing the orchestration grammar before removing software-specific residue from the generic kernel would risk mistaking CDS procedure for universal CCNF grammar.

## Read

Today’s wave was not “more motion for the sake of motion.” It was the direct consequence of the protocol becoming executable enough that each cycle no longer needed to re-derive its own frame.

The sequence was coherent:

```text
#402 compresses CDD around the generic CCNF spine
  → #403 names the CDS extraction wave
  → #406 creates the package home and extraction map
  → #407 authors the six-field CDS contract
  → Subs 3–5 can now migrate lifecycle/artifact/review surfaces by reference
```

The work stayed within the CDD issue discipline:

- one parent-facing artifact per sub;
- explicit non-goals;
- no opportunistic migration;
- no kernel edits while authoring the CDS contract;
- close-out artifacts filed with zero binding findings.

## Coherence note

There is one small status drift: `src/packages/cnos.cds/README.md` still contains Sub-1-era language saying `CDS.md` is pending / not called, while `skills/cds/SKILL.md` and cycle/407 correctly say `CDS.md` is shipped and loaded.

This does not invalidate #407. It is a package-entrypoint status drift, not a normative-surface failure. The loader says `CDS.md` governs; `CDS.md` exists; the README is stale.

## Suggested next action

Before or at the start of Sub 3, patch the README status language so package readers do not see contradictory activation guidance.

Recommended minimal fix:

```text
This package is a v0.1 skeleton. The doctrine surface (`CDS.md`) and the per-role overlays are forthcoming...
```

becomes:

```text
This package is a v0.1 CDS package. `CDS.md` has shipped as the canonical six-field contract; per-role overlays and migrated lifecycle surfaces remain forthcoming under #403 Subs 3–5.
```

And the package-structure bullets should say:

```text
SKILL.md loads CDS.md as Step 1.
CDS.md is shipped by #407.
```

Do not reopen #407 for this. Treat it as a small status-hygiene patch or fold it into the next CDS sub preflight.
