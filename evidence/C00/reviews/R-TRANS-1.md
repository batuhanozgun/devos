# R-TRANS-1: independent review of the transition bundle (PR #146)

**Verdict:** FAIL

- **Reviewed commit:** `dbb24b5b6592cce4cf9cf58da308077c546fcef1` (branch `claude/transition-bundle`), against base `f51e7e0` on `main`.
- **Reviewer:** session `session_018tWKmQrqh88xvkwXF2jYtA`. It is a separate review session: it did not produce the bundle and did not see the producer's conversation.
- **Date:** 2026-10-05 (UTC).
- **Criteria:** the four criteria of the review task: (1) fidelity to D-010; (2) plan fidelity; (3) safety of the merge gate and the guard; (4) the single-session way for a new working session.
- **Sources read:** D-010 and the approved summary (Turkish original, English rendering, addendum E1-E3); plan section 14 and the ledger rules; PC-06 and every plan place it lists; `tools/merge_gate.py`, `tools/test_merge_gate.py`, the guard diff, `.claude/settings.json`, the new hook, the five role files, `CLAUDE.md`, `plan/Installation_Working_Order.md` (WO below), `tools/stop_check.sh`, `tools/records.py`, `tools/sync_worktree.sh`, the diffs of `plan/work/`, `plan/decisions/`, `plan/ledger.md`, `DURUM.md` and the C00 log, and, for comparison, the old gate (`tools/check_records.py` at `f51e7e0`).

**In short.** The plan text side is sound. Every plan change is in PC-06, and no acceptance condition is loosened beyond the stated change of independence level (criterion 2). Most of D-010 is carried out faithfully. I found three blocking defects, all in class-high tools. (B1) The merge gate no longer protects acceptance conditions, which is beyond the decision. (B2) The merge gate accepts a verdict that was given for another head. (B3) The stop check cannot pass when the live tree is not on branch `main`, so the installation `/goal` could never be met. Each one is a small code change, but the fixes change class-high files, so the fixed head needs a new verdict.

## Checks run

