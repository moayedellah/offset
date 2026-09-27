---
type: proof
id: pr-reversal
title: ILLUSTRATIVE — reversal cost is a function of elapsed commitments
created: 2026-09-22
updated: 2026-09-22
claim: reversal-cost
practice: null
rung: derive
artifact: scratch/2026-09-22-reversal-derive.md
verified: 2026-09-22
---

# ILLUSTRATIVE — proof at `derive`

## What I produced, not what I recalled

Recalling that reversing is hard is not evidence. The argument is: the cost of
reversal is proportional to *accumulated commitments* — people told, data
migrated, expectations set — and not to the difficulty of undoing the technical
step, which is often trivial.

Two consequences follow, and neither was in the source:

1. The cost curve is **convex**: flat early, steep later. This predicts that
   "we can always reverse it" is most true exactly when it is cheapest to
   believe and least true when it matters.
2. The way to make a decision reversible is therefore **not** to defer it but
   to make the early commitments small and reversible by design. Deferring
   accumulates commitments of a different kind — the cost of waiting.

## What could have falsified it

A case where reversing is *more* expensive early than late, from a growing
commitment that gets unwound either way. I could not construct one, which is a
weak result and I am recording it as weak rather than as support.

## `practice: null`

A proof with a `practice` key set to `null` is fine — `L9` only requires that a
proof target a `claim` **or** a `practice`. The book's `proof-aerobic.md` takes
the other branch, and both are the same rule.
