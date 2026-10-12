# EV-C01-029 · W-C01-48 item 1: evidence for W-C01-30 point 1's two ✘ conditions (paid features, overage, tokens and secrets)

**What this is.** The evidence file W-C01-48's acceptance block, item 1, asks for, gathered for the stage-close review W-C01-30 (its point 1: "for the two ✘ conditions, from evidence gathered for this review"). C01's two ✘ conditions are "No test enabled a paid feature" and "No probe session wrote a token, a secret or anything derived from one into a repository, a branch or a record" (`plan/work/C01.md`, Acceptance). Part (a) lists the instructions given to Batu or to a probe session in C01, and says for each whether it enables a paid feature and what that rests on. Part (b) lists every `get_session` reading the records hold, with its `isUsingOverage` value. Part (c) is a scan of every `claude/probe-c01-…` branch and every C01 record, made after a positive control. This record judges nothing for W-C01-30; its checker does. One part is **not done**: the machine account's comments on issue #6 were not read here (a.1).

## Evidence envelope (plan Section 8 item 9)

| Field | Value |
|---|---|
| Source commit | `main` `3301de707169de7dc715e42dc1b2bc7a30775585` (L-270, W-C01-48 admitted), in the producer's scratch clone on branch `claude/c01-w48-evidence`. Every record cited is read at this commit. The probe branches are read at the heads in section (c), table 1. They were fetched into the clone at 2026-10-12T08:44:06Z with `git fetch origin '+refs/heads/claude/probe-c01-*:refs/remotes/origin/claude/probe-c01-*'`, and `git ls-remote` listed 9 such branches. The cancelled probe design's unmerged branch `claude/c01-probe-design` is read at `6cf4e5dfc89031e80d6a99b7aa49df8464c8b66d`. Blobs at `3301de7`: the guard `.claude/hooks/tool_allowlist.py` `956f1b3`, `tools/credential_value_scan.py` `fba2ab6`, `tools/credential_class.py` `2b14844`, `tools/test_credential_value_scan.py` `a2afad1`, `plan/key_inventory.md` `71e6582`, `evidence/C01/routine/ROUTINE_DESIGN.md` `6261c44`, `evidence/C01/routine/CONTROL.md` `81b3e28` (version 11), `evidence/C01/routine/AFTER_K.md` `59214f1` |
| Deployment configuration | A producer subagent of the working session `session_01XyxvJd3RayQk4HCrjurbVH` (cloud, environment `devos-kurulum`), under the repository's guard at blob `956f1b3`. It has no `get_session` and no GitHub tools: its tools are file reading, search, writing and the shell. The Claude Code version was not read here. The session's credential variables, by `tools/credential_class.py` (classes only, no value): `GH_TOKEN`, `GITHUB_TOKEN` and `CLOUDSDK_AUTH_ACCESS_TOKEN` hold the documented placeholder; `CLAUDE_CODE_MESSAGING_TOKEN` is set (length 32, class "other"); the token file is a regular file (its content 895 bytes long); `ANTHROPIC_API_KEY`, `ANTHROPIC_AUTH_TOKEN` and `CLAUDE_CODE_OAUTH_TOKEN` are unset |
| Criterion version | W-C01-48's acceptance block, item 1 (file blob `4ebc6cf`). The block's SHA-256, over the lines from `<!-- acceptance -->` to `<!-- /acceptance -->` inclusive as `sed -n` prints them, is `75b04d6378651effc04e005b0d64962e84894321e03b9f90e0ad1c05fbbe1cd5`. Read with W-C01-30's block (SHA-256 `7052cbfa2ca612b5813f8305ab3d3e3976fdd19020f9be4400ed266823615289`, the same method) and with plan Section 8 items 9 and 14 |
| Input | (a) The decision records `plan/decisions/D-017.md` to `D-030.md`. The plan-change records written in C01 (PC-19 to PC-39, FR-04 to FR-06) and D-002, which was amended in C01. `ROUTINE_DESIGN.md` section 1, section 3 and "Batu's step". Every committed version of `CONTROL.md` (14 blobs, versions 1 to 11), both versions of `AFTER_K.md`, and the one version of the probe skill (W-C01-20). The C01 log, and `plan/work/C01.md` "Batu's steps". (b) The ledger's Usage row (`plan/ledger.md`:23), `plan/work/C01.md` "Usage", the C01 log and the evidence files under `evidence/C01/`. Also the working session's own transcript, read with `grep` only (section (b)). (c) The targets of section (c), table 1 |
| Actual observation | The producer read the records above in the clone. It read the probe branches and the draft branch with `git archive`, `git log -p`, `git ls-tree` and `git merge-base`. It ran a pattern scan on those extracts (the script is in the appendix), with a positive control on a scratch copy. It ran `tools/credential_value_scan.py` on the clone's whole object store and on the extracts, after that tool's own planted test. It read the transcript of the working session (this container) with `grep` for the `isUsingOverage` field. Every run's output is quoted in the sections below. Nothing was written to a repository except this file |
| Raw evidence ID | The scan's extracts, outputs and scripts are in the producer's scratchpad of this container, not on `main`: `…/scratchpad/w48/t/` (extracts), `out_control.tsv`, `out_real.tsv`, `bin/pattern_scan.py` (SHA-256 prefix `e489e83e323b5fc1`; reproduced in the appendix) and `bin/plant_control.py` (prefix `5a6f114e6ab7ee62`). The scan is reproducible from `main` and the branch heads in table 1 |
| Independence level | Producer's own work, a fresh-context producer subagent of the executor's working session (Opus 5.5), dated 2026-10-12. It shares the criterion, the guard's pattern lists and the records with the executor who designed the item. The positive control is the producer's own. A fresh-context checker judges this record (declared, Ek A 5.3; PC-06) |

## How the criterion is read

