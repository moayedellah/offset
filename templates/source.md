---
type: source
id: YYYY-MM-DD-author-short-title
title: TODO — Author, *Title* (Year)
created: YYYY-MM-DD
updated: YYYY-MM-DD
locator_hint: TODO — chapter, section, or page where the relevant material lives
---

# TODO — Author, *Title* (Year)

## Why this type exists

A `source` note is **not the work**. It is a provenance record: where the
material is and where in it to look. The work itself lives in `raw/`, which is
never committed.

This is the middle layer of the three-layer pattern. `raw/` holds the bytes,
`sources/` holds the map, `claims/` holds the compiled result. It is what makes
it legal to have a well-sourced public repository — you commit the coordinates,
not the content.

## No summary field yet

There is deliberately **no `summary:` field** in this template.

A summary is a *result*, not an *input* — Law 2, and the reason the definitive
review rated summarization **LOW** for learning utility while rating practice
testing and spaced practice the only two **HIGH** [cite: dunlosky2013]. Until you
have written your own `attempt` against this source, adding a summary is the most
common way to arrive at a conclusion you never actually reached. Lint rule `L2`
will reject it.

## Locator

`locator_hint` is deliberately coarser than a compiled claim's `locator`. A
source says "the relevant part is around here". A claim says "this specific
sentence, in this specific chapter".
