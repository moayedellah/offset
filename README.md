# Grimoire

**A durable learning and cognitive-training system. Your notes are the artifact;
the software is a lens.**

You do not read to have read books. You read to train the reading brain. The same
law governs the vault and the operator, and its corollary is the whole product:

> **An AI that removes all cognitive effort is the cognitive equivalent of
> sitting on the couch.**

So this system refuses to be helpful on demand, and then it *proves* it — twelve
lint rules that fail the build when you break your own laws.

Zero required runtime. The only executable is an LLM reading text.

---

## Why this exists, and why not another vault

The field is crowded and it is good. `claudian` has ~12,000 stars and made "your
vault is the agent's working directory" mainstream. `tutor-skills` has ~1,100 and
packaged the setup-then-quiz loop as a portable skill. `TutorVault` is the closest
thing to this project and has a better `CLAUDE.md` than most commercial products.

**All of them ship the same three gaps**, which is where this lives:

| Gap | What everyone does | What this does |
|---|---|---|
| **Nobody schedules** | claims "spaced repetition"; `TutorVault`'s entire scheduler is one `last_reviewed` date. No decay, no resurfacing. | A real ladder that decays and resurfaces, enforced by `L6` — a `proven` claim past due **fails the build**. |
| **The answer sheet is always open** | the compiled note sits readable and the tutor reads it back on revisit. | Law 1: the compiled claim is gated behind a **recorded failure**. A pointer is the only key. |
| **Laws are requests, not checks** | every rule is left to model discretion. | All five laws are lint rules. Delete an error and `L5` fails. Cite something unverifiable and `L12` fails. |

There is also a fourth thing nobody has, which is the part you will not find in
any of them: **an honesty layer that is mechanically enforced.** Every scientific
claim in this repository is graded in [`CITATIONS.md`](CITATIONS.md), and rule
**L12 fails the build if any document cites an id graded `DO-NOT-CLAIM`.**

---

## Install

```sh
git clone <this-repo> ~/grimoire
cd ~/grimoire
```

Point your agent at the vault root. `AGENTS.md` is the canonical instruction
file and every harness finds it or a shim for it — `CLAUDE.md`, `GEMINI.md` and
`QWEN.md` each contain exactly one line, `@AGENTS.md`, because those tools do not
read `AGENTS.md` themselves [cite: agents_md_standard].

Read one file:

```sh
cat rules/01-five-laws.md
```

Then try the loop:

```sh
bin/g-new . subject my-subject --title "Whatever I'm learning"
bin/g-today .
bin/g-lint --vault .
```

Everything in `bin/` is optional. The vault works with none of it, forever.

---

## The ten-minute path

Clone it. Then:

1. `examples/book/` is a complete worked subject — Darwin, *On the Origin of
   Species* (1859), public domain — with six claims, six attempts, six proofs
   across all three rungs, three errors, two predictions, three insights, two
   practices and an audit.
2. Open `examples/book/claims/darwin/natural-selection.md`. It is `proven` at
   `derive`. Now read `examples/book/attempts/darwin/att-ns.md`, which is the
   **failed** attempt that opened it. The ordering is the product: the attempt is
   dated before the reading.
3. `examples/book/claims/darwin/variation-passes-directly.md` is `retracted`.
   It is still on disk. Read `errors/darwin/err-vpd.md`, which points at it. The
   claim was wrong, the correction is recorded, and neither was deleted.
4. `examples/decision/TODO.md` lists the five facts **only you can supply**. They
   are missing on purpose, and the example says so rather than inventing them.

Then run the deletion test yourself:

```sh
bin/g-lint --repo-root . --deletion-test
```

It copies each example vault, **deletes every non-markdown file**, re-lints, and
fails if the result is not clean. The whole philosophy in one command.

---

## The Five Laws

Each is enforced by a lint rule that names it.

1. **The Closed Book** — never show a compiled claim before the learner produced
   their own attempt at the raw. A recorded failure is the only key. (`L1`)
2. **No summary as first contact** — a summary is a result, never an input.
   (`L2`)
3. **Provenance** — every compiled claim carries source, locator, and whether it
   is the source speaking or us. (`L3`)
4. **Exposure is not mastery** — no `proven` without a proof artifact the learner
   produced, at a named rung. (`L4`, `L6`)
5. **The Ledger** — never erase a recorded error. `erased` is not a legal value
   and never will be. (`L5`)

