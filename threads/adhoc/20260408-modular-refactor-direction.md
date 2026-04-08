# Modular Refactor Direction — 2026-04-08

## What happened
Operator shared a detailed architectural review: the docs describe a much more modular system than the code implements. `src/cmd/` owns system truth that should be in a reusable core. Commands are the only content class that doesn't flow through the standard build pipeline.

GPT contributed a comprehensive 7-phase implementation plan. Sigma proposed a scoped-down 3-move KISS alternative. Operator chose Sigma's plan as immediate execution, GPT's as north star.

## Why it matters
This is the first time the refactor direction has been concretely scoped. Previous cycles (#167, #173, #174) built the package infrastructure piece by piece. Now the gap between docs and code is named and there's a plan to close it.

## What changed (MCA)
- `docs/alpha/agent-runtime/CORE-REFACTOR.md` — full L7 design artifact with 10 ACs, 5-phase plan, target structure, alternatives considered. Immediate KISS slice added.
- `docs/gamma/essays/MODULAR-ARCHITECTURE-REFACTOR.md` — gamma decision record
- #182 filed as umbrella issue
- #184 filed as Move 1 (command pipeline symmetry) — handed off to Claude

## Architectural decisions captured
1. One package substrate with roles, not two systems
2. Commands through standard pipeline (biggest asymmetry)
3. Super-lean core: pure schemas in src/lib/, impure in src/cmd/
4. Four distinct runtime surfaces: skills, commands, orchestrators, extensions
5. A2A transport in core, workflows in packages
6. Bootstrap kernel stays built-in (8 commands)

## What to watch for
- Move 1 (#184) is the test: if command migration works cleanly, the architecture direction is validated
- If src/lib/ gets crowded after Move 2, that's the signal to introduce src/core//src/host//src/runtime/
- Activation schema redesign deferred until trigger words actually fail
- Package roles deferred until there's a second package author
