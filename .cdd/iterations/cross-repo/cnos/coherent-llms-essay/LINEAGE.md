# Cross-Repo Lineage: cn-sigma → cnos (coherent-llms-essay)

## Source

- **Repo:** `usurobor/cn-sigma`
- **Branch:** `main` (per operator preference established with `agent-activate-skill` and `activate-foreign-body` bundles; full source proposal carried on cn-sigma main rather than on a branch)
- **Authoring commit:** filled at filing (cn-sigma main HEAD when this bundle lands)
- **Path:** `.cdd/iterations/cross-repo/cnos/coherent-llms-essay/`
- **Source posture:** cn-sigma is an agent hub, not a fully CDD-activated tenant repo. This is the fourth cross-repo bundle from cn-sigma (after `agent-activate-skill` (LANDED cnos 3.78.0), `activate-foreign-body` (drafted), and observed sibling bundles `agent-gh-deployment`, `coherence-audit-request`, `release-3.82.0-hygiene`).

## Upstream — what drives this proposal

The essay is operator-authored (fresh writing, delivered to κ at cn-sigma via the 2026-07-03 session that also captured six sibling doctrine adhocs today plus a batch of retro-backfills for earlier events). κ's role per cnos#501 is `record` and `translate`; this bundle records the essay verbatim and translates its target-placement per the cnos paper-family convention.

The essay synthesizes doctrine that already lives at cnos:
- **TSC** as a measurement theory for α (pattern), β (relation), γ (process) coherence.
- **cnos** as the durable, receipted work-body that gives coherence measurements somewhere to live.
- **"Dumb Models, Smart Cells" (v0.8.0)** as the substrate framing this essay extends into an operational proposal for LLM systems.

The synthesis reads as a doctrinal center for today's other cn-sigma adhocs:
- `20260703-typed-skill-modules.md` — the article's coherence loop instrument is expressed via typed skill modules (SKILL.md frontmatter contract + CUE + fixtures).
- `20260703-kappa-role-canonicalization.md` — the article's §6 ("bounded reasoning body operating inside a coherence-preserving work body") is the κ role verbatim.
- `20260626-cycle497-model-b-and-kappa-emergence.md` — the article's §7 coherence loop (commit-with-receipt or refuse-to-commit) MAPS onto cycle/497 R1 recovery: `degraded_recovery: human_interface_applied_operator_patch` is exactly the "commit with a receipt that records the risk" clause.
- `20260703-discipline-failures-become-typed-gates.md` — the article's §10 ("the LLM must not be the sole authority") sharpens the typed-gates principle.

- **Primary upstream source:** operator direct authorship in cn-sigma session, 2026-07-03.
- **Bilateral mirror (cn-sigma-side):** full-essay adhoc at `cn-sigma:.cn-sigma/threads/adhoc/20260703-coherent-llms-essay.md` (companion; essay body verbatim + framing wrapper, matching the doorway-essay-adhoc precedent).

## Target

- **Repo:** `usurobor/cnos`
- **Issue:** to be filed; assign cycle number on intake
- **Mode:** `docs-only` (per ISSUE.md mode declaration)
- **Title (proposed):** "cnos essay proposal: Coherent LLMs — Measuring Whether Generation Still Belongs to the Whole"
- **Labels (proposed):** `docs`, `P2`, `area/essays`
- **Disposition:** pending (filled at acceptance by cnos γ)
- **Canonical target path on cnos:** `cnos:docs/papers/COHERENT-LLMS.md`

## Why a bundle, not just a channel directive-out

Per cn-sigma adhoc `20260703-cross-repo-bundle-pattern.md` (this session): substantive cross-repo proposals with multi-paragraph bodies belong in bundle form. This essay is exactly that shape — 5000+ words of publication-grade content that must be filed verbatim and evolve at the target repo. Channel directive-out is reserved for lightweight signals; this is not lightweight.

Per cnos `CDD.md §5.3` cross-repo trace row + the precedent established by `agent-activate-skill` (cnos 3.78.0 cycle). The bundle carries (a) the essay body ready for filing, (b) bilateral trace, (c) source-side STATUS ledger for the proposal lifecycle. Without the bundle, the essay would live only inside a channel entry, which is transient by comparison.

## Bilateral trace

When cnos accepts this proposal:
- cnos-side mirror expected at `cnos:.cdd/iterations/cross-repo/cn-sigma/coherent-llms-essay/`.
- cn-sigma-side STATUS advances via the ledger: `drafted` → `submitted` → `accepted`/`modified`/`rejected` → `landed`.
- Companion cn-sigma adhoc `20260703-coherent-llms-essay-captured.md` records the local capture event; it does not evolve; the essay evolves at cnos.

## Coherence-check on placement (per the essay's own loop)

The essay's Section 7 loop applied to this bundle's placement:

- **Declared whole:** cn-sigma memory + cnos public-doctrine surface + the essay-family that already sits at cnos:docs/papers/.
- **Candidate:** bundle for cnos:docs/papers/COHERENT-LLMS.md + small cn-sigma marker adhoc.
- **α (pattern):** stable — bundle shape follows precedent; essay-genre matches cnos:docs/papers/ convention.
- **β (relation):** strong — bundle points at cnos target; small cn-sigma marker preserves inbound reference from cn-sigma memory to essay's canonical home.
- **γ (process):** strong — essay evolves at cnos with paper-family versioning (v0.8.0-shape maturation) rather than freezing in adhoc form.
- **Bottleneck:** none blocking. Weakest axis is β on external readership discovery until essay is published beyond cnos, which is a separate operator decision.
- **Commit-with-receipt:** the bundle IS the receipt. STATUS advances at each lifecycle event; LINEAGE.md provides the trace; cn-sigma marker adhoc provides the local record.

The placement satisfies the essay's own coherence criteria. That is the intended demonstration.
