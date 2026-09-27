# CITATIONS

Every scientific claim this project makes is graded here, and **lint rule L12
fails the build if any document cites an id graded `DO-NOT-CLAIM`.** The
honesty layer is not a promise in a README; it is a check in CI.

Each entry carries:

- `- **Grade**` — `SAFE` | `PREPRINT` | `OVERREACH` | `MISATTRIBUTED` | `DO-NOT-CLAIM`
- `- **Verification**` — `full text read` | `abstract + secondary` | `secondary only`
- `- **Finding**` — what the work actually says
- `- **Caveat`** — what it does not say, or where the popular reading overreaches

**`Verification` is the field that matters most.** A claim is only as good as
how far we actually read. Where we read a citing paper rather than the paper
itself, we say so. Several of the most-cited findings in this field circulate as
third-hand summaries that have drifted from their sources; the grade and the
verification line exist to stop that drift here.

Cite in documents as `[cite: <id>]`.

---

## roediger2006

- **Grade**: SAFE
- **Verification**: secondary only (universally replicated; the original claim is uncontested)
- **Citation**: Roediger, H. L., III, & Karpicke, J. D. (2006). Test-enhanced learning: Taking memory tests improves long-term retention. *Psychological Science*, 17(3), 249–255.
- **Finding**: Students who took a memory test after studying a passage retained it substantially better one week later than students who spent the same time restudying — even though the restudying group *felt* they had learned more.
- **Why we use it**: The origin of the testing effect, and the origin of the desirability gap that makes external evidence necessary rather than optional.
- **Caveat**: The effect is about *retention of studied material*, not about transfer to new problems. See `kestin2025` and `bastani2025` for what happens when a tool changes the learning target.
- **Source**: https://www.brucehayes.org/Teaching/papers/2008_Roediger_Karpicke_Science.pdf

## karpicke2007

- **Grade**: SAFE
- **Verification**: secondary only
- **Citation**: Karpicke, J. D., & Roediger, H. L., III. (2007). Repeated retrieval during learning is the key to long-term retention. *Journal of Memory and Language*, 57(3). https://doi.org/10.1016/j.jml.2006.09.004
- **Finding**: Retrieval practice during learning is what produces long-term retention.
- **Why we use it**: The mechanism behind the proof ladder.
- **Caveat**: **This is frequently miscited as a *Science* paper.** It is *Journal of Memory and Language*. The famous *Science* paper is `karpicke2008`.
- **Source**: https://www.sciencedirect.com/science/article/abs/pii/S0749596X06001367

## karpicke2008

- **Grade**: SAFE
- **Verification**: full text read
- **Citation**: Karpicke, J. D., & Roediger, H. L., III. (2008). The critical importance of retrieval for learning. *Science*, 319(5865), 966–968. https://doi.org/10.1126/science.1152408
- **Finding**: After an item had been successfully recalled once, **repeated study produced no measurable learning a week later**, while **repeated retrieval produced a large gain** (~80% correct on the final test). Separately and importantly: *students' predictions of their own future performance were uncorrelated with their actual performance.*
- **Why we use it**: Two things. It is the strongest single justification for the proof ladder, and its metacognitive finding is the clearest statement of why the system cannot trust the learner's self-report and must require artifacts.
- **Caveat**: See `soderstrom2015` — part of the "restudy is useless" reading is a spacing artifact and does not fully replicate.
- **Source**: https://www.brucehayes.org/Teaching/papers/2008_Roediger_Karpicke_Science.pdf

## soderstrom2015

- **Grade**: SAFE
- **Verification**: abstract + secondary
- **Citation**: Soderstrom, N. C., Kerr, T. K., & Bjork, R. A. (2015). The critical importance of retrieval—and spacing—for learning. *Psychological Science*, 26(11). https://doi.org/10.1177/0956797615617778
- **Finding**: Replicated `karpicke2008` (once recalled, repeated testing helps and repeated restudy does not), then showed that the between-subjects design had confounded spacing: when spacing was controlled within-subjects, **both** repeated testing and restudying improved learning.
- **Why we use it**: We cite this to *weaken* our own headline. "Retrieval is uniquely important" survives; "restudy is useless" does not. A project that only cites the convenient half is not being honest.
- **Caveat**: This does not weaken the friction thesis — a closed-book attempt is a *retrieval* event, and that is the thing the evidence supports best.
- **Source**: https://pubmed.ncbi.nlm.nih.gov/26674128

