# Coherence CI Validates Itself

**Date:** 2026-04-10
**Trigger:** I1 failure on main after shipping eng/design-principles skill

## What happened

Shipped the design-principles skill (`d63d0ca`). Copied the file to `packages/cnos.eng/skills/eng/design-principles/` but forgot to add `eng/design-principles` to the `sources.skills` list in `packages/cnos.eng/cn.package.json`.

The coherence CI workflow (I1 — package/source drift) caught it. OCaml `cn build --check` detected the undeclared skill in the package directory. Telegram notification fired: "❌ Coherence failure: usurobor/cnos@main".

Fixed in `eccdd92` — one line in the manifest.

## Why this matters

1. **The CI caught what the human didn't.** The skill was about "one source of truth per fact" (§3.2) and immediately violated that principle by existing on disk but not in the manifest.

2. **The coherence workflow works end-to-end.** OCaml build → `cn build --check` → drift detection → CI failure → Telegram notification → fix. The full loop took minutes.

3. **Mechanical checks > human discipline.** This is the same lesson as the dispatch boundary CI check (#221/PR #222). When a constraint can be mechanicalized, it should be. Humans forget. CI doesn't.

4. **This validates the investment in I1.** The coherence workflow was built to catch exactly this class of error — source and packages drifting apart. First real catch on main (not a PR). It works.

## Pattern

Every time we add a new skill or sync content to packages, the manifest must be updated. This is a mechanical step that humans will occasionally forget. I1 exists to catch it. Today it did.

## Connection to design-principles skill

The skill's own §3.2 says: "If two places claim authority over the same fact, the design is already drifting." The manifest and the directory were two places claiming different things about what skills exist in cnos.eng. The CI caught the drift.

§1.3 names this failure mode: "authority drift — docs, runtime contract, help, doctor, and code disagree about what exists."

The tool enforced the principle before the principle's author did.
