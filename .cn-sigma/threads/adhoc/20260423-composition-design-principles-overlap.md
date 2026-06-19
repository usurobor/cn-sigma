# Composition ↔ Design-Principles: Authority Relationship

**Filed:** 2026-04-23
**Updated:** 2026-04-23 — corrected after reading both skills. Initial framing was "overlap to fix." Actual relationship is "parent-application to declare."

## The initial worry

I flagged that composition and design-principles both claim "contracts" territory — the exact failure mode composition rule 3.6 prevents. This turned out to be wrong.

## What actually holds

**design-principles** is about software systems — modules, packages, providers, registries, runtime surfaces, kernel/core policy. **composition** is about skill artifacts — what loads when, what triggers what, who owns which rule.

The word "contract" appears in both with different referents:
- In design-principles: substitutability promise between consumer and interface implementation
- In composition: input/output expectation between skills in a pipeline

They are not competing for territory.

## The deeper relationship

composition is structurally what design-principles looks like when applied to artifacts of class skill. The parallels are too clean to be accidental:

| design-principles | composition |
|-------------------|-------------|
| 3.1 "One reason to change per boundary" | 3.2 "State one axis" |
| 3.2 "One source of truth per fact" | 3.6 "Move shared rules to one owner" |
| 3.5 "Interfaces belong to consumers" | 3.3 "Declare both contracts" |
| 3.7 "Preserve explicit runtime surface boundaries" | 3.9 "Compose, do not extend" |

Same pattern, different artifact class. Not peers along independent axes — a parent-and-application pair.

## What composition adds beyond design-principles

These are legitimately skill-specific and don't exist in design-principles:

- **Classification** (skill vs runbook vs reference vs deprecated) — specific to skill artifacts
- **Trigger as first-class part** — skills select by trigger; software modules don't have triggers in the same sense
- **Publish-or-compose verdict** — about whether a new artifact should exist, the skill-author's question, not the system architect's
- **The kata** — practiced on skill artifacts specifically

## Concrete fixes

### 1. composition §3.11 — incomplete authority declaration

Currently:
> "skill governs skill form. writing governs prose rules. composition governs skill composition."

Should read something like:
> "design-principles governs system decomposition. skill governs skill form. writing governs prose rules. composition applies design-principles to artifacts of class skill, adding triggers, classification, and the publish-or-compose verdict."

### 2. design-principles algorithm/section name mismatch

Algorithm header says four steps: Define / Unfold / **Apply** / Verify.
Body sections are: Define / Unfold / **Rules** / Verify.

"Rules" is presumably what "Apply" was supposed to be. Either rename the section or update the header. The skill skill says each section should serve the formula in necessary order — this naming gap is a small violation.

## The cnos.core skill set architecture

The four skills form a coherent set with two layers:

**Foundation layer:** skill (artifact form), writing (prose), design-principles (system decomposition)

**Specialization layer:** composition (design-principles applied to skill artifacts)

## Meta-observation

The fact that composition was derived from first principles (functional composition vs OOP inheritance) and then lined up rule-for-rule with design-principles is the strongest evidence both skills point at the same underlying pattern from different angles. The system discovered its own architecture.

## Observation on my initial analysis

I framed this as "overlap — same rule, two homes, drift guaranteed." That was wrong. The rules aren't the same — they share vocabulary but have different referents. The actual relationship is hierarchical (general → specific), not competitive. Lesson: read both skills before diagnosing overlap. Shared vocabulary ≠ shared territory.

## Status

Insight captured. Two small fixes identified (composition 3.11, design-principles algorithm header). Ready to ship.
