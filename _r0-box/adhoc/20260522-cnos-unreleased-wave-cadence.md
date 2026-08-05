# cnos Unreleased Wave Cadence — 2026-05-22

## Finding

`cnos` main carries 15 closed issues since the 3.81.0 tag (cnos#385, 2026-05-20), and every one of them is parked in `.cdd/unreleased/`. 85 commits on main, no new tag.

```text
unreleased/  ← 388 389 390 392 393 394 395 396 397 398 399 400 401 402 406 407
last tag     ← 3.81.0 @ afb89475 (2026-05-20)
```

This is the largest unreleased delta `cn-sigma` has carried since the hub started bumping deps cycle-by-cycle. `cn-sigma/.cn/deps.json` still pins `cnos.core@3.81.0` and `cnos.eng@3.81.0`. None of #388–#407 — schema split, V port, δ extraction, harness substrate, release-effector extraction, γ shrink, ε upscope, CDD compression, CDR bootstrap, CDS skeleton, CDS contract — is visible to the hub yet.

## Classification

Two possible reads, both worth surfacing:

```text
(a) release-overdue: 3.82.0 is owed and the wave is waiting on δ to stamp it.
(b) cadence-shifted: post-#399 (release-effector extraction) and #400 (γ shrink),
    the per-cycle release rhythm changed to wave-bounded releases; the next
    tag stamps when #403 Subs 3–5 land or some other coherent boundary fires.
```

Either read is fine. What is *not* fine is having no recorded answer — the cycle/385 close-out treated tag-per-cycle as default, and nothing since has documented an override.

## Why it matters

1. **Downstream blindness.** `cn-sigma` cannot pick up V (#389/#391/#392), δ skill (#397), harness substrate (#398), release-effector (#399), generic ε (#401), the CCNF-spine `CDD.md` (#402), the CDR package (#394–#396), or the CDS package (#406–#407) until a release stamps. Every gap the hub side has had to work around — manual runtime.md edits, hand-vendored deps — would presumably improve as soon as the wave releases.

2. **PRA accumulation.** Without per-cycle release, the PRA / RELEASE.md / CHANGELOG aggregate over 15 cycles. That is a large γ close-out surface to assemble in one pass, and one of the things δ extraction (#397) and release-effector extraction (#399) were supposed to reduce.

3. **Doctrine pointer.** If the cadence shifted, OPERATOR.md §"Release" and `cnos.cdd/skills/cdd/release-effector/SKILL.md` should say so. The current behavior is undocumented inference.

## What to verify

Before recommending anything, the operator should answer:

```text
- Was a 3.82.0 release intentionally deferred? If so, what gates it?
- Did release cadence change post-#399/#400? If so, where is that decision recorded?
- Is the next tag pinned to #403 wave completion, or to a calendar/size threshold?
```

## Suggested action

P2 / coherence. Either:

```text
(a) stamp 3.82.0 to clear the unreleased buffer and bump cn-sigma deps; or
(b) record the cadence change in release-effector/SKILL.md and OPERATOR.md so
    future operators (and hub-side Sigmas) do not assume per-cycle releases.
```

Do not ship a release without operator approval — release tagging is a δ gate per OPERATOR.md and the prior-session memory.

## Priority

P2 / cadence-coherence. Promote to P1 if the hub needs any of #389–#402 surfaces (V validator, δ skill, harness, release-effector, ε generic) for its next planned work.

## Cross-refs

- [[20260522-cnos-cds-extraction-wave]] — names the wave content
- [[20260522-executable-protocol-velocity]] — names the velocity gain; release cadence is the throughput-shaped counterpart
- [[20260522-cds-readme-drift-extended]] — adjacent coherence finding in the same wave