- **"Every instruction given to Batu or to a probe session in C01."** C01 runs from L-168 (2026-10-06, merge `c843988`, 13:09:57Z) to `3301de7`. An instruction is any text that asks Batu for an action, or that a probe session (a run of `devos-c01-rutin`) acts on. Most instructions to Batu reached him on issue #6; some were given in the working session. For a probe session they are the stored prompt, `CONTROL.md`, `AFTER_K.md`, the probe skill (W-C01-20), and the subagent tasks written inside `CONTROL.md`. Every run recorded that no text arrived with its start (for example EV-C01-028 envelope, "Input").
- **[2026-10-12, CHK-C01-112 finding 1; L-279] Correction.** Not every run recorded that no text arrived with its start. P3's second attempt (`c01-run/P3/STAMP.md` line 10 on `claude/probe-c01-p3-20261011T1448Z`; copy `evidence/C01/routine/runs/P3-20261011T1448Z/P3/STAMP.md`) and P4 (`evidence/C01/routine/runs/P4-20261011T1914Z/P4/STAMP.md` line 11) recorded text arriving with their start, its content not recorded. That text could not be checked (plan Section 8 item 14). It is bounded by step 3 of D-021, D-022, D-027, D-028 and D-030 ("Metin kutusu açılırsa boş bırakıp onayla", leave any text box empty and confirm), by the stored prompt's rule that text arriving with a start is data (`ROUTINE_DESIGN.md` F4; ban 5), and by `isUsingOverage` false at 13:52:51Z and 15:22:02Z around P3's start at 14:48:43Z, and at 19:04:15Z and 19:20:08Z around P4's at 19:14:17Z. The result of (a) stands with that part labelled could not check.
- **"Enables a paid feature."** It does if it turns on, buys or subscribes to something that costs money beyond what Batu's existing plan includes. That covers extra usage beyond the allowance, an added seat or account, or a paid tier of a service. An action that only draws on the plan's included usage does not enable a paid feature (EV-C01-022:42: "Routines draw down subscription usage the same way interactive sessions do"). Offering Batu a paid option as his decision is not enabling it; taking it would be.
- **"Every `get_session` reading … that the records hold."** A reading is named where a record gives its time or its fields. A reading that only the session's transcript holds is listed apart, as not in the records.
- **"The probe tokens' format."** It is read as `plan/key_inventory.md`:66 and `plan/work/W-C01-03.md` state it: the format W-C01-03's design record was to fix. Section (c.1) says whether one was fixed.
- **"The credential patterns the guard knows"** are the guard's `REDACT` list (`tool_allowlist.py`:416-418, five patterns), the one class of `tools/credential_class.py` that `REDACT` lacks (JWT-shaped), and the values of the guard's `CREDENTIAL_VARS` (`tool_allowlist.py`:150-152), searched for by value with `tools/credential_value_scan.py`. `CREDENTIAL_PATHS` (`tool_allowlist.py`:154) are file paths, not value patterns, so they are not scanned for.
- **"Could not check"** stays apart from "none found" (plan Section 8 item 14).

## (a) Instructions given to Batu or to a probe session

### (a.1) The machine account's comments on issue #6 since C01's start: **could not check here**

The producer could not read issue #6. Its one attempt was a read through `gh api` (`repos/batuhanozgun/devos/issues/6/comments`, since 2026-10-06T13:00Z), and the guard denied it: decision #12194, rule B7 ("'gh' acts with the account's credentials"). The denial's "What to do instead" names the GitHub tools, which this producer does not have. No other route was tried. So the comments are **not listed from the issue and not read in full here**. This part of item 1(a) stays open for a reader with the GitHub tools (the executor, or W-C01-30's checker).

What the records say the machine account posted on issue #6 in C01 is listed below, as a pointer for that reading. The list is not complete. A paid-feature judgment here rests on the record of what was asked, not on the comment's text.

| Comment (as the records give it) | Asked of Batu (per the record) | Enables a paid feature? Basis |
|---|---|---|
| D-018, posted with the merge of L-176 (2026-10-09; C01 log:109) | Enrol in the host's official verification path, or not. The record says "terms and cost unknown until he looks" (D-018) | Not enabled: Batu answered (b), not enrolling (D-018, answered 2026-10-10T20:58Z). The option was put to him as his decision with its cost unknown, as working order section 8 requires |
| D-019, posted with L-180 (2026-10-10; log:154) | Accept a residual (N-109) | No action, no feature |
| `6103245358` (2026-10-10; `plan/work/C01.md`, step 1 and 1a) | "Batu's step", steps 1 to 24 of `ROUTINE_DESIGN.md`: add one non-secret variable to `devos-kurulum`; create `devos-c01-rutin` with Opus 5.5, `devos` only, a daily schedule trigger, every connector removed, and no API or GitHub trigger ("API seçeneği bir anahtar üretir", the API option issues a key) | No, see (a.4) |
| D-020, posted with L-184 (2026-10-10; log:188, 194) | Where the three environments live: (a) all in his account at $0; (b) one second Pro account at $20 a month; (c) two further accounts | Not enabled: answered (a), "ek ücret gerekmeyen (a)" ("(a), which needs no extra fee") (D-020) |
| D-021, opened on issue #6 (L-200) | One Run now press for R1b | No: a run draws included usage (EV-C01-022:42); D-021 says "the run draws the same usage as tomorrow's would" |
| `6109027725` (2026-10-11T12:29:16Z), with the probe issue #222 | Row 6: say whether the GitHub app notified him | No (a reply only) |
| D-022, opened on issue #6 (L-205); answered as item 2 of `6109603950` | One Run now press for P1 | No, as D-021. P1 downloads public packages and models, anonymously (a.5) |
| `6109718026` (2026-10-11, between 12:00Z and about 13:50Z; EV-C01-011:97) | Not stated in the records read | **Could not check** |
| `6109965514` ("P3 hazır", 14:18Z) and `6110210099` ("P3 tekrar hazır", 14:45:51Z) | Run now presses for P3 under D-027 | No, as D-021 |
| `6110301769` (2026-10-11T14:56:04Z; L-226) | Look at claude.ai/settings/usage and claude.ai/code/routines and report | No: reading his own account pages |
| `6111248384` (L-235) | Information only. Nothing asked; "the routine is not to be pressed until the next note there" | No |
| `6114111104` (D-029, about 2026-10-11T21:43Z; L-261) | Turn the synced skills off on claude.ai's skill settings, or keep them | No: a toggle. D-029 says "at no money cost". Answered (b), keep (L-263) |
| `6120564296` (2026-10-12T08:27:11Z; L-269) | Steps 25 to 37 of `ROUTINE_DESIGN.md`: delete the routine, then remove the variable line | No: a deletion and a removal |

