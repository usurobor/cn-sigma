# Claude CLI vs API: dispatch backend economics

## Governing question

When should cnos (and OpenClaw) use Claude Code CLI (`claude -p`) instead of the Anthropic API?

## Finding

Claude Code CLI authenticates via Pro/Max subscription. Usage draws from plan allocation — no per-token API billing. The API charges per token.

For bounded, one-shot tasks — the exact shape `cn dispatch` produces — CLI is the cheaper surface. For multi-turn, streaming, tool-routed conversations (OpenClaw's core loop), the API gives control CLI can't.

## The boundary

| Need | Surface | Why |
| --- | --- | --- |
| One-shot bounded task | `claude -p --no-session-persistence` | Fresh session, stdout return, subscription cost, no streaming needed |
| Multi-turn conversation | Anthropic API | Streaming, mid-flight tool routing, session continuation, context injection |
| Sub-agent / background job | CLI preferred | Fire-and-wait, no conversation state, subscription cost |
| Interactive agent session | API preferred | Persistent connection, compaction, multi-channel dispatch |

## Confirmed on cn-sigma (2026-04-30)

- Installed Claude Code CLI v2.1.123 via `npm install -g @anthropic-ai/claude-code`
- `claude -p "Write 'hello from alpha' to /tmp/subagent-test.txt" --allowedTools "Write,Read"` succeeded
- Root user blocks `--dangerously-skip-permissions`; `--allowedTools` is the correct scoping mechanism
- `--no-session-persistence` prevents Claude from saving session history (cognitive isolation for CDD roles)

## Implication for cn dispatch (#295)

`cn dispatch` uses `claude -p --no-session-persistence` as default backend. This is the right fit: bounded role invocation, subscription-cost, no session persistence needed.

Backend adapter pattern (`CN_DISPATCH_BACKEND=claude|codex|stub|print`) keeps the primitive backend-agnostic. Other CLIs (OpenAI Codex `codex -q`) fit the same shape.

## Implication for OpenClaw

OpenClaw's `sessions_spawn` could offer a Claude CLI backend for one-shot sub-agents. The main session loop (streaming, tool routing, multi-turn) stays on the API. Hybrid model: API for conversations, CLI for tasks.

Not raised as an issue — captured here for future reference.

## Billing nuance

- Pro/Max subscription: usage draws from plan allocation, subject to rate limits
- `ANTHROPIC_API_KEY` set: API billing applies even through CLI
- Rate limits exist on Max; heavy dispatch loops may hit them
- Tests must use stub backend, never live credentials
