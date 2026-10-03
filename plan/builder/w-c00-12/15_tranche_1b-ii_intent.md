# W-C00-12 · 15 · Tranche 1b-ii: intent, formats and acceptance checks (write-ahead)

**Status:** candidate (W-C00-12 work product, not binding). **Scope:** installation only. **Written:** 2026-10-03 by run `session_01CmCKBkyHynQ27CwqkiviC6`, before any 1b-ii file is built (write-ahead, operating model §3.4). **Governs nothing by itself:** the contents of 1b-ii are fixed by `12_tranche_plan.md` §2.1 (row 1b-ii) and §2.2 (gate 1b-ii). The rules are fixed by `02_memory.md`, `03_work_model.md`, `04_roles.md`, `05_continuity.md` and the register. The conditions to meet are C1 (a) and C5 of `13_r-w12-2_dispositions.md` §1, and the findings to dispose of are N-049 and N-050 on `plan/work/W-C00-12.3.md`. This file states only how this run builds and checks them, so that the session Verifier can compare the result with an intent written before it. Where this file and a rule disagree, the rule wins, and the disagreement is a finding.

## 1. What 1b-ii builds (from 12 §2.1; nothing added except where §6 says so)

1. **`tools/check_records.py`** with the ten subcommands of A-04: `chain` (M-R4, M-R1), `kinds` (M-R5), `views` (M-R6, M-R15), `work` (W-R1, W-R4, W-R9, R-R3, R-R5), `impact` (W-R7), `docstatus` (M-R2), `stamps` (M-R14), `claims` (M-R16 a, b), `decisions` (R-R10), `map` (M-R19). There are three helper modes besides:
   - `all`: the tree checks plus the diff checks on one range;
   - `merged`: the diff checks for every commit on `main`'s first-parent line after a fixed baseline, the verdict-after-the-fact check of the break-glass rule, and the `patch:` count;
   - `answers`: the M-R13 accounting of Batu's comments.

   The helpers are not new rules, so A-04's row names them (§6).
