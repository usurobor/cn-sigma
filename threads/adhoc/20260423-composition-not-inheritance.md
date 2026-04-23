# Composition Is Not a Preference — It's the Only Model Consistent with Coherence

**Filed:** 2026-04-23
**Context:** After shipping skill, compose, write, design to cnos.core and watching them organize into peers, not a hierarchy.

## The question that matters

OOP vs composition is usually framed as an engineering trade-off. For skills in a coherence-first system, it isn't a trade-off. It's a question about what kind of object a skill is. The answer determines whether the system stays coherent or quietly drifts.

## What a skill actually is

A skill is not a class. No private state, no encapsulated mutation, no inheritable behavior. A skill is advisory text loaded into context to bias a downstream judgment. It has four properties:

- a trigger — when it applies
- an input contract — what it assumes
- an output contract — what it guarantees
- a transformation along one axis — what it changes

That's a function with preconditions, a body, and postconditions. Not a class. If you accept this, the OOP framing is a category error. You're not choosing between two implementation styles for the same kind of thing — you're choosing between two models of what a skill *is*.

Inheritance models a skill as a class. Composition models a skill as a function. Only one is faithful to what a skill actually does.

## Why inheritance fails for skills specifically

Three problems skills cannot absorb:

**Implicit coupling.** A child's behavior depends on the parent's rules in a way the loading system cannot inspect. If the parent changes, every child silently changes. In a system that selects skills by trigger and runs them in order, every dependency must be visible to the loader. Inherited behavior is invisible by definition.

**Single-axis commitment.** A class hierarchy locks you to one variation axis. Once `essay` inherits from `write`, you cannot cleanly add voice or form as second axes. Skills cross many axes — coherence, voice, form, naturalness, domain — and no single hierarchy captures them all.

**Brittle base class → brittle base prompt.** When the parent skill iterates, all children inherit the change without consenting. In code this is annoying. In skills — where "behavior" is rules biasing a generative system — children change in ways their authors didn't anticipate and can't easily test.

These aren't theoretical. They're the predictable failure modes of making skills inherit, and you don't need to encounter them to know they're coming.

## Why composition fits

Composition treats each skill as an independent function with a clean contract. Combining skills means running them in sequence or selecting by trigger, each knowing only what it needs, producing what it promises.

**Multiple axes without commitment.** A draft can be transformed along coherence, then form, then voice, then naturalness, in any order. None forces a choice about which is "more fundamental." They're peers because they're axes, not levels.

**Explicit dependencies.** A composed pipeline declares what runs before what. No inherited behavior, no silent side-effects from parent changes. The loader can inspect the pipeline.

**Skill replaceability.** Swap one skill for another satisfying the same contract. Inheritance lets you subclass but not easily substitute. For a system where skills are continuously added and refined, replaceability beats reuse.

The Unix pipeline is the canonical instance. GoF said "favor composition over inheritance" in 1994; thirty years of language design agreed by weakening inheritance (Java's `final`, Kotlin's sealed classes) or removing it (Go, Rust, Clojure). Skills are young enough to learn the lesson without relearning it.

## Where coherence raises the bar

In a system whose foundation is coherence, the question isn't just which model is more flexible — it's which model *preserves coherence under change*.

Coherence: all parts of a system point at the same thing. A coherent skill has one axis, one trigger, one set of contracts, one source of truth for each rule. A coherent skill system has skills that combine without overlap, drift, or hidden order.

Inheritance violates coherence in two specific ways:

**Two homes for one rule.** When a child inherits from a parent, both files contain the rule — parent declares it, child inherits it. As the child evolves it may override or shadow it. Now two slightly different versions exist in two places, and the system can't know which the loader applies. This is exactly the failure mode write names ("say a fact once, then point to it") and compose names ("move shared rules to one owner"). Inheritance institutionalizes that failure.

**Implicit axes.** A skill that inherits from another inherits the parent's reasons-to-change on top of its own. Multiple reasons to change, hidden under one file. The boundary isn't crisp; the skill isn't single-axis. By rule, it's no longer coherent.

Composition creates neither failure. Each skill owns its own rules. Each has one axis. Each skill's reasons-to-change are exactly its own. When two skills combine, the combination happens at the use site (visible, explicit), not the definition site (implicit, inherited).

Composition isn't just preferable for skills — it's the only model consistent with coherence as a foundational principle.

## The evidence from cnos.core

The four cnos.core skills organized themselves into exactly the shape this principle predicts:

- **write** owns prose coherence
- **skill** owns artifact form
- **design** owns system decomposition
- **compose** owns the question of when a skill is warranted

Four peers along four axes. None inherits from another. Each points to the others where they're authoritative.

The compose ↔ design relationship is the most revealing case. compose is structurally what design looks like when applied to artifacts of class skill. The rules map almost 1:1:

| design | compose |
|--------|---------|
| One reason to change per boundary | One axis per skill |
| One source of truth per fact | One owner per shared rule |
| Interfaces belong to consumers | Contracts belong to consumers |
| Preserve runtime surface boundaries | Compose, do not extend |

If skills could inherit, compose would be a child of design. But because they don't, compose is a peer that applies the design formula to a specialized artifact class, declares what it adds (classification, triggers, publish-or-compose verdict), and points back for shared rules. That's composition working at the meta level — the skills compose to form the skill system, and the rules of composition are themselves expressed compositionally. The system is coherent with itself.

Inheritance would have produced: design as base class, compose as subclass. That shape hides the relationship inside `extends`, makes rules harder to point at, and creates silent-drift risk every time design iterates. Composition makes the same relationship explicit, declarable, auditable.

## The principle

**For systems whose foundation is coherence, composition is the only architectural primitive that preserves the foundation.**

Inheritance trades coherence for concision, and concision is not worth that trade.

Skills compose because they are functions, not classes. They preserve coherence because composition keeps every dependency explicit, every rule single-owned, every axis singular. They scale because adding a new skill never requires editing an old one. They stay honest because the loader can inspect every relationship.

The cnos system didn't arrive here by argument. It arrived by building. The four cnos.core skills are peers, not a hierarchy, because every attempt to make one inherit from another would have violated the system's own coherence rule. The architecture discovered itself.

That's the deeper test of a foundational principle. Not that you can state it, but that the system you build by following it organizes itself the way the principle predicts.

Coherence demanded composition. Composition delivered coherence. Same move at different scales — and skills are where it shows up first.
