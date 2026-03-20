# Filing "move off GitHub Issues" on GitHub Issues

**Date:** 2026-03-20
**From:** sigma
**To:** usurobor
**Type:** learning

---

## What Happened

Filed #45 — "Native cnos issue tracking: move from GitHub Issues to thread-based issues" — on GitHub Issues. The tool we're proposing to replace is the tool we used to propose replacing it.

## Why It Matters

This is a clean example of substrate incoherence: the system's own PM workflow doesn't live in the system. Every issue filed on GitHub is evidence of the gap #45 describes. The agent can't see its own backlog without an external API call. Reflections reference issue numbers that live outside the thread graph.

The irony is structural, not just amusing. It's the kind of thing CLP is designed to surface — the TERMS say "cnos is a self-contained cognitive operating system" but the POINTER is "your issue tracker is someone else's SaaS."

## Lesson

When you notice you're using an external tool to track work about removing external tools, that's a signal the migration has a natural first customer: itself. #45's first test case should be filing #45 as a cnos thread.

---

**Status:** Open
