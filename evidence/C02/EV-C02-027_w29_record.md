---
id: EV-C02-027
title: "W-C02-29's record: N-315's prevention built (records.py refuses a foreign working directory; sync_worktree.sh refuses a foreign tree and heals a stamp-only render)"
stage: C02
kind: observation
source: "the producer a0869d5517136ca5e's report; CHK-C02-126 (checker a6d5199185c0709e9); the executor's reading of tools/ at a0fcbfc; issue #6's comments read 2026-10-20"
---

# EV-C02-027 · W-C02-29: the record its condition asks for

Filed by the executor (L-436), as CHK-C02-126 C1 requires; each item names the condition's point it answers (`plan/work/W-C02-29.md`, its acceptance block at `eb0f5b9101345a7758f78f7ed4464ac2ec491dde`).

## 1. The evidence envelope (point 11)

- **Head:** `a0fcbfc7e8dd9600398cb00605a4df49510a1ed0` (branch `claude/c02-w29-product`; one commit on `eb0f5b9`), changing only `tools/records.py` and `tools/sync_worktree.sh`.
- **Blobs at the head:** `tools/records.py` `f71e759d4ceb9ddc030b3f2128d7f5f3917d7b2f`; `tools/sync_worktree.sh` `3e14709d7de38f977f8188fbd4c478ab18e711d6`; `tools/test_sync_worktree.sh` `499ec1703c19ed59b9b55db4117ea231ec0714c1`; `tools/test_records_disciplines.py` `7f5313a009acc0980d1616e0a8fea25d86f8f79b` (both test blobs as the test designer's commit `bae4e65` left them; point 6) (CHK-C02-126 C2).
- **Criterion version:** the acceptance block at `eb0f5b9` (written before the product; judged by CHK-C02-124 and CHK-C02-125).
- **Case lists and raw outputs:** `RECORDS_DISCIPLINES_TEST PASS (46/46)` and `SYNC_WORKTREE_TEST PASS (47/47)` at the head, by the producer and, independently, by the checker; at the base (253260c's two scripts under the head's tests) `FAIL (33/46)` (the 13 named lines) and `FAIL (36/47)` (S02 to S09, S12, R22b, R22c); `bash tools/test_tool_allowlist.sh`: `ALLOWLIST_TEST PASS`. The checker's raw outputs and break drivers were in its scratch directory (`chk126/`), and its verdict quotes their results (findings F2, F4, F6, F7).
- **Independence:** same session, fresh-context subagents (declared, Ek A 5.3): the producer, and a checker that took part in no triage, condition or check of this item.

## 2. Where it ran (point 7)

The session's container: Python 3.13.16, PyYAML 6.0.3, git 2.43.0, GNU bash 5.2.21; locale POSIX, with `LANG` and `LC_ALL` unset (so S05 under `LC_ALL=C` and the script's own `export LC_ALL=C` are not told apart here; condition (h)). The changed scripts were never run with `/home/user/devos` as the working directory (the producer's and the checker's statements; the guard's records show no such call).

## 3. The callers of records.py (point 2)

- `tools/stop_check.sh:18` runs `python3 -B tools/records.py render --check`, relative to its working directory; `stop_check.sh` is run from the root of the live tree (its header), which is the script's own checkout: not refused.
- The working order's render step (section 4 step 6): the executor runs `python3 tools/records.py render` with the scratch clone's root as the working directory, the clone's own `records.py`: not refused. The run that caused N-315 (another clone's script from the live tree) is now refused.
- The tests run their own copies (`tools/test_records_disciplines.py`'s `run()` copies `records.py` into each fixture).

## 4. The heal's precondition (point 3)

The stamp-only heal applies only when `main`'s committed views are current, so that a render of `HEAD`'s records changes only the two stamp lines. A render whose generated blocks differ from `HEAD` (stale views on `main`) is refused, safe but not healed. The executor keeps `main`'s views current by rendering in every records pull request (working order section 4 step 6).

## 5. Records (point 9)

- **(a) Each discard is a departure.** Every `SYNC DISCARDED: <path> (render stamp only)` line the executor sees from the merge on is logged as a departure (a render in the live tree), with its path. The working order's step 5 is not changed by this item: the working order is being changed at the same time by W-C02-22 (PR-A1), one writer per file (PC-24); the practice is carried by this record and the log, and is folded into step 5 at its next change; a note on `plan/work/C02.md` (added with the records after the merge, since this pull request carries only the record paths CHK-C02-126 C2 allows) says so.
- **(b) The failure class.** A script of one checkout reads or writes another tree because it resolves its paths from the working directory, and the guard judges the command, not what the script writes (gstack F3; the SDLC playbook's F7). The scripts under `tools/` at the head that resolve paths from the working directory, and whether each can write there:
  - `tools/records.py` (`ROOT = Path(".")`): writes `plan/ledger.md` and `DURUM.md`; now refuses a working directory other than its own checkout.
  - `tools/sync_worktree.sh` (`git rev-parse --show-toplevel`): moves the working directory's tree; now refuses a tree other than its own checkout.
  - `tools/stop_check.sh`: reads only (relative `plan/ledger/*-log.md`, its own `records.py --check`); its only write is `git fetch` of `origin/main` into the working directory's repository: no.
  - `tools/test_token_stop.py` (`root = os.getcwd()`, line 1054): reads from the root; every write goes under its own temporary directory (lines 582, 625 to 633, 804, 812): no.
  - `tools/test_tool_allowlist.sh` (`os.getcwd()` at line 927, as `CLAUDE_PROJECT_DIR` for the guard it tests; line 515 is a test case's text): reads; its writes go to temporary fixtures: no.
  - `tools/leak_fingerprints.py`, `tools/subagent_audit.py`, `tools/credential_*.py`: anchored to `__file__` or to explicit paths: not of the class.
  No "yes" beyond the two scripts this item fixes, so no stage note. **A second mechanism for the same class:** yes. The first is guard rule B4 with `tools/sync_worktree.sh` (W-C00-12.6: the live tree moves only by the sync). The premise that creates the limit (plan 6.12 item 2): the guard judges a command's text, not the effects of a script it runs (working order section 10, "Not protected": an interpreter or `bash` run). The frame question is answered for now: changing that premise means a guard that follows what scripts write, which the working order lists as not protected; the two refusals compensate where the class actually bit, and their removal conditions below name when they can go.
- **(c) Plan 6.12 item 4, for each mechanism.** What each compensates for that the model cannot do on its own: noticing, while running a script by path, that the working directory belongs to another tree, a slip the guard does not see. Premise: scripts are run as `python3 <path>` or `bash <path>`; the live tree is the only tree the guard protects; renders happen in scratch clones. Removal condition: the `records.py` refusal: `records.py` resolves its paths from its own location, or the guard judges a script's effects on the live tree; sync (ii): no render can run in the live tree, or each session's live tree is a fresh checkout that no agent writes; sync (i): no clone other than the live tree carries the script and could be run against it. The test of whether removing one worsens the result: point 5's breaks, and the count of departures under (a) and of `SYNC REFUSED` lines, read at C02's close.
- **(d) Scratch clones.** Scratch clones made before this merge keep the old `records.py`; the executor makes its scratch clones fresh after the merge (or fetches and checks out `main` in them before a render).

## 6. Guard lines the suite does not reach (CHK-C02-126 findings F6 and F7)

- **Live, shown only by the checker's plants outside the suite:** (1) the read-hash check in `load()` (`[ "$got" = "$want" ]`): with it removed the suite still passes 47/47, while a ledger holding a NUL byte followed by text is then discarded with its hand edit lost; the product refuses it. (2) The exact ` M` status rule: taking `?M` while still comparing with `HEAD` passes the suite, while a staged stamp under a different working stamp (`MM`) is then discarded, leaving a staged change; the product refuses it untouched.
- **Equivalent in the counted environment** (removing one alone leaves 47/47, and no state there tells them apart): `cd -P`/`pwd -P` on the toplevel (git already returns a physical path); `cd -P` on the script's own path (`readlink -f` already resolves it); `[ -n "$hnorm" ]`; `norm`'s prefix-present and reassembly checks (each covered by the other and by the regex); `[ -f ] && [ ! -L ]` in `load()` (a deleted file or a type change already fails the ` M` pattern).
- **Unreached because of the environment:** `export LC_ALL=C` (the container's default locale is already POSIX).

## 7. The timing parameter (point 10)

- **The parameter:** the switch to a new working session (N-315's way out, the approach's (A)). As agreed in W-C02-29's approach: the request to Batu when this fix merges; the switch before the first of SB-COR's first producer task and the first merge that changes a path read from the live tree. **Changed since** by PR-A1's approach (W-C02-22, disposition 1; N-315's annotation, L-434): the switch is made right after PR-A1's merge, before any further role run, so that one new session serves N-315 and PR-A1's delivery row; the merges until then skip the sync (one departure, ending at the new session's opening). The request goes to Batu at PR-A1's merge.
- **The time it adds:** measured at point 8 (this item's merge, the request, the new session's opening); no estimate at writing: it is Batu's response time to a request not yet sent. He was told at about 07:20Z, as information, that it is coming (L-433).
- **What would end it sooner, and whose call:** asking him before the merge (the executor's call; taken as information at 07:20Z, the request itself waits for PR-A1's merge by disposition 1); the session is his to open; the in-session bootstrap is not an option (`CLAUDE.md`, "The guard"; EV-C02-024).
- **Sources with dates:** N-315 (`plan/work/C02.md`, L-432, 2026-10-20) and its annotation (L-434, 2026-10-20); working order section 4 step 5; W-C02-29's approach (EV-C02-024 part 9, 2026-10-20) and W-C02-22's approach (EV-C02-026 part 14, 2026-10-20); CHK-C02-123 C1 (the library window a new session needs, 2026-10-20).
- **Against Batu's later decisions:** D-034 (2026-10-13, (b)): bears on the new session only through the library window, a single-action Auto window with a checker's verdict (CHK-C02-123 shows the route). D-035 (2026-10-13, (a)): the working session runs at the effort he sets in it; a new session he opens takes his setting; nothing to change. D-041 (2026-10-20): he asked the executor to stand behind the plan and do what has to be done; it does not bear on the timing. Issue #6: no comment by `batuhanozgun` after 2026-10-18T19:45:57Z ("A Tamam", already recorded), read 2026-10-20.
- **This item's own parameters:** `depends_on: []`; no item waits on its acceptance; N-315 closes at point 8.
