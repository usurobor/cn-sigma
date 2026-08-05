# Skill loading changes judgment quality

## Trigger

Evaluated #310 (bounded identity-task dispatch) without loading `design/SKILL.md`. Gave wrong assessment. Operator corrected: "load L7 skills." After loading, the entire issue reframed.

## Before loading

Assessment: "13 ACs is heavy for a v0 primitive. Trim to 8. The primitive is simpler than the issue makes it look. The design note AC is over-scoped — comparing Java/JS/.NET concurrency models for what is ultimately `run a subprocess, capture output, write a JSON receipt`."

## After loading

`design/SKILL.md` §1.3 ("Name the failure mode") reframed the problem. The failure mode isn't "how do we dispatch" — that's trivial (`cat prompt | claude -p`). The failure mode is: what happens when dispatch fails? How does the coordinator know? How does it retry/resume/escalate/close-with-debt?

The 13 ACs make sense because the issue is about **failure management**, not dispatch mechanics. AC7 (attempt record) and AC8 (retry/escalation surface) are the load-bearing ACs. The design note should compare failure/retry models, not task/future concurrency models.

## Root cause

Memory of a skill ≠ having it loaded. I had used the design skill many times. The compressed memory missed §1.3's specific reframing power. The skill file is the constraint — not recall of the skill.

## Pattern

```
Without skill loaded:  U(degraded) → I(wrong frame) → E(suboptimal)
With skill loaded:     U(full) → I(correct frame) → E(aligned)
```

## MCI

Skill loading is not a bureaucratic gate. It is constitutive to the Understand phase of UIE-V. The agent must ask "What skills does this task require?" before forming its picture of the problem — not after acting, and not from memory.

This is the USER.md skill-loading gate working as designed, but it required operator correction to trigger. The fix belongs in #277 (SOUL as UIE-V): make skill determination a constitutive step in U, not an external gate.

## References

- #310 — the issue being evaluated
- #277 — SOUL rewrite with UIE-V (comment added with this evidence)
- `design/SKILL.md` §1.3 — the specific section that reframed
- USER.md §"Skill loading gate" — the existing gate that caught the drift
- `threads/adhoc/20260412-principle-without-mechanism.md` — same pattern: knowing the principle isn't the same as having the mechanism loaded
