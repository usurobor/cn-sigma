# Reading source-branch content without polluting main's index

**Filed:** 2026-05-20 by cn-sigma δ
**Class:** workflow / git ergonomics
**Trigger:** δ-bootstrap dispatch — three operator-pending bundles staged on `cnos:claude/file-cnos-cdr-issue-fi9Ld`; δ needed to read their content from `/root/cnos` (currently checked out to `main`)

## What happened

Brief said "read source content from this branch ref OR wait until operator merges to main and read from there." Main didn't yet carry the branch's content. I reached for the obvious command from `/root/cnos`:

```
git checkout cb1bf430 -- .cdd/iterations/cross-repo/
```

This is the path-restricted form of `git checkout` against a commit ref. Its actual behaviour:

1. Reads the listed tree paths from `cb1bf430`.
2. Writes them into the **working tree** at those paths.
3. Updates the **index** to match (i.e. **stages** them).
4. Leaves `HEAD` and the branch ref untouched.

Step 3 is the trap. Until I ran `git status` I had **14 files staged** for the next commit on cnos main — three were the bundles I wanted to read, the other 11 were unrelated bundles from the same `.cdd/iterations/cross-repo/` directory that I'd swept in with the directory-level checkout.

```
A  .cdd/iterations/cross-repo/cn-rho/bootstrap-2026-05-19/LINEAGE.md
A  .cdd/iterations/cross-repo/cn-rho/bootstrap-2026-05-19/OPERATOR.md
A  .cdd/iterations/cross-repo/cn-rho/bootstrap-2026-05-19/PERSONA.md
A  .cdd/iterations/cross-repo/cn-sigma/agent-activate-skill/FEEDBACK.patch
M  .cdd/iterations/cross-repo/cn-sigma/agent-activate-skill/LINEAGE.md
A  .cdd/iterations/cross-repo/cn-sigma/discipline-section-2026-05-19/LINEAGE.md
A  .cdd/iterations/cross-repo/cn-sigma/discipline-section-2026-05-19/PERSONA-discipline.patch
A  .cdd/iterations/cross-repo/cph/coherence-drift-sweep-followup-2026-05-18/...
A  .cdd/iterations/cross-repo/cph/issue-32-tightening-2026-05-19/LINEAGE.md
A  .cdd/iterations/cross-repo/cph/issue-32-tightening-2026-05-19/issue-comment.md
A  .cdd/iterations/cross-repo/gait-support-paths/bootstrap-cdr/...
?? .claude/worktrees/
```

If a δ in autopilot mode runs `git commit -am "..."` after reading the files (a habit when finishing a small task), the commit would carry cnos γ's source-branch work product onto cnos main without review or release. That's not a dispatched cycle — it's a side-channel promotion of branch work, attributed to whoever's identity is set locally, bypassing the entire CDD pipeline.

I caught it at the final state-check step (`git status` before declaring the deliverables done) and unstaged with `git reset HEAD -- .cdd/iterations/cross-repo/` + cleaned the working tree.

## Why I almost did the wrong thing

The brief explicitly authorised reading from the branch ref. `git checkout <ref> -- <path>` is the form most engineers reach for when reading from a non-current branch. The mental model is "checkout = bring this in," and most of the time the implicit staging is what you wanted (you're about to commit the change). For *read-only* use, the staging is unwanted side-effect, but git doesn't distinguish the two intents at the command level.

## Better tools for read-only branch access

### `git show <ref>:<path>`

Writes to stdout. No filesystem change, no index change.

```
git show cb1bf430:.cdd/iterations/cross-repo/cn-rho/bootstrap-2026-05-19/PERSONA.md
```

Best for reading individual files. Pipe to `less`, `cat`, or redirect to `/tmp/` for inspection. Combine with `git ls-tree -r <ref> -- <path>` to enumerate the tree first.

### `git worktree add <dir> <ref>`

Creates a separate working tree at a different path, checked out to the ref. The main repo's HEAD/index/working tree is untouched.

```
git worktree add /tmp/cnos-branch-read cb1bf430
# read files at /tmp/cnos-branch-read/...
git worktree remove /tmp/cnos-branch-read
```

Best for substantial multi-file reads where you want filesystem access (find, grep, scripts). Cheap (worktrees share `.git/`); the cleanup is explicit.

### `git ls-tree` + `git cat-file`

Plumbing-level. Lists tree contents at a ref + dumps blob contents by SHA. Best for scripts that need to enumerate + read without touching the working copy at all.

### What about `git checkout <ref> -- <path>` then `git reset HEAD <path>`?

Works, but is the failure mode that triggered this adhoc: you have to remember the `reset` step, and the window between the two commands has the wrong-shape state on disk. If anything interrupts (terminal closes, agent crashes, you forget) the staging persists silently.

## Rule of thumb

**If you don't intend to commit it, don't `git checkout <ref> -- <path>` it.**

For δ work that reads from a branch other than the one currently checked out:
- Single file → `git show <ref>:<path>`
- Tree subset, no edits → `git ls-tree -r <ref> -- <path>` to list, `git show <ref>:<each>` to read
- Tree subset, with edits or scripts → `git worktree add`

This applies symmetrically when working from a CDD repo against a hub's branch, or from a hub against a CDD repo's branch — the workspace is whatever working tree the δ session lives in, and that workspace's index is the live commit surface.

## Failure mode this prevents

A δ who reads source-branch content via `git checkout <ref> --` and commits in the same session can side-channel-promote unreviewed branch work onto main. The promotion shows up as a commit by the δ's local identity, not by cnos γ. Cycle ledger, release manifest, and PR-review history all miss the change. It's the worst kind of regression: silent, unattributed, lossy of provenance.

The trap is most acute for cross-repo δ-bootstrap dispatches because:
- The δ is working from a target repo (e.g. cn-sigma) but reading source from a different repo (cnos)
- The δ may also have the *cnos* checkout open in the same session for read access
- A muscle-memory `git commit -am` in the wrong terminal is enough

## Related

- `feedback-dispatch-observable` — JSONL log + stream-json for dispatched agents (different surface but same class: tooling that has unintended persistence side-effects when run from the agent's primary workspace)
- `operator/SKILL.md §4` — α-direct override discipline; a δ doing both reads and writes in the same session needs the same kind of "what surface are you actually modifying right now" attention
- `cn-sigma:.cdd/iterations/cross-repo/` (this hub) — paired example: hub stores source-side bundles, target γ reads them via `git show` or `gh api`, never via `git checkout --`

## What I'll do differently

For future δ-bootstrap reads from a source branch:
1. Default to `git show <ref>:<path>` for single files.
2. Use `git worktree add` for tree-level reads, with explicit cleanup at the end.
3. If `git checkout <ref> --` is genuinely the right tool (rare; usually means I'm about to commit), do it on a dedicated branch, never on main.
4. Always `git status` before the final declare-done step in a δ session, regardless of how mechanical the work felt.
