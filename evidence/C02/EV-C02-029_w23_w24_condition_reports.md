---
id: EV-C02-029
title: "The test designers' reports for W-C02-23's and W-C02-24's acceptance conditions (EV-C02-028 part 10's approaches written as conditions and tests)"
stage: C02
kind: observation
source: "the test designers a0004abfedb986b57 (W-C02-23) and a62f5e18d8d76772e (W-C02-24), their final messages taken with tools/subagent_audit.py last after their end status; DISCIPLINES OK for both"
---

# EV-C02-029 · W-C02-23 and W-C02-24: the test designers' reports

Filed by the executor (L-445), verbatim, so that the binding checkers of the two conditions (CHK-C02-130, CHK-C02-131) and the producers can read the hand-overs, the pinned interfaces and the doubts each designer left. Nothing is withheld: neither report quotes the common floor's heading or a library path (checked before filing), and both cite the library by name and section only. Each report's file list names its clone and branch: W-C02-23's head is `a2af2479da9ac5189aec8831e15bc05dc369d480` (branch `claude/c02-w23-acceptance`), W-C02-24's head is `a3c208c6d2483756f45e0d969eaabb68e42c8ebf` (branch `claude/c02-w24-acceptance`, the executor's commit of the designer's three files, with the approach block pasted by tool from EV-C02-028 part 10.2 and the rendered views).

The executor's reading of the two runs for W-C02-22 point 10 is in L-445, not here.

## 1. W-C02-23's test designer (`a0004abfedb986b57`), its final message

Package: none delivered (file absent)
Nonce: none delivered
Take-up: PROCEED. Approach version 2 in EV-C02-028 part 10.1 is agreed, and it gives everything a condition needs except some output details. I pinned those as interface and list them under Product. Nothing in the item is a proxy for something else, so no other return fits. No start header arrived and `/home/user/devos/.claude/roles/` does not exist (checked with `ls`), so I worked from my role file and the floor in my context.

## Disciplines (D1–D9)
D1: yes: I tested the assumptions that carry weight against the code. Which tree the fixture's gate runs from forced the gate cases to run from `main`'s checkout. The source blocks also exist in round 1, so the condition names part 9 only.
D2: uncertain: I wrote one of the round-2 notes this approach takes in, so I asserted nothing from that note without re-checking it against the base. My own block-hash claim I re-measured.
D3: yes: I checked the whole chain from the packages to the merge gate's refusal. That added RP7 (scope) and RP8 (the check's own path in the trigger set), and the pre-merge run of the head's gate as the counted enforcement run.
D4: yes: I wrote a throwaway sketch and ran 26 check breaks and 6 gate breaks; each turned its named cases red. I also removed three vacuous passes (P6b, P7b, and RP0 when the tool is absent).
D5: yes: for every fact I relied on I went back to the source rather than the approach's paraphrase: the marker lines and block bytes, `MESSAGE` measured by running the hook, `records.py`'s `ACC_RE` and `NOTE_RE`. That is how I found that a literal note marker in the item would break `records.py`.
D6: no
D7: yes: everything is in the clone and in this message. The sketch and break scripts stay in scratch as evidence only.
D8: yes: the clone is at `449df84…`. `tools/` and `.claude/` are byte-identical to `b547565`, and there is no `.claude/roles/` yet.
D9: yes: I read gstack CORE P5 to P7 and F1 to F4, playbook 04 F5 to F7, and work-environment finding 02 §1, §2 and §4. They shaped the cases and the counted environment, as listed below.