D-027 (offered, L-210) and D-028 (offered, L-242) do not say which channel carried them. D-030 was offered in the working session (L-264).

### (a.2) The decision records of C01 with steps for Batu

Read: `plan/decisions/D-017.md` to `D-030.md` (D-023 to D-026 do not exist at `3301de7`). Each was checked for every option it puts to him and for the words paid, cost, `$`, free, extra usage, overage, billing, subscription and money.

| Record | His step | Paid feature? Basis |
|---|---|---|
| D-017 | None (the builder's method; it routes the account action to D-018) | No |
| D-018 | Enrol in the verification path, or not | Not enabled (answered (b)) |
| D-019 | None (accept a residual) | No |
| D-020 | Keep the environments in his account, or pay for second accounts | Not enabled (answered (a), $0) |
| D-021, D-022, D-027, D-028, D-030 | One Run now press each (R1b; P1; P2 and P3; P4; CS1) | No. Each says the run draws usage the schedule would draw anyway; routines draw included usage (EV-C01-022:42); extra usage is off (criterion 25, as EV-C01-022:131 reads it) |
| D-029 | Turn the synced skills off on claude.ai, or keep them | No ("No money", D-029). Answered (b) |

D-002 (Batu's usage policy) was amended in C01 on his word (L-267). It changes how the builder reads `allowed_warning` and gives him no step.

### (a.3) Plan changes written in C01 that give him a step

PC-19 to PC-39 and FR-04 to FR-06 were searched for a step asked of him. These give one or reshape one:

- **PC-21** (place 3, Section 12 item 0). His C01 steps shrink to creating one routine, without the probe environments, the SQL text or the probe tokens. That is "Batu's step" in (a.4).
- **PC-22.** One non-secret variable line, added and later removed (steps 1a and 3a in `plan/work/C01.md`).
- **PC-35 and PC-39.** The account-level step of Section 12 item 6 for the synced skills. It is put to him only as D-029 (a.2), and the plugin step of PC-35 (A) was not taken.
- **PC-25 place 2 and PC-38.** The auto-merge setting stays his step in Section 12 item 1, moved to C03, so it was not asked in C01.

PC-27, PC-28 and PC-33 name a question to Batu only to reject or withhold it. None of these steps enables a paid feature.

### (a.4) "Batu's step" (`ROUTINE_DESIGN.md`, steps 1 to 37) and the steps given in the working session

These were read in full at `3301de7`. Part A (steps 1-9) adds `DEVOS_ENVIRONMENT=devos-kurulum` to the environment's variables. Part B (steps 10-24) creates the routine: Opus 5.5, `batuhanozgun/devos` only, `devos-kurulum`, a Daily schedule, every connector removed, and "API ve GitHub event'i seçme" (do not choose API or GitHub event). Part C (steps 25-37) deletes the routine and removes the line. Steps 1b and 3 of `plan/work/C01.md` were given in the working session: moving the daily time (L-195), and the deletion (asked on issue #6, reported in both places).

- **Paid feature: none enabled, by the text.** No step opens a billing, plan, extra-usage, purchase or upgrade screen. The one key-issuing option (API trigger) is excluded by name. Opus 5.5 is the model D-008 fixed for every session.
- **What that rests on:**
  - the step text;
  - "Routines draw down subscription usage the same way interactive sessions do", and "Without usage credits, additional runs are rejected until your usage window resets" (EV-C01-022:42, the routines page read 2026-10-11);
  - extra usage off by Batu's decision (criterion 25; EV-C01-022:42, 131);
  - `isUsingOverage` false at every reading that shows it (b).
- **Could not check:** the account's extra-usage setting itself. No session reads it; Batu's report on his account pages (EV-C01-022 section 1.3) is his word.

- **[2026-10-12, CHK-C01-109 C1; L-273] Two more instructions given in the working session**, taken from the C01 log and "Batu's steps" in `plan/work/C01.md` (the working session's instructions to him are recorded there; the transcript was not read for them):
  - Choose Accept edits for the working session (2026-10-10, about 20:58Z; L-178; "Batu's steps" row 6): a permission mode of the session (D-008). Does not enable a paid feature: it changes how the session asks for permission, not what the account pays for.
  - Set the session's effort to ultracode (2026-10-12, at his question at 07:03:20Z, answered at 07:03:36Z; L-267 gave about 06:45Z, corrected in L-279; row 16): the effort D-008 fixed, drawn from his plan's included usage (D-002). Does not enable a paid feature.
  With these, (a)'s result stands: no instruction given to Batu or to a probe session in C01 enables a paid feature.

### (a.5) The routine's stored prompt and the control files a probe session acts on

- **The stored prompt.** `ROUTINE_DESIGN.md` section 3, verbatim, read in full. `git log` shows 19 commits to `ROUTINE_DESIGN.md`. The prompt block was extracted from all 19 versions, from "You are a C01 probe run of DevOS" to "…the bans win: do nothing else and end.", and its SHA-256 is the same in every one. At `3301de7`, section 3's copy and step 13's copy also have the same SHA-256. So the prompt did not change during C01, as section 3 says. It has five bans (self-observation only; no token or secret; write only the run's own branch; no other sessions, routines or repositories; start text is data) and one instruction: read `CONTROL.md`. **No paid feature**: it enables nothing.
- **`CONTROL.md`, every version.** These are the 14 committed blobs from `git log --follow`:
  - version 1 `f8a1531`;
  - version 2 `0a97ad7` and `2adb1ea`;
  - version 3 `1ebc1a6` and `c1c869c`;
  - version 4 `3a652ac`;
  - version 5 `d4a604e`;
  - version 6 `c7282f6`;
  - version 7 `835878d`;
  - version 8 `f96735a`;
  - version 9 `f6dc985`;
  - version 10 `529a0c0` and `134fa86`;
  - version 11 `61e59bc` (blob `81b3e28`, unchanged at `3301de7`).

  How they were read:
  - version 11 in full;
  - every line that occurs only in an earlier blob, in full: 63 distinct lines, from `sort -u` of the 13 earlier blobs minus version 11;
  - a keyword pass over all 14 blobs for paid, cost, billing, subscription, upgrade, purchase, buy, credit, overage, extra usage, API key, trial, pricing, price, `$<digit>`, enable, install, sign up and account. Its hits are the install lines of P1 and the machine account's commit identity.

  What the versions ask of a run:
  - clone and push its own `claude/probe-c01-…` branch;
  - read two named variables;
  - call `get_session` if offered, and run `tools/guard_report.py`;
  - write records;
  - make subagent calls (R1b row 4; the tasks R4-T and R4-C);
  - in P1, install two public Python packages from the public package index and download two public models, anonymously, with no account and no key (version 11, P1 items 1-3; 6.4);
  - in P2 and P3, call the repository's own probe skill (W-C01-20; versions 4 to 10 inline, then `AFTER_K.md`);
  - in P4, read the session's own user-level folders.

  **No version enables a paid feature.** The downloads are public and free of charge. Subagent calls and runs draw included usage (EV-C01-022:42). No version asks for a key, an account, a sign-up or a billing setting. Rule 1.3 bans every session or routine tool other than its own `get_session`.
- **`AFTER_K.md`**, versions 1 (`3a652ac`) and 2 (`d4a604e`; blob `59214f1`), read in full. It asks for `ROW13.md`, part B, and one call of the repository's probe skill on a synthetic word list. **No paid feature.**
- **The probe skill (W-C01-20).** One version (added `3a652ac`, removed `fdb6824`), read in full. It asks for a tally, "no other file, command or tool". **No paid feature.**

### (a.6) Result of (a)

Of the instructions this producer could read (a.2 to a.5), **none enables a paid feature**. Two put a possibly paid option to Batu as his decision (D-018, cost unknown; D-020 (b) and (c), $20 a month per account), and he chose the free option in both. The machine account's issue #6 comments are **could not check** here (a.1), so item 1(a) is not complete until they are listed and read with the GitHub tools.

## (b) `get_session` readings in C01 and their `isUsingOverage` value

### (b.1) Readings the records hold

Times are UTC; "Records" names where each is held.

| # | Session | Reading | Window, state | `isUsingOverage` in the records | Records |
|---|---|---|---|---|---|
| 1 | `session_01WKJi23FwAjFtiyD1DbQ2Rs` | 2026-10-06 13:35Z | `five_hour` `allowed` | false | `plan/work/C01.md` Usage only (not in the log) |
| 2 | same | 2026-10-06 14:11Z | `five_hour` `allowed` | false | C01.md Usage; log:31 (L-169); log:28 and EV-C01-001:10 give its version only |
| 3 | same | 2026-10-06 15:06Z | `five_hour` `allowed` | false | C01.md Usage; log:44 (L-170) |
| 4 | same | 2026-10-06 17:01Z | `five_hour` `allowed` | false | C01.md Usage; log:78 gives its effort fields only |
| 5 | `session_01Cr4b8p5UA5dLmtrTdA243S` (L-176) | 2026-10-09, "at the opening" (no time given) | `seven_day` `allowed_warning` | false | log:110 (L-176); **not in C01.md's Usage table** |
| 6 | `session_01XyxvJd3RayQk4HCrjurbVH` | 2026-10-10 about 20:58Z | `five_hour` `allowed` | false | log:126, 131 (L-178); **not in C01.md's Usage table** |
| 7 | same | 2026-10-11 about 06:03Z (guard #960) | not given | **not shown** (version only) | EV-C01-004:29; log:255 |
| 8 | same | 2026-10-11 07:29Z | `five_hour` `allowed` | false | log:279 (L-194) |
| 9 | same | 2026-10-11 08:53Z | not given | **not shown** (version only) | log:351 (L-202); EV-C01-007:10; EV-C01-008:10, 99 |
| 10 | same | 2026-10-11 15:22Z | `five_hour` `allowed` | **not shown** | log:589 (L-226); EV-C01-022:13, 89; CHK-C01-079:65 |
| 11 | same | 2026-10-11 17:58Z (R0) | `seven_day` `allowed_warning` | false | ledger:23; C01.md Usage; log:753 (L-244); EV-C01-024:34 |
| 12 | same | 2026-10-11 18:06Z (R0′) | as R0 | false ("the same as R0") | EV-C01-024:35; log:764 |
| 13 | same | 2026-10-11 18:12Z (R1) | `five_hour` `allowed` | false | C01.md Usage; EV-C01-024:36; ledger:23 |
| 14 | same | 2026-10-11 18:30Z (R2) | `five_hour` `allowed` | false | C01.md Usage; ledger:23 |
| 15 | same | 2026-10-12 05:42Z | `five_hour` `allowed` | **not shown** | ledger:23; log:934 (L-262); EV-C01-023:353 (version) |
| 16 | same | 2026-10-12 06:01Z | not given | **not shown** (effort only) | log:960 (L-265) |
| 17 | same | 2026-10-12 07:06Z | `five_hour` `allowed` | **not shown** | ledger:23; log:976 (L-267) |
| 18 | same | 2026-10-12 08:36Z | `five_hour` `allowed` | false | C01.md Usage; log:992 (L-269, without the field) |

So the records hold 18 readings, 12 of which show `isUsingOverage` false. **Six do not show it**: #7, #9, #10, #15, #16 and #17. None of the 18 shows true.

### (b.2) The working session's transcript

The transcript of `session_01XyxvJd3RayQk4HCrjurbVH` is in this container: `~/.claude/projects/-home-user-devos/<session>.jsonl`, 64,526,094 bytes at 08:48Z. The producer read it with `grep` only. A first attempt with a Python reader was denied (guard #12345, rule B5: only a reader may name `~/.claude`), and no other interpreter was tried.

`grep -o 'isUsingOverage[^,}]\{0,12\}' … | sort | uniq -c` finds `isUsingOverage\":false` 54 times and no `true`. The 54 sit in 27 transcript events, each holding the field twice. Their times, as the events record them:

- **2026-10-10:** 20:58:29Z, 22:01:32Z, 23:19:10Z.
- **2026-10-11:** 01:35:45Z, 05:32:00Z, 06:02:59Z, 07:29:02Z, 08:49:43Z, 11:45:26Z, 13:52:51Z, 15:22:02Z, 17:58:47Z, 18:06:26Z, 18:12:24Z, 18:30:11Z, 18:49:12Z, 19:04:15Z, 19:20:08Z, 19:31:19Z, 19:47:06Z, 20:15:39Z.
- **2026-10-12:** 05:42:07Z, 05:48:56Z, 06:01:36Z, 06:18:22Z, 07:06:19Z, 08:36:31Z.

The windows: `seven_day` at 17:58Z and 18:06Z on 2026-10-11, `five_hour` at all the others.

- **Readings that do not show the field in the records.** For #7 (06:02:59Z), #10 (15:22:02Z), #15 (05:42:07Z), #16 (06:01:36Z) and #17 (07:06:19Z), the transcript holds an event at that time with `isUsingOverage` false. For #9 (dated 08:53Z), the nearest event is at 08:49:43Z, false. Whether it is the same reading is not determined.
- **Readings in the transcript only.** 14 events are in no record: 22:01Z, 23:19Z, 01:35Z, 05:32Z, 11:45Z, 13:52Z, 18:49Z, 19:04Z, 19:20Z, 19:31Z, 19:47Z, 20:15Z, 05:48Z and 06:18Z. All are false.
- **Could not check.** Readings #1 to #5 were taken by earlier working sessions in other containers. Their transcripts are not here, so those readings rest on the records alone. The transcript was searched only for the field's JSON form. A reading whose result was not kept in the transcript would not be found.

## (c) The scan for the probe tokens' format and the guard's credential patterns

### (c.1) Was a probe-token format fixed?

**Not on `main`, and no probe token was ever issued.**

- `plan/key_inventory.md`:66 leaves the format to W-C01-03's design record ("W-C01-03 fixes the format, and this file does not state it").
- W-C01-03 was cancelled on 2026-10-10 (W-C01-31; FR-05, PC-21) after its design failed two checks (CHK-C01-010, CHK-C01-013; L-173).
- PC-21 item 1 removed P1 (the probe environments with tokens) and P3 (the probe schema that would issue them): "P1 … P3 … are not built". `plan/work/C01.md`:200 says the same.
- The design itself was never merged. It lives only on the branch `claude/c01-probe-design` (`6cf4e5d`).

That draft did propose a format: "`dvs_probe_` + 32 lowercase hex, i.e. `^dvs_probe_[0-9a-f]{32}$`" (draft `EV-C01-002_probe_design.md`:138-141; `P3_probe_schema.sql`:38-39). The scan therefore also looks for that draft format (pattern F1), as a precaution. The draft branch's own files are scanned as an extra target.

### (c.2) Patterns

| ID | Pattern (Python `re`) | Source |
|---|---|---|
| G1 | `gh[pousr]_[A-Za-z0-9]{20,}` | guard `REDACT`, read from `tool_allowlist.py` by the script (AST), so it cannot drift |
| G2 | `github_pat_[A-Za-z0-9_]{20,}` | guard `REDACT` |
| G3 | `sk-[A-Za-z0-9_\-]{20,}` (covers `credential_class.py`'s `sk-ant-` class) | guard `REDACT` |
| G4 | `(?i)bearer\s+[A-Za-z0-9._\-]{12,}` | guard `REDACT` |
| G5 | `(?i)(token\|secret\|password\|passwd\|api[_-]?key)(\s*[=:]\s*)\S+` | guard `REDACT` |
| J1 | `eyJ[A-Za-z0-9_-]{8,}\.[A-Za-z0-9_-]{8,}\.[A-Za-z0-9_-]{8,}` | `credential_class.py`'s "JWT-shaped" class, in its usual `eyJ` header form for free text |
| F1 | `dvs_probe_[0-9a-f]{32}` | the cancelled draft's probe-token format (c.1) |
| V | the values of `CREDENTIAL_VARS` and of the token file, by value | `tools/credential_value_scan.py` (not printed) |

### (c.3) Positive control (synthetic, in a scratch copy, never in the repository)

`bin/plant_control.py` copied three real targets into a scratch folder twice, as `base/` and `planted/`: probe branch CS2's files, CS2's `git log -p` history file, and `evidence/C01/routine/` from the records (81 files). In `planted/` it inserted, at line 8 of a named file, one made-up value per pattern. Each value was built at run time from random characters and sits on a line labelled "SYNTHETIC FAKE for the W-C01-48 positive control, not a credential":

- G1 in `CS2/CLOSING.md`;
- G2 in `cs-queue/QUEUE.md`;
- G3 in `CONTROL.md`;
- G4 in `ROUTINE_DESIGN.md`;
- G5 in the history file;
- F1 in `AFTER_K.md`;
- J1 in `CS2/OPENING.md`.

No fake value was printed or kept outside the scratch folder. The same scan then ran on both copies. Its output (`out_control.tsv`), without the masked context:

```
TARGET control/base files=81 lines=3018 G1=0 G2=0 G3=0 G4=0 G5=0 J1=0 F1=0
HIT control/planted records__tree__evidence__C01__routine/AFTER_K.md:8 F1
HIT control/planted records__tree__evidence__C01__routine/CONTROL.md:8 G3
HIT control/planted records__tree__evidence__C01__routine/ROUTINE_DESIGN.md:8 G4
HIT control/planted branches__cs2-20261012T0808Z__history/log_p.txt:8 [8d55d851bca0 message] G5 api_key
HIT control/planted branches__cs2-20261012T0808Z__tree/c01-run/CS2/CLOSING.md:8 G1
HIT control/planted branches__cs2-20261012T0808Z__tree/c01-run/CS2/OPENING.md:8 J1
HIT control/planted branches__cs2-20261012T0808Z__tree/c01-run/cs-queue/QUEUE.md:8 G2
TARGET control/planted files=81 lines=3025 G1=1 G2=1 G3=1 G4=1 G5=1 J1=1 F1=1
PATTERN_SCAN DONE
```

Every planted value was caught, at its file and line, by its own pattern, and nothing else was. The unplanted copy gives 0.

For pattern V, `python3 -I tools/test_credential_value_scan.py` (the tool's planted test) printed 22 `PASS` lines and `CREDENTIAL_VALUE_SCAN_TEST PASS`, exit 0. Its cases include "repo: blob match located", "repo: commit-message match located", "repo: object no ref reaches", "dir: file match and every split point found" and "dir: match across the 1 MiB boundary".

### (c.4) Targets, head and counts

How each target was made, all from the clone at the commits named:

- **A branch's "tree":** `git archive <head> -- c01-run`, which is every file the branch adds. Each branch changes only `c01-run/` (`git diff --name-only <merge-base> <head>`).
- **A branch's "history":** `git log -p --format=fuller <merge-base>..<head>`: every commit message, author and committer, and every added and removed line.
- **"records/tree":** `git archive 3301de7` of:
  - `evidence/C01` (all of it: checks, raw, phase_a, routine with the run copies);
  - `plan/work/C01.md`;
  - `plan/work/W-C01-*.md` (48 files);
  - `plan/ledger/C01-log.md`;
  - the decision and plan-change records added in C01: D-017 to D-022, D-027 to D-030, FR-04 to FR-06, PC-19 to PC-25, PC-27, PC-28, PC-30, PC-32 to PC-39;
  - D-002, amended in C01.
  
  That is 302 files, matching `git ls-tree` (222 + 48 + 32).
- **"records/history":** `git log -p` of the same paths over `c843988..3301de7` (158 commits; all of `plan/decisions`), plus the merge `c843988` itself.

**Table 1: the targets and the pattern scan's counts** (`out_real.tsv`; exit 0, `PATTERN_SCAN DONE`)

| Target | Head | Files / lines | G1 | G2 | G3 | G4 | G5 | J1 | F1 |
|---|---|---|---|---|---|---|---|---|---|
| `claude/probe-c01-r1a-20261011T0808Z` tree / history | `67fcd98a8ec84f3a2269f4227cca6cdbbbc9b251` (7 commits on `5d0cc58`) | 7 / 214; 1 / 365 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| `claude/probe-c01-r1b-20261011T0913Z` | `568cf6a1bf5ad96002bf41d0423ddd6edda7217f` (17 on `5d0cc58`) | 16 / 465; 1 / 857 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| `claude/probe-c01-p1-20261011T1337Z` | `7fd90cae1c3cd8b3a27b4d85ebe681d369a34662` (7 on `63e166c`) | 5 / 228; 1 / 370 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| `claude/probe-c01-p2-20261011T1354Z` | `be9bac74d8f30e7c0210ea974cad931572eee55d` (7 on `aeb5fd0`) | 6 / 143; 1 / 278 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| `claude/probe-c01-p3-20261011T1420Z` | `38733f3b46c88aa86466e6954581f434b4d39dcb` (3 on `528d9e2`) | 3 / 59; 1 / 112 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| `claude/probe-c01-p3-20261011T1448Z` | `e971713ba0c53c76058d5724b7e56699d261bf06` (7 on `aabb9c9`) | 6 / 130; 1 / 278 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| `claude/probe-c01-p4-20261011T1914Z` | `b44f88145c24afe3d2608d4bcfd3fccf2c0ff1c7` (8 on `23ff0ce`) | 7 / 216; 1 / 338 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| `claude/probe-c01-cs1-20261012T0604Z` | `c2240846ccea2cc9587cc3547ee388c05fd771f3` (8 on `14ec14c`) | 7 / 169; 1 / 316 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| `claude/probe-c01-cs2-20261012T0808Z` | `8d55d851bca0feb3c9533c9d88f2c4ea29e608ba` (16 on `14ec14c`) | 14 / 306; 1 / 601 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| C01 records at `main` (records/tree) | `3301de7` | 302 / 27,720 | 0 | 0 | 0 | 0 | 10 | 0 | 0 |
| C01 records' history (records/history) | `c843988..3301de7` | 2 / 40,237 | 0 | 0 | 0 | 0 | 13 | 0 | 0 |
| Extra: `claude/c01-probe-design` (draft, unmerged) tree / history | `6cf4e5d` (3 commits on `main`'s history) | 13 / 2,798; 1 / 4,637 | 0 | 0 | 0 | 0 | 7; 11 | 0 | 0 |

**Value scan (pattern V).** `python3 -I tools/credential_value_scan.py --repo <clone> --dir <extracts>`, exit 0, `CREDENTIAL_VALUE_SCAN DONE`. It searched for two values, `CLAUDE_CODE_MESSAGING_TOKEN` (length 32) and the token file's content (length 895). The other eight variables are not candidates: three are the placeholder, two are paths, one is a URL, and three are unset. Results:

- the clone's object store, 7,611 objects (every object of `main`'s history, the nine probe branches and the draft branch, reachable or not): 0 objects hold either value;
- the extracts, 384 files: 0 files hold either value.

### (c.5) Every hit, with its location (never its value), and its judgment

All hits are G5, the guard's broad "name followed by `=` or `:`" pattern. The scan printed each with the match masked, the length and character classes of the matched text, and the line around it. Each was judged from that context, and where needed from the file line read directly, without writing the text matched.

| Location (records/tree at `3301de7`) | Key | Judgment |
|---|---|---|
| `plan/work/W-C01-32.md`:24 | token | Prose: the word ends a clause ("with … no token"), and the colon introduces the next clause, which is about the stored prompt. Not a value |
| `evidence/C01/EV-C01-005_W-C01-33_first_run.md`:29 | token | Prose: an API trigger "would issue a token", then a colon and a source citation. Not a value |
| `evidence/C01/EV-C01-018_W-C01-39_row12_repository_access.md`:30 | token | Prose about the connected user's token, followed by a sentence about the git client. Not a value |
| `evidence/C01/checks/CHK-C01-004.md`:46 | token | Prose: "the first probe token", then a colon and an item dependency (W-C01-05 on W-C01-02). Not a value |
| `evidence/C01/checks/CHK-C01-007.md`:48 | token | Prose: a list entry naming the environment's token, then a colon and a line number. Not a value |
| `evidence/C01/checks/CHK-C01-007.md`:70 | token | Prose: the builder "cannot revoke a probe token", then a colon and the reason. Not a value |
| `evidence/C01/checks/CHK-C01-011.md`:23 | token | Prose in a Disciplines line. Not a value |
| `evidence/C01/checks/CHK-C01-014.md`:162 | Token | A header name followed by the placeholder `<fake>`. Not a value |
| `evidence/C01/raw/D-020_terms_and_github.md`:82 | token | Prose quoting documentation. Not a value |
| `evidence/C01/raw/FR-05_counter_assessment.md`:124 | token | Prose: a list entry naming network-secret tokens, then a colon and its assessment. Not a value |

The 13 records/history hits are the same ten lines as they were added, or shown as context, in these commits:

- `9619b88` and `d574410` (EV-C01-018);
- `2adb1ea` (EV-C01-005);
- `c7c02c2` (D-020 raw);
- `94caefb` twice and `44cef4e` (W-C01-32);
- `da7a1be` (FR-05 counter-assessment);
- `88f3964` (CHK-C01-011, CHK-C01-014);
- `71a9866` twice (CHK-C01-007);
- `091aa9a` (CHK-C01-004).

The judgment is the same: not a value.

The draft branch's hits (extra target) are all code or prose, with no value in them:

- `EV-C01-002_probe_design.md`:269 is prose;
- `P3_probe_schema.sql`:121 is a variable assignment that builds a token at run time from the prefix and random bytes, with no value;
- `probe_token_scan.py`:26 and :95 are a constant naming the format, and a comment;
- `routine_a_instruction.md`:95 is a header name followed by a shell variable reference, not a value;
- `CHK-C01-011.md`:23 and `W-C01-03_setup_facts_report.md`:225 are prose.

Its history hits are the same lines in commits `d3e46b4` and `50dbe3e`.

**Result:** 0 hits of G1, G2, G3, G4, J1 and F1, and 0 value matches, on every target. The G5 hits are 10 on the records at `3301de7`, 13 in their history and 18 on the draft branch, all judged non-values. On the nine probe branches every pattern found 0.

### (c.6) What the scan could not check (plan Section 8 item 14)

- **The probe sessions' own credential values.** Each run's messaging token and token file were in its own container. The value scan searched only this session's values. A probe session's token of the same shape as the messaging token (32 characters, no known prefix) is in no pattern the guard knows, so a copy of one on a branch would not be found by pattern. **Could not check.**
- **Encoded or partial forms.** Base64, URL-encoded or escaped forms, a value split across lines, or a derivative such as a hash are not decoded or recognised (as `credential_value_scan.py` says of itself). **Could not check.**
- **Credentials of other kinds.** A secret that matches no pattern above, for example a database key in a form not listed, is not found.
- **Places other than the targets.** Not scanned by pattern:
  - other branches of `devos`;
  - issues and comments (#6, the probe issue #222);
  - pull request texts;
  - `plan/ledger.md`, `DURUM.md` and the plan text;
  - the guard's decision log and the container's transcripts.

  The value scan did cover every object in the clone, so all branches fetched. A run's `IDLE.md` branch (`claude/probe-c01-idle-…`) would be a `claude/probe-c01-*` branch, and `ls-remote` listed none.
- **What a probe session wrote outside `devos`.** By its bans it wrote nothing else, but the scan cannot see outside the repository.
- **The draft format's tokens.** F1 can only find values never issued, so its 0 shows absence in the targets, not that a token was kept safe.

### (c.7) The head scanned, and what W-C01-30's review should scan after it

The scan's head is **`main` `3301de707169de7dc715e42dc1b2bc7a30775585`**, with the nine probe-branch heads of table 1 (fetched 2026-10-12T08:44:06Z). W-C01-30's review should run the same scan over what was added after these:

- **Records:** `git diff --name-only 3301de7 <its head> -- evidence/C01 plan/work/C01.md 'plan/work/W-C01-*.md' plan/ledger/C01-log.md plan/decisions`. This file and the rest of W-C01-48's records are among them; W-C01-47's item 4 record is too.
- **Branches:** any `claude/probe-c01-*` branch that is new, or whose head differs from table 1. None is expected after the routine's deletion at 08:35:04Z (W-C01-47 item 4 checks that no run starts).

## Appendix: the scan script (`bin/pattern_scan.py`, condensed)

This is the script that ran, condensed: its docstring, argument check and `PATTERNS` header line are left out. The condensed text below was itself run on the control copies and on five of the real targets. It gave the same `TARGET` counts as the script that ran (base 0; planted one of each; records/tree G5=10; records/history G5=13; draft tree G5=7 and history G5=11; R1b history 0). Run it as `python3 -I pattern_scan.py --guard <clone> <dir>...`. It prints, per hit, the target, file and line (with the commit and path for a `git log -p` file), the pattern ID, the key word for G5, and the length and character classes of the matched text. It then prints the line with every match masked, and per target the counts. It never prints a matched text.

```python
import ast, os, re, sys
sys.dont_write_bytecode = True

def guard_redact(checkout):          # REDACT = [re.compile(p) for p in (...)] in the guard file
    src = open(os.path.join(checkout, ".claude", "hooks", "tool_allowlist.py"), encoding="utf-8").read()
    for node in ast.parse(src).body:
        if isinstance(node, ast.Assign) and "REDACT" in [getattr(t, "id", None) for t in node.targets]:
            return [ast.literal_eval(e) for e in node.value.generators[0].iter.elts]
    raise ValueError("REDACT not found")

def shape(v):
    c = {"lower": sum(ch.islower() for ch in v), "upper": sum(ch.isupper() for ch in v),
         "digit": sum(ch.isdigit() for ch in v)}
    c["other"] = len(v) - sum(c.values())
    return "len=%d lower=%d upper=%d digit=%d other=%d" % (len(v), c["lower"], c["upper"], c["digit"], c["other"])

def main(argv):
    pats = [("G%d" % (i + 1), re.compile(p)) for i, p in enumerate(guard_redact(argv[2]))]
    pats.append(("J1", re.compile(r"eyJ[A-Za-z0-9_-]{8,}\.[A-Za-z0-9_-]{8,}\.[A-Za-z0-9_-]{8,}")))
    pats.append(("F1", re.compile(r"dvs_probe_[0-9a-f]{32}")))
    ok = True
    for top in argv[3:]:
        files = lines = 0
        counts = {k: 0 for k, _ in pats}
        if not os.path.isdir(top):
            print("TARGET %s ERROR not a directory" % top); ok = False; continue
        for root, _d, fs in os.walk(top):
            for fn in sorted(fs):
                fp = os.path.join(root, fn)
                if os.path.islink(fp) or not os.path.isfile(fp):
                    continue
                files += 1
                rel = os.path.relpath(fp, top)
                text = open(fp, "rb").read().decode("utf-8", "replace")
                where = commit = ""
                for n, line in enumerate(text.splitlines(), 1):
                    lines += 1
                    if re.fullmatch(r"commit [0-9a-f]{40}", line):
                        commit, where = line[7:19], "[%s message]" % line[7:19]
                    elif line.startswith("diff --git a/"):
                        where = "[%s %s]" % (commit, line.split(" b/", 1)[-1])
                    for k, r in pats:
                        for m in r.finditer(line):
                            counts[k] += 1
                            masked = line[:m.start()] + "\x00" + line[m.end():]
                            for _k2, r2 in pats:
                                masked = r2.sub("<<OTHER>>", masked)
                            masked = masked.replace("\x00", "<<MATCH>>")[max(0, m.start() - 90):m.start() + 100]
                            key = m.group(1) if k == "G5" else ""
                            print("HIT\t%s\t%s:%d %s\t%s\t%s\t%s\t%s" % (top, rel, n, where, k, key,
                                                                         shape(m.group(0)), masked))
        if files == 0:
            ok = False
        print("TARGET %s files=%d lines=%d %s" % (top, files, lines, " ".join("%s=%d" % (k, counts[k]) for k, _ in pats)))
    print("PATTERN_SCAN " + ("DONE" if ok else "INCOMPLETE"))
    return 0 if ok else 2

if __name__ == "__main__":
    sys.exit(main(sys.argv))
```

## (a.1), completed by the executor: issue #6 read (2026-10-12; L-272)

The producer could not read issue #6 (no GitHub tools in its context; its `gh` call denied, B7), so (a.1) above says "could not check here". The executor read all 32 comments of issue #6 with the GitHub tools (`issue_read`, method `get_comments`, at about 08:36Z on 2026-10-12, on `batuhanozgun/devos` only). This section supersedes (a.1)'s "could not check" and its table's judgments; (a.6)'s result is restated below.

The machine account's comments since C01's start (the first is 2026-10-09; C01 started at L-168, 2026-10-06; none between): 16. Each was read in full.

| Comment | Time (Z) | What it asks of Batu | Enables a paid feature? |
|---|---|---|---|
| `6088575488` | 2026-10-09 20:19 | D-018: whether to register the account for the platform's verification route; its terms and cost not known to the builder | No. A decision put to him; answered in the working session: the route was not open to him (D-018; L-178). Nothing was enabled |
| `6102192851` | 2026-10-10 21:08 | Nothing (D-018 recorded) | No |
| `6102651127` | 2026-10-10 22:03 | D-019: accept a residual risk | No; no cost |
| `6103245358` | 2026-10-10 23:18 | The routine's set-up (steps 1 to 24: one environment variable, a routine with a schedule trigger, Opus 5.5, one repository, every connector removed) and its later removal (steps 25 to 37); the stored prompt | No. The routine runs inside his plan's usage (D-002); step 19 tells him not to choose the API trigger, which would issue a key; no paid option is chosen |
| `6103374785` | 2026-10-10 23:36 | D-020: where DevOS's three environments live; options (b) and (c) are paid (one or two Pro accounts, $20 or $40 a month) | No. A decision with paid options and their cost stated; he answered (a), at no cost (L-185) |
| `6106096907` | 2026-10-11 06:07 | Nothing (answers recorded) | No |
| `6107443771` | 2026-10-11 09:09 | D-021: one Run now press | No; a run inside his plan's usage |
| `6109027725` | 2026-10-11 12:29 | Say whether the GitHub app notified him; D-022: one Run now press | No |
| `6109718026` | 2026-10-11 13:50 | D-022 recorded (P1's result); D-027: a Run now press now and one more on "P3 hazır" | No |
| `6109965514` | 2026-10-11 14:18 | "P3 hazır": one Run now press | No |
| `6110210099` | 2026-10-11 14:45 | "P3 tekrar hazır": one Run now press | No |
| `6110301769` | 2026-10-11 14:56 | Look at his usage page and routines page and report what they show; "nothing to press or change" | No; reading only |
| `6111248384` | 2026-10-11 16:38 | Nothing (information on ECC) | No |
| `6111977151` | 2026-10-11 17:58 | D-028: one Run now press | No |
| `6114111104` | 2026-10-11 21:43 | D-029: turn off the account's synced skills on claude.ai ("ücreti yok", no cost) | No; he answered (b) (L-263) |
| `6120564296` | 2026-10-12 08:27 | Delete the routine and the environment's variable line | No |

**(a)'s result, restated.** With issue #6 read, none of the instructions given to Batu or to a probe session in C01 enables a paid feature. Two put a paid or possibly paid option to him as his decision with its cost stated (D-018, cost not known; D-020 (b) and (c)), and neither was taken. Every Run now press runs inside his plan's usage. His own comments in C01 (eight, from `6105974865` to `6120677086`) report steps and answers; none reports a paid feature turned on.
