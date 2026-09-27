---
type: error
id: 2026-01-01-slug
title: TODO — what was wrong, and what killed it
created: 2026-01-01
updated: 2026-01-01
recorded_at: 2026-01-01
resolution: open
supersedes: null
claim: null
---

# TODO — recorded error

## Why this type exists

The ledger. A mistake you made, kept forever, never deleted.

The schema is built so that erasure is **structurally impossible**, not merely
discouraged:

- `resolution` is a **closed vocabulary**: `open`, `corrected`, `superseded`.
  **`erased` is not a value and `L5` rejects it.** The word does not exist.
- `supersedes` points at the thing this error replaces. That thing stays.
- A proven claim that turns out to be wrong moves to `retracted` and keeps its
  proof, marked superseded.

## Why the record of being wrong is worth more than being right

The current state of your beliefs is a snapshot, and a snapshot is worth very
little on its own. What is worth a great deal, in a year, is the sequence: what
you believed in March, what broke it, what you believed instead, and why.

A system that quietly corrects itself has laundered its own errors, and a
learner who never sees their own error history never develops the one thing that
makes a reader good — a sense of which of their own claims are load-bearing.

## Resolution values

| Value | Means |
|---|---|
| `open` | you know, you have not fixed it |
| `corrected` | fixed, and the original is still there for the record |
| `superseded` | a newer claim replaces this one; `supersedes` points at the new claim |

There is no fourth value. That is the entire point.