## dunlosky2013

- **Grade**: SAFE
- **Verification**: full text read
- **Citation**: Dunlosky, J., Rawson, K. A., Marsh, E. J., Nathan, M. J., & Willingham, D. T. (2013). Improving students' learning with effective learning techniques. *Psychological Science in the Public Interest*, 14(1), 4–58. https://doi.org/10.1177/1529100612453266
- **Finding**: The definitive review. Utility ratings:

  | Rating | Techniques |
  |---|---|
  | **High** | practice testing, spaced practice |
  | **Moderate** | elaborative interrogation, self-explanation, interleaved practice |
  | **Low** | summarization, highlighting, keyword mnemonic, imagery for text, rereading |

- **Why we use it**: Only two techniques earned *high* utility. That is the entire reason the system is built around retrieval and scheduling, and the reason highlighting and summarizing are not features.
- **Caveat**: Popular summaries of this paper routinely list self-explanation and elaborative interrogation as winners. They are **moderate**, not high. We build on the two highs and treat elaboration as a bonus, not a pillar.
- **Source**: https://journals.sagepub.com/doi/10.1177/1529100612453266

## vanlehn2011

- **Grade**: SAFE
- **Verification**: full text read
- **Citation**: VanLehn, K. (2011). The relative effectiveness of human tutoring, intelligent tutoring systems, and other tutoring systems. *Educational Psychologist*, 46(4), 197–221. https://doi.org/10.1080/00461520.2011.611369
- **Finding**: The field believed human tutoring achieved **d = 2.0** over no tutoring, ITS **d = 1.0**, and answer-based computer tutoring **d = 0.3**. The review found human tutoring at **d = 0.79** and ITS at **d = 0.76** — nearly identical to each other, and both far below belief. In one condition, students who only *read* matched the tutoring groups' learning gains.
- **Why we use it**: This is the honest ceiling. Whatever we build, we are not promising the 2-sigma result, because a careful review says it was never real.
- **Caveat**: This bounds the *effect of tutoring*; it does not bound what a learner can achieve with unbounded time and effort. It is an argument against inflated claims, not against effort.
- **Source**: https://www.tandfonline.com/doi/full/10.1080/00461520.2011.611369

## kirschner2006

- **Grade**: SAFE
- **Verification**: full text read
- **Citation**: Kirschner, P. A., Sweller, J., & Clark, R. E. (2006). Why minimal guidance during instruction does not work: An analysis of the failure of constructivist, discovery, problem-based, experiential, and inquiry-based teaching. *Educational Psychologist*, 41(2), 75–86. https://doi.org/10.1207/s15326985ep4102_1
- **Finding**: Minimally guided instruction fails for novices because it ignores the structure of working and long-term memory. **Direct instruction with worked examples produced vastly more learning than discovery**, and transferred better to new contexts.
- **Why we use it**: This paper argues *against* unguided Socratic tutoring — which is the obvious criticism of our design. We publish it anyway, with the reconciliation below.
- **Reconciliation**: **Friction is not the absence of guidance.** The Closed Book is friction; the five-rung Hint Ladder is guidance, and its top rung is a *worked example* — precisely what Kirschner found works. We attack the learner's attempt before we hand over a model, and when we do hand over a model, it is a worked example. Kirschner attacks unassisted discovery, not scaffolded struggle.
- **Caveat**: Kirschner's target is *novices* and *minimal* guidance. It is not a claim that experts learn nothing from exploration.
- **Source**: https://www.tandfonline.com/doi/pdf/10.1207/s15326985ep4102_1

## bastani2025

