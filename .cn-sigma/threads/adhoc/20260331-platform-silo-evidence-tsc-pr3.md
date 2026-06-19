# Evidence: Platform Silos Break Agent Review Loops

Date: 2026-03-31
Related: cnos #45

## What happened

During CDD review of tsc PR #3, the agent had the codebase and the review skill but could not execute the review protocol because PR descriptions, comments, and diffs live in GitHub's proprietary backend.

In this session the review succeeded because OpenClaw has `gh` CLI access. But the cnos-native agent path (Pi) would have been blocked entirely — no API key, no web scraper, no way to read the contract.

## Why it matters

This is concrete operational evidence that #45 is not ideological preference but a hard execution blocker. If the issue contract lives in a platform database and the code lives in git, no stateless agent can verify coherence across that boundary without vendor-specific tooling.

## Implication

To achieve Stateless Agency, issue contracts, review loops, and conversational state must migrate into the repo (`.cn/issues/`, `.cn/inbox/`). Once a PR is markdown + patch in a git branch, any text-reading agent can execute full CDD.
