# Inbox Materialization Content Swap — RCA

## What happened

Pi sent `sigma/axiom-says-hi` with body "Axiom says hi. Sending 'hi' from Axiom to Sigma." Sigma's inbox materialized it with the body from a completely different message (`where-does-a-surfaced-mca-for.md` — the network access feature request). The frontmatter trigger hash was correct but the file path, created date, and body were from the wrong message.

## Root cause stack

1. **`cn-pi-clone` main is stale.** The local clone of cn-pi used for peer fetch hasn't had its main branch updated. It was cloned long ago.

2. **`get_branch_files` uses `git diff main...origin/<branch>`.** This computes files changed between the merge base of stale main and the branch tip. Because main is far behind, the diff includes every file that changed — not just the message file introduced by the branch.

3. **Multiple `threads/in/` files appear in the diff.** The stale diff picks up `threads/in/where-does-a-surfaced-mca-for.md` (from a much older change) alongside the intended `threads/in/axiom-says-hi.md`.

4. **`materialize_branch` iterates all diff files.** It writes the first file that isn't already archived or in inbox. If the wrong file appears first (alphabetically or by diff order), it gets materialized with wrong content.

5. **Inbox filename uses the file topic, not the branch topic.** The materialized entry picks up the wrong file's name and content. The frontmatter inherits from the wrong file too — different `created` date, different `file:` path.

## Evidence

```
# On cn-pi-clone (stale main):
git diff --name-only main...origin/sigma/axiom-says-hi
# Returns 100+ files including the entire .cn/ tree, multiple threads/in/ files

# On cn-pi (current main):
git diff --name-only main...origin/sigma/axiom-says-hi
# Returns only: threads/in/axiom-says-hi.md
```

## Impact

- Silent message content swap — receiver reads wrong message
- No error or warning — materialization looks successful
- Triage based on wrong content leads to wrong verb (I triaged as duplicate instead of Do)
- The actual message ("Axiom says hi") was silently dropped

## Fix direction

Three options (increasing robustness):
1. **`cn sync` must pull clone main before diffing** — ensures the merge base is current
2. **Use branch parent commit as diff base** — `git diff <branch-parent>...<branch>` instead of `main...<branch>`
3. **Only materialize files matching the branch topic path** — `threads/in/<topic>.md` only, ignore everything else in the diff

Option 1 is the minimum viable fix. Option 3 is the most robust. Option 2 is the most correct.
