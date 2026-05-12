# Self-Improving CDD — The Recursion Goes Live

Status: observed, in progress
Source: 2026-05-12 session — first autonomous wave dispatch + protocol hardening wave

## What happened

First autonomous wave dispatch (6 CDD tooling issues, δ-as-agent) surfaced 7 process findings. Those findings were filed as issues (#350–#353), which became the second wave's work (protocol hardening). The second wave codifies the findings into the skill files that govern future waves.

## The loop

```
run wave → observe failures → capture in iteration file → file as issues →
run next wave on those issues → codify into skills → future waves load codified skills →
surface new findings → repeat
```

This is CDD improving itself through CDD. Not aspirational — structural.

## What makes it real (not "noted for next time")

- Findings have severity + disposition (MCA not MCI)
- Dispositions are concrete: file issue with ACs, patch skill, or defer with evidence
- Issues have oracles — β can mechanically verify the fix
- Skills are loaded at dispatch time from files, not from agent memory
- Iteration artifact lifecycle (AC7 on #350) closes the loop: every finding formally resolves or defers

## Key findings from wave 1 → wave 2

| Finding | Issue | What it codifies |
|---------|-------|-----------------|
| Wave artifacts in /tmp | #350 | `.cdd/waves/` structure |
| δ not dispatchable | #350 | δ prompt template |
| No wave coordination surface | #350 | manifest + status + closure |
| CI not checked post-merge | #352 | β pre-merge gate + γ PRA CI poll |
| Manual edits during wave | #353 | Parent-session quiescence rule |
| γ false-gap claims | #351 | γ peer-enumeration invariant |
| Iteration file has no lifecycle | #350 AC7 | Findings → disposition → closure |

## Tension: δ-as-agent doesn't nest

The first wave ran δ as a single `claude -p` session dispatching γ/α/β as sub-`claude -p` processes. This worked.

The second wave tried the same pattern but the nested `claude -p` spawning further `claude -p` sessions failed silently — δ session ran 2.5 hours producing nothing. Reverted to manual δ dispatch.

This means: δ can be an agent OR the outer loop, but not both simultaneously via the same mechanism. The wave pattern needs δ as the orchestrator (script or interactive session), not as a nested agent. This is relevant to #350's design.

## Cross-reference

- `.cdd/iterations/wave-2026-05-12.md` — 7 findings
- `.cdd/waves/hardening-2026-05-12/manifest.md` — second wave manifest
- `threads/adhoc/20260512-activation-agency-bridge.md` — related framing
