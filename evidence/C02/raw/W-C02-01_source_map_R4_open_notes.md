# C02 source map R4: open notes

## Disciplines (D1–D9)

D1: yes: I split "carries work to C02" into two groups. Group (a) is notes whose text or deadline places work in C02. Group (b) is notes that only interact with C02 items. I label each note with its group so the frame is visible.
D2: uncertain: the task gave me the list of twenty notes and the search phrases, so I checked the list against the markers myself and read every one of the 102 other open notes in full rather than searching only for the phrases.
D3: yes: I sorted each note by C02 task, with its kind and deadline, so the executor can place it under W-C02-01 item 3. Where a note also affects items 2, 4 or 5, I flag it.
D4: no
D5: yes: I read every note at HEAD and checked what the notes claim against their sources: the pointer targets, PC-16, the Appendix B activation table, Appendix C rows, the guard blobs and git history. Claims that something is absent rest on targeted searches only and are marked as inference.
D6: no
D7: no
D8: yes: HEAD is `796c427`, which equals `origin/main` (L-280). The local `main` ref is stale at `298fc73`, so I read HEAD. No plan, Appendix B, working-order or decisions file has changed since `2999a71` (L-279).
D9: no

The markers agree with the list: there are 122 open markers in `plan/work/*.md`, 20 of them on C02.md (the twenty the task names). C00.md and the W-files have none.

## Work list (W-C02-01): due at or with the work list

- **N-112**, C02.md:60–62. A pointer to **N-111**, C05.md:57–60. Ask: "At this stage's work list, and at each `get_session` reading … compares the Claude Code version". If the version differs, N-111's "Then" applies before work that relies on subagents or role loading.
  - Owner: executor. Deadline: "this stage's close".
  - Kind: a check that stays a note, plus one comparison recorded at the work list. The baseline is 2.1.296 (C05.md:59).
  - Depends on: N-111 and the C01 record EV-C01-008 2.6.
- **N-125**, C02.md:64–66. Ask: "C02's work list says who issues these two and when". These are the `devos_kurulum` token (key_inventory row 21) and the `devos_ci` key (row 22). Section 12 lists neither (plan:1229).
  - Owner: executor. Deadline: "C02's work list".
  - Bears on: tasks 3 and 7. By inference also task 0: `deployment_drift` is run by "the migration job and `devos_ci`" (Ek B:387), and in C02 "the checks of every later pull request run it" (Ek B:390). So the CI key may be needed in C02, not only "for C03".
  - Kind: an executor decision, plus Batu *steps* added through Section 14. They are steps, not decisions of his.
  - Depends on: N-201.
- **N-128**, C02.md:72–78. Ask:
  - item 1: "decides whether the grader's identity and version enter EvalRun's fields here or at C05";
  - item 2: whether "`Review.basis_refs` [is] typed by kind" and whether "`Verdict.result` need[s] `not_applicable`";
  - item 3: not prerequisites of C02.
  - Owner: executor. Deadline: "this stage's work list".
  - Bears on: task 1 (EvalRun, and Review/Verdict/Acceptance are C02 families; Ek B:75, :79).
  - Kind: executor decisions.
  - Depends on: EV-C01-003 (C01 record), N-101 (C07) and N-095 T-74 (C05.md:43).
- **N-207**, C02.md:115–117. Ask: "This stage's work list writes it into the stage-end item's acceptance condition". The scenario must include at least one guard deny path, a merge-gate merge, a records-tool check and a subagent call that loads a role file.
  - Owner: executor. Deadline: "this stage's work list".
  - Bears on: the stage close, and W-C02-01 item 2.
  - Kind: work (the stage-end item).
  - Depends on: EV-C01-028, N-137 (C03) and N-077 (C05).
- **N-208**, C02.md:120–122. Ask: "This stage's work list decides the trigger …, the owner and the work each re-reading comes before, either by widening N-111 … or by its own item".
  - Owner: executor. Deadline: "this stage's work list".
  - Kind: an executor decision.
  - Depends on: N-111 and N-112, and PC-21 item 9.
