# W-C00-12 · 14 · Tranche 1b-i: intent, formats and acceptance checks (write-ahead)

**Status:** candidate (W-C00-12 work product, not binding). **Scope:** installation only. **Written:** 2026-10-03 by run `session_01S1vPB2jo4bzk1w8XqWekj6`, before any 1b-i file is built (write-ahead, operating model §3.4). **Governs nothing by itself:** the contents of 1b-i are fixed by `12_tranche_plan.md` §2.1 (row 1b-i) and §2.2 (gate 1b-i), the rules by `02_memory.md`, `03_work_model.md` and the register, and the conditions to meet by `13_r-w12-2_dispositions.md` §1 (C1 b, c; C2; C4). This file states only how this run builds and checks them, so that the session Verifier can compare the result with an intent written before it.

## 1. What 1b-i builds (from 12 §2.1; nothing added)

1. **Records migration** (M-R3, W-R16, 08 §2 rows 1–3):
   - `plan/work/<ID>.md` for every work item of `plan/ledger.md` §2 (W-C00-01 to W-C00-12), each with front matter and its acceptance text inside `<!-- acceptance -->` … `<!-- /acceptance -->`, byte-identical to its ledger cell after normalising table escaping only;
   - stage records `plan/work/C00.md` … `C12.md` (`kind: stage`) and one root record `plan/work/INSTALL.md` (`kind: root`) that carries the purpose chain as pointers to plan §1.1 and §9; C00 carries `hold_until: W-C00-12` and the C00 acceptance text of `plan/ledger.md` §3 as its acceptance block (byte-identical);
   - `depends_on: [W-C00-12]` in W-C00-06, 07, 08, 09, 10 and 11 (B-1 b; T-W15);
   - W-C00-12's children, because its work has started (03 §7): `W-C00-12.1` (1a), `.2` (1b-i), `.3` (1b-ii), `.4` (1c), `.5` (1d). Their acceptance blocks point to 12 §2.1–2.2 and the conditions of 13 §1; they restate no rule;
   - `plan/decisions/<ID>.md` for every row of `plan/ledger.md` §4 (D-001, D-002, D-003, PC-01 to PC-05), with Batu's words verbatim where a record holds them (issue #6; log entries), and a pointer where it does not;
   - every open item (OI-001 to OI-012, and OI-011's 24 numbered items plus its input list) moved verbatim into a note block on the item or stage that `08_oi011_dispositions.md` §1 and the OI's own resolution cell name; the three notes of `06` §3a g on C03, C04 and C08/C09; closed items as closed notes. OI-011 as a container is retired;
   - `plan/ledger.md`: §2 work list, §4 decisions index and §5 open items become generated blocks; the Next action row becomes the generated frontier (W-R2); new rows Governing documents, `answers seen through`, `Armed wakes`, `summary_tr` (08 §2 row 1).
2. **`tools/records.py`** with subcommands `render` (`--check` compares without writing), `brief <ID>|run --role <role>` (verifier: `--target-sha` and a non-empty `--failure-classes` required), `durum`, `lease`.
3. **Generated views**: work index, frontier, zoom, decisions index, open-notes view in `plan/ledger.md`; `DURUM.md` generated from a Turkish template and `summary_tr` (M-R15's generator; its view check and T-M5r are gated in 1b-ii).
4. **Register and carrier tables moved** to `plan/builder/mechanisms.md`, unchanged in content: `11_test_register.md` §1 and `07_mechanism_map.md` §2–§4. Both files keep a pointer. `check_ids.py` reads the register from the new home and scans it. Operating model Appendix M is **not** changed here: the operating model is a governing document whose v1.8 delta is 1c's (12 §1); 1c's supersession table points Appendix M to `mechanisms.md`.

**Not in 1b-i** (stated so the Verifier can check nothing leaked in): `check_records.py` and the `builder_check.sh` extension (1b-ii); any `.claude/**` or `CLAUDE.md` change (1c); workflows (1d). The view check, kind check, stamps and claims checks do not exist yet, so 1b-i's records are checked only by its gate tests and the Verifier.

## 2. Formats (decided here, technical, normal)

- **Front matter:** YAML between `---` lines (Python `yaml.safe_load`; `PyYAML` 6.0.1 is present in the environment, observed). Fields as `03_work_model.md` §2, plus `id`, `kind` (`root`, `stage`, `item`), `parent`, `title`, `scope`, `legacy_status` (the v1.7 status cell, verbatim, so the migration loses nothing), `evidence` (the v1.7 evidence cell, verbatim).
- **Migrated acceptance values:** no v1.7 item was accepted under W-R1's definition (W-C00-05 says so itself, and the others were marked done by their producer). So every migrated item gets `acceptance: proposed`, with its old status kept in `legacy_status`. This is a truthful mapping, not a downgrade by judgement; a later Verifier may accept a finished item by a bound verdict.
- **Notes:** `<!-- note N-nnn status=open|closed origin=<source> -->` … `<!-- /note -->` blocks in the body; an optional `blocks=true` makes an open note a readiness blocker (03 §3).
- **Decisions:** front matter `id`, `class` (`batu` or `technical`), `owner_reason` (for `batu`), `status` (`open`, `answered`, `superseded`, `retired`), `answer_original_tr`, `answer_interpretation_en`, `answered_by`, `answer_channel_ref`, `conditions`, `reopen_if`, `supersedes`, `record` (log pointers).
- **Readiness** exactly as 03 §3, three-valued: an unresolved ID or field makes the item `unknown`, which is not ready. The stage `hold_until` applies to every item of the stage except the hold target and its descendants, while the target is not accepted.
- **Staleness (W-R9)** is computed from decision status and from Record changes lines of the log naming an `assumes` ID with kind correction, supersession or retirement after the item's last `rechecked:` entry. Its test (T-W3r) is gated in 1b-ii; 1b-i only renders it.
- **Hash** of a brief: the first 16 hex digits of SHA-256 over the brief text above its `Task-Brief:` line.

## 3. Gate tests, made concrete (procedures of `11_test_register.md` §2.2; PASS and FAIL conditions unchanged)

All run by one script, `tools/test_records.py`, whose output is pasted unedited into `evidence/C00/tests/1b-i_gate.md`. Scratch fixtures are built in a temporary directory, never in the working tree.

| Test | Concrete procedure |
|---|---|
| T-W10 | For each item of the base commit's `plan/ledger.md` §2 (the commit this PR branches from, read with `git show`), and for C00's §3 block: take the acceptance cell, un-escape `\|` only, compare with the text between the markers of `plan/work/<ID>.md`; print one line per item, then `T-W10 PASS` only if every comparison is identical and every source item has a file |
| T-W15 | Render the migrated tree's frontier and zoom; check W-C00-06 to 11 each have `W-C00-12` in `depends_on`, none in the frontier's ready list, and each shown in the zoom with a blocked reason naming W-C00-12 |
| T-W2 | Scratch: A `execution: finished, acceptance: proposed`; B `depends_on: [A]`, else ready. Render: B absent. Set A `acceptance: accepted` with `accepted_by` a verdict path, render again with no edit of the generated file: B present |
| T-W5 | Scratch: a `candidate` item with all dependencies met: absent from the frontier, present in the zoom marked `candidate` |
| T-W7 | Scratch: thirteen stages C00–C12; a claimed leaf `W-X.1.1` under `W-X.1` under `W-X` under C01: zoom shows thirteen stage lines, the path C01 → W-X → W-X.1 → W-X.1.1 expanded, a non-path sibling as one line, and a non-path stage's items collapsed to counts |
| T-W12 | Scratch: an item with `platform: [{fact: x, status: untested}]`, else ready: absent from the ready list; the frontier line for it names the probe for `x` |

Mutation checks (to show the tests can fail): the script also runs T-W10 against a copy with one acceptance character changed, and T-W15 against a copy with one `depends_on` edge removed; each must print FAIL. T-W15's mutation also shows that the C00 `hold_until` alone still blocks the item (the edge and the hold are two layers).

## 4. Self-checks before the review request

| # | Check | Pass only if |
|---|---|---|
| S-1 | `python3 tools/test_records.py` | prints PASS for all six tests and FAIL for both mutations |
| S-2 | `python3 plan/builder/w-c00-12/check_ids.py` | prints `IDS OK` with the register read from `plan/builder/mechanisms.md` |
| S-3 | `python3 tools/records.py render --check` after a render | prints no difference |
| S-4 | `tools/check_service_names.sh` on the staged tree | `SERVICE_NAMES CLEAN` |
| S-5 | Every OI and OI-011 item is in exactly one note; no OI text was lost | a script counts the 24 numbered items and OI-001…OI-012 (OI-009 does not exist in the ledger) and diffs the concatenated note text against the source cells |
| S-6 | A non-binding Critic subagent reads this file, the diff and the conditions (R-R16) | each finding is answered in this file's §6 before the Verifier is asked |

## 5. The session Verifier (12 §1; 13 §1)

Started with `create_session` on the PR head, with the fixed prompt (`plan/builder/REVIEW_PROMPT.md`), review ID `R-W12-3`, target the PR and its head SHA, criteria: 12 §2.1 row 1b-i and §2.2 gate 1b-i; W-R16, M-R3, W-R2, W-R3, W-R11, W-R15 and 03 §9's briefs; this file; conditions C1 (b, c), C2 and C4 of `13` §1 as met in the text; the 1a deferral (12 §2.1, row 1a). Its failure classes: acceptance text changed in migration; a rule restated instead of pointed to; the C00 hold liftable without a high-class change; a record lost in the migration; a producer-written check accepting the producer's own work; claims stated stronger than the evidence. The PR merges only on PASS, or PASS-WITH-CONDITIONS with the conditions met; the verdict is copied with `git show` from its branch.

## 6. Critic findings and responses

(filled before the Verifier is asked)
