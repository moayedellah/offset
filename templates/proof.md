---
type: proof
id: YYYY-MM-DD-slug-rung
title: TODO — claim title, at recall
created: YYYY-MM-DD
updated: YYYY-MM-DD
claim: TODO — the id of the claim this proves
rung: recall
artifact: TODO — where your own attempt lives
verified: YYYY-MM-DD
---

# TODO — proof of TODO at recall

## Why this type exists

A proof is the only thing that can move a claim to `proven`. It is the entire
evidence layer, and it is the answer to the question nobody else in this space
answers: **what stops the system taking the learner's word for it?**

## `artifact` is yours

**Not the agent's.** A proof the model wrote is not a proof you produced. A
system that accepts one has no evidence layer — it has a compliments layer.

The artifact is wherever your own attempt lives: a file you wrote, a photo of
scratch work, a code diff, a paragraph in your own words. The field is a string
pointer, not a validated path, because the artifact is frequently not a file at
all.

## The three rungs

| Rung | What it means | What it unlocks |
|---|---|---|
| `recall` | you reproduced it, unaided | the claim |
| `derive` | you reproduced the **reasoning**, not the result | the claim, and it counts toward a prerequisite |
| `transfer` | you solved a problem the source never solved | **the subject milestone** |

Ranked by depth of engagement: constructive beats active, interactive beats
constructive [cite: chi2014]. A `recall` proof that you scored by re-reading
three times is not a `recall` proof, and no lint rule can tell — but you will
know, and that is where the honesty has to live.

## `verified`

The date the proof was accepted. This is what makes the rung penalty work: a
claim proven at `transfer` and then failed afterwards is demoted, because `L4`
compares this date against the failing attempt's.
