# CDS README Status Drift — 2026-05-22

## Finding

After cycle/407, `cnos.cds` has a small entrypoint drift.

`src/packages/cnos.cds/skills/cds/CDS.md` has shipped, and `src/packages/cnos.cds/skills/cds/SKILL.md` now loads it as Step 1 and names it as the normative source for the CDS six-field contract.

But `src/packages/cnos.cds/README.md` still contains Sub-1-era status text:

```text
This package is a v0.1 skeleton. The doctrine surface (`CDS.md`) and the per-role overlays are forthcoming sub-deliverables of #403.
```

It also says the loader “does not call `CDS.md` yet” and that `CDS.md` is “Pending Sub 2.” That was true after #406. It is stale after #407.

## Classification

This is not a binding cycle failure.

Cycle/407’s implementation contract required `CDS.md` and the loader update. It explicitly did not require README status hygiene. The normative loader path is correct and the conflict rule says `CDS.md` governs.

The finding is a package-entrypoint coherence gap:

```text
normative state: CDS.md shipped and loaded
README state: CDS.md pending / not called yet
```

## Why it matters

The README is the first document many humans and agents will read when inspecting the package. If it says `CDS.md` is pending while the loader says `CDS.md` is shipped, activation and review paths will fork unnecessarily.

This is exactly the kind of small stale pointer that can erode the velocity gains from CCNF compression. The kernel and contract can be correct, but if entrypoints disagree, each cycle starts rechecking state instead of inheriting it.

## MCA recommendation

Do not reopen #407.

Patch the README in the next small status-hygiene cycle, or fold it into Sub 3 preflight before lifecycle migration begins.

Minimum patch:

```text
This package is a v0.1 skeleton. The doctrine surface (`CDS.md`) and the per-role overlays are forthcoming sub-deliverables of #403.
```

→

```text
This package is a v0.1 CDS package. `CDS.md` has shipped as the canonical six-field software instantiation contract. Per-role overlays and migrated lifecycle surfaces remain forthcoming sub-deliverables of #403.
```

```text
SKILL.md ... Does not call `CDS.md` yet (Sub 2 lands it).
```

→

```text
SKILL.md ... Loads `CDS.md` as Step 1; names forthcoming per-role overlays as advisory targets.
```

```text
CDS.md ... Pending Sub 2 of #403.
```

→

```text
CDS.md ... Shipped by #407 as the canonical six-field software instantiation contract.
```

Status section should also move from:

```text
v0.1 — package skeleton + extraction map.
```

to:

```text
v0.1 — package skeleton + extraction map + canonical CDS.md contract.
```

## Priority

P3 / hygiene, unless the next cycle uses README as its activation entrypoint. If Sub 3 loads from README first, promote to preflight fix.