- **Grade**: SAFE
- **Verification**: full text read (PDF)
- **Citation**: Bastani, H., Bastani, O., Sungu, A., Ge, H., Kabakcı, Ö., & Mariman, R. (2025). Generative AI without guardrails can harm learning: Evidence from high school mathematics. *PNAS*, 122(26), e2422633122. https://doi.org/10.1073/pnas.2422633122
- **Finding**: A preregistered cluster RCT, ~1,000 high-school mathematics students in one Turkish school, 2023–24, two grade levels, AI tutors comprising ~15% of the curriculum. Three arms:

  | Arm | Assisted practice | **Unaided exam** (preregistered primary outcome) |
  |---|---|---|
  | GPT Base (resembles a plain ChatGPT) | **+48%** | **−17%** vs control |
  | GPT Tutor (withholds answers, teacher-written hints) | **+127%** | harm essentially **erased** (not significantly different from control) |
  | Control (no AI) | — | baseline |

  Students with the unguarded tool later scored **worse than students who never had it at all.** Students' own estimates of the effect were **over-optimistic**.
- **Why we use it**: This is the empirical foundation of the entire project. The same model produced *opposite* learning outcomes based only on its guardrail design. That is the refusal layer, measured.
- **Caveats**:
  - The guarded arm removed the harm; it did **not** produce a benefit. Guardrails are damage control, not a performance multiplier. We do not claim otherwise.
  - Domain is school mathematics. Transfer to knowledge work is an assumption, not a finding.
  - The design conclusion — *secure the first hard attempt and the final unaided check; allow guarded assistance in between* — is a constraint on tool design in general, not a law of nature.
- **Source**: https://www.pnas.org/doi/10.1073/pnas.2422633122

## kestin2025

- **Grade**: SAFE
- **Verification**: full text read
- **Citation**: Kestin, G., Miller, K., Klales, A., Milbourne, T., & Ponti, G. (2025). AI tutoring outperforms in-class active learning: an RCT introducing a novel research-based design in an authentic educational setting. *Scientific Reports*, 15, 17458. https://doi.org/10.1038/s41598-025-97652-6
- **Finding**: RCT, N = 233, Harvard introductory physics. Students using a guard-railed AI tutor learned significantly more in less time than students in an in-class active-learning section, and reported more engagement and motivation. Learning gain z = −5.6, p < 10⁻⁸; effect size 0.63 by linear regression (underestimated due to a ceiling effect), 0.73–1.3 by quantile regression.
- **Why we use it**: It is the strongest evidence that a *well-designed* AI tutor can beat good human-led active learning — the ceiling is real when the scaffolding is right.
- **Caveats**:
  - **The outcome is an immediate post-test, not a delayed retention test.** Bastani's primary outcome was unaided and later. These are different measurements.
  - The authors' own scope limitation: *"we do not presume that structured AI tutoring will always outperform in-class active learning in all contexts, for example, those requiring complex synthesis of multiple concepts and higher-order critical thinking."* That excluded context is roughly what this project is for.
  - Venue is *Scientific Reports*, not a physics-education journal as commonly reported.
- **Source**: https://www.nature.com/articles/s41598-025-97652-6

## deslauriers2019

- **Grade**: SAFE
- **Verification**: secondary only (the paper is consistently reported as PNAS 2019; we read the finding, not the full text)
- **Citation**: Deslauriers, L., McCarty, K., Miller, K., Callaghan, K., & Kestin, G. (2019). Measuring actual learning versus feeling of learning in response to being actively engaged in the classroom. *PNAS*.
- **Finding**: Students' sense of learning from active learning was **negatively** related to their actual learning gains, while their sense of learning from passive lecture was **positively** related — students felt they learned most from the method that taught them least.
- **Why we use it**: With `karpicke2008`'s metacognitive finding and `bastani2025`'s over-optimistic self-reports, this is the third independent line saying the learner's confidence is an unreliable instrument. Hence: artifacts, not self-report.
- **Caveat**: The correlation reverses under instructional design; the point is not that feeling is always wrong, but that it is not evidence.
- **Source**: https://www.semanticscholar.org/paper/23c1bcb0c0450d79abbe0a1c2a9b4a3b60b6fe03

## liu2026

