# Skill Language Convergence: Practice Side Meets CTB

**Filed:** 2026-04-23
**Context:** After shipping skill, compose, write, design to cnos.core and SKILL-ARCHITECTURE doctrine.

## The observation

We are developing a language for writing skills. Not deliberately designing one top-down — discovering one by building from practice.

The cnos.core skill system already contains the components that make a programming language useful:

| Language component | cnos.core equivalent |
|-------------------|----------------------|
| Type system | skill, runbook, reference, deprecated (skill §1.0) — with classification tests |
| Function signature | trigger + input contract + output contract + transformation along one axis |
| Module system | compose — no inheritance, explicit order, single ownership, publish-or-compose gate |
| Standard library | the four core skills themselves (skill, write, design, compose) |
| Type checker | the Final Test in each skill, the Verify phase |
| Test framework | katas as executable verification surfaces |
| Architectural constraints | SKILL-ARCHITECTURE doctrine — the memory model / calling convention |
| Style enforcer | write — the equivalent of `gofmt`, not optional, not taste |

## The convergence

CTB (FOUNDATIONS §3.3, CTB-v4.0.0-VISION) exists as syntax waiting for semantics. The skill system is semantics waiting for syntax. They're converging from opposite ends.

**CTB today:** a small deterministic expression-only language. `tri(T₁, T₂, T₃)` constructor, repair rule, pattern matching. Can represent coherent structure but has no ecosystem.

**Skill system today:** a human-readable, human-executed language with types, functions, composition rules, verification, and a standard library. Lacks formal syntax, machine-checkable contracts, and a runtime.

**The meeting point:** when CTB gains the ecosystem components the skill system has already prototyped in prose:

- A skill can be *checked* (does the contract hold?) not just read
- Composition can be *verified* (does the pipeline type-check?) not just declared
- The publish-or-compose verdict can be *computed* (does the proposed skill's axis already exist in the composition space?) not just judged
- "Two agents with the same skill and same input must produce the same output" becomes enforceable, not aspirational

## What this means for the roadmap

The skill system is the standard library being written before the compiler exists. This is the right order — the library constrains the language, not the other way around.

Specifically, the practice side is producing:

1. **The type system CTB needs** — artifact classification with tests is a prototype for CTB's skill type system. The four classes (skill/runbook/reference/deprecated) become CTB types.

2. **The module semantics CTB needs** — compose's rules (single axis, explicit order, no inheritance, publish-or-compose gate) are the module system design. When CTB gains imports (v2.0 roadmap), these rules should govern them.

3. **The effect vocabulary CTB needs** — skill contracts (input/output) are prototyping the effect algebra. "Input: a skill proposal. Output: a composition verdict" is a type signature waiting for syntax.

4. **The verification model CTB needs** — katas are test suites. The Final Test is a type checker. The Verify phase is a linter. All three map to CTB toolchain components (v2.0: linter, v3.0: capability annotations).

## Agent hierarchy as call stack

**Added:** 2026-04-25

The CDD triad revealed another language component hiding in practice: **agents are function calls with scoped authority.**

| Programming concept | CDD equivalent |
|-------------------|----------------|
| Call stack | operator → γ → α/β |
| Function scope | each agent owns only its local artifacts (α: implementation, β: review + release, γ: assessment + triage + closure) |
| Arguments | dispatch prompt + issue (input contract) |
| Return value | close-out (output contract) |
| Local variables | branch state, draft artifacts, working observations — invisible to caller until returned |
| Caller owns the result | γ owns what α/β return. Close-outs are return values, not owned state. α/β lose authority over their observations once surfaced. |
| No upward mutation | α cannot modify γ's assessment. β cannot modify γ's triage decision. Lower scope cannot write to higher scope. |
| Delegation | γ dispatches α and β the way a function calls two sub-functions. The caller decides what to do with the results. |

This is strictly hierarchical by design. Lower-level agents own their execution scope and nothing above it. Findings flow up as return values. Decisions flow down as dispatch. The caller (γ, or operator above γ) holds judgment authority over everything returned to it.

The key insight: **"surface findings in close-outs" is not ownership — it's returning a value.** α doesn't own its findings any more than a function owns its return value after the caller receives it. γ receives, triages, and decides. The close-out is the return type.

This extends the function-signature model from the language table above:

- **Skill** = function definition (trigger + contract + transformation)
- **Agent** = function invocation (scoped execution of a skill with concrete inputs)
- **Triad** = a call tree: γ calls α and β, collects returns, produces its own return to the operator

The hierarchy also explains why role separation is a type constraint, not a preference: α and β having separate scope is the same principle as functions not sharing mutable state. When they do (role leakage), you get the concurrent-mutation bugs that CDD's independence rule exists to prevent.

## What's still implicit

Three things the skill language uses but hasn't formalized:

- **The loader model** — how triggers resolve, what "loading" means at runtime, precedence when multiple skills match. Referenced but never specified.
- **The pipeline model** — compose says "declare order" but execution semantics (sequential? parallel? conditional?) aren't defined.
- **The contract grammar** — "Input: ... Output: ..." is convention, not grammar. No way to verify satisfaction except reading.

These are the gaps where CTB syntax would make the skill language machine-checkable.

## The deeper point

The cnos system arrived at a skill language by following coherence, not by designing a language. The four core skills organized themselves into peers along orthogonal axes — the shape a well-typed module system produces. The composition rules emerged from failure analysis — the constraints a sound type system enforces. The verification surfaces emerged from practice — the test framework a mature language provides.

CTB doesn't need to invent its ecosystem. The ecosystem is already being prototyped in prose. CTB's job is to give it syntax, determinism, and machine-checkability.

We're writing the standard library before the compiler. The compiler's job is to make the library's contracts enforceable.
