# EV-C01-003 · The phase-A probe: its question, its result and the probe checker's verdict (W-C01-25; PC-16)

**What this is.** The evidence for W-C01-25 (`plan/work/W-C01-25.md`), plan Section 9, C01, "Phase-A probe" (PC-16; CHK-C00-046 condition 5). A discovery subagent picked one real SOUL development question; three researchers read the library and outside sources on it; a synthesizer wrote a sourced result; a fresh subagent continued from that result alone; and a fresh-context probe checker judged the result against criteria (a) to (f). This record gives the question and how it was chosen, every run with its role, task and agent, the result, and the verdict. The seven outputs are filed under `raw/`, and the workflow script that holds every task is filed verbatim as `tasks.js`; section 8 states how the outputs were cleaned for this public repository. W-C01-25 asks that the probe ran, was judged and reached C02, not that its criteria were met (PC-16 place 9); nothing here adopts the result.

## Evidence envelope (plan Section 8 item 9)

| Field | Value |
|---|---|
| Source commit | devos `main` `6a3aa557f6dd677844d98600641ba5df52c78fb7` (PR #191), at which the probe ran; the research library `agentic-os-search` at `941f027d3a15497b90e60d752303c0463a9feab5`, read only, with a clean tree (the runs' D8 lines) |
| Deployment configuration | The working session `session_01WKJi23FwAjFtiyD1DbQ2Rs` ran workflow `wf_90fe70e6-98b`, whose script is `tasks.js`. Runs 1 to 4 used the role definition `researcher`, runs 5 and 6 `producer`, the probe checker `checker` (`.claude/agents/` at `6a3aa55`; each `model: inherit`, so the session's model). Each run started with a fresh context and saw only its task text, into which the earlier outputs it needed were pasted verbatim |
| Criterion version | Plan Section 9, C01, "Phase-A probe" (question, run, criteria (a) to (f), budget, checker, use) and W-C01-25's acceptance block, both at `6a3aa55`; the criteria stood in the plan before the run |
| Input | The task texts in `tasks.js` (a shared rules block and one template per role); SOUL's purpose (plan Section 1.1) and the library at `941f027d`; outside pages that runs 3 and 4 read on 2026-10-06 |
| Actual observation | Sections 1 to 5 below: the question and its choice, the runs, the result and its continuation, the verdict |
| Raw evidence ID | Agents `ad70870b296a01575` (run 1), `af88196dface4ff86` (run 2), `a16d944793666c726` (run 3), `a0d5f98c6845c40d4` (run 4), `a33dbb1fa59d045cc` (run 5), `a42a1dfa45ab1dc73` (run 6) and `a53b94908b2dced5f` (probe checker), in the working session above, 2026-10-06. The executor took each output with `tools/subagent_audit.py last` and checked it with `tools/subagent_audit.py disciplines` (DISCIPLINES OK for all seven). Filed under `raw/`, cleaned as section 8 states |
| Independence level | Same session, fresh-context subagents (declared, Ek A 5.3; PC-06). The probe checker took no part in the probe and was given its records only; it is a review by the same model family in the same session, as its own D4 line says |

## 1. The question

Picked by run 1, the discoverer; verbatim from `raw/01_discovery.md`:

> SOUL may form an agent for a user's work in a field where the user cannot judge quality. Before that agent may act or have its output used, what qualification evidence should SOUL require, of what unit (the agent alone, or the agent bound to its method, information and environment for that use), and where should that evidence live in SOUL's records? The difficulty is that DevOS's hidden-exam method (plan 7.3), which criterion 33 names as the yardstick, assumes an answer key that such a field may not have.

The later runs kept the question as discovered and corrected one premise in its last sentence: criterion 33 makes DevOS's present role-preparation method the yardstick and names hidden exams as the way a better method shows it is better; it does not ask each agent to pass a hidden exam at run time (research A, W2; research B, W1; research C, gap 1; result, section 1 and W1).

## 2. How the question was chosen

**Who chose it.** Run 1, whose task (`tasks.js`, the `discover` call, lines 28 to 47, with the shared blocks `DB` at line 13 and `COMMON` at lines 15 to 26) set conditions and named no topic: a question whose answer changes a decision in developing SOUL, not in building DevOS; one the library can inform; small enough for three researchers and one synthesis; with assumptions that may be wrong (measure 1), prerequisites to test (measure 2), library content that can change or limit a decision (measures 3 and 8), and at least one decision that Appendix B 3.17's class rule could make high_impact (measure 7). It had to weigh at least three candidates. The builder and Batu chose nothing (plan Section 1.2).

**Its reasons** (its section "Why it is a real SOUL development question", summarised):
- SOUL works where the user's own expertise ends and assembles the actors a piece of work needs, adapting its capacity under control (plan L141-143); qualifying an agent it forms is that control.
- Criterion 33 already asks SOUL's agents to keep a quality floor and leaves the method to DevOS's research (plan L218).
- The hidden-exam yardstick rests on an exam author, a separate exam environment and keys the agent cannot reach (plan 7.3, L808-817); in another user's account and in a field no one present has mastered, these may be missing.
- It read the library as leaving the matter open (`lib:EXP-004/MS01-COVERAGE` L84, G04; `lib:EXP-004/OPEN-QUESTIONS` L41-43, O10; `lib:EXP-002/OPEN-QUESTIONS` L5-11, L53-59). Research A (W1) and the result (W8) later found that two continuations (`lib:EXP-004/DQ02`, `lib:EXP-004/DQ04`) had already given it a conceptual answer; only the empirical side is open.
- Three SOUL decisions depend on it: how SOUL prepares and qualifies the agents it forms; whether its data model gets a qualification record family; whether an unqualified agent may cause effects. Under EkB 3.17 (L293) all three are at least high_impact.

**Candidates considered** (seven):

| # | Candidate | Its reason |
|---|---|---|
| 1 | Qualifying the agents SOUL forms, under criterion 33 | Chosen: a real high-impact decision, assumptions that can be falsified, mechanisms and counter-evidence in the library, and a likely squeeze (no answer key) for measure 9 |
| 2 | Where SOUL keeps lasting working state in the user's account | Not chosen: the closest memory studies are only planned; it turns on current platform facts and the open host gap (G03); risk of anchoring on DevOS's database |
| 3 | What enforces SOUL's effect boundary in another user's account | Not chosen: mostly a current-platform question; it overlaps C08 and DevOS's own guard, so it drifts into building DevOS |
| 4 | What "base SOUL" contains before any user work | Not chosen: an umbrella over the others; three researchers would produce a survey, not a decision |
| 5 | How SOUL finds needs the user did not state | Not chosen: the plan records that no reliable measure exists, and the probe itself measures discovery, so it would be partly circular |
| 6 | SOUL's first concrete target use | The strongest alternative frame; not chosen: a purpose and scope choice that belongs to Batu (batu class), which the library cannot settle |
| 7 | Shared learning without leaks; the languages SOUL uses with its end users | Not chosen: both come after SOUL exists, the library says little on them, and language is Batu's product decision |

**The two pulls it disclosed** (its D2 line and its "Overlap I disclose"):
1. Its task wanted a question that exercises the measures, which pulls toward a convenient question. The probe checker reads this as a selection condition that matches the probe's purpose, not a topic (finding 7).
2. The library proposes a next question of its own (`lib:EXP-004/DQ01` L113) close to the one chosen. The discoverer treated it as data and states that it was not the basis of the choice.

**What the checker found on the origin.** Nothing shows the builder or Batu choosing the topic (finding 7). It noted that it had not been given the discovery's task text; that text is the `discover` call in `tasks.js`, cited above.

## 3. The runs

| Run | Role as stated in its task | Agent | Task (in `tasks.js`) | Output |
|---|---|---|---|---|
| 1 | "**Discoverer** (a researcher whose task is discovery)" | `ad70870b296a01575` | `discover` call, lines 28-47 | `raw/01_discovery.md` |
| 2 | "**Researcher A (the library's evidence)**" | `af88196dface4ff86` | research template, lines 49-70, angle A (line 51), with run 1's output | `raw/02_research_A.md` |
| 3 | "**Researcher B (counter-evidence, gaps and wrong assumptions)**" | `a16d944793666c726` | the same template, angle B (line 52), with run 1's output | `raw/03_research_B.md` |
| 4 | "**Researcher C (high-impact decisions and current outside sources)**" | `a0d5f98c6845c40d4` | the same template, angle C (line 53), with run 1's output | `raw/04_research_C.md` |
| 5 | "**Synthesizer**" | `a33dbb1fa59d045cc` | `synthesize` call, lines 72-100, with runs 1 to 4 | `raw/05_result.md` |
| 6 | "**Continuer**, a fresh subagent" | `a42a1dfa45ab1dc73` | `continue` call, lines 102-115, with run 5's output only | `raw/06_continuation.md` |
| — | "the **probe checker** of the phase-A probe" | `a53b94908b2dced5f` | `probe-checker` call, lines 117-162, with runs 1 to 6 | `raw/07_probe_checker_verdict.md` |

Every task begins with the shared blocks `DB` (the discipline instruction, line 13) and `COMMON` (context and rules, lines 15-26). The outputs pasted into later tasks are the outputs as returned, before the cleaning of section 8. Runs 2 to 4 ran in parallel.

**Budget.** Six counted runs of the twelve allowed; the probe checker's run is not counted (plan C01, "Budget"). The budget was not spent, so nothing here is partial on that ground.

## 4. The result and its continuation

**The result** (run 5, `raw/05_result.md`) marks itself as a candidate input to C02's work list: no decision in it is accepted for DevOS or SOUL, and it is not C07's result. Its eight decisions, each at least high_impact under EkB 3.17:
- **D-1.** Criterion 33's hidden exams are DevOS's instrument for comparing SOUL's agent-preparation methods; fitness of an agent for a named use comes from SOUL's purpose (Section 1.1), not from that clause. Recorded as an interpretation; if Batu meant a hidden exam per agent at run time, D-7 changes and the conflict goes to him.
- **D-2.** What SOUL qualifies is a binding for a named use (carrier, role text and method version, information sources and context method, tools, environment and grants, the use with its criterion), not an agent alone; the same holds when SOUL reuses an actor or brings in an outside tool or expert.
- **D-3.** Three levels, each permitting certain acts (worth trying: a bounded trial; fit for a named use: dependent work; this result accepted: admission of the result and its effect). An unqualified binding may draft; effects and the admission of results are gated; exploring with outside effects needs its own permission; effects need consistency over repeated trials.
- **D-4.** Where no one present can judge, grading by a model without reference answers supports at most "worth trying", for a second model family too. "Fit for a named use" needs an error-sensitive path that carries a reference and does not share the producer's frame; without one the claim narrows and the user is told. The user's approval is authority, not evidence of quality.
- **D-5.** A qualification records what it depends on (carrier model and provider, judge and instrument, role and method, tools, sources, environment and grants, criterion, use). A declared change sends it to re-evaluation, not to failure; drift under an unchanged model name needs pinned versions or periodic re-probes; it does not carry across providers.
- **D-6.** The content of a qualification record is fixed (binding, frame, basis, distinct result states, a separate assessment layer and decision layer, dependencies and reopen triggers, a flag for an instrument change) and travels with every consumer; its physical shape stays open. Runtime records live in the user's own space.
- **D-7.** The hidden, keyed exam belongs to DevOS's validation of SOUL's preparation method before release (C05), with balanced sets kept apart from development cases. No exam bank ships in SOUL, and nothing already disclosed, this probe's public records included, can later serve as a hidden test.
- **D-8.** Qualification depth is budgeted per level; a spent budget is a resource event, not a verdict. Paid or outside evaluation of a user's work is that user's cost and data decision in SOUL and Batu's in DevOS; a provider tier that uses submitted content to improve its products receives no private user work.

It also names ten wrong or partly wrong assumptions in the question (W1 to W10) and thirteen gaps (G1 to G13; G13, the open core: no source gives "fit for a named use" without a reference or an outside ground truth); tests the four prerequisites the discovery proposed and adds two (A1: C05's comparison set balanced and kept apart from development cases; A2: the binding dimensions a qualification record now lacks); follows nine errors (E1 to E9) to failure classes, three with capability-gap candidates; and meets four squeezes (S1 to S4), each with a frame question first and no new mechanism. Its next step: bring D-6's open record shape to a decision-ready comparison.

**The continuation** (run 6, `raw/06_continuation.md`) took that next step from the result alone, with no library search and no web access. It added option A+ (DevOS's existing Review → Verdict → Acceptance chain and staleness carriers, with the competence and evaluation records), traced A, A+, B and C through two invented cases and four events, and drafted an unaccepted high_impact decision: A+ for DevOS, decided at C05, with B as fallback and C rejected as the only shape. It found that EvalRun, which C02 builds, has no grader identity or version, and proposed a note for C02's work list (section 7 below takes it up). It also read parts of DevOS's data model beyond the result's cited ranges, and said so for criterion (d).

## 5. The probe checker's verdict

`raw/07_probe_checker_verdict.md`: verdict **MET**; criteria "a: met; b: met; c: met; d: met; e: met; f: met"; independence "same session, fresh-context subagent (declared, Ek A 5.3)"; date 2026-10-06. Its front matter keeps `checker_run: AGENT-ID`, as its task told it to; the run is agent `a53b94908b2dced5f`. Its findings, one line each:

1. **(a) met.** W1 to W10 and G1 to G13 each carry a source, the search is described, and the seven it re-checked against their passages hold.
2. **(b) met.** Each proposed prerequisite answers "which decision or action would be wrong without this?", and so do A1 and A2; in EkB it confirmed that EvalRun has no grader field and `Verdict.result` no `not_applicable`.
3. **(c) met.** The sampled passages behind D-2 to D-7 say what the result claims and shape the decisions named; one minor imprecision on where the self-review labels sit, not blocking.
4. **(d) met.** The continuation did the named next step from the result without new research; its extra reading of DevOS's own data model is not redoing the probe's research, though under the strictest reading of "alone" that is the fact the judgment turns on, and it shows a gap in the hand-over.
5. **(e) met.** Errors E1 to E9 have failure classes (E1 to E3 with capability-gap candidates), squeezes S1 to S4 start with a frame question, and it confirmed E3 and the basis of E1 itself.
6. **(f) met.** Every decision is at least high_impact and states the research it reflects; the outside papers were checked against the checker's own knowledge, not fetched.
7. **Question origin: shown by the records**; limit: it was not given the discovery's task text (now in `tasks.js`).
8. **Records' content:** own synthesis and identifiers in substance, with six phrases of six to eight words over the probe's four-word cap; this blocks the write to devos, not the verdict, until they are reworded, checked with an n-gram check and passed by the leak check. Section 8 records that this was done.
9. **Budget and scope:** six of twelve runs; the result is marked as input to C02, not as an accepted decision or C07's result.

Its D8 line writes the devos head as `6a3aa557dd677844d98600641ba5df52c78fb7`, two characters short of `6a3aa557f6dd677844d98600641ba5df52c78fb7`; the file keeps it as written.

## 6. The use

The result, with its checker's verdict, enters C02's work list through a note on `plan/work/C02.md`; that work list asks again each record family's first need (plan Section 9, ordering principle). The executor adds the note; its text is in section 7. The result is not C07's result: N-101 on `plan/work/C07.md` keeps the probe's question and result out of C07's own test, and C07 runs as planned. Adopting any of D-1 to D-8 needs a Decision record through EkB 3.17's format gate, or an entry in the SOUL requirement record that C12 creates.

## 7. Note for plan/work/C02.md

Entered as N-128 on `plan/work/C02.md` by the executor, with this text:

**The phase-A probe's result, for this work list** (W-C01-25; PC-16; `evidence/C01/phase_a/EV-C01-003_phase_a_probe.md`, 2026-10-06). The probe worked one SOUL question: what evidence SOUL should require before an agent it forms acts in a field the user cannot judge, of what unit, and where that evidence is recorded. Its checker found criteria (a) to (f) met. The result is input to this work list, not a gate and not C07's result (N-101 on C07); none of its decisions is accepted. What it gives this stage's record families:
1. **EvalRun** (built here, EkB 3.15 and the activation table): it has no grader identity or version. If C05's exams use a model grader for some items (not yet known), criterion 33's method comparison cannot show that both methods were graded alike, and a change of grader cannot trigger a retest. This list decides whether the grader's identity and version enter EvalRun's fields here or at C05.
2. **Review, Verdict, Acceptance** (built here, EkB 3.11): the continuation's draft would carry a qualification on this chain at C05 (its option A+). Two questions are asked again when these families are built, though neither is needed for this stage's own tests: should `Review.basis_refs` be typed by kind (subject or instrument), and does `Verdict.result` need `not_applicable`? Leaving both out now means a migration at C05 if A+ is kept.
3. **Not prerequisites of this stage** (K-1 item 3): the record shape for a qualification is owned by C05, where Competence is activated; C05's comparison set must be balanced and kept apart from development cases (A1); D-1's reading of criterion 33 is an interpretation whose match with Batu's meaning is open (research B, "Open"), and if he meant a hidden exam per agent at run time, D-7 changes and the conflict goes to him with options.

Owner: the executor. Deadline: this stage's work list.

## 8. Cleaning for the public repository

**Why.** The outputs cite the library by full path, and the library holds those same paths in its own indexes; some outputs also repeated short runs of library wording. The guard's leak check (`tools/leak_fingerprints.py scan`) matched 64 lines of the seven outputs; the workflow script matched none. The probe checker's finding 8 named six phrases over the probe's own four-word limit. The probe's rules let the outputs carry DevOS's synthesis and source identifiers only (plan Section 0.5).

**What was changed, by kind** (each cleaned file says so in an italic line under its title, or under its front matter for the verdict; apart from these edits nothing was changed, added or removed, and every line number keeps its place in its reference):

| Kind | How | Count |
|---|---|---|
| Library paths | Each path that names a library file from the library's root, from a top-level folder, or from an experiment, study or Foundation folder (with or without the `agentic-os-search@941f027d:` or `LIB:` prefix, and including slug-elided forms such as `…/EXP-004-…/`) became its key `lib:<code>/<stem>`. A list under a folder label became a list of keys. The outputs' legend lines now expand to keys (for example `EXP4 = lib:EXP-004`). References through a legend (EXP4/…, GS/…, CS/…, ACT/…, SP/…, AP/…, CL/…, EXP5/…, EXP6/…), by a path relative to the one just cited, or by a bare file name were kept, except where they matched the library at six words; then only their folder and file name were cut to the key's stem (for example `GS/syntheses/testing-…md` became `GS/testing-eval`) | 179 references: discovery 31, research A 31, research B 24, research C 25, result 66, continuation 2 |
| Phrases | Each run of five or more words that repeated library wording was reworded in DevOS's own words with the same meaning; a list of result states that repeated the library's own list word for word was given in another order, with the same members | 19: research A 9 (F2, F3 twice, F7, F8, F9, F12, F18 twice), research B 5 (findings 4, 6 twice, 13 twice), research C 1 (finding 9), result 3 (D-2, D-6, D-7), continuation 1 (F4). They include, at their places in the outputs, the six phrases of the checker's finding 8 |
| Phrases quoted in the verdict | In finding 8, each quoted phrase, with the source cited after it, became `[phrase withheld: n words from <key> L<line>]`; n counts words as the leak check does (8, 8, 7, 6, 8, 7) | 6 |
| One outside page | Anthropic's page of 2026-01-09, "Demystifying evals for AI agents", which the library cites with the same title, date and address: where an output gave its address, the address became the date, title, site and section (`www.anthropic.com`, Engineering); in the result's D-3, which gave title and date only, the date was put before the title | 4 places: research C 2, result 2 |
| Other outside addresses | Kept as written: the leak check does not flag them. Three of them (the arXiv abstract address after an author's "et al.", the NIST playbook page, the Gemini API pages) also occur in the library and so match it at six words; they are outside addresses, not library text | 0 changed |

`tasks.js` is the workflow script byte for byte (SHA-256 `b8fd4194a95636658b518369fb76f7d2119bdf0d800867ecbe081141461441da`). Turkish file stems inside keys (`04-ILK-CLOUD`, `07-V2`) are identifiers; the outputs quote one Turkish phrase of the plan's criterion 33 (TR-A18), which is DevOS's own text, and the verdict's finding 1 quotes one Turkish term of the library, a single word, within the probe's limit.

### Source keys

A key `lib:<code>/<stem>` names one file of the research library `agentic-os-search` at commit `941f027d3a15497b90e60d752303c0463a9feab5`: the file in the code's folder (in the subfolder given below) whose name is `<stem>.md` or begins with `<stem>-`. Every key used was checked to resolve to exactly one file at that commit. A code stands for a folder; an experiment's descriptive slug is left out, and `EXP-004-*` finds its folder. A key without a code (`lib:README`) is a file at the library's root.

| Code | Folder | Stems used, by subfolder |
|---|---|---|
| (none) | the library's root | root: `README` |
| `research` | `research/` | root: `INDEX` |
| `soul-foundations` | `research/soul-foundations/` | root: `STATE` |
| `studies` | `research/studies/` | root: `CATALOG` |
| `explorations` | `explorations/` | root: `CATALOG` |
| `EXP-002` | `explorations/EXP-002-*` | reflections: `OPEN-QUESTIONS` |
| `EXP-003` | `explorations/EXP-003-*` | root: `STATE` |
| `EXP-004` | `explorations/EXP-004-*` | root: `STATE`; artifacts: `MS01-COVERAGE`, `MS01-QUESTION-BANK`, `MS01-RESEARCH`, `MS01-SOUL`, `SY01`; continuations: `DQ01`, `DQ02`, `DQ04`, `T10`, `T11`, `T15`; reflections: `OPEN-QUESTIONS`, `QUALIFICATIONS`, `TERMS` |
| `EXP-005` | `explorations/EXP-005-*` | artifacts: `DEVOS02`; reflections: `LESSONS`; sources/conversation: `04-ILK-CLOUD`, `07-V2` |
| `EXP-006` | `explorations/EXP-006-*` | work: `B7`, `B9` |
| `actors-ground` | `research/soul-foundations/03_*/grounds/actors/` | root: `A1`, `FINDINGS-MAP`, `INDEX`, `OPEN-QUESTIONS` |
| `composite-standing` | `research/soul-foundations/05_*/composite-standing/` | root: `KEY`, `S3` |
| `foundations-08` | `research/soul-foundations/08_*/` | root: `COMPLETION-AND-RESIDUALS`, `REUSE` |
| `gstack` | `research/studies/gstack/` | root: `CORE`; syntheses: `multi-agent-cross-model`, `review-qa`, `testing-eval` |
| `superpowers` | `research/studies/superpowers/` | root: `CORE`, `META`; syntheses: `S01`; notes: `U06A` |
| `anthropic-playbook` | `research/studies/anthropic-*` | root: `03-SOUL`, `04-FALSIFIERS`, `META` |
| `multi-agent-patterns` | `research/studies/`, folder `multi-agent-patterns/` | root: `CONVERSATION-SYNTHESIS`, `SOUL-DEVELOPMENT` |
| `autoresearch` | `research/studies/autoresearch/` | root: `META` |
| `i-have-adhd` | `research/studies/i-have-adhd/` | root: `META` |
| `carbon-layer-mQfTdNVCOB0` | `research/studies/the-carbon-layer/`, video folder `mQfTdNVCOB0-*` | root: `META`; notes: `12-VERIFICATION`, `14-MATH` |

The outputs' own legends map to these codes: EXP4, EXP5 and EXP6 to `EXP-004`, `EXP-005` and `EXP-006`; CS to `composite-standing`; ACT to `actors-ground`; GS to `gstack`; SP to `superpowers`; AP to `anthropic-playbook`; MAP to `multi-agent-patterns` (in research A, its file `SOUL-DEVELOPMENT`); CL to `carbon-layer-mQfTdNVCOB0`; and, in the continuation, MS01 to `lib:EXP-004/MS01-SOUL` and GS-RQ to `lib:gstack/review-qa`. Short references the outputs wrote by stem alone (DQ01 L63, MS01 L54, S01 L37, KEY L122) resolve through the same table.

**How it was checked.**
- `python3 -B tools/leak_fingerprints.py scan` over the seven cleaned files, `tasks.js` and this record: 0 lines matched (64 before, on the outputs).
- A scratch n-gram check (not part of devos): the text normalised exactly as the guard does (`leak_words`, imported from `.claude/hooks/tool_allowlist.py`), every run of six words of these files looked up in every text file of the library at `941f027d`. Before cleaning it found 156 matching spans; after cleaning, no span of library wording and no shortened path or key remains; the remaining spans are the outside addresses of the table above. An exploratory pass at five words, on the originals and again on the cleaned files, found three runs taken from the very passage their output cites (research A F7 and F18, research C finding 9), all reworded; every other five-word run is an identifier, an outside address, or common English that occurs only in library files other than the passage cited, and was kept. A control file with a sentence copied from the library was flagged and a sentence of DevOS's own was not.
- Each cleaned file was compared word by word with its original (`git diff --no-index --word-diff`); every change is of a kind in the table.
