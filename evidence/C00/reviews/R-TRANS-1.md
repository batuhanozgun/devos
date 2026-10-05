# R-TRANS-1: independent review of the transition bundle (PR #146), round 2

**Verdict:** PASS

- **Reviewed commit:** `3033031d6bc28f468c92c3e141b3d36225fa8dd5` (branch `claude/transition-bundle`).
- **Reviewer:** session `session_018tWKmQrqh88xvkwXF2jYtA`. It is a separate review session: it did not produce the bundle and did not see the producer's conversation.
- **Date:** 2026-10-05 (UTC).
- **Scope of this round.** The diff from the round-1 commit `dbb24b5b6592cce4cf9cf58da308077c546fcef1` to the reviewed commit. That diff contains:
  - the producer's fix commit (L-133);
  - a merge of `main` that adds this reviewer's recorder line to `.claude/hooks/owned_ids.txt`.

  Round 1 judged the whole bundle at `dbb24b5`, and this round judges the whole diff since then, so together they cover the bundle at the reviewed commit. The producer set this round's scope: a new finding blocks only if one of the fixes introduced it. I accepted that scope. Nothing outside it that I saw changes this verdict.
- **Criteria:** the same four as round 1: (1) fidelity to D-010; (2) plan fidelity; (3) safety of the merge gate and the guard; (4) the single-session way for a new working session.

## Round 1, in short

Round 1 judged `dbb24b5` and returned FAIL. Plan fidelity (criterion 2) was met. Three blocking findings:

- **B1.** The new merge gate decided by path alone, so a changed or removed acceptance block in `plan/work/` merged without a verdict. That went beyond D-010 item 28 and the D-008 assurance.
- **B2.** A verdict already on `main` covered a later pull request, for example a revert of a later reviewed fix: a verdict for another head.
- **B3.** `tools/stop_check.sh` required branch `main`, so a detached or `claude/` checkout could never reach `STOP_CHECK PASS`, and the installation `/goal` could never be met.

Round 1 also listed nine minor findings, m1 to m9. That version of this file is on this branch's history (commit `8219e56`).

## Checks run at the reviewed commit

