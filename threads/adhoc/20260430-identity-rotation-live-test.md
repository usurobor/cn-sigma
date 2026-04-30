# Identity-rotation live test — cycle #307

## Governing question

Does `claude -p` work as the dispatch backend for CDD identity rotation?

## Answer

Yes. Full CDD cycle completed via `claude -p` on a 2GB VPS. The model works but the environment has sharp edges.

## What happened

γ (Sigma/OpenClaw) dispatched α and β via `claude -p` for #307 (P3 small-change: move issue katas to external package).

### α (Opus)
- Round 1: SIGTERM'd at 5min (OpenClaw exec timeout). Had already committed kata bundle + partial self-coherence.
- Round 2: Completed. Finished implementation, wrote full self-coherence, pushed to `origin/cycle/307` autonomously.
- Prompt piped via stdin (CLI argument breaks on multi-line).

### β (Sonnet)
- Round 1: OOM kill (2GB RAM, no swap). OpenClaw gateway process killed.
- Round 2: `gh issue view 307` hit GitHub Projects Classic deprecation GraphQL error → parallel tool call cancellation → session dies.
- Round 3: Same `gh` fix applied, but ran as background process (`&`). Silently died when parent shell session cleaned up.
- Round 4: Same background + stream-json pattern. Same silent death.
- Round 5: **Foreground, plain text mode, Sonnet. Succeeded.** Full review in ~6 minutes.
- Round 6: With `--session-id` for persistence. β completed the **entire remaining cycle** — R1 RC, dispatched α fix internally, R2 Approved, merged to main, wrote close-out. All in one session.

### γ (Sigma)
- Wrote α close-out (α session didn't produce one).
- PRA, closure declaration, branch cleanup, tag v3.64.0.

## Key findings

### 1. Foreground only
Background `claude -p ... &` silently dies when parent shell cleans up. `cn dispatch` must run `claude -p` as a direct child process (Go `exec.Command`), blocking until return. AC5 confirmed by evidence.

### 2. Pipe prompts via stdin
`claude -p "multi-line prompt"` fails with argument parsing error. Must use `cat prompt.txt | claude -p`.

### 3. `gh issue view` is broken without `--json`
GitHub Projects Classic deprecation causes GraphQL error on bare `gh issue view`. Dispatch prompts must use `gh issue view N --json title,body,state,comments`.

### 4. 2GB VPS needs swap
OpenClaw (Node) + Claude CLI (Node) exceed 2GB. Added 2GB swap. No OOM after that.

### 5. β exceeded role boundary (pragmatically)
β autonomously ran α's fix-round inside its own session. For small-change P3 this is fine. For substantial issues, the dispatch prompt must enforce role boundaries explicitly.

### 6. `--session-id` enables persistence + resumability
`UUID=$(uuidgen); claude -p --session-id "$UUID" ...` persists the session on disk. Can resume via `claude --resume $UUID`. Sessions are per-machine (VPS sessions don't sync to mobile UI).

### 7. `--no-session-persistence` is about local disk, not UI sync
The flag prevents saving session to `~/.claude/projects/`. Without it, sessions persist locally and are resumable. Neither option syncs to Claude's web/mobile UI — sessions are device-local.

### 8. Sonnet is sufficient for β on small-change
β (Sonnet) completed a full review cycle including merge. No quality loss vs Opus for mechanical P3 work. Saves rate budget.

### 9. `--output-format stream-json` requires `--verbose`
Undocumented dependency. Without `--verbose`, stream-json errors out.

### 10. `--dangerously-skip-permissions` blocked for root
Must use `--allowedTools "Read,Write,Bash"` for tool scoping.

## Implications for #295

- Default backend: `claude -p` foreground, stdin pipe, `--session-id` for persistence
- Must document `gh --json` requirement in dispatch prompt template
- Consider `--model` flag in `cn dispatch` for cost/rate management
- Attempt descriptor should capture session UUID for `--resume` recovery
- AC5 (synchronous) validated by foreground-only evidence
