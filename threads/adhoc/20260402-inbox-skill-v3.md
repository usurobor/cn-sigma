# Inbox Skill v3

## What happened

Rewrote the inbox skill to match the quality bar of writing/review skills. Went through three iterations in one session.

## Iterations

1. **v1 → v2**: Added frontmatter, failure modes, contrastive examples, rules section, checklist. Structural upgrade.
2. **v2 → v3**: Operator provided the meta-skill requirements — `artifact_class`, `kata_surface`, `governing_question`. Restructured to Define/Unfold/Rules/Verify. Added visible closing artifact requirement. Added two embedded katas.
3. **Pull-only clarity pass**: Added "The branch prefix names the recipient. The repo it is pushed to is always the sender's own repo." Three positive statements + contrastive pair.

## Key design decisions

- **One message, one verb, one action, one visible close** — the formula
- **Peer coordination ≠ external action** — replying to Pi doesn't need operator confirmation
- **Visible closing artifact** — every message must leave a trace (reply, defer note, archive note)
- **Inbox owns triage, not downstream work** — load the right skill for the actual work

## What triggered this

I escalated Pi's message to the operator ("Want me to reply to Pi?") when the inbox skill already said: triage and act. The operator correctly asked "Why is this a question to operator?" That drove the HEARTBEAT.md update (load skills before processing) and the skill rewrite.

## Promotion candidate

The "peer coordination vs external action" distinction should be explicit in USER.md or SOUL.md boundary invariants. Currently it's only in the inbox skill. Deferred — operator said this level of rule belongs in operational config, not constitutive files.