2. **`tools/builder_check.sh`** extended (C-R1 without its 1d part, C-R11, M-R13, A-07, and R-R9's hand-over signal):
   - an optional stop reason `S1`…`S5`, with `ISSUE_READ_FAILED` as an extra word after `S3`;
   - the record checks;
   - the issue read;
   - the leak check on committed and staged content;
   - the reason's own conditions;
   - the failure-class counter.

   Every existing check is kept, with the same text after a class tag.
3. **`tools/test_check_records.py`**: the 25 gate tests, each in scratch git repositories built in a temporary directory, never in the working tree. Its unedited output goes to `evidence/C00/tests/1b-ii_gate.md`.
4. **Record and text changes the gate needs** (§5 lists each with its reason): the Governing-documents row split (F-7); the operating model's header status sentence replaced by the M-R2 pointer (needed for T-M1 b); carrier rows for the scripts the map would otherwise report; the N-050 dispositions; the m-7 re-run of the M-R14 prototype.

**Not in 1b-ii** (so the Verifier can check that nothing leaked in): any `.claude/**` change, `CLAUDE.md`, `.gitattributes`, `tools/boot_map`, agent definitions or role files (1c); workflows (1d); the main-definition check C-R9 (deferred). The operating model's rules are not changed; only its header status sentence becomes the pointer (§5).

## 2. Formats and decisions (technical, normal; each stated so the Verifier can judge it)

**Output.** Each subcommand prints `PASS  <sub>`, or one `FAIL  [<sub>] <what>` line per problem, then `RECORDS PASS` or `RECORDS FAIL` (exit 0 or 1). Informational lines start `INFO`. A crash prints `RECORDS ERROR` and exits 2, which `builder_check.sh` counts as a failure.

**Ranges.** The diff checks (`kinds`, `impact`, `stamps`, `claims` b) read `--base`..`--head`. `--head` defaults to `HEAD`, or to the working tree with `--worktree`, and `--base` to the merge base with `origin/main`. At a stop, everything is merged, so the stop check runs `merged`. That walks every first-parent commit of `origin/main` after the **baseline** `f72b973`, the last `main` commit before 1b-ii's branch, and checks each one's own diff (`M^1..M`), so a merged PR is judged on what it changed. The baseline is a constant in the script; moving it is a `tools/**` change, so it is class high.

**Errors that reached `main`.** A merged commit cannot be changed. If a merged PR fails `kinds`, `stamps` or `claims`, the stop check stays failed until a later log line `record-check exception: <merge SHA> <subcommand>: <reason>` reaches `main`. The exception is printed at every stop. It counts as "a failure that reached `main`" for R-R9, so the run must hand over. No exception exists for `impact`: a missing verdict is fixed by adding the verdict.

**Verdict coverage** (W-R7 "bound to its head"; also used by W-R1 and the break-glass rule). A merge `M` is covered when a file under `evidence/*/reviews/` on the checked tree:
- says `Verdict: PASS` or `Verdict: PASS-WITH-CONDITIONS`;
- names a commit `X` (7 to 40 hex digits) that is `M^2` or an ancestor of it;
- and the diff `X..M^2` is itself class normal.

The last clause covers conditions met after the verdict, as with R-W12-3 (target `68a5e05`, merged head `db1fa53`). A condition-fix that touched a class-high path would need a new verdict.

**Break-glass** (W-R7 exception; C1 a). Plumbing replaces the scratch `git revert`. A diff is the exact inverse of the executable-carrier part of merge `M` when both hold:
- every path it changes is in `M`'s executable part;
- every path of that part has, at the head, exactly its content at `M^1` (or is absent, if `M` added it).

This is stricter than a revert, because a later change to the same file makes it fail. It never qualifies when `M`'s part includes `.github/workflows/**` or `tools/builder_check.sh`. The `break-glass: <merge SHA>` line goes in a separate record PR. The stop check fails while a `break-glass:` line exists whose revert merge has no covering verdict, or whose revert cannot be found.

**N-049 and R-W12-3 F-3, decided together.**
- (i) `records.py` `is_accepted` also requires `accepted_by` to lie under `evidence/`, so a README or a log file cannot lift a gate even in the render.
- (ii) W-R7 gains one line, a stated addition reviewed by this part's Verifier. In an existing item that is the target of a `hold_until` or of any `depends_on` edge, a change of `acceptance`, `accepted_by` or `composition_by` is class high, unless every verdict the item names is one the work check accepts at the PR head (`03_work_model.md` W-R7 gives the conditions; `check_records.py` `exemption_problems`).
- (iii) W-R1 at every stop.

Together, lifting the C00 hold at class normal needs a session verdict, copied from its review branch and committed there by an owned session that made no commit of the PR (M-R16 b), that names W-C00-12 and a commit at or after the commit where W-C00-12 started `running`, and that accepts no other item. Anything else is class high and needs a session verdict on the PR. The residual is a trailer forged to name a real owned reviewer session. This paragraph was rewritten twice, each time after a reviewer showed it claimed more than the code (the Critic's finding 1; R-W12-4 B-1). This third version was written after the planted cases T-W9 (t), (u) and (v) passed on `991d51a`, and after (u) and (v) were shown to fail on the pre-fix checker (§9).

**The work check** (`work`):
- **W-R1.** It fails on an `accepted` item when any of these holds:
  - `accepted_by` is empty or a session ID;
  - it is neither a verdict file (`evidence/*/reviews/*.md` with a PASS or PASS-WITH-CONDITIONS line naming a commit) nor a deterministic evidence file;
  - `acceptance_label` is missing or not one of `deterministic`, `subagent`, `session` or `audit-environment`;
  - the label does not match the file kind;
  - a test named on the evidence file's `Tests:` line is `retired` in the register.

  A deterministic evidence file carries `Deterministic-Command:`, `Deterministic-Commit:` and `Deterministic-Result:` lines. The check re-runs the command in a scratch clone at that commit and compares the last output line. The command's script must be pre-registered (its last change at that commit is an ancestor of the first `main` commit where the item is `running`), or that last change must be in a merge that a verdict covers.
- **R-R3 and T-R4.** An item's class is the higher of its `impact:` field and the class computed from `targets:` as W-R7 computes a PR's; an empty `targets:` is high. A high item needs `acceptance_label: session` or `audit-environment`. An `impact:` value lower than the computed class fails.
- **R-R5.** A normal item at `running` or later needs a `triage:` record path that exists.
- **W-R4.** A parent with children that is `accepted` needs `composition_by:`, a verdict file the W-R1 rules accept, and every child accepted, cancelled or declined.
- **W-R9.** An accepted item whose qualification is stale fails.

**`impact` field rules.** The rules compare the YAML front matter of each `plan/work/*.md` at base and head. The class is high when:
- a base `depends_on` or `waits_for` entry is missing or changed at the head;
- an entry added at the head carries `on: finished`;
- a stage's `hold_until` changes;
- `admission` changes, except `candidate` → `admitted` or `candidate` → `declined` on a file whose history never carried `waits_for` (`git log -p`);
- `execution` becomes `cancelled` on an admitted item (03 §5);
- an item file is deleted;
- an existing acceptance block has a modified or deleted line;
- the (ii) line above applies.

The state file counts as high when the Stage row or a Governing-documents row changes. `.claude/hooks/owned_ids.txt` is normal when the diff only appends lines matching the recorder's form (`session_…` or `trig_…`).

**`kinds`.**
- **Records.** The records are the files under `plan/work/`, `plan/decisions/`, `plan/ledger/` and `evidence/`, plus the state file outside its generated blocks and its `Rendered` row (clock-written, like a generated block).
- **What each change needs.** The Record changes lines are the segments of the `- **Record changes:**` lines added in the range, split on `;`. A segment names a record when its first field contains the record's path, its ID (the file stem) or a glob that matches its path:
  - a modified or deleted line needs a segment of kind `correction`, `supersession`, `retirement` or `annotate`;
  - a pure append or a new file needs `addition` or `annotate`;
  - a `correction` segment needs a non-empty reason after its last `·`, other than a `supersedes` or `patch:` field;
  - a modified or deleted line of a log file fails in every case.
- **`patch:` counting.** `patch:<ID>` tokens are counted per mechanism over the log lines added since the newest `plan/decisions/FR-*.md` was added.

**`stamps`.** This check covers the added lines of the state file, of new log entries, and of `DURUM.md`. In `DURUM.md` it checks only the update line and any `Z` time; its other lines are generated from typed fields that are checked in the state file. It also covers the `Written:` line of an added file under `plan/` or `evidence/`. A time is `YYYY-MM-DDTHH:MM(:SS)?Z` or a dateless `HH:MM(:SS)?Z`, read on the commit's UTC date. The commit time is the author time from `git blame` of the line; for uncommitted lines it is the clock.
- **Scheduled fields:**
  - the Run lock `Expires`, at most 3h15m ahead;
  - the Usage `resets`, at most 7 days ahead;
  - the `Armed wakes` entries, written `<type> <time> <owned ID>` and separated by `;`, at most 25 hours ahead. A `S5` entry must equal `resets` plus 15 minutes.

  All of them must be in the future at commit time.
- **Prose:** a later time must be `sched:`-marked.
- **Written-at stamps** must lie within [commit − 15 min, commit]: the state file's As-of cells and `DURUM.md`'s update line, which is Turkey time.
- **Log headers:** the date must not be after the commit's UTC date.

**`claims`.**
- **(a)** This part runs on the whole tree: every repository-root `evidence/…` path in the log, the work items and the decision records must exist. The match is anchored so that a `/`, `.`, `-` or word character before the path excludes it. A path holding `<` or `*` is a pattern, not a claim. The whole-tree scan is clean on `f72b973`, checked by a script before this file was written.
- **(b)** This part runs on the diff. A verdict that the range adds or modifies must match the blob of the same name on `claude/review-<ID>` (remote or local ref): byte-identical, or differing only in lines where the branch line holds a term of the leak check's derived pattern and the copy replaces exactly those terms. It must name a commit that resolves, and its last commit on the review branch must carry a `Claude-Session:` trailer that no commit of the range carries (D-07: not the producer's session).

**`docstatus`.** The governing documents are the paths in the Governing-documents rows, or W-R7's list on a tree that has no such rows (`b74ab11`). Pieces count only from 1c, when they are promoted.
- **Header.** A header is the first paragraph after the `# ` title. It fails when it has a `**Status:**` field whose value is not `see plan/ledger.md, Governing documents`, or a status word (`binding`, `candidate`, `proposal`, `accepted`, `draft`) outside such a field.
- **Fact markers.** `<!--fact:govdoc-status:<path>-->value<!--/fact-->` outside inline code must equal the `status:` field of that path's row. An unknown key fails.

**`chain`.**
- **Homes.** The home table is read from `plan/builder/MEMORY_MAP.md` when it exists (1c), and until then from `02_memory.md` §3, its current home. Each family's home path must exist, unless it is *pending*. A path is pending when a later tranche part names it in its 12 §2.1 contents cell and that part's item is not accepted; it is printed as `INFO pending (1c)`.
- **Indexes.** Every `plan/work/*.md` must appear in the work index or the zoom block, and every `plan/decisions/*.md` in the decisions index.
- **Named files.** Every file path in `CLAUDE.md` or in the home table must exist.
- **Stray records.** No file with an `id:` front matter may lie outside `plan/work/` and `plan/decisions/`.

**`map`.** The carriers that run are:
- the hook command paths in `.claude/settings.json`;
- the files under `tools/`, `.github/workflows/`, `.claude/agents/` and `plan/builder/roles/`.

Each must be named, in backticks, in a Carrier cell of `plan/builder/mechanisms.md` §2. Every path named in a Carrier cell must exist, unless the row is retired or deferred, or the path is pending as for `chain`. Every cell of those tables must be non-blank. A missing carrier is named; a blank cell is named by row and column.

**`decisions`** (R-R10, presence only).
- **Who must carry the full set.** A decision is major when it is `class: batu`, `kind: plan-change`, `FR-nn`, or `major: true`. A major decision must carry `premises`, `alternatives`, `chosen_because`, `reopen_if` and `consulted`.
- **Owner reason.** A `class: batu` decision needs `owner_reason`.
- **Major designs.** An item with `type: major-design` needs `counter_design:`.
- **Records already on the baseline.** These keep their v1.7 content. Only the owner-reason rule applies to them, because adding premises to Batu's past decisions would be writing on his behalf.

**`views`.** This reuses `records.py`'s render functions without stamping the clock. It compares every generated block and `DURUM.md` with the committed text.

**`answers`** (M-R13).
- **Accounted for.** Every comment by `batuhanozgun` on issue #6 must be accounted for: its ID appears in a decision record, or in a log line `not a decision: <id>`.
- **Read failure.** A failed or unparsable read prints `ISSUE_READ_FAILED` as a FAIL.
- **Source.** The URL is `https://api.github.com/repos/batuhanozgun/devos/issues/6/comments?per_page=100` through the proxy (observed: HTTP 200 before this file was written). `ISSUE_API_URL` overrides it for tests; `file://` fixtures work through `curl`.

**Stop reasons** (C-R1) in `builder_check.sh`:
- **S1:** no item of the running stage open.
- **S2:** an `Armed wakes` entry of type `Check-in` whose ID is in `owned_ids.txt`.
- **S3:** the lease is released.
- **S4:** nothing about the successor.
- **S5:** an `S5` entry, owned.
- **`S3 ISSUE_READ_FAILED`:** the M-R13 read failure passes only when the last log entry carries `issue read by MCP:`. With every other reason, it fails.
- **No reason** (today's R1 call): the reason conditions are skipped, with an `INFO` line. Changing R1's call is part of 1c's v1.8 delta.

**R-R9 counter.**
- **Recording.** Every FAIL line carries a class tag. When the tree is clean and `HEAD` equals its upstream branch, the classes of this invocation are appended, de-duplicated, to `$(git rev-parse --git-dir)/builder_check_fails/<session>`. That file is inside `.git`, so it can never be committed.
- **Signal.** At the second invocation that fails with the same class, or when an exception line exists for this session, the check prints `HAND-OVER DUE (R-R9)`.
- **After the signal.** Any reason other than `S4` fails, and `S4` passes once the other checks pass.

**Leak check** (A-07): `check_service_names.sh` on the tracked tree, plus the same pattern on `git diff --cached` and on untracked files that are not ignored, which cover staged content and planted lines.

## 3. Gate tests, made concrete (procedures of `11_test_register.md` §2; PASS and FAIL conditions unchanged)

One script, `tools/test_check_records.py`, builds each fixture as a scratch repository: a copy of the tree at `HEAD` with one root commit, then branches merged with `--no-ff` for PRs, and author dates set where a test needs times. Each test prints `T-xx PASS` only when every listed outcome holds, and the script ends with `GATE 1b-ii PASS` only if all 25 pass. Tests that need real history run in a `--shared` scratch clone of this repository: T-M1 (a), T-M7c (a), T-M14 (a) and T-M15 (e). The rows below say only what is concrete beyond the register's text.

| Test | Concrete fixture |
|---|---|
| T-R20 | scratch repo with a bare remote; a future As-of stamp committed and pushed; `builder_check.sh` called twice, then with `S1`, then `S4` after the stamp is fixed; (b) the same stamp uncommitted, twice |
| T-M1 | (a) scratch clone at `b74ab11`; (c) a `govdoc-status` marker in a scratch file with a wrong value |
| T-M2, T-M5r | hand edits of a generated line, of an item's `execution`, of a `DURUM.md` fact line, and of a `class: batu` decision's status to `open` |
| T-M3 | scratch PR branches against a scratch `main`, each with or without a log entry carrying the Record changes block; (e) also runs `merged` and reads the `patch:` count |
| T-M4 | add `plan/decisions/D-999.md` without re-rendering; delete the `plan/decisions/` row of `02` §3; name `plan/nothing.md` in `CLAUDE.md` |
| T-M6r | `file://` fixtures of the comments API in the five shapes; (e) runs `builder_check.sh S3 ISSUE_READ_FAILED` without, then with, the line in the last log entry, and `S1` with it |
| T-M7a, T-M7b, T-M7c (b, c) | scratch commits with `GIT_AUTHOR_DATE` set; (c) committed at 00:10Z |
| T-M7c (a) | scratch clone at `d69d7c6`; the log lines of L-016 to L-041 are treated as added (base: an empty log), with times from `git blame` at `d69d7c6`; the expected set is the 18 rows of the prototype re-run pinned at `d69d7c6` (m-7) |
| T-M11 | a note block in `plan/work/W-X-99.md` referencing a non-existent parent; a note on a planned C03 item, then the zoom view |
| T-M14 | (a) scratch clones at `05ba7c9` (adds L-019) and `ef4bd4d` (adds L-021) |
| T-M15 | scratch review branches with session trailers; (c) a copy with one derived term replaced by `[service]`; (e) the real `R-W12-1.md` against `claude/review-R-W12-1` |
| T-W1, T-R11 | scratch items and evidence files; (g) and (h) with scratch merges, the second carrying a covering verdict that does not touch the script |
| T-W3r, T-W4 | scratch decisions, a log entry with a correction line, a `rechecked:` note |
| T-W9 | cases (a)–(s) as scratch PRs; (d) and (h2) run `merged` after the merge |
| T-R4, T-R9 | scratch items and decision records |
| T-MAP1–3, T-MAP5, T-MAP7 | scratch tree edits; T-MAP7 plants a derived term in an untracked log line and runs `builder_check.sh` |

**Mutation checks.** Beyond the tests' own negative cases, the script also runs `views` and `kinds` with their comparison disabled by a monkeypatch, and shows that T-M2 and T-M3 then report FAIL. This proves that the tests depend on the check, not on the fixture.

## 4. Self-checks before the review request

| # | Check | Pass only if |
|---|---|---|
| S-1 | `python3 tools/test_check_records.py` on the final head | `GATE 1b-ii PASS`, both mutation checks FAIL as required |
| S-2 | `python3 tools/test_records.py --base f72b973` | `GATE 1b-i PASS` (the 1b-i tests still hold after the `records.py` changes) |
| S-3 | `python3 tools/check_records.py all` on the branch, and `merged` | `RECORDS PASS` |
| S-4 | `python3 plan/builder/w-c00-12/check_ids.py` | `IDS OK` |
| S-5 | `tools/records.py render --check` | `RENDER OK` |
| S-6 | `tools/check_service_names.sh` | `SERVICE_NAMES CLEAN` |
| S-7 | A non-binding Critic subagent reads this file, the diff and the conditions (R-R16) | each finding is answered in §7 before the Verifier is asked |

## 5. Record and text changes in this PR, with reasons

- `plan/ledger.md` Governing-documents row: split into one row per document (`Governing documents: <path>`) with `version`, `status` and `accepted by` fields, text unchanged in substance (F-7).
- `plan/Builder_Operating_Model.md` header: the status sentence becomes `**Status:** see plan/ledger.md, Governing documents.` The removed sentence is moved verbatim into its History list, so nothing is lost. The reason is that T-M1 (b) requires the migrated tree to pass `docstatus`, and OI-011 item 22 already superseded the header word. This pulls one header line of 1c's v1.8 delta forward; no rule changes. It is a departure from 12 §1, stated for the Verifier.
- `plan/builder/mechanisms.md`: carrier rows for `tools/test_records.py`, `tools/test_check_records.py` and `tools/check_dispatcher_pr.sh` (retired with the dispatcher in 1d); A-04 names the helper modes.
- `03_work_model.md`: §3 gets one sentence for the stage-edge rule (F-10); W-R7 gets the (ii) line of §2; W-R1 and W-R4 name the field names used (`acceptance_label`, `composition_by`).
- `plan/work/W-C00-12.md`: the `composition:` field is removed. Its home is acceptance (d), inside the block (F-5).
- `plan/work/W-C00-11.md`: the W-C00-05 edge becomes `on: finished`, with its reason. W-C00-05 is superseded in substance by W-C00-12, which W-C00-11 also depends on. A note records how W-C00-01 to 04 reach acceptance: by a session Verifier before W-C00-11 starts (F-11). Adding `on: finished` is class high; this PR is high anyway.
- `tools/records.py`:
  - a blank or unresolvable `--target-sha` is refused (F-4);
  - briefs list the `answered` notes of the item and its ancestors (F-8);
  - a non-mapping `platform` entry makes the item unknown (F-9);
  - `is_accepted` requires `accepted_by` under `evidence/` (F-3 i).
- `11_test_register.md` T-R22: the blank-SHA case is added (F-4). This is a tightening of a pre-registered test before it runs, not a loosening.
- `evidence/C00/probes/W12-R3_times_walkthrough.md`: a dated section re-running the prototype pinned at `d69d7c6`, with L-027's commit time corrected (R-W12-2 m-7, before T-M7c).
- `plan/work/W-C00-12.3.md`: `execution: running`, `claimed_by` this run, `targets`; N-049 and N-050 closed with their dispositions after the Verifier's verdict. `plan/work/W-C00-12.md`: `claimed_by` this run.

## 6. The session Verifier

The Verifier is started with `create_session` on the PR head. It gets the fixed prompt (`plan/builder/REVIEW_PROMPT.md`), review ID `R-W12-4`, the PR and its head SHA as target, and a generated verifier brief (`records.py brief W-C00-12.3 --role verifier`).

**Criteria:**
- 12 §2.1 row 1b-ii and §2.2 gate 1b-ii;
- the rules listed in §1;
- this file;
- conditions C1 (a) and C5 of `13` §1, as met in the text and by tests;
- a disposition for each R-W12-3 minor finding in N-050 and for N-049;
- the departures of §5.

**Failure classes:**
- a check that cannot fail on its planted case;
- a check that fails on ordinary records;
- a gate test whose procedure departs from its register row;
- a class-high change that the impact check computes as normal;
- a producer-written check accepting the producer's own work;
- a claim stated stronger than the evidence;
- a rule restated instead of pointed to;
- a `.claude/**` or 1c change leaking into this part.

The PR merges only on PASS, or on PASS-WITH-CONDITIONS with the conditions met. A revert branch `claude/revert-w12-1b-ii` is pushed and checked with `git ls-remote` before the merge.

## 7. Departures found during the build (stated before the Critic and the Verifier read the result)

The first gate run (`aee4fec`) showed three failures. Two were fixture defects and one was a checker defect; each was fixed by cause:
- T-M2's state change (`planned` → `waiting`) did not change the render, so the fixture now uses `finished`;
- T-W9 (q)'s fixture "reverted" an added file by checking it out from a parent that lacked it, which made an empty diff, so the fixture now removes it;
- the leak pattern's alternation matched a shorter term inside a longer phrase, which broke the redaction comparison of M-R16 (b). Terms are now tried longest first. Detection is unchanged; only the span is.

Departures from §2 and §5, each a decision for the Verifier to judge:
1. **Zoom view** (`records.py`). T-M11 asks that a note on a planned later-stage item appear "under that item in the zoom view". The 1b-i zoom expanded only the active branch, so such a note showed only as a count. The vertical view now ends with one line for each item outside the expanded branch that carries an open note. Current output gains nothing, because no such item exists today.
2. **Header status words** (`docstatus`). When a header has a `**Status:**` field equal to the pointer, other words in the header are not read. `plan/builder/mechanisms.md` says "a candidate for DevOS's `MechanismAssumption` records" in its header, which is not a status. Without a Status field, a status word fails.
3. **Index exemption** (`chain`). The root record `plan/work/INSTALL.md` (`kind: root`) is in no generated index by design, since it is the purpose chain that briefs print, so it is exempt from the index rule.
4. **Acceptance-block changes** (`impact`). Any difference in an existing acceptance block is high, including an appended line, which W-R7's "modified or deleted line" would not cover. This is stricter; ledger rule 3 treats every later change of an acceptance condition as high.
5. **Lease record line** (`records.py lease`). The command now appends its Record changes line to the newest log file, so a lease PR passes `kinds` with no hand-written line (02 §7, K2 walk-through: "writes the row and the line together").
6. **The prototype's expected set** for T-M7c (a) is the pinned re-run's 19 rows, not the first run's 18 (`evidence/C00/probes/W12-R3_times_walkthrough.md`, correction). The first run, in what was likely a shallow clone, credited L-027's line to a later commit and missed L-028's quoted future stamp.
7. **S-2's base** is `7ed3fa3`, the commit 1b-i's migration branched from. §4 named `f72b973`, against which `test_records.py` cannot find the pre-migration ledger. Corrected here, not in §4, so that the write-ahead stays readable.
8. **The baseline override.** `merged --since` and `builder_check.sh --since` exist so that the scratch tests can set a baseline after their own fixture commits. The override is printed, and `builder_check.sh` refuses it when `BUILDER_RUN=1`.
9. **Errors on merged commits** (`merged`). A `kinds`, `stamps` or `claims` failure on a merged commit can be acknowledged only by a log line `record-check exception: <SHA> <subcommand>: <reason>`. Such a line counts for R-R9 as a failure that reached `main` when that commit carries the session's own trailer.
10. **Scheduled times in `DURUM.md`.** The `Kurulu uyandırmalar` line is not stamp-checked, because it repeats the `Armed wakes` row, which is.

Departures stated after R-W12-4 (its condition C-4), by run `session_01Gfj3M4MjrMb4YcRHwsA1X8`:

11. **R-R9 counter scope and store** (R-W12-4 m-3). `04_roles.md` §6 item 3 says the stop check appends "the class of every FAIL" to "a gitignored per-session file". The code appends only the quality classes (`tree`, `ahead`, `fetch` and `usage` are excluded: they say where the run is, not what it did wrong; Critic finding 8) and stores the file under `$(git rev-parse --git-dir)/builder_check_fails/`, which no `git add` can reach, instead of a gitignored path. The rule's clause is corrected in 1c's v1.8 delta (note N-053 on W-C00-12.4). The counter does not survive a fresh clone; no claim of persistence is made.
12. **The S5 wake bound** (R-W12-4 m-5). `13_r-w12-2_dispositions.md` §2 M-4 words the S5 wake as bounded by `resets` ("at most 7 days plus 15 minutes"); the code and the pre-registered row T-M7a (f) require the `S5` entry to **equal** `resets` plus 15 minutes. The strict reading stays, because it is the pre-registered one (ledger rule 3); a wake armed later than `resets` plus 15 minutes fails `stamps`. M-4's wording is aligned in 1c's v1.8 delta (N-053).
13. **Lease record line** (R-W12-4 m-6; replaces the placement of departure 5). `records.py lease` now writes its Record changes line under a new log entry of its own (`### L-<next> · <date> · Lease taken or renewed by <session>`, or `released`), so it is never attributed to the previous entry. The entry number is the highest `L-` number in the log files plus one.

## 8. Critic findings and responses

A non-binding Critic subagent (fresh context, read-only; R-R16) read this file, the diff `f72b973..560afe7`, the rules, the 25 test rows, the conditions and N-049 and N-050. It reproduced its findings in scratch clones and reported 13: 1 blocking, 8 material, 4 minor. It confirmed that the gate reproduces, that `all` passes on the branch, that a lease renewal is normal and passes `kinds`, that the override is refused in a run, that F-4, F-5, F-7, F-8, F-9 and F-10 behave as disposed, and that no `.claude/**` file changed.

| # | Finding (short) | Severity | Response |
|---|---|---|---|
| 1 | One existing verdict (R-W12-3) could be set as `accepted_by` and `composition_by` of W-C00-12 and its children, which lifts the C00 hold at class normal with every check passing. §2's "lifting the hold needs a bound session verdict" and `summary_tr` item 4 were stronger than the code | blocking | **Accepted.** A verdict now accepts only its own item (`binding_problems`). It must name the item's ID and a reviewed commit at or after the commit where the item started `running`, that commit must be an ancestor of `HEAD`, and the item must be `finished`. One file accepts one item, except a parent's composition verdict, which must also say "composition" and name a commit after every child's last change. The W-R7 (ii) line requires the same at PR time. Planted cases: T-W9 (t), T-W1 (reuse), T-W4 (a child's verdict as the composition record). The wording in §2, W-R7 and `summary_tr` is corrected |
| 2 | Verdict binding satisfiable by the producer: any unowned trailer passes D-07; an exception line can waive a claims (b) failure, even in the same PR; `covered()` ignores claims (b) | material | **Accepted.** The review-branch session must be in `owned_ids.txt` (the recorder's list of sessions this chain created) and not in the range. Claims failures on verdict files cannot be waived. An exception counts only when a later first-parent commit adds it. `covered()` uses only verdicts whose adding commit passes claims (b). Planted case: T-M15 (b2). **Residual, stated:** a producer can still forge a trailer naming a real owned reviewer session; that needs the audit environment's credential (C03, D-003) |
| 3 | An unrelated verdict naming the reverted merge covers a break-glass revert, because `covered()`'s "X..m2 normal" used the break-glass equivalence | material | **Accepted.** `covered()` computes the X..m2 class without the break-glass exception. A break-glass revert is covered only by a verdict naming the revert's own head or merge. Planted case: T-W9 (h3) |
| 4 | Break-glass accepted a rollback past a later merge, because only the head was compared with M^1 | material | **Accepted.** The base must also equal M on every path of the part. Planted case: T-W9 (h4) |
| 5 | The after-the-fact check now lives in `tools/check_records.py`, which is eligible for break-glass | material | **Declined, with reason.** T-W9 (h) was pre-registered with "the exact revert of a merge that changed only `tools/check_records.py` is class normal". Changing its PASS condition is not this part's to do (ledger rule 3). With #4's fix, a break-glass revert restores exactly M^1's version of the checker, which was itself a class-high merge with its own verdict and already holds the after-the-fact check (it exists from 1b-ii on). Reverting 1b-ii itself removes the checker, and then `builder_check.sh`, which never qualifies, fails closed on the missing script |
| 6 | `map` could not fail for A-01, A-04, B9 or B2: "retired" or "deferred" anywhere in the row exempted it, and `pending` excused existing carriers | material | **Accepted.** Inactivity is read only from the row's ID, name and carrier cells. A path that existed at the baseline is never pending. Planted cases: T-MAP2 removes `tool_allowlist.py`, `builder_check.sh` and `CLAUDE.md` |
| 7 | Every stop fails in a shallow clone (the leak derivation needs `3cd686a`) | material | **Accepted.** `builder_check.sh` runs `git fetch --unshallow` when the clone is shallow and prints that it did |
| 8 | R-R9 counted `ahead`, `tree` and `fetch`, and T-R20 (a) could not show that `stamps` was counted | material | **Accepted.** Only quality classes count. T-R20 (a) now merges first and asserts that the repeated class is `stamps` |
| 9 | W-R1 accepted producer-written work: `shell=True` with one checked token; a hand-written `subagent` verdict accepted | material | **Accepted.** The deterministic command must be `<python3\|bash> <script> [args]` with no shell metacharacters, run without a shell, and every script argument is checked for pre-registration. A `subagent` label cannot accept in tranche 1, because nothing binds it. This is stricter than W-R1's label list, and the W-R1 text says so |
| 10 | A `*` glob in a Record changes line covered every record | minor | **Accepted.** A glob must start under a named directory and names records only for additions |
| 11 | Test fidelity: T-W9 (i) lacked the Governing-row case; (d) and (h2) called `merged`, not the stop check; T-W1 (g)'s "normal-class PR" is a `tools/` change | minor | **Accepted** for (i), (d) and (h2): the Governing-row revert was added, and (d) and (h2) now run `builder_check.sh`. For (g), a script change is class high by W-R7, so "normal-class PR" can only mean a PR merged without its verdict. That is what the fixture builds, stated here as the reading |
| 12 | An `execution` change on the target of an `on: finished` edge lifted readiness at class normal | minor | **Accepted.** It is class high (`impact`) |
| 13 | `answers` substring match; claims (b) accepted any resolvable SHA; `docstatus` pointer by prefix | minor | **Accepted.** The comment ID must match as a whole number; the named commit must be an ancestor of the head; the pointer must match exactly |

The gate was re-run after these changes: 25/25, with the planted cases above among the outcomes, and both mutation checks caught.

## 9. R-W12-4 conditions and responses (run `session_01Gfj3M4MjrMb4YcRHwsA1X8`)

R-W12-4 (`evidence/C00/reviews/R-W12-4.md`) gave PASS-WITH-CONDITIONS on `242d195`, with one blocking condition. Each condition and minor finding, with the response on this branch:

| Item | Response |
|---|---|
| C-1 (B-1, blocking) | `impact()` now calls `exemption_problems()`: the item must be `accepted` with a session label, and every verdict it names (`accepted_by`, and `composition_by` when set) must pass `verdict_bound_at()` (M-R16 (b): claims (b) on the range when the range adds or changes the file, otherwise the commit that added it) and `binding_problems()` evaluated at the PR head (names the item; a reviewed commit at or after the item's first `running` commit, an ancestor of the head; item `finished`; one verdict, one item). `binding_problems()` and `first_running_commit()` take the revision to judge, so the PR-time and the stop-time checks are the same code. Planted cases in T-W9: (u) the Verifier's scenario 1 (a producer-written file), (v) its scenario 2 (`R-W12-2.md` as `accepted_by` and `composition_by`), each asserting the reason, and (w) a control in which a bound verdict naming an edge target after its start stays class normal. On the pre-fix checker, in a scratch clone of `991d51a` with `d6dea29`'s `check_records.py` committed, (u) and (v) FAIL and (t) and (w) PASS; on the fixed checker all pass. The texts (W-R7, N-049 (ii), §2, `summary_tr` item 4) were rewritten after that |
| C-2 (m-1) | Met in `d6dea29` by the previous run |
| C-3 (m-2) | `tools/test_check_records.py` checks its preconditions before any test: no shallow clone, and a `refs/remotes/origin/claude/review-<ID>` ref for every verdict under `evidence/*/reviews/`. Either missing prints `PRECONDITION FAIL` with the fetch command and fails the gate. The docstring and the gate evidence header state both |
| C-4 (m-3, m-5, m-6) | Departures 11 and 12 above; m-6 fixed in code (departure 13) |
| m-4 | The gate evidence names the stop reasons this gate does not exercise (S2, plain S3, S5) and the gate that does (T-C5, gate 1d) |
| m-7 | Note N-053 on W-C00-12.4: the 1c Verifier confirms that T-R22 (a2) runs |
| m-8 | Met before this run: the recorder line for R-W12-4 is on `main` (PR #76) |
| m-9 | The R-W12-5 Verifier's first message is the review prompt followed by the generated brief, read from the generator's output file and passed byte for byte (F-049-3). T-W6 in 1c gets a brief whose text differs from its hash (N-053) |