| Check | Result |
|---|---|
| `python3 tools/test_merge_gate.py` at the head | `MERGE_GATE_TEST PASS (16/16)` |
| `bash tools/test_tool_allowlist.sh` at the head | `ALLOWLIST_TEST PASS`: 618 `ok`, 0 `BAD`, run in a clone whose origin is `https://github.com/batuhanozgun/devos`, on the pushed branch. In a clone whose origin is a local path, two push cases report `BAD`, because rule B3 denies a push to a remote that is not devos. That is a premise of the test environment, not a defect. |
| `python3 -B tools/records.py render` at the head | Only the clock-driven lines change: the `Rendered` row and DURUM's update line. The generated blocks are in sync. |
| Guard diff `f51e7e0..dbb24b5` | Only the rule texts (where, why, what to do instead), comments, the docstring, the deny footer and the error message change. M7 now runs `tools/merge_gate.py --pr N --head SHA`. The rule logic is otherwise unchanged. |
| Gate probes | A scratch script that reuses the PR's own fixture (`Fixture` in `tools/test_merge_gate.py`) with the head's gate and guard. Results are under B1, B2, m1 and m2. |
| `tools/stop_check.sh` from the head, run in a fresh clone detached exactly at `origin/main` | `STOP_CHECK FAIL` (B3) |
| PR head after the reviewed commit | `claude/transition-bundle` has since moved to `fa09065`, a merge of `main`. Its diff from the reviewed commit is one added recorder line in `.claude/hooks/owned_ids.txt` (this reviewer's ID). This review judges the reviewed commit only. |

## Blocking findings

### B1 · The merge gate no longer protects acceptance conditions

**Where:** `tools/merge_gate.py`, `high_paths()` (lines 69-78); the M7 text in `.claude/hooks/tool_allowlist.py`; the 2026-10-05 update in `plan/decisions/D-008.md`.

**Problem.** Several kinds of change made a pull request class high under the old gate (`impact()` in `tools/check_records.py` at `f51e7e0`):
- a change to, or removal of, an existing acceptance block in `plan/work/`;
- a deleted item file;
- a cancelled admitted item;
- an edit to `depends_on`, `waits_for` or `hold_until`;
- a change to the ledger's Stage row or Governing rows.

M7 on `main` said so in its own words: "A change to rules, hooks, tools, governing documents or acceptance conditions (class high)". The new gate decides by path alone, and the new M7 text drops "or acceptance conditions".

**Evidence (probe P1).** A pull request rewrites an existing acceptance block from "All 20 cases pass, reviewed by a fresh-context checker" to "Most cases pass" and adds no verdict. Result: `GATE PASS ... class normal`.

**Why it blocks.** D-010 item 28 keeps the merge gate and changes only who gives its verdict ("instead of a separate session's verdict, the Auditor's verdict, with its independence level; this preserves the assurance Batu was given in D-008"). As M7 stated that assurance, it covered acceptance conditions. Dropping that coverage goes beyond the decision (criterion 1). It also removes the only mechanical check behind several written rules:
- ledger rule 3;
- plan section 14 ("kabul koşulu sonuç görüldükten sonra gevşetilemez");
- summary item 22.

This matters most in the new way, where one session writes the conditions, produces the results, has them checked and merges them. The narrowing is disclosed honestly in D-008's update. PC-06 does not mention it, and L-132 says "The guard's rule logic is unchanged except M7's tool", which understates that M7's coverage shrank.

**Fix.** In `merge_gate.py`, treat these as class high:
- deleting a `plan/work/*.md` file;
- changing or removing the text of an existing `<!-- acceptance -->` block in one.

Adding a block where none existed stays class normal, as the stage files assume. Add a test for both cases, restore "or acceptance conditions" to M7's text, and name the trigger in WO section 4, step 5. Restoring the `depends_on` and cancellation triggers is optional; the acceptance-block trigger is the one that is needed.

### B2 · A verdict for another head satisfies the gate (criterion 3)

**Where:** `tools/merge_gate.py`, `cover()` (lines 89-113).

**Problem.** Any verdict file anywhere in the head's tree covers the head when its `reviewed_head` X is any ancestor of the head and X..head touches no class-high path. Verdict files accumulate on `main`. So the verdict of an earlier pull request covers a later pull request that brings the class-high files back to the state that verdict saw. A revert of a later, reviewed fix is the plain case.

**Evidence (probe P2).**
1. PR A adds "rule A" to `CLAUDE.md`, gets its own verdict `CHK-C00-001` and merges.
2. PR B adds "security rule B", gets `CHK-C00-002` and merges.
3. PR C removes rule B and adds no verdict. Gate output: `class high: CLAUDE.md`, then `GATE PASS ... covered by evidence/C00/checks/CHK-C00-001.md`. That verdict reviewed PR A's commit, not PR C's.

By code reading, the old gate's `covered()` used the same ancestor rule, so this is not a regression. It still fails criterion 3 as written. It also contradicts two statements in the bundle:
- D-008's update: "No high-impact change merges without an independent verdict".
- WO section 10: "There is no break-glass route". In fact this is an unreviewed rollback route, open to a mistaken executor or an injected instruction ("revert to the earlier version").

**Fix.** Count only verdict files that the pull request adds or changes (`vf in in_pr`). Also require that X is not an ancestor of the merge base, so that X is a commit of this pull request and not one already on `main`. This keeps the intended flow: commit X, the checker judges X, the verdict is added, `main` is merged in. Add P2 as a test case.

### B3 · `tools/stop_check.sh` cannot pass unless the live tree is on branch `main`

**Where:** `tools/stop_check.sh`, lines 11-13.

**Problem.** Line 12 requires `git branch --show-current` to print `main`. A cloud session's checkout can be detached. This review session started with "HEAD detached from refs/heads/main", and `git branch --show-current` prints nothing here. `tools/sync_worktree.sh` moves the tree with `git merge --ff-only`, which leaves a detached HEAD detached. Guard rule B4 denies checkout and switch in the live tree. So a session in that state has no allowed way onto `main`. A session that starts on a `claude/` branch fails the same way.

**Evidence.** The head's `stop_check.sh`, run in a clone detached exactly at `origin/main`, printed `FAIL  the working tree is not on main at origin/main (branch 'none', ...)` and then `STOP_CHECK FAIL`.

**Consequence.**
- Ek F's `/goal` is "met only when ... the unedited output of tools/stop_check.sh ending in STOP_CHECK PASS", so the installation goal could never be met.
- Every "not yet" stop message, which WO section 7 says "must end in `STOP_CHECK PASS`", would carry FAIL instead.

I could not verify how an app-opened working session's checkout starts (see "Not checked"). Both possible non-`main` states fail, and this session shows that such a state occurs in this environment. The retired `builder_check.sh` checked "no commits ahead of origin/main", which does not depend on the branch name.

**Fix.** Pass when HEAD equals `origin/main`, on a branch or detached: `[ -n "$om" ] && [ "$(git rev-parse HEAD)" = "$om" ]`. Print the branch name as information only.

## Minor findings

- **m1 · `merge_gate.py`, `front()` (lines 81-86): a repeated key is not refused.** The last occurrence wins. Probe P3: a verdict file with `verdict: FAIL` followed by `verdict: PASS` covers the head (`GATE PASS`). Fix: fail closed on any repeated key.
- **m2 · `merge_gate.py`, `HIGH_FILES` and `HIGH_PREFIXES`: nested rule files are class normal.** Only the root `CLAUDE.md` and the root `.claude/` are class high. A nested `plan/CLAUDE.md`, which Claude Code loads as instructions when it works under `plan/`, merges without a verdict (probe P4: `GATE PASS ... class normal`). The old gate had the same gap. Fix: treat as class high any path whose file name is `CLAUDE.md` or that has a `.claude/` component.
- **m3 · WO section 10 ("Not protected") and plan section 9, item 5: the gate checks a verdict file's form, not where it came from.** The executor writes the verdict file itself, and `checker_run` is free text. This is inherent to the declared independence level that D-010 chose, but it is stated nowhere. Plan section 9, item 5 says a high-impact change does not reach `main` "bu karar olmadan" (without this verdict); the gate enforces the file, not the verdict. Fix: add one line to "Not protected".
- **m4 · `.claude/agents/checker.md`, procedure step 2: conflicts with W-C00-08.** Step 2 says "Read the producer's rationale". That conflicts with W-C00-08's acceptance ("sees only the plan, criteria and sources") and with plan C00 step 4 ("Planı yazanın gerekçelerini görmemiş", one that has not seen the plan author's reasoning). Fix: add "unless your task limits what you may see; then read only what it names".
- **m5 · WO section 3, opening check steps 1 and 3: the goal check depends on an unconfirmed field.** Step 1 requires the goal condition to be set and reads it from `external_metadata.goal`. I could not confirm that this field exists. `get_session` on this session shows no such key, but no goal is set here. If the platform never exposes the field, step 3 stops all plan work and asks Batu to change something he cannot change. Fix: treat goal visibility like effort and record "not visible". The session's own first message is the evidence; stop only when that message is not the Ek F goal.
- **m6 · `CLAUDE.md`, line 3: how a session knows it is the executor is not stated.** The line says "The working session that Batu opened (the executor)". In Accept edits, Batu also opens the other sessions the plan needs: the sessions observed in C01, the exams and the audit environment. The lease that used to stop two writers is gone. Fix: say that the executor is the session whose first message is the installation `/goal` of Ek F. Any other session follows the task in its first message and does not run the work loop.
- **m7 · `.claude/hooks/reread_after_compact.py`: its list is shorter than WO section 3.** The hook names four items: WO, ledger sections 1-2, `DURUM.md` and the stage log. WO section 3 ("Where it left off") also names Appendix D section 2, Appendix G items G4, G8 and G10, Batu's new answers, and the plan sections that the next item names, and it says the hook reminds the session to re-read "this list". Fix: make the hook point to the list in WO section 3.
- **m8 · `DURUM.md` and `summary_tr` in `plan/ledger.md`: Batu's status page is not accurate yet.** At the head, DURUM says "Kurulumu tek bir çalışma oturumu yürütüyor" (one working session runs the installation) and "Senden beklenen: Hiçbir şey" (nothing expected from you). No working session exists yet, and Batu still has to open it with Ek F. `summary_tr` still describes step 0, and the render warns about it. Fix: update both at the hand-over (step 5).
- **m9 · Dangling pointers to retired files.** None of them pulls a session back to the chain. Fix them in the next class-high change.
  - The title of `plan/decisions/PC-04.md` and its generated ledger row still name `plan/Builder_Operating_Model.md`.
  - Comments in `tools/sync_worktree.sh` (line 2) and `tools/guard_report.py` (line 6) cite "operating model section 9" and "section 11".
  - The work items and decision updates cite the retired files' history at `676a116`, and L-132 cites `f51e7e0`. Both commits hold the files.

