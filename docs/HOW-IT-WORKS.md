# How it works

## Install and point an agent at the root

```sh
git clone https://github.com/moayedellah/grimoire.git ~/grimoire
cd ~/grimoire
```

`AGENTS.md` is the canonical instruction file. `CLAUDE.md`, `GEMINI.md` and
`QWEN.md` each contain one line, `@AGENTS.md`, because those harnesses do not
read `AGENTS.md` themselves [cite: agents_md_standard].

## The loop

1. **Pick.** Find a claim that is `failed`, `re-attempting`, or `decaying` and past
   its `due`. The agent proposes; you choose.
2. **Attempt.** Write the answer from memory, in your own words, *before* opening
   anything. Record it as an `attempt` note with `outcome: null`.
3. **Wait.** Grade it later, away from the keyboard. Grading in the same sitting is
   how `passed` gets recorded when the answer was two tabs away.
4. **Open.** The attempt is now `unlocked_by` on the claim, and the Closed Book
   opens. Read the compiled claim.
5. **Proof.** On success, write a `proof` at the rung you actually reached.
6. **Schedule.** `bin/g-schedule` advances one ladder step and sets the next due
   date. On failure, record it and the ladder retreats.

## The three rungs

| Rung | What it means | What it unlocks |
|---|---|---|
| `recall` | reproduce it, unaided | the claim |
| `derive` | reproduce the **reasoning**, not the result | the claim, and it counts toward a prerequisite |
| `transfer` | solve a problem the source never solved | **the subject milestone** |

Ranked by depth of engagement [cite: chi2014]. A claim can be proven at `recall`
and later at `derive`; both proofs stay, and `L4` reads the later one — because a
vault that keeps only the best proof per claim cannot show you that the rung
changed.

## The Hint Ladder

The agent climbs one rung at a time, and only when you fail the current one.

| Rung | What the agent gives |
|---|---|
| 1 `nudge` | a rephrasing. No information. |
| 2 `boundary` | what *kind* of thing is being asked for |
| 3 `worked example` | the same **shape**, on an unrelated problem |
| 4 `partial derivation` | the first step, remainder blank |
| 5 `full worked example` | all of it. **Only on explicit request.** |

Rung 3 is the strongest rung. A worked example of the same shape transfers the
*method* and leaks nothing about your problem, so it is worth climbing to well
before rung 5.

**Friction is not the absence of guidance.** The obvious objection to any
Socratic system is that unguided discovery fails for novices and that direct
instruction with worked examples produces vastly more learning [cite:
kirschner2006]. That objection lands. The Closed Book is friction — we do not
show the answer before the attempt. The Hint Ladder is guidance, and its top rung
is precisely a worked example. Kirschner attacks unassisted discovery; this is
scaffolded struggle.

Ask for rung 5 and you will get rung 5. Refusing forever is not integrity, it is
obstruction, and it is its own kind of dishonesty.

## The scheduler

```
1d  →  3d  →  1w  →  3w  →  3mo
        each pass advances one step
        each lapse retreats one step
```

`L6` fails the build when a `proven` claim is past due, so the ladder is enforced
rather than suggested.

**It is not FSRS**, and `rules/05-scheduler.md` says at length why. The swap is
contained: keep the six fields, add float precision, replace the lookup in
`g-schedule`.

## The state machine

```
unseen → attempted → failed → proven → decaying → re-attempting → retracted
                    ↑                          ↓
                    └──────────────────────────┘
```

`retracted` is reachable but not a dead end: you can revisit, and you cannot
un-see what killed it. The **rung penalty** is the other half — a claim proven at
`transfer` and then failed afterwards is demoted, because `L4` compares the
failing attempt's date against the proof's.

## The three layers

| Layer | Holds | Tracked? |
|---|---|---|
| `raw/` | the bytes: books, papers, transcripts | **no — gitignored, always** |
| `sources/` | provenance: author, title, year, locator | yes, paraphrasing |
| `claims/` | what you compiled | yes, gated behind your attempt |

`self/` holds your own prior reasoning and **is** tracked. Your thinking is
durable state.

## The two disciplines

**The Log** (`attention-log.md`) is append-only: start, end, task, interrupts,
switches. Facts only. The two counted columns are there because recall falls as
switch count rises [cite: liefooghe2008] and residue persists [cite: leroy2009] —
but the popular magnitudes are inflated [cite: wiradhany2021], and voluntary
switching is not the same as interruption [cite: nuhn2026]. Count them because
they are free. Build no target out of them.

**The Audit** reads the Log and reports frequencies. Never grades. *"Tuesday: 47
switches, 31 under 90 seconds"* is a fact. *"Focus score 62%"* is a lie with a
chart on it.

## Commands

| Command | Does |
|---|---|
| `bin/g-lint --vault .` | enforce the laws; every finding names its rule |
| `bin/g-lint --templates templates/` | schema-check the templates |
| `bin/g-lint --repo-root . --deletion-test` | the whole repository, then prove durability |
| `bin/g-today .` | regenerate `today.md` from the due set (pull-only) |
| `bin/g-schedule . <id>` | advance or retreat one ladder step |
| `bin/g-new . <type> <slug>` | scaffold a note or a whole subject |

All optional. The vault works with none of them, forever.

`g-schedule` refuses to schedule a `draft`, refuses a state that is not `proven`
or `decaying`, is idempotent within a day, and refuses to grant a subject
milestone without a `transfer`-rung proof.

`g-today` is deterministic — the same vault state produces byte-identical output
— and it never notifies.

## The three laws of changing this repository

1. **Add the lint rule and the test together.** The test breaks exactly one thing
   and asserts *only* that rule fires.
2. **Add the citation before the sentence.** `L12` will tell you if you forgot,
   and it will tell your reviewer if you cited something graded `DO-NOT-CLAIM`.
3. **Never make a law a preference.** If it is not checked, move it out of
   `rules/01-five-laws.md` and into the prose where it belongs.
