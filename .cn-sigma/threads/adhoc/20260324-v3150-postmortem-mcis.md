# v3.15.0 Post-Mortem — MCIs

**Date:** 2026-03-24
**Source:** v3.15.0 post-release assessment by background agent + Sigma review

---

## MCI 1: Background agent coordination protocol

**Problem:** Background agent worked from stale base, touched files outside scope (design skill regression), introduced cram whitespace regressions, and had stale tag state in self-coherence report.

**Learning:** When a background agent implements a CDD branch:
- It must rebase onto current main before pushing (picks up concurrent changes)
- It must not modify files outside the issue's scope
- The implementing session and reviewing session share no state — reviewer must verify everything mechanically

**Status:** No skill covers multi-agent coordination yet. #100 (memory capability) partially addresses shared state. The CDD skill's §1.5 pre-flight partially addresses branch freshness. No skill addresses "don't touch files outside your scope."

## MCI 2: CI gate enforcement

**Problem:** PR #99 merged with I1 (package/source drift) failing. While I1 is a pre-existing issue (#58), merging a version-coherence PR with a version-adjacent CI check red is a claim/reality gap.

**Learning:** CDD should document: "Do not merge with red CI checks. If a check fails on a domain your PR touches, that is a blocking finding. If the check is known-broken (#58), document the exception explicitly in the PR."

**Status:** GitHub branch protection could enforce this mechanically. CDD skill could document the rule. Neither done yet. → Follow-up for #94 (CDD mechanization).

## MCI 3: Self-scoring vs independent assessment sequence

**Problem:** CHANGELOG TSC entry self-scored A/A/A/A before independent assessment scored A-/A/A-/B+.

**Learning:** Self-score is provisional. Assessment governs. Post-release skill now documents this (MCA done above).

**Status:** ✅ Captured in post-release skill.

## MCI 4: Tag naming inconsistency

**Problem:** v3.12.2 and earlier use `v` prefix. 3.14.7+ use bare version. Mixed conventions break tooling assumptions.

**Learning:** Pick one convention and enforce it. Current state: both exist. The `v` prefix convention is more common in the git ecosystem.

**Status:** Not resolved. Need to decide and standardize. Low priority — cosmetic, doesn't break functionality.

## MCI 5: @-parsing duplication

**Problem:** `Filename.basename pkg_path` → split on `@` → extract version appears in 4 places: cn_runtime_contract.ml, cn_system.ml (update_runtime, run_status, run_doctor).

**Learning:** Extract to a helper like `parse_pkg_dir_version : string -> (string * string) option`. Single implementation, 4 call sites.

**Status:** Not addressed. Follow-up for #58 or next code-touching PR.

## MCI 6: `third_party_rev` unconditional network call

**Problem:** `lockfile_for_manifest` always runs `git ls-remote` for third-party rev even when all deps are first-party. Dead code that adds latency and failure surface.

**Learning:** Guard with `if List.exists (fun d -> not (is_first_party d.name)) manifest.packages`.

**Status:** Not addressed. Low priority — all current packages are first-party.

## MCI 7: MCI freeze discipline

**Problem:** Post-release assessment notes #94, #100, #96 were opened with detailed designs during MCI freeze. Filing issues is lighter than implementation, but detailed multi-phase architecture specs (#100) constitute MCI activity.

**Learning:** MCI freeze means: no new design work. Filing bare gap-identification issues is fine. Writing detailed multi-section design specs in the issue body is MCI activity and should be deferred or marked as draft/provisional.

**Status:** Not resolved. The freeze is still active. The designs exist. Pragmatically, this is about discipline awareness, not rollback.
