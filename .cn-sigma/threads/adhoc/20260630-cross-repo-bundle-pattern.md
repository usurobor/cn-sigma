# Cross-repo bundle pattern — κ→worker canonical artifact form

**Date:** 2026-06-30 (recognition; bundles authored earlier — agent-activate-skill 2026-05, activate-foreign-body 2026-06-05)
**Class:** doctrine-evolution (artifact-shape recognition)
**Author:** Sigma at cn-sigma (κ-body)
**Source:** Inspection of `.cdd/iterations/cross-repo/cnos/activate-foreign-body/` during catch-up audit. Operator's κ-sharpening earlier today ("κ creates issues; workers articulate everything else") forced the recognition: there is already a canonical κ→worker artifact form at cn-sigma, and I had not been using it.

## Why this is captured here

The κ-sharpening rule said κ writes only issues. The objection raised at the time — "no foreign-issue-create command exists" — assumed channel directive-out was the only option. **That objection is wrong.** A canonical artifact form already exists for κ-shaped cross-repo work: the cross-repo bundle at `.cdd/iterations/cross-repo/<target-repo>/<slug>/`.

This adhoc names the pattern so future κ at cn-sigma uses it by default for substantive cross-repo work, and reserves channel directive-out for lighter-weight signals.

## The pattern (per existing precedent)

Directory shape:

```
cn-sigma:.cdd/iterations/cross-repo/<target-repo>/<slug>/
  ISSUE.md      # Full issue body, ready for filing at target repo
  STATUS        # Event ledger: drafted → submitted → accepted → modified → landed
  LINEAGE.md    # Bilateral trace: source, target, upstream gap-analysis path, peer-branch precedents
```

Lifecycle (per cnos `CDD.md §5.3` cross-repo trace + cnos `cdd/gamma/SKILL.md` close-out):

1. **drafted** — κ writes `ISSUE.md` + `STATUS` + `LINEAGE.md` directly on cn-sigma main. No branch.
2. **submitted** — operator (or κ via authorized mechanism) files the issue at target repo using ISSUE.md verbatim; STATUS appended with the issue number.
3. **accepted/modified/rejected** — target repo γ disposes; STATUS appended.
4. **landed** — target repo merges the cycle; STATUS appended; bilateral mirror at target repo `.cdd/iterations/cross-repo/<source-repo>/<slug>/` carries the target-side history.

Author posture (per LINEAGE.md of activate-foreign-body bundle):

> cn-sigma is an agent hub, not a fully CDD-activated tenant repo. ... full source proposal carried on cn-sigma main rather than on a dormant branch.

Same main-only convention I just adopted today. The bundles were already authored under it.

## Existing bundles

| Bundle | Slug | Status | Notes |
|---|---|---|---|
| agent-activate-skill | `cn-sigma:.cdd/iterations/cross-repo/cnos/agent-activate-skill/` | LANDED | Shipped as cnos 3.78.0 |
| activate-foreign-body | `cn-sigma:.cdd/iterations/cross-repo/cnos/activate-foreign-body/` | drafted (open) | Awaiting cnos γ intake; pending operator authorization. Three-gap design for agent/activate SKILL.md amendments. Authored 2026-06-05 by Sigma-at-cph; bundle deposited at `77b5d59`. |

## Why this is the right shape for κ

Per cnos#501 κ may *record*; per the κ-sharpening rule κ writes only issues. The bundle satisfies both:

- **Records the issue body** in `ISSUE.md` — durable, citable, version-controlled.
- **Is the issue artifact** — when filed at target, ISSUE.md becomes the issue body verbatim. The bundle authoring IS the issue creation work, just packaged for handoff.
- **Carries bilateral trace** — LINEAGE.md gives the target γ the source-side gap-analysis without losing context. STATUS gives the source side a place to record disposition.
- **Avoids inline-overstep** — κ does not implement, route, or close at the target. κ proposes; target γ disposes.

Compare to today's pattern (channel directive-out → cnos channel entry → Sigma-at-cnos files via cnos/issue skill):

| Aspect | Bundle | Directive-out |
|---|---|---|
| Where κ writes | `cn-sigma:.cdd/iterations/cross-repo/<target>/<slug>/` | `cn-sigma:.cn-sigma/threads/activations/<target>/YYYYMMDD.md` |
| Durability | Three files, versioned, dedicated home | Single channel entry, mixed with daily syncs |
| STATUS ledger | Yes (drafted → ... → landed) | No |
| Bilateral mirror | Standardized at target | Ad hoc |
| Suited for | Substantive issue proposals | Lightweight directives, cross-repo signals |

Today's agent-memory-wakes directive-out was a heavyweight issue dressed as a directive. It should have been a bundle.

## Correction for the agent-memory-wakes work

The directive-out filed at 19:00Z (`.cn-sigma/threads/activations/cnos/20260630.md`) carries the issue body. The right shape is:

1. Create `cn-sigma:.cdd/iterations/cross-repo/cnos/agent-memory-wakes/` with ISSUE.md (the body verbatim from the directive), STATUS ledger, LINEAGE.md.
2. Update the directive-out entry to point at the bundle rather than embedding the issue body inline.
3. Sigma-at-cnos still files the issue via cnos/issue skill on her next wake; the body is now sourced from the bundle's ISSUE.md (canonical) rather than the channel entry (transient).

Alternatively: leave the channel entry as the file-this-issue directive (light signal), but author the bundle at the same time so the durable artifact exists. Lower-priority cleanup; the issue gets filed either way.

## Forward direction

- **Default for substantive cross-repo work:** bundle.
- **Default for lightweight signals:** directive-out channel entry.
- **Boundary heuristic:** if the cross-repo write is "file this issue" with a multi-paragraph body, it's bundle-shaped. If it's "execute this small operation" or "ack this state," it's directive-out-shaped.
- **Migrate agent-memory-wakes to bundle form** when the κ-CDD-preflight or similar mechanical gate exists to drive this kind of structural cleanup. Until then, the channel entry suffices (Sigma-at-cnos picks it up; issue gets filed).

## Related artifacts

- **cn-sigma:.cdd/iterations/cross-repo/cnos/agent-activate-skill/** — first bundle precedent (LANDED as cnos 3.78.0).
- **cn-sigma:.cdd/iterations/cross-repo/cnos/activate-foreign-body/** — second bundle (drafted; awaiting intake).
- **cn-sigma:.cn-sigma/threads/activations/cnos/20260630.md** — agent-memory-wakes directive-out (the form that should have been a bundle).
- **cn-sigma:.cn-sigma/threads/adhoc/20260630-kappa-role-canonicalization.md** — κ's authorized actions, including record-by-issue-creation.
- **cnos:CDD.md §5.3** — cross-repo trace specification.
- **cnos:cdd/gamma/SKILL.md** — cross-repo proposal close-out lifecycle.
