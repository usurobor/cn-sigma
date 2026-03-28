# Review Divergence — PR #130 (Self-Knowledge Interception)

## Divergence

Sigma R1: APPROVED with C-level note on fs_glob gap.
Independent review: REQUEST CHANGES with 2 D-level findings + 1 C overclaim.

## CLP Analysis

### α — What was the structural gap?

The review skill §2.2.1a says: "When the diff adds or modifies a function that filters, sanitizes, or validates, **enumerate every input source** that feeds it."

`check_self_knowledge_path` is a filter. The input sources that can disclose self-knowledge are:
1. `fs_read` — intercepted ✓
2. `fs_list` (direct path) — intercepted ✓
3. `fs_list` (parent directory child entries) — **not checked** ✗
4. `fs_glob` — **not checked** ✗
5. `git_grep` — **not checked** ✗

I checked sources 1-2, stopped, and called it done. §2.2.1a requires exhaustive enumeration.

### β — Why did the divergence happen?

Two causes:

1. **Incomplete input-source enumeration.** I verified the interceptor worked for the paths it covered (`fs_read`, `fs_list` on exact path) but didn't ask "what other observe ops can reveal the same information?" The review skill step existed — I didn't follow it to completion.

2. **Severity miscalibration.** I rated `fs_glob` as C ("reveals path existence, not content — defense-in-depth works"). But the PR claims the failure class is "impossible by construction." A membrane hole in any surface contradicts that claim. When the PR makes an L7 closure claim, any incomplete surface is D, not C.

### γ — What should change?

**Skill gap or application gap?**

§2.2.1a is correctly specified. It says "enumerate every input source" and "mandatory for security-relevant paths." The self-knowledge membrane is a coherence boundary, not a security boundary — but the principle is identical. I treated it as a softer check because the PLAN.md says "this is NOT a security boundary."

**Root cause:** Application gap. The skill is right. I didn't apply it with the rigor the claim demanded. When a PR claims structural impossibility (L7 closure), §2.2.1a must be applied at security-level rigor regardless of whether the boundary is security or coherence.

**Proposed skill patch:** None needed. §2.2.1a already covers this. But a note could be added:

> When a PR claims a failure class is "impossible by construction," apply §2.2.1a at maximum rigor — enumerate all input sources, not just the ones the PR addresses.

This is borderline between application gap and skill underspecification. The skill says "mandatory for security-relevant paths" — a reviewer could interpret a coherence boundary as non-mandatory. Adding an explicit clause tightens that.

### Verdict

Application gap, not skill gap. The rule existed, I didn't follow it fully. The independent review correctly caught what I missed by doing the enumeration I should have done.

No skill patch shipped — this is a MCI (noted, will apply differently). If the same pattern recurs, escalate to MCA (patch the skill with explicit L7-closure rigor clause).
