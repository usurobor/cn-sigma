# Squash-merge destroys .cdd/ artifacts

**Date:** 2026-04-16

## What happened

α committed `.cdd/releases/3.56.0/alpha/254.md` on the PR branch (commit a72b0a4) per §1.4 step 11. β squash-merged PR #257. GH squash-merge collapsed all branch commits into one — but the squash only included the code diff, not the `.cdd/` artifact. Branch deletion orphaned the close-out commit.

## Root cause

Process gap: §1.4 step 11 said "write close-out" but didn't specify where. α naturally committed to the branch (where the work was). Squash-merge is a lossy operation for non-code artifacts.

## Fix

**MCA shipped** — §1.4 step 11 now reads: "Commit close-out to main directly (not the PR branch) — squash-merge destroys branch-only files."

Commit: `23cd6e69` (docs: post-release assessment for 3.56.0 + §1.4 step 11 patch)

## Generalization

Any CDD artifact committed to a PR branch will be lost on squash-merge. This applies to:
- α close-outs
- β close-outs
- Any `.cdd/` directory content

Rule: process artifacts go to main. Code goes to branches. Squash-merge is safe for code but lossy for process.

## Connection

This is the same class of problem as the dual-source findings from cycle #251 — two locations for the same thing creates ambiguity. One source of truth for close-outs: main.
