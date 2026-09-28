# Design decisions

Each entry: what was chosen, what was rejected, why. Including the places this
implementation **deviated from the plan that produced it**, because a record
that only contains decisions we agree with is a press release.

---

## 1. Markdown-only, with zero required runtime

**Chosen.** All durable state is `.md` in git. The only executable is an LLM
reading text. `bin/` is optional tooling.

**Rejected.** An Obsidian plugin (the crowded lane, and plugin API churn), an MCP
server (a running service, which cuts directly against the thesis), a SQLite
index, anything requiring a daemon.

**Why.** The Deletion Test is only credible if there is nothing to delete. A
system with a database has a schema migration story, and a schema migration story
is a way for your own knowledge to become hostage to a program.

## 2. POSIX `sh` and `awk`, not a modern runtime

**Chosen.** `/bin/sh` and `awk`. No npm, pip, or cargo. No lockfile.

**Rejected.** `bun` or `node` (the obvious choice, and `ts-fsrs` is a TypeScript
package — convenient, and a dependency in the one place the maths lives);
Python (wider, same problem).

**Why.** A repository whose thesis is *we have no dependencies* cannot carry a
package manager. It also has to run on a machine with a two-decade-old `awk`,
which is the actual population of machines that outlive their software.

**Cost, accepted.** The frontmatter parser is hand-rolled and flat on purpose.
Nested YAML is rejected loudly rather than guessed at.

## 3. A fixed interval ladder, not FSRS

**Chosen.** `1d, 3d, 1w, 3w, 3mo`. A pass advances one step, a lapse retreats
one.

**Rejected.** FSRS, which is a trainable DSR model with a power-law forgetting
curve and genuinely schedules better. Also rejected: a two-axis
intervals/stability heuristic.

**Why.** Legibility over accuracy. A hand-rolled ladder's output is a fact a
human can verify by reading a table; when the scheduler does something odd, you
can work out whether it is wrong. And the audience for this project is not
people who want a marginally better scheduler — it is people who want their
knowledge to still be there in ten years.

**The swap is contained.** Keep the six fields, add float precision to
`stability` and `difficulty`, replace the ladder lookup in `g-schedule`. The
schema does not have to change. That reversibility is the entire reason the
state is small.

## 4. Six human-readable frontmatter fields, not a float ledger

**Chosen.** `due`, `state`, `last_review`, `lapses`, `stability`, `difficulty`,
with `stability` and `difficulty` rounded and display-only.

**Rejected.** Full FSRS state — roughly ten fields including floating-point
`stability` and `difficulty`.

**Why.** The value of these fields is that a human can read them and intervene.
FSRS's own state is a float; a rounded float is a display value, not a
computation, and calling it anything else would be a lie about how the scheduler
works. The only precedent we found for FSRS-in-YAML is inside an Obsidian plugin
[cite: agents_md_standard] — which would make a plugin the owner of your state.

## 5. `AGENTS.md` canonical, one-line shims for everything else

**Chosen.** `AGENTS.md` is the single source of truth. `CLAUDE.md`, `GEMINI.md`
and `QWEN.md` each contain exactly the string `@AGENTS.md`.

**Rejected.** `CLAUDE.md` as canonical (vendor-locked to one harness);
duplicated full files per harness (guaranteed drift).

**Why.** `AGENTS.md` is stewarded by the Linux Foundation's Agentic AI
Foundation, used by 60,000+ repositories, and read natively by Codex, Cursor,
Windsurf, Copilot, Aider, Devin, Amp, opencode and RooCode. Claude Code does *not*
read it — native support has been requested and not granted — so the shim is a
workaround, not a feature, and it is described that way here [cite:
agents_md_standard].

**Constraint, obeyed.** Codex caps `AGENTS.md` at 32 KiB
(`project_doc_max_bytes`), so law content lives in `rules/*.md`. `L10` enforces
it. Ours is 6.7 KB.

## 6. One ontology, not two

**Chosen.** A single primitive — *an idea you must earn the right to hold* — with
ten note types and two kinds of raw: external sources, and your own prior
reasoning in `self/`.

**Rejected.** A separate ontology for cognitive work (the obvious split once
"learning" and "deciding" are both in scope).

**Why.** A person who has to learn the system twice has already lost. The proof
ladder transfers unchanged: on a decision, `recall` is *what were my reasons*,
`derive` is *walk the trade-off*, `transfer` is *apply this to a new decision*.

## 7. Laws for the artifact, disciplines for the operator

**Chosen.** The Five Laws govern the vault. Two Disciplines — The Log and The
Audit — govern you. Separate sections, different verbs.

**Rejected.** One unified "rules" list, and treating the operator with the same
rigour as the record.

