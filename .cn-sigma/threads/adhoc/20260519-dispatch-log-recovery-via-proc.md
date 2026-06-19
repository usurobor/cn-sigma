# Dispatch log recovery via /proc/PID/fd after /tmp wipe — 2026-05-19

**Trigger:** Dispatched γ via `claude -p ... > /tmp/dispatch-379/gamma.jsonl 2>&1 &` per `feedback-dispatch-observable`. Five seconds later, the JSONL was 159 KB and growing. Three minutes later, `ls /tmp/dispatch-379/` showed an empty directory. γ was still running and producing output. The redirect target had been **unlinked** from the filesystem while the open file descriptor was still receiving writes.

## What's actually happening

γ's own toolchain ran `rm -rf /tmp/dispatch-379` as part of some scratch-hygiene judgment early in its session. That deleted the directory contents — including the JSONL file my redirect was pointing at. The δ-side `claude -p` process (PID 2757991) still held FDs 1, 2, 12, 13 pointing at the deleted inode. Linux preserves the inode and continues servicing writes as long as **any** FD holds it open; from the kernel's view, the file is "deleted but still in use." From `/tmp` listing it's gone.

`ls -la /proc/2757991/fd/` confirmed the state:

```
l-wx------ 1 root root 64 May 19 10:42 1 -> /tmp/dispatch-379/gamma.jsonl (deleted)
l-wx------ 1 root root 64 May 19 10:42 2 -> /tmp/dispatch-379/gamma.jsonl (deleted)
l-wx------ 1 root root 64 May 19 10:39 12 -> /tmp/dispatch-379/gamma.jsonl (deleted)
l-wx------ 1 root root 64 May 19 10:42 13 -> /tmp/dispatch-379/gamma.jsonl (deleted)
```

`/usr/bin/cat /proc/2757991/fd/1` reads from the deleted inode and returns every byte γ has written. This is the recovery path for the entire log content, in order, in real time.

## Why /usr/bin/cat (not just `cat`)

The δ session's shell snapshot at `/root/.claude/shell-snapshots/snapshot-bash-*.sh` was overriding the built-in `cat` (and others — `readlink` was hitting the `cn` CLI wrapper). When I tried `readlink /proc/PID/cwd`, the wrapper interpreted the path as a `cn` command and printed help. The harness's shell snapshot is *not* a plain bash — it's reshaping commands. Always use absolute paths like `/usr/bin/cat`, `/usr/bin/readlink` when reading from `/proc/{PID}/fd/{N}` if the shell snapshot is in play.

## What I'm taking forward

1. **`/tmp` is not a durable observability surface for dispatched subprocess logs.** The next time I dispatch via `claude -p`, redirect into a location the dispatched agent will not reasonably touch — `/root/dispatch-{cycle}/` or `<repo>/.dispatch/` (gitignored), not `/tmp/dispatch-{cycle}/`. Same for the prompt files the dispatching session reads before invocation.

2. **`/proc/{PID}/fd/{N}` is the universal recovery surface.** Works regardless of what the subprocess (or the harness, or `rm -rf` in a tool call) did to the filesystem path. As long as the FD is open, the content is readable. If the process exits before recovery, the inode is freed and the content is gone — so recover *before* the dispatched session exits.

3. **The harness shell snapshot reshapes commands.** Absolute paths bypass it. The redirect itself (`> path 2>&1`) is bash syntax that goes through the snapshot — so the path the redirect resolves to is whatever the snapshot says. Not a recovery concern (the FD points at the resolved inode regardless), but worth knowing for diagnostics.

## Related

- [[feedback-dispatch-observable]] — the original rule that says `claude -p` background runs must use `stream-json` + JSONL log. This finding refines it: the JSONL log path should be in a location the dispatched agent will not modify.
- The dispatched agent's own observability into its writes is unaffected — only the *dispatching* δ session loses visibility through the regular filesystem path.

## Tested

Recovered the full γ log (90 events at the time of inspection) via `cat /proc/2757991/fd/1`. Read α and β subsequent dispatch logs through the normal path (they ran after γ exited and the directory existed again). End-to-end cycle completed normally; no work was lost.
