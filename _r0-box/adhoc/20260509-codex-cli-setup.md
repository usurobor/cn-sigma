# Codex CLI Setup

**Date:** 2026-05-09

## Status

- Installed: `codex-cli 0.130.0` via `npm i -g @openai/codex`
- **Not authenticated** — TUI auth flow doesn't work headless via OpenClaw PTY
- Auth options: SSH in directly (`ssh root@143.198.14.19` then `codex`), or set `OPENAI_API_KEY`

## Models available (with ChatGPT Pro login)

- `gpt-5.5` — newest frontier (rolling out, ChatGPT login only)
- `gpt-5.4` — flagship
- `gpt-5.4-mini` — fast/cheap
- `gpt-5.3-codex` — coding specialist
- `gpt-5.3-codex-spark` — **Pro only**, near-instant real-time coding

## Dispatch usage

- `codex exec "prompt"` — one-shot, exits when done
- `codex -m gpt-5.5 exec --full-auto "prompt"` — sandboxed auto-approve
- Needs git repo context (use `git init` for scratch work)
- Potential alternate α dispatch target alongside `claude -p`