## By criterion

**(1) Fidelity to D-010.**
- **Present:** everything step 2 names (item 26): the role-neutral `CLAUDE.md`, the five roles (item 19), the re-read hook (item 20), the guard change, and the plan-change record with the section-G changes (items 31-33).
- **Roles:** they match items 16-19. Each has a tool list, `model: inherit`, effort inherited, a procedure, bans and `maxTurns`. The checker carries the plan-fidelity question for side branches and stage ends. The counter-designer's plan-blindness is enforced by its tools (Write only), with the "recorded as low" fallback.
- **Mechanics (item 20 (a)):** written in WO sections 3-7.
- **Side branches (item 21):** WO section 5. **Plan changes (item 22):** WO section 6. **Reasoning layer (item 23):** WO section 2.
- **One `/goal` (E2):** written in Ek F v2.0 and WO section 7. **Where Batu types (E3):** Ek F, WO section 8 and the plan's section 9 block.
- **Item 30:** W-C00-05, W-C00-12 and W-C00-12's children are cancelled, with reasons and with their acceptance blocks unchanged. The C00 hold is lifted, and the acceptance route for W-C00-01, 02 and 04 is set in N-051 and the Stage row.
- **Item 28:** history and evidence are kept, and no evidence file is deleted.
- **Growth:** `tools/stop_check.sh` is not in item 26's file list. It is defensible under E2, because the goal evaluator sees only the conversation, but it is defective (B3).
- **Beyond the decision:** the merge gate's lost coverage (B1). **Missing:** nothing else found.

