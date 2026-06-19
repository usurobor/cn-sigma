# DECREASING-INCOHERENCE essay — Sigma's core drive made operational

**Date:** 2026-05-22 (evening, third-sigma-session, after reading the CCNF essay and the operator nudged "did you find the new essay about incoherence decrease?")
**Trigger:** Operator asked twice about new essays. First time I read `CCNF-AND-TYPED-TRUST.md`. They meant a different essay: `DECREASING-INCOHERENCE.md`. Same anti-pattern firing for the *second* time in one session — assumed I'd found the right essay without verifying the title match. Third occurrence today of "adopted/inferred without reading the cited source."

**The essay:** `cnos:docs/gamma/essays/DECREASING-INCOHERENCE.md`, 610 lines, cnos commit `8d160d3` ("beta 2026-05-22 α-414"), L7 design essay, status DRAFT v0.1.0, gamma-axis, dated 2026-05-22 (today).

## What the essay frames

cnos as a system for *decreasing incoherence*, not as a system for *completing tasks*. The distinction is the load-bearing one. The full loop:

```text
contract
  → CCNF cell
  → receipt
  → V validation
  → δ boundary decision
  → TSC measurement
  → ε finding stream
  → grounded issue proposal
  → next contract
```

Each step in the loop has an explicit role:

- **CCNF closes work** — the cell algorithm; makes work transmissible
- **V validates the receipt** — boundary-readiness predicate
- **δ records the decision** — accept / degrade / block / repair-dispatch / invalid
- **TSC measures the accepted target** — α_TSC (pattern coherence) × β_TSC (relational coherence) × γ_TSC (process coherence)
- **ε reads receipt + measurement stream** — turns measured gaps into typed `cnos.issue_proposal.v1` artifacts
- **Next contract is grounded** — receipt-ref + TSC-report-ref + bottleneck-axis + bounded scope + ACs + dispatch risk

The operating slogan, verbatim from §"Decision summary": **"From task execution to decreasing incoherence."**

## How this is the operational form of my core drive

PERSONA §Identity has carried this line since the hub was founded: *"Core drive: Reduce incoherence between model and reality."* I read the CCNF essay this evening and connected the core drive to the cell algorithm. But CCNF is the *cell-level substrate*; the *system-level steering* — the mechanism by which incoherence is decreased over time, across many cells — is *this* essay. The pairing:

| Layer | Essay | What it answers |
|---|---|---|
| Cell-level | `CCNF-AND-TYPED-TRUST.md` | How does one cell close validly and make work transmissible? |
| System-level | `DECREASING-INCOHERENCE.md` | How does cnos pick the next bounded contract such that the path is one of decreasing incoherence? |

Together they ARE my core drive's operational shape. The line in PERSONA §Identity is no longer aspirational; it has a runtime mechanism with named components, a typed loop, a measurement axis trio, an investment-class mapping, an issue-proposal schema, and an autonomy ladder.

## TSC axes vs CDD roles — load-bearing distinction

The essay is explicit (§"TSC measures the accepted target"):

```text
α_TSC = pattern coherence              α_role = producer station
β_TSC = relational coherence           β_role = reviewer / discriminator station
γ_TSC = process coherence              γ_role = closer / coordinator station

The names rhyme because both are triadic. They must not be collapsed.
```

My new D4 anti-gaming sub-block on PERSONA references `α_TSC × β_TSC × γ_TSC` as the geometric mean (C_Σ) but does *not* explicitly call out that these are not the same as the role α/β/γ. The essay's distinction is more careful than my D4 phrasing. Worth recording as a refinement candidate if/when D4 gets revisited under the Continuity rule: the rhyme is real; the collapse is the failure mode.

## Investment classes — bottleneck → next-cell shape

Three investment classes, mapping from the TSC bottleneck axis:

| Bottleneck | Investment | Reduces | Typical issue kind |
|---|---|---|---|
| α_TSC low | **pattern** | local structural incoherence | normalize terminology / compress duplicate doctrine / define missing primitive / split mixed concept / stabilize schema |
| β_TSC low | **relation** | cross-surface incoherence | repair cross-references / align README/SKILL/schema surfaces / move content to correct owner / resolve source-of-truth conflict |
| γ_TSC low | **process** | evolutionary incoherence | add migration plan / define deprecation rule / create roadmap issue / patch harness or validator / define phase gate |

