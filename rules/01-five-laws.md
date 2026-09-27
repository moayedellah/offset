# 01 — The Five Laws

These govern **the artifact** — the vault. Each law names the lint rule that
mechanically enforces it, because an unenforced law is a preference.

If a law and a preference disagree, the law wins
([`00-precedence.md`](00-precedence.md)).

---

## Law 1 — The Closed Book

> **Never show a compiled claim before the learner has produced their own
> attempt at the raw material. A recorded failure is the only key.**

- **Enforced by**: `L1` — a `claim` with `status: compiled` must have a non-null
  `unlocked_by` resolving to an `attempt` or an `error` note.
- **Rests on**: the retrieval literature [cite: roediger2006] [cite: karpicke2008],
  and directly on the measured cost of unguarded assistance [cite: bastani2025].
  In that RCT, students with a plain-ChatGPT-style tutor scored **17% worse**
  on an unaided exam than students who never had it at all. The *same model*,
  rebuilt to withhold answers, lost that harm entirely.
- **Violating note**:

  ```yaml
  ---
  type: claim
  id: natural-selection-mechanism
  status: compiled      # compiled and open
  unlocked_by:          # no key. the answer was on screen first.
  ---
  ```

- **What the agent may still do**: state that a claim *exists* and offer the
  attempt. "There is a compiled claim on this; want to try it first?" is
  allowed. Reading the body is not.

---

## Law 2 — No summary as first contact

> **A source's summary is a result, never an input.**

- **Enforced by**: `L2` — a `source` note may not carry a `summary` field until
  an `attempt` referencing it exists.
- **Rests on**: [cite: dunlosky2013], which rated **summarization LOW** for
  learning utility, in the same review that rated practice testing and spaced
  practice the only two **HIGH**.
- **Violating note**:

  ```yaml
  ---
  type: source
  id: on-origin-of-species
  summary: Darwin argues that species evolve by natural selection.   # first contact
  ---
  ```

---

## Law 3 — Provenance

> **Every compiled claim carries where it came from, where in it to look, and
> whether it is the source speaking or us.**

- **Enforced by**: `L3` — every non-draft `claim` needs `source`, `locator`, and
  `kind` in `{source, inference}`.
- **Rests on**: the three-layer pattern in [cite: karpathy_llmwiki], where an
  immutable `raw/` layer is separated from the maintained compiled layer.
  Without an explicit `kind`, an inference launders itself into an apparent
  quotation, and within a few months you cannot tell which of your sentences the
  book actually said.
- **Violating note**:

  ```yaml
  ---
  type: claim
  id: sexual-selection-explained
  status: compiled
  unlocked_by: attempt-003
  source: on-origin-of-species
  locator: ""              # nowhere to look
  kind: source             # asserted, not known
  ---
  ```

---

## Law 4 — Exposure is not mastery

> **No `proven` state without a proof artifact the learner produced. Not on
> exposure, not on confidence, not on getting it right with the answer visible.**

- **Enforced by**: `L4` — `state: proven` requires a resolvable `proof` with a
  `rung` in `{recall, derive, transfer}`; and a `claim` whose latest proof is
  older than a `failed` attempt may not be `proven`. Also `L6` — a `proven` note
  past its `due` date fails the build.
- **Rests on**: [cite: bastani2025] for the harm, and for the metacognitive
  case, three independent findings: [cite: karpicke2008] (students' predictions
  of their own performance were *uncorrelated* with actual performance),
  [cite: deslauriers2019] (perceived learning from active learning ran
  *opposite* to actual gain), and [cite: bastani2025]'s own finding that
  students over-estimated what the AI had done for them.
- **The rung ladder** is not decoration. Ranked by engagement depth [cite:
  chi2014]:

  | Rung | Meaning | Unlocks |
  |---|---|---|
  | `recall` | reproduce it, unaided | the claim |
  | `derive` | reproduce the reasoning, not the result | the claim, and counts toward a prerequisite |
  | `transfer` | solve a problem the source never solved | **the subject milestone** |

- **Violating note**:

  ```yaml
  ---
  type: claim
  id: divergent-evolution
  state: proven      # "I read it and it made sense"
  ---
  ```

---

## Law 5 — The Ledger

> **Never erase a recorded error. Corrections append; they never overwrite.**

- **Enforced by**: `L5` — every `error` needs `recorded_at`; `resolution` may
  not be `erased`; `supersedes` may not dangle.
- **Rests on**: the whole point of an audit trail. A system that silently
  corrects itself is a system that launders its own errors — and the error
  ledger is the only record of *how your understanding changed*, which is worth
  more than the current state of your understanding.
- **`retracted` is a state, not a deletion.** When a new source contradicts a
  proven claim, the claim becomes `retracted`, an `error` note with
  `resolution: superseded` points at it via `supersedes`, and both stay.
- **Violating note**:

  ```yaml
  ---
  type: error
  id: err-007
  recorded_at: 2026-09-01
  resolution: erased       # not a legal value
  ---
  ```

---

## The three principles

The Five Laws are the enforceable surface. Three named principles sit above
them and explain *why*.

### The Deletion Test

**The tool must be able to die tomorrow.** Delete Obsidian, delete the CLI,
delete the agent, delete this repository's code — and the vault must still be
readable, greppable, and usable. Not "exportable." *Usable.*

Durable state is `.md` in git. Nothing else. This is not an aesthetic
preference; it is lint rule `L8`, and `--deletion-test` proves it by deleting
every non-markdown file and re-linting.

As we train our body we train our brain. The same is true of tools: a tool you
depend on is a tool that gets to decide what you can still do. Keep the
training log in text and the tool becomes a lens, not a landlord.

### The Closed Book

The principle behind Law 1. **An answer you did not struggle for is a loan,
not a gift.** Every mechanism in this system that makes the easy path slightly
harder is downstream of that sentence.

### The Ledger

The principle behind Law 5. **Append, never overwrite.** Errors, corrections,
retractions, superseded proofs. The record of what you believed and what killed
it is the durable thing. The current state of your beliefs is just a snapshot of
it.
