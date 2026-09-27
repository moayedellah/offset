# Contributing

Thanks for looking. This is a small repository with a strict idea of what counts
as done, so the contribution bar is mostly about evidence rather than effort.

## Run the suite first

```sh
sh tests/harness.sh          # 35 assertions, the portable date core
sh tests/lint-tests.sh       # 24 cases, one per rule, both directions
bin/g-lint --templates templates
bin/g-lint --repo-root . --deletion-test

All four must exit `0`. They all run in CI, and they all run in about a second.

## Adding a law

Three edits, in this order. Skipping the third is the mistake this section
exists to prevent.

1. **Write it** in `rules/01-five-laws.md`, naming the lint rule that will
   enforce it. A law with no rule is a request, and the whole point of this
   repository is that requests do not count.
2. **Implement it** in `bin/g-lint`, and **dispatch it** in `lint_vault()`. The
   dispatch `case` is the single place a rule can be implemented and then
   silently never called. It happened once already: `l4_not_exposure()` had a
   correct `practice` branch that nothing routed to, so a `proven` practice with
   no proof linted clean for months. A rule that is written but never
   dispatched is worse than no rule, because it looks like enforcement.
3. **Test it** in `tests/lint-tests.sh` with `expect_only`, which asserts the
   violation trips *only* your rule. A test that passes for the wrong reason is
   the same failure wearing a disguise: the `L8b` case was green for a while
   only because an unbound variable was killing the linter before the rule it
   was meant to catch could run.

If you add a thirteenth rule, bump the coverage self-check. It fails the run
whenever a rule in the range is untested, and it will not notice a new one
unless you tell it.

## Adding a citation

Add a graded entry to `CITATIONS.md` **first**, then cite it. `L12` fails the
build on an unresolvable id, and it fails it again if the id is graded
`DO-NOT-CLAIM`.

Every entry needs a `Verification` line that says how you actually read it. A
full-text read, an abstract, and a third-hand summary in someone else's paper
are three different things, and the ledger exists to keep them apart. If you
read a preprint and call it `SAFE`, a reviewer will ask which of those three it
was.

The two entries that most often get argued about:

- A preprint you have not read in full is `PREPRINT`, whatever the finding.
- If you cannot find the paper behind a claim, the entry is `DO-NOT-CLAIM` and
  the claim comes out of the document. Do not "use instead" anything you have
  not checked.

## Adding a note type

`rules/04-ontology.md` owns the vocabulary, so it goes first. Then the template
in `templates/`, then the dispatch arm in `lint_vault()`, then the tests. CI
asserts every type is covered exactly once by a lint-clean template, so a
partial addition fails the build rather than passing quietly.

## Style

The prose bar is set by `docs/PHILOSOPHY.md`, and it is not a style guide so
much as an honesty requirement. State the limit. Name the effect size. If the
evidence is weak, grade it weak. The section that does this best is
"What this system cannot do" in the README, and it is not last because it is
least important.

## Reporting a problem

Open an issue. For anything security-shaped, follow `SECURITY.md` instead,
which routes you to private reporting.
