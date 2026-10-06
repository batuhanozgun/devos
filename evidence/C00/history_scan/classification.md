<!-- N-084: the researcher subagent's classification of every match, its final message verbatim, taken with `python3 tools/subagent_audit.py last`; EV-C00-018 -->

**Question.** Sort every library match in the N-084 history scan (`main` at e42257a, plus the 103 commits outside `main`) into classes A to F, so the builder can tell real leaks of library content from harmless overlaps. I classify only; I decide nothing.

**Answer in short.** Two short research-study phrases (class E) reached public history; neither is on `main` now. Four lines of earlier DevOS design text (class D) also sit in history only. Nearly everything else is Batu's own texts (class A, about 98.7% of the matching runs in the current tree), identifiers or boilerplate. One overlap you may want to judge: Appendix D's adaptation of the library's agent protocols (class F). It is not research text, but it is library text in history, and one short phrase of it is still on `main`.

**Method.** I re-ran the guard's normalisation in memory and read only: casefold, Turkish dotless-i fold, accent strip, words, 8-word runs. For each reported line I mapped the matching runs to library files and areas at 941f027 and read the devos line in context. My per-path run counts equal the scanner's for every reported path. Library area keys are as you defined them. "concepts/", "AGENT.md" and "research/" mean the library's top-level folder or file.

## 1. Tables per class

**A. Batu's own writing (all of it is on `main`)**

| Introduced by | Path | Lines | Runs | Area | Repeated by merges | On main |
|---|---|---|---|---|---|---|
| 8cf3f4d | briefs/w-c00-12/BATU_NOVEL_ANALOGY_TR.md | 13 lines, 10–47 | 678 | PUB (3 runs also X) | 42541d5 | yes |
| 9eee086 | …/BATU_TERMINAL_GOALS_TR.md | 14 lines, 7–33 | 709 | PUB (21 also X) | 7200ba0 | yes |
| 8989011 | …/BATU_CONTEXT_ACTIVATION_TR.md | 12 lines, 7–31 | 564 | PUB | 284236f | yes |
| e3cccd7 | …/BATU_SCALE_AND_EXPERTISE_TR.md | 10 lines, 7–29 | 520 | PUB | 03864ec | yes |
| 6efa6c0 | …/BATU_COMMON_FLOOR_TR.md | 118 lines, 7–305 | 610 | PUB | fdf9e3d | yes |
| 4c27d34 | …/BATU_MEMORY_LIFECYCLE_TR.md | 128 lines, 7–362 | 618 | PUB | 9f50fc3 | yes |
| f0ce550 | …/BATU_STORED_IS_NOT_USED_TR.md | 134 lines, 7–318 | 691 | PUB | b738a68 | yes |
| ca2894e | …/BATU_MECHANISM_MAP_TR.md | 96 lines, 13–581 | 514 | PUB | de127aa | yes |
| 0c576ee | …/BATU_LIVING_PLAN_TR.md | 112 lines, 7–635 | 498 | PUB (1 also X) | fea14c1 | yes |
| 6afe396 | …/BATU_INTELLECTUAL_HERITAGE_TR.md | 118 lines, 7–538 | 695 | PUB | 4960ec9 | yes |
| 5ac2d35 | …/BATU_GROWTH_AND_FRAMING_TR.md | 144 lines, 7–593 | 622 | PUB | 45e3677 | yes |
| e482d33 | …/BATU_WORK_DISCOVERY_TR.md | 127 lines, 7–502 | 456 | PUB (11 also X) | 67b743a | yes |
| 333d1b2 | plan/DevOS_Kurulum_Plani.md | 95 | 2 | A | none | yes (now line 1292) |
| 5cf796e | plan/DevOS_Kurulum_Plani.md | 1182 | 2 | A | 8349242 | yes (1292) |
| d97fe51 | plan/Summary_for_Batu_TR.md | 15 | 2 | A | c8e8456, a179d9a | yes |
| tree | 12 BATU files + plan 1292 + Summary 15 | as above | 7179 | | | yes |

- Every run of every `BATU_*` file occurs in one `publications/` analogy file, and no run occurs only outside PUB. The few X hits are conversation transcripts holding the same text.
- Each `BATU_*` file says of itself that Batu had the text written from his own thinking and gave it to the builder.
- The plan and summary lines are the SOUL definition, which devos labels as Batu's decision and "his definition".

**B. Identifiers**

