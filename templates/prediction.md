---
type: prediction
id: 2026-01-01-slug
title: TODO — the prediction
created: 2026-01-01
updated: 2026-01-01
statement: TODO — a falsifiable claim about the world, stated so it could be wrong
date: 2026-01-01
outcome: open
refuted_by: null
---

# TODO — prediction

## Why this type exists

The cheapest high-value note type in the system.

A dated prediction is a **falsifiable instrument**. You write down what you
think will happen, and then reality gets a vote. That is a fundamentally
different relationship with your own reasoning than "I believe X" — and it is
the only reliable way to find out which of your claims are load-bearing before
you need them.

It costs about thirty seconds.

## How predictions drive the rest of the system

- A `confirmed` prediction is evidence you can point at.
- A `refuted` prediction names its killer in `refuted_by` — usually an `error`
  note — and drags the claim it was about into `retracted`. Both records stay.
- `refuted` predictions are the most valuable notes you will ever write, and
  they are the ones you are most tempted to delete. Do not.

## Write it so it could be wrong

"Trees will keep getting bigger" cannot be refuted, so it teaches you nothing.
"Somewhere in this codebase there is a bug that only manifests on Tuesdays"
can be refuted, and if it comes back `confirmed` you have learned something real
about a system you thought you knew.

The test is simple: **could you point at the observation that would kill this?**
If not, it is not a prediction. It is a mood.
