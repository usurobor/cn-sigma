# threads/inbox vs threads/in — scanner drift

## What

cnos 3.71.0 `cn activate` scans `threads/in`, `threads/mail`, and `threads/archived`. It does not scan `threads/inbox`. cn-sigma uses `threads/inbox` as its canonical inbound surface. Activation sees `threads/in` but not `threads/inbox`.

## Impact

Non-blocking for triad compliance. `threads/in` exists and is scanned. But `threads/inbox` — the surface with actual messages — is invisible to `cn activate`.

## Disposition

Filed as cnos #323.