**Why.** A **law** is a promise about an immutable record; a **discipline** is a
practice by a fallible human. If breaking a discipline falsified the record, you
would stop opening the vault within a fortnight, and a system you have stopped
using has taught you nothing. Failure has to be cheap here, and it is exactly
what makes it cheap in the vault too: `outcome: failed` is the only key to the
Closed Book, so if failure is socially expensive, nobody records it and Law 1
silently becomes "the answer is always open."

## 8. `null` as the null sentinel in flat YAML

**Chosen.** A literal `null` in frontmatter means *absent*. `g_fm_getn` treats it
as empty, and every "is this filled in?" test uses it.

**Rejected.** Empty values (`key:`), which a flat parser cannot distinguish from a
list header. A real YAML parser, which is a dependency.

**Why.** Absence and `null` are different things in this schema — a missing key is
a malformed note (`L9`), a present-and-empty key is a statement about progress.
Law 1 depends on that distinction, and `g_fm_getn` existing at all is what keeps
it from being forgotten. An earlier draft of the linter used plain `g_fm_get`
here, which meant **Law 1 would not have fired on a real compiled claim**.

## 9. No `--strict` flag

**Chosen.** No warnings tier. Every finding is fatal.

**Rejected.** The `--strict` flag in the plan.

**Why.** We had no soft findings to promote, and a flag that does nothing is worse
than no flag. Removed rather than left as decoration.

---

# Deviations from the plan

Recorded because they happened, and because a reader comparing this to the plan
should not have to guess which is the accident.

## 10. Step-retreat replaced the 2.5× lapse multiplier

**Planned:** a lapse multiplies the next interval by 2.5, capped at 6 months.
**Built:** a lapse retreats one ladder step.

Two overlapping penalty mechanisms are harder to reason about than one, and
legibility was the whole justification for not using FSRS. `lapses` is still
counted — it is a useful diagnostic and it feeds `difficulty` — but it no longer
also scales the interval.

## 11. `proof` gained a `practice` target

**Planned:** a proof references a claim.
**Built:** a proof references a claim **or** a practice; `L9` rejects one with
neither.

Found by the linter, not by inspection: `L7` caught a dangling `proof-aerobic`
because there was no way for a proof to name a practice, which contradicted the
plan's own requirement that a practice needs a proof artifact. The plan was
right and the schema was incomplete.

## 12. `sources/` is separate from `raw/`

**Planned:** `type: source` notes live under `raw/`.
**Built:** `raw/` holds verbatim material and is gitignored; `sources/` holds
committed, paraphrasing provenance records.

The plan's own Must-NOT-Have said no copyrighted source text may be committed,
which `raw/` plus a committed `source` note contradicts. The resolution favours
the legal constraint and keeps Karpathy's three layers intact: bytes, map, and
compiled claim.

## 13. `self/` is not gitignored

**Planned:** Must-NOT-Have said `raw/` **and** `self/` are gitignored, while the
ontology section described `self/` as "committable". Contradictory.

**Built:** `raw/` only. Your own prior reasoning is durable state, and a directory
marked ephemeral would mean the system failed at the only thing it promised. The
`ref_resolves` half of the contradiction is the correct one.

## 14. The date round-trip sweeps 400 days, not 10,000

**Planned:** a 10,000-day consecutive round-trip.
**Built:** 400 consecutive days, plus explicit round-trips across the non-leap
century boundaries (1899, 1900, 2099, 2100) and 1600/2400.

The 10,000-day sweep spawns roughly 40,000 `awk` processes and exceeded a
two-minute timeout. The replacement covers every case the sweep would have found
— a leap day, both non-leap centuries, both leap centuries — in a few seconds.
Verified independently against GNU `date` across 12 dates from 1582 to 2400, zero
mismatches.

## 15. Three lint rules defer to others, for testability

**Built:** `L5` owns `resolution: erased`; `L11` owns the six banned field names;
`L5` owns `supersedes` resolution. `L9` accepts each of these so the owning rule
reports it.

Without these deferrals, one broken thing trips two rules, and the isolation test
suite cannot assert that a rule works on its own. A check that cannot be tested
in isolation is a check you cannot trust.

## 16. Images in the README, after an earlier decision was reversed

**Chosen.** A brand banner in `.github/assets/`, plus five badges as hand-written
SVGs in the brand's own colours, each with a light and a dark variant, wired
through `<picture>` so the right one follows the reader's colour scheme.

**Reversed.** An earlier version of this file argued for a text-only README, on
the grounds that `L8` strips every non-markdown file. **That reasoning was wrong,
and the decision was made on it anyway.** `L8` is scoped to the vault's note
directories (`sources`, `claims`, `attempts`, `proofs`, `predictions`, `errors`,
`insights`, `practices`, `audits`, `self`) plus markdown at the vault root.
`.github/assets/` is repo presentation, not vault state, so `L8` never applied.
The Deletion Test has the same scope: it copies markdown out of the example
vaults and does not look at repo assets.

A rule was stretched to cover a case it was never written for, and the stretch
went unnoticed because the rule is enforced by a machine that had nothing to
say. Worth recording: the enforcement was working, and the reasoning was still
wrong.

