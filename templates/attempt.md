---
type: attempt
id: YYYY-MM-DD-slug
title: TODO — claim title, first attempt
created: YYYY-MM-DD
updated: YYYY-MM-DD
claim: TODO — the id of the claim attempted
outcome: null
artifact: TODO — your attempt, in your own words
---

# TODO — attempt at TODO

## Why this type exists

This note is the key to the vault.

Law 1 — the Closed Book — says you never see a compiled claim before you have
produced your own attempt at the raw material. `unlocked_by` on a claim points
here, and that pointer is the only door. Nothing else opens it.

## `outcome: failed` is the most valuable value in this schema

Read that again. It is the field that unlocks the answer sheet, and it is
therefore the field the entire system depends on.

Which means **`failed` has to be cheap and unpunished.** If writing one feels
like losing, you will not write one, the compiled claim stays locked forever, and
Law 1 quietly becomes "the answer is always open" while the README still claims
otherwise. The most likely way this system fails is not a bug — it is a learner
who stopped recording failures because it hurt.

The evidence for why that matters is measured: students given an unguarded AI
tutor scored **17% worse** on an unaided exam than students who never had one at
all, while feeling better about it [cite: bastani2025].

## `null` is a real value

An attempt that has not been graded yet. Write the attempt first, think about it
away from the screen, then come back and grade it. Grading in the same sitting
is how `passed` gets written when the answer was two tabs away.

Full citation and caveats in `CITATIONS.md`.