| Check | Result |
|---|---|
| `python3 tools/test_merge_gate.py` | `MERGE_GATE_TEST PASS (24/24)`. The new cases are 14-19b; they plant probes P1-P4 of round 1. |
| `bash tools/test_tool_allowlist.sh` | `ALLOWLIST_TEST PASS`: 618 `ok`, 0 `BAD`. Run in a clone with a GitHub origin, on the pushed branch. |
| Round-1 probes P1-P4 (same script, the reviewed commit's gate and fixture) | **P1** (loosened acceptance block, no verdict): `class high: plan/work/W-C00-99.md (an existing acceptance block changed or removed)`, `GATE FAIL`. **P2** (revert of a later reviewed rule, no verdict of its own): `GATE FAIL`. PRs A and B with their own verdicts still `GATE PASS`. **P3** (repeated `verdict:` key): `no front matter, or a key repeats in it`, `GATE FAIL`. **P4** (nested `plan/CLAUDE.md`): `class high: plan/CLAUDE.md`, `GATE FAIL`. |
| New probe of the legitimate flow (does the B2 fix break it?) | A class-high change X is judged and its verdict added, then `main` with only a recorder line is merged into the branch: `GATE PASS`, covered by the PR's own verdict. Then a `main` with a class-high change is merged in: `GATE FAIL` (`X..head touches class-high paths: tools/merge_gate.py`). That is fail-closed, so a new verdict is needed after merging a class-high `main`. |
| B3 case: the reviewed commit's `tools/stop_check.sh` in a fresh clone of `main` | Detached at `origin/main`: `PASS HEAD equals origin/main`, `STOP_CHECK PASS`. On a `claude/` branch at `origin/main`: `STOP_CHECK PASS`. Detached at an older commit: `FAIL HEAD is not at origin/main`, `STOP_CHECK FAIL`. |

## Blocking findings of round 1

### B1 · resolved

`high_paths()` now makes two record changes class high:
- deleting a `plan/work/*.md` file (renames count too, through `--no-renames`);
- changing or removing the text of an existing `<!-- acceptance -->` block (`acceptance_blocks()`).

Adding a block where none existed stays class normal (test 16), so the WO's stage work list and new item files still merge without a verdict. M7's text again names acceptance conditions. WO section 4, step 5 and D-008's update describe the trigger. The other old record triggers (cancellation, `depends_on`, ledger rows) stay retired. D-008's update says so openly, and round 1 called restoring them optional.

### B2 · resolved

`cover()` counts only verdict files that the pull request adds or changes (`p in in_pr`). It refuses a `reviewed_head` that is an ancestor of the merge base, which also refuses a reviewed commit equal to the base.

- Probe P2 and test 19: the plain revert fails.
- Test 19b: a verdict the pull request adds for a commit already on `main` fails.
- The intended flow still passes, as the new probe above shows.

### B3 · resolved

The check is now "HEAD equals `origin/main`", whether on a branch or detached. The branch name is printed as information only.

## New findings introduced by the fixes

None blocking. I looked for regressions and found these behaviours, all of them fail-closed:

- An unclosed `<!-- acceptance -->` marker makes the rest of that file count as the block.
- A whitespace-only edit inside a block is class high.
- A block added beside an existing one is class high.
- Merging a class-high `main` after the verdict needs a new verdict.

## Round-1 minor findings

- **m1** (repeated key): fixed. Fails closed; test 17.
- **m2** (nested `CLAUDE.md` or `.claude/`): fixed. Test 18.
- **m3** (the gate checks a verdict's form, not its origin): fixed. One line in WO section 10 and in D-008's update.
- **m4** (checker step 2): fixed. "unless your task limits what you may see; then read only what it names".
- **m5** (the goal field in the opening check): fixed. The goal is recorded as shown; the evidence is the session's own first message; plan work stops only if that message is not Ek F's `/goal`.
- **m6** (who is the executor): fixed in `CLAUDE.md` and the WO header. The executor is the session whose first message is Ek F's `/goal`, and other sessions do not run the work loop.
- **m7** (the re-read hook): fixed. The hook points to the whole list in WO section 3.
- **m8** (`DURUM.md` and `summary_tr` before the hand-over): still open. L-133 defers it to the hand-over (D-010 step 5). Do it there, before Batu opens the working session.
- **m9** (dangling pointers): fixed for the PC-04 title and its ledger row, `tools/sync_worktree.sh` and `tools/guard_report.py`. The `676a116` versus `f51e7e0` history citations remain; both commits hold the files, so this is harmless.

## Remaining minor notes (do not block)

- **n1 · L-133, "Review loop bound".** The entry opens with "(Batu, 2026-10-05: branches may grow but must not leave the line)", then states a rule: a re-review covers only the fix diff, a new finding blocks only if a fix introduced it, and there is at most one more round. That rule is the builder's application of Batu's principle (summary items 2 and 7), not his words. As written it can read as his rule. Suggest stating it as "builder's bound, from summary items 2 and 7". The log is append-only, so this would be a correction entry.
- **n2 · L-133, "returned FAIL at 19:40Z".** Consistent with the push of round 1. No change needed.

## By criterion, at the reviewed commit

1. **(1) Fidelity to D-010:** met. The merge gate is kept with only its verdict source changed, and the acceptance-condition coverage that D-008 gave is restored (B1). Round 1's other findings under this criterion stand: no growth beyond the stop check, which is now correct.
2. **(2) Plan fidelity:** met (round 1). The fix diff touches no plan text and no acceptance block.
3. **(3) Safety:** met.
   - The gate fails closed.
   - A verdict for another head no longer satisfies it (P2, tests 19 and 19b).
   - The class-high path set is kept and widened to nested rule files.
   - The guard's rule logic is unchanged except M7's tool; the fix diff changes only M7's text in the guard.
   - Both suites pass.
4. **(4) A new working session:** met. It follows the single-session way; nothing in the repository pulls it back to the session chain (round 1); its stop check can now pass (B3); and how it knows it is the executor is now stated (m6).

## Not checked

The round-1 list still applies:
- how an app-opened session's checkout starts (B3 no longer depends on it);
- `/goal` behaviour and limits;
- whether the `SessionStart` hook with matcher `compact` fires in a cloud session (N-058);
- subagents' loading of `CLAUDE.md`, and the tool restriction of `tools: Write`;
- M7 on a real GitHub merge (only the fixture, with a local bare origin).

Not reviewed in this round: anything outside the diff from the round-1 commit to the reviewed commit, and any commit after the reviewed commit.

## Guard

This session's `tools/guard_report.py` at the time of writing: 1 denied, 67 allowed, 0 passed to the user, hash chain intact, last record #68. The only denial is #6 (B4) from round 1, repeated with literal paths and not routed around.