Proofs are earned at a rung: **`recall`** reproduces it, **`derive`** reproduces
the reasoning, **`transfer`** solves a problem the source never solved. Only
transfer earns a subject milestone, and two independent checks enforce it.

## The Two Disciplines of the operator

A **law** is a promise about an immutable record. A **discipline** is a practice
by a fallible human, and must be breakable — if breaking it falsified the record,
you would stop opening the vault within a fortnight.

- **The Log** — an append-only attention log. Facts only: when a block started
  and ended, what you worked on, what interrupted you, how many switches. No
  interpretation. The two counted columns are there because the mechanism is
  real [cite: leroy2009] [cite: liefooghe2008].
- **The Audit** — reads the Log back and reports **frequencies**. Never grades.
  *"Tuesday: 47 switches, 31 under 90 seconds"* is a fact. *"Focus score 62%"* is
  a lie with a chart on it.

`L11` rejects the entire vault if a field named `score`, `streak`, `points`, `xp`,
`level` or `rank` ever appears. We hold **no empirical claim** that streaks work
or fail — see `streaks_evidence`, graded `DO-NOT-CLAIM`. The prohibition is
philosophical: a streak counter manufactures the *feeling* of progress, which is
the exact failure this project exists to refuse.

---

## What this system cannot do

This is the section that matters most, so it is not last.

**The tutoring ceiling is lower than the field admits.** The standard belief is
that human tutoring reaches **d = 2.0** over no tutoring. A careful review found
**d = 0.79** — with intelligent tutoring systems at 0.76, nearly identical, both
far below belief [cite: vanlehn2011]. Whatever this system does, it is not
promising the 2-sigma result, because a careful review says it was never real.

**Socratic prompting alone is not enough.** The strongest evidence that a
well-designed AI tutor can beat good human-led active learning is real — N = 233,
effect size 0.63–1.3, p < 10⁻⁸ [cite: kestin2025] — but the authors' own scope
limitation is that they do *not* claim it wins for "complex synthesis of multiple
concepts and higher-order critical thinking". That excluded case is roughly what
this system is for. It is also an **immediate** post-test, not a delayed retention
test.

**And the same tooling, differently designed, does measurable harm.** A
preregistered RCT in *PNAS* with ~1,000 high-school students: students with an
unguarded ChatGPT-style tutor scored **+48%** on assisted practice and then
**−17% on an unaided exam — worse than students who never had it at all.** The
same model, rebuilt to withhold answers, lost the harm entirely [cite: bastani2025].
That paper is the empirical foundation of the whole design, and note what it does
*not* say: the guarded version stopped the damage, it did not produce a benefit.

Those two are **not** in conflict, and saying so is most of what is new here. One
measures an immediate post-test under a supported scaffold; the other measures a
later unaided exam without guardrails. Different measurements, different designs.
A vendor quoting the first and ignoring the second is telling you something.

**The learner's own sense of progress is not an instrument.** Three independent
findings: predictions of your own performance were *uncorrelated* with actual
performance [cite: karpicke2008]; perceived learning from active learning ran
*opposite* to actual gain [cite: deslauriers2019]; and students systematically
over-estimated what an AI tutor had done for them [cite: bastani2025]. Hence:
artifacts, not self-report. Every `[x]` needs a file the learner wrote.

**Highlighting and summarizing do not work.** The definitive review rated only
**two** techniques *high* utility: practice testing and spaced practice.
Summarization, highlighting, rereading, keyword mnemonics and imagery were rated
*low*; elaborative interrogation, self-explanation and interleaving only
*moderate* [cite: dunlosky2013]. Popular summaries of that paper routinely list
the moderate three as winners. This system builds on the two highs.

**Retrieval is uniquely important; "restudy is useless" is not.** Repeated
study after a successful recall produced no measurable learning a week later
[cite: karpicke2008] — but a replication showed the between-subjects design
confounded spacing, and that when spacing is controlled, restudying helps too
[cite: soderstrom2015]. We cite the paper that weakens our own headline.

**The exercise effect is real and modest, and it takes weeks.** An umbrella
review across 133 reviews, 2,700+ RCTs and 250,000+ participants found general
cognition SMD 0.42, falling to d = 0.31 after funnel-plot adjustment
[cite: bjsm2025]; a more conservative RCT meta-analysis finds executive function
at g = 0.123 [cite: chang2012]. Dose: **13–24 weeks, 20–60 minutes, 3–7 days a
week** [cite: ye2024] — from adults 45 and over, so do not silently generalise it
to a 25-year-old. As we train our body we train our brain [cite: hillman2008].
**Anyone promising faster is selling something.**