Read, and what each changed:
- `evidence/C02/EV-C02-028_pra2_m1_triage.md`, part 10 (lines 2634 to 2670) and part 9.7 in full. I read only the marker lines of part 9 and measured the blocks by script. This is the base of the whole condition. It changed things: a whole-file search would find two round-1 blocks with the same markers, so "the source" is part 9 only.
- `plan/Ek_D_Dusunme_Protokolleri.md` from line 69 on: the method.
- `plan/SB-COR_Correction_Plan.md` 1.1 (line 85), 2.8, 2.3 with the verdicts note, and E. These set the claims. 1.1's "for the gate, its added time" became point 13's last line.
- `plan/Installation_Working_Order.md` section 4 (lines 44 to 70) and the item format at line 125. These set the form, point 11 and point 13.
- `tools/merge_gate.py` (all of it) and `tools/test_merge_gate.py` (harness, `main()`, cases 1 to 19). Changed: the fixture's working tree is the head after `planted()`, so my cases check out `main` before running the gate.
- `.claude/hooks/reread_after_compact.py`: `MESSAGE` is a literal, 222 bytes written including the newline.
- `tools/records.py`: `deps()`, `ACC_RE`, `NOTE_RE`, and the marker count in `load_records`. Changed: point 6 does not write the note marker literally.
- `plan/work/W-C02-29.md`: the form of the item file.
- Library: gstack CORE P6 and F4 (a check that did not run must not read green, which led to the vacuous-pass fixes and to COULD NOT CHECK refusing) and F2 (attempted effect is not target state: the live row); playbook 04 F7 (every input route, which became the trigger-set cases) and F5 (a green test is not proof of content: "Not covered" (b)); finding 02 §2 (definition vs realized state: the pre-merge head-gate run against the live row) and §4 (the protected equivalence for the copies is byte content).
- Not read on purpose: the constraint (a) files; the work-environment `KEY.md` and finding 07 (read in round 2, nothing new turned on them); the other roles' part-9 answers beyond their marker lines.

Relied on:
- At the base, `tools/` and `.claude/` are identical to `b547565` (empty `git diff --stat`). Observed.
- Part 9 has exactly one package block and one executor-lines block per role at whole marker lines (EV-C02-028 lines 1613 to 2555), and parts 2 to 6 have two earlier blocks. Observed. The block bytes as I define them give test-designer 6,254 bytes, SHA-256 `9f8557260d35d1a5…`, equal to part 9.7's figure. Observed.
- The real hook writes 222 bytes, so the executor's limit is 9,078. Observed by running it.
- The gate fixture's working tree holds the head after `planted()` (`tools/test_merge_gate.py` `planted`, `branch`). Observed. Hence the cases run from `main`'s checkout. Inferred.
- `records.py` refuses an item file whose literal note-marker count differs from `NOTE_RE`'s matches (`tools/records.py:73`). Observed.
- `python3` 3.13.16 and git 2.43.0. Observed. Claude Code 2.1.304: stated by the task.

Unsure:
- **I broke the reading order once, though I saw nothing of the file.** I ran `grep -ln 'on: finished' plan/work/*.md | grep -v W-C02-22`. The glob passed `plan/work/W-C02-22.md` to grep, which read its content. Its name was filtered out, and no line of it reached me. Whether this run still counts for W-C02-22 point 10's test-designer row is for W-C02-22's test designer and binding checker to decide.
- The approach's precedence-line paraphrase is self-contradictory: "`.claude/agents/` and `CLAUDE.md` do not bind the executor; its rules are the working order and `CLAUDE.md`, which bind". Point 2 makes a line saying `CLAUDE.md` does not bind the executor a defect. The executor should confirm that reading or settle it.
- The fixture writes padded packages with `write_bytes` throughout, but RP cases write through the harness's `write_text` only for ASCII. Not a known issue.

For: the executor, who pastes the approach block under `## Approach`, commits my three files from the clone, and merges them with EV-C02-028 in one pull request. Then PR-A2's producer, who builds to the pinned interface. Then the binding checker, who runs both tests at the head and the base and builds point 9's breaks.

Received from / Returned to: none received, none returned. Reported to the executor, not done:
- (a) the precedence-line contradiction above;
- (b) the two guard denials below, for `tools/guard_report.py`;
- (c) the reading-order slip above.