- **N-074**, C02.md:44–46. No owner is stated. It has three parts:
  - **T-31:** strengthen the conditions CHK-C00-022 F11, F12 and F14 list "before its work starts". By inference, after PC-08 moved criteria 12, 14 and 28 out of C02 (plan:1009), the C02 residue is F12(c): planted filled-but-meaningless records, "caught at a rate written in advance" (CHK-C00-022.md:214). The test should also cover N02's open_exploration rule (CHK-C00-035.md:41: "can wait for T-31").
  - **T-36:** the `contract-first` item, a C02 design comparison of the SQL migrations alone against an extra schema (EV-C00-011:188). N-092 does not carry it.
  - **T-37:** a Finding field. This duplicates N-092 T-37.
  - Kind: T-31 is work through the test designer's conditions; T-36 and T-37 are executor decisions in tasks 1, 2 and 6.
- **N-092**, C02.md:48–58. Its plan text "changed through plan Section 14 at C02's start, with its work list, before its work" (C02.md:57).
  - **T-36:** "C02 confirms and builds" the answer-to-revision binding. Deadline "C02's start". Task 1 (Decision) and task 2.
  - **T-37:** "C02 decides whether Finding needs a field". Deadline "C02's start". Task 1.
  - **T-77:** the outside check of due occurrences. "the expired-claims job in C02, if C02 applies expiry through it". This ties to the claim-expiry choice "chosen in C02 with the tests" (Ek B:410), i.e. tasks 1, 2 and 6. The other parts belong to C04 through C10.
  - Kind: work (a plan change plus builds) and executor decisions.
  - Depends on: N-093 (C03), N-095 (C05) and N-096 (C06). N-136 adds X1 to T-77.
- **N-201**: see the stage-close group below. The work list must also write the "Batu's steps" section and copy the note to C03.md (C02.md:103).

## Task 0 (migration path)

- **N-099 T-65**, C09.md:39 (group a). Ask: "The migration part is PC-16's, before C02 task 0 is accepted."
  - The plan text is already made: PC-16 places 3, 10, 11 and 17 (PC-16.md:78, :275, :299, :494), and Ek B:387 and :390 carry `deployment_drift`.
  - What remains is the build and the ✘ "merged but not applied" condition (plan:1007).
  - Kind: work, already in the plan's text; no new scope.

## Task 1 (Appendix B as SQL)

- **N-031**, C02.md:24–30. Ask: "Re-observe and store the raw output when the raw-evidence store exists (C02)". No owner or deadline is stated.
  - Kind: work or a check. It depends on whether C02 builds a raw-evidence store at all (see the conflict flags).
- **N-064**, C02.md:40–42. Ask: "This stage decides rows R17, R23". R17: EffortPolicy as fields of Work. R23: "whether SessionRecord is an event type; keep LaunchRecord's states" (EV-C00-012:255, :261). No owner or deadline. Neither row is settled by any plan change (my search found none).
  - Kind: an executor decision inside the data-model item.
- **N-094 T-68**, C04.md:66, and **N-096 T-34**, C06.md:41 (group a, met). Both have "before C02" parts that PC-16 place 13 met (PC-16.md:347–394; Ek B:146). The only C02 consequence is in plan text: Relation is built with `method` and `epistemic_status` (PC-16.md:394, "Stages: C02"). No note work remains for C02.
- Also N-128 and N-092 T-36 and T-37 (above).

## Task 2 (`devos_api` functions)

- N-074 T-36 `contract-first` and N-092 T-36 and T-77 (above). No other note.

## Task 3 (identity chain)

