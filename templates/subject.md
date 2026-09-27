---
type: subject
id: 2026-01-01-slug
title: TODO — subject title
created: 2026-01-01
updated: 2026-01-01
state: unseen
milestone_earned: false
core_ideas:
  - TODO — one authoritative core concept of this field
---

# TODO — subject title

## Why this type exists

A `subject` is a field of study, and it is where the state machine actually
lives. A claim can be `proven` while the subject it belongs to is still
`unseen`, because you can prove one isolated thing without having learned a
field. The subject note is what stops that from being mistaken for a syllabus.

## Core ideas index

Seed `core_ideas` from an **authoritative** list of the field's core concepts —
the twenty to fifty things a practitioner in the discipline would name. If you
do not have one, leave the `TODO` in place and say so out loud in this section:

> No authoritative index yet. This list is the model's invention and is
> **unsourced**. Treat it as a strawman to correct.

That label is the single cheapest honesty mechanism in the system. An invented
index presented unlabelled becomes a confident fiction that silently shapes
every syllabus built on top of it.

## Milestone

`milestone_earned: true` requires at least one `transfer`-rung proof in this
subject. Lint rule `L4` checks this, and `bin/g-schedule` refuses to grant it
without one. Recall and derive earn you the claim. Only transfer earns you the
field.

## Session

The agent's opening move for this subject. See `rules/03-agent-contract.md` §3.
