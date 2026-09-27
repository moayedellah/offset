# Release checklist

This repository is **complete and passing**, and it is **not yet publishable as
yours**. Four items stand between it and a public URL. Three need a fact only you
have; one needs a review pass that has been explicitly waived.

Run this list top to bottom. It is short on purpose.

---

## 1. Review gate — **OWED, NOT CLEARED**

The high-accuracy review (native Momus critique + an independent Oracle review)
has **not been run**. Subagent dispatch was broken for every model in the
authoring session by a `ProviderModelNotFoundError`, and the user waived the gate
on 2026-09-27 with the risk stated plainly.

The cause has since been **diagnosed and the fix applied** to the author's
`~/.config/opencode/opencode.jsonc`: the `oh-my-openagent` plugin hardcodes
`anthropic/claude-haiku-4-5` and `anthropic/claude-opus-5`, which do not resolve on
an OpenRouter account — OpenRouter serves `claude-haiku-4.5`, a **dot** where the
plugin writes a dash. Agent-model overrides are now in place using ids verified
against `opencode models` output. **They take effect on the next session.**

- [ ] Restart opencode.
- [ ] Run the Momus critique against the plan and an Oracle review of
      `rules/01-five-laws.md` and `bin/g-lint`.
- [ ] Record the verdicts in the plan's Review Debt table.

This repository is unusually well placed to notice that it shipped on an
unverified plan: it contains a rule that fails the build when a document cites
something unverifiable. Please close this before publishing, and say plainly in
the first commit or release note that the review came after the first draft.

## 2. `LICENSE` — copyright holder

`LICENSE` line 3 reads `Copyright (c) 2026 <handle> and contributors`.

- [ ] Replace `<handle>` with your GitHub handle.

## 3. `README.md` — repository URL

Two places show `<this-repo>` in the install instructions (`README.md`,
`docs/HOW-IT-WORKS.md`).

- [ ] Replace with the real clone URL once the repo exists.

## 4. Translated `README`

English ships by default. One translated README was planned in your strongest
non-English language.

- [ ] Name the language, and it gets written. Or delete this item — English-only
      is a legitimate choice, not a debt.

## 5. `examples/decision` — your real facts

The decision example ships **deliberately empty of your life**, with
`examples/decision/TODO.md` naming five facts a machine must not invent:

1. An authoritative core-ideas index for the real question
2. A real failed attempt
3. A real dated prediction
4. A real refutation
5. A real retraction

- [ ] Either fill those in with a real decision, or leave the example as-is. It
      lints clean and demonstrates the mechanics either way. **It is not broken,
      and it is not a TODO that blocks publishing** — the subject is titled
      `ILLUSTRATIVE` and says so in its own body.

---

## What is already done, so you can skip it

- [x] 12 lint rules, each naming the law it enforces
- [x] 22 lint tests with full rule isolation and a coverage self-check
- [x] 35 assertions pinning a portable date core, independently validated
      against GNU `date` across 12 dates from 1582 to 2400
- [x] `CITATIONS.md` with a `Verification` field distinguishing a full-text read
      from a third-hand summary
- [x] `L12`, which fails the build on any citation graded `DO-NOT-CLAIM`
- [x] Two worked examples, both linting clean
- [x] `AGENTS.md` at 6.7 KB, under the 32 KiB Codex cap
- [x] CI running all four checks
- [x] A generated deletion-test transcript, with the limits stated

## Verify before you push

```sh
sh tests/harness.sh
sh tests/lint-tests.sh
bin/g-lint --templates templates
bin/g-lint --repo-root . --deletion-test
```

All four must exit `0`. They do, as of the last commit.
