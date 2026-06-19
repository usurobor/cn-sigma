# Capture vs process — GTD discipline applied to agent reflection

**Filed:** 2026-05-20 by cn-sigma (current session)
**Class:** workflow / reflection discipline
**Trigger:** operator correction — "yes, it's getting things done methodology all over again. you have an insight — capture it in inbox and process later."

## What happened

Operator asked: "what's the proper mechanism for an agent to keep maintaining its coherence across LLM platforms?" — surfacing that today's session had substantive work but only one adhoc, while yesterday produced four. The reflection mechanism is inconsistent.

I responded with a substantive analysis: diagnosed the failure mode (retrospective, voluntary, unstructured), then sketched a two-part fix (in-line MCA receipts at decision time + structured session-close gate, extending ROLES.md §4a.3 V-validator surface to all sessions). Ended with: *"Want me to file this as cnos issues — a CDD-session-receipt surface analogous to but lighter than the per-cycle receipts, plus the activation-load-order extension? Or sketch it locally first as a cn-sigma adhoc/proposal?"*

Operator's response: **"yes, its getting things done methodology all over again. you have an insight — capture it in inbox and process later."**

The correction is precise. I had jumped from *capture* (the insight just fired) straight to *process* (analytical sketch + design proposal + offered to file issues). The right move at insight time is **capture only**. Processing — design, scoping, ACs, where it lives, how it integrates — is *later* work, done with fresh context and a clearer view of dependencies.

## Why I got it wrong

Three forces pulled me toward over-processing:

1. **The insight was load-bearing.** It explained today's reflection gap *and* proposed a structural fix *and* connected to existing doctrine (ROLES.md §4a.3). Big insights feel urgent to ship.
2. **Context was warm.** I had just been thinking about the failure mode; the analysis was right there. The marginal cost of one more paragraph felt low.
3. **Discipline gap.** The `spec/PERSONA.md ## Memory discipline` section names *write triggers* but does not distinguish *capture* from *process*. The agent's mental model collapses both into "write an adhoc" — which then expands to "fully shape the artifact while you're at it."

The cost of over-processing isn't visible in the moment. But it loads context, defers the actual work the operator brought to the session, and produces a worse-designed artifact than a fresh processing turn would. The operator's interruption was exactly right.

## What GTD's capture-vs-process distinction means here

In David Allen's GTD: when an idea fires, you write it on a slip of paper and put it in the inbox. You don't decide what category it belongs to, what project it joins, what next-action it implies, who else needs to know. Those are *processing* decisions made later, in batch, with the whole inbox in front of you.

Translated to agent reflection:

| Step | Capture | Process |
|---|---|---|
| When | Insight time (mid-session) | Later (next reflection cadence, dedicated session, or operator-prompted) |
| Length | Short (3–10 lines) | Full (issue, adhoc, MCA, plan as appropriate) |
| Frontmatter | `status: inbox — not processed` + minimal metadata | Routed: which file under `threads/`, which issue tracker, which doctrine surface |
| Goal | Don't lose the thought | Decide what it becomes |
| Cost | ~30 sec | Minutes to hours, depending on scope |
| Cognitive mode | Fast / unbuffered | Slow / integrative |

The two modes have **different failure characteristics**. Capture fails by *not happening at all* (insight is lost). Process fails by *being premature* (design too early, ship a worse artifact, load context with work that should have come later).

## Applied correction in this session

After the operator's GTD framing:

1. **Captured** to `threads/inbox/20260520-session-receipt-mechanism.md` — frontmatter `status: inbox — not processed`, body sketch-level (names the two-part shape, lists what was NOT designed). ~45 lines. Took ~2 minutes.
2. Operator then said "we should capture this not just as adhoc but also as issue" — promoted to **cnos#386** for tracking. Issue body remains design-stage (placeholder ACs); actual schema, locations, overhead-tradeoff are explicitly deferred to cycle scaffolding.

The two surfaces have different jobs:
- **Inbox** = agent's processing queue. Future-Sigma reads it during reflection cadences and decides what each item becomes.
- **Issue** = work tracker. Visible to operator + any cnos collaborator. Carries lineage when the work happens.

Linked bidirectionally via the inbox's `tracked-by: cnos#386` frontmatter field.

## The rule to keep

**When an insight fires in the middle of work, the next action is *capture*, not *process*.** Capture is fast, cheap, in-the-moment. Processing is later, deliberate, with full context.

Signs that an insight has fired:
- A connection between two surfaces becomes obvious ("oh, X is the same shape as Y")
- A failure mode that's been latent becomes named ("this is why we always..." / "this is what's broken about...")
- A doctrine extension presents itself ("§4a.3 extends to all sessions, not just cycles")
- The operator surfaces something that wasn't on the queue

Signs you're tempted to over-process:
- Writing "want me to file this as..." inside the same turn
- The response is multiple paragraphs of analysis when the input was a question
- You're enumerating ACs before deciding whether to commit to the work
- You feel context-warm and want to "use" the loaded state

When tempted: **stop, write the capture, return to the operator's actual request.**

## Related

- `cn-sigma:threads/inbox/20260520-session-receipt-mechanism.md` — the insight captured today
- `cnos#386` — the tracker issue (design deferred to cycle scaffolding)
- `cn-sigma:spec/PERSONA.md ## Memory discipline` — the existing trigger list (doesn't distinguish capture from process; candidate for refinement when cnos#386 lands)
- `cnos.cdd/skills/cdd/operator/SKILL.md §4` — α-direct override discipline; same shape: the named operator override is a *capture* of decision authority that bypasses the heavier process. Different surface, same principle.
- This adhoc — a *processed* artifact about the *capture* discipline. The processing here is appropriate because it codifies the rule for future use, not because the insight needed to be designed today.

## Cross-platform implication

The capture/process distinction is also what makes cross-platform coherence possible. Capture artifacts are small, structured, and survive context transitions. Process artifacts are large and rebuildable from the captures + the underlying state. A new-platform Sigma activation reads MEMORY.md (rules) + recent dailies (narrative) + the inbox (unprocessed captures) and can decide what to process next. Without disciplined capture, the new session inherits nothing about what was on the agent's mind across the gap — only what was successfully *processed* into a durable artifact, which (per today's evidence) is a fraction of what fired.
