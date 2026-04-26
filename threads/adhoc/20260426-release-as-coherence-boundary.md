# Release as coherence boundary

**Date:** 2026-04-26
**Thread type:** principle discovery
**Related:** COHERENCE-FOR-AGENTS.md, δ operator skill, CTB LANGUAGE-SPEC.md §9

## The insight

The release tag is not a distribution mechanism. It is a **coherence boundary** — the structural cut that says "this is one articulated whole, inspectable, reproducible, done."

Without the tag, the triad's output bleeds into the next cycle's input with no named edge between them. The whole never crystallizes — it stays entangled.

## Same principle at every scale

- **Skill level:** a skill returns a plan (data). The caller owns the result. The boundary is the return. (CTB LANGUAGE-SPEC.md §9: "lower scope MUST NOT mutate higher scope. A sub-skill returns; it does not push.")
- **Triad level:** α/β/γ produce artifacts. γ closes the cycle. The boundary is the close-out.
- **System level:** δ tags the final state. The tag is the disconnection point. Everything before it is the triad's coherent whole. Everything after it is a new boundary.

This is the same structure at three scales: produce → close → disconnect. The return value, the close-out, and the tag are all the same thing — a boundary that crystallizes a whole.

## Why "no consumers, no release" was wrong

The consumer argument treats the tag as delivery — "who receives it?" The coherence argument treats the tag as boundary — "where does one whole end and the next begin?" The boundary exists whether anyone reads it or not. It's structural, not consumer-driven.

This was discovered in practice: after #230's cycle closed, 10 commits of post-release work (PRA, close-outs, skill patches, δ operator skill, CTB v0.1) sat on main untagged. The agent assessed "no downstream consumers, no release needed." The operator corrected: the triad must be disconnected at its final state. The tag (3.59.1) was the disconnection.

## Connection to COHERENCE-FOR-AGENTS.md

The essay says: "once a triad stabilizes, it appears at its external boundary as one articulated whole." δ cuts that boundary. Without the cut, the triad's external boundary is undefined — another agent looking at the repo sees an undifferentiated stream of commits, not a coherent whole.

The tag is what makes the whole inspectable from outside. It is the structural equivalent of trust: another agent can integrate because it can see what was produced, judged, and released — as a named, immutable snapshot.

## Implication for δ skill

δ §3.4 now states: "the release is how δ disconnects the triad's output into a distributable, tagged whole. This is not optional." The lifecycle table has a "Disconnect" phase after Post-release. The tag is the last δ action in a cycle — the cut that frees the next cycle to start clean.

## No signaling — git is the shared surface

The initial δ design had inter-role signal protocols: γ signals δ to disconnect, δ signals γ on gate completion. All of this was removed. The tag is git-observable. Branch deletions are git-observable. Commits are git-observable. If it's on the shared surface, everyone can see it — no messaging layer needed.

This is the same principle again: the boundary (tag) is observable by definition. Adding a signal on top of an observable boundary is redundant. The signal itself would need a surface — and that surface would be less reliable than git.

Removed: "δ: disconnect" from γ's closure format, "signal γ" from δ lifecycle table, "completion signal" from γ inputs and load order, all §3.5 signal references across CDD.md/gamma/operator. Replaced with: "git-observable."

## CDD algorithm now reflects the full model

- Role table: δ alongside α/β/γ
- Phase 6 (Disconnect): step 17 — δ tags after all post-cycle work lands
- Step 16: γ closure declaration is γ's last commit
- Step 17: δ tags. Nothing between closure and tag except δ's patches.
- §1.4 "δ and the external boundary": structural explanation via COHERENCE-FOR-AGENTS.md
- All inter-role signaling removed — git is the shared observable surface

## Tags shipped

- 3.59.1 — first δ disconnect (operator skill, CTB v0.1, all session patches)
- 3.59.2 — second disconnect (CDD algorithm reflects full δ model + Phase 6)
