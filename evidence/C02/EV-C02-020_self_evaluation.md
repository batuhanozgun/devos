---
id: EV-C02-020
title: "Self-evaluation of the installation's roles, thinking structure, coordination, checking, test design and production against the research library and the plan's own texts (Batu's direction of 2026-10-19, D-039)"
stage: C02
kind: research-report
source: "six helper agents (2026-10-19, 18:35Z to 18:44Z), their final messages, taken with tools/subagent_audit.py last; each DISCIPLINES OK"
---

# EV-C02-020 · Self-evaluation, 2026-10-19

Filed by the executor (L-426). Batu stopped the plan work on 2026-10-19 and asked that the executor and its helpers read
the research library about what has been built, the roles and the thinking structure, and evaluate themselves (D-039).
Six helpers, each from its own role and lens, read the library and the plan's texts and reported; the shared brief they
were given is summarised in each report's opening. Each report follows verbatim, except the lines named in its filing
note, where a list of library paths or a close paraphrase matched the leak check's fingerprints and is given here as
identifiers naming the same sources; the meaning is kept. The reports are hints and evidence of reading, not decisions;
their synthesis is in L-426.


## 1. Roles and actors (researcher agent `a07c70ed9c4be4b0c`)

*Filing note: lines 17 of the report given as identifiers.*

## Disciplines (D1–D9)