**The attention mechanism is real; the popular numbers are not.** Residue from a
previous task persists while you work on the next, and what predicts a clean
switch is *disengaging before you switch*, not finishing the task
[cite: leroy2009]. But the classic laboratory switch-cost magnitudes are
substantially inflated — in a controlled design the cue-repetition effect
accounted for nearly two-thirds of the measured cost [cite: wiradhany2021]. And
**self-initiated** switching has been shown to *reduce* depletion and increase
focus [cite: nuhn2026], so this system's no-interruption rule is about uninvited
residue, not about a ban on thinking across two things.

**"Brain rot" is a perception, not a diagnosis.** It was Oxford Word of the Year
2024, defined by the OED as a *"perceived"* loss of critical thinking
*attributed to* unchallenging content. OUP's own entry records the scientific
position: there is no evidence that brains actually deteriorate as a direct
result. Merriam-Webster's slang entry notes it is not an official medical
condition [cite: oed2024]. The subjective experience is real and worth taking
seriously. The neurological claim is not made here.

And the word is older than the internet. Thoreau, *Walden*, 1854: *"will not any
endeavor to cure the brain-rot, which prevails so much more widely and fatally?"*
[cite: thoreau1854] His complaint was the devaluation of complex thought — a
society trading interpretable work for simple content.

**The rot is the rot of the grimoire.**

**What we cite, and how carefully.** The 2025 cognitive-debt EEG study behind a
lot of "AI damages your brain" posts is an **arXiv preprint**, not peer-reviewed,
and it concerns one essay-writing task [cite: kosmyna2025]. The 2026 finding that AI
assistance reduces persistence and later unaided performance is real and
well-corroborated, but the paper usually cited for it is misattributed, so we cite
the ones we could actually verify [cite: liu2026]. The full grading, including a
`Verification` field distinguishing a full-text read from a third-hand summary, is
in [`CITATIONS.md`](CITATIONS.md).

---

## The three-layer vault

`raw/` holds the bytes: the book, the paper, the transcript. **Gitignored, and
the only thing this project refuses to track.** It is yours.

`sources/` holds a provenance record: author, title, year, a chapter or section
locator. Commit the coordinates, not the content. This is what makes a
well-sourced vault a legal public repository.

`claims/` holds what you compiled, gated behind your attempt — the adaptation of
the three-layer pattern from [cite: karpathy_llmwiki] where the middle layer gains
a lock the original does not have.

Your own prior reasoning lives in `self/`, and is **not** gitignored. Your
thinking is durable state; a directory marked ephemeral would mean the system had
failed at the only thing it promised.

---

## The scheduler, honestly

A fixed ladder: **1d, 3d, 1w, 3w, 3mo**. A pass advances one step, a lapse
retreats one. One mechanism, not two.

**This is not FSRS and it is not better than FSRS.** FSRS is a trainable DSR
model with a power-law forgetting curve and it genuinely schedules better. Its
per-item state is roughly ten fields including floating-point stability and
difficulty, and the only precedent we found for that in YAML frontmatter is inside
an Obsidian plugin — which would make a plugin the owner of your state and break
the Deletion Test.

We chose legibility. A hand-rolled ladder's output is a fact you can verify by
reading a table, and when it does something odd you can work out whether it is
wrong. If you want FSRS, the swap is contained: keep the six fields, add float
precision, replace one lookup in `bin/g-schedule`. **That reversibility is the
point of keeping the state small.**

---

## Vocabulary

The agent talks in **sets** and **reps**, and says the **rack** is loaded or
quiet. The **schema stays neutral** — `attempt`, `proof`, `prediction`, `error`,
`insight`, `practice`, `audit` — because a few hundred lines of POSIX `sh` has to
parse every note, and a vault of `type: rep` files is a gym log, not a grimoire.

---

## Contributing

Open `examples/book/` and read the notes. Then run:

```sh
sh tests/harness.sh          # the portable date core
sh tests/lint-tests.sh       # every law, both directions, with isolation
bin/g-lint --repo-root . --deletion-test
```

If you want to add a law, add its lint rule *and* a test that breaks exactly one
thing and asserts **only that rule** fires. The isolation is what stops a
half-linter looking like a whole one.

If you add a citation, add a graded entry to `CITATIONS.md` first. `L12` will
tell you if you forgot, and will tell your reviewer if you cited something we
graded `DO-NOT-CLAIM`.

## License

MIT. Deliberately, and with no strings: the point is that this outlives its
software.
