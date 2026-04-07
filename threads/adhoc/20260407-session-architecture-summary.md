# Architecture State After 2026-04-07 Session

## What shipped
- v3.34.0: artifact-first package distribution, commands content class, lockfile v2, git transport deleted
- CDD §2.5a: delegated implementation handoff protocol + self-verification gate
- Architecture-evolution skill §5: five L7 diagnostic patterns
- Runtime contract: activation index + command/orchestrator registry (#173, pending merge)

## Current cnos architecture (four surfaces)
- **Skills decide** — judgment, activated by declarative context signals (SKILL.md frontmatter triggers)
- **Commands dispatch** — exact name, operator-facing (built-in > repo-local > package)
- **Orchestrators execute** — mechanical workflow IR, deterministic (cn.orchestrator.v1)
- **Extensions provide capability** — typed ops, runtime/body-plane

## Package model (NuGet)
- Package = dumb tarball delivery, runtime = smart loading
- Well-known directory layout per content class
- Manifest lists exposed skills only (encapsulation)
- Runtime contract emits activation table at wake (cognition layer)
- Install → scan frontmatter → build activation table. Uninstall → rebuild.

## CTB connection
- CTB = source language (deterministic, expression-only, effects-as-data)
- Effect Plan = IR (pure data, JSON wire form, hashable/verifiable)
- Runtime bridge = executor (capability-gated)
- Stack: CTB source → compile/evaluate → Effect Plan JSON → runtime execution

## Open issue chain
- #170 master: orchestrators + command providers
  - #172 ✅ ETB → CTB doc fix
  - #173 pending merge: runtime contract activation
  - #174 next: orchestrator IR runtime (L7)
  - #175 future: CTB → IR compiler (L7)
- #168: L8 candidate tracking

## Key MCI from session
1. Fix at the right level — don't patch subsystems, question whether they belong
2. Remove complexity, don't add fallbacks
3. Design for actual scale (one hub → clean cut)
4. Follow the system's own extension pattern
5. Handoff is a CDD contract, not a feature spec (§2.5a)