- **Grade**: SAFE
- **Verification**: secondary only (read as a citation in two independent arXiv papers; full text not read)
- **Citation**: Liu et al. (2026). AI assistance reduces persistence and hurts independent performance. arXiv:2604.04721.
- **Finding**: As reported by two citing papers: AI assistance raised math and reading performance, but reduced participants' persistence and their performance on subsequent unaided tasks.
- **Why we use it**: It independently corroborates the `pi2026` phenomenon. Because that attribution is wrong, this paper — not the one in the original research dump — is what we cite for the effect.
- **Caveat**: **We have not read this paper.** Until we do, treat the effect size and generalisation as unestablished. This entry exists to replace a misattribution with a real lead, not to close the question.
- **Source**: https://arxiv.org/pdf/2604.04721

## kosmyna2025

- **Grade**: PREPRINT
- **Verification**: abstract + secondary
- **Citation**: Kosmyna, N., Hauptmann, E., Yuan, Y. T., Situ, J., Liao, X.-H., Beresnitzky, A. V., Braunstein, I., & Maes, P. (2025). Your Brain on ChatGPT: Accumulation of Cognitive Debt when Using an AI Assistant for Essay Writing Task. arXiv:2506.08872.
- **Finding**: EEG-based comparison of LLM-assisted, search-assisted, and brain-only essay writing. Reports weaker neural connectivity and poorest recall of one's own output in the LLM group.
- **Why we use it**: It is the most-discussed neuroscience-adjacent claim in this area, so we had to engage it rather than pretend it does not exist.
- **Caveats**: **It is a preprint and has not been peer reviewed.** It concerns a specific essay-writing task with small group sizes. The methodological literature on AI-assisted writing has raised design concerns about exactly this paradigm. Cite it as a preprint or do not cite it. We do not treat it as load-bearing.
- **Source**: https://arxiv.org/abs/2506.08872

## leroy2009

- **Grade**: SAFE
- **Verification**: abstract + secondary
- **Citation**: Leroy, S. (2009). Why is it so hard to do my work? The challenge of attention residue when switching between work tasks. *Organizational Behavior and Human Decision Processes*, 109(2), 168–181. https://doi.org/10.1016/j.obhdp.2009.04.002
- **Finding**: **Attention residue** — cognitive activity about a previous task persists while you work on the next one. Critically, *psychological disengagement from the unfinished task before switching* predicted successful switching; **merely finishing the task did not eliminate the interference.**
- **Why we use it**: The mechanism behind our refusal to interrupt. A proactive tutor is a machine for injecting attention residue into the exact activity where you are trying to hold attention.
- **Caveat**: Laboratory task-switching paradigms have been criticised — see `wiradhany2021` for a substantial confound in the classic measurements.
- **Source**: https://psycnet.apa.org/record/2009-10822-007

## liefooghe2008

- **Grade**: SAFE
- **Verification**: abstract + secondary
- **Citation**: Liefooghe, B., Barrouillet, P., Vandierendonck, A., & Camos, V. (2008). Working memory costs of task switching. *Journal of Experimental Psychology: Learning, Memory, and Cognition*, 34(3), 478–494. https://doi.org/10.1037/0278-7393.34.3.478
- **Finding**: Across four experiments, recall performance **decreased as a function of the number of task switches**.
- **Why we use it**: The measurement behind the attention-log field `switches`.
- **Caveat**: See `wiradhany2021`.
- **Source**: https://pubmed.ncbi.nlm.nih.gov/18444750

## wiradhany2021

- **Grade**: SAFE
- **Verification**: secondary only
- **Citation**: Wiradhany, W., & Nieuwenstein, N. (2021). Partitioning switch costs when investigating task switching in relation to media multitasking. *Psychonomic Bulletin & Review*. https://doi.org/10.3758/s13423-021-01895-z
- **Finding**: In a two-cue design, the **cue-repetition effect accounted for nearly two-thirds of the measured switch cost.** Classic laboratory switch-cost figures are therefore inflated by confounded cue transitions.
- **Why we use it**: To stop us overstating `leroy2009`. The mechanism is real; the magnitude in the popular retelling is not trustworthy.
- **Caveat**: Concerns the measurement, not the phenomenon.
- **Source**: https://link.springer.com/article/10.3758/s13423-021-01895-z

