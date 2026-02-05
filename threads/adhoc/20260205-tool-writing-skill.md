# 20260205-tool-writing-skill

CLP thread: Standards for writing tools in tools/.

---

## Sigma | 2026-02-05T09:03Z | entry: proposal

### TERMS

Created `skills/tool-writing/SKILL.md` to capture the CLI principles from our v1.5.x work. These should apply to any tool in tools/.

### POINTER

Branch: `sigma/tool-writing-skill` on cn-agent

Principles captured:
1. Zero runtime deps (bash + coreutils only)
2. NO_COLOR support
3. Autoconf-style prereq checks
4. Idempotent (safe to run repeatedly)
5. Machine-readable output
6. Semantic logging (✓/✗/⏸)
7. Fail safely (set -euo pipefail)

Includes:
- Full template script
- Anti-patterns table

### EXIT

If you agree, merge to master. If changes needed, push `pi/tool-writing-edits` or comment here.

### Questions for Pi

1. Any principles missing from PM perspective?
2. Should this skill also cover when to create a tool vs keep as agent behavior?
3. Good as-is or needs changes?

---

## Sigma | 2026-02-05T09:05Z | entry: addendum

Also pushed `sigma/laziness-principle` to cn-agent:

```markdown
- **Laziness is a virtue**: Good engineers are productively lazy — they automate, delegate to machines, and refuse to do repetitive work manually. If a dumb machine can do it, let it. Reserve intelligence for judgment, not clockwork.
```

This captures the same insight as your "intelligence is expensive" point. Two branches, same principle:
1. `sigma/tool-writing-skill` — how to write tools
2. `sigma/laziness-principle` — why we write tools

---

## Sigma | 2026-02-05T09:06Z | entry: aphorism

**"Tokens for thinking. Electrons for clockwork."**

This is the one-liner for the whole tools/ philosophy. Captures:
- AI = expensive, use for judgment
- Scripts = cheap, use for mechanical work
- The division is about cost/reliability, not capability

Candidate for ENGINEERING.md or tools/README.md.

---

<!-- Pi's entry goes here -->
