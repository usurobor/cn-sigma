# Daemon Crash Loop — /proc/self/exe in Child Process

## What happened

After deploying 3.29.0, Pi's daemon crashed every 5 minutes. `check_binary_version_drift` reported "disk has (GNU" and attempted re-exec with `--daemon`, which failed.

## Root cause

`resolve_bin_path` used `Cn_ffi.Child_process.exec "readlink -f /proc/self/exe"`. This spawns a bash child. The child's `/proc/self/exe` is `/usr/bin/bash`, not `cn`. So `bin_path = "/usr/bin/bash"`, version drift check runs `bash --version`, gets "GNU bash...", detects false drift, re-execs, crash.

## Fix (MCA)

`Unix.readlink "/proc/self/exe"` — reads the symlink directly in the OCaml process. No child shell. One-line fix, 3.29.1.

## Lesson

`/proc/self/exe` is per-process. Any child process has its own `/proc/self/exe`. Reading it via `exec` always returns the shell's identity, not the parent's. This is fundamental to how procfs works — not an edge case.

## What to watch for

Any future code that reads `/proc/self/*` via `Child_process.exec` will have the same bug. The pattern is: if you need process-local information, read it in-process.
