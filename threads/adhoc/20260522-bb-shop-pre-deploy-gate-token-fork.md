# bb-shop pre-deploy gate — the token issue was masked by an interactive prompt

Date: 2026-05-22
Repo: usurobor/bb-shop
Surface: `.github/workflows/pre-deploy.yml`

## What happened

Operator handed me commit `2501632` ("install Pillow before build") and a three-branch failure tree:

- All green → gate operational.
- Red at step 4 (push) → token issue, rotate `atkn_` → `shpat_`.
- Red at step 6 (Playwright) → real v2.2.1 spec/code drift.

I drove the iteration. Two failures, two distinct causes — only the second matched the tree.

### Iteration 1 (commit `2501632`)
Step 9 ("Push unpublished draft theme") failed with:
```
Failed to prompt: Name of the new theme
```
Diagnosis read at the time: not a token problem. `--unpublished` creates a new theme and the CLI prompts for its name; non-interactive CI can't answer.

Hypothesis-1: set `SHOPIFY_FLAG_THEME` env to supply the name without changing the command line. **Wrong env var name.** Real env is `SHOPIFY_FLAG_THEME_ID`, and even with the right name `--theme` only targets existing themes — never feeds the new-theme prompt for `--unpublished`.

### Iteration 2 (commit `79011db`)
Same prompt failure, confirming hypothesis-1 wrong. Inspected `@shopify/cli` source (`chunk-26D72ZNV.js`, function `y(e)`): the new-theme-name prompt is unconditional under `--unpublished` and has no flag or env override. `--unpublished` is structurally incompatible with non-interactive CI for `theme push`.

### Iteration 3 (commit `1462a3b`)
Switched to `--development --development-context gh-pre-deploy`. This is the documented non-interactive path: dev theme reused per context name, no proliferation, no manual setup. Push step finally exercised the API and returned:
```
Error connecting to your store ...: GraphQL Error (Code: 401):
{"response":{"errors":"[API] Service is not valid for ...
```

The `atkn_` Theme Access token is scoped to a narrow theme-files API. `theme push` (both `--unpublished` and `--development`) needs Admin API GraphQL access, which only `shpat_` (Custom App) tokens grant. Operator's second branch.

## Key insight — masked failure mode

The operator's failure tree was right about the token being insufficient. But `--unpublished` failed at an **upstream non-interactive prompt** before the request reached the API, so the auth issue was invisible until the command shape changed.

**Pattern:** when a CI step fails, the surface error names *one* problem — sometimes there's a second problem behind it that the first one is hiding. Iterating fixes the visible one; the next iteration reveals the next one. Operator's branch prediction was wrong on which branch fires *first*, right on which token is needed *eventually*.

This is a near-cousin of the "what tier am I actually in" failure mode named in `20260519-git-read-and-untested-limits.md` — both are about not assuming the first signal is the whole picture.

## What changed structurally

- `--unpublished` ⟶ `--development --development-context gh-pre-deploy` in `.github/workflows/pre-deploy.yml`.
- Stable context name = one reused dev theme = no theme-proliferation follow-up.
- Downstream contract unchanged (same JSON shape; same `theme_id` plumbing into `?preview_theme_id=` URL).

## Open MCA (operator-only)

Rotate GH secret `SHOPIFY_CLI_THEME_TOKEN` from `atkn_…` (Theme Access app) to `shpat_…` (Custom App with `read_themes` + `write_themes` Admin API scopes on `bodybound-3.myshopify.com`). No further workflow change required.

## Learnings to keep

1. **Read the failing CLI's source before guessing env var mappings.** I guessed `SHOPIFY_FLAG_THEME` from the flag name; the real mapping was `SHOPIFY_FLAG_THEME_ID`. The cost of a wrong guess is a full CI iteration (~3 min) instead of a 30-sec source read.
2. **An interactive-prompt failure in CI is structurally different from an auth failure.** Don't conflate them just because the operator's tree predicted "red at this step" — *why* red matters.
3. **When `--unpublished` is the wrong shape for CI, `--development -c` is the documented non-interactive equivalent** — and is also better for proliferation hygiene. Worth keeping after token rotation.

## Cross-refs

- Iteration log: GH Actions runs `26291285060` (Pillow), `26302561656` (env-var hypothesis), `26302741397` (--development -c).
- Operator preference recorded this session: "bother me only when MCA is unclear" — applied here only when the MCA crossed an external-action boundary (secret rotation).
