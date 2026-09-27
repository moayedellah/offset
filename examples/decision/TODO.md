# TODO — the five facts only you can supply

This vault is structurally complete and deliberately empty of your life. These
are the parts a machine must not invent, because inventing them is the one lie
this system cannot survive.

## 1. A real authoritative core-ideas index

Not "topics related to the decision" — the actual question, and the two or three
sub-questions that have to be answered for it to be answerable. If you have no
such list, say so in `subject.md` and leave the model's list labelled
*unsourced*. See `rules/03-agent-contract.md` §3.

## 2. A real failed attempt

An `attempts/…` note with `outcome: failed`. It is the **only** key to the
Closed Book [cite: roediger2006], and it has to be yours. Without it the
compiled claims stay shut and the vault proves nothing while looking tidy.

## 3. A real prediction

A `predictions/…` note, dated, falsifiable, written *before* the outcome is
known. Thirty seconds. It is the cheapest instrument in the schema and the only
way to find out which of your current beliefs are load-bearing.

## 4. A real refutation

The moment a prediction came back wrong, recorded as an `error` with
`resolution: corrected` and the prediction's `refuted_by` pointing at it.

## 5. A real retraction

A claim that was `proven` and turned out to be wrong. The claim goes to
`retracted`, an `error` with `resolution: superseded` points at it, and **both
records stay** — `L5` makes `erased` a non-existent value.

## And the raw material

Whatever you consulted goes in `raw/`, which is gitignored. What you commit is a
`source` note: author, title, year, locator. Commit the coordinates, not the
content.

---

Until at least items 1–3 exist, this vault lints clean and demonstrates
nothing. That is stated here rather than hidden, because a demo that quietly
implies more than it has is the thing this project is against.