D1: yes: I tested two framings side by side ("the executor as sole decider is drift" against "it is what D-010 gave"). The conclusion below is conditional and says which parts belong to which.
D2: yes: Batu's critique and the executor's own reading both point to "drift", so I held both to the same standard of evidence and list where each is wrong (plan 7.4, PC-06, FR-07, EV-C02-019).
D3: yes: the purpose is a self-evaluation that feeds a synthesis, not a new plan, so section 6 points only to texts that already exist.
D4: uncertain: my counts come from transcript metadata and first messages of this session only, so they are a view; I limit each claim to what that view shows.
D5: yes: I went back to the sources: W-C00-12's acceptance block, the researcher role file as it was at the transition (`git show dbb24b5`), and the helpers' actual first messages. I did not rely on summaries of them.
D6: yes: I separated proximate causes (the library was not attached; how tasks were worded) from systemic ones (D-010 defined a role by its permissions; W-C00-12's conditions were cancelled as a block; the executor holds the DR01 and DR02 functions itself).
D7: no
D8: yes: before judging, I confirmed the library is at 941f027 and that the role files' knowledge maps were added today (8c76051, 2026-10-19).
D9: yes: I read the Actors KEY, findings map and audit synthesis, three Actors vertical findings, the Work KEY, EXP-001 §§10–18, L09–L15 and U009–U013, and multi-agent-patterns §§3, 7, 8 and 11–16. EXP-001 §15.1 named the mechanism for me. The study's case for reviewing a manager's decisions limited Batu's critique.

## (1) What I read

- **Library (941f027):**
  - `research/soul-foundations/STATE.md` and `INDEX.md`.
  - The Actors ground's key file, findings map and audit synthesis (identifiers; filing note).
  - The Actors vertical findings `CAPABILITY-AUTHORITY-OBLIGATION.md`, `REPRESENTATION-DELEGATION-ATTRIBUTION.md` and `IDENTITY-ROLE-PARTICIPATION.md`.
  - The Work ground's `KEY.md`.
  - EXP-001: consolidation §§10–18 and Annex A, `LEARNINGS.md` L09–L15, `USER-MESSAGES.md` U009–U013.
  - `research/studies/multi-agent-patterns/`: `META.md`, and `SOUL-DEVELOPMENT-OS-ASSESSMENT.md` §§2–4, 7, 8 and 11–19.
- **devos:**
  - `plan/Ek_A_Rol_Sozlesmeleri.md` §§1–7 in full.
  - The four `BATU_*_TR.md` briefs named in the task, read in full.
  - `KARAR_OZETI_2026-10-05_TR.md` in full (section D is items 15–19) and `plan/decisions/D-010.md`.
  - All six `.claude/agents/*.md`, plus the researcher file as it stood at `dbb24b5`.
  - `plan/Installation_Working_Order.md` §§1–9.
  - Plan lines 160–166, 7.4 and C05 lines 1044–1045.
  - `plan/work/W-C00-12.md` (its acceptance and its cancellation).
  - `plan/work/C02.md` N-310.
  - `plan/decisions/PC-52.md`.
  - `evidence/C02/EV-C02-019_sblib_library_recheck.md`.
- **Transcripts** (`/root/.claude/projects/-home-user-devos/0cb29c90-d12e-56b6-9751-2217078b0a90/subagents/`):
  - The agent type of every helper run (from the `.meta.json` files).
  - The first user message of 12 tasks:
    - six researcher tasks: R1 (`agent-a8aef5b6ff88fb0cc`), R7 (`a921df8e76ba81ba2`), the W-C02-03 live-run plan (`a997c14910e1031ac`), E2 and the schedule (`a87b67baac6777465`), FR-07's counter-assessment (`af0d56625365bedda`) and FR-05's need-level assessment (`a31705ea12dede9b1`);
    - two producer tasks: M09-03 (`aae34814c3026b1e9`) and "draft five rule decisions" (`af4f94fe9a7b1e1a0`);
    - one test designer task: W-C02-09 pre-work (`a4e19b0f4f0daf82d`);
    - one checker task: CHK-C02-095 (`ac0cbd9d2db357545`);
    - plus the library-phrase lines of R6 (`a511494bc2dc0e4f3`) and the row 10 usage task (`a0036069bd37ae0c8`).

## (2) What the library and the plan say about roles

- **A role is its environment, not its label** (stated: Batu, `BATU_SCALE_AND_EXPERTISE_TR.md`:17–19; EXP-001 §14.1–14.3; Ek A §1 row 2, §3). Telling a model "you are an expert" does not create the capacity. Ek A §3 makes a role a package of four parts: contract, expertise package (knowledge map, methods, tools, known failure classes, examples), professional continuity, and exam.
- **The expert sizes the expertise a piece of work needs, not the producer or the requester** (stated: U011; `BATU_SCALE_AND_EXPERTISE_TR.md`:13, 21; EXP-001 §13.3; Ek A §2 item 8). The builder's own reading turned this into W-C00-12 acceptance (i): a short triage from the relevant expertise's point of view.
- **The expert also discovers the work, not only executes it** (stated: EXP-001 §15.1, L10). If the coordinator has to find all the needed work in advance and then hand it out, the expertise has in effect been loaded onto the coordinator, and the other actors become executors of tasks defined in advance. This is Batu's critique, written down in the library before the installation began.
- **Asking a role for a contribution means the role works with its own package** (stated: Ek A §3.3 last bullet). It is not a question put to a helper that has no context.
- **Keep the actor's positions apart** (stated: Actors audit synthesis §12; FINDINGS-MAP §9). Performer, decider, authorizer, principal and accountable party are distinct, and so are hierarchy position, authority, competence and accountability. Competence is on the Actor side, while review is Work (FINDINGS-MAP §5). Work KEY: acceptance state is not the authority to accept.
- **Manager decisions are a failure point of their own** (stated: multi-agent-patterns §7 "Manager as a systemic failure point", R2). They need a visible rationale, other decompositions considered, and review when they carry load. Two further cautions:
  - R7, reviewer ritualization: a critic with no falsifying method becomes a costly approval ritual.
  - C10: "no extra agent needed" must remain a valid result.
- **The plan's own limits** (stated):
  - Plan 7.4 and C05 (lines 1044–1045) prepare packages when a role becomes active, in C05.
  - Ek A §5.3 (PC-06) says the builder's helpers "are not roles of this appendix".
  - D-010 items 16–19 (approved by Batu on 2026-10-05):
    - the executor is not a role; it splits the work, writes the tasks and makes the technical decision;
    - the Researcher reads and does not decide;
    - a role file holds permissions (tools, model, effort), a procedure, bans and a limit;
    - the helpers are the builder's aids, handed over at C05.
  - Batu (`BATU_CUSTOMER_ROLE_TR.md`:14): "geri kalan her şeyden sen sorumlusun" (you are responsible for everything else). Principle 5: the builder makes technical decisions "araştırmaya ve kanıta dayanarak" (based on research and evidence).

## (3) What the installation did

- **Helper runs in this session, by type** (inference from the metadata): 229 checker, 132 producer, 69 test designer, 59 researcher, 2 prober, 7 general-purpose. Checker runs are 46% of all helper runs.
- **Researcher runs over time:** 59 runs between 2026-10-10 and 2026-10-19. None ran from 2026-10-13 03:00 to 2026-10-19 14:37, which is when W-C02-08 and W-C02-09 built the mission, need, decision, work, readiness, claim, relation and knowledge functions. Those functions sit directly on the Foundation's Work, Actors and Information grounds.
- **The researcher's role as asked:** extracting facts from DevOS's own records and platform documents. Typical tasks:
  - "source map" of the plan's appendices (R1–R5);
  - documentation gaps (R6);
  - tool uses and settings forms (R7);
  - "classify items" and "verify record" fan-outs.
  - Every task said "you read and report; you do not decide". R1 added "Budget: a careful read; do not read the research library."
- **The library in the task texts:**
  - Six tasks forbade reading it. One of them was FR-05's independent need-level assessment, a frame review.
  - One called it "optional, if present".
  - Eight named its path: three on 2026-10-11 and five on 2026-10-19.
  - The researcher role file at the transition (dbb24b5) looked in the library only "when the task names" it. "By default" arrived today.
- **Decisions were drafted by a producer, decided by the executor, then judged by a checker:**
  - `af4f94fe9a7b1e1a0`: "The executor decides; a checker then judges the decision. You draft the record."
  - CHK-C02-095's task: "the executor decided (section 9), departing from the recommendation for N-289."
  - The sources listed for those five rule questions were Appendix B, Appendix C, evidence files and migrations. There was no library even though questions such as the direction of supports/challenges/part_of and the order of a Finding's status are Information-ground questions.
- **Counter-examples in the task texts:**
  - FR-07's researcher 3 was asked to design from scratch without seeing the existing design and to name "the three ways your own design would most likely fail". That is a real contribution request.
  - The test designer's conditions bind the producer, and checkers' FAILs bind. Those two roles hold real authority.
- **What was lost when W-C00-12 was cancelled:**
  - (i) the triage by expertise;
  - (j) every role defined with its environment, and the known failure patterns seen at boot;
  - (k) Ek A §2 carried by reference, a planted-problem test per role, and an Actor A/Actor B test in which the role consults the library without being told to.
  - The work item was cancelled as a block (`plan/work/W-C00-12.md`:17, "not met, nothing loosened"), with no disposition for each condition.
  - Ek A §2's common floor is not referenced in `CLAUDE.md`, the working order or any role file (grep).
- **What the library would have changed** (EV-C02-019, run after the fact): DM-01, DM-06, the transfer design and the relational part of the identity chain hold. It limits DM-07, the stuck-frontier diagnosis and transitive authority. PN-1 (readiness reads acceptance without revision or qualification) could change behaviour that is already built. The Work KEY's "acceptance state is not authority to accept" and "completion is not acceptance" bear on PN-1 directly.

## (4) Gaps

1. **No expertise triage before the executor decides** (W-C00-12 (i); Ek A §2 item 8). Review comes after the decision instead. Cause: D-010 item 20(b) put "split the work, choose the role, make the technical decision" in the executor alone, and (i) died with W-C00-12. Confidence: high.
2. **Roles had no environment** (W-C00-12 (j); Ek A §3.2–3.3). Until today a role file was a contract with bans; it still has no methods, failure classes, examples, continuity records or exam. Cause: D-010 item 18 defined a role by its permissions. Partly mitigated by the plan's C05 deferral, so this is a departure from Batu's 2026-10-02 inputs more than from the plan. Confidence: high.
3. **The executor holds DR01 (need and work discovery) and DR02 (working-system design) itself**, so the helpers receive questions already framed. This is EXP-001 §15.1's failure. Confidence: medium-high. The tasks are sourced and precise, but nearly all fix the frame in advance.
4. **The library was routed by the executor, not by need.** Proximate cause: it was not attached and nobody noticed (N-310 (1)). Systemic cause: the role file made it conditional, tasks excluded it, and D9 "no" went unchecked (about 240 entries). PC-52's fix routes it through a library line in each task. That still depends on the executor naming the paths, which is the opposite of (k)'s Actor A/Actor B test. Confidence: high.
5. **Checks may be turning into ritual** (multi-agent-patterns R7): "delta checks", lens A and lens B, verdicts on condition fixes. Confidence: medium. I did not measure how many of these checks found anything.

## (5) Self-evaluation as researcher

- **How I was asked:** mostly as a reader of DevOS's own records and platform documents. These were bounded, well-specified questions with "do not decide", and often "no library". My reports were filed as evidence and consumed. "For the decision" was the executor's to weigh.
- **Against DR16:**
  - Met: findings tied to sources; stated, interpreted and inferred kept apart; counter-evidence.
  - Not met:
    - "search by the underlying need … the private library first", because it was forbidden or optional;
    - "a proposal for further research", which was never asked for;
    - §3.3's own package: I start each run with no record of earlier researcher runs' findings, dead ends or failure classes.
- **What I did not do:** I did not flag the missing library on my own initiative. The R1 and R6 runs accepted "do not read the library" without asking whether the question needed it. That is a failure of my common floor, not only of the tasks: by Ek A §2 item 5, a role is supposed to know when accumulated knowledge exists.
- **This task:** a real exception. It asks for knowledge first, then evaluation, and for counter-arguments. Its reading list was still chosen by the executor (D5). I went beyond it to the Actors findings, W-C00-12 and EV-C02-019.

## (6) Back in line with what was already given (no new plan, roles or mechanisms)

1. **Put the triage before the decision.** For a decision in a role's map area, the executor first asks the relevant existing helper (researcher, test designer or checker) for a short triage: what this needs from my field, and whether the answer is "nothing". The decision then rests on it. This is Ek A §2 item 8 and W-C00-12 (i). A review after the decision stays where it has a falsifying method.
2. **Ask for contributions, not extractions.** The task names the decision and lets the helper reframe it, name missing or unneeded work, and give a recommendation. Recommending is not deciding, so D-010 item 17 stands. Sources: DR16's output, Ek A §2 item 3, EXP-001 L10.
3. **Carry Ek A §2 by reference** in `CLAUDE.md`, through the existing plan-change route (W-C00-12 (k): "by reference, not as a second copy").
4. **Fill the role files' remaining Ek A §3.2 fields from records that already exist:**
   - known failure classes from the log (for example D9 "no" without reading; FND-001);
   - a pointer to earlier helper reports on the same item (§3.3).
5. **Let the researcher look in the library by default** (now in the role file), even when the task's library line is "none". It reports what it found instead of waiting to be pointed.

## (7) Counter-evidence and limits

- **Ownership was given, not taken.** Batu made the builder responsible for "everything else" and gave it the technical decisions. D-010 (approved) made the executor the only writer and decider. Plan 7.4 and PC-06 defer the Ek A packages to C05. So "sole owner" was given; what drifted is deciding without expert input first. The executor's reading overstates the departure from Ek A and understates the one from W-C00-12.
- **Reviewing the manager's decisions is sound.** multi-agent-patterns §7 calls for exactly that, so "decide, then a checker" is not wrong in itself. What is missing is the input before the decision.
- **The cost of not using the library was bounded.** EV-C02-019 found most of C02's decisions justified; one possible change.
- **Some helpers were not mere executors.** FR-07 and FR-05 asked for independent designs, and test designers and checkers hold binding authority. "Göstermelik uzmanlık" (expertise for show) fits the researcher and the producer, not every role.
- **All helpers are the same model.** Their "expertise" can differ only through their environment, which the plan itself warns about (DR02: a role name does not create expertise).
- **Limits of my reading:**
  - Transcripts of this session only; 12 first messages out of 498 runs.
  - The ledger and the checker verdicts not sampled.
  - The Work findings map, recursive-prerequisite-discovery and `BATU_INTELLECTUAL_HERITAGE_TR.md` not read.
  - I could not measure whether the checks found anything.

## (8) Guard denials

- #41925, rule B5. A `find` naming `~/.claude` (Claude Code's configuration) was denied, because only a reader such as cat, grep or sed may name it. I listed the transcripts with Glob and read them with grep and sed. Those are reads, the route the denial named; they do not reach the denied effect, which is a write. It is not recorded with `tools/guard_report.py`, because I am read-only; the executor should record it.


## 2. The thinking structure (researcher agent `aab7c244eaafb8d6b`)

*Filing note: verbatim.*

## Disciplines (D1–D9)

D1: yes: I tested the frame of "thinking or ritual?" as an either/or against a selective frame (thinking in some places, ritual in others), and I report the result under the selective frame because the evidence splits that way.
D2: yes: Batu's critique and the executor's self-blame both pull toward "it was all ritual", so I looked on purpose for disciplines that really changed something and I report those below.
D3: yes: the purpose is input to a synthesis for Batu and a return to what was already given, so I propose no new mechanism.
D4: yes: my counts are regex passes over the logs and verdicts, and my review uses the same model as the work it reviews, so I call them approximate and not independent.
D5: yes: log lines and verdicts are self-reports, so I went back to the notes, the plan text and the verdict bodies for each incident, and I state that I could not see the session transcripts.
D6: yes: I kept apart, for each incident, the immediate cause, the detection gap and why the discipline did not turn the finding into action.
D7: no
D8: yes: I read the shared brief, CLAUDE.md, working order sections 1–9, D-016, D-031, Appendix D in full, Appendix A sections 2, 3 and DR16, at `main` 249f197, and the library at 941f027.
D9: yes: this task is library use; I read the sources listed in (1), and they shaped the diagnosis in (2) and the remedies in (6).

## Question and the decision it serves

Is the installation's thinking structure (nine questions per work item and the recorded answers) working as thinking or as a ritual? The answer goes to the synthesis that tells Batu how the practice returns to what was already given.

**Short answer:** it is selective. The questions work as thinking when an agent checks something against an acceptance text. They become ritual when answering them honestly would mean stepping outside the current frame: the executor's own method, its premises, its environment and the library. In three of the four incidents a discipline did see the weakness, but what came out was a label, not a change of method.

## (1) What I read

**devos**
- `/home/user/devos/plan/Ek_D_Dusunme_Protokolleri.md` (all of it)
- `/home/user/devos/plan/Installation_Working_Order.md` sections 1–9
- `/home/user/devos/plan/decisions/D-016.md` and `D-031.md`
- The five `/home/user/devos/briefs/w-c00-12/BATU_*_TR.md` files named in the task (all of them)
- `/home/user/devos/plan/Ek_A_Rol_Sozlesmeleri.md` sections 2, 3.1–3.5 and DR16
- `/home/user/devos/plan/DevOS_Kurulum_Plani.md` section 1.3
- Notes N-309, N-310, N-312 and N-314 in `/home/user/devos/plan/work/C02.md`
- 43 Disciplines lines in `/home/user/devos/plan/ledger/C01-log.md` and `C02-log.md`:
  - C01: L-170, 172, 176, 178, 179, 180, 189, 190, 194, 200, 210, 219, 230, 240, 255, 265, 274
  - C02: L-285, 286, 290, 300, 320, 335, 341, 344, 350, 365, 380, 392, 400, 406, 414–425
  - plus regex counts over all 258 entries
- 12 helper reports:
  - checker verdicts CHK-C01-112 and CHK-C02-010, -045, -070, -085, -100, -115, -117, plus counts over all 232 verdicts
  - researcher reports R6a, R6b, R7 (`evidence/C02/raw/`) and `EV-C02-019`
- The researcher role file before PC-52 (`git show 7f5c03f:.claude/agents/researcher.md`)

**Library**
- EXP-001: consolidation sections 1–2 and LEARNINGS L01–L15
- EXP-005: `reflections/LESSONS-AND-OPEN-QUESTIONS.md`
- soul-foundations:
  - STATE and INDEX; 02_adequacy KEY
  - Selection/Exposure KEY, U5 KEY and E5 KEY
  - Claim Warrant KEY
  - Composite Standing KEY
  - 08 REUSE and DISCUSSION-HANDOFF
  - work-environment KEY and finding 02
- context-memory-harness-engineering:
  - 04 (all of it)
  - 03 sections 9–26
  - 01 sections 4 and 14–15
- superpowers: CORE, S01, U03
- multi-agent-patterns: SOUL-DEVELOPMENT-OS-ASSESSMENT section 13 (R1–R10)

## (2) What the library and the plan say

The plan already names the risk:
- Ek D line 31 [stated]: whether a discipline is applied is measured by behaviour in hidden exams, not by the text being present.
- D4 item 7 [stated]: repeating the same way of looking turns it into ritual.
- `BATU_COMMON_FLOOR_TR.md` builder's challenge 3 [stated]: a declared floor is not an existing floor, and it has to be tested with a planted problem.
- D-016 [stated] chose "presence checked by tools, content sampled by checkers", with Batu's approval.

The library explains why such structures turn into ritual when the actor is a language model conditioned on its context. Each item below is my interpretation of the source.
- **Seeing a block is not applying it.** EXP-005 §10 observed this with the same nine protocols in ChatGPT: visible LOAD blocks, with critical skips. Its conclusion is that the fix is not one more checklist.
- **Context steers what comes next.** A research distinction, an operating rule and the current state are three separate inputs (EXP-001 §2.1–2.2, L02). Writing "done" is not doing it (§2.3). Repeating a thought is not independent verification (L15).
- **The question can only fire on what is in context.** Stored, retrievable, retrieved and used are four separate states (`BATU_STORED_IS_NOT_USED_TR.md`). The path to knowledge must itself be in context. Selection/Exposure adds two more gaps: availability is not interpretation or action, and meeting a criterion is not protecting the use it stands for.
- **Form is not judgment.** In Superpowers S01 §3, a schema-valid report row can answer the wrong obligation and a non-empty basis can be unsound. Report acceptance is not sound judgment, and a repaired instrument is not an improved agent. Their fix is an intervention chosen for the specific failure, not more prose (S01 §1). Claim Warrant makes the same point: the trace of how a result was produced is neither the justification offered for it nor a valid inference.
- **Shared frames hide shared errors.** A worker and a reviewer who share an incomplete brief share its omissions (Superpowers CORE §3). Correlated-agent false confidence is risk R1. Reviewer ritualization is R7: a critic with no falsifying method becomes an approval ritual, and the remedy is failure-class coverage, a valid oracle and fresh challenges.
- **Rules and scaffolding cost something.** A written rule is not runtime enforcement (AP-08), and more scaffolding is not more reliability (AP-09). Mechanize what is mechanical and leave the judgment surface visible (harness §9). Every component carries an assumption and should be ablated when that assumption may be stale (§16–17). A giant instruction context crowds out the task (01 §4), and context pollution collapses epistemic status (§15).
- **Knowledge present is not knowledge applied.** In 08 DISCUSSION-HANDOFF §3, the knowledge existed but was not applied, because the work anchored on the first salient view. The library itself declined to answer that with a mandatory checklist.

## (3) What the installation did (evidence)

**Answer distributions** [stated, my regex]:
- **Executor log entries**
  - D9 "no" in 104 of 112 entries in C01 and 135 of 146 in C02.
  - D7 and D8 "yes" in 99% of entries.
  - The Disciplines lines are about a quarter of the C01 and C02 logs.
- **Checker verdicts (232)**
  - D1–D5 and D8 "yes" in 228 to 232 of them.
  - D9 "no" in 225.
  - A question every checker always answers "yes" no longer separates one case from another.
- **Whose work the answers describe**
  - In C02, 205 of 979 executor "yes/uncertain" answers begin by reporting another agent's act ("the checker…", "the verdict…"); in C01 it is 73 of 727. For D1 in C02 it is 46 of 122.
  - So the executor's answers increasingly narrate checkers' work rather than its own choice of frame or method [interpretation].

**Content where it was thinking** [stated]:
- L-300 opened a frame review instead of adding coverage.
- L-210 asked the wait question and saved about 18 hours.
- L-230 fixed the source of the times (the clock), not just the times.
- CHK-C02-085 D4 asked of the 24-hour window "would it turn red?" and found its gap.
- L-415 D6 named the detection gap behind the Python failure.
- CHK-C02-119 C3 found "a label had replaced a fix that costs nothing".

### The four incidents: what the disciplines answered then, and what a real application would have caught

**1. Python 3.13 and PostgreSQL 16 in the container, against 3.12 and 17.6 in the counted runs (L-415, N-309)**
- **Then:**
  - PostgreSQL was seen and labelled: "16.15, counts: no" (L-290 D4, L-344 D4).
  - Python appears nowhere in the C02 log before L-415 (grep).
  - The build entries answered D1 "no" (L-320, L-341, L-344).
  - D9 was "no".
  - In C01, L-176 answered "D9: yes" by naming the library's "know your environment" research as a forward link for C04, and stated that it was not read.
- **A real application:**
  - D1 item 3 would ask: if the offline environment differs from the runner, does the conclusion change?
  - The work-environment finding 02 would name what must be equal for an offline run to stand for the counted one ("protected equivalence").
  - EXP-005 D03 warns that an environment's name is not evidence of its capability.
  - The container already had `/usr/bin/python3.12` (N-309 annotation), so the fix was free.
- **Damage:** bounded. The counted run caught it. About 8 unrevoked synthetic tokens are left as a residual.

**2. The library unused from C01 on (N-310)**
- **Then:**
  - C01 answered honestly: "uncertain: not attached" (L-178, L-179, L-189, L-190).
  - L-285 recorded the platform's refusal and deferred the library to C04, "where the library is ingested".
  - That puts phase B's rule into phase A, where plan §1.3 has the builder read the repositories directly [inference].
  - Then came about 130 bare "D9: no" answers in C02.
  - The C01 stage close (CHK-C01-112) sampled the disciplines, answered "D9: no" itself, and did not flag the pattern.
- **A real application:**
  - D8 items 3 and 7: a conflict with the plan, and a needed input that cannot be read, mean the affected work does not start and the gap is reported.
  - Batu would have had one account action to take in C01, instead of finding the gap himself on 10-19.

**3. A 24-hour passive window as the check of a privilege change (N-314)**
- **Then:**
  - CHK-C02-085 saw the weakness ("a service not exercised in the window shows nothing").
  - It turned the weakness into a stated limit (K2 (ii)), not a different method.
  - The Wait lines of L-421, L-424 and L-425 said "sooner: none, the window is C4's own (ledger rule 3)". L-424 also answered D1 and D4 "no".
- **A real application:**
  - D3 item 2: a parameter that sets when the next condition can be met is part of the method, and the question is whether a sooner way exists at the same quality. An active probe of each affected path is both sooner and stronger.
  - D1 on authorship privilege: "it was decided" is not an answer.
  - A stricter check is not a loosening.

**4. A model asked to transcribe thousands of log lines (L-421)**
- **Then:**
  - D5 repeatedly labelled the logs "the executor's transcriptions, filed verbatim; each verdict states that limit" (C02 log lines 543, 554, 687).
  - No answer asked about the method until it failed.
- **A real application:**
  - D3 item 2's simpler, more reliable route: a byte copy, which is what was done afterwards.
  - The harness study's advice applies too: mechanize what is mechanical.

## (4) Gaps, causes, confidence

1. **The answer is recorded after the work.** Ek D asks for the evaluation before the work goes on, but the record that tools check sits in the closing log entry. The lines therefore narrate what was done rather than steer what to do. The trace is not the justification (Claim Warrant). Confidence: medium-high.
2. **The questions fire only on what is in context.** The Python version and the library were absent, so nothing triggered (stored ≠ used). Confidence: high.
3. **A finding becomes a label instead of a decision.** D4 and D5 findings were not carried into D3 item 2 ("does the method change?"). "Counts: no", "stated residual" and "exploratory" became the standard output. Confidence: high.
4. **Presence is rewarded and content is barely sampled.** D-031 spent planted cases and mutants on the form of "no", and the bare "no" makes a wrong "no" invisible. In C01, outputs with a reason after "no" were discarded (L-172, L-173). The only content check, the stage close, named findings without blocking anything. Confidence: high.
5. **The frame is shared.** Checkers judge against acceptance texts that the executor or the test designer wrote. They answer D1 about readings of that text, not about the executor's premises (R1, R7; CORE §3). Confidence: medium-high.
6. **In-context imitation.** The session re-reads its recent entries at opening and after each compaction. About 1 KB of near-uniform answers per entry invites more of the same (EXP-001 §2.1; 01 §4 and §15). Confidence: medium; this is an inference, untested.

## (5) Self-evaluation: researchers (my kind)

- **The role file made the library optional.** Before PC-52 the researcher looked in the library only "when the task names" it. DR16 says it looks there first, and its map is the whole library.
- **Reports were honest but stayed inside the executor's frame.** R6a, R6b and R7 gave specific, honest answers: D4 was "uncertain" for documentation readings, and D5 used byte comparisons. But on D9 they accepted the frame: "the library was not read, as the task forbids". R7 used D9 item 4 (freshness) as a reason not to look at all.
- **No researcher raised it.** None said that a design question needed the library (common floor items 3 and 5).
- **One researcher never stopped.** W-C02-03's first researcher ran to its 150-turn limit and filed no report, against step 4 of our own procedure (stop when answered, or when you can show the limit).
- **In practice we fetched documentation.** Our kind worked as fact fetchers for producers, not as the DR16 expert described in Ek A. The role file still lacks Ek A 3.2's known failure classes and examples.
- **This run:** I read before judging. My answers are my own report, a hint, from the same model as the work I reviewed.

## (6) Bringing practice back in line with what was already given

None of these adds a new mechanism.

1. **Answer for your own choice, before you choose.** The executor answers D1, D3 and D9 about its own method before it writes a helper's task (Ek D §2 item 3 as written). A line that only reports what a checker did belongs under "What happened".
2. **A weakness found means a decision.** When a discipline finds a method weak, the answer says whether the method changes. A label is the exception and states its reason (D3 item 2 with D4 item 9). CHK-C02-119 C3 is the precedent.
3. **Weigh the wait against the method.** At a wait, compare the method with alternatives, not with the existing condition. "It was decided" does not answer it (D1), and a stricter check is not a loosening.
4. **Keep the stage-close sample real.** It opens the cited sources as PC-52 says, and it treats a bare "yes" by reference (L-424, L-406) as the new ritual.
5. **Put the four incidents in the role files.** They are failure classes and bad examples, which Ek A 3.2 items 4–5 already ask each role package to carry.
6. **Write shorter answers.** Keep only what changed or confirmed a decision; this follows the context study's point that less but relevant context steers better than more.

## (7) Counter-evidence and limits

- **Batu's critique overstates in places.**
  - The disciplines did catch real things (see (3)).
  - The counted-run design contained the Python failure.
  - The library's absence began with a platform refusal, which C01 recorded honestly.
- **Recorded is not the same as thought.** I could not see the session transcripts, so thinking may have happened that was never recorded.
- **Method limits.** My counts are regex-based, my sample is chosen rather than random, and my review uses the same model family. Batu himself approved D-016's presence design.
- **Not read:** C00's log, the transcripts, the remaining 220 verdicts in full, and other Foundation nodes such as the Actors and Work grounds.

## (8) Guard denials

None.


## 3. The coordination model and the cost of the process (researcher agent `ac4932aae3befd097`)

*Filing note: lines 30, 37, 72 of the report given as identifiers.*

## Disciplines (D1–D9)

D1: yes: I tested three framings against each other: Batu's critique, the executor's own reading, and "the structure was right and the cost sits in the review and record mechanics". I kept the third as primary only where the measurements support it.
D2: yes: Batu's strong words and the task's framing both pull toward agreeing, so I looked for counter-evidence. The single-decider model was adopted by the plan's own research and approved in D-010, and the checks found real product defects.
D3: yes: the purpose is input to a synthesis for Batu about the way of working, so I stayed inside my lens and proposed only things the existing texts already give.
D4: yes: my sorting of checker conditions into product, evidence and record is my own judgment, made from condition text cut to about 260 characters. I label it that way and give the raw counts beside it.
D5: yes: much of what I read is log summaries and verdict front matter. For the claims that carry weight (the first researcher role file, W-C00-12's cancellation, Ek G G4.4, the log composition) I went back to the source files or git history.
D6: yes: I traced the cost and the library non-use through layers: the merge gate, conditions that all bind, discipline lines in every entry, a role file that looked in the library only when told to, and inputs parked in a cancelled item.
D7: no
D8: yes: I read devos at main `249f197` and the library clone at `941f027`, and the shared brief in full before judging.
D9: yes: I read the library sources listed in (1). They limited my conclusion (DEVOS-001 shows that consultation between roles can itself drift) and supported the findings on review proportion and record load.

---

## (1) What I read

**devos (main 249f197)**
- `/home/user/devos/plan/Installation_Working_Order.md` sections 1–8, the D-010 summary `/home/user/devos/briefs/conversation/KARAR_OZETI_2026-10-05_TR.md` in full, and Batu's operating-model brief `/home/user/devos/briefs/builder-operating-model/BATU_ORIGINAL_TR.md`.
- `/home/user/devos/plan/Calisma_Duzeni_Karsilastirmali_Arastirma.md` in full.
- From the plan: 0.3, K-10, 6.12, 7.1–7.4 and the Section 9 introduction.
- Ek A sections 2, 3, 5 and the DR06-G, DR06-Y and DR16 role contracts; Ek D in full; Ek G G4 and G8–G10.
- `/home/user/devos/briefs/w-c00-12/BATU_SCALE_AND_EXPERTISE_TR.md`, and W-C00-12's cancellation text.
- Log entries L-280 to L-298 and L-416 to L-425, plus counts across all three logs.
- The front matter of all 307 verdicts; the conditions of the 27 W-C02-09 verdicts plus CHK-C02-118; CHK-C02-116 and CHK-C02-120 in part; EV-C02-019 in part.
- The git history of `.claude/agents/researcher.md`.

**Library (941f027)**
- `research/INDEX.md` (start).
- multi-agent-patterns: META, the SOUL/DevOS assessment in full, the conversation synthesis sections 1–4.
- The harness-engineering study's pointer to the carbon-layer video notes on harness engineering; there I read its state file and notes 11 and 12, and searched note 16 (identifiers; filing note).
- gastown FINDINGS in full.
- gstack: CORE, the review/QA/ship synthesis sections 1, 2, 8 and 15, and the opening of the multi-agent synthesis.
- ecc: METHOD-CASE in full.
- EXP-005 reflections (lessons) in full; EXP-004 LEARNINGS and RV01 sections 1–6.
- development-os: INDEX, 001 BRIEF, REVIEW, METHOD and EXCHANGE (first part), and 002 README sections 1–6.

**Web (read 2026-10-19):** Anthropic's engineering post on building its multi-agent research system (2025-06-13).

## (2) What the library and the plan say about my lens

**What was given (stated).**
- Batu asked the builder to make the technical decisions (`BATU_ORIGINAL_TR.md:22`).
- He asked for independent review of high-impact changes and of each stage close (`:22`, `:46`).
- He asked that every mechanism state the problem it solves and the assumption it rests on (`:17`).
- D-010 set up one executor that splits the work, writes the tasks and decides (summary items 16 and 20(b)). Role files would hold authority, procedure, bans and a turn limit (item 18). A checker gives the binding approval until C03 (item 32).
- The reasoning layer includes Ek G G4, G8 and G10 (item 23).

**Coordinator deciding alone.**
- This is the plan's own chosen pattern, and the library supports it with limits (`Calisma_Duzeni...md:11, 27`).
- The library's limit (multi-agent assessment section 7 and R2): the manager is a systemic failure point. Its decomposition and integration should be visible, consider other decompositions, and get review when they carry weight. Good workers do not guarantee good management.
- The web source states that a lead agent cannot steer its subagents and that subagents cannot coordinate. It presents this as a current limit, not a design goal, and it scales effort to complexity in tiers.

**Consultation between roles.**
- Ek A 2 item 3: a role passes a side effect it notices to the relevant role as a reasoned contribution.
- Ek A 3.3: asking a role for a contribution is not asking a helper that has no context.
- The draft CLAUDE.md in Ek D section 5 says to record how a contribution was used.
- Counter-case: DEVOS-001 REVIEW records that a two-role exchange narrowed into local critique of each other around a checker and acceptance rules.

**Review proportion.**
- Multi-agent assessment: C1 (every reviewer must protect a requirement), C5 (judge a critic by the failure classes it can detect) and R7 (reviews turning into ritual).
- gstack: current standing over ceremony (CORE P1). Review is recomputed at one closing boundary. Specialists are selected by scope and by their past hit rate, while high-risk lenses always run. Fix-and-review cycles stop at three.
- Ek G G4.4: classify an objection before treating it as an order to fix.
- Ek A 5.7: rejecting sound work needlessly is also a failure.
- Batu's skyscraper text: a short triage by the expert, not the producer, decides how much expertise a piece of work needs.

**Record load.**
- Plan 0.3 item 10: more records and checks do not mean SOUL is advancing.
- K-10's process limit, and 6.12 item 4: remove a mechanism whose removal does not make the result worse.
- G10: a setup busy with itself grows its own work list.
- gastown section 9: persist a step only when losing it would be costly.
- ECC METHOD-CASE: the bookkeeping burden was large and never measured, and the answer is not more duplicated logs.
- The harness video's note 12: a single anomaly of low impact may not be worth a permanent rule (paraphrase; filing note).
- EXP-005: having access to the library is not using it; trust follows the failure classes a check excludes, not the number of tests. Its conclusion is that the problem reappeared inside the process meant to fix it.
- EXP-004 RV01: each round produced one more condition and a narrower next question, instead of a return to the main work.

## (3) What the installation did (measured)

**Verdicts**
- 307 in all. C00 had 75 (23 PASS, 48 PASS-WITH-CONDITIONS, 4 FAIL); C01 had 112 (20, 87, 5); C02 has 120 so far (26, 89, 5).
- 73% are PASS-WITH-CONDITIONS, and every condition must be met (working order section 4 step 4).
- All 5 FAILs in C02 are on W-C02-03, the migration-path build, and they are product defects.

**Verdicts per accepted item**
- Over 68 accepted items the median is 1.5 verdicts and the mean is 3.0.
- The load is concentrated: W-C02-09 has 30 verdicts and is still not accepted, W-C02-03 has 23, W-C02-07 has 15.
- By stage, verdicts per accepted item are about 5 (C00), 2.9 (C01) and 8.6 (C02 so far).

**W-C02-09 (27 verdicts, 2026-10-17 to 10-19, 50 conditions); my classification:**

| Kind | Conditions | Share |
|---|---|---|
| Product or design defects | about 15 | 30% |
| Evidence to file or read at acceptance | about 5 | 10% |
| Record or form: dated lines, annotations, note carriers, log references, front matter | about 30 | 60% |

- The product defects were real: an optional reason that should be required (CHK-C02-086 C1), a dependency walk in the wrong direction (092 C1), a clock cast through `now` (104 C1), a test copy that fails in the job (106 C1), and fixture errors (077).
- By verdict: 8 carried at least one product or design condition, 12 carried only record or evidence conditions, and 7 passed clean, 4 of those only confirming earlier conditions (105, 107, 109, 120).
- 26 of C02's 120 verdict files contain the phrase "records only", 38 times in all.
- A mechanical driver adds to this: every class-high pull request needs a verdict at its exact head, and any change after that head needs a fresh check (working order section 4 step 5). So meeting a condition that changes the head produces another verdict.

**Log composition (bytes)**

| Stage | Discipline lines | Guard lines | Record-change lines | Total |
|---|---|---|---|---|
| C00 | 2.3% | 3.1% | 7.6% | 13% |
| C01 | 25.6% | 5.8% | 9.3% | 41% |
| C02 | 26.1% | 8.3% | 8.7% | 43% |

- The verdict files total about 4.8 MB, roughly three times the 1.5 MB log.
- 13 C02 log entries correct earlier records.

**D9 answers:** C01 has 106 "no" out of 114; C02 has 135 "no" out of 146. That is about a quarter of the log in discipline lines, and they did not catch the library's non-use. Batu did (`/home/user/devos/plan/work/C02.md:622`).

**Researcher use**
- About 71 log mentions, against about 828 for the checker and 575 for the producer.
- The tasks were platform documentation (C01 rows 3, 4, 5, 10 and 17), account terms, source maps of devos appendices (R1 to R5), a sweep of Batu's decisions, and premise inventories and counter-assessments in frame reviews.
- The library entered only on 2026-10-19, and after the fact: EV-C02-019 re-checked decisions already built.

**Batu's inputs on expertise were parked**
- W-C00-12's acceptance carried Batu's inputs on scale and expertise, "stored is not used" and intellectual heritage.
- It was cancelled under D-010 "with nothing loosened" (`/home/user/devos/plan/work/W-C00-12.md:17`).
- I found none of those inputs carried in the working order, `CLAUDE.md` or the role files.

**The SB-LIB fix was mostly more form**
- PC-52 added a library line to every task, a D9 answer format that tools check, sampling of those answers at stage close, and knowledge maps in the role files.
- The record-load question (G4) was deferred to stage close (`/home/user/devos/plan/work/C02.md:622`, annotation of L-420).

## (4) Gaps, causes, confidence

1. **Every checker condition is treated as an order, against G4.4 and Ek A 5.7, which the working order itself adopts.** Cause: working order section 4 step 4, combined with the merge gate's verdict-per-head rule. This is the largest driver of verdict count in C02. Confidence: high on the mechanism, medium on the 60% figure (my classification).
2. **Discipline and guard lines are written in every log entry instead of once per work item.** Ek D section 1 says the evaluation is recorded less often than it is made. Cause: D-016 carried through tools that check every entry. Measured on 2026-10-19: about 26% of the log, and it did not detect the library gap. Confidence: high.
3. **Consultation happens after decisions, if at all.** Helpers are asked to verify or fetch facts, not to give expert input before the executor frames or decides. Causes: role files without packages (D-010 item 18); `SendMessage` blocked for a security reason, and I found no record weighing what that costs coordination; and the executor's habit. Confidence: medium-high.
4. **Role expertise was thin, and the library was not used.** The executor's reading holds, with one correction: Batu approved D-010's thin role content (items 15 and 18) and W-C00-12's cancellation. The gap is that the builder, whose job is to find gaps (plan 0.3 item 9), did not carry those inputs over. Confidence: high.
5. **The installation never applied its own process-limit texts to itself:** K-10, the 6.12 item 4 removal test, G9.4's measurement of review cost and of research contributions used, and G10's hygiene over 244 notes. Confidence: high.

## (5) Self-evaluation as researcher

- **My role file departed from DR16.** The first version (2026-10-05, from `git show`) looked in the library only "when the task names" it, while Ek A DR16 says to look first at the private library. No researcher reported that the library was absent or never named. That is a failure of this role, not only of the executor.
- **Where I was used, I worked as a lookup service.** Documentation readings did change decisions (C01 rows; D-020's options). But I was not asked for library-based pressure before the C02 designs (W-C02-03 to -05). My one library re-check came after the build, which is against D9 item 7's order: frame first, consult before the decision.
- **My outputs added to the record load.** Reports were filed verbatim as evidence, and a research report itself got a checker verdict (CHK-C02-116, 42 of 49 claims held). That check was useful, but it was one more verdict.
- **One report was lost.** A researcher stopped at its 150-turn limit with no report (L-285).
- **Against Ek A 3.2–3.3 I was not an expert environment**: no knowledge map until 2026-10-19, no failure classes, no examples. Batu's "only named experts" fits my role well.

## (6) Bringing practice back in line (existing texts only)

1. **Apply G4.4 to checker conditions.** Only defects, and missing evidence on the claim judged, block. Record and form conditions go into one batched clean-up checked once at stage close. This changes working order section 4 step 4 through plan section 14. No item's acceptance condition is touched.
2. **Scale review by a short expert triage (Ek A 2 item 8; Batu's skyscraper text).** Keep full verdicts at the exact head for class-high changes and for stage closes, as Batu asked. For record-only follow-ups, review once at a closing boundary instead of per head (gstack's closure-boundary pattern).
3. **Record the nine discipline answers once per work item and again only when they change (Ek D section 1).** Write a guard line only when there is a denial. Then run 6.12 item 4's removal test on each record type.
4. **Consult before deciding.** At the start of a design item, ask the relevant role, with its map, for an assessment, and record how it was used (Ek A 3.3; Ek D section 5). No new mechanism is needed for this.
5. **Measure G9.4's "research contributions used" and "review cost" now, and apply G10 to the notes.** Do not add more D9 form checks (EXP-005 conclusion; ECC case E).

## (7) Counter-evidence and limits

**Strongest counter-argument.** C02 builds the rule gate and the identity chain, which is security-critical. The checkers found real defects, and records exact enough for a fresh session (D7) and for the ledger transfer protect against drift, Batu's own principle 4(b). Also, test designers write tests from the records, so a false record can corrupt a test (CHK-C02-086 C2). Cutting record conditions has a real risk. Batu also gave the builder the technical decisions, so "decides alone" is the given model, not a drift. The drift is what the helpers are asked to do, and how much.

**Limits of my reading.**
- My condition classification rests on truncated front-matter text.
- I did not read soul-foundations, soul-context, EXP-001, most ECC and gstack notes, or harness notes 16 and 17 in full.
- I did not read the whole plan or all 307 verdicts.
- Some delay came from platform limits (Accept edits, usage limits, Batu's steps), and I did not quantify it.

## (8) Guard denials

- #42097, rule G0: a shell `for` loop with command substitution that the guard could not parse. I repeated it as a plain Python read.


## 4. The checking practice (checker agent `aab761de7b4255d8a`)

*Filing note: lines 17 of the report given as identifiers.*

## Disciplines (D1–D9)

D1: yes: I tested two framings against each other: "the checks were excessive" and "the cost came from plan rules (the class-high merge gate, tests written before the build) and not from the checkers". I state the conclusion conditionally where the two framings give different answers.
D2: yes: Batu's critique and the executor's reading both point towards "too much checking", and as a checker I have a stake of my own. So I counted the real defects that checks caught before weighing the overhead.
D3: yes: I kept to my lens. This is a self-evaluation: there is no PASS or FAIL, and I propose no new plan, role or mechanism.
D4: yes: This is a same-model self-review and is not independent. Counts made with a regex are approximate and labelled so. The defect classification rests on a hand-read sample.
D5: yes: I read the verdicts' front matter and findings at the source, not the log summaries. Where I truncated output with `cut`, I say so. The two claims of absence ("3.2 (c) not asked", "D9 nearly always no") rest on greps over all 307 files.
D6: yes: I kept the proximate causes (the per-head merge rule, tests that would not fit the build, record-type conditions) apart from the systemic ones (no triage in the role, a loop limit that counts only FAILs, the package not carried into the role file).
D7: no
D8: yes: I confirmed `main` is at `249f19786a69068edc125cfcddeea6e6743f8ae1` with a clean tree, and the library clone is at `941f027`.
D9: yes: I read the library parts my task named, listed in (1). They supplied the yardsticks I judged by: proportion, independence, ritualization, objection types and consumer use.

## (1) What I read

- **Plan texts.** `plan/Ek_A_Rol_Sozlesmeleri.md`: §2 (common floor, item 8 at :50), §3.2 (mechanism (c) at :71), DR13-G (:296-309), DR13-Y (:311-324), §5 items 6-7 (:380-381). `plan/Ek_G_Isleyis_Kurallari.md` G4 (:49-56) and G8 (:92-96). `plan/Installation_Working_Order.md` §4 step 4 (:48), "Stage close" (:57), §6 loop limit (:71-74). `plan/Ek_D_Dusunme_Protokolleri.md` §2 item 3 and §3 D1-D9. `plan/decisions/D-031.md`.
- **Batu's text.** `briefs/w-c00-12/BATU_SCALE_AND_EXPERTISE_TR.md` in full.
- **Library.** The multi-agent-patterns study's DevOS assessment (full); the superpowers study's core, notes U03 and U04 and synthesis S04 (full); the gstack study's core (full); the context-memory-harness study's harness file, sections 4.7, 11, 16, 20-21, 23 and F-HRN-06; the Formation and Selection/Exposure key files under the Information ground; the spec-kit study's findings (gate lines); EXP-004's T15 continuation, sections 3-10 (identifiers; filing note).
- **Installation.** All 307 verdict front matters (verdict, conditions, D9 and D6 lines), tabulated. In full: CHK-C02-075, the findings of CHK-C00-028/029/033/052, and part of CHK-C01-112. The conditions blocks of 31 more verdicts spread across C00 to C02. Every conditions block from CHK-C02-075 to CHK-C02-120. The blocking-finding lines of all 14 FAILs. `plan/work/W-C02-09.md`. The W-C02-09 entry headers of `plan/ledger/C02-log.md` and L-415 in full. The history of `.claude/agents/checker.md`.

## (2) What the library and the plan say about my lens

- **DR13-G** (Ek A :300, :305, :307-308). In high-impact work the reviewer asks Ek A 3.2 (c)'s question: was the relevant accumulated knowledge consulted, and used correctly? A design-knowing review and a design-blind review are not one piece of evidence. Several reviewers repeating the same mistake do not add confidence. The role comes with a knowledge map, methods and an exam.
- **Proportion is part of the role, not a dispensation from it.**
  - Ek A §2 item 8 (:50) asks for an expert assessment of every item, which "may" end in little work.
  - Batu's text (:13, :23) asks who decided that no architect is needed. The expert decides how much involvement is needed after seeing the problem; small work means less work, not a lower standard.
  - The builder's own reading of that text (:48-49) says asking the expert must be cheap, a short triage, and it warns that process grows by itself.
- **Kinds of objection** (G4 item 4, :54; T15 §§3, 5, 9-10):
  - Defect, missing evidence, preference and scope conflict are different things, and only a defect requires a repair.
  - Five critiques that share one assumption are not five grounds.
  - Closing does not need every critique driven to zero.
- **Review is not proof by headcount.**
  - Multi-agent assessment §8 and C5: review, verification and adversarial challenge are different jobs, and a critic is judged by which failure classes it turns red on.
  - R1 and R7: correlated agreement, and the "approval ritual". C1 and C10: every reviewer layer must protect a named requirement, and "no extra layer needed" is a valid outcome.
  - Superpowers: one reviewer's two verdicts are not two reviewers (CORE :44); a shared brief means a shared gap (:37).
  - Superpowers U03 F22 (:48-59): minor findings are deferred, not fixed in a loop; at a cap the remaining findings are adjudicated; re-review is scoped.
- **Cheaper evidence first.**
  - gstack P1 (current standing over ceremony) and P3 (heterogeneous evidence); its F5 class (an old review taken for current truth).
  - Harness study §11 (an added evaluator does not solve verification), §16 (more harness is not better harness) and §21.7 (cost-adjusted value).
  - spec-kit treats its review gates as optional (FINDINGS :24).
- **Use is not availability.** Formation KEY :17 (acquired ≠ exposed ≠ used) and Selection KEY :22 (availability ≠ use). A role map in a file is not consultation.

## (3) What the installation did, with evidence

**Volume and outcomes**
- 307 verdicts, about 4.38 MB in total: C00 75 (0.98 MB), C01 112 (1.55 MB), C02 120 (1.85 MB).
- Outcomes: 14 FAIL, 69 PASS, 224 PASS-WITH-CONDITIONS.
- 665 conditions in all. By regex, about 90 verdicts (29%) re-check conditions, deltas or a second round, and 26 are lens splits.

**Was 3.2 (c) asked?**
- Until 2026-10-19 the checker role file had no knowledge map, no 3.2 (c) question, no failure classes and no examples. Its first version is from `dbb24b5`; the map was added in `8c76051` on 2026-10-19.
- Of the 242 verdicts that carry a D9 line, 235 answer "no".
- Before 2026-10-19 only three are not "no" (CHK-C01-012, CHK-C01-035, CHK-C02-009), and two of those three did not consult the library.
- CHK-C02-075 found no library clone present (:142), yet answered "D9: no" (:23) instead of "could not consult".
- The 3.2 (c) question as such appears only in CHK-C02-120. Stage closes accepted "D9: no" as fitting (CHK-C00-075 :126; CHK-C01-112 point 6).

**Thinking or form?**
- **Both, but the count leans to form and the value leans to thinking.** Hand-reading the sample, most conditions are records:
  - dated lines, annotations, "carry as a note with an owner and a deadline";
  - corrected counts, for example CHK-C02-084 C2's "1 to 13" against 16;
  - references that must resolve (CHK-C02-103 C2);
  - incomplete lists (CHK-C02-118 C3).
- The defects that mattered came from checkers' own probes, mutants and re-reading of the source.

**Real defects that checks caught and nothing else would have caught first**
- A leak-check parse bypass through 0x1e/0x1f bytes (CHK-C00-033 F3).
- Service names back in the public repository, in a decision record that called them redacted (CHK-C00-028 F1).
- Library headings left verbatim in copies about to be published, which the 8-word scan cannot see (CHK-C00-052).
- A CI workflow that GitHub would not accept, and a PR gate that passes silently on quoted file names (CHK-C02-029, CHK-C02-035).
- A test plant spelled out in plain form in the public repository (CHK-C02-043/044/045).
- API roles holding TEMPORARY (CHK-C02-076 C5).
- A Mission widening accepted on the same authority, and a required reason made optional against Appendix B principle 3 (CHK-C02-086 C1, C3).
- `supports` walked in the direction opposite to B:149 (CHK-C02-092 C1).
- `transfer_decision` accepting `now` and `infinity` as answer times (CHK-C02-104 C1).
- Test oracles that accept any error as the refusal, or that could never pass a correct build (CHK-C02-030, -088, -089, -094, -095).
- Rules left untested, shown by checker-made breaks (CHK-C02-101 X1, -102 X5).

**A check that missed.** CHK-C02-113 passed the CONC copy on offline runs. The counted job run then crashed it, because the runner's Python 3.12 behaves differently from the container's 3.13 (L-415).

**W-C02-09: 41 verdicts and zero FAILs** (CHK-C02-075 to CHK-C02-120, without 080, 082, 083, 116 and 119)
- 14 verdicts (i), one per migration (M09-01 to M09-12, the rule corrections, M09-TC). The class-high merge gate (working order §4 step 5) requires each.
- 13 checks of test work. Most were revisions made after merged tests proved unworkable on the build (N-283, N-285, N-291, N-293/294, N-297, N-301, N-305, N-308; L-361, L-366, L-372, L-374, L-379, L-391).
- 9 re-checks of conditions or deltas (079, 085, 087, 105, 107, 109, 117, 118, 120). Several of these were demanded by the checkers' own conditions ("a fresh checker…", "a checker confirms the diff").
- 4 records of interface and decisions (076, 081, 095, 110), and verdict (ii) (115).
- **What drove the rounds:** the per-head rule, the churn of tests written before the build, and the checkers' own conditions. Defects come third.
- The acceptance block grew to 24 KB, partly through checker-authored departure text (CHK-C02-115 C5, CHK-C02-117 Q2).
- No checker raised a frame review, although one failure class recurred about eight times. The D6 answers traced each test fault's class locally ("the same fault in DM11-d, -e"), never the process.

## (4) Gaps

1. **3.2 (c) not asked; D9 "no" by default.** Confidence: high.
   - Cause: D-010's short role file carried no map; tasks carried no library line until PC-52.
   - It was also my own choice: D9 item 1 (design, implementation, testing) was within reach in every task.
2. **No triage of involvement.** Confidence: medium-high.
   - Every dispatch got a full verdict, and I never once wrote "this needs no checker beyond a mechanical diff".
   - Record nits became gated conditions, often with a fresh check attached.
   - Cause: the role procedure has no triage step; G4 item 4 was unused; the executor dispatched everything.
3. **Causal depth stopped at the artefact.** Confidence: medium-high.
   - Recurring test-to-build mismatches and nine-verdict stage closes (CHK-C00-067 to -075) were never named as a frame signal.
   - The §6 loop limit counts FAILs, so a run of PASS-WITH-CONDITIONS rounds never trips it. No checker raised that as a finding on the rule.
4. **Multiplicity taken for independence.** Confidence: medium.
   - Same-model lenses plus an aggregating verdict: CHK-C02-045 "upholds" lenses A and B; CHK-C01-112 has lenses A to E.
   - Only one reading mode was ever used, the one that knows the design. G4 item 2's product-only reading never was.
5. **Checkers grew the records.** Confidence: medium.
   - 665 conditions, many asking for new notes and dated paragraphs (284 notes exist). Every later reader carries that cost.

## (5) Self-evaluation as a role

**What worked.** I worked as a careful conformance verifier:
- exact SHA, and my own runs, mutants and breaks;
- the producer's confidence not taken as evidence;
- independence declared honestly;
- sound work rarely rejected (14 FAILs).

That is DR13-G's verification core, and it caught real harm.

**What did not.** I was not DR13-G's expert:
- no map, no failure-class lens, no 3.2 (c), no proportion;
- I did not separate preference from defect, and I rarely questioned the frame or the conditions' own size.

**My share of the pattern Batu named.** I answered every dispatch at full depth and handed back conditions plus calls for more checking. In that way I helped make "decide alone, then send it to the checker" the main loop, instead of acting as the expert who first says how much checking the work needs.

## (6) What would bring the practice back in line (existing texts, no new mechanism)

- **Open each verdict with a short triage** (Ek A §2 item 8; Batu (i)):
  - the claim;
  - the failure classes that could make it false;
  - the cheapest evidence that tells right from wrong (a counted deterministic run, a diff, a source re-read);
  - the depth chosen, and whether a fresh check is needed after the conditions. "Executor's diff suffices" is a valid answer.
- **Type every objection (G4 item 4).**
  - Only a defect or missing evidence blocks.
  - Record and wording points go into a non-blocking list, which the executor meets without a re-check; the next substantive verdict or the stage close samples them (superpowers scoped re-review; gstack P1).
- **Ask 3.2 (c) on high-impact targets, using the map now in the role file.** D9 names what was read, or says "could not consult".
- **Track rounds and recurring classes per item.** At the second recurrence, the finding is a frame review (§6; plan 6.12 item 2), not another condition. Also flag, as a finding on the rule itself, that the loop limit counts only FAILs.
- **No same-model lens splits with an aggregating verdict.** Use one checker, or a genuinely different evidence path: the counted environment's run, or a product-only reading.
- **Keep the practices that found the real defects:** own breaks and mutants, source re-reading, binding to the exact SHA.

## (7) Counter-evidence and limits

**Against Batu's reading:**
- The checks caught harmful defects that no other mechanism would have caught first: leaks into the public repository, a guard bypass, a fail-open CI gate, semantic errors in the schema, false test oracles. The erosion was in proportion, not in checking as such.
- Much of the count is rule-driven (per-head class-high verdicts; ledger rule 3 for test revisions) or comes from upstream test churn, and is not a checker choice.

**Against the executor's reading:** for my role the missing package explains gap 1, but not gap 2 or gap 3. I had the authority to say "less is enough" and to name a frame problem, and I did not use it.

**Limits:**
- About 31 verdicts were hand-classified, and three were read in full.
- Counts made by regex are approximate.
- I did not read the task texts (transcripts), so I cannot tell how far the briefs steered the D9 answers.
- I did not re-run any defect claim myself.
- This is a same-model self-evaluation.

## (8) Guard denials

None of mine. The session's guard log shows five denials between 18:37 and 18:40Z (#41925, #41967, #42053, #42097, #42098). Their commands are not mine; they were made by other helpers.


## 5. The test design practice (test-designer agent `aee864044227043eb`)

*Filing note: verbatim.*

## Disciplines (D1–D9)
D1: yes: I compared two framings, risk-led against specification-coverage-led, and two readings of ledger rule 3 (frozen as written, or replaceable by a stronger test before its result). I also kept the claim that the revisions came from environment differences separate from the alternative that they came from fixture and rule drift, and counted both.
D2: yes: I treated Batu's critique, the executor's reading and my own role's interest (defending it, or confessing too much to please) as hints, and tested each against the log and the notes.
D3: yes: the deliverable is a read-only self-evaluation for a synthesis. I wrote no file and kept the proposals inside what the plan already gives.
D4: yes: for the 24-hour count and the break evidence I asked whether each check could turn red if its claim were false, and on which environment.
D5: yes: I worked from views (log entries, notes, the 571 KB EV-C02-014 read only in part). I went back to the source texts for C4, K2, ledger rule 3, DR04 and the role file's first version, and I mark below what rests on partial reading.
D6: yes: I traced why the revision rounds happened, separating the proximate cause (a test fault) from what enabled it (tests written against an assumed interface, fixtures duplicated across files, no cap on loops).
D7: no
D8: yes: read at `main` as checked out in `/home/user/devos` (no checkout) and at library clone 941f027; W-C02-09 is still `acceptance: proposed` and W-C02-13 is `planned`.
D9: yes: I read the role file's knowledge map, DR04 and DR10, and the library sections named in (1). They changed my conclusions on the passive window, on environment parity and on bounded correction rounds.

## (1) What I read
- **Plan:** Ek A sections 1–3, DR04, DR10; Ek D sections 2–3 (all of D1–D9 and the working rules in section 5); Ek C C0 and F01; `plan/ledger.md` rule 3; working order line 53 ("Where a result ran"); Batu's `briefs/w-c00-12/BATU_SCALE_AND_EXPERTISE_TR.md`, scanned for his scale points.
- **Installation:** `plan/work/W-C02-09.md`'s acceptance block (23 KB); `tests/C02/W-C02-07/README.md` sections 5.1–5.2; notes N-279 (K2 and the L-342 to L-344 and L-359 annotations), N-283, N-291, N-302 to N-304, N-309, N-314 in `plan/work/C02.md`; log entries L-358, L-404, L-415, L-425 and the headings of every test-revision entry; `evidence/C02/checks/CHK-C02-115.md` C4; EV-C02-014 section 3 (Route A) and the outline of the rest; EV-C02-018's outline; the git history of `.claude/agents/test-designer.md` and its first version (7a7f349).
- **Library:**
  - work-environment `KEY.md` and findings 02, 05 (section 9) and 07
  - Environment ground `KEY.md` and work-conditions `KEY.md`
  - superpowers `CORE.md` and S04
  - playbook 01 sections 8 and 15, and 04 F5, F6, F10, F11, F13, F18
  - gstack `CORE.md` and its testing synthesis sections 7, 11 and 30
  - Academy note section 1
  - CATALOG lines for `i-have-adhd` and `agentic-ai-systems-roadmap` (PLANNED, or a seed; questions only)

## (2) What the plan and the library say
- **DR04 (Ek A:144–157).** Its inputs include "the risk class". Its work is to set up examples, "alternative criteria, environment conditions and the scope limit". Its output is a testing contract with a "sampling rationale" and a "decision rule". Its acceptance clause warns against measuring a real-world claim with a wrong proxy. DR10 adds that installed, accessible, permitted and working are different things.
- **Ek C C0** has a field "Stage and environment: … in which real environment" and says the number of tests is not a quality indicator.
- **Ek D section 5** says every loop has an upper limit, a budget and a no-progress check. **D3 item 2** says a schedule-setting parameter states the time it adds.
- **Batu's scale text** (lines 23 and 33, in substance): a good system also prevents unnecessary work, and an expert scales the effort to the work.
- **Library:**
  - The environment must be specified relative to the behaviour being protected. Ask which attributes must match for the claim; a declared configuration is not the full set of things that affect behaviour (finding 02 sections 4 and 8).
  - An observation does not cover what it never exercised, and a monitoring path can differ from the real use path (finding 05 section 9; playbook F18).
  - Repository state is not live state; check the real target before acting (playbook F11; gstack's "verify reality" readback).
  - Three things are separate: when a test was written, whether its oracle is valid, and whether its result applies to the current code and environment. Correction rounds are capped, then adjudicated (superpowers S04 sections 3–4).
  - An unavailable runtime is not a negative result; "green" is a derived view (gstack testing synthesis sections 11 and 30).
  - The Academy note describes a loop: the builder fixes the visible failure, the verifier confirms, an adversarial reviewer finds a broader form of the same failure, and the loop repeats.

## (3) What the installation did (evidence)
- **Specification coverage, not risk.** W-C02-09's condition opens with "Serves … word for word" and then follows the specification point by point (W-C02-09.md:23–60). Tests are function × role-class matrices: T-W14-FN reached 290 cases and 155 breaks for fourteen transfer functions (L-415), with a 173 KB specification. In total, `tests/C02` holds 435 files (5.7 MB) and 299 break files. No condition names a risk class or a sampling rationale. Ek C's own F01–F08 are risk-derived, from real findings; the expansion beyond them was coverage-driven, and checkers kept adding "rules no merged test reaches" (N-302 and N-303 annotations: 23, 30 and 25 more cases).
- **Revision rounds and their causes.** About 20 log entries are test revisions or their checks (L-340 to L-415). Most come from fixture and rule drift: a test written against the assumed interface v1 (README 8.1) breaks when the build adds a rule. Examples:
  - a column that does not exist (`mission.scope`)
  - Missions with no creation event under Rule O (N-291)
  - one fault repeated across 16 duplicated fixture copies (N-283; README section 7, since no includes are possible without psql meta-commands, which the no-backslash rule bars)

  Real oracle faults recurred too: any error accepted as the refusal (N-283 (6)), and cases passing "for the wrong reason" (N-279 (1), from L-394).
- **Revisions caused by the environment: three rounds, all on T-W07-CONC (plus one pre-emptive fix in LOCKS).**
  - (i) CONC-tokens counted the job's tokens-step tokens (N-304 (4)). The step was already described in the designers' own README 5.1(b).
  - (ii) The Python 3.12 pipe crash (L-415). The container had python3.12 all along (L-422).
  - (iii) A follow-up condition fix (N-309 (5)); LOCKS's identical pattern was fixed in advance (N-309 (2)).
  - PostgreSQL 16 against 17.6 caused no revision I could find. Its cost is different: every offline result and every break carries "counts: no", and the PostgreSQL 17 break harness (W-C02-13) is still `planned`. A PostgreSQL 17 route on GitHub already existed and had been used in W-C02-03 (L-278, L-313, L-326: 17.11).
- **The 24-hour window.** It came from checkers, not the test designer: CHK-C02-085 K2 (L-359), then CHK-C02-115 C4. K2 itself said a zero shows only that nothing was logged and does not show that the services work. N-314 later judged it weak, yet held that it "still binds as written (ledger rule 3)". L-425 recorded "sooner: none … whose call: none".
- **Ledger rule 3 in practice.** It added these rounds:
  - the four-test loosening line, about 4,500 characters, plus a repeated run and a fresh checker (W-C02-09 point 1)
  - the passed "first result" deadline, plus a delta checker (L-404)
  - CONC's void first result, plus a rerun (L-415)

## (4) Gaps, with cause and confidence
1. **No risk triage at the start; the specification and the build's rule list drove test depth.** Cause: the role file dropped DR04's risk class, environment conditions and sampling rationale (first version, 7a7f349, steps 2–5). High confidence.
2. **The environment was declared for the database, not worked out for each claim.** The interpreter, the job's own steps and the shared state in `devos-test` were left out. Cause: C0's field was filled as a label, and finding 02 section 8's question was never asked. Two of the three CONC rounds were avoidable by reading `migrate.yml` and running under python3.12 first (high). The PostgreSQL gap could have been reduced through the existing PostgreSQL 17 GitHub route (medium; I did not check that route's limits for the breaks).
3. **The 24-hour count was unsound as an acceptance gate.**
   - With near-zero traffic on `devos` it has almost no power to detect a failure.
   - Its control showed only that the logs capture the phrase, not that the services ran.
   - The 24 hours came from `query_logs`' reach, not from any consumer's schedule.
   - The paths that bear the risk (PostgREST as the four API roles) had already been exercised actively by the job's programs; DevOS uses no Auth, Storage or Realtime path.

   As a stated backstop it was sound. Rule 3 forbids loosening; it does not forbid replacing a check, before its result, with an active probe. "Whose call: none" was wrong: it was the executor's call, with a checker. High confidence on the reading of the rule, medium on the service-path inventory (inferred, not read on the platform).
4. **The conditions bind methods, not just claims:** copies byte for byte with SHA-256, git ancestor order, "before the first result" deadlines. So every operational detour becomes a "loosening" under rule 3. Cause: acceptance blocks were used as process control, against D3's separation of method from goal. High confidence.
5. **Loops with no cap.** Each build migration led to a test-fault note, a designer, a checker and a merge, around 14 times, which is the Academy note's loop. Ek D section 5's upper limit and no-progress check were not applied. High confidence.
6. **No professional continuity.** About 45 separate test-designer instances in C02, no failure-class record, the same fault classes rediscovered. Ek A 3.2 item 4 and 3.3 were not carried. High confidence.

## (5) Self-evaluation as the test-designer role
I have acted as a careful writer of exhaustive, well-formed C0 specifications: controls, breaks, "could not check" never counted as a pass, honest "not covered" lists. I have not acted as DR04's expert. I did not ask first what could really go wrong, where, and how much testing that is worth. I generated tests from the specification and the build's rules, wrote recipes at payload level before the interface existed, and so produced defects that checkers then found. My oracles were sometimes too weak (any error accepted as the refusal), and my view of the environment stopped at the database version. I answered D9 "no" until SB-LIB. Batu's "only named an expert" fits my role substantially. One qualification: the role file I was given lacked the package, and the 24-hour gate and the sequencing clauses were not mine.

What DR04 and the library would have had me do differently:
- Write a one-paragraph risk and environment triage per item first: the claims at risk, the counted environment and the attributes it must match, and the cheapest refuting observation.
- Size the cases to that triage.
- Prefer active probes and readback over passive windows.
- Check each oracle's sensitivity before pinning recipes.
- Fix the criterion before the build, but bind fixtures to the interface record.
- Carry a list of known failure classes forward.

## (6) Back in line without a new plan
- Apply DR04 as written: the risk class and environment conditions as inputs; the sampling rationale and decision rule as outputs.
- Fill the role file's empty package parts (known failure classes and examples, from N-283, N-291, N-304, N-309), which Ek A 3.2 already requires.
- Apply working order line 53 per claim: it already says to label a result exploratory "for each claim that version can change". Use the PostgreSQL 17 GitHub route already used in W-C02-03.
- Apply N-314 now: replace C4 by an active probe of each affected path, decided before its result, with a checker. Rule 3 allows a stronger replacement.
- Write acceptance conditions as claims plus refuting evidence; leave the copy and order mechanics in the working order.
- Apply Ek D section 5's loop limit to test-revision and checker rounds. At the limit, the decision goes to adjudication, as Ek D already says, and is recorded.

None of this needs a new role or mechanism.

## (7) Counter-evidence and limits
- The exhaustive approach has merits: its honesty labels ("counts: no", "could not check") prevented false greens, and the checkers' breaks found real gaps (the one-Mission lock, X2). A lighter, risk-led design might have missed some of those.
- I found no recorded case of a pre-written test turning red on a build defect. That search was narrow, so this absence is weak evidence.
- The counts are from Grep over the log, not a full read.
- I read only section 3 of the 571 KB EV-C02-014.
- The inventory of which platform services act as the four API roles is inference, not read on the platform.
- Rule 3's text could reasonably be read more strictly than I read it.
- Web: none read.

## (8) Guard denials
- #42053, G0: an unbalanced backtick in a `grep` pattern. Redone with the Grep tool.
- #42098, G0: the same cause. Redone with the Grep tool.

Neither was recorded with `tools/guard_report.py`, because this task writes nothing. The executor should record them.


## 6. The production practice (producer agent `a912d5769b0cf4fe2`)

*Filing note: verbatim.*

## Disciplines (D1–D9)

D1: yes: I tested two framings side by side: "the executor reduced the producer to a writer" against "the plan itself defined the producer as an interim writer until C05" (D-010 item 17, `producer.md` header). I kept both, because each changes where the fix belongs.
D2: yes: Batu's critique and the executor's own first reading point the same way, so I looked for evidence against them: the forms EV-C02-013's producer chose itself, Batu's "planı bozmayalım" at L-340, and the plan's deferral of role packages to C05.
D3: yes: I stayed within the production-practice lens and the read-only, report-only output, and proposed no new plan, role or mechanism.
D4: yes: six task prompts plus file counts are a sample, not coverage, so every claim about "all producers" is worded as limited.
D5: yes: log entries are the executor's summaries, so for the method question I went to the tasks' first user messages, the role file's git history and file counts.
D6: yes: I traced the producer's thin practice through its layers: D-010's role definition, a role file with no package, task-level dictation, the test-first order, and explicit library bans in tasks.
D7: no.
D8: yes: I read at `main` `249f197`, and compared `producer.md` at `7f5c03f` (during the build) with `8c76051` (PC-52, 2026-10-19).
D9: yes: I read the playbook, superpowers (CORE, U03, U04, S03), the ECC method case, gstack CORE and spec-kit FINDINGS, plus the mattpocock-skills and ponytail METAs (PLANNED, so questions only). They gave the standards I judged against: preparation that scales with the work, implementer return states, and exact copies instead of model transcription.

## 1. What I read

- **Library:** `research/studies/CATALOG.md` (the relevant rows); `anthropic-ai-native-sdlc-playbook/01-PLAYBOOK-RESEARCH.md` in full, and `03-…ASSESSMENT.md` §7–10; `superpowers/CORE.md`, `notes/U03…` and `notes/U04…` in full, `syntheses/S03…` in full; `ecc/META.md` and `ecc/METHOD-CASE.md` in full; `gstack/CORE.md`; `spec-kit/FINDINGS.md`; `mattpocock-skills/META.md` and `ponytail/META.md` (both PLANNED).
- **Plan:** Ek A §2, §3 and DR01–DR05; Ek D §2 item 3 and §3; plan §9 (C00–C02); `plan/work/W-C02-09.md`.
- **Records:** EV-C02-013 §1–12 and headings; EV-C02-014 headings; C02-log L-336 to L-343, L-377 to L-379 and L-418 to L-425; `producer.md` history.
- **Batu's text:** `briefs/w-c00-12/BATU_SCALE_AND_EXPERTISE_TR.md` (passages found by search).
- **D-010 summary:** `KARAR_OZETI_2026-10-05_TR.md` items 16–18 and 25.
- **Transcripts (first messages only):** producers `a6e769308d5b4fce5` (EV-C02-013), `a167a0843565bed6c` (M09-01), `af74f765a56f55dce` (M09-08), `af4f94fe9a7b1e1a0` (EV-C02-017), `a52e32d6238034751` (PC-52), and the Q1 log helper `ae5184c3d1ca33c25` (L-421). I also counted, across all transcripts, the agents of type producer and the files containing the phrase "Do not read the research library".

## 2. What the plan and the library say about production

- **Ek A DR05.** The role assesses existing code, the standard library and ready-made parts first. It makes a wrong assumption visible. Its package has a knowledge map (ponytail, spec-kit, mattpocock-skills, superpowers, gstack, hands-on-LLM), methods (testing-focused development, source fidelity) and known failure classes.
- **Ek A §3.3.** A contribution is produced "with its own package", not by "a helper that has no context".
- **Ek A §3.5.** The coordinator's task names purpose, output, sources, limits and budget. It does not name the method.
- **Ek A §2 item 8.** Every work item gets an expert assessment of how much effort it needs.
- **Batu's text, line 21.** The person asking for the work should not decide how much expertise it needs. Line 23: avoid needless work.
- **Superpowers.** Preparation scales by route: spike, bounded, or architectural. The implementer can answer DONE_WITH_CONCERNS, NEEDS_CONTEXT or BLOCKED. Fix loops are capped and then adjudicated.
- **Playbook.** The implementer reads the codebase and proposes the plan before changing anything. When implementation gets fast, review capacity becomes the bottleneck.
- **ECC method case.** Recurring "whole-file transcription failures". Recommended instead: transform the exact source and reuse immutable objects, and do not answer the failure with more duplicated records.
- **Ponytail (questions only).** The first question is whether the thing needs to exist at all.

## 3. What the installation actually did

- **The executor chose the method.**
  - EV-C02-013's task fixed the strategy (interface first, then test revision, then a checker, then SQL), the eight contents of the record, the sources, a 90-minute budget, and: "Do not read the research library."
  - M09-01's and M09-08's tasks fixed the files, the steps, what to run offline, and that the migration "holds exactly" its row in EV-C02-013.
  - 14 transcript files contain "Do not read the research library."
- **During the build the role file had no knowledge map, methods or failure classes** (`7f5c03f`). The map arrived only with PC-52 on 2026-10-19.
- **D-010 item 17 defines the producer as "Üretici (yazar)"**, i.e. a writer.
- **Producers did use real judgment inside that frame.**
  - EV-C02-013's producer chose forms itself: D-1 to D-15, the read block / write block refusal pattern, and the migration split.
  - Builders recorded departures, and test faults in N-283, N-285, N-293 and N-297.
  - EV-C02-017's producer gave recommendations, and the executor overruled one (N-289, L-378).
  - In the records and first messages I read, no producer raised an objection at the level of the frame or the method.
- **L-421: the method was dictated and wrong.** The Q1 helper's task said: "never run Python or a shell on saved tool output; write the files with the Write tool only". That is a model copying 4,515 and 1,788 log lines by hand. An earlier helper's partial transcription had already failed. The helper ended on a platform error. The executor then did it right with a byte copy and a 20-line decoder, and its own D6 note names the approach as the cause. This is exactly the failure class in the ECC method case.
- **Cost of W-C02-09.**
  - 14 of the 26 migrations, about 21,983 of 22,938 SQL lines.
  - 55 `devos_api` functions plus 2 owner-only.
  - 46 checker verdicts (CHK-C02-075 to 120) and 90 log entries (L-336 to L-425).
  - EV-C02-013 has 1,530 lines, 16 of its sections corrections; EV-C02-014 has 2,989 lines.
  - Calendar: 2026-10-17 to 2026-10-19.
- **Where the scale came from.** The function count follows the plan's C02 task 2 ("All state transitions as `devos_api` functions") and Appendix B §4's activation table, which the task told the producer to apply. No step asked "what is the smallest set C02's acceptance and C03's start need?" (PC-08). The line count is driven by a uniform defensive pattern in every function, and by break patches that rewrite the function text itself (EV-C02-013 §10, "Forms the merged break patches read"), so the tests fixed the code's form in advance.

## 4. Gaps

1. **The method belonged to the executor's task, not to the producer's expertise.** Cause: D-010's "writer" role, a role file without a package, and task habit. Confidence: high.
2. **No triage of scale before production.** Cause: no step asks for it. The plan's rule that C02 builds only what its acceptance and C03's start need was applied as "follow the activation table". Confidence: medium. Whether a smaller set would have met C02's acceptance is not shown.
3. **Library use was banned in production tasks**, even though DR05's map has existed in Ek A since C00. Confidence: high.
4. **The producer had no state for "this method is wrong, here is a better one".** Role procedure step 1 covers only missing or contradictory inputs, and step 4 covers wrong premises. L-421 shows the result. Confidence: high.
5. **Tests constrained how the code is written, not only what it does** (break patches over the function text). Superpowers U04 separates behaviour tests from source-text assertions. Confidence: medium; mutating the function's source is a legitimate test technique.
6. **Records grew by duplication.** EV-C02-014 repeats the same six subsections for each of 15 parts, and EV-C02-013 carries 16 correction sections. ECC warns against exactly this. Confidence: medium.

## 5. Self-evaluation as the producer role

I and the other producer instances worked as skilled executors of what the task dictated. Locally that was faithful and careful: departures stated, raw output filed, own checks not counted as evidence. But I neither did nor was asked to do what DR05 describes: look first for reuse, triage how much the work needs, choose the method from known failure classes, and consult the library.

Even this task shows the label problem: a producer is used for a reading task.

What DR05 and the library would have me do differently:
- Before production, give a short triage: the smallest deliverable, its route (bounded or architectural), and what can be reused.
- Answer "this method is wrong" as NEEDS_CONTEXT or DONE_WITH_CONCERNS, before doing the work.
- In the L-421 case, refuse hand transcription and propose the exact copy.
- Ask the ponytail question ("does this need to exist now?") for each function group.

## 6. Bringing practice back in line (no new plan or roles)

- **Tasks state purpose, acceptance, sources, limits and budget** (Ek A §3.5), and **leave the method to the producer**. The producer opens with a short expert assessment (Ek A §2 item 8; Batu's line 21) that the executor can accept or argue with.
- **Change one wording in the role file:** procedure step 1 also covers "the method or scale the task implies is wrong, with the better one". This reads Ek A §2 items 6 and 8 into the existing file; it is not a new mechanism.
- **Remove library bans from production tasks.** PC-52's library line does this already. Use the library for failure classes; ECC's transcription case would have prevented L-421.
- **Ask PC-08's question explicitly** ("which decision or action of C02 or C03 would be wrong without this function?") before the next large build: W-C02-10, and C03's work list.

## 7. Counter-evidence and the limits of my reading

**Counter-evidence:**
- Batu accepted D-010 with the producer defined as a writer. The plan defers role packages to C05, so a thin producer was partly the decided design.
- Much of the dictation follows the verification rules (tests before build; the builder never adapts a test), not arbitrary control.
- EV-C02-013's producer did make real design choices.
- 55 functions follow fairly directly from the plan's own text.
- The executor did offer an alternative (a small real loop) at L-340, and Batu declined.

**Limits:**
- I read only the first messages of six tasks, and no producer final reports, so a frame objection could have been raised and dropped without my seeing it.
- I read EV-C02-014 by its headings only.
- I did not check C00's counter-design comparison on how wide the data model should be.
- Ponytail and mattpocock-skills give questions only, no findings.

## 8. Guard denials

- **#41967, rule B5.** A `find`/`ls` command naming the `~/.claude` transcript folder was denied. I used Glob, Grep and `sed -n 1p` (readers, as the denial says) instead. I wrote no file, so I did not record it with `tools/guard_report.py`; the executor should record it.