| Introduced by | Path | Lines (runs) | Area | Repeated by merges | On main | Kind |
|---|---|---|---|---|---|---|
| 333d1b2 | README.md | 3 (3) | C, X, research/, README | none | yes | product repository name and URL |
| 333d1b2 | plan/DevOS_Kurulum_Plani.md | 83 (23) | M | none | yes (same list at 91, 1268) | list of 13 old experiment repository names |
| c0007ea | tools/test_tool_allowlist.sh | 20 (1) | S, X | bfa7ae1 (27) | yes (80) | library repository URL in a test |
| aa60009 | briefs/w-c00-12/RUN_BRIEF.md | 55 (4) | concepts/ | b74ab11 | yes (57) | three library router paths |
| 58bd22e | plan/builder/w-c00-12/01_goal_down.md | 70 (4) | A, C, F, S, X, concepts/ | 54353ef | no | study path |
| 03c91f7 | …/02_memory.md | 140 (7) | X, S, A, C, F, concepts/ | 77bad79 | no | study paths |
| 33001df | …/04_roles.md | 105 (1 of 3) | C, S, X | 483ca01 | no | study path |
| f362e95 | 02_memory 155 (7); 04_roles 151, 152 (3); 05_continuity 139 (6); 12_tranche_plan 109, 112, 114 (4 of 6) | as listed | X, S, A, C, F, M, concepts/ | 08459af (156; 152, 153; 139; 191, 194, 196) | no | study paths, plus one study's status label (04_roles 152) |
| 3c297a6 | evidence/C00/reviews/R-W12-2.md | 151 (4) | S, M | 5bba836, 9235d7e | yes | one library evidence path, used as a test case |
| 4c5caae | plan/builder/w-c00-12/11_test_register.md | 144 (4) | S, M | 469f102 | no | same path |
| aee4fec | tools/test_check_records.py | 471 (4) | S, M | 58f16bb (487) | no | same path |
| a11a3a8 | tools/__pycache__/test_check_records.cpython-311.pyc | 177 (4) | S, M | none (deleted in d6dea29 before any merge) | no | same path, inside committed bytecode |
| 4776276 | plan/decisions/FR-02.md | 11 (3) | C, S, X | eb556b5; outside 92332c8 | yes (12) | study path |
| 889cb68 | tools/test_tool_allowlist.sh | 60 (1), 249 (1) | S, X; S | be797c6 (60, 669); outside c40af71 (78, 687) | yes (80, 689) | library repository URL; public Claude Code docs URL |
| 5cf796e | plan/DevOS_Kurulum_Plani.md | 86, 1158 (46) | M | 8349242 (84, 1158) | yes (91, 1268) | repository name list |
| 5cf796e | plan/Ek_D_Dusunme_Protokolleri.md | 256 (1) | P | 8349242 (254) | yes (257) | list of epistemic-status labels |
| 8687382 | evidence/C00/EV-C00-011_ecc_comparison.md | 113 (2) | S | 8349242 | yes (120) | module names of the external project compared |
| 3bb2360 | same file | 120 (2) | S | 32bd875, efa8d9a, a179d9a | yes | same |
| 5223552 | tools/test_tool_allowlist.sh | 800, 802, 803 (7) | X | edb0097 (847, 849, 850) | yes (859, 861, 862) | a clone command for the library URL, as test cases |
| tree | README 3; RUN_BRIEF 57; EV-C00-011 120; R-W12-2 151; plan 91, 1268; Ek_D 257; FR-02 12; test_tool_allowlist 80, 689, 859, 861, 862 | 72 runs | | | yes | |
| outside 2f9751a | .claude/agents/researcher.md | 11 (4) | concepts/ | none | no | router paths |
| outside a1f421b | plan/decisions/FR-01.md | 11 (12) | C, X, F, S | none | no | two study file paths |
| outside ac374a1 | evidence/C00/reviews/R-W12-2.md | 151 (4) | S, M | none | same line is on main via 3c297a6 | evidence path |
| outside db06c26 | evidence/C00/tests/1c_gate.md | 58 (1) | S, X | none | no | library URL |
| outside fb0ed2d | plan/builder/design/02_memory 147 (7); 04_roles 152, 153 (3); 05_continuity 142 (6) | as listed | X, S, C, M, A, F, concepts/ | none | no | the f362e95 paths after a file move |

**C. Generic code or boilerplate**