**(2) Plan fidelity.**
- **Recorded:** every changed place in the plan, Appendix A and Appendix F is in PC-06 with its old text, new text, reason and affected stages. Line numbers match `f51e7e0`.
- **Batu-labelled places, each covered by D-010:**
  - 0.6 item 1 (under K9): item 33 names translation fidelity.
  - 4 K-11 item 7 ([PC-05; Batu]) and Appendix A line 373: item 32.
  - The PC-04 block in section 9: item 31.
  - The PC-01 paragraph: E1 and E2.
  - 11.1: it records his decisions.
- **Not labelled:** 6.12 item 3 and section 8 item 7 carry no Batu label; they are recorded with reasons.
- **Changed acceptance blocks:** in W-C00-06, 08, 09 and 11, only the independence level changes. W-C00-06 adds "that did not translate", which is stricter. W-C00-09 adds the "recorded as low" fallback of summary item 17.
- **Unchanged:** ledger rule 3.
- **Result:** met.

**(3) Safety.**
- **Fails closed:** yes. Any non-zero exit makes the guard deny; git errors give `GATE ERROR`. The tests cover a moved head, a pull request the remote does not hold, a short SHA, a FAIL verdict and missing fields.
- **A verdict for another head:** not met (B2).
- **Class-high path set:** kept, with `plan/Installation_Working_Order.md` in place of the retired operating model (test 13). The non-path triggers are dropped (B1).
- **Guard:** rule logic unchanged except M7.
- **Tests:** both suites pass at the head, as stated.

**(4) A new working session that reads `CLAUDE.md` and WO.**
- **Follows the single-session way:** yes.
- **Pull-back:** outside history, no instruction about leases for runs, successor sessions, the dispatcher, the heartbeat or separate review sessions for routine checks remains. History here means the C00 log, cancelled items, decision records, and the two briefs marked "not instructions".
- **But:** its stop check fails in a non-`main` checkout (B3), and how it knows it is the executor is not stated (m6).

## Claims against evidence

- **L-132, "Tests at the bundle head: MERGE_GATE_TEST PASS (16/16), ALLOWLIST_TEST PASS, RENDER OK":** reproduced. The allowlist suite needs a clone with a GitHub origin on a pushed branch.
- **L-132, "The guard's rule logic is unchanged except M7's tool":** true of the guard file, but it understates the change, because M7's coverage narrowed (B1).
- **D-008 update, "No high-impact change merges without an independent verdict":** not what is enforced (B2, m3).
- **WO section 10, "There is no break-glass route":** an unreviewed rollback route exists (B2).
- **PC-06, "No acceptance condition is loosened after a result":** holds for the bundle's own edits. The gate no longer enforces it for later edits (B1).

## Not checked

- How an app-opened session's checkout starts (on `main`, detached or on a `claude/` branch), which is the premise of B3's likelihood.
- `/goal` behaviour:
  - whether a 1,488-character goal is accepted;
  - how the evaluator treats a turn that ends in a "not yet" state;
  - whether re-prompting repeats while the session waits for Batu.
- Whether `get_session` exposes `external_metadata.goal` (m5).
- Whether the `SessionStart` hook with matcher `compact` fires in a cloud session and its text reaches the context (N-058 defers this to the first compaction).
- Whether custom subagents load `CLAUDE.md`, and whether `tools: Write` excludes every other tool, MCP tools included, for the counter-designer.
- The old gate's behaviour on probe P2: by code reading only, not run.
- M7 on a real GitHub merge: only the fixture, with a local bare origin.
- Commits after the reviewed commit, beyond the one-line diff noted above.
- Batu's issue comments, the research library, and plan sections the criteria do not name.

## What would make it pass

Fix B1, B2 and B3, add tests for B1 and B2, rerun B3's case and both suites, and record the fixes. These fixes change class-high files, so this verdict cannot cover the fixed head. Under the gate now on `main`, a new verdict must name the fixed head, or a commit after which only class-normal paths change. That review can be scoped to the diff from the reviewed commit. The minor findings can follow in a later checked change; m4 and m6 are worth doing before the working session starts.

## Guard

This session's `tools/guard_report.py` at the time of writing: 1 denied, 52 allowed, 0 passed to the user, hash chain intact, last record #53. The denial was #6 (B4): a scratch-clone command with the clone path in a shell variable was treated as the live tree. It was repeated with literal paths (`git -C <path>`) and not routed around.