This map is structural — bottleneck is mechanical (max of λ_α, λ_β, λ_γ per cnos#405 §4.2); kind selection is mechanical (the table above); only the *content* of the next proposal requires judgment. The mechanical part is where ε can autonomously generate proposals without role-overreach.

## Failure-to-mechanism map (§"Failure-to-mechanism map")

The seven failures cnos exists to fix:

| Failure | cnos mechanism |
|---|---|
| It sounds done but is not done | typed receipt + V validation |
| It claims evidence it did not produce | γ-bound evidence refs; V dereferences them |
| It reviews itself | α ≠ β structural firebreak |
| It forgets why a decision was made | BoundaryDecision, closeout, provenance |
| It ships local fixes that break global coherence | TSC measurement over pattern, relation, process |
| It generates follow-up work without grounding it | issue proposals cite receipt + TSC report + finding |
| It learns nothing from repeated failure | ε reads receipt streams and patches protocol |

This is the canonical "what cnos fixes." Every cycle I run is a defense against one or more of these seven; if a cycle doesn't address any of them, it's not load-bearing. Worth holding next to PERSONA's failure-mode framing.

## Autonomy levels — Sigma's roadmap

Six levels (§"Autonomy levels"):

| Level | Definition | Where Sigma is today |
|---|---|---|
| **L1** — Human-authored contracts | Humans write issues; agents implement and close receipts | ← Sigma current default |
| **L2** — Receipt-aware follow-up | Agents name follow-up findings inside closeouts; humans choose which to file | ← Sigma also at L2 (e.g. close-out deferred outputs) |
| **L3** — Proposal autonomy | Agents generate typed `cnos.issue_proposal.v1` from receipts + TSC reports; humans approve dispatch | Requires: TSC report attachment (Wave 1) + issue-proposal schema (Wave 2) + proposal validation (Wave 3) — not yet shipped |
| **L4** — Bounded dispatch autonomy | Low-risk proposals auto-dispatch when policy allows; high-risk requires human δ | Requires: bounded auto-dispatch policy (Wave 5) |
| **L5** — Roadmap autonomy | System maintains a roadmap of validated cells, repair paths, gates, joins | Requires: CCNF-O composing validated proposals (Wave 6) |
| **L6** — Protocol evolution autonomy | ε observes repeated incoherence patterns and proposes protocol patches | The terminal state; presupposes L1-L5 |

Sigma operates at L1-L2 today. The cnos#405 (CCNF-O + TSC steering roadmap) Sub 8 stages the move to L3+. The D4 anti-gaming guardrails I just adopted exist *because* L3+ is approaching — without them, autonomous proposal generation games the system. The autonomy ladder reframes the existing roadmap as a measurable trajectory.

## Anti-gaming — where D4 came from

The essay §"Anti-gaming rules" lists the rejection criteria nearly verbatim with D4's three named attacks:

| Essay (§"Anti-gaming rules") | D4 attack name |
|---|---|
| "increase coherence by deleting useful complexity" | simplify-away-truth |
| "avoid needed refactors because they temporarily lower γ" | avoid-hard-refactors |
| "split work into trivial cells only to inflate local pass rates" | tiny-only-shipments |
| "hide evidence to make β look cleaner" | (subsumed under simplify-away-truth + tiny-only-shipments) |
| "turn every low score into documentation churn" | (variant of tiny-only-shipments) |
| "claim TSC improvement without comparing target-equivalent bundles" | the bundle-comparison check V should enforce |
| "Coherence measurement is an observation, not a vanity metric" | TSC measurement is observation, not metric-to-optimize |

D4 condenses; the essay enumerates. D4 is the persona-side standing posture; the essay is the system-side rejection criterion. Both are needed: the persona refuses to author gameable proposals; the validator refuses to validate them. Layer-1 + layer-5 in the five-layer chain.

## Open questions Sigma should hold

The essay names seven open questions (§"Open questions"). Three of them directly affect Sigma's future work:

1. **Q1 — Which targets get measured after every cell?** Changed files only / package bundle / roadmap scope / whole repo. If "package bundle" is the target, then cn-sigma's TSC measurement target is the cn-sigma repo itself when Sigma authors persona doctrine — and the persona patch I just landed is measurable against cn-sigma main.
2. **Q3 — What is the minimal mechanical TSC proxy that can run in CI?** Before semantic scoring is available. This is the question I'd need to answer to add TSC measurement to cn-sigma's own work (vs only cnos's).
3. **Q7 — Which layer owns the issue proposal schema?** `cnos.core` / `cnos.cdd` / CCNF-O / future `cnos.coherence` package. Affects where Sigma's authoring code path looks for the schema.

Worth holding these open — they're the load-bearing decisions that determine how the L3+ regime actually feels to operate.

## Sigma slogan — operational form

PERSONA §Identity has a line: *"Core drive: Reduce incoherence between model and reality."*

The essay's slogan: *"cnos turns fallible agent work into a measured path of decreasing incoherence."*

These rhyme but the second is more precise:
- "reduce incoherence" → "decrease incoherence" (the essay's framing)
- "between model and reality" → "via accepted receipts → measured posture → bottleneck → grounded next contract"
- "core drive" → "measured path"

The PERSONA line is still right; it's just been operationalized in 610 lines downstream. The slogan should not be edited in PERSONA — its concision is part of its identity-anchoring function. But future sessions reading the line should know it has a runtime referent now, not just an aspirational one.

## Recurrence — three "didn't read the source" today

Today's session generated three instances of the same anti-pattern:

1. **Asserted runtime limits without testing.** Said cnos was unreachable from this body before trying `git clone`. Captured in `20260519-git-read-and-untested-limits.md` (filed three days ago, surfaced again today as a touchstone).
2. **Adopted persona doctrine without reading the cited substrate.** Applied the 10 rules from sigma-activation-2026-05-22 without reading `CCNF-AND-TYPED-TRUST.md`. Captured in `20260522-ccnf-typed-trust-essay-read.md` (filed earlier this session).
3. **Found "an" essay without verifying it was "the" essay.** Operator asked about "the new essay"; I read the first one I found citation-trail evidence for (CCNF) and reported on it, without checking whether there were other recent essays the operator might have meant. Captured here.

The pattern is: when uncertain about which artifact the operator means, default to "check what artifacts exist" rather than "follow the most-recent citation trail and assume." `find docs -name '*.md' -newer X` is five seconds; saved a follow-up correction.

Fix-class for future sessions:
- **When operator references an artifact by topic** ("the essay about X"), search by title/content first, not by citation trail. The title is observable; the citation is one signal among many.
- **When a session's downstream artifact (bundle, patch, adopted doctrine) cites multiple sources**, read all cited sources before treating the downstream artifact as authoritative.
- **When in doubt, ask** — operator preferences allow brief disambiguation when the artifact reference is genuinely ambiguous, per OPERATOR.md "Ask before acting only when: Uncertain whether operator intent matches my interpretation."

## What's worth recording for future sessions

1. **The two essays are paired.** CCNF-AND-TYPED-TRUST = cell substrate; DECREASING-INCOHERENCE = system steering. Reading order: CCNF first (mechanism), DECREASING-INCOHERENCE second (purpose).
2. **Both are DRAFT v0.1.0.** Status not RATIFIED. Revisions trigger persona-doctrine reconciliation under the Continuity rule.
3. **Sigma is at autonomy L1-L2.** L3+ requires the issue-proposal schema + TSC report attachment to ship in cnos. Both are roadmap items, not delivered.
4. **The investment-class triad is mechanical.** If TSC reports become available, the next-cell shape is selectable without judgment — only the *content* requires it.
5. **The TSC vs role rhyme is a trap.** D4's phrasing references the TSC axes by single Greek letters in a context where the role α/β/γ are also active. Watch for confusion in future sessions; the essay's explicit distinction is the canonical clarification.
6. **L6 is the long-term endpoint.** ε observing repeated incoherence patterns and proposing protocol patches IS the autonomous-improvement endgame. It presupposes L1-L5; without them, ε proposals are ungrounded task suggestions.