| Introduced by | Path: lines (runs) | Area | Repeated by merges | On main |
|---|---|---|---|---|
| 5724ff9 | evidence/C00/tests/1b-i_migrate.py: 12 (1); tools/test_records.py: 11, 30, 225 (4) | S | 83efa86 (test_records 11, 30, 244) | migrate yes; test_records no |
| aee4fec | tools/check_records.py: 33, 35 (3); tools/test_check_records.py: 14, 16, 76 (5) | S | 58f16bb | no |
| 889cb68 | tools/check_records.py: 1503 (1); tools/sync_worktree.sh: 10 (1) | X | be797c6; outside c40af71 (1596, 10) | sync yes; check_records no |
| 889cb68 + 61e03ae together | tools/guard_report.py: 17 (1) | S | be797c6; outside c40af71 | yes |
| dbb24b5 | tools/merge_gate.py: 123 (1); tools/test_merge_gate.py: 66 (2) | X; S | 22d1b54 (146, 80) | yes (146, 83) |
| 5223552 | tools/leak_fingerprints.py: 21, 35 (4); tools/test_tool_allowlist.sh: 830 (3) | S, D | edb0097 (877) | yes (31, 49; 889) |
| 5f8c5ea | tools/test_leak_fingerprints.py: 70, 224 (4) | S, D | e42257a | yes |
| tree | 1b-i_migrate 12; guard_report 17; leak_fingerprints 31, 49; merge_gate 146; sync_worktree 10; test_leak_fingerprints 70, 224; test_merge_gate 83; test_tool_allowlist 889 (17 runs) | | | yes |
| outside 2fdd4b7, 510a1a6, 98b2090, c6cca70, db6d203 | test_tool_allowlist 780 (5); test_1c.py 142, 143 (6); test_1c.py 11 (2); .claude/hooks/tool_allowlist.py 160 (1); test_tool_allowlist 138 (5) | S, D | outside merge c40af71 (734) repeats db6d203 | no |

The kinds are Python import lists, the standard idiom for loading a module from a file path, `subprocess.run` keyword arguments, a `mkdir` call with its usual flags, and a git fetch refspec for origin/main.

**D. DevOS design text that the library also holds (none of it is on `main`)**

| Introduced by | Path | Lines | Runs | Area | Merges | On main |
|---|---|---|---|---|---|---|
| 333d1b2 | plan/DevOS_Kurulum_Plani.md (Turkish v2.1) | 634 | 3 | M | none | no. An English rendering of the row is at plan line 697, with no 8-word match. |
| 333d1b2 | plan/Ek_A_Rol_Sozlesmeleri.md (Turkish) | 43, 371, 377 | 6 + 2 + 2 | A | none | no. Appendix A is now English, with no match. |

**E. Library research content (none of it is on `main`)**

| Introduced by | Path | Line | Runs | Area | Merges | On main |
|---|---|---|---|---|---|---|
| 33001df | plan/builder/w-c00-12/04_roles.md | 105 | 2 (its third run is a path, class B) | S | 483ca01 | no (`plan/builder/` is gone from main) |
| f362e95 | plan/builder/w-c00-12/12_tranche_plan.md | 110 | 2 | S | none directly | no |
| 0616482 | same file (the same phrase, re-added in an edit) | 192 | 2 | S | 08459af (192) | no |

**F. Other: library control-file and agent-protocol wording**

| Introduced by | Path: lines (runs) | Area | Merges | On main |
|---|---|---|---|---|
| 333d1b2 | plan/Ek_D_Dusunme_Protokolleri.md (Turkish v1.1): 124, 129, 133, 155, 158, 189, 218, 219, 229, 233 (25) | P | none | no |
| 5cf796e | Ek_D: 66 (2) | AGENT.md | 8349242 (64) | yes (65) |
| 4fec306 | evidence/C00/checks/CHK-C00-017.md: 52 (2) | AGENT.md | 8349242 | yes |
| 96220c7 | Ek_D: 65 (2); plan/decisions/PC-08.md: 2278, 2289 (4) | AGENT.md | d4630ef | yes |
| tree | Ek_D 65; PC-08 2278, 2289; CHK-C00-017 52 (8 runs) | AGENT.md | | yes |

**Service-name counts (listed only, as asked)**
- **Main, non-merge commits:** a58413a 1, 3cd686a 1, 33b5043 6, c0007ea 2, 05ba7c9 1, 9b4f17c 1, 8687382 2, 3bb2360 1, 6598f32 1.
- **Main, merges:** 15f2927 1, 07d8e50 1, 8349242 2, 32bd875 1, efa8d9a 1, a179d9a 1, bd77c52 1.
- **Outside main:** ce600a3 1, fbb027b 3.

