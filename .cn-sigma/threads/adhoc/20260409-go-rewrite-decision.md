# Go Rewrite Decision — 2026-04-09

## Context
After 6 cycles where no agent could compile OCaml locally (CI is the only oracle), and with the agent network vision requiring accessibility, the question was raised: do we still need OCaml?

## Decision
Rewrite cnos in Go.

## Reasoning
- Tests catch what types catch — OCaml's type safety served during design, tests preserve the discipline
- The code is schema validation, JSON parsing, file copying, command dispatch — not deep type algebra
- Go: any agent builds it in seconds, single static binary, trivial cross-compile
- Rust considered but rejected: borrow checker adds friction for no real gain in this domain
- OCaml ecosystem too small for an open network where anyone needs to build/extend cnos
- Codebase is ~3-4k lines of real logic — rewrite is weeks, not months

## What to watch
- Schema/contract validation may want codegen or stricter patterns in Go to compensate for weaker types
- Test discipline must hold — Go makes it easy to skip, OCaml's compiler didn't let you
- The rewrite should be incremental if possible (command by command) or a clean break
- Package system, workflow IR, runtime contract — these are the complex modules to port carefully
