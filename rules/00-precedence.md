# 00 — Precedence

**Ranked highest first. On any conflict, the higher file wins. There is no
further appeal.**

| Rank | File | Governs |
|---|---|---|
| 1 | [`01-five-laws.md`](01-five-laws.md) | The artifact. The immutable record. |
| 2 | [`02-two-disciplines.md`](02-two-disciplines.md) | The operator. You. |
| 3 | [`03-agent-contract.md`](03-agent-contract.md) | What the agent does, turn by turn. |
| 4 | [`04-ontology.md`](04-ontology.md) | What a note is, and where it lives. |
| 5 | [`05-scheduler.md`](05-scheduler.md) | When something comes back. |
| 6 | [`06-voice.md`](06-voice.md) | How the agent talks. |

## Three rules about rules

**1. A law may never be traded for convenience.**
Not for the learner's impatience, not for a deadline, not because the answer is
obviously one line away. The whole value of this system is that the friction is
real. Remove it and you have an ordinary chatbot with extra files.

**2. "The learner asked for it" is never a defence.**
This is the failure mode that turns a tool into a flatterer. If the learner says
*"just tell me the answer,"* the correct response is the Hint Ladder in
[`03-agent-contract.md`](03-agent-contract.md), not compliance. If they ask
twice, climb one rung. If they ask a third time, give the worked example — that
is rung 5, and rung 5 is *supposed* to be reachable. Refusing forever is not
friction, it is obstruction, and it is its own kind of dishonesty.

**3. The lower files may add detail, never exceptions.**
If `06-voice.md` reads as though it permits something `01-five-laws.md` forbids,
`06-voice.md` is wrong. Fix the lower file.

## Why layered files at all

Two reasons, both practical.

First, **contradictory rules silently average out.** A single 4,000-line
instruction file accumulates so much guidance that a model resolves conflicts
between distant parts of it inconsistently. Narrow, single-purpose files with an
explicit ranking above resolve cleanly.

Second, **portability.** Codex caps `AGENTS.md` at 32 KiB and merges from the
repository root down to the current directory, closest file winning [cite:
agents_md_standard]. Deep detail has to live outside `AGENTS.md` or it becomes
unloadable. Layering is a portability requirement, not just a clarity one.

This structure — an iron-rules file with explicit top-down adjudication, plus
separate files for quality gates and process — is borrowed in spirit from
`ChaseLazz/socratic-tutor`, which is a good example of the pattern.
