# Adhoc — Multi-agent ping-pong: GPT + Claude convergence protocol

**Date:** 2026-05-13
**Context:** cnos #357, #358, tsc #50-54 issue refinement

## Pattern discovered

GPT (Codex CLI) and Claude (claude -p) can be run in alternating rounds on the same artifact until they converge. This produces higher-quality issue packs than either agent alone.

## Protocol

1. α (GPT or Claude) writes first draft to `/tmp/file-r1.md`
2. β (the other agent) reviews, critiques, rewrites to `/tmp/file-r2.md`
3. α reviews β's changes, writes converged version to `/tmp/file-r3.md` with `<!-- CONVERGED: yes/no -->`
4. If no, β does final check. If yes, apply to GitHub.

Typical convergence: 3 rounds. Both agents mark `CONVERGED: yes`.

## Codex CLI configuration

```bash
codex exec \
  -m gpt-5.5 \
  -c 'model_reasoning_effort="high"' \
  -c 'model_verbosity="high"' \
  -c 'max_output_tokens=64000' \
  -s danger-full-access \
  -o /tmp/output.md \
  "prompt"
```

- ChatGPT account auth blocks `-m o3`, `-m gpt-4.1`, `-m o4-mini` — use model names from Codex model list
- Default model is gpt-5.5 (available to Plus and above)
- `gpt-5.3-codex-spark` is Pro-only (confirmed working on this account)
- `--reasoning` and `--thinking` flags don't exist on `codex exec` — use `-c` config overrides

## Observations

- GPT tends to over-build on R1 (999 lines for #358), Claude trims aggressively on R2, GPT restores needed detail on R3
- Claude is better at identifying over-specification; GPT is better at structural completeness
- For issue packs: convergence consistently produced better results than either alone
- For implementations: parallel runs on separate branches allow direct comparison
- Cost: ~30k-250k tokens per agent per run depending on scope

## When to use

- Issue pack refinement (high value — catches different failure modes)
- Implementation comparison (parallel branches, choose best)
- Design proposals (GPT proposes, Claude simplifies, GPT restores)

## When not to use

- Simple mechanical changes (overkill)
- Time-critical single-issue cycles (wave dispatch is faster)
- When the spec is already tight (agents agree immediately, no value added)
