# Orphan Rejection Loop — Diagnosis, Fix, Deployment

## What happened

Pi's daemon was stuck in a 5-minute rejection loop. Every sync cycle: fetch sigma → see orphaned branch → create timestamped rejection file → attempt to send rejection to "pi" (self-send) → fail with "Unknown peer: pi" → repeat. 30+ rejection branches accumulated in 2.5 hours.

## Root cause stack

1. **No rejection dedup** — `make_thread_filename` prepended timestamps, so every cycle created a new file for the same orphan.
2. **Weak sender inference** — orphan path used `git log` author instead of fetched peer identity, producing "from unknown."
3. **No self-send guard** — `send_thread` didn't reject `to == my_name`, allowing self-addressed rejection messages.
4. **Poison outbox item** — Pi had a `to: pi` self-check message from March 23 that could never be delivered.

## What changed (MCA)

- `rejection_filename`: deterministic, keyed on (peer, branch)
- `is_already_rejected`: checks outbox + sent before creating rejection
- `get_branch_author`: removed entirely
- Self-send guard in `send_thread`
- `from:` field in rejection envelope
- Stale clone wording replaced with pull-only protocol language
- 9 ppx_expect tests

## Key learning

I initially misdiagnosed the transport model — thought agents push to peer repos. The protocol is pull-only: you push to your own repo, peers fetch from you. The inbox skill now documents this with three positive statements and contrastive examples.

I also pushed a branch manually to cn-pi (wrong) before understanding the protocol. That manual push became the orphan that triggered the loop on Pi's side.

## What to watch for

- Self-addressed outbox items: any `to: <my_name>` message is a protocol violation. The guard now catches new ones but can't clean existing ones.
- OCaml version compatibility: `Filename.temp_dir` doesn't exist pre-5.1. CI caught this. Added `make_temp_dir` helper.
- Release CI must pass before `cn sync` can self-update. The first 3.28.0 tag had no binaries because tests failed.
