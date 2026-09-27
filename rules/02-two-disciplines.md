# 02 — The Two Disciplines of the Operator

The Five Laws govern the **artifact**. These two govern **the operator** — you.
The asymmetry is deliberate:

> A **law** is a promise about an immutable record.
> A **discipline** is a practice by a fallible human.

A discipline must be breakable. If breaking it falsified the record, you would
stop opening the vault within a fortnight, and a system you have stopped using
has taught you nothing. Failure here costs you nothing except the streak you
were not keeping anyway.

---

## The Log

An append-only attention log. **Facts only. No interpretation.**

| Field | Type | Meaning |
|---|---|---|
| `date` | `YYYY-MM-DD` | The day |
| `start` | `HH:MM` | When a work block began |
| `end` | `HH:MM` | When it ended |
| `task` | string | What you were working on, in your words |
| `interrupts` | integer | Things that pulled you off it |
| `switches` | integer | Times you moved to another task |

**`attention-log.md` at the vault root. Append only. Never edited after the
fact.**

The log records two numbers because they are the ones with evidence behind
them. Recall performance **decreases as a function of the number of task
switches** [cite: liefooghe2008], and the lingering cognitive activity of a
previous task persists while you work on the next [cite: leroy2009]. Those two
columns are the whole measurement apparatus. They are deliberately austere
because a measurement you can fudge is not a measurement.

**No score fields. Ever.** Lint rule `L11` rejects the entire vault if it finds
a field named `score`, `streak`, `points`, `xp`, `level`, or `rank`.

### The prohibition, and why it is not a style choice

A streak counter converts a record of what happened into a number you feel bad
about. That number then starts generating behaviour designed to protect the
number rather than to do the work. This is the exact failure this project
exists to prevent: **manufacturing the feeling of progress in place of
progress.** The evidence for the harm of unguarded AI assistance is that it
*felt* like learning while measurably reducing unaided performance
[cite: bastani2025]. A streak counter is the same trade, smaller.

We hold no empirical claim about whether streaks work. We searched, found
nothing verifiable, and therefore do not dress a philosophical position up as an
empirical one. See `streaks_evidence` in `CITATIONS.md`, graded `DO-NOT-CLAIM`.

---

## The Audit

Periodically, read the log back and report **frequencies**. Never grades.

Required register — a fact, not a judgement:

> Tuesday: 47 switches, 31 of them under 90 seconds. Longest unbroken block:
> 22 minutes. Median block: 4 minutes.

Not this:

> Your focus score is 62%. You are 18% below your target. Trend: declining.

**The learner interprets the frequencies. The audit does not.** A number with an
attached judgement attached becomes a grade within a week, and a grade is a lie
with a chart on it. The audit's entire job is to make the data visible and then
stop talking.

Two honest caveats we hold about our own numbers: classical laboratory
switch-cost figures are inflated by a confounded cue-repetition effect
[cite: wiradhany2021], so treat the mechanism as real and the popular magnitude
as untrustworthy; and **self-initiated** switching is not the same as
interruption — one recent study found it *reduced* depletion and increased focus
[cite: nuhn2026]. This system's no-interruption rule is about uninvited residue,
not about a ban on thinking across two things.

---

## Prescription: the hard border

This system prescribes **only what is strongly evidenced**, and holds practices
to the **same proof requirement as concepts**. A practice is "done" when there is
a proof artifact, not when a box is ticked. Practise it, then prove you noticed
something.

### In

**Aerobic exercise.** The best-supported lever we have. A 2025 umbrella review
pooled 133 reviews, over 2,700 RCTs and more than 250,000 participants: general
cognition SMD **0.42** (95% CI 0.37–0.47), executive function **0.24**
(0.21–0.27); after funnel-plot adjustment, the true effects are d = 0.31 / 0.24
/ 0.20 [cite: bjsm2025]. The direction is robust across decades of work
[cite: hillman2008].

Dose, from a meta-analysis of 42 RCTs in adults 45+ [cite: ye2024]:
**13–24 weeks** to see the effect, **20–60 minutes** per session, **3–7 days**
per week. Working memory g = 0.392, cognitive flexibility g = 0.343, inhibitory
control g = 0.229.

**Population caveat, stated because it matters:** that dose-response evidence is
from middle-aged and older adults. Do not silently generalise it to a 25-year-old.

**Magnitude caveat, also stated because it matters:** a more conservative
meta-analysis of RCTs found *modest* effects — executive function g = 0.123,
memory g = 0.128 [cite: chang2012]. We cite both. The honest summary is: real,
modest-to-moderate, directionally robust, and it takes weeks. **Anyone promising
faster is selling something.** As we train our body we train our brain — but
nobody's brain has a fast setting.

### Out

**Supplements. Nootropics. Diet ideology. Routines-as-identity.**

There is no good reason a text-based learning system should be telling you what
to eat, and this line is what keeps the project credible with a technical reader
who has seen a hundred wellness repos built on supplements. If a prescription
is not in the `In` list with a citation attached, it does not go in.

---

## On the phrase "brain rot"

We use the phrase. We never make the neurological claim.

"Brain rot" was **Oxford Word of the Year 2024**, defined by the OED as a
**"perceived"** loss of intelligence or critical thinking skills *attributed to*
the overconsumption of unchallenging or inane content. OUP's own entry records
the scientific position plainly: **"there is no evidence to suggest that brains
actually deteriorate as a direct result of this behaviour."** Merriam-Webster's
slang entry notes it is "**not itself an official medical condition**"
[cite: oed2024].

So: the subjective experience — dulled attention, fog, difficulty holding a
thread — is real and worth taking seriously. The claim that the brain tissue
rotted is not evidenced, and this project will not assert it. Taking the lived
experience seriously while refusing the unfounded claim is the entire honesty
layer applied to the word itself.

And the word is older than the internet. Thoreau, *Walden*, 1854: *"While
England endeavors to cure the potato-rot, will not any endeavor to cure the
brain-rot, which prevails so much more widely and fatally?"* [cite: thoreau1854]
His complaint was about **the devaluation of complex thought** — society trading
interpretable work for simple content. That is a complaint about a grimoire
rotting, which is exactly our subject: a culture that stops compiling and
keeping books worth rereading.

**The rot is the rot of the grimoire.**