Product:
- **Files** (clone `/tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/devos`, branch `claude/c02-w23-acceptance`, nothing committed):
  - `/tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/devos/plan/work/W-C02-23.md`, SHA-256 `879a334ddb33db6340a7516f7c9f4fff7899ea26180e27091570607d537feb0d`, holds:
    - the front matter, with the `depends_on` edge on W-C02-22 `on: finished` and its reason (`records.deps()` reads it);
    - "What it is";
    - the acceptance block: 15 points plus "Not covered" (a) to (k), with the fixed line as (a);
    - an empty `## Approach`.
  - `/tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/devos/tools/test_check_role_packages.py` (new), SHA-256 `510db3cfebc5dda003f81218c7fa77fe3f0c2e5611ddc8aae3c2fe3835415b23`, has 55 cases:
    - P1 to P7b: controls;
    - S1 to S6: size;
    - X1 to X4: could not check;
    - F1 to F6b: form;
    - D1 to D5: the six-file count;
    - I1 to I11: IDs;
    - RV1 to RV3: `--rev` reads the revision, not the disk.
  - `/tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/devos/tools/test_merge_gate.py`, SHA-256 `1502be5890a0cd62cd99d7e01148cd380ae6b9d98841a91a897fc1b2073c29f7`:
    - adds `role_package_gate()`, cases RP0 to RP8b, in a fixture of its own built from the check test's `build_tree` (one source);
    - adds one docstring line and `import importlib.util`;
    - leaves the older cases unchanged.
- **Results on `main`'s code** (no product):
  - The check test gives `FAIL (0/55)`, every case for one reason: "tools/check_role_packages.py absent".
  - The gate test gives `FAIL (97/98)`: all 97 older cases are `ok`, and RP0 fails as "absent".
- **Results on my throwaway sketch** (`/tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/sketch/`, evidence only, never a patch):
  - The check test gives 53/55. P7 and P7b fail only because the real packages do not exist yet.
  - The gate test with the sketch call gives `PASS (107/107)`.
  - All 26 check breaks and 6 gate breaks turned their named cases red: `breaks_check.py` and `breaks_gate.py` there, results as in point 9's table.
  - The leak scan matched 0 lines. `SERVICE_NAMES CLEAN`, with the store built 2026-10-20T09:27:53Z.
- **Interfaces I pinned that the approach left open** (marked [T] in the condition):
  - exactly one of `--root` or `--rev`; `--root` ignores the working directory; `--rev` reads git, never the disk;
  - one line per each of the six, missing ones included, plus one per extra entry at any depth; `<name>` relative to `.claude/roles/`; a `PASS` line ends at `PASS`;
  - the COULD NOT CHECK line names its cause: `MESSAGE`, the hook's file name, or the revision (12 hex);
  - the reason tokens `size utf8 nul front-matter name-line heading long-line unresolved <IDs> missing extra`, each FAIL carrying every broken rule's token and no other, and no text rules on a file that is not UTF-8;
  - the line `LIMIT = 9500 - RESERVE` verbatim;
  - `HEADER = "DevOS role package: {role}@{sha12}"`; importing the module has no side effect;
  - the gate runs the check from its own file's directory with `-I`, refuses with `GATE FAIL` exit 1 on any nonzero exit, and prints the check's lines.
- **Coverage:**
  - The condition answers SB-COR 2.3, 1.1, the verdicts note and E items 3 and 4, and approach (1) to (7) with dispositions (1) to (6).
  - It covers claim M; the copy hashes; size with its oracle and sensitivity; form; the six-file count; IDs and their limit; the gate's call, trigger set and breaks; point 10's binding check; the counted environment, including the pre-merge run of the head's gate and the live row that does not hold the acceptance; the wait under plan 6.12 item 1; and plan 6.12 item 4.
  - "Not covered", (a) to (k), is everything else: use, content fitness beyond ID resolution, delivery and `RESERVE`'s per-line maxima (W-C02-25), the executor's re-read after compaction, the platform cap behind 9,500, unplanted forms, other environments, and the validity of W-C02-22's rows.
- **Open:**
  - the precedence-line contradiction;
  - the reading-order slip;
  - the executor confirming the [T] interfaces before the producer's task.

