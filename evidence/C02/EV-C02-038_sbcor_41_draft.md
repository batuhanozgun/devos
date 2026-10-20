---
id: EV-C02-038
title: "SB-COR 4.1: the researcher's draft of one line per W-C00-12 sub-point, the EV-C00-012 L10 state and the C05 note, with its comparison to 4.1's summary"
stage: C02
kind: observation
source: "researcher a738e84458e67d309: its report, taken with tools/subagent_audit.py last (DISCIPLINES OK), filed verbatim; its one library path replaced by the library ID"
---

# EV-C02-038 · SB-COR 4.1, the researcher's draft

Filed by the executor for SB-COR step 4.1 (the researcher drafts; the executor files; 4.5's checker judges). The lines under "Findings" are copied by script onto `plan/work/W-C00-12.md` ("SB-COR 4.1 dispositions"), without their "4.1:" comparison bullets, which stay here.

Package: researcher@bfb9d1e8e5e9
Nonce: 04fb0e2de875cd79
Take-up: PROCEED. The task holds: plan step 4.1 needs these lines drafted, and the draft can be checked against the merged records. Depth: a primary-source check of the repository records at `main` aec4d29c2cb8 (HEAD equals origin/main), plus one library check. The question is about what the repository holds. The library bears only where a line cites it, and only EXP-001 L12 does.

## Disciplines (D1–D9)
D1: yes: I kept "carried by this correction" apart from "carried earlier by other work", because 4.1 blurs the two for (a2), (h) and part of (l), and I say so on each line.
D2: yes: I treated 4.1's summary as a claim to test against the records, not as the expected answer, and I report every place where it does not hold.
D3: yes: I separated merged from accepted for every carrier, and I flag (f) as a forward claim, because 4.5 has not happened yet.
D4: yes: I separated a one-time acceptance check (the floor diff) from the standing mechanical check that W-C00-12 (k) and (l) ask for, and passing tests at merge from acceptance.
D5: yes: I read item front matter, ledger entries and file lines directly, found the front matter out of step with the log, and cite merges by PR and log entry rather than by item state.
D6: no
D7: yes: each line cites a file and line at aec4d29, so the executor and the closing checker can rebuild it without this session.
D8: yes: I confirmed HEAD = origin/main = aec4d29 and read L-452 to L-459, plus the merge of #441, which came after L-459.
D9: yes: I read EXP-001 L12, which 4.1 cites. It limited how the (m) line may use it. I did not read `research/INDEX.md`, because the only library point needed was the cited file.

Read, and what each changed:
- `/home/user/devos/plan/work/W-C00-12.md` (all): this set the sub-points and their order. Acceptance block lines 23–25.
- `/home/user/devos/plan/SB-COR_Correction_Plan.md` lines 7–56, 85, 100–145, 150–230: the standard (4.1 at line 174) and the steps it cites. Lines 57–84 were not read in full, which limits the (b) line.
- `/home/user/devos/plan/ledger/C02-log.md` L-456, L-457, L-459 in full, and the headings of L-450 to L-458: what is merged and what is not yet accepted.
- git log of aec4d29 (#441 holds c7537c5, 640b1f1 and 4ea502b): the liveness fix is merged, with no log entry yet.
- Front matter of W-C02-22, -23, -24, -24.1, -25, -27, -29 and the W-C00-12 children: states. This turned up a discrepancy, reported below.
- `/home/user/devos/plan/Installation_Working_Order.md` lines 24–74, 125–145, 190–205: carriers for (c), (i), (k) and the task template.
- `/home/user/devos/plan/decisions/PC-53.md` (front matter; lines 98, 391, 403): PC-53 is `status: proposed`. Its scope adaptation is at line 391.
- `/home/user/devos/plan/decisions/PC-52.md` front matter: accepted on CHK-C02-119, before SB-COR. This changed the (h) line.
- `/home/user/devos/evidence/C00/EV-C00-012_counter_design_comparison.md` lines 30, 58, 128–137, 268–280: row L10 and its section-5 line 276.
- `/home/user/devos/plan/work/C05.md` lines 20–30 and 107: N-067 already carries L10. This shaped the note draft.
- `/home/user/devos/plan/work/W-C02-22.md` (grep): the floor check A-CL-FLOOR (line 38) is a one-time acceptance check. This changed the (k) and (l) lines.
- `/home/user/devos/tools/merge_gate.py` lines 65–66, 81, 97, and `/home/user/devos/tools/records.py` lines 121–162 and 403–420, plus their git history: there is no standing floor check, and records.py dates from 2026-10-03 (5724ff9).
- `/home/user/devos/.claude/settings.json` lines 141–179, and the role files' and packages' line numbers.
- `/home/user/devos/plan/decisions/D-040.md` line 31 (20:20Z): justified the "not carried" reason given for (k) and (l).
- `/home/user/devos/evidence/C02/checks/CHK-C02-121.md` and `CHK-C02-122.md` front matter: carriers for (d).
- Library `[library id: EXP-001, reflections LEARNINGS]` lines 129–137 (HEAD 941f027): limited the (m) line.
- `/home/user/devos/plan/Ek_D_Dusunme_Protokolleri.md` section 3 and D2 to D5.
- Deliberately not read: the retired `plan/builder/w-c00-12/` files (history at 676a116), the briefs, and the remaining text of the EV-C02 records.

Relied on:
- W-C00-12's sub-points and their order: W-C00-12.md:24 (stated).
- 4.1's mapping: SB-COR plan :174 (stated).
- A4 :12, A6 :14, 1.1 :85, 2.1 :98, 2.2 :100–109, 2.4 :111, 2.5 :113, 2.6 :115–121, 2.7 :123, 2.8 :125, 2.3 :136, 3.1 :142–145, 3.3 :153, 3.7 :165, 4.5 :182 (stated).
- Merges: W-C02-22 (PR-A1) merged, finished, not accepted, PC-53 proposed: W-C02-22.md front matter, ledger.md:49 and :180, PC-53 front matter (observed). W-C02-23 accepted: CHK-C02-133 (observed). W-C02-24 M1a #429 and M1b #433, not accepted while CHK-C02-143 C1 stands: L-454, L-456 (stated). W-C02-25 #437 and the liveness fix #441 with CHK-C02-150 PASS; acceptance not yet recorded: L-458, L-459, git (observed). W-C02-27 #439, not accepted (platform rows): L-459 (stated). W-C02-24.1 not merged; its producer was running at L-459 (stated).
- Team triage including the "no team round needed" result: working order :28 and :47 (observed).
- Approach block with `library:`: working order :131–144 (observed).
- Task template's Item, Purpose and Consumer fields: working order :193–197 (observed).
- The discipline trigger covers work items or tasks, material changes and waits, but not proposals or conversation: working order :30 and CLAUDE.md (observed).
- Floor in CLAUDE.md :21 onward, three lines at :17–19 (observed). Its diff against Ek D runs only in W-C02-22's acceptance (W-C02-22.md:38). No `tools/` script compares it standing (grep, observed). Both files are class high: merge_gate.py:65–66 (observed).
- Start, stop and SessionStart hooks: settings.json :141–179 (observed).
- Known failure classes in the packages: researcher :14, checker :16, prober :16, producer :27, test-designer :20 (observed).
- Scope: PC-53:391 and working order :27 (observed).
- records.py staleness (:130–162) and frontier (:403–420), added 2026-10-03 by W-C00-12 tranche 1b-i (W-C00-12.2, accepted) (observed).
- PC-52 accepted on CHK-C02-119, and SB-COR 4.3 lists it as untouched (observed).
- L10 row and its line: EV-C00-012:137 and :276 (observed).
- C05 N-067 already says C05 decides L10: C05.md:26–28 (observed).
- L-426 departure (2) is (i) and (j) dropped without a disposition: C02-log.md:1479 (observed).
- EXP-001 L12's point, in my words: a mechanism view lets you study the ideal flow; it does not show or guarantee real execution; and the view itself is counted as a gain (interpreted).

Unsure:
- Git order showing each part's condition merged before its build's first commit (1.1's "Done"): I rely on the ledger and did not check the order myself. Running `git log --first-parent` per path would settle it.
- Whether SB-COR anywhere takes up OI-011: lines 57–84 were not read in full. A grep for "OI-011" in the plan would settle it.
- Whether EV-C00-012 is edited in place or annotated: that is a records-format call for the executor.
- The next free note number: I saw N-316 as the highest. `records.py` assigns numbers.
- W-C02-25's acceptance after #441 and W-C02-24's after W-C02-24.1 may change before the records PR. Each line below carries its state as of aec4d29.

For: the executor, who files these lines in step 4.1's records pull request, and the branch's closing checker (step 4.5), who judges them against W-C00-12's sub-points and the merged records.

Received from / Returned to:
- Received the task from main (the executor). Returned nothing.
- Outside my scope, for the executor (not done): W-C02-24, -25 and -27 still say `execution: planned` in their front matter, while L-456 and L-459 record their builds as merged and execution finished. The generated ledger section 2 therefore shows W-C02-24 as "ready" (ledger.md:182) and W-C02-24.1 as waiting on W-C02-25 "not finished" (ledger.md:50), while W-C02-24.1's producer is already running.
- Also for the executor: #441 (the liveness fix, CHK-C02-150 PASS) merged after L-459 with no log entry yet.

Product:

Question: draft one line per W-C00-12 sub-point, in its own order, for SB-COR step 4.1's records PR. Each line says where this correction carried the sub-point, partly carried it, or why it did not, cited at `main` aec4d29, and says whether 4.1's summary holds. Also draft the EV-C00-012 L10 state line and the C05 note. Decision served: what the executor files and the closing checker judges. W-C00-12's acceptance block stays byte-identical; nothing below touches it.

Findings (the draft lines, in W-C00-12's order; "4.1:" marks how each compares with 4.1's summary):

(a) Not carried. D-010 replaced the redesign with the working order (W-C00-12.md:17), and SB-COR is a correction inside the existing plan, not a goal-down look over C00 to C12 (SB-COR A1–A3, :9–11). Its premises section B (:16–29) records the uncertainties that could change this correction's design, for its own scope only.
- 4.1: no summary given; consistent.

(a2) Partly carried, mostly before this correction. W-C00-12's own tranche 1b-i (W-C00-12.2, accepted) built `tools/records.py`: `depends_on` (:121), staleness (:130–162), the startable frontier (:403–420), and the item front matter that separates admission and execution from acceptance (working order section 9, :127). This correction adds that every task names its item (the parent), its Purpose and its Consumer (the downstream effect): working order section 9 :193–197 (SB-COR 2.4; W-C02-22, merged, not accepted). Not carried: zoom; siblings in every task (the `Teammates:` line lists co-working agent IDs, not sibling items).
- 4.1: holds in substance, but the frontier and item format are not this correction's work (records.py dates from 2026-10-03, 5724ff9). The line should say "before this correction" and name 2.4 as what SB-COR adds.

(b) Not carried by this correction. The OI-011 inputs keep the dispositions they had before the cancellation: notes N-008 to N-025 on W-C00-12 (answered; N-021 closed), which point to the retired dispositions file (history at 676a116; W-C00-12.md:17). SB-COR does not re-disposition them, even where one touches its mechanisms (item 20 (a), per-agent tool lists, now 2.2 (6) and T4/T6).
- 4.1: no summary given; consistent, subject to the OI-011 grep under Unsure.

(c) Carried for the rules this correction adds: SB-COR A6 (:14) and PC-53 "Two adaptations" item (2) (PC-53:391; status proposed) state their scope as the installation, handed over at C05. The general statement is older: working order section 2 :27. PC-53's protected-passage and change lists name the files. Not carried: a per-rule scope (installation, DevOS or SOUL) with its file for every installation rule.
- 4.1: "by A6 and PC-53" holds only if narrowed to this correction's rules. Suggested wording: "partly: for the rules this correction adds".

(d) Partly. An outside review of the design for purpose and robustness before its build: CHK-C02-121 (PASS-WITH-CONDITIONS at 74419690) and CHK-C02-122 (scoped re-review at 6782f774), by non-participant checkers (SB-COR 0.5). The branch's closing check (4.5, :182) is still to come. Not carried: a clean-session counter-design of this correction with every difference closed. SB-COR took up one row (L10) of the C00 counter-design (EV-C00-010) through EV-C00-012 (A4, :12).
- 4.1: no summary given.

(e) Carried by 1.1 (:85) for the parts merged at aec4d29. Each part's condition and tests were merged before its build and were green at its merge verdict:
- W-C02-22: `tests/C02/W-C02-22/check.py` and `breaks.py`
- W-C02-23: `tools/check_role_packages.py`, CHK-C02-133
- W-C02-24: CHK-C02-141 and -143 (L-454, L-456)
- W-C02-25: conditions #426 (L-453), CHK-C02-145 and -146, liveness cases L7 and L8 with CHK-C02-150 (#441)
- W-C02-27: #427 (L-453), CHK-C02-149

W-C02-24.1 is not merged. W-C02-22, -24, -25 and -27 are merged but not accepted.
- 4.1: holds. The line should add "for merged parts; W-C02-24.1 pending" and "passes at merge, not accepted".

(f) Not yet carried. 4.5 (:182) ends with Batu told in about ten Turkish sentences, as information; that is not on `main`. "Decisions only where they are his": SB-COR section F (:198) asks him nothing (the standing CLAUDE.md Batu rule is older).
- 4.1: "by 4.5" is a forward claim, since 4.1 is filed before 4.5. The line should say "to be carried by 4.5; not on main at <sha>", or be completed at the close.

(g) Partly, and not by what 4.1 names. The tie between roles and goals sits in each role file's single success direction (`.claude/agents/*.md` line 14, kept verbatim by 2.2's "Unchanged" clause, :108), in the field owners of working order section 4 step 1a (:28; 2.5 (c)), and in the consumer table (working order section 4, "Every output has a consumer"; 2.8). Not built: a per-work-type map of terminal goals and of which may share a role.
- 4.1: "partly by records.py's frontier and the item format" does not hold for (g). Those carry (a2)'s work list, not a role-and-goal map.

Trailing sentence 1 (no item accepted by its own producer). Carried. Working order section 4 step 4 (a checker that did not produce the result) is older. This correction strengthens it with the checker's binding exclusion of producers, proposers and triage participants (2.2 (7); PC-53:98; checker.md), and with the merge gate's `item:` and `producer_run` keys (M1b, #433, L-456). The confirmation duty for `producer_run` is W-C02-24.1, not merged.
- 4.1: no summary given.

Trailing sentence 2 (every builder role traced to a demonstrated demand, or removed). Partly. D-010 removed the dispatcher and the heartbeat (W-C00-12.md:17). This correction adds no role (A3, :11). From M1a (#429, L-454; working order :27), T4 and TW admit only the five role types: `general-purpose`, the no-type default and the Workflow tool are out, each with its reason, and the counter-designer is denied until C05 (3.1, :145). Each role's call triggers are in its `description:` (2.2 (1)). Not carried: a record that traces each of the five roles to a demonstrated work demand.
- 4.1: no summary given.

(h) Partly. Before this correction, PC-52 (accepted, CHK-C02-119; SB-LIB) gave every task a library line and D9 answers against the role maps. This correction adds the hand-over's "Read, and what each changed" (including what was deliberately not read) and "Relied on" (2.2 (4); each role file's Output list, e.g. researcher.md :58), and the approach block's `library:` use receipt (working order section 9 :131–144; 2.7). Not carried: each source's status as a required field of every major decision.
- 4.1: "partly by PC-52" holds as "partly", but PC-52 predates SB-COR (4.3 lists it as untouched). The line should name 2.2 (4) and 2.7 as this correction's carriers.

(i) Carried by 2.5 (c) and 2.7: the team triage of working order section 4 step 1a (:28), where the field owner decides and "no team round needed, because …" is a valid result (:47); the approach block (:131–144). The "not by the producer" half also stands in each role's take-up triage (2.2 (2); role files :20/:22) and the checker's triage, where "little or no checking" is valid (2.6 (a); checker.md :27). T5 (M1a, #429) denies a producer task without the approach. W-C02-22 is merged, not accepted.
- 4.1: holds. Adding 2.2 (2) and 2.6 (a) makes the line complete. With (j), it closes L-426 departure (2) (C02-log.md:1479).

(j) Carried by 2.2, 2.3 and 3.3.
- Purpose, sources and methods: the role files (success direction :14, knowledge map, procedure).
- Known failure patterns with recorded cases: the packages `.claude/roles/*.md` (researcher :14, checker :16, prober :16, producer :27, test-designer :20; W-C02-23 accepted, CHK-C02-133).
- Seeing them at boot: 3.3's start hook (`.claude/settings.json` :161–167; the executor's package through SessionStart, :141–155). W-C02-25 is merged (#437), rows (i) to (iv) recorded (L-459), liveness fix merged (#441); its acceptance is not yet recorded.
- 4.1: "by 2.2, 2.3" holds but leaves out 3.3, which is what carries "at boot". Without it the line would rest the boot half on files a run need not read.

(k) Partly.
- Carried: the purpose chain in every task (2.4; working order :195); the common floor (2.1; CLAUDE.md :21 onward, verbatim with listed substitutions, as a kept restatement); the known failure patterns as heritage (2.3), and builder-started runs formed with it at start (3.3). D1–D9 is older (D-016; working order :30).
- Not carried: the planted out-of-specialty test per role and the Actor A against Actor B test (D-040 at 20:20Z: use is answered by mechanisms, not tests; plan 7.3 at plan :809, and C05, keep the exams).
- Not carried: the long-session quality mechanism with its own test. The nearest carriers, re-reading the package after compaction (2.2 (5)) and the researcher's interruption rule (PC-53:403), have no quality test.
- Not carried: the discipline trigger for proposals and conversation. The trigger covers tasks, material changes and waits (working order :30).
- The floor's comparison with Ek D is a one-time acceptance check (W-C02-22.md:38, A-CL-FLOOR), not a standing one. Both files are class high in the merge gate (merge_gate.py:65–66).
- 4.1: holds for what it names, but it leaves out three sub-parts: the long-session test (not carried), the trigger for proposals and conversation (not carried), and builder-started sessions' heritage (carried by 3.3). The line should name all three.

(l) Partly by 2.1 and 3.3.
- 2.1: the floor in CLAUDE.md under (l)'s kept-restatement rule, with a diff at W-C02-22's acceptance (one-time, not standing).
- 3.3: the package placed in each run's context at start, with a nonce receipt. This shows delivery, not use (3.3's own claim limit).
- Older carriers, not this correction's: generated restatements (`DURUM.md` and the ledger's generated blocks by `records.py render`) and change kinds on every log entry's "Record changes" line (W-C00-12.2 and .3, accepted).
- Not carried: the fresh-session use test and the chain-intact check, for the same reason as (k).
- 4.1: holds. The line should say the floor diff is one-time and keep the older carriers apart.

(m) Its substance by phases 2 and 3: the critical-path arrows made mechanical.
- T5 before every producer task; the merge gate's verdict forms, `writes:` and revert route (W-C02-24: #429, #433).
- The registry, start and stop hooks and liveness (W-C02-25: #437, #441).
- T6 on `SendMessage` (W-C02-27: #439).
- The working order's consumer table, each row with its gate or "none" (2.8).

The map itself was not built, nor its coverage rows per component.
- 4.1: holds. Citation check of EXP-001 L12 (library LEARNINGS.md:129–135): the lesson supports "a map shows the ideal and does not make it real". It also counts the view as a gain, so it is not a reason against a map. The not-building rests on the mechanisms' priority; L12 is consistent with that but does not ground it.

EV-C00-012 row L10, state draft (for the table cell at :137 and the line at :276):
"L10: taken up for the installation's helpers by SB-COR (2026-10-20). The package is delivered at every role start by the SubagentStart hook with its hash and a nonce, and the SubagentStop hook checks the receipt (W-C02-25, #437, liveness fix #441). The counter-design's launch-denying stamp was not built; it stays only as SB-COR 3.7's last fallback. Open: C05 for DevOS's own roles (`plan/work/C05.md` N-067)."
If evidence records are not edited in place, file this as a dated annotation under :276 instead.

`plan/work/C05.md` note draft (an annotation to N-067, which already names L10; or a new note):
"SB-COR (`plan/SB-COR_Correction_Plan.md` A4, 4.1) took up EV-C00-012 row L10 for the installation's helpers only, by start-hook delivery with a receipt (W-C02-25), not by a launch-denying stamp. This stage still decides L10 for DevOS's own roles (plan 6.12 item 3), with that result as one input; the helpers' mechanism is an installation rule, removed or handed over here (working order section 2)."

Counter-evidence and alternatives:
- 4.1's grouping "(a2), (g) partly by …" could be read as attaching the frontier and item format to (a2) alone, with (g) left unstated. Either way, a separate (g) line is needed.
- "Carried" could mean "by anything on main" rather than "by this correction". 4.1's own wording ("where this correction carried it") supports the narrower reading I used. Under the wider reading, (a2) and (h) would read as carried more fully.
- (c) can be read as satisfied, because A6 states the scope of every rule in this correction.

For the decision: the draft changes 4.1's summary in seven places.
- (a2) and (h): name SB-COR's own carriers (2.4; 2.2 (4) and 2.7) and mark the older ones as older.
- (c): narrow it to this correction's rules.
- (f): forward claim, not on `main`.
- (g): not carried by the frontier or item format.
- (j): add 3.3.
- (k): add its three missing sub-parts.

It confirms (i), (l), (m) and (e) as written, with (e) limited to merged parts and every carrier marked merged versus accepted. Lines for (a), (b), (d) and the two trailing sentences are drafted above.

Guard denials: none.