**Why it is safe.** The Deletion Test's claim is about *durable state*: if the
tools vanish, your knowledge survives as markdown you can read with `cat`. A
banner is not state. It carries no information that is not also in the text
beneath it, and deleting the whole `.github/assets/` directory costs the
repository nothing but its appearance.

**The palette was measured, not chosen from a template.** `banner-light.png` has
37 distinct colours; the dominant ones are paper `#EFEFEF`, ink `#1E1E1E`, and a
blue ramp running `#0C356C`, `#0A4794`, `#0F59B8`, `#146CDD`, `#2B83FA`,
`#5298FD`, `#88B7FB`. Badges use `#0F59B8` for values on light and `#88B7FB` on
dark, with 2px corners to match the hard-edged mark in the banner rather than the
rounded shields.io silhouette.

The light value was originally `#146CDD`, and rendering the badges showed a defect
that arithmetic had been asked about too late: `#146CDD` on `#EFEFEF` is
**4.33:1**, which fails WCAG AA. The fix is not a new colour, it is the next step
down the same measured ramp, `#0F59B8` at **5.81:1**. The muted labels measure
4.63:1 light and 5.15:1 dark. The dark value, `#88B7FB` on `#1E1E1E`, is 8.11:1.
Every foreground in this set now clears 4.5:1.

**No badge asserts anything unmeasured.** There is no download count, no star
count, no coverage percentage, no "trusted by". Each states a fact checkable in
the tree: `MIT`, `none`, `0`, `12`, `pass`.

**A sixth badge was cut after looking at the render.** `assertions: 59` was
accurate and the least distinctive thing in the row, an internal test count
rather than a property of the project. Six badges came to 792px, which wraps
inside GitHub's content column and leaves one badge orphaned on a second line.
Five come to 666px and sit on one row. The deletion pass asked what understanding
disappears when the badge goes, and the answer was a number already printed in
chapter 12.

**Resolved: the dark banner exists, and the `<picture>` wrapper is back.** The
first asset supplied was a flat `#1E1E1E` rectangle: 2100x900, one distinct
colour, 100% of pixels, no mark and no text. It was committed, and then removed.

Committing it was the mistake worth recording. It was referenced by nothing,
because the banner's `<source>` and `<img>` both pointed at the light file, so
`<picture>` was doing nothing at all. What it did do was sit in
`.github/assets/` looking like a finished dark asset, implying a capability the
repository did not have. A blank image that asserts support it cannot provide is
fabricated proof, and removing it cost nothing, because a solid rectangle is
reproducible from three lines of CSS by anyone who wants one.

The replacement is the real thing: 37 distinct colours, `#1E1E1E` ground at
96.5%, with the mark and tagline inverted to `#EFEFEF` and the same blue ramp
carried through. Both variants measure **14.5:1** for tagline and mark against
their own ground, well clear of AA. The wrapper switched correctly on first
render, sampled at the pixel: `#EFEFEF` under a light scheme, `#1E1E1E` under a
dark one.

The five badge pairs kept their `<picture>` blocks throughout, because their dark
variants were real from the start: verified to differ from the light ones, with
background `#1E1E1E`, label `#8F8F8F` and value `#88B7FB`. A wrapper that
switches between two genuine variants is doing a job; one that switches between a
file and itself is not, which is exactly why the banner's did nothing.

Recolouring the light banner or inverting the mark vector would have been
inventing brand material, and which treatment is right has a blast radius across
every surface carrying the mark. The owner's asset was the only correct input,
and it took one attribute to wire up.

Verified by rendering the actual `<picture>` markup in headless Chromium at both
colour schemes and reading the result, rather than trusting that the files were
correct because they were dropped in by a script. The first version failed that
test twice over, on contrast and on row wrap.

## 17. The author section claims only what the repository can check

**Chosen.** The author section makes no claim that cannot be verified from inside
this repository: no job titles, no "passionate about", no list of technologies, and
no personal philosophy published on the owner's behalf.

**Rejected.** The usual profile paragraph, which is unverifiable from here and
indistinguishable from every other one. Also rejected: publishing the author's
private working doctrine, which was considered and explicitly declined.

**Why.** This project ships a lint rule that fails the build on an unverifiable
citation. A bio that cannot be checked is the same failure in a different file, and
a private document quoted at length would be a third one: accurate, unverifiable,
and not the author's to publish here.

**What the section does instead.** It names the refusals, which are all visible in
the code, and it points at a real defect that was found and fixed. The
unbound-variable crash in `l12_citations()` is in the git history and in
[`RELEASE-CHECKLIST.md`](RELEASE-CHECKLIST.md), so the claim is checkable.

**Cost, accepted.** It reads as more self-referential than a normal bio, and it is
shorter than one. That is the accurate trade for a repository whose subject is
evidence.
