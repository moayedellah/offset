---
type: claim
id: 2026-01-01-slug
title: TODO — the claim, as one assertable sentence
created: 2026-01-01
updated: 2026-01-01
state: unseen
status: draft
unlocked_by: null
source: null
locator: null
kind: null
due: null
last_review: null
lapses: 0
stability: 1d
difficulty: 5
---

# TODO — the claim

## Why this type exists

A claim is the spine of the vault: one assertion, compiled once, then kept. The
stable body is never overwritten. New understanding arrives as dated `insight`
notes that reference this id, or as `error` notes that supersede it.

## The three nullable fields are required to be *present*

`unlocked_by`, `source`, `locator`, and `kind` are all marked required, and all
allow `null`. That is not a contradiction:

- `status: draft` + `unlocked_by: null` means **you have not tried this yet**.
  That is the normal state of a new claim.
- `status: compiled` + `unlocked_by: null` means **the answer is on screen and
  you have not attempted it**. That is Law 1 being violated, and `L1` fails it.

Absence and `null` are different things here. A missing key is a malformed note
(`L9`). A present, empty key is a statement about your progress.

## `kind`

- `kind: source` — the work said this. Check the locator before you trust it.
- `kind: inference` — we worked this out. **This is the field that stops an
  inference laundering itself into an apparent quotation.** Within a few months
  you will not remember which of your sentences the book actually said, and this
  field is the only thing that will tell you.

## Scheduler fields

`due`, `last_review`, `lapses`, `stability`, `difficulty` are yours to read and
the CLI's to write. `stability` is a **label** (`1d`, `3w`, `3mo`) and is display
only; the computation is the ladder in `rules/05-scheduler.md`. See
[`05-scheduler.md`](../rules/05-scheduler.md) for what this scheduler does not
claim — it is not FSRS, and it does not pretend to be.

## Body

TODO — the claim, stated so that a reader could disagree with it. A claim you
cannot disagree with is not a claim.
