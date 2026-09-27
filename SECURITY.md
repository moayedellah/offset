# Security policy

## What counts as a vulnerability here

This repository is markdown, five POSIX shell scripts, and a linter that reads
files you control. The realistic threat model is narrow, and it is worth
stating precisely.

**In scope:**

- `bin/g-lint` executing anything derived from the content of a vault note.
  Note bodies are attacker-controlled the moment someone clones a shared vault.
  There must be no `eval`, no `sh -c` on note-derived text, and no sourcing of
  a note. This is the highest-risk class of bug in a repository whose entire
  content is untrusted-ish text, so it is the one to check first.
- `g-new` overwriting or clobbering an existing note without `--force`.
- Any network egress from a script in `bin/`. There should be none. A tool that
  phones home is a tool that cannot die tomorrow.
- The deletion test being bypassable, since the Deletion Test is the load-bearing
  claim of the whole design.
- A way to make a `DO-NOT-CLAIM` citation usable by editing its grade mid-pull
  request without anyone noticing.

**Out of scope:**

- The vulnerabilities this repository *teaches* about. It documents how
  unguarded AI tutoring measurably damages unaided performance, and it refuses
  to hand the answer over before you have attempted it. That is the product.
- Findings in someone else's vault that you obtained without permission.
- Denial of service against your own machine.

## Reporting

Use GitHub's private vulnerability reporting for this repository. Please do not
open a public issue for anything in scope.

Include: the file and line, the vault layout that reproduces it, the command you
ran, and what you expected instead. A minimal vault is worth more than a long
description.

## What a good report gets

A fix, a test that fails without it, and a credit line unless you would rather
not have one. The test is not optional. Every defect fixed in this repository so
far has come with the case that would have caught it, and one of them came with
the discovery that an existing test had been green for the wrong reason.

## Response

No SLA is promised, because this is one person's spare time. Reports are read
in order of blast radius: anything that can execute note content comes before
anything else.