- **N-131**, C02.md:80–83. Ask:
  - (1) PC-21 names the design path "before this stage's environment work";
  - (2) weigh keeping the token unreadable by the session;
  - (3) "C02's token design chooses the form and decides row 3's fail path … before task 3";
  - the dated line of 2026-10-12: "names where the non-readability is observed … or records it as a documented, untested residual".
  - Owner: executor (implied). Deadline: "before C02 builds DevOS's environments and the identity chain".
  - Bears on: tasks 3 and 6 (N04, F06) and the Acceptance line on real tokens.
  - Kind: work (a token-design item) plus executor decisions.
  - Depends on: EV-C01-002, FR-05, N-109, N-136 and N-209.

## Tasks 3, 4 and 7 (one note, several items)

- **N-136**, C02.md:85–88.
  - Before task 3: S5, "a network secret of its own environment … custom header without prefix".
  - Task 4: `devos_kurulum` gets a "Cannot" row; role class must match the claim; "a claim without registration is refused"; N04 and N08 run with the `devos_kurulum` token; N17 is extended.
  - Before task 7: the installation's uses of session tools are listed, and the S9 bridge goes into `.claude/settings.json` with a checker verdict, confirmed by a session's own tool list. Batu's task-7 step text carries S5, S6 and S4(d)(e). "C02 says whether [the owned-ID recorder hook] is kept". The plan text changes through Section 14 "before this stage relies on it".
  - Owner: executor. Deadline: "S5 before task 3; the rest before task 7 and before any session runs in the three environments".
  - Kind: work across several items, an executor decision on the hook, and Batu *step* text.
  - Depends on: EV-C01-004, N-131, N-181, N-174, N-137, N-140 and N-092. By inference also N-194.

## Task 5 (format gates and samples)

- **N-032**, C02.md:32–38. Ask: "Structural part (a format gate on effect-channel inventory records): C02/C03". No owner or deadline.
  - Kind: work or a move to C03. Which one is an executor decision.
  - Depends on: N-046 (C05.md:22–24, the behavioural part). By inference also N-065 D36 (C03.md:31).
- Also N-074 T-31's F12(c) sample (above).

## Task 6 (Appendix C tests)

- N-074 T-31 (N02, sampling), N-136 (N04, N08, N17) and N-131 (N04, F06). No separate note.

## Task 7 (the three environments)

- **N-181**, C02.md:90–92. Ask: "Before task 7, C02 states when the confirming list is taken and whether S9's deny covers `ccd_session`".
  - Owner: executor. Deadline: "with N-136, before task 7".
  - Kind: an executor decision.
  - Depends on: N-136, N-137 and EV-C01-020.
- **N-174**, C02.md:94–96. Ask: if any of the three guard files differs, "`tools/test_tool_allowlist.sh` runs again at the commit that will be live".
  - Owner: executor. Deadline: "before C02's task 7, and before any session runs in the three environments".
  - Kind: work (a run). It could be a step of the task-7 item.
  - Depends on: EV-C01-017 and N-136.