## nuhn2026

- **Grade**: SAFE
- **Verification**: secondary only
- **Citation**: Nuhn, C., et al. (2026). Effects of task switching on depletion, motivation, and creativity.
- **Finding**: **Self-initiated** task switching reduced reported depletion and increased task focus and motivation relative to a control group.
- **Why we use it**: A necessary corrective. *Voluntary* switching is not the same as interruption. Our no-interruption rule is about uninvited residue, not about a ban on thinking across two things.
- **Caveat**: Read as an abstract listing only.
- **Source**: https://psycnet.apa.org/journals/prs/25/1/1.html

## hillman2008

- **Grade**: SAFE
- **Verification**: abstract + secondary
- **Citation**: Hillman, C. H., Erickson, K. I., & Kramer, A. F. (2008). Be smart, exercise your heart: Exercise effects on brain and cognition. *Nature Reviews Neuroscience*, 9(1), 58–65. https://doi.org/10.1038/nrn2298
- **Finding**: The canonical review establishing that aerobic physical activity improves cognitive performance across molecular, cellular, systems, and behavioural levels.
- **Why we use it**: The scientific basis for treating the brain as something you *train*, not something you protect.
- **Caveat**: Effects are on *selective* aspects of cognition, not general intelligence. Correlational and intervention evidence differ in strength.
- **Source**: https://www.nature.com/articles/nrn2298

## bjsm2025

- **Grade**: SAFE
- **Verification**: secondary only (we read the abstract and its headline figures, not the full meta-analysis)
- **Citation**: Effectiveness of exercise for improving cognition, memory and executive function: a systematic umbrella review and meta-meta-analysis. *British Journal of Sports Medicine*, 59(12), 866. (2025)
- **Finding**: Pooled across **133 systematic reviews and meta-analyses, over 2,700 RCTs, more than 250,000 participants**: general cognition SMD **0.42** (95% CI 0.37–0.47), executive function SMD **0.24** (0.21–0.27). Funnel-plot adjusted true effects: d = 0.31 / 0.24 / 0.20.
- **Why we use it**: The single most robust number available for "as we train our body we train our brain." It is also the number that keeps us honest — after adjustment, these are *modest* effects, not superpowers.
- **Caveat**: **We did not read the full paper** and have not verified the author list. The umbrella scope and the adjusted true effects are the load-bearing figures. Authors should be added before publication.
- **Source**: https://bjsm.bmj.com/content/59/12/866

## ye2024

- **Grade**: SAFE
- **Verification**: abstract + secondary
- **Citation**: Ye, M., et al. (2024). Effects of aerobic exercise on executive function of healthy middle-aged and older adults: A systematic review and meta-analysis. *Behavioural Brain Research*. PMID 39326271.
- **Finding**: 42 RCTs, 2,881 participants. Cognitive flexibility g = 0.343, working memory g = 0.392, inhibitory control g = 0.229 (all p < 0.001). Dose-response: largest effects after **13–24 weeks**, **46–60 min/session** (flexibility), **20–45 min/session** (working memory), at **5–7 days/week** or **3–4 days/week** (inhibitory control).
- **Why we use it**: The dose prescription in `rules/02-two-disciplines.md` comes from here, not from folk wisdom.
- **Caveat**: Population is middle-aged and older adults (45+). Do not silently generalise to a 25-year-old. We state the population wherever we state the dose.
- **Source**: https://pubmed.ncbi.nlm.nih.gov/39326271

## chang2012

- **Grade**: SAFE
- **Verification**: secondary only
- **Citation**: Chang, Y.-K., et al. (2012). Aerobic exercise and neurocognitive performance: A meta-analytic review of randomized controlled trials. (PMC2897704)
- **Finding**: Across RCTs of aerobic training: attention and processing speed g = 0.158, executive function g = 0.123, memory g = 0.128 — **modest** effects, far smaller than the earlier Colcombe & Kramer (2003) figures.
- **Why we use it**: The counterweight. We cite the optimistic umbrella review *and* the more modest meta-analysis, because the discrepancy is real and partly explained by two studies in the older review that were not true RCTs.
- **Caveat**: Being fair to both, the exercise–cognition effect is robust in direction and modest in magnitude, and grows over weeks.
- **Source**: https://pmc.ncbi.nlm.nih.gov/articles/PMC2897704

