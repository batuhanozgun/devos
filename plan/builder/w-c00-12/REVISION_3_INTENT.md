# W-C00-12 · Revision 3: intent and self-check, written before the work (write-ahead)

**Status:** write-ahead record (operating model §3.4). **Scope:** installation only. **Written:** 2026-10-03, committed 18:25:01Z (`git log`; the first text said 18:31Z, a typed estimate, corrected: F-042-1) by run `session_01XUsVQowRbLJdC1E8gFvxZq`, before any piece is rewritten. What git order shows (corrected after the critic, finding 15): at this commit (`9ae0081`) the piece files 02–05 were unchanged from `fe5e909` (`git diff fe5e909 9ae0081 -- plan/builder/w-c00-12/0[2-5]*` is empty), and the rewrite was committed later (`f362e95`). It does not show what the producer had decided before; the checks below are the fixed part.

## What revision 3 does

The R-W12-1 dispositions (`10_r-w12-1_dispositions.md`) group the 23 findings by four causes, K1 to K4. Revision 3 applies them:

1. **K1 (one text).** Pieces 02–05 are rewritten in place, with no "Revision 2" change-list sections. Superseded rules keep their IDs as retired rows, so references stay stable. A new test register (`11_test_register.md`) holds one row per mechanism. A new tranche plan (`12_tranche_plan.md`) assigns every mechanism to tranche 1, a later tranche with its trigger, or retirement. Pieces 06–08 are corrected where they disagree with 02–05.
2. **K2 (walk ordinary records through every check).** Each check in the register carries a "normal records" walk-through. This covers the current state file, a lease renewal, a log entry quoting old times, a verdict copied with `git show`, and the W-C00-06 translation.
3. **K3 (evidence about the design's own premises).** A fresh-context subagent re-reads L-016 to L-041 against a list of the premises the dispositions rest on. Each contradiction it finds is either answered in the revision or recorded.
4. **K4 (proportionality by timing).** Tranche 1 is limited to recurring failures and to what C00's heavy items need. Every other mechanism waits for a named trigger.

## Self-check, fixed now (the producer runs it; the narrow re-review judges it)

| # | Check | How | Pass |
|---|---|---|---|
| S-1 | Every R-W12-1 finding (B1–B7, M1–M8, m1–m8) has a location in revision 3 | a table in `12_tranche_plan.md` §4, one row per finding, naming file and section | 23 rows, none empty |
| S-2 | Every mechanism ID cited in 06 §3 adopted/merged rows, 07, 08, 11 and 12 resolves to a current rule in 02–05 or to a retired row with its successor | `plan/builder/w-c00-12/check_ids.py`, committed with the revision; output pasted into the log entry | prints `IDS OK` |
| S-3 | No "Revision 2" section remains in 02–05 | `grep -c '^## Revision 2' 02_memory.md 03_work_model.md 04_roles.md 05_continuity.md` | all 0 |
| S-4 | Every mechanism row in 11 has PASS and FAIL conditions, a scope and a tranche | the ID check also checks the register columns | no empty cell |
| S-5 | The B6 contradictions are gone: 07 H12 against stop reasons; 07 X-20 against markers; 08 role profiles; 06 §8 recovery role; 06 §4 and 07 H8 Critic; 07 B1 "R-R5 heritage"; 08 item 6 test ID | the critic subagent reads the revised set for contradictions, not only these seven | the critic finds none of the seven; its other findings are answered |
| S-6 | Leak check on the staged content | `git add` first, then `tools/check_service_names.sh` (F-041-2) | `SERVICE_NAMES CLEAN` |

## What it does not do

It does not implement anything. It does not change `.claude/**`, `CLAUDE.md`, the operating model or the state file's acceptance text. It does not re-enable the starters.
