# 05 — The Scheduler

The interval ladder is the part of this system that the rest of the field
claims to have and does not. Every vault-with-a-tutor project we found says
"spaced repetition". We checked what each one actually implements. The closest
one's entire scheduler is a single frontmatter field: `last_reviewed`, a date.
Nothing decays. Nothing resurfaces. A concept you failed in March is never
brought back in June, because there is no mechanism that could bring it back.

This file is that mechanism. It is small on purpose, and it is **law**, not a
suggestion — `L6` fails the build when a `proven` note is past its `due` date.

---

## The ladder

| Step | Interval | Label |
|---|---|---|
| 0 | 1 day | `1d` |
| 1 | 3 days | `3d` |
| 2 | 7 days | `1w` |
| 3 | 21 days | `3w` |
| 4 | 90 days | `3mo` |

**One mechanism, not two.** A successful review advances one step. A lapse
retreats one step. The current interval is `LADDER[step]`, clamped to the ends.

That is the entire algorithm. There is no multiplier, no exponential decay, no
floating-point stability. If you can read this table you can predict what the
scheduler will do, and if the scheduler ever does something surprising, that is
a bug.

> **Deviation from the original plan, recorded deliberately.** The plan called for
> a lapse to multiply the next interval by 2.5 with a 6-month cap. We dropped the
> multiplier. Two overlapping penalty mechanisms are harder to reason about than
> one, and this system's entire pitch is legibility. `lapses` is still counted — it
> is a useful diagnostic and it feeds `difficulty` — but it does not also scale the
> interval. See `docs/DESIGN-DECISIONS.md`.

## State transitions

| From | To | When |
|---|---|---|
| `proven` | `decaying` | `due` is in the past |
| `decaying` | `re-attempting` | a ritual session opens on it |
| `re-attempting` | `proven` | a new `proof` note exists |
| `re-attempting` | `failed` | the attempt failed again |

`unseen`, `attempted`, `failed` and `retracted` are never scheduled. Only
`proven` and `decaying` carry a meaningful `due`. `L6` fires on
`state: proven` with a `due` in the past.

## `difficulty`

An integer `1..10`, initialised to `5`.

- **+1** on each lapse, clamped to `10`.
- **−1** on a `transfer`-rung proof, clamped to `1`.

It is read by the agent when choosing the Hint Ladder's starting rung: a
`difficulty: 9` claim gets more scaffolding before it is ever handed over. It
does not affect the interval. Keeping the two independent means a hard concept
gets more help *and* comes back sooner without those two facts contaminating
each other.

## `stability`

The **label** of the current interval — `"1d"`, `"3w"`, and so on. Display only.

This is the one field in the schema that exists purely so a human can read their
own vault and know when something is coming back. It is not the computation; the
computation is `LADDER[step]`, and `step` is inferred from the label. A rounded
number a human can check beats a float nobody can.

## What this scheduler refuses to do

- **It never schedules a `draft` claim.** A claim that is not `compiled` is not
  an answer yet, so it has nothing to forget. `bin/g-schedule` exits non-zero and
  names Law 4.
- **It never grants a subject milestone without a `transfer` proof.**
  `bin/g-schedule` exits non-zero naming the requirement. `L4` checks it
  independently, so passing the CLI does not get you past the linter.
- **It never marks anything.** Scheduling is bookkeeping. Only a proof artifact
  the learner produced can move a claim to `proven`, and a clock cannot produce
  an artifact.

## What this scheduler does not claim

**This is not FSRS, and it is not better than FSRS.**

FSRS is a trainable DSR model with a power-law forgetting curve; the current
version uses a stability-weighted mixture of two power laws. It genuinely
schedules better than a fixed ladder. Its full per-item state is roughly ten
fields including floating-point `stability` and `difficulty`, and the only
precedent we found for storing that in YAML frontmatter is an Obsidian plugin —
which would break the Deletion Test by making a plugin the owner of your state.

We chose a fixed ladder for two reasons, both about the product rather than the
algorithm:

1. **No dependency.** A repo whose thesis is "we have no dependencies" cannot
   carry an npm package in the one place where the maths lives.
2. **Legibility.** A hand-rolled ladder's output is a fact a human can verify by
   reading a table. When our scheduler does something odd, you can work out
   whether it is wrong. That is worth more here than three percent of retention.

If you want FSRS, the swap is contained: keep the six fields, add float precision
to `stability` and `difficulty`, and replace the ladder lookup in
`bin/g-schedule`. The schema does not have to change. That reversibility is the
point of keeping the state small.
