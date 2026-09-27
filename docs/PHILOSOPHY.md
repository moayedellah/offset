# The philosophy

## One law, two domains

> **You do not read to have read books. You read to train the reading brain.**

That is the whole thesis, and it is one law applied twice.

Applied to knowledge: a claim you have merely been exposed to is a claim you
cannot reproduce. The proof ladder exists to convert exposure into retrieval, and
the ladder to convert retrieval into something that survives a month.

Applied to the operator: the same structure governs your attention. A day of
fragmented switching is a day you spent below what you could have done, and no
dashboard can recover it — the residue is real, and it is not visible from the
inside [cite: leroy2009].

And applied to the software: a tool you cannot delete is a tool that gets to
decide what you can still do. So the durable state is text, and the tool is a
lens.

## The corollary

> **An AI that removes all cognitive effort is the cognitive equivalent of
> sitting on the couch.**

This is not a stance on AI. It is a statement about what a training system is
for. If a system makes the work feel finished, and the work is not finished, the
system has optimised the wrong variable — and the learner has no way to tell,
because the feeling and the progress have been decoupled.

That is not a hypothetical failure mode. It is the measured one. In a
preregistered RCT, students with an unguarded AI tutor scored **+48%** on assisted
practice and then **−17% on an unaided exam — worse than students who never had it
at all** — while over-estimating what it had done for them [cite: bastani2025].
The same model, rebuilt to withhold answers, lost the harm entirely.

So this system refuses. The refusal is the philosophy, and the lint rules are
what stop the refusal from being a vibe.

## The three principles

### The Deletion Test

**The tool must be able to die tomorrow.** Not "exportable". *Usable*.

Durable state is `.md` in git. Nothing else. `L8` fails the build on a
non-markdown file inside a vault, and `--deletion-test` proves the claim by
deleting every non-markdown file and re-linting.

### The Closed Book

**An answer you did not struggle for is a loan, not a gift.**

The compiled claim is the answer sheet. It stays shut until a recorded failure
opens it. The pointer is the only key, and `L1` fails the build if a compiled
claim has none.

The critical dependency is that **failure must be cheap**. If recording a
mistake costs something socially, nobody records one, the compiled claim never
opens, and Law 1 quietly becomes "the answer is always open" while the README
still claims otherwise. The most likely way this system fails is not a bug. It
is a learner who stopped writing down being wrong.

### The Ledger

**Append, never overwrite.**

`erased` is not a legal value for `resolution` and never will be. Corrections
are new notes that point at old ones. A proven claim that turns out to be wrong
becomes `retracted` and keeps its proof, marked.

Because the record of being wrong is worth more than being right: the current
state of your beliefs is a snapshot, and a snapshot is worth little on its own.
What is worth a great deal, in a year, is the sequence — what you believed in
March, what broke it, what you believed instead, and why.

## The laws and the disciplines

A **law** is a promise about an immutable record. A **discipline** is a practice
by a fallible human, and must be breakable — if breaking it falsified the record,
you would stop opening the vault in a fortnight.

That asymmetry is why The Log and The Audit are not laws. You may miss a day. The
audit then reports the gap as a gap, and the record stays true.

## On "brain rot"

The phrase is **Oxford Word of the Year 2024**. The OED defines it as a
*"perceived"* loss of critical thinking *attributed to* overconsumption of
unchallenging content — and OUP's own entry records the scientific position:
there is no evidence that brains actually deteriorate as a direct result.
Merriam-Webster's slang entry notes it is not an official medical condition
[cite: oed2024].

So the subjective experience — dulled attention, fog, difficulty holding a
thread — is real and worth taking seriously. The neurological claim is not
evidenced, and this project will not make it. A repository built on citation
discipline cannot afford the one claim that would be checked most carefully.

And the word is Thoreau's, from *Walden* in 1854 [cite: thoreau1854]: a
complaint about the **devaluation of complex thought** — society trading
interpretable work for simple content. That is a complaint about a grimoire
rotting.

**The rot is the rot of the grimoire.** A culture that stops compiling and keeping
books worth rereading. The cure is not a technique; it is a practice, kept in
text, by someone who still thinks hard enough to compile it.

## And the training

As we train our body we train our brain [cite: hillman2008]. The effect is real,
directionally robust, and **modest** — general cognition SMD 0.42 across 2,700+
RCTs, falling to d = 0.31 after funnel-plot adjustment [cite: bjsm2025], with a
more conservative analysis finding executive function at g = 0.123
[cite: chang2012]. It takes weeks: 13–24 weeks, 20–60 minutes, 3–7 days a week
[cite: ye2024], from adults 45 and over.

Prescribe only what is strongly evidenced. No supplements, no nootropics, no
diet ideology, no routines-as-identity — there is no reason a text-based learning
system should be telling you what to eat, and that line is what keeps this
credible to a technical reader.

A practice is done when there is a **proof artifact**, not when a box is ticked.
You did the walk; now write down what you noticed. Without that, the brain half
of this system decays into a habit checklist, and a habit checklist is a
scoreboard, and a scoreboard manufactures the feeling of training without the
training.

## Vocabulary

**Rack.** Where you lift; where you fire something durable; the software that
must be disposable. One word carrying the body analogy and the durability
constraint at once, which is the whole argument of this project in a noun.

**Set.** One session of focused work on one thing.

**Rep.** One retrieval attempt at one claim, at a named rung.

The agent speaks in these. The **schema does not**: `attempt`, `proof`,
`prediction`, `error`, `insight`, `practice`, `audit`. The analogy belongs in the
prose; the schema belongs to the machines.