- **N-194 / N-200**, C01.md:454–457 and C06.md:124–126 (group b, by inference). The trigger is "the next checked change of the guard or the recorder hook". If C02 changes or drops `.claude/hooks/record_owned_id.py` under N-136, the trigger fires in C02. Final deadline: C06.
- **N-139**, C06.md:74 (group b, by inference). Its configuration record could be "a record made when an environment … is created", and environments are created in task 7. Deadline: C06.
- Related, each with a later deadline: **N-137** (C03.md:73–74; test 3's tool list and N08 with the `devos_kurulum` token), **N-203** (C03.md:112; Batu's question on S1 and S9), **N-140** (C12.md:28; replaces C02's bridge).

## Task 8 and stage close

- **N-127**, C02.md:68–70. Ask: add the X6 and Y7 planted cases with "the next change of `tools/records.py` or `tools/subagent_audit.py`".
  - Owner: executor. Deadline: "before C02 closes at the latest (the ledger moves to the database at C02's end)".
  - Kind: work. It is installation tooling.
  - Depends on: CHK-C01-009 and N-198.
- **N-198** → **N-129**, C02.md:98–100 and C01.md:437–440. Ask: "the executor decides … whether a reason after 'no' is allowed".
  - Deadline: "with N-127's change, and before C02 closes at the latest".
  - Kind: an executor decision.
- **N-205** → **N-144**, C02.md:110–112 and C01.md:399–403. Ask: working order section 5 states how a branch waiting only on its check relates to the next step. "A class-high change … with its own fresh verdict".
  - Deadline: "before the next side branch opens, and before this stage's close at the latest".
  - Kind: work (a rule change).
- **N-209**, C02.md:125–127. Ask: correct plan lines 932, 894, 235, 723, 734, 435, 725 and 1137, Ek B:446 and key_inventory:30. I checked that the cited texts are still present.
  - Deadline: "the next plan change through Section 14, and before this stage's close at the latest".
  - Kind: work (plan text).
- **N-201** → **N-091** (and N-197), C02.md:102–104, C01.md:305–314 and C11.md:48–50. Ask: a "Batu's steps" section on this file, checked at the stage close, and "this stage's work list … carries a copy of this note to the next stage's file".
  - Owner: executor. Deadline: "this stage's close, and each later stage's".
  - Kind: a record practice that stays a note, plus one work-list action.
- **N-202**, C02.md:106–108. Ask: "At or after 2026-10-13T08:40Z, list `devos`'s branches".
  - Deadline: "the first work of this stage at or after 2026-10-13T08:40Z, and in any case before this stage's close".
  - Kind: a check that stays a note. If it shows a run, C01 is reopened and the deletion goes back to Batu.
  - Depends on: W-C01-47, EV-C01-022 and EV-C01-030.

## Flags

**Deadlines that have passed or are ambiguous**
1. **N-092** says "C02's start" (C02.md:53–55). C02 started on 2026-10-12 (C02-log.md:7) and no plan change has been made since (git log). Its plan-text line reads "with its work list, before its work" (C02.md:57). It is ambiguous whether W-C02-02 counts as "its work".
2. **N-127**: by inference, its first trigger has passed twice. `subagent_audit.py` changed at `0204381` and `90bcc4e`, and I found no X6 or Y7 planted case in `tools/test_records_disciplines.py` or `tools/test_subagent_audit.py`. N-127 has no dated line recording this; N-129 does (C01.md:439).
3. **N-094 T-68 and N-096 T-34**: their "before C02" deadlines have passed, but PC-16 met them.
4. **N-131 (1)** still reads "C00's sixth condition stays provisional on N-109". N-109 was closed on 2026-10-11 (C01.md:419), and plan:926 sets out the route. Item (1) may already be met; this is an inference.
5. **N-112** places the comparison "at this stage's work list". But W-C02-02's first role load comes before the work list (C02-log.md:10–11), and N-111's "Then" applies "before any work that relies on … role loading" (C05.md:58).
6. **N-209**: "the next plan change" will be whichever comes first, probably N-092's, N-125's or N-136's.
7. **N-031, N-032 and N-064** state no deadline.
8. **N-174's condition is already met.** The current blobs (`956f1b3`, `62ef9b7`, `d15a872`; git ls-tree) differ from those of the last run (EV-C01-017:463). They changed at `4daf915` and `fdb6824`. So a re-run is needed whatever N-136 does.

**Notes that conflict or overlap**
1. **N-136 against the activation table.** N-136 requires "a claim without registration is refused" in task 4 (S8 line 3 cites SessionRecord; EV-C01-004:193). But SessionRecord activates in C04 (Ek B:90), and so does `register_session` (Ek B:390). EV-C01-004 section 8 (lines 363–376) lists no change to the activation table. This also touches N-064 R23.
2. **N08's stage.** N-136 runs N08 with the `devos_kurulum` token in task 4. Ek C:125 gives N08's stages as C01, C03 and C05, and N-137 (C03.md:73) places the same extension at C03.
3. **Token form.** N-131 says C02's design "chooses the form". N-136 already states it is a network secret ("N-131 decides it"). Plan:1229 and key_inventory rows 18–21 say "settings field"; EV-C01-004 section 8 item 1 names that plan change.
4. **Raw-evidence store.** N-031 assumes it exists in C02. Ek B:80 gives EvidenceEnvelope as database fields only from C04 and C05.
5. **Effect-channel gate.** N-032 places the structural gate at "C02/C03". N-065 D36 (C03.md:31) decides at C03 whether the effect-channel list is "one gate-checked file".
6. **Grader fields.** N-128 item 1 overlaps N-095 T-74 ("fields added by migration before C05 task 4"). The two are consistent.
7. **Session tools.** The N-136 and N-181 bridge denies session tools except those shown to be needed. N-111 and N-112 depend on `get_session`. N-203 (Batu's question) asks C03 for a purpose-based criterion after C02 builds the bridge.
8. **Pointer notes.** If N-208 widens N-111, the pointer notes N-112 to N-121 that copy N-111 verbatim would no longer match it.
9. **T-77 carriers.** T-77's parts for C04 to C10 appear only on C02.md (grep). Closing N-092 in C02 needs the plan change or new carrier notes.
10. **N-128 item 3.** I found no carrier on C05 to C07 for its open points (criterion 33's reading; a balanced comparison set). They need one if N-128 closes at the work list.

**Possible scope growth (asked of C02 but not named in the plan's C02 text; not judged)**
- N-031, N-032 and N-074 (contract-first, Finding field);
- N-092 (revision binding, Finding field, T-77's check);
- N-112, N-125 (steps Section 12 omits), N-127 and N-128 (new fields);
- N-136 (the S9 settings bridge, S8 lines, registration before C04, the N08 extension, X1), N-181 and N-174 (named in PC-21 item 5 in C01's text, not C02's);
- N-198, N-201, N-202, N-205, N-207 (plan 8 item 5 in general), N-208 and N-209.

N-064, N-131 and N-099 sit within C02's own text.

**Notes a C02 item can close outright**
- With a single item or decision: N-064, N-074 (with N-092 T-37), N-125, N-128 (items 1–2; item 3 needs a carrier), N-131, N-181, N-174, N-207, N-208, N-209.
- Together in one change: N-127 + N-198 (closes N-129), and N-205 (closes N-144).
- Possibly N-031.
- Not in C02 by design: N-112 and N-201 recur until the close, N-202 closes by its listing, and N-092 and N-136 only after several items.

## Open

- I did not read EV-C00-001, EV-C01-002, EV-C01-003 or EV-C01-020 in full. I read EV-C01-004 only in its sections 7–9 and S8, CHK-C00-022 only for F11–F14, and C01.md's "Rows and parts that move" table only where grep hit it.
- Outside the notes, for the plan-text maps: P3 and the probe tokens were never created (C01.md:434; key_inventory rows 16–17). So C02's ✔ "probe schema … no longer exist[s]" becomes a check that they are absent. Also, the network-secret form is documented "on Pro and Max plans" (C02.md:81); whether Batu's plan covers it was not checked here.
- Notes I judged to carry nothing to C02: N-033, N-047/N-196, N-085, N-101 (its before-C02 part is done; C01.md:185), N-107, N-138 (related to EvalRun's access rule), N-146 (TaskDefinition comes in C04; Ek B:66), N-169, N-184/N-199 (only if a hand-back report is relied on in C02), and the other notes on C03 to C12.
- For the decision: N-136 against Ek B:90 and :390, and N-174's already-met trigger, may change how items are ordered and how many there are. Everything else fits under tasks 0 to 8 and the work list.
- Guard denials: one. Rule G0 ("readable call", decision log #13626) denied a Bash command with unbalanced backticks. I repeated the search with the Grep tool, as its "What to do instead" says, and did not pursue the denied form. I did not run `tools/guard_report.py`.