## 2. Totals

An introduction is a non-merge commit, or the current tree. A commit can introduce items of several classes (333d1b2 has A, B, D and F).

| Class | Main introductions | Merges repeating them | Outside introductions | Tree runs |
|---|---|---|---|---|
| A | 15 + tree | 15 | 0 | 7179 |
| B | 17 + tree | 17 | 5 (+1 merge, 92332c8, and part of c40af71) | 72 |
| C | 6 + tree, plus one import line built across 889cb68 and 61e03ae | 6 | 5 (+ part of c40af71) | 17 |
| D | 1 (333d1b2, 4 lines) | 0 | 0 | 0 |
| E | 3 (two distinct phrases) | 2 | 0 | 0 |
| F | 4 + tree | 2 | 0 | 8 |

- The scan's own numbers check out: 36 non-merge plus 34 merges gives its 70 matching commits on `main`, and 10 plus 2 gives its 12 outside.
- Tree runs add up to its 7276.

## 3. What the class D and E items are

- **D, plan line 634 (333d1b2):** one row of plan v2.1's table that gives each source a status. This row covers an exploration note and the condition for opening work from it. The library's maintenance request (M) reproduces the plan's tables.
- **D, Appendix A lines 43, 371, 377 (333d1b2):** three Turkish role-contract sentences. They cover the gap between someone's intent and a sufficient work definition, the limits of what a researcher role can establish, and the verifier's task of judging whether a claim is supported. The library keeps them in an archived pre-Claude DevOS report (A). Plan v2.1's source table says valid parts of that report were carried into the appendices.
- **E, 04_roles line 105:** a short quoted result criterion from a library study that assesses multi-agent designs for SOUL and DevOS.
- **E, 12_tranche_plan lines 110 and 192:** a one-clause control-design principle, about which component may write control state, from a library study of an external AI-native software-lifecycle playbook.
- **F, for comparison:** Appendix D v1.1 lists the library's `AGENT.md` and its nine agent protocols as its sources, and adapted their Turkish wording. Only one sentence of it is still on `main`. It is a rule about what to do when a required protocol file cannot be read, and its English wording shares about 9 words with the library's `AGENT.md`.

## 4. Unclassified

None. Two items needed explanation:
- **`guard_report.py:17`:** no single commit introduces it. 889cb68 added four imports and 61e03ae later inserted a fifth, so the 8-word run only exists once both are present. Only the merges be797c6 and c40af71, and the tree, show it.
- **The `.pyc` file:** a11a3a8 committed a compiled bytecode file that holds the evidence path from the test. d6dea29 deleted it before any merge, so it exists only in history.

## Counter-evidence and alternatives

- **SOUL definition:** it could be filed as D, since the archived pre-Claude report (A) also holds it. I chose A because devos labels it Batu's decision.
- **Class F:** this is library text, not research, and Appendix D v1.1 declares the adaptation openly. A stricter reading could treat the 25 Turkish runs in 333d1b2 as a library-text leak, in history only.
- **Status labels:** I put one study's status label (04_roles 152/153) and the list of epistemic-status labels (Ek_D 257) in B. A stricter reader might call them content.
- **What the scan cannot see:** it only catches verbatim runs. Paraphrased summaries of study findings, such as FR-02 line 12's consulted-sources entry or the deleted source list in 12_tranche_plan, are outside its reach by design.

## Open

- I read the library only to locate matches. The exceptions were one line of `AGENT.md` and the top and one row of the maintenance request.
- Library areas are the union of every file holding a run.
- A run that spans lines added by different commits and was deleted before any merge would show nowhere in either report. I found no sign of one but cannot rule it out.

## For the decision

- No class D or E text is on `main`.
- Real research content in public history is limited to two short phrases: 33001df, f362e95 and 0616482, repeated by merges 483ca01 and 08459af.
- Whether those, or the Appendix D adaptation in 333d1b2, warrant any action beyond recording them is your decision; the findings do not settle it.

## Guard denials

None.

Inputs used:
- /tmp/claude-0/-home-user-devos/1ffeb509-6a85-5fdc-9f2f-cbf44d117c09/scratchpad/stage/history_main.txt
- /tmp/claude-0/-home-user-devos/1ffeb509-6a85-5fdc-9f2f-cbf44d117c09/scratchpad/stage/history_outside.txt
- /tmp/claude-0/-home-user-devos/1ffeb509-6a85-5fdc-9f2f-cbf44d117c09/scratchpad/w12
