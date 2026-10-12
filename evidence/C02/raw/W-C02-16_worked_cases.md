# W-C02-16 point 2: worked cases for working order section 5 (synthetic)

**SYNTHETIC (plan Section 8 item 13).** Every case in this file is made up for this test. The stage `Cxx`, items `W-Cxx-nn`, side branches `SB-1` to `SB-9`, branch names, notes `N-X1` and `N-X2`, plan change `PC-X1`, commits `H1`, `H2`, times `T0` to `T3` and file names are all invented and name nothing real. A "Shape" line points at a real record only to show where a case's shape comes from. It judges nothing about that record. In particular, no case judges FR-06's overlap in C01 (L-197 to L-200). That overlap stays a recorded departure whatever the new text says (W-C02-16 point 3).

**Written.** 2026-10-12, begun at about 14:50Z, by the test designer (a fresh-context subagent of the executor's session, Opus 5.5). Written from commit `560bcab` (`main` after PR #275), before the new text of working order section 5 existed in anything I read. I read the old text only as `git show 560bcab:plan/Installation_Working_Order.md`. I did not read the clone's working files of the working order, `plan/decisions/PC-40.md`, or any other new text of W-C02-16. If a case looks wrong once the new text has been seen, that is reported, not edited (ledger rule 3; Appendix G G8 item 3).

**Sources, all at `560bcab`.**
- W-C02-16: its body and acceptance block.
- N-144 on `plan/work/C01.md`, and N-205 on `plan/work/C02.md`.
- CHK-C01-112 finding 12.
- Working order sections 2, 4, 5, 6, 7 and 9.
- `CLAUDE.md`: "`main` is the only source of truth".
- `tools/merge_gate.py`, functions `gate` and `cover`.
- The C01 log, L-197 to L-200.
- N-186 on `plan/work/C01.md`.
- Appendix C, C0.
- The decision summary's items 2 (B) and 21 (K).

**How the checker uses this file.** Read each case against working order section 5's new text at the head that adds it, together with the sections the change also touches. For each case, record:
- the sentence or sentences that decide it, quoted;
- the answer they give;
- whether two careful readers could reach different answers.

A case passes when exactly one answer follows from the text. It fails when the text gives no answer, or two. The cases do not choose between "may start" and "may not start": that choice is the builder's (summary item 21, (K)), and a text in either direction can pass every case (see the positive control). Each case fixes what the text must settle so that it admits only one reading.

## The test in form C0

| Field | Content |
|---|---|
| ID and claim | W-C02-16-T2. Working order section 5's new text settles, in one reading, whether the next plan step may start while a side branch waits only on its closing check and merge. It also forbids, or names as a departure that the log records, every way the next step can depend on that branch before its merge. |
| Failure class rule | The next plan step depends on a side branch that is not yet merged: on its files, its decisions, its rules, or the state of the branch at the head its closing check judges. Or the dependence happens and no record shows it. |
| Examples | The original finding is CHK-C01-112 finding 12 (FR-06's overlap, L-197 to L-200). Here only synthetic cases of its shape stand for it (P1, N4). Other manifestations: N1 (a file or a decision used), N2 (a rule relied on), N3 (the branch changed after its check) and N4 (the overlap not logged), each in two forms. N5 and N6 test the remaining two of N-144's five conditions. |
| Negative control | (1) The old section 5 (Break, at the end of this file). (2) A text that says only "a side branch closes when its result is recorded; the next plan step may then start". It settles P1 but must fail N1 to N4, because it says nothing about reliance, rules, added work or the log. (3) A text that says "may start" in one place but leaves "closes ... before the next plan step starts", or section 2's sentence on the checker at closing, in a form that contradicts it. It must fail P1 (two readings). |
| Positive control | A text in either direction passes if it settles each case as the case asks. **"May not":** the text puts the closing point at the merge (or at a later point it names) and forbids the next plan step until then. It says what goes on meanwhile, in a way that fits section 7 and section 4 step 3. N1 to N4 are then forbidden at the step where the next step starts, and the text says what the log records if one happens anyway. **"May":** the text states N-144's five conditions so that N1 to N6 each fall under one of them, and it says what the log records. Neither direction needs a new tool (W-C02-16 asks for none). |
| Break attempt | (1) Read every case against the old section 5 at `560bcab`. At least one must come out left to the executor's own reading. The table at the end shows that five do. (2) For a "may" text, strike each of N-144's five conditions in turn. The case named for that condition in the table "Which condition each case needs" must then come out undecided or permitted. If it still comes out forbidden, it is not testing that condition. |
| Stage and environment | C02, W-C02-16 point 2. The cases are read, not executed, by the fresh-context checker of point 6, at the head that adds the change. No live environment is involved. |
| Independence level | Written by the test designer, a fresh-context subagent of the executor's session, from `560bcab`, before the new text existed in anything it read. It is the same model family as the producer and the checker (declared, Ek A 5.3). The producer writes in the same clone and may read this file. So the text may be fitted to the cases, which is allowed because they are the condition. The cases were not fitted to the text. The point 6 checker runs and judges them. |
| Evidence layer | Semantic: what the text says. The behavioural layer, whether the executor follows the text at the next side branch, is not covered here. W-C02-16's "Not covered here" names it, and it is left to the stage-close checker (W-C02-18). |
| Evidence envelope | **Target commit:** the head the point 6 checker judges (filled in by the checker). **Criterion:** this file as the executor commits it, written from `560bcab`. **Input:** cases P1, N1 to N6, B1 and B2. **Observation:** for each case, the deciding sentence and the answer. **Raw evidence:** the checker's verdict file, `evidence/C02/checks/CHK-C02-<nnn>.md`. |

## Common setting (synthetic)

- Stage Cxx runs in the executor's single session.
- Item W-Cxx-07 has been accepted and merged. The startable frontier holds W-Cxx-08 (on the critical path) and W-Cxx-09, each with its acceptance condition merged on `main`.
- Reasoning proposed side branch SB-n. Before it opened, the log recorded the plan step it serves, its return point (the frontier) and its limit, and an opening checker asked "have we broken away from the plan?" (old section 5).
- The branch's work is committed on `claude/cxx-sbn-...`.
- **"The closing check"** is the fresh checker that judges the branch at its head and asks the same question at closing. It runs in the background (section 4 step 3).
- **"The merge"** is the branch's pull request merged into `main`.

## ✔ The positive case

### P1 · A branch whose result is complete and recorded waits only on its closing check

1. At T0, SB-1's result is complete on its branch at head H1. SB-1's limit is one analysis record and one note, and both are there: `evidence/Cxx/raw/SB-1_analysis.md` and note N-X1. No helper is writing on the branch: every writing helper's end status has arrived (PC-24).
2. At T1, the executor starts SB-1's closing check at H1, in the background.
3. At T1, W-Cxx-08 is the next plan step. Its acceptance condition, sources and tools are all on `main`, and SB-1 touches none of them. Nothing in SB-1's result or rules bears on it.
4. The question at T1: may W-Cxx-08 start now, or only after SB-1's check passes and SB-1 merges (say at T3)?

What any acceptable text must make determinate:
- (a) One answer to step 4's question, which follows from the text without the executor's own reading.
- (b) The point at which a branch "closes", so that "before the next plan step starts", or whatever replaces it, refers to one moment. Finding 12 names two candidates: the result recorded on the branch, or the closing check passed and the branch merged. The text may also name a third point.
- (c) If "may": what the log records about the overlap, and in which entry or entries. A reader of the log and git alone must be able to tell that W-Cxx-08 started before SB-1 merged. At least these are named: the branch, the head its closing check judges, the next step and when it started, and the merge. N-144's five conditions must also be stated (see N1 to N6).
- (d) If "may not": what the executor does from T1 to T3, in a way that fits section 7 ("Meanwhile, and in each state, finish and merge all work that does not depend on it"; PC-23) and section 4 step 3 (checks run in the background). This is condition point 1.
- (e) What counts as "the next plan step". At least an item taken from the startable frontier (section 4 step 1) counts. The text must also say whether a note's change, or other work outside the frontier, counts as well.

Shape: L-197 to L-200 at `560bcab`. A branch waited only on its confirmation check, running in the background, while a frontier item and a note's change started. That record is not judged here.

## ✘ The failure class: the next step depends on a side branch not yet merged

Each case takes P1's steps 1 and 2 and then changes what happens next.
- **Under a "may not" text**, each case is decided at the step where the next step starts: that start is forbidden. The checker then confirms that the text also says what the log records if it happens anyway.
- **Under a "may" text**, each case must fall under one of N-144's five conditions as the text words them. The text must forbid it, or name it a departure that the log records.

### N1 · The next step uses a file or a decision from the branch before the merge

**(a) A file.**
1. SB-2's result includes a corrected fixture at H1, `tests/fixtures/sb2_sample.json` (synthetic). Its closing check runs.
2. W-Cxx-08 starts. Its producer reaches the fixture in one of these ways:
   - the executor creates W-Cxx-08's branch from H1 rather than from `main`;
   - the executor copies the fixture into W-Cxx-08's branch;
   - the producer's task names the path on SB-2's branch as a source.
3. W-Cxx-08's work passes its check using the fixture. SB-2 has not merged.

What the text must do: forbid step 2, because the next step relies on no file of the branch until the merge, or name step 2 a departure that the log records.

Where it shows: W-Cxx-08's branch has SB-2's H1 as an ancestor, though H1 is not on `main`; or the task names a path that exists only on SB-2.

**(b) A decision.**
1. SB-3 is a short analysis of a timing parameter. Its record at H1 recommends option B over option A, and the executor agrees.
2. W-Cxx-09 starts while SB-3's closing check is running. Its producer's task says "use option B (SB-3)".
3. SB-3's closing check returns conditions that change the recommendation, or finds that the branch broke away from the plan.

What the text must do: the same as in (a). A decision on an unmerged branch is a result of that branch, so W-Cxx-09 built on it must not count as compliant.

### N2 · The next step relies on a rule the branch changes, before the merge

**(a) A working-order rule.**
1. SB-4 changes working order section 7, a class-high path: a new sentence widens which waits let other work go on. Its plan-change record says the change "takes effect when PC-X1 is accepted". Such records at `560bcab` take that form; for example, N-186 on `plan/work/C01.md` says "the change takes effect when PC-35 is accepted with W-C01-20".
2. SB-4's closing check returns PASS at H1 at T2. The merge is at T3.
3. Between T2 and T3, the executor starts W-Cxx-09. It gives SB-4's new sentence as the reason the work may go on, or it acts in a way that only the new sentence allows.

What the text must do:
- Say which rules hold for the next step during the overlap: those on `main` at that moment, or the branch's rules from a point the text names. "Accepted" at T2 and "merged" at T3 must not both be readable as the moment the rule takes hold.
- Forbid step 3, or name it a departure that the log records.

Shape: a plan change of the working order made on a side branch, as FR-06's branch carried PC-23. That record is not judged here.

**(b) The rule under change is section 5 itself.**
1. SB-5 changes working order section 5, as a side branch might.
2. While SB-5 waits on its closing check, the executor starts W-Cxx-08 under SB-5's new section 5. The old section 5 on `main` does not allow this start, or allows it on only one reading.

What the text must do: the same as in (a). This case checks that the overlap rule cannot bootstrap itself: during SB-5's own check, `main`'s section 5 governs, or the text names the departure.

**A third form, not worked through:** a branch that changes the guard (`.claude/hooks/tool_allowlist.py`) or `tools/merge_gate.py`. The live guard runs from the working tree at `main`, so the change does not act before the merge. The next step's plan can still be built on a call that the change will allow.

### N3 · Work beyond the check's conditions is added to the branch while the next step runs

**(a) Additions after a verdict with conditions.**
1. SB-6's closing check at H1 returns PASS-WITH-CONDITIONS with one condition, C1: correct a citation in its record.
2. W-Cxx-08 is running; it started at T1.
3. On SB-6's branch, the executor commits C1's fix. In the same commit or the next, it also adds work that "came up", beyond C1 and only in class-normal paths: a new note N-X2, and a wording change to a tool's help text.
4. SB-6 merges.

The merge gate does not stop this. A class-normal pull request needs no verdict at all. A class-high one is covered by the verdict at H1 when only class-normal paths changed after H1 (section 4 step 5; `tools/merge_gate.py`, `gate` and `cover`).

What the text must do: forbid step 3's additions beyond C1, or name them a departure that the log records. Here the text decides the case, not the gate.

**(b) The branch changes after its check because the next step merged first.**
1. SB-7's closing check runs at H1.
2. W-Cxx-08, started at T1, merges into `main` at T2. It changes lines of `plan/ledger.md` (class normal) that SB-7 also changes.
3. SB-7's pull request now conflicts. The executor merges `main` into SB-7 and resolves the conflict at H2, touching class-normal paths only.
4. SB-7 merges, and the gate accepts the verdict at H1, as in (a).

What the text must do: say what resolving a conflict caused by the overlap is. It may be "what the check's conditions require", work beyond them (a departure, or a new check at H2), or something else the text names. The case fails if the text leaves it to reading.

This dependence runs in the reverse direction: the branch depends on the next step's merge. It belongs here because it is a direct cost of the overlap and of condition 2.

### N4 · The overlap is not logged

**(a) No record.**
1. SB-8's closing check runs at H1 from T1. W-Cxx-09's first commit is at T1 + 2 min. SB-8 merges later, at T3.
2. W-Cxx-09's log entry says what it did, and SB-8's closing entry says the branch closed with the merge. Neither says that the two overlapped.
3. Entries appear in the order their branches merged (L-198, on CHK-C01-044 finding 12). So W-Cxx-09's entry may stand before or after SB-8's, and the order of the entries shows nothing.
4. The overlap is visible only by comparing the time of W-Cxx-09's first commit with the time of SB-8's merge.

What the text must do: require a record of the overlap and say where it goes, or name an unrecorded overlap a departure. A text that says "may start" but not what the log records fails this case.

**(b) Filled but meaningless (C0's format-gate example).**
1. As in (a), except that SB-8's closing entry carries the line "Overlap: none", or "Overlap: other work went on". The commit times show that W-Cxx-09 started at T1 + 2 min.

What the text must do: name what the record contains, so that a checker can compare it with git and find "none", or a line without those facts, false or empty. At least these must be named: the branch, the head under check, the next step with its first commit or start time, and the merge. A text that requires only "the log records the overlap" lets this case through. The case then shows that the requirement is a presence rule only, and the checker says so.

## ✘ Two of N-144's conditions that N1 to N4 do not test

These two cases are not of the failure class above. They exist so that each of N-144's five conditions has a case that turns red when that condition is struck from a "may" text (Break attempt (2)).

### N5 · The branch does not wait only on its closing check

1. SB-1 is as in P1, with one difference at T1. Either a producer started on the branch has not returned its end status, so it may still write (PC-24), or the result lacks a part its limit names (the note N-X1 is not yet written).
2. The executor starts SB-1's closing check at H1 and starts W-Cxx-08 at T1, calling SB-1 "waiting only on its check".

What the text must do: make "complete on its branch" determinate enough that step 2 is forbidden or is a departure. At least: no writer is still active on the branch, and the whole result its limit names is at the head the check judges.

### N6 · The closing check, during the overlap, does not ask "have we broken away from the plan?"

1. P1's steps 1 to 3 happen. The executor's task for SB-1's closing check asks only whether the record meets its limit and is cited correctly, on the ground that "the plan step has already moved on".

What the text must do: keep the question at closing whatever the overlap (N-144's condition 4; section 2's sentence on the checker). A task without the question is a departure, or the check does not count as a closing check.

## Boundary cases (offered; point 2 does not list them)

### B1 · The closing check fails while the next step runs

1. P1 happens, and then at T2, while W-Cxx-08 is running, SB-1's closing check returns FAIL (for example: the branch broke away from the plan).

What the text must settle:
- whether W-Cxx-08 goes on, pauses or stops;
- whether the fix on SB-1 is "what the check's conditions require", since a FAIL has findings rather than conditions, or is new work;
- how section 6's loop limit applies.

A "may" text that is silent here leaves the executor's own reading to decide at the worst moment.

### B2 · Another side branch opens during the overlap

1. P1 happens, and then at T2, while SB-1 waits on its check and W-Cxx-08 runs, reasoning proposes SB-9.

What the text must settle: whether SB-9 may open before SB-1 merges. Summary item 2 (B) speaks of being able to close "the branch that was opened" and continue. N-205's deadline ("before the next side branch opens") shows that the item expects this question.

## Which condition each case needs (Break attempt (2))

| N-144's condition, in a "may" text | Case that must turn undecided or permitted when the condition is struck |
|---|---|
| 1. The branch's result is complete on its branch | N5 |
| 2. Only what the check's conditions require is done on the branch | N3 (a), N3 (b) |
| 3. The next step relies neither on the branch's result nor on its rules until the merge | N1 (a), N1 (b) for the result; N2 (a), N2 (b) for the rules |
| 4. The closing check still asks "have we broken away from the plan?" | N6 |
| 5. The log records the overlap | N4 (a); N4 (b) as well, if the text names the record's content |

## Break: each case read against the old section 5 (`560bcab`)

The old section 5 reads: "The branch closes, with its result recorded or cancelled with a reason, before the next plan step starts; the checker asks the same question at closing." It admits two readings, which finding 12 names and which L-200 (its D1) and CHK-C01-042 also named:
- **Reading A:** the branch closes when its result is recorded on the branch.
- **Reading B:** the branch closes when its closing check has passed and it has merged. `CLAUDE.md` supports this reading: "What is not merged into `main` does not exist".

| Case | Under the old text | Decided? |
|---|---|---|
| P1 | Under A, the branch closed at T0, so W-Cxx-08 may start. Under B it has not closed, so W-Cxx-08 may not start. No text says what the log records. | **Left to reading.** |
| N1 (a), (b) | Section 5 is silent on what the next step may use. Under B, the start itself is a breach. Under A, the start is allowed, and only `CLAUDE.md`'s general sentence speaks against relying on an unmerged file or decision. No text says whether this is a departure or how it is recorded. | **Partly decided**: against, through `CLAUDE.md`, not through section 5. Whether it is a departure, and how it is recorded, is not stated. |
| N2 (a) | Section 5 is silent. `CLAUDE.md` points to the merge. Records of the form "takes effect when PC-nn is accepted" point to acceptance, which a PASS verdict gives at T2, before the merge at T3 (L-200: "accepted on CHK-C01-042 and merged"). | **Left to reading** (when a branch's rule takes hold). |
| N2 (b) | Under A, the old section 5 itself allows W-Cxx-08 to start, without SB-5's rule. Under B it forbids the start. | **Left to reading.** |
| N3 (a), (b) | Under A the branch has closed, so the additions are either work on a closed branch or new work without an opening record. Under B the branch is still open and section 5 bounds it only by its limit, but the next step should not be running at all. The merge gate accepts class-normal additions made after the reviewed head. | **Left to reading.** |
| N4 (a), (b) | No text requires an overlap to be recorded. Under A there is no overlap. Under B the overlap is a breach, and no rule says how a breach of section 5 is recorded; L-200 recorded one as a departure because a checker's condition (CHK-C01-042 C1) asked for it. | **Left to reading** (not required). |
| N5 | Under both readings, the branch closes only "with its result recorded", so a branch with an incomplete result has not closed. The case stays open only if "recorded" is read as "a part recorded". | **Decided**, in the main: the next step may not start. |
| N6 | "The checker asks the same question at closing" holds under both readings. | **Decided**: the question is required. |
| B1 | Not addressed. Under A, the branch has closed and its check failed afterwards, which no text foresees. | Left to reading. |
| B2 | Not addressed under either reading. Section 5 does not limit the number of open branches. | Not addressed: the silence permits it. |

**Result.** The old text leaves five cases to the executor's own reading: P1, N2 (a), N2 (b), N3 and N4. Point 2's break therefore holds: if the new text decides them, the change decides them, not a reading. N1 is only partly decided, through `CLAUDE.md` and not section 5. N5 and N6 are already decided by the old text, and a new text must keep them decided: they serve as regression cases.

## What these cases do not cover

- **Whether the executor follows the new text at the next side branch.** That is behavioural. W-C02-16's "Not covered here" names it, and W-C02-18's stage-close sampling covers it.
- **W-C02-16's points 3 to 8.** These are: FR-06 stays a departure; authority and fit; PC-23's time on the critical path; route and judge; deadline; N-209. They are other points of the condition, which its checker judges directly.
- **Whether "may start" or "may not start" is the better direction.** That is the builder's choice (summary item 21, (K)). The cases are neutral between the two directions (see the positive control).
