# Wake backend quickstart

**Most users should do nothing.** cnos wakes run on the default backend chosen by the
wake provider. Today the safe production backend is `claude-code`.

> **Mock / design-oracle status.** The commands below are the *target* human surface for
> the wake-substrate wave (cnos#596). Names may change until #452 pins the final CLI/API;
> the wave's job is to make this guide true — not the other way round.

## See what backend a wake uses

```sh
cn wake status cnos-agent-admin
```

Expected output:

```
wake:    cnos-agent-admin
backend: claude-code
production_write_authority: true
fallback: none
last_report: success
```

## Try another backend safely — canary

A canary **must not** get production write authority.

```sh
cn wake canary cnos-agent-admin --backend openai-compat --no-write
```

Inspect the report:

```sh
cn wake report cnos-agent-admin --latest
```

The report must show:

```
backend: openai-compat
production_write_authority: false
outcome:  success | rejected_by_policy | validation_failed | executor_error
fallback: none | claude-code
```

## Make a backend the default

Do this only after the canary is clean **and** the operator approves production write authority.

```sh
cn wake backend set cnos-agent-admin --default claude-code
cn install-wake cnos-agent-admin
```

For now, do **not** set `openai-compat` as a production write backend.

## Roll back

```sh
cn wake backend set cnos-agent-admin --default claude-code
cn install-wake cnos-agent-admin
cn wake status cnos-agent-admin   # verify
```

## Never do this

- Do not edit generated GitHub workflow YAML by hand.
- Do not give `openai-compat` production write authority without operator approval.
- Do not treat a model endpoint as a tool policy.
- Do not accept a silent fallback — fallback must appear in the wake report.

---

*North star: everything else in this wave (backend contract, generated YAML, terminal
reports, executor fixtures, canary observation) exists only to make this guide true. The
full terminal-report enum backing the human-facing `outcome`/`fallback` fields is
`success · rejected_by_policy · substrate_discipline_failed · degraded_fallback_used ·
executor_error · validation_failed` (cnos#596). Target landing path for the shipped guide:
`src/packages/cnos.core/skills/agent/wake-substrate/examples/QUICKSTART.md` (package-examples
first; `docs/wake-backends/QUICKSTART.md` is the alternative — final path is repo-convention,
decided by the Sub 0.25 cell).*