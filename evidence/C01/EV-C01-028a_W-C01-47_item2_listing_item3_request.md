# EV-C01-028a · W-C01-47: item 2's listing in pull request #261, item 3's request, and the Claude Code version (2026-10-12)

**What this is.** A record the interim verdicts asked for: CHK-C01-107 C1 and CHK-C01-108 C3 (pull request #261's description and the request on issue #6, which neither checker could read), and CHK-C01-108 C2 (the Claude Code version, against a further routine run). Written by the executor of the working session `session_01XyxvJd3RayQk4HCrjurbVH` (L-271).

## Evidence envelope (plan Section 8 item 9)

| Field | Value |
|---|---|
| Source commit | `main` `3301de707169de7dc715e42dc1b2bc7a30775585` when read |
| Deployment configuration | The GitHub tools of the working session, on `batuhanozgun/devos` only; `get_session` of the working session |
| Criterion version | W-C01-47's block (SHA-256 `7dbb5f25…` as the interim verdicts give it); CHK-C01-106 C1; CHK-C01-107 C1; CHK-C01-108 C2 and C3 |
| Input | `pull_request_read` (method `get`) on #261 and #262, and the comments of issue #6, read at about 08:45Z to 08:50Z on 2026-10-12; `get_session` at 08:36Z |
| Actual observation | Sections 1 to 3 |
| Raw evidence ID | Pull request #261 (head `5012f79cbd6b6373fdd40c3c4a20b0452ac11bb7`, base `56d1ac7`, merge `53d28fe`); pull request #262 (merge `0befba6`); issue #6 comments `6120564296` and `6120677086` |
| Independence level | The executor's own reading, same session; a fresh-context checker judges it with W-C01-47's accepting check (declared, Ek A 5.3) |

## 1. Pull request #261's description (CHK-C01-106 C1; CHK-C01-107 C1; CHK-C01-108 C3)

Created at 2026-10-12T08:14:26Z and merged at 08:14:34Z, so the description was in place before the merge. Its text as the GitHub tools return it, without its two closing attribution lines:

```
W-C01-47 acceptance block item 2 (removal from the repository), class high. Judged at its head `fdb6824e8555cacdb08368016850041771cdee75` by CHK-C01-106 (PASS-WITH-CONDITIONS; this description meets its condition C1). Merged only after the combined scenario's second run (CS2) closed, as block item 1 requires.

**Removed by this change**
- The probe skill (W-C01-20): the only directory under `.claude/skills/`. It was offered to every session of the repository; after this change `.claude/skills/` no longer exists.
- In `tools/test_tool_allowlist.sh`, the repository-skill allow control that was skipped when `.claude/skills/` held no skill is **replaced, not removed**: the controls now run in a fixture checkout (a copy of the guard and one made-up skill directory), always, through the settings command, decided by rule T4; once the fixture skill's directory is removed, the same Skill call is denied.

**No probe-only guard rule exists to remove.** W-C01-04 (the probe-only guard rule) was cancelled (W-C01-31); the guard's rules (G0, T1–T4, M1–M7, S1–S5, F1–F5, B1–B11, L1–L3) are all general, and `plan/Installation_Working_Order.md` section 10 names no probe-only rule as in force (CHK-C01-106 findings 3 and 4).

**Kept as evidence, not removed:** the routine's control file `evidence/C01/routine/CONTROL.md` (its section 6 holds the synthetic inputs), `evidence/C01/routine/ROUTINE_DESIGN.md` (Batu's steps 25 to 37, needed for block item 3), `evidence/C01/routine/AFTER_K.md`, and the runs' records under `evidence/C01/routine/runs/` and on the `claude/probe-c01-…` branches.

**Unchanged:** `.claude/hooks/tool_allowlist.py`, `.claude/settings.json`, `tools/guard_report.py`.

**Tests at the head (CHK-C01-106 finding 6):** `ALLOWLIST_TEST PASS` (820 ok, 0 BAD, no SKIPPED line), `MERGE_GATE_TEST PASS (24/24)`, and the other `tools/test_*.py` all pass.

**This pull request also adds** `evidence/C01/checks/CHK-C01-106.md` (the verdict, verbatim), a class-normal commit after the reviewed head.
```

It carries the three parts CHK-C01-106 C1 asks for: (a) each thing removed (the probe skill, W-C01-20, and `.claude/skills/` gone; the skipped test replaced, not removed); (b) no probe-only guard rule exists to remove (W-C01-04 cancelled); (c) the control file, its synthetic inputs and the runs' records stay as evidence.

## 2. Item 3's request on issue #6 (CHK-C01-108 C3)

- Pull request #262, which merged item 1's record, merged at 2026-10-12T08:26:53Z. The request, comment `6120564296`, was posted at 08:27:11Z: after item 1's record.
- It tells Batu the probes are done, and asks, step by step with what he should see after each step (Appendix E section 7), first to delete the routine `devos-c01-rutin` (its steps 1 to 5) and then to remove the line `DEVOS_ENVIRONMENT=devos-kurulum` from `devos-kurulum`'s settings (its steps 6 to 12), and to report (step 13). Its 13 steps are steps 25 to 37 of "Batu's step" in `evidence/C01/routine/ROUTINE_DESIGN.md`, word for word, numbered from 1.
- Batu reported at 08:35:04Z, comment `6120677086`: "rutin ve satır silindi" ("the routine and the line deleted").

## 3. The Claude Code version (CHK-C01-108 C2)

- `get_session` of the working session at 2026-10-12T08:36Z: `external_metadata.container_cc_version` `2.1.296`. W-C01-10 and EV-C01-008 recorded `2.1.296`. The version has not changed, so W-C01-10's rule ("if either changes before C01 closes, this probe part is observed again") needs no further routine run now, and none was needed before the routine's deletion was relied on.
- **Residual.** W-C01-30 point 8 compares the version again at the stage close. If it changes before then, row 4's probe part would need a session started by a routine; the routine is deleted, so that need would go to Batu as a decision (a routine created again) before the stage close, not be met silently.
