# Release checklist

This repository is **published, passing, and reviewed.** Everything actionable is
closed. Two items remain and both are yours to answer, not debts: whether to name
a language for a translated `README` (item 4), and whether to put your own facts
into `examples/decision` (item 5). The review gate in item 1 is closed, commit
attribution in 3b is closed, and one brand asset is outstanding in 3c.

Run this list top to bottom. It is short on purpose.

---

## 1. Review gate — **CLEARED**

Both gates ran for real. Subagent dispatch was initially broken by a
`ProviderModelNotFoundError`; the cause was the `oh-my-openagent` plugin
hardcoding `anthropic/claude-haiku-4-5` and `anthropic/claude-opus-5`, which do not
resolve on an OpenRouter account, because OpenRouter serves `claude-haiku-4.5`
with a **dot** where the plugin writes a dash. Worked around with explicit model
selection, and the gates were then run.

- **Momus** (plan critique): **APPROVE**, zero blocking defects.
- **Oracle** (independent): **APPROVE with one CRITICAL defect.**

### The critical defect, and what chasing it turned up

`l4_not_exposure()` had a correct `practice` branch that nothing ever called:
`lint_vault()`'s dispatch `case` routed only `claim`, `source`, `error` and
`subject`. **A practice marked `proven` with no proof artifact whatsoever linted
clean.** Law 4 was unenforced for practices, in a repository whose entire claim
is that unenforced laws are just requests.

Fixed in `a74b0fa`, and verified in both directions by hand as well as by test.

Verifying the fix surfaced three more defects, all also fixed:

1. **`g_err "$ledger"`** in `l12_citations()` referenced an unassigned variable.
   Under `set -u` this **aborted the linter mid-run**, so the "CITATIONS.md is
   missing" branch crashed instead of reporting. The `L8b` test had been green
   **for a false reason**: the crash killed the process after L8 had printed and
   before L12 could fire.
2. **The fixture was masking the original bug.** `base_vault` carried a `proven`
   practice with `proof: null`, a real Law 4 violation that passed only because
   the rule was dead. `66ff28a` gave it a back-referencing proof and added the
   `L4d` isolation case, so the baseline is now clean for the right reason.
3. **`grep -qE "^$_b[[:space:]]*:"`** needed `${_b}` to parse as intended.

Also in `a74b0fa`: the dead `NULLABLE_KEYS` variable was removed. Its comment
claimed L9 rejects `null` outside a nullable set, and **L9 does not do that**; it
skips `null` for every key unconditionally. The dead variable is gone and the gap
is documented, not implemented. Implementing it is a schema decision, not a lint
fix, and it is still open.

### Known gap, deliberately not fixed

`L9` permits `null` in any field rather than only in a declared nullable set, so
`due: null` on a `proven` claim would pass. Closing it changes the schema
contract and needs its own decision. It is recorded here rather than quietly
patched.

The review came **after** the first draft, and that is worth saying plainly in the
first release note. This repository is unusually well placed to notice: it ships a
rule that fails the build on an unverifiable citation, and it shipped itself
unreviewed for a while.

## 2. `LICENSE` — copyright holder — **DONE**

`Copyright (c) 2026 moayedellah and contributors`, derived from the
authenticated GitHub account rather than asked for.

## 3. Clone URL — **DONE**

`README.md` and `docs/HOW-IT-WORKS.md` read
`git clone https://github.com/moayedellah/offset.git ~/offset`, and the
repository is live at that URL. Verified from a fresh public clone rather than
assumed.

Renaming or moving it later is a two-line find-and-replace across those two
files, plus the `clone` line in the README's install section.

## 3b. Commit attribution — **DONE**

The first five commits were made under a placeholder identity
(`grimoire <grimoire@localhost>`) before the real one was known. **All 25 commits
are now authored `Moayed Ellah <moayedellahcode@gmail.com>`.** No commit in the
published history carries the placeholder.

This took two force-pushes rather than one, because the history was rewritten
twice: once to set the correct author, and again to correct the name when
`0xRinx` turned out to be a handle rather than the name. Both were done with
`--force-with-lease` pinned to the exact remote SHA, so each would have aborted
rather than clobber if anything else had touched the branch in between. The first
attempt was rejected, correctly, because `filter-branch` had already rewritten
the local `origin/main` tracking ref, making the lease a comparison against a
value that did not exist on the server.

`docs/DELETION-TEST.md` was regenerated after each rewrite. It names its own
source commit, and a rewrite invalidates that name, so leaving it would have put
a commit reference in this repository that points at nothing.

Verified from a fresh public clone, not only locally: 25 commits, one author, no
placeholder.

## 3c. Brand assets — **DONE, with one item open**

`banner-light.png` and a five-badge SVG set are in `.github/assets/`, wired
through `<picture>`. The palette was measured from the banner rather than
chosen. Decision 16 in [`DESIGN-DECISIONS.md`](DESIGN-DECISIONS.md) records the
reversal, the measured contrast figures, and the badge that was cut.

**Open:** there is no dark banner. The asset that existed was a flat `#1E1E1E`
rectangle, one colour across 2100x900, with no mark and no text. It was removed
rather than shipped, because it was referenced by nothing and its only effect was
to look like a finished dark asset. The banner is a plain `<img>`; the
`<picture>` wrapper comes back in one edit when a real dark asset exists. The
five badge pairs kept theirs, because their dark variants are real.

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
- [x] 24 lint tests with full rule isolation and a coverage self-check
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
