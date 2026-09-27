# Changelog

Kept in the order things actually happened, because the review history is part
of the record. The format follows [Keep a Changelog](https://keepachangelog.com/);
the project uses [semantic versioning](https://semver.org/).

## [Unreleased]

### Added

- `CONTRIBUTING.md`, `SECURITY.md`, `CODE_OF_CONDUCT.md`
- A README restructured as fourteen chapters with the state machine, the ladder,
  the session loop and the Hint Ladder drawn as diagrams

### Fixed

- `docs/RELEASE-CHECKLIST.md` claimed 22 lint tests and an unrun review gate.
  There are 24, and both gates ran.

## [0.2.0]

### Fixed

- **Law 4 was unenforced for practices.** `l4_not_exposure()` had a correct
  `practice` branch, but `lint_vault()` routed only `claim`, `source`, `error`
  and `subject`. A practice marked `proven` with no proof artifact whatsoever
  linted clean. Found by an independent Oracle review, not by the test suite,
  which could not have caught it.
- The test fixture had been masking it. `base_vault` carried a `proven` practice
  with `proof: null`, a real Law 4 violation that passed only because the rule
  was dead. It is now backed by a real proof, and `L4d` covers the negative case.
- `l12_citations()` referenced an unassigned variable. Under `set -u` this
  aborted the linter mid-run, so the "CITATIONS.md is missing" branch crashed
  instead of reporting. The `L8b` test had been green only because the crash
  killed the process after L8 printed and before L12 could fire. The fixture was
  corrected.
- `L8`'s `.gitignore` half never fired. `git check-ignore` skips tracked files,
  so the check needed `--no-index`. `L8b` was added to cover it.

### Changed

- `liu2026` regraded from `SAFE` to `PREPRINT`. It is an arXiv paper read
  secondhand, the same situation as `kosmyna2025`, and its own `Verification`
  line said so. The inconsistency was ours.
- The README's TutorVault comparison is now pinned to a commit, so a reader can
  check it. It was accurate and unauditable, which is not the same as good.
- `shellcheck -s sh` over `bin/` and `tests/` is clean: 0 errors, 0 warnings.
  It had never been run.

## [0.1.0]

The first public shape. Twelve lint rules, five laws, ten note types, two
worked examples, a graded citation ledger, and CI running all four checks.

Notable admission: the high-accuracy review ran *after* the first draft, not
before. A repository that ships a rule failing the build on unverifiable
citations had shipped itself unreviewed, which is the kind of irony worth
writing down.