## chi2014

- **Grade**: SAFE
- **Verification**: secondary only
- **Citation**: Chi, M. T. H., Feltovich, P. G., & Glaser, R. (2014). The ICAP framework: Linking cognitive engagement to active learning outcomes. *Educational Psychologist*, 49(4), 219–243.
- **Finding**: Engagement depth ranks **Interactive > Constructive > Active > Passive**. Learners can be cognitively active and still learn little.
- **Why we use it**: The framework for ranking the proof ladder's rungs. An attempt that is merely *active* (rereading, highlighting) sits below *constructive* (deriving, explaining) and far below *interactive* (transfer, teaching).
- **Caveat**: A framework for ranking engagement, not a quantitative law.
- **Source**: https://www.learningscientists.org/blog/2016/8/18-1

## oed2024

- **Grade**: SAFE
- **Verification**: full text read
- **Citation**: "brain rot." *Oxford English Dictionary*, added June 2025; Oxford Word of the Year 2024. https://corp.oup.com/news/brain-rot-added-to-the-oxford-english-dictionary
- **Finding**: The OED defines brain rot as "a **perceived** loss of intelligence or critical thinking skills, esp. (in later use) as attributed to the overconsumption of unchallenging or inane content or material." OUP's own entry records the scientific position: *"there is no evidence to suggest that brains actually deteriorate as a direct result of this behaviour."* Merriam-Webster's slang entry likewise notes it is "**not itself an official medical condition**."
- **Why we use it**: It licenses the phrase while forbidding the claim. The subjective experience of dulled attention is real and worth taking seriously. The neurological decay story is not evidenced. A project built on citation discipline can hold both halves at once; a wellness product cannot.
- **Caveat**: "Perceived" is doing real work in that definition. Quoting it selectively — as either a dismissal or a diagnosis — misrepresents the source.
- **Source**: https://corp.oup.com/news/brain-rot-added-to-the-oxford-english-dictionary

## thoreau1854

- **Grade**: SAFE
- **Verification**: full text read (etymological record)
- **Citation**: Thoreau, H. D. (1854). *Walden*. — earliest recorded use of "brain-rot": *"While England endeavors to cure the potato-rot, will not any endeavor to cure the brain-rot, which prevails so much more widely and fatally?"*
- **Finding**: The term is 170 years old and originally a complaint about **the devaluation of complex thought** — society trading interpretable work for simple content — not about neurons.
- **Why we use it**: It names the actual disease. The rot is the rot of the grimoire: a culture that stops compiling and keeping books worth rereading. That is a thesis about text, and it happens to be ours.
- **Caveat**: A literary allusion, not a cognitive claim.
- **Source**: https://www.etymonline.com/word/brain-rot

## karpathy_llmwiki

- **Grade**: SAFE
- **Verification**: full text read
- **Citation**: Karpathy, A. LLM Wiki. https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f
- **Finding**: A three-layer pattern — immutable `raw/` sources, a maintained interlinked `wiki/`, and a schema document (`CLAUDE.md` / `AGENTS.md`) that tells the agent how to behave — with three operations (**ingest**, **query**, **lint**) and two navigation files (`index.md` content-oriented, `log.md` append-only and greppable).
- **Why we use it**: The knowledge layer, adapted: the compiled layer must be *gated behind a recorded failure*, which the original pattern has no concept of. We also adopt the honest scale note — the original author reports it works well to roughly 100 sources and a few hundred pages.
- **Caveat**: This is an idea file, not a specification. It explicitly defers detail to the agent. We treat it as prior art, not as a contract.
- **Source**: https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f

## agents_md_standard

