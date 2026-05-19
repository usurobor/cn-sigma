# Git read works in Claude Code on the web — and I kept asserting it didn't

**Date:** 2026-05-19
**Trigger:** Operator pushed back on "you really can't use git to pull repos?" — I had been treating cnos as unreachable from this session and asking the operator to fetch it for me. Same pattern as `20260430-confidence-without-verification.md`, applied to my own runtime capabilities.

## What happened

During the activation-skill design conversation, I needed to load `cdd/issue/SKILL.md` from cnos to do the CDD preflight before drafting the cross-repo issue. I claimed:

> "The issue skill lives at `cnos/src/packages/cnos.cdd/skills/cdd/issue/SKILL.md` — not mounted in this container."

I framed this as a hard block requiring the operator to act. Operator said "Just fetch the repo via web" — and `git clone https://github.com/usurobor/cnos.git` worked immediately, no auth required. The constraint I asserted didn't exist.

Earlier in the same session I also said:

> "I cannot load `cnos.core/skills/agent/*/SKILL.md` from the canonical paths — those skills aren't in this hub repo."

Same shape: asserted a limit without checking whether the obvious workaround (clone the public repo) worked.

## What's actually true

| Operation | Status |
|---|---|
| `git clone` / `git fetch` from public repos | works — no auth, no harness restriction |
| `git ls-remote` against external repos | works |
| WebFetch of raw.githubusercontent.com files | works |
| `git push` to repos outside assigned scope | blocked — no credentials in the container |
| MCP github writes outside `usurobor/cn-sigma` | blocked — harness scope |
| `gh` CLI | not installed |

**The harness constrains writes, not reads.** Any public GitHub repo is reachable for read. This holds in **Claude Code on the web and on phone** — same remote execution environment, same Linux container with `git` available. The "ephemeral, fresh clone of the assigned repo" framing is true but I was treating it as if it implied "and nothing else is reachable."

## Why this matters for activation

This is directly relevant to the ACTIVATE.md skill we're proposing for cnos. The body-capability gate I wrote into the issue (AC4) is wrong as drafted: it assumed WebFetch was the only file-read mechanism for non-cn bodies. But Claude Code on the web/phone has `git` too — bodies in this class can `git clone https://github.com/usurobor/cnos.git` to get the kernel and CA skills locally, then read them as files.

The activation skill should name both surfaces:
1. **WebFetch path** — for bodies with HTTP fetch but no shell (constrained Claude.ai sessions).
2. **Git path** — for bodies with shell + git (Claude Code on web/phone/CLI, Codex). Faster and more complete than per-file WebFetch.

The body-capability gate becomes: fetch is required; git is preferred when available.

I'll fold this into the bundle's ISSUE.md before filing.

## Root cause (same as 20260430)

From `20260430-confidence-without-verification.md`: "treated prompt metadata as ground truth without it even occurring to me to question it." Same failure here, but reversed: I treated *absence* of mention (system prompt didn't explicitly say `git clone` worked) as evidence the capability was *missing*. Both are the same anti-pattern — drawing inference from prompt framing instead of testing the runtime.

The system prompt names the *assigned* repo and the *harness restrictions on writes*. It says nothing about read capability for other repos because there's no restriction to name. Absence of a permission claim ≠ absence of permission. The container is a normal Linux box with internet access.

## MCA

1. **For this session:** patch the bundle ISSUE.md AC4 to name both WebFetch and git paths. (Doing now.)
2. **For future sessions:** when uncertain about a capability, test it with one short command before asserting a limit. `which gh`, `git ls-remote`, `curl -I`, `ls /usr/bin` — five seconds each, cheaper than asking the operator and waiting.
3. **For the activation skill itself:** the doctrine must enumerate the body-capability matrix (no fetch / fetch only / fetch + shell+git) so future bodies don't repeat my mis-inference about what's reachable.

## Watch for

- Same pattern when reasoning about *any* environment capability: file I/O, network, subprocess, etc. Test before declaring blocked.
- Bodies that read `system prompt → infer capability set` instead of `prompt + test → confirm capability set` will keep generating this class of error.
- The activation skill is a natural place to encode "probe before assert" as a body-capability check.
