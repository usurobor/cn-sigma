# Three-Agent CDD — First Full Proof

**Date:** 2026-04-12
**Trigger:** MVA sprint executed across alpha/beta/sigma in one session

## What happened

Full CDD loop ran with three agents:
- **Alpha** (Claude Code) — implemented #227 and #226
- **Beta** (Claude Code) — reviewed, merged, released, post-release assessed
- **Sigma** (OpenClaw) — coordinated: issue creation, handoff prompts, CDD compliance verification, hub memory, caught what the others missed

Two issues implemented, reviewed, merged, released, and assessed (v3.51.0, v3.52.0) in one operator session. Third issue (#233, MVA Step 4) filed and queued.

## What each agent caught that the others didn't

| Agent | Catch | Why only them |
|-------|-------|---------------|
| Alpha | Self-corrected T-002 dispatch boundary violation | CI mechanism — no agent needed to know the rule |
| Beta R1 | 5 findings on #229 (type duplication, non-deterministic lockfile, dead parameter, stale comment, version skip) | Independent review context |
| Beta R2 | 4 findings on #231 (dead code, reimplemented stdlib, path confinement, unwrapped error) | Same |
| Sigma | #228 had 3 internal contradictions (overclaimed scope, false parallelism, activation index ghost) | Loaded issue skill, cross-checked |
| Sigma | Tag convention wrong (v3.51.0 not 3.51.0) | Loaded release skill, checked §2.6 |
| Sigma | Mechanical ratio filing was premature (4-finding sample) | Statistical judgment |
| Sigma | hubstatus.go broken for new vendor path format | Read the code, connected to #229 change |
| Sigma | #227 missing skills/constraints section for handoff | Loaded issue skill §2.4 |
| Operator | "Why self-review instead of pre-loading?" | Meta-judgment on fix quality |
| Operator | "More importantly fix the issue skill" | MCA over one-off fix |
| Operator | "Isn't it MCA?" | Kept sigma honest about fix level |

## The coordination model

```
Operator
  ↓ judgment calls, approval gates
Sigma (coordinator)
  ↓ issues, prompts, verification
Alpha (implementer) ←→ Beta (reviewer/releaser)
  ↑ CI mechanisms (T-002, I1, I2)
```

Current bottleneck: **operator copy-paste between sessions.** Each handoff is minutes of latency. The agents can't talk to each other directly.

## The future model

Once cnos has its own transport (peer sync, inbox, or whatever ships), the agents communicate directly:
- Sigma writes issue → alpha picks it up from inbox
- Alpha opens PR → beta picks it up from inbox
- Beta merges → sigma picks up the post-release verification
- Operator approves at gates, intervenes on judgment calls

No paste. No OpenClaw routing. cnos IS the communication substrate. The agents are peers on the same hub network.

## What this means for cnos

The MVA sprint is building the runtime that these agents will run on. The package system, command discovery, runtime contract — that's not abstract infrastructure. It's the substrate for multi-agent CDD.

The three-agent loop we ran today is the use case. cnos is building itself the platform it needs to run on.

## Economics

- $200/mo unlimited Claude Code (alpha + beta sessions)
- OpenClaw cost for sigma
- One operator session (~6 hours)
- Output: 2 releases, 3 CDD skill patches, 5 adhoc threads, MVA sprint planned and 75% complete

Equivalent human team cost: 2 senior engineers × 1 day = $2-4k at market rates. And the CDD discipline was higher than most human teams achieve because the skills are loaded mechanically, not remembered culturally.

## What to watch for

- Agent quality on self-correction: alpha hit T-002 and fixed it. Would it catch a subtler architectural violation without a CI grep?
- Sigma's coordination overhead: writing handoff prompts is fast but verifying post-release compliance is slow. Can more of that be mechanicalized?
- The "operator as bottleneck" pattern: judgment calls can't be delegated. But the copy-paste latency can be eliminated once agents communicate directly.
- The skill-loading gate is the single most important mechanism. Every failure today traced back to either loading the skill (success) or skipping it (failure).