- **Grade**: SAFE
- **Verification**: full text read
- **Citation**: AGENTS.md — a simple, open format for guiding coding agents. Stewarded by the Agentic AI Foundation (AAIF), Linux Foundation. https://agents.md
- **Finding**: Used by over 60,000 open-source projects. Read natively by Codex, Cursor, Windsurf, Copilot, Aider, Devin, Amp, opencode, RooCode, Jules, and Factory. Claude Code reads `CLAUDE.md`; Gemini CLI reads `GEMINI.md`; Qwen Code reads `QWEN.md`. Codex caps the document at `project_doc_max_bytes` (32 KiB default), merges root→cwd, and lets the closest file win.
- **Why we use it**: It is the portability contract. We ship canonical `AGENTS.md` plus one-line `@AGENTS.md` shims, and keep `AGENTS.md` under the 32 KiB cap.
- **Caveat**: Claude Code does **not** read `AGENTS.md` natively; the `@` import is a workaround, not native support, and native support has been requested and not granted.
- **Source**: https://agents.md

---

# DO NOT CLAIM

Nothing below may be cited from any document in this repository. Lint rule **L12**
fails the build on a `[cite: <id>]` pointing at any of these. They are listed so
the prohibition is legible rather than invisible.

## pi2026

- **Grade**: DO-NOT-CLAIM
- **Verification**: not found
- **Cited as**: "Pi et al. (2026), More AI Assistance Reduces Cognitive Engagement"
- **Why it is here**: The **phenomenon is real and well corroborated** — AI assistance raises assisted performance while reducing later unaided performance and persistence. The **attribution is wrong.** We could not find a paper by that author with that title.
- **Use instead**: `liu2026`, plus `bastani2025`, which is preregistered and far stronger.
- **Caveat**: Citing a real finding under a wrong author is exactly the failure this ledger exists to prevent.

## tullis2026

- **Grade**: DO-NOT-CLAIM
- **Verification**: not found
- **Cited as**: "Tullis (2026), Using Generative AI to Support Retrieval Practice"
- **Use instead**: Nothing. LLM-generated questions are a known technique; we do not have a verified citation and we do not assert the claim.

## roelle2022

- **Grade**: DO-NOT-CLAIM
- **Verification**: not found
- **Cited as**: "Roelle & Rotgans (2022), Sequence matters!"
- **Note**: The underlying intuition — that attempting before being told beats being told first — is central to our design. **We still cite nothing**, because we could not find this paper. The Closed Book stands on `bastani2025` and the retrieval literature, not on this.

## blasco2024

- **Grade**: DO-NOT-CLAIM
- **Verification**: not found
- **Cited as**: "Blasco & Charisi (2024), Socratic vs Non-Socratic AI"

## learnlm_rct

- **Grade**: DO-NOT-CLAIM
- **Verification**: not found
- **Cited as**: "LearnLM Team / Google + Eedi (2025), AI tutoring can safely and effectively support students, N=165, +5.5pp transfer"
- **Related and verified**: Google's *TeachLM* paper reports that across pedagogical interaction benchmarks — student talk time, words per tutor turn, questions per interrogative turn — **human tutors consistently outperform LLMs**, including the LearnLM model. So the available evidence on this model cuts *against* the claim usually made for it.
- **Use instead**: `kestin2025` for the strong version of the claim, with its own scope limitation stated.

## guideeval2025

- **Grade**: DO-NOT-CLAIM
- **Verification**: not found
- **Cited as**: "Discerning Minds or Generic Tutors? — GuideEval (2025)"
- **Use instead**: `chi2014` (ICAP) and `kirschner2006`, both verified, for the question of whether an agent can adaptively guide rather than merely generate questions.

## ibm2025

- **Grade**: DO-NOT-CLAIM
- **Verification**: not found
- **Cited as**: "IBM Research (2025), How People Manage Knowledge in their 'Second Brains'"

## streaks_evidence

- **Grade**: DO-NOT-CLAIM
- **Verification**: searched, nothing found
- **Cited as**: any empirical claim that habit streak counters work or fail
- **Note**: Our prohibition on streaks is a **philosophical** consequence of the friction thesis — a streak counter manufactures the *feeling* of progress, which is the failure mode we exist to prevent. It is **not** an empirical claim, and we do not dress it up as one. This entry exists to keep that line sharp.
