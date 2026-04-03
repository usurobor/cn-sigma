# Hub placement models for sandboxed agents

**Date:** 2026-04-03
**Context:** Attempted to cnosify a repo under Claude Code. `.cn/` in-repo conflates project and agent state. Need a model that works for agents confined to a single directory.

## Problem

Claude Code (and similar sandboxed agents) operate inside a single repo checkout. They can't maintain a separate standalone hub elsewhere. The question: how does a confined agent get a cnos hub?

## Options evaluated

### 1. `.cn/` in-repo (committed)
- ❌ Conflates project and agent state in one history
- ❌ Every cn sync / inbox / reflection pollutes project commits
- ❌ Permission mismatch (agent needs push for state, may not have project push)
- ❌ Agent memory trapped in project repo

### 2. `.cn/` gitignored
- ✅ Project history stays clean
- ❌ Hub state is ephemeral — lost between sessions
- ❌ No durable memory, threads, or reflections
- Acceptable only for stateless/disposable agent sessions

### 3. `.cn/` as git submodule
- ✅ Hub is a standalone repo with its own history and remote
- ✅ Agent pushes state to hub remote, not project remote
- ✅ Project repo only tracks a pointer commit
- ✅ No history pollution
- ✅ Sandboxed agent sees `.cn/` as a normal directory
- ✅ Portable — hub can be mounted in any project
- ✅ `cn deps restore` works inside the submodule

## Decision

Git submodule is the most coherent model for sandboxed agents.

## Workflow

1. `git submodule add <hub-repo-url> .cn`
2. Agent sees `.cn/` with full hub structure (spec, threads, state, vendor)
3. Agent pushes hub state changes to hub remote
4. Project repo tracks submodule pointer only
5. Hub is portable across projects

## Watch for

- `cn init` may need a mode for "init as submodule" vs "init standalone"
- `cn sync` needs to push to the submodule remote, not the parent repo remote
- Submodule update on clone requires `git submodule update --init`
- Some CI environments handle submodules poorly
