---
title: CDD bundle final normalization
date: 2026-04-03
status: closed
---

## What happened

Operator reviewed the CDD bundle and identified 4 remaining gaps:
1. Stale delegation paths (partially already fixed)
2. Gamma README stale paths (already fixed)
3. Frontmatter incomplete on some skills (governing_question missing on plan/issue)
4. Kata surfaces not visible in live bundle

## What changed

Two commits (`6f00c66`, `2a64a8a`):
- All 7 artifacts: `artifact_class`, `kata_surface`, `governing_question` present
- Governing questions reframed as "How do we..." process questions
- plan/issue: `governing_question` added
- cdd kata: expanded to full Scenario/Task/Governing skills/Expected artifacts/Verification/Common failures
- Descriptions tightened on review, release, post-release
- Last stale path fixed: §2.8 `release/SKILL.md` → `cdd/release/SKILL.md`

## Status

Bundle is now fully consistent with corpus contract. Operator verdict: coherent, complete, consistent.
