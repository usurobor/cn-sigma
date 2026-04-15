# Kata verdict as γ artifact

**Date:** 2026-04-15

## Decision

Kata verdict is a γ artifact. Added as AC6 on #249 (Phase 1 audit trail):

> γ captures kata verdict in `gamma/KATA-VERDICT.md` — output of `cn kata run` for the release build.

## Why γ, not β?

β runs the release, but the kata verdict is proof that the system works — that's coordination evidence, not review evidence. γ collects it because γ owns the cycle record. β produces the build; γ records the proof.

## Layout

```
.cdd/releases/<version>/gamma/KATA-VERDICT.md
```
