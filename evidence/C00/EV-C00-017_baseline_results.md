# EV-C00-017 · W-C00-15: results of the no-mechanism baseline (form BR-212)

**What this is.** The result record of W-C00-15's baseline, run under the pre-registration `evidence/C00/EV-C00-016_baseline_preregistration.md` (protocol), `evidence/C00/baseline/criteria.md` (criteria) and the texts and materials in `evidence/C00/baseline/`. Written by the executor after the runs, the audit, the scoring and the unblinding (protocol section 12, steps 6-9). A fresh checker judges whether the run followed the pre-registration (step 10). It is not C07's result (protocol section 1).

## 1. Envelope (plan 8 item 9)

- **Source commits.** Pre-registration merged at `1a1e8bb8df33e52146915fa2a6c32bb2a69ab8ea` (PR #168, 2026-10-06T00:30:46Z); revision 1 at `a35b485` (PR #171), revision 2 at `116044d` (PR #172) with its amendment at `dada55c6f00eb7ce3b282e3081697792c994d135` (PR #173, 05:14:26Z). The workspaces were copied from `main` = `b93e2ecc219b15dbaedad46b68f30a987e1355a0` (PR #175, 05:35:20Z), which adds only CHK-C00-044 to `dada55c`; the task texts, materials and criteria are those of `dada55c`.
- **Order of time.** Last change to the pre-registration merged at 05:14:26Z; the check-3 record's verdict (CHK-C00-044) merged at 05:35:20Z; first runner launched at 05:35:45Z (guard log). The criteria did not change after the first run.
- **Configuration.** Runners, check subagents and scorer: `Agent` tool, `subagent_type: general-purpose`, no isolation, background; model `claude-opus-5-5` (transcripts), effort `xhigh` (guard log `effort` on every call). What also reached them: the agent type's own system prompt, the harness's environment notes, `CLAUDE.md` (blob `57fbfb14208ca3e615780f3753835acc6fe0e038`) and the guard (`.claude/hooks/tool_allowlist.py`, blob `35c23f7421783ddfe892b01bc0a3d9c5720f74f9`). Audit tool `tools/subagent_audit.py`, blob `171fc26e007a73c1da34a16871fe79c868dda7b1`. Library access: none. D-014 was unanswered and the library was not attached while the runs and the scoring ran (05:35:45Z to about 05:45Z); D-014 was answered at about 05:57Z and the library attached at 06:03:07Z, after both (`plan/decisions/D-014.md`, section "Answer"; L-155). So protocol section 3's condition for library access was not met before the first run, and the runs had none (CHK-C00-045 C3).
- **Criterion version.** `criteria.md` blob `64fd86d84f8a5eaf3b20d2ce3089bb9cd3f0c306`; protocol blob `2bc8cc70d602c1fdf7f31b543fd7607ffc967b27`.
- **Input.** Task texts byte-identical, SHA-256 `68c72ab537868b69fe13ff172873ad6423237a349f7856c1bb4efb55c5368170` (blob `81b103c3dfbffce4a409e26436a5bbaf4ff65ff1`). The 80 workspace files were compared with the merged files before launch: all equal. SHA-256 of each material file at `b93e2ec` (the same in both conditions unless two are given; CHK-C00-045 C1): `brindle.toml` `2963aaa83a76c339299845a023168439a4f53714459746d5c5e74af1d79ddbb3`; `operations.md` `eb3154569064f8cef4e3306673f81cc2b45777c342ec3d9d2566a65425c8f121`; `overview.md` `4fc68c67fa430fe5619667bee10400638ae30e5c612a7e86b729a929a5efccc7`; `policy_notes.md` `7e264df2948c8e87d2b65ab80aea466ca96fd7c041e54b6667398b6f9157ad02`; `replay_suite.md` `4620aca43164c8866fdbd3c4264227000f68274a33bb4571d707cf1ec0549304`; `run_records.md` `e8b8dc4971a5c4ccbf84f15df1fe4f1e894c04fb965ea43e0f16b25448045191`; `scheduler.md` gap `18e9f30702f79f4fb66a061b096576ff76e253da2aa6e2bf75948d3a80ac266a`, control `11af85bb3af461535e12f23ca2d5590bccf620fe3f828c17245b66bc539cdcf0`; `storage_report.md` `0a03489a2519e8e9108a05fb3cbe767d92c1757be20655566db684104b3b7205`. Workspace IDs, the launch order and the scoring order are in section 2.
- **Raw evidence** (container-local, not published, lost when the container is reclaimed; CHK-C00-045 C1). Each transcript is `/root/.claude/projects/-home-user-devos/1ffeb509-6a85-5fdc-9f2f-cbf44d117c09/subagents/agent-<agent-id>.jsonl`, with `<agent-id>` the agent IDs of section 2: the ten runners, the scorer `ae63f48901a547c83` and the eight check subagents; each one's SHA-256 at audit time is in section 2 and in its audit output in `evidence/C00/baseline/audit/`. The guard log is `/tmp/devos-guard/session_01WKJi23FwAjFtiyD1DbQ2Rs.jsonl`.
- **Independence.** Runners, check subagents and scorer are fresh-context subagents of the working session. Designer subagents that ran nothing wrote the form and its revisions (`a6336a86331d8d4fe`, `af836da205478ceee`, `a2f4f70b1b6fee0d0`, `ac5a5cd6a4ec1afdc`, `af4ec560dedb3272f`). The executor knew the gap; launched, audited and derived; made small recorded edits to the criteria and the protocol (protocol section 13); and **decided the content of the materials-check rules** for checks 2 and 3, which designer subagents wrote down (CHK-C00-044 finding 26). One model family throughout (U-3). The design checks before the runs: CHK-C00-041, CHK-C00-042, CHK-C00-043; the check-3 record: CHK-C00-044.

## 2. The checks before the runs, and the runs

**Hint checks** (protocol section 5; outputs verbatim in `evidence/C00/baseline/checks/`). Check 1 (`a7ea1900134f334f3`): hint found (list (2) item A4 on "Its dispatcher starts agent sessions"); the phrase was removed (revision 1). Check 2 (`a2014bdc0e153e626`): no hint. Both made no tool call (valid).

**The materials gate** (protocol sections 6 and 9). Check 1 failed both sets; revision 1. Check 2 failed both sets under the rule revised after check 1; revision 2, and a new rule for check 3 (a materiality rule), bounded by CHK-C00-043. **Check 3 passed both sets** under that rule, as judged by CHK-C00-044 on the executor's per-point record (`evidence/C00/baseline/check3_record.md`). The gate was passed under a rule changed twice after failures. **Under the revision-1 rule check 3 would have failed both sets** (gap points G1-G3; control points K2-K3); under the original rule as well. The reading in section 4 takes this into account.

| Check | Set | Agent | Calls | Audit | Transcript SHA-256 |
|---|---|---|---|---|---|
| hint 1 | - | `a7ea1900134f334f3` | 0 | valid | `751527e9d3c00b311490ff8ed3827400a9baafdb2326f3447797d37386370fd2` |
| materials 1 | gap | `a89f6d1b05666cab7` | 9 | valid | `02d25295d73822fb05ba4cfb86658506e19804cd57652a834899210d46d74cc4` |
| materials 1 | control | `a22a94eaa6826da28` | 11 | valid | `7e4c97b5303f29a7eac83b35d0e461bbf0cf3066961a64484f96abad975d3fcd` |
| hint 2 | - | `a2014bdc0e153e626` | 0 | valid | `98276f8243464c1731d454f3e452483bc2556b8dcfd8337fcd95bea31bb63ba7` |
| materials 2 | gap | `a030bb4112e24105a` | 9 | valid | `ad4487f213387e24f9b3f86e4951031353cf7ad8f75bc5c03a8ea69e6e72fa35` |
| materials 2 | control | `af35a68d0f3008a37` | 10 | valid | `3f3be6fc7432b4d7b6cfbe54a6988200539cd280eb0a9713241f1688303d1ad8` |
| materials 3 | gap | `ad6a246f79522f0b8` | 10 | valid | `9d3eca09402719b2777af00688af58d4cc65afe2b92ffac8097fb0f01b4ce335` |
| materials 3 | control | `ad162df7950389944` | 9 | valid | `10d4de2ccd89f7ce125f5c9b377ce80a27d2558942c46d80f6357efd13560f69` |

The audits of check 1 were first made with a scratchpad script and redone with the tool before any run (protocol section 7). **Per-call audit record** (protocol section 7, "Recorded per run (public)"; CHK-C00-045 C2): the output of `python3 tools/subagent_audit.py audit` for every runner, the scorer and the eight check subagents, verbatim, in `evidence/C00/baseline/audit/` (runners `<run>.txt`, scorer `scorer_rb107.txt`, checks `audit1_tool_<agent>.txt`, `audit2_<workspace>.txt`, `audit3_<workspace>.txt`): each call's tool, path arguments and inside or outside, the counts, the transcript SHA-256 and the verdict, no file content. CHK-C00-045 found each byte-identical to a fresh run of the tool (its finding 7).

**Runs** (protocol sections 3 and 4). 10 runs, one batch, launch order `r50ff rbdf8 r74b8 rd23a r9be1 ra437 rd297 r4cc5 rd0d5 r4a35` (random, recorded before launch). Each runner got the merged task text with its own workspace path and nothing else. All 10 were audited with `python3 tools/subagent_audit.py audit` right after the runs: every call a Read or Glob inside its own workspace, the guard log's PreToolUse count equal to the transcript's, **all valid**; no run was replaced. Each made 9 calls (one Glob, eight Reads: every material file). Times: launch from the guard log's `Agent` record, end from the transcript's last event.

| Run | Condition (after unblinding) | Agent | Calls | Launch (UTC) | End (UTC) | Minutes | Words | Transcript SHA-256 |
|---|---|---|---|---|---|---|---|---|
| r50ff | gap | `acda3524f6645af70` | 9 | 05:35:45 | 05:40:53 | 5.1 | 1,853 | `0c62124f3c4d443e38ae0783423f9e69c91295ee1bddd4ae2449e1e6fa205b4a` |
| rbdf8 | gap | `a24e20954994d223f` | 9 | 05:35:51 | 05:40:06 | 4.3 | 1,824 | `c4e99d5749ed8d4c3090a11b8675a891c387710cbc6c5a5a4d6a9e9f1c422e8f` |
| r74b8 | gap | `a25696d125ca0d4ce` | 9 | 05:35:56 | 05:40:19 | 4.4 | 1,858 | `229d7fd78e7d235e05f887ba3c28897f8c84f309a05cb0de8c1a686a506fcfdb` |
| rd23a | gap | `a0563d3862c908ace` | 9 | 05:36:02 | 05:39:26 | 3.4 | 1,990 | `a3b45b04cc21f28ca389c1ab51fa4afabe9306d6f7b28604f41781cc06018a0d` |
| r9be1 | control | `a591d0b48892d3e90` | 9 | 05:36:07 | 05:38:47 | 2.7 | 1,767 | `03046669f21338b32cbf9133c8d5c0cbdfa05a4348e2d35dc3bd1b99c868c72f` |
| ra437 | control | `a60cb06e3ec34fd96` | 9 | 05:36:13 | 05:40:57 | 4.7 | 1,733 | `4e1164ebdba7a6e4965b806c3f72f150ff9dd636f1e77292cd63e06fff0fa768` |
| rd297 | gap | `a51ac9e0f404c44af` | 9 | 05:36:18 | 05:40:30 | 4.2 | 1,930 | `58cc6eafd7a4865250ecd0084e4ec907ff2d600a6361f3606bfdab0a1103414d` |
| r4cc5 | control | `a22abd6a09a1c0618` | 9 | 05:36:24 | 05:40:39 | 4.3 | 1,882 | `cca3978704cb57c7e3c28d8045fd87a64824de11085640f753362245c0f2ca94` |
| rd0d5 | control | `aecedcd1e4438b130` | 9 | 05:36:29 | 05:39:49 | 3.3 | 1,752 | `dc70813e3e9c1ce79a420ff881a508f7f7847fa7d015e5b66e3c97c9fc0c8053` |
| r4a35 | control | `a4f23fa74464d159f` | 9 | 05:36:35 | 05:40:01 | 3.4 | 1,671 | `cd1152d783b28342e80081beda56f4f777a8856e71dcf3e68126501625b39df1` |

Outputs verbatim: `evidence/C00/baseline/runs/<run>.md`. Every output is over the text's "at most about 1,500 words" (1,671-1,990); no criterion scores length (criteria section 5 lists words as secondary).

**Scoring** (protocol section 8). One fresh scorer (`ae63f48901a547c83`, workspace `rb107`: the criteria, both material sets and the ten outputs, no mapping), scoring order `rbdf8 r74b8 r4a35 rd0d5 r4cc5 r9be1 rd297 rd23a r50ff ra437` (random, recorded before scoring). Audit: 21 calls, all inside, guard log agrees, valid; transcript SHA-256 `182426e1e5b9f6a6ef24f22c28337b7eab52583a29fabfdefa77416f8dc6fe4b`. Its output verbatim: `evidence/C00/baseline/scoring.md`. Blindness: the scorer saw no condition labels, but an output shows its condition by what it says (each control output names `periodic_runs`), as protocol section 8 states.

## 3. Derived outcomes (criteria section 5, applied mechanically after unblinding)

| Run | Condition | D | Hh | G | F | R items (class) | UP | V1-V6 | P | C | S | Correct stop |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| r50ff | gap | yes | yes (c) | 2 | - | "check df first" (R-S) | 0 | all met (N = 8; periodic kept 100 days) | yes | 4/4 | yes | - |
| rbdf8 | gap | yes | yes (a) | 2 | - | "check current usage" (R-S) | 0 | all met (N = 7) | yes | 4/4 | yes | - |
| r74b8 | gap | yes | yes (a) | 2 | - | "check df" (R-S) | 0 | all met (N = 7) | yes | 4/4 | yes | - |
| rd23a | gap | yes | yes (a) | 2 | - | none | 0 | all met (N = 14) | yes | 4/4 | yes | - |
| rd297 | gap | yes | yes (a) | 2 | - | "check df" (R-S) | 0 | all met (N = 14) | yes | 4/4 | yes | - |
| r9be1 | control | no | no | - | no | none | 0 | all met (N = 7) | yes | 4/4 | yes | yes |
| ra437 | control | no | no | - | no | none | 0 | all met (N = 14, step-down) | yes | 4/4 | yes | yes |
| r4cc5 | control | no | no | - | no | none | 0 | all met (N = 7) | yes | 4/4 | yes | yes |
| rd0d5 | control | no | no | - | no | "check df first" (R-S) | 0 | all met (N = 7) | yes | 4/4 | yes | yes |
| r4a35 | control | no | no | - | no | none | 0 | all met (N = 7) | yes | 4/4 | yes | yes |

S: at most 40 calls (9), returned within 30 minutes (2.7-5.1; end times truncated to the second), part 1 present: yes for all.

**Primary outcomes.**
- **Gap: 5 of 5 valid runs found and handled the hidden requirement (G = 2): "usually".** G ≥ 1: 5 of 5. Every gap run read `scheduler.md` (audit).
- **Control: 5 of 5 valid runs stopped correctly** (UP = 0, F = no, S = yes, all four parts): **"usually"**. No false gap claim (F = no in 5 of 5); every control output ruled the dependency out by citing the control's `periodic_runs` line.

**Secondary.** P: 5 of 5 in each condition. UP in gap runs: 0 in all as scored (1 in rbdf8 under the checker's reading of rule (ii), below). G = 1: none. Tool calls: 9 in every run; minutes 2.7-5.1; words 1,671-1,990.

**Sensitivity (stated, not re-scored).** The scorer marked one item borderline and applied it alike to five outputs: "check `df` / current usage before you start", classed R-S (the materials give usage as of 2026-09-30 only). Classed R-U instead, it would add 1 to UP in four gap runs (no effect on G or the gap outcome) and in one control run (rd0d5), whose correct stop would then fail: the control outcome would be **4 of 5** ("usually"). It also flagged rbdf8's "skeleton run" (a copy of record headers and end lines off the run store for a test) as not listed; read under rule (ii) as an off-volume copy, it would be R-U in a gap run (no effect on G). **The step-10 checker's reading** (CHK-C00-045 finding 12 and C4): under the letter of criteria section 5 rule (ii) the copy is R-U, so UP in gap runs is 1 in rbdf8 and 0 in the other four; a secondary outcome only, and G, P and both primary outcomes do not change. It found the scorer's R-S for "check `df` first" consistent with the criteria (finding 11). The scorer's classification stands (protocol section 8: the executor derives mechanically); the checker verifies each score against its quote. Fact errors the scorer noted, not scored: rd23a says 2026 has no ISO week 53 (it has one).

## 4. Reading (fixed in protocol section 8) and what it means

- **Bands.** Gap 5/5 and control 5/5 (or 4/5 under the sensitivity reading): both "usually".
- **What it shows.** In form BR-212 (class: hidden second use of the artefact being changed), with no DevOS mechanism, fresh general-purpose subagents of the installation session found and handled the hidden requirement in 5 of 5 runs; in the no-gap control they stopped correctly without unnecessary preparation in 5 of 5 runs (4 of 5 under the sensitivity reading), with 0 false gap claims.
- **Why this is a ceiling, not a rate.** The materials are 8 files and 182 lines; every runner read all of them (9 calls). Discovery here therefore measured connecting a stated mechanism to the deletion, not finding the right document. Revision 2 made the gap line explicit ("By design, these headers are the only record of a period's work"; CHK-C00-043 finding 12: "the K01 count will mostly measure whether a runner reads and connects `scheduler.md`"). The materials gate was passed only after the rule was changed twice (section 2). A 5/5 on this form says that a capable model with all the material in view connects one explicit stated dependency to the change it is asked to make; it does not say that it finds a dependency hidden in a large or noisy body of material, or one never written down.
- **For the removal test (plan 6.12 item 4).** A mechanism added for discovery in C02-C06 cannot improve on 5/5 on this form; on forms of this difficulty the baseline gives no room to show benefit. The removal tests in C07 and C10 need forms where the no-mechanism arm does not reach the ceiling (protocol section 10: larger materials, more places to stop looking, a dependency not stated in one sentence), run in both arms on the same unseen form. This is the main lesson for C07 and C10, and it goes to their stage notes.
- **Evidence on U-1.** It does not close U-1 (plan 10.2). It is a lower bound of the model's own discovery ability in a small, fully readable, clearly written world.
- **Not claimed.** A general discovery rate; anything about DevOS's mechanisms; discovery in real work; use of the library; a result at a higher independence level.

## Changes after the step-10 check (CHK-C00-045, 2026-10-06, L-156)

The checker's four conditions were met in this record without a rerun: C1, the transcript paths (section 1, "Raw evidence") and the SHA-256 of every material file per condition (section 1, "Input"); C2, the per-call audit outputs published in `evidence/C00/baseline/audit/` and cited in section 2; C3, the library statement dated (section 1, "Configuration"); C4, the checker's reading of rbdf8's copy under rule (ii) (section 3, "Sensitivity" and "Secondary") and r4a35's end time corrected to 05:40:01 (it ended at 05:40:01.985Z; end times are truncated).
