---
title: External review of the GH-deployment bundle — α≠β firebreak working
date: 2026-05-27
status: adhoc
scope: review-correction
---

# External review of the agent-gh-deployment bundle

**Trigger:** Operator routed the `BRIEF.md` + `ISSUE.md` to a third party (the external review the brief was written to invite). Verdict: accept directionally, file into cnos with seven precision edits. This is a review-correction worth capturing per PERSONA §Memory discipline (a finding was caught that I missed), and a clean validation of the α≠β firebreak.

## The load-bearing lesson: the firebreak worked

The reviewer — with **no authoring stake** — caught a real error I had **glossed because I authored it**: I described the wake as `cn sync → process → cn agent`, a fixed sequence. Verified against `cnos:docs/beta/guides/AUTOMATION.md`: `cn agent` (oneshot) is *itself* a full maintenance cycle + bounded queue drain — it already includes maintenance. So `cn sync && cn agent` would double-sync. `cn sync` is the transport-only tick; `cn agent` is the full reasoning wake; the runner runs one or the other.

This is exactly the α≠β structure from CFA / CELL-OF-CELLS §5: a producer reviewing its own matter is immunologically compromised. I had deep authoring stake across this whole arc; the conflation was invisible to me and obvious to a fresh reader. **This is why the brief invited external review and why I excluded myself as auditor on the coherence-audit charter.** The firebreak is not ceremony — it caught a concrete error before it shipped into cnos.

## Verified before incorporating

Before rewriting based on the reviewer's claim, I checked the primary source (`AUTOMATION.md`) rather than accepting the secondary characterization — the probe-before-assert discipline from `20260519-git-read-and-untested-limits.md`, applied correctly this time. The reviewer's `cn sync`/`cn agent` claim was confirmed: `cn agent` oneshot = "one full maintenance cycle + bounded queue drain" (`maintain_once` → `drain_queue` → `process_one` → exit). So the edit is grounded in cnos source, not just the reviewer's word.

## The seven edits (all incorporated)

1. **`cn sync` vs `cn agent`** — transport tick vs full oneshot wake; no fixed sequence; Sub D owns the command. Sub D renamed.
2. **Stub vs full-fidelity** — Sub A/C may ship stub/transport wake now; may not claim full agent wake until Sub D ships the Go `cn agent` oneshot. Explicit in constraint + both subs.
3. **Scheduled-workflow liveness** — public dormant repos get schedules auto-disabled (~60 days); need `workflow_dispatch`; liveness is part of the field test. *This is the verify-don't-assert item I flagged in `20260519-git-read-and-untested-limits.md` — the reviewer confirmed it from GitHub docs; my earlier "active repo keeps the schedule alive" correction was right but the brief had drifted back to overconfidence.*
4. **6-field receipt explicit in ACs** — AC3 lists all six fields, not just a pointer.
5. **Auth separation** — `GITHUB_TOKEN` (own-repo write only) vs model key (model call only); no peer-write in base case.
6. **"repo is the agent" framing** — precise first ("hub repo stores durable continuity"), slogan second ("repo at rest / runner awake"). Matches AGENT-CONTINUITY's actual framing.
7. **Sub A → Sub C ordering** — Sub A ships stub workflow first; Sub C adopts/replaces as canonical. Avoids the A→C→D circular stall.

Plus: add `handoff` label (deployment/handoff transport, not only core activation). Disposition: file into cnos as a P2 tracker; sub-dispatch waits for operator authorization under the pause.

## What the review confirms about the bundle

The reviewer validated the core: durable continuity in Git, activation-not-deployment, GitHub Actions as ephemeral compute, read-peers/write-self, the three deployment paths, the runtime gap named honestly. The edits are precision, not redirection — the shape was right.

## Memory note

Two patterns this session, now both demonstrated end-to-end:
- **The anti-pattern** (authoring-stake blindness): I glossed the `cn sync`/`cn agent` conflation. Only an external reader caught it.
- **The mitigation** (firebreak + verify): external review surfaced it; I verified against primary source before incorporating; the edit is grounded.

This is the agent-doctrine working as designed (CFA inspectable boundary + EFA repair-as-substitute-inspectability). The bundle is stronger for having been reviewed by someone with no stake in it. Future cross-repo proposals of consequence should invite external review *before* filing, not after — the firebreak is cheap and catches what authoring stake hides.

Bundle updated in place (BRIEF.md, ISSUE.md, LINEAGE.md "External review" section, STATUS `reviewed-external` event). Still operator-gated; pause holds; sub-dispatch awaits authorization.