Guard denials:
- B5 (#732): a `cp` into a path built from `$S/.../tools/` read as a guarded location. I repeated it with literal paths in my scratch copy.
- G0 (#735): a heredoc with backticks the guard could not parse. I wrote the break script with the Write tool instead.

Both are for the executor to record with `tools/guard_report.py`. I wrote no records.


## 2. W-C02-24's test designer (`a62f5e18d8d76772e`), its final message

Package: none delivered (file absent)
Nonce: none delivered
Take-up: PROCEED. Part 10.2 of EV-C02-028 can be written as a condition as it stands, and every interface it left open could be pinned inside its own words, so no reframing was needed. No start header arrived, and `/home/user/devos/.claude/roles/` does not exist (checked with Glob), so I worked from my role file and the floor in my context.

## Disciplines (D1–D9)
D1: yes: I pinned each open interface (`TW`, the T5.n numbering, the log fields, the grammars, `Workflow` staying in `ALLOWED_NON_MCP`) as the choice least likely to over-block, and flagged each one for the producer.
D2: uncertain: my own role wrote part 9.7, so I re-derived the points from the code at the base instead of trusting that note, and widened my own log oracle when my break showed it was too weak.
D3: yes: I traced each claim to where it actually runs (the live tree's copy, the first call or merge after sync, observation (12)) and kept the item at "not accepted" until those observations are filed.
D4: yes: I showed each oracle is sensitive: red on main's code, green on a throwaway sketch, and red under each of eight breaks. One break exposed a weak oracle, which I fixed before handing over.
D5: yes: I read the code, `records.py`, `checker.md`'s template and real verdicts rather than the round notes' descriptions of them, and confirmed that `.claude` and `tools` are unchanged from `b547565` to `449df84`.
D6: no
D7: yes: I wrote only the three named files on the named branch in my own clone. I also put back the shared scratch clone I had switched by mistake (reported below).
D8: yes: I confirmed HEAD `449df843…`, a clean clone, that `W-C02-24.md` did not exist yet, and that W-C02-22's approach block copies and passes as an over-blocking control.
D9: yes: playbook 04 F7 shaped the route cases (Agent, Task, PermissionRequest, `agent_id`), F12 and gstack F2 the revert-by-tree and read-back points, gstack P6 and F4 the "which copy runs" and live-run points, P7 the containment cases, and finding 02 section 4 the per-claim environment.

Read, and what each changed:
- EV-C02-028, all in my clone at `449df84`:
  - part 10.2 in full: the basis of the condition;
  - parts 9.3, 9.6 (M1a and M1b triage) and 9.7: the interfaces, breaks and floor;
  - parts 9.1 and 9.2: the over-blocking control texts;
  - the headings of parts 1 to 8, which I did not read in full.
- `plan/Ek_D_Dusunme_Protokolleri.md` from line 69 only: my method.
- `.claude/hooks/tool_allowlist.py`: lines 2130 to 2345, 420 to 461, and the constant and RULES lines found by grep. These fixed the T4 and T2 order, the `RULES` fallback to G0's title, the `git()` decoding, `DEVOS_CALL_BUDGET` as a clean `OverBudget` fixture, and the log record.
- `tools/test_tool_allowlist.sh`: lines 1 to 240, 750 to 761, 850 to 884, 1100 to 1139 and 1290 to 1309. I found that `lt`'s `\w+` cannot capture `T5.1` (changed: widened) and that `lt` and `has` were defined after the cases that need them (changed: moved up).
- `tools/test_token_stop.py` lines 1165 to 1185: the 1175 change.
- `tools/records.py` (`NOTE_RE`, `load_records`, `deps`): the note rule and the `depends_on` form.
- `tools/merge_gate.py` lines 1 to 60, plus grep for the verdict key lines.
- `.claude/agents/checker.md` lines 65 to 105, and `CHK-C02-128` and `CHK-C02-129`: the M1b value grammars I pinned.
- `plan/SB-COR_Correction_Plan.md`: 1.1, 1.2, 3.1, 3.5, 3.7, E and P-7.
- Working order lines 186 to 200 and 206 to 240.
- The heads of `plan/decisions/D-039.md` and `D-041.md`: the P-7 check.
- `plan/work/W-C02-29.md` lines 1 to 40: the item form.
- Library: playbook 04 §8 (F7), §9 (F8) and §13 (F12); gstack CORE P6, P7, F2 and F4; work-environment finding 02 §2 to §4. Not read: finding 07 and the vertical's KEY.
- Deliberately not opened, under constraint (a): my own agent file, `CLAUDE.md`, PC-53, W-C02-22's item file (only piped by the test's fixture code, never printed), EV-C02-026, and Ek D before line 69. I also did not open `scratchpad/test-designer.md`, which may be a copy of my role file.

Relied on:
- The guard checks T2 before the type, and an untyped call defaults to `general-purpose`: `tool_allowlist.py:2196-2201` (observed).
- `deny_text` falls back to G0's title for a rule with no `RULES` entry: `:2286` (observed).
- `CALL_BUDGET = min(400, env)`, so `DEVOS_CALL_BUDGET=0` raises `OverBudget` at the first git call: `:81` and `:427-444` (observed; it is the mechanism of a case that passed on the sketch).
- The log `summary` holds no prompt text on main: the log probes passed on main (observed).
- W-C02-22's block at HEAD has exactly one pair of whole-line markers and the nine keys in order: its control passed on the sketch (observed, without the text reaching me).
- `.claude/` and `tools/` are identical at `b547565` and `449df84` (observed).
- Agent IDs have the form `a` plus 16 hex digits (observed in EV-C02-028's IDs, inferred as a rule).
- `deps()` reads the `on:`-as-True key: `records.py:125` (observed; `load_records` returned `on: finished`).
- Claude Code 2.1.304: stated by the task.

Unsure:
- I made `producer_run` follow the agent-ID form `a[0-9a-f]{16}`. A platform change to that form would refuse sound verdicts. M1b's test designer should confirm this against the agent IDs EV-C02-028 records.
- `floor:` and `triage:` were free prose in recent verdicts, and my pinned grammars may be too strict for real use. M1b's producer or test designer settles this before M1b's tests.
- A git repository missing at `ROOT` (T5.8 or T5.0) is left unpinned; it is listed under "Not covered".
- I did not run the leak scan on the three files. They hold no library text (all citations are by path and section). The push leak check settles it.

For: the executor, who pastes the approach under `## Approach`, commits my files and merges them with EV-C02-028 in one pull request. Then M1a's producer, who builds to the [pinned here] interfaces. Then M1a's binding checker, who judges the head against Part A and runs the A5 breaks. Then M1b's test designer, who writes `tools/test_merge_gate.py` to Part B after PR-A2's merge.

Received from / Returned to:
- To the executor, an incident: my first clone attempt collided with an existing `scratchpad/devos`, apparently W-C02-23's test designer's clone on branch `claude/c02-w23-acceptance`. I created and checked out my branch in it, saw the mistake, switched it back and deleted my branch. Its `git status` was clean before and after, and its HEAD was `449df84`. Please confirm with that designer that nothing was written to it in that window.
- To the producer (interfaces pinned, return to the executor if any cannot be built): `TW`; `Workflow` stays in `ALLOWED_NON_MCP` (part 10.2's open item); T5.1 to T5.19 and T5.0 as tabled; `T5R` for a test designer in either form; every type refusal is `T4`; the log fields `input_keys=`, `prompt_bytes=`, `prompt_sha256=`; and each grammar in A3.
- To M1b's test designer: the pinned grammars of `triage:`, `floor:`, `shared_with_producer` and `producer_run` (B1).

Product:
- **Files:** in the clone `/tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/w24td/devos`, branch `claude/c02-w24-acceptance`, base `449df84`, nothing committed:
  - `plan/work/W-C02-24.md`, SHA-256 `9743fff69575b107a43dc4f3fcd1a4305d44020a8cce7f9b0052f2666a8d16a6`. It holds the front matter as asked, "What it is", the acceptance block (Part A M1a, Part B M1b, Part C environment, P-7 and acceptance, the 6.12 item 4 line, "Not covered") and an empty `## Approach`.
  - `tools/test_tool_allowlist.sh`, SHA-256 `700d0cb3e230f9b1ce4221e74fe25bd5f2af2f0aa40f043547a31ead8cdf8a38`. Changes:
    - `lt` and `has` moved up and `lt`'s rule capture widened to dotted IDs;
    - lines 141 to 144 asserted as T2, with its positive control;
    - every Workflow case is `lt deny TW`;
    - the type cases: one per type, Task and PermissionRequest included;
    - 758 flipped;
    - a new T5 section: a fixture generator (59 cases) covering every check ID, the over-blocking controls, routes, containment pairs, the type-by-file fixture, and the log fields with the no-text probes.
  - `tools/test_token_stop.py`, SHA-256 `83c25054022c07f932918a01732a3892450ffc491f067ac6fcaa8a9437942e02`: line 1175 now uses `checker`.
  - Results on main's code (no product), run twice with the same output: 1,485 ok and 98 BAD lines, `ALLOWLIST_TEST FAIL`, `TOKEN_STOP_TEST PASS`. Every BAD line is a new or flipped case failing for its named reason (TW expected, T3, T4 or allow seen; T4 expected, T2 allow seen; T5.x expected, T2 allow seen). No old case failed. Output: `/tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/w24td/run_main2.txt`.
  - Throwaway sketch, evidence only and not handed over (`/tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/w24td/mksketch.py`, checkouts under `/tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/w24td/sk/`):
    - Sound sketch: 1,584 ok. Every new case passes, the W-C02-22 control included. The only 2 BAD lines are push controls that need the clone's origin to be `devos`, which is a setup artifact.
    - Each break turned its own cases red (8 to 21 BAD lines each; the W20-P7 and push lines are the same setup artifact): `cwd`, `noacc`, `status`, `noform`, `nowf`, `nocatch` (the G0 guard-error check is red too), `agentonly`, and `logtext`.
    - `logtext` was green at first: its leak sat outside my one end-of-prompt marker. I widened the oracle to three probes from the start, middle and end of the prompt, and it is now red.
  - Where it ran: this container, `python3` 3.13.16 and git 2.43.0, `bash tools/test_tool_allowlist.sh` from the clone's root.
- **Coverage:**
  - Covered: SB-COR 3.1, 1.1 (flips, breaks, over-blocking, environment, 6.12 item 4, P-7, "Not covered"), 3.5's `Plan` case, section 10's lock-out route, and part 10.2 points (1) to (12) and its dispositions.
  - M1b's tests are deliberately not written: they come in the second step, after PR-A2's merge (one writer of `tools/test_merge_gate.py`). The condition states what they must show.
  - Not covered, with reasons, in the block: use (2.8 rows 1 to 5 show presence and form only), the reader-form write residual, a `diff-confirmed` closure really made, undeclared class-normal paths, T6 and M3, workflow agents, M2, `ROOT` without git, and the bullet form line.
- **Open:**
  - Part 10.2's `open:` line (`ALLOWED_NON_MCP`) is pinned by me, not by its owner, the producer.
  - The `Plan` case already passes at the base by T4, so it guards against regression rather than showing new behaviour.
  - A10 allows checking observation (12) by the record's hash before `launch` exists. Whether that suffices is the executor's call.

Guard denials:
- #677, B5: a `git clone` whose directory was in a shell variable. I re-ran it with literal paths (then, by mistake, in the existing shared clone; see above). After that I used my own `scratchpad/w24td/`.
- #682, B7: `claude --version`. I dropped it and used the version the task states, 2.1.304.
- #761, B5: a `python3 -c` loop writing into scratch `tools/` paths it could not resolve. Following the denial's "what to do instead", I used `cp` and `python3 mksketch.py` with literal paths, the form it had allowed for the sound sketch.
- These are for the executor to record with `tools/guard_report.py`.
