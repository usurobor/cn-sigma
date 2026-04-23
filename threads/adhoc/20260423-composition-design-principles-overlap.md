# Composition ↔ Design-Principles: Overlap and Authority

**Filed:** 2026-04-23
**Trigger:** External reasoning surfaced the exact failure mode composition warns about — between composition itself and its new neighbor.

## The finding

composition and design-principles both claim "contracts" territory. This is precisely the failure mode composition rule 3.6 is designed to prevent: same rule, two homes, drift guaranteed.

Evidence:

- **design-principles** owns contracts as a general architectural principle (§2.4 "Make interfaces truthful", §3.5 "Interfaces belong to consumers", §1.2 "Substitutability")
- **composition** owns contracts for skills specifically (§2.3 "Declare entry and exit contracts", §3.3 "Declare both contracts")

The word "contract" appears authoritatively in both. Neither points to the other.

## The relationship question

Is composition an application of design-principles to skills, or a peer along a different axis?

After reading both: **composition is design-principles applied to the skill domain.** The mapping is direct:

| design-principles concept | composition concept |
|---------------------------|---------------------|
| reason to change (§2.1) | axis (§2.1, §2.2) |
| contract / interface (§2.4) | entry/exit contract (§2.3) |
| one source of truth (§3.2) | one owner per shared rule (§2.6, §3.6) |
| runtime surface separation (§2.5) | trigger distinction (§2.4, §3.4) |
| dependency direction (§2.3) | pipeline order (§2.5, §3.5) |

composition doesn't add new *principles* — it adds skill-specific *application* of design-principles. The "axis" IS "reason to change" for skills. The "ownership" rule IS "one source of truth" for skill rules.

This means composition should point upward to design-principles for the general principles and own only the skill-specific application. Not the other way around.

## Concrete gaps to fix

### 1. composition §3.11 is incomplete

Currently:
> "skill governs skill form. writing governs prose rules. composition governs skill composition."

Missing: design-principles governs decomposition and contracts at the system level. composition applies those principles to skills specifically. The four-way authority story is:

- **skill** → skill form and classification
- **writing** → prose coherence
- **design-principles** → decomposition, contracts, boundaries (general)
- **composition** → skill boundaries, composition judgment (skill-specific application of design-principles)

### 2. composition should cite design-principles as upstream authority

composition §2.3 (contracts), §2.1 (one axis), §2.6 (one owner) are all applications of design-principles §2.4, §2.1, §3.2. composition should say so explicitly — "contract" rules in composition derive from design-principles; composition owns the skill-specific form.

### 3. design-principles doesn't declare its own composition contracts

Ironic: now that design-principles lives alongside composition, it should eat its own food. It has no declared axis, trigger, order, or ownership in composition terms. It should have:

- **Axis:** transforms a system along the axis of architectural decomposition
- **Trigger:** use when splitting packages, defining boundaries, designing interfaces, or reviewing refactors
- **Order:** runs before composition (composition applies these principles to skills); runs alongside review (review loads it for architectural checks)
- **Contract:** Input: a system with boundaries to evaluate. Output: boundaries aligned to reasons-to-change, contracts truthful, policy above detail.

### 4. Dogfood results on design-principles

- Frontmatter: ✅ complete
- Governing question: ✅ singular, proper form
- Failure mode: ✅ specific (leakage, duplication, false substitutability, surface smearing, premature canonicalization, authority drift)
- Kata: ✅ two embedded katas exercising real judgment
- Demonstrates own formula: ✅ mostly — the skill itself is decomposed by reason-to-change
- Missing: composition self-declaration (see §3 above)

## Implication for cnos skills system

This is the first real test of composition's own rules against a live neighbor. The fact that the overlap appeared immediately after moving both skills to cnos.core validates the skill — composition detected (through external reasoning) exactly the failure class it's designed to prevent.

The fix is straightforward:
1. Add design-principles to composition's authority declaration
2. Add upward citations from composition's contract/axis/ownership rules to design-principles
3. Add composition self-declaration to design-principles
4. Neither skill loses territory — they nest (general → specific), not overlap

This is also evidence that **any time skills move into the same package, a composition check should fire.** The co-location itself is a trigger. This could become a gate in the skill-loading or skill-publication process.

## Status

Insight captured. Fixes not yet applied — waiting for operator decision on whether to patch both skills now or defer to a CDD cycle.
