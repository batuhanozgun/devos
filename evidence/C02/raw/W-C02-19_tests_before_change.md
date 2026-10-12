# W-C02-19: the merge gate's new tests, run before the gate change

This file holds W-C02-19's test run against the gate as it was before the change, and the break procedure. The cases are (20) to (30) in `tools/test_merge_gate.py`, written by the item's test designer. The gate (`tools/merge_gate.py`) is unchanged from `main` here. The run shows that the cases detect the gap the item closes: on this gate, the negative cases for the five paths the gate does not class, and for the link forms, print `BAD`, and case (28) fails on those five paths. The gate change, its producer's run and the checker's verdict come later and are not in this file.

## Evidence envelope

- **Target commit:** `560bcab1d2ac336be06c8eacca08700c44ed485b` (`main`; branch `claude/c02-w19-merge-gate-paths`), with the working-tree change to `tools/test_merge_gate.py` (`git diff --stat HEAD`: 1 file changed, 311 insertions, 5 deletions; not yet committed when this run was made). `tools/merge_gate.py`, `.claude/hooks/tool_allowlist.py` and `plan/DevOS_Kurulum_Plani.md` were unchanged from HEAD (`git diff --quiet HEAD -- <those three>`: exit 0). Gate blob at HEAD: `c5614fb93cd6224ab182d30405851971cd8d96f6` (`git rev-parse HEAD:tools/merge_gate.py`). The test file's identity is the blob the executor commits.
- **Command**, from the repository root of the scratch clone: `python3 tools/test_merge_gate.py`
- **When:** 2026-10-12, started after 15:08:15Z, ended 15:08:35Z.
- **Configuration:** Linux; Python 3.13.16 (POSIX locale, so Python's UTF-8 mode is on); git 2.43.0.
- **Criterion:** W-C02-19's acceptance block, as merged in `560bcab`.
- **Exit code:** 1. **Final line:** `MERGE_GATE_TEST FAIL (46/78)`: 46 `ok`, 32 `BAD`.
- **Independence:** the tests were written and run by the test designer, a helper subagent of the executor's session. This is the designer's own run of its own tests, not a verdict. The checker runs the tests again at the producer's head and builds the breaks itself.

## Raw output

The blank line after each `BAD` line is in the output: the gate's last line ends with a newline.

```
ok   (1) a class-normal head passes without a verdict
ok   (1g) the guard allows that merge by rule M7, which runs tools/merge_gate.py
ok   (2) a class-high head without a verdict fails
ok   (2g) the guard denies that merge by rule M7
ok   (3) the same change with a PASS verdict naming the reviewed commit passes
ok   (4) a SHA that is no longer the pull request's head fails
ok   (5) a verdict for an older X passes when X..head is class normal
ok   (6) a verdict for an older X fails when X..head touches a class-high path
ok   (7) a FAIL verdict does not cover
ok   (8) a verdict without the independence field does not cover
ok   (9) a verdict naming a short SHA does not cover
ok   (10) a short head SHA fails in the gate and is denied by the guard's M6
ok   (11) a change that only adds recorder lines to owned_ids.txt is class normal
ok   (11b) any other change to owned_ids.txt is class high
ok   (12) a pull request number the remote does not hold fails
ok   (13) a change to plan/Installation_Working_Order.md is class high
ok   (14) changing the text of an existing acceptance block is class high
ok   (14b) removing an existing acceptance block is class high
ok   (15) deleting a plan/work/*.md file is class high
ok   (16) adding a block where none existed, and editing outside a block, stay class normal
ok   (17) a verdict file with a repeated key does not cover
ok   (18) a nested CLAUDE.md and a nested .claude/ path are class high
ok   (19) a pull request that reverts a reviewed change, adding no verdict, is not covered by an older verdict on main
ok   (19b) a verdict the pull request adds for a commit already on main does not cover
ok   (20a) CLAUDE.md: deleted, no verdict: GATE FAIL naming CLAUDE.md
ok   (20p) CLAUDE.md: (20a) with a covering verdict it adds: GATE PASS, covered by
ok   (20b) CLAUDE.md: renamed out (to archive/rules-old.md), no verdict: GATE FAIL naming CLAUDE.md
ok   (21a) .claude/: a new file one level down (.claude/protocols/D10.md), no verdict: GATE FAIL naming it
ok   (21p) .claude/: (21a) with a covering verdict it adds: GATE PASS, covered by
ok   (21b) .claude/: plan/notes.md renamed into it (.claude/notes.md), no verdict: GATE FAIL naming .claude/notes.md
BAD  (21c) .claude/: a symbolic link at a nested .claude path (docs/.claude -> ../.claude), no verdict: GATE FAIL naming docs/.claude: GATE PASS: PR #104 head cc676f4a3048: class normal: d6f9c9d32201..cc676f4a3048

BAD  (22a) methods/: a new file one level down (methods/review/checklist.md), no verdict: GATE FAIL naming it: GATE PASS: PR #105 head 5b7b7c0d9ab6: class normal: d6f9c9d32201..5b7b7c0d9ab6

BAD  (22p) methods/: (22a) with a covering verdict it adds: GATE PASS, covered by: GATE PASS: PR #105 head 03a55fa9f223: class normal: d6f9c9d32201..03a55fa9f223

BAD  (22b) methods/: a new file with a non-ASCII name (methods/ölçüm-yöntemi.md), no verdict: GATE FAIL naming it: GATE PASS: PR #106 head a22db5bb0f6e: class normal: d6f9c9d32201..a22db5bb0f6e

BAD  (22c) methods/: a symbolic link at its own path (methods -> docs), no verdict: GATE FAIL naming methods: GATE PASS: PR #107 head 749e003304ab: class normal: d6f9c9d32201..749e003304ab

BAD  (23a) supabase/migrations/: a new migration (supabase/migrations/20261012000001_fixture_item.sql), no verdict: GATE FAIL naming it: GATE PASS: PR #108 head 3b8cc900697f: class normal: d6f9c9d32201..3b8cc900697f

BAD  (23g) supabase/migrations/: the guard denies (23a)'s merge by rule M7: allowed by rule M7: GATE PASS: PR #108 head 3b8cc900697f: class normal: d6f9c9d32201..3b8cc900697f
BAD  (23p) supabase/migrations/: (23a) with a covering verdict it adds: GATE PASS, covered by: GATE PASS: PR #108 head 48f07f80b816: class normal: d6f9c9d32201..48f07f80b816

BAD  (23h) supabase/migrations/: the guard allows that merge by rule M7 once (23p)'s verdict is added: allowed by rule M7: GATE PASS: PR #108 head 48f07f80b816: class normal: d6f9c9d32201..48f07f80b816
BAD  (23b) supabase/migrations/: a new file whose name has a space (supabase/migrations/20261012000002 fixture index.sql), no verdict: GATE FAIL naming it: GATE PASS: PR #109 head e4f866299edf: class normal: d6f9c9d32201..e4f866299edf

BAD  (23c) supabase/migrations/: a symbolic link at its own path (supabase/migrations -> ../docs), no verdict: GATE FAIL naming supabase/migrations: GATE PASS: PR #110 head 859e20148d0b: class normal: d6f9c9d32201..859e20148d0b

BAD  (23d) supabase/migrations/: a pull request mixing a new migration (supabase/migrations/20261012000003_fixture_mixed.sql) with a class-normal change (plan/notes.md), no verdict: GATE FAIL naming the migration: GATE PASS: PR #111 head efa59e63cd28: class normal: d6f9c9d32201..efa59e63cd28

BAD  (24a) supabase/functions/: a new function one level down (supabase/functions/fixture-hello/index.ts), no verdict: GATE FAIL naming it: GATE PASS: PR #112 head 71f8002d6a1c: class normal: d6f9c9d32201..71f8002d6a1c

BAD  (24p) supabase/functions/: (24a) with a covering verdict it adds: GATE PASS, covered by: GATE PASS: PR #112 head 14d2ca752c50: class normal: d6f9c9d32201..14d2ca752c50

BAD  (24b) supabase/functions/: a symbolic link at its own path (supabase/functions -> ../docs), no verdict: GATE FAIL naming supabase/functions: GATE PASS: PR #113 head 2f47c59044b5: class normal: d6f9c9d32201..2f47c59044b5

BAD  (24c) supabase/functions/ and supabase/migrations/: a symbolic link at their parent's path (supabase -> docs), no verdict: GATE FAIL naming supabase: GATE PASS: PR #114 head 948a650f01d1: class normal: d6f9c9d32201..948a650f01d1

BAD  (25a) pipelines/: a new file one level down (pipelines/embedding/embed.py), no verdict: GATE FAIL naming it: GATE PASS: PR #115 head 98dfebee373e: class normal: d6f9c9d32201..98dfebee373e

BAD  (25p) pipelines/: (25a) with a covering verdict it adds: GATE PASS, covered by: GATE PASS: PR #115 head cd973923ddf2: class normal: d6f9c9d32201..cd973923ddf2

BAD  (25b) pipelines/: a regular file at its own path (pipelines), no verdict: GATE FAIL naming pipelines: GATE PASS: PR #116 head 9c2f87b50157: class normal: d6f9c9d32201..9c2f87b50157

BAD  (25c) pipelines/: a symbolic link at its own path (pipelines -> docs), no verdict: GATE FAIL naming pipelines: GATE PASS: PR #117 head 876ebf2dc17f: class normal: d6f9c9d32201..876ebf2dc17f

ok   (26a) .github/workflows/: a new workflow whose name has a space (.github/workflows/nightly fixture.yml), no verdict: GATE FAIL naming it
ok   (26p) .github/workflows/: (26a) with a covering verdict it adds: GATE PASS, covered by
BAD  (26b) .github/workflows/: a symbolic link at its own path (.github/workflows -> ../docs), no verdict: GATE FAIL naming .github/workflows: GATE PASS: PR #119 head 7bca94643e25: class normal: d6f9c9d32201..7bca94643e25

BAD  (27a) .github/CODEOWNERS: a new file, no verdict: GATE FAIL naming .github/CODEOWNERS: GATE PASS: PR #120 head 836b3199929c: class normal: d6f9c9d32201..836b3199929c

BAD  (27p) .github/CODEOWNERS: (27a) with a covering verdict it adds: GATE PASS, covered by: GATE PASS: PR #120 head 91c46ce5827a: class normal: d6f9c9d32201..91c46ce5827a

BAD  (27b) .github/CODEOWNERS and .github/workflows/: a symbolic link at their parent's path (.github -> docs), no verdict: GATE FAIL naming .github: GATE PASS: PR #121 head 31ab6193e7a1: class normal: d6f9c9d32201..31ab6193e7a1

BAD  (27c) .github/CODEOWNERS and .github/workflows/: a regular file at their parent's path (.github), no verdict: GATE FAIL naming .github: GATE PASS: PR #122 head 02e2a1e93888: class normal: d6f9c9d32201..02e2a1e93888

BAD  (23e) supabase/migrations/: a migration deleted (supabase/migrations/20261001000000_fixture_init.sql), no verdict: GATE FAIL naming it: GATE PASS: PR #123 head 347bc89c952f: class normal: 48e764380903..347bc89c952f

BAD  (24d) supabase/functions/: a function changed (supabase/functions/fixture-hello/index.ts), no verdict: GATE FAIL naming it: GATE PASS: PR #124 head ee473e0d2a15: class normal: 48e764380903..ee473e0d2a15

BAD  (25d) pipelines/: a file changed (pipelines/ingest/run.py), no verdict: GATE FAIL naming it: GATE PASS: PR #125 head 790675925a60: class normal: 48e764380903..790675925a60

BAD  (25e) pipelines/: a file renamed out (pipelines/ingest/run.py to archive/run.py), no verdict: GATE FAIL naming pipelines/ingest/run.py: GATE PASS: PR #126 head 928ccec5a5ce: class normal: 48e764380903..928ccec5a5ce

ok   (26c) .github/workflows/: a workflow deleted (.github/workflows/ci.yml), no verdict: GATE FAIL naming it
BAD  (27d) .github/CODEOWNERS: changed, no verdict: GATE FAIL naming .github/CODEOWNERS: GATE PASS: PR #128 head 28ac863c4638: class normal: 48e764380903..28ac863c4638

BAD  (27e) .github/CODEOWNERS: renamed out (to archive/CODEOWNERS.old), no verdict: GATE FAIL naming .github/CODEOWNERS: GATE PASS: PR #129 head 39f5f83c24ad: class normal: 48e764380903..39f5f83c24ad

     plan 6.7: 8 backticked paths found: .github/CODEOWNERS, CLAUDE.md, .claude/, methods/, supabase/migrations/, supabase/functions/, pipelines/, .github/workflows/
     plan 6.7: skipped, as it names no path: 'the code of the decision channel once C06 writes it'
     plan 6.7: not class high: .github/CODEOWNERS, methods/, supabase/migrations/, supabase/functions/, pipelines/; of the eight, not in the list: none; in the list, not of the eight: none
BAD  (28) every path that plan 6.7's "High-impact path list" names (read from plan/DevOS_Kurulum_Plani.md) is class high, and the list names the eight of (20) to (27): not class high: ['.github/CODEOWNERS', 'methods/', 'supabase/migrations/', 'supabase/functions/', 'pipelines/']; of the eight, not in the list: []; not of the eight: []
ok   (29a) near miss supabase/config.toml, no verdict: GATE PASS, class normal
ok   (29b) near miss supabase/seed.sql, no verdict: GATE PASS, class normal
ok   (29c) near miss supabase/migrations-notes.md, no verdict: GATE PASS, class normal
ok   (29d) near miss methods.md, no verdict: GATE PASS, class normal
ok   (29e) near miss pipelines-old/x.py, no verdict: GATE PASS, class normal
ok   (29f) near miss .github/CODEOWNERS.md, no verdict: GATE PASS, class normal
ok   (29g) near miss docs/methods/x.md, no verdict: GATE PASS, class normal
ok   (29h) near miss tests/supabase/migrations/x.sql, no verdict: GATE PASS, class normal
ok   (29i) near miss tests/pipelines/x.py, no verdict: GATE PASS, class normal
ok   (29j) near miss .github/ISSUE_TEMPLATE/x.md, no verdict: GATE PASS, class normal
ok   (29k) near miss tests/methods, a symbolic link named like a listed directory below another directory, no verdict: GATE PASS, class normal
ok   (30a) a file name that is not valid UTF-8 under supabase/migrations/: GATE FAIL or GATE ERROR, never GATE PASS
ok   (30b) a file name that is not valid UTF-8 under .github/workflows/: GATE FAIL or GATE ERROR, never GATE PASS
MERGE_GATE_TEST FAIL (46/78)
```

On this gate, (30a) and (30b) give `GATE ERROR: UnicodeDecodeError: 'utf-8' codec can't decode byte 0xff` (0xfe for (30b)), exit 2. This was seen in a scratch copy whose `case()` also prints passing cases' output. It is not visible in the run above, because `ok` lines carry no detail.

## Cases: expected after the change, result now

"Point" is the point of W-C02-19's acceptance block that the case serves. Every case is expected `ok` after the change; the full run is then expected to give `MERGE_GATE_TEST PASS (78/78)`.

| Case | Path | Form | Point | Expected after the change | Now |
|---|---|---|---|---|---|
| (1) to (19b), 24 cases | as on `main` | as on `main` | 3 (a) | ok | ok (24/24) |
| (20a) | `CLAUDE.md` | deleted | 1 (a) | ok: GATE FAIL naming it | ok |
| (20p) | `CLAUDE.md` | positive, verdict added | 1 (b) | ok: GATE PASS, covered by | ok |
| (20b) | `CLAUDE.md` | renamed out | 1 (a) | ok | ok |
| (21a) | `.claude/` | new file one level down | 1 (a) | ok | ok |
| (21p) | `.claude/` | positive | 1 (b) | ok | ok |
| (21b) | `.claude/` | renamed into | 1 (a) | ok | ok |
| (21c) | `.claude/` | symbolic link at a nested `.claude` path | 1 (a), link form | ok | **BAD** (class normal) |
| (22a) | `methods/` | new file one level down | 1 (a) | ok | **BAD** |
| (22p) | `methods/` | positive | 1 (b) | ok | **BAD** (class normal, so not "covered by") |
| (22b) | `methods/` | non-ASCII name | 1 (a) | ok | **BAD** |
| (22c) | `methods/` | symbolic link at its own path | 1 (a), link form | ok | **BAD** |
| (23a) | `supabase/migrations/` | new migration | 1 (a) | ok | **BAD** |
| (23g) | `supabase/migrations/` | guard denies by M7 | 1 (d) | ok | **BAD** (allowed) |
| (23p) | `supabase/migrations/` | positive | 1 (b) | ok | **BAD** |
| (23h) | `supabase/migrations/` | guard allows by M7 after the verdict | 1 (d) | ok | **BAD** (allowed as class normal, not covered) |
| (23b) | `supabase/migrations/` | name with a space | 1 (a) | ok | **BAD** |
| (23c) | `supabase/migrations/` | symbolic link at its own path | 1 (a), link form | ok | **BAD** |
| (23d) | `supabase/migrations/` | mixed with a class-normal path | 1 (a) | ok | **BAD** |
| (23e) | `supabase/migrations/` | deleted | 1 (a) | ok | **BAD** |
| (24a) | `supabase/functions/` | new function one level down | 1 (a) | ok | **BAD** |
| (24p) | `supabase/functions/` | positive | 1 (b) | ok | **BAD** |
| (24b) | `supabase/functions/` | symbolic link at its own path | 1 (a), link form | ok | **BAD** |
| (24c) | `supabase/functions/`, `supabase/migrations/` | symbolic link at the parent path `supabase` | 1 (a), link form | ok | **BAD** |
| (24d) | `supabase/functions/` | changed | 1 (a) | ok | **BAD** |
| (25a) | `pipelines/` | new file one level down | 1 (a) | ok | **BAD** |
| (25p) | `pipelines/` | positive | 1 (b) | ok | **BAD** |
| (25b) | `pipelines/` | regular file at its own path | 1 (a), link form | ok | **BAD** |
| (25c) | `pipelines/` | symbolic link at its own path | 1 (a), link form | ok | **BAD** |
| (25d) | `pipelines/` | changed | 1 (a) | ok | **BAD** |
| (25e) | `pipelines/` | renamed out | 1 (a) | ok | **BAD** |
| (26a) | `.github/workflows/` | new file, name with a space | 1 (a) | ok | ok |
| (26p) | `.github/workflows/` | positive | 1 (b) | ok | ok |
| (26b) | `.github/workflows/` | symbolic link at its own path | 1 (a), link form | ok | **BAD** |
| (26c) | `.github/workflows/` | deleted | 1 (a) | ok | ok |
| (27a) | `.github/CODEOWNERS` | new file | 1 (a) | ok | **BAD** |
| (27p) | `.github/CODEOWNERS` | positive | 1 (b) | ok | **BAD** |
| (27b) | `.github/CODEOWNERS`, `.github/workflows/` | symbolic link at the parent path `.github` | 1 (a), link form | ok | **BAD** |
| (27c) | `.github/CODEOWNERS`, `.github/workflows/` | regular file at the parent path `.github` | 1 (a), link form | ok | **BAD** |
| (27d) | `.github/CODEOWNERS` | changed | 1 (a) | ok | **BAD** |
| (27e) | `.github/CODEOWNERS` | renamed out | 1 (a) | ok | **BAD** |
| (28) | plan 6.7's list | read from the plan, each path planted | 2 | ok | **BAD** (five paths not class high) |
| (29a) to (29k) | near misses | new file or link | 3 (b) | ok: GATE PASS, class normal | ok (11) |
| (30a), (30b) | `supabase/migrations/`, `.github/workflows/` | name not valid UTF-8 | 3 (d) | ok: GATE FAIL or GATE ERROR | ok (GATE ERROR) |

Forms across the eight paths: new file ((21a), (22a), (23a), (24a), (25a), (27a)); changed ((24d), (25d), (27d)); deleted ((20a), (23e), (26c)); renamed into ((21b)); renamed out ((20b), (25e), (27e)); a space ((23b), (26a)); a non-ASCII character ((22b)); a file or link at a listed directory's own or parent path, for every directory path ((21c), (22c), (23c), (24b), (24c), (25b), (25c), (26b), (27b), (27c)); mixed with a class-normal path ((23d)). For the forms that need a file already on `main` (changed, deleted, renamed out), the fixture first merges made-up files under the listed paths into its `main`. The link-form cases run before that merge, so that no listed path is in their diff.

## Breaks

**How a break copy works.** The test file reads the gate, the guard and the plan from its own parent's parent (`REPO`). A break copy is therefore a directory `BRK/<name>/` holding four files at their repository paths: `tools/merge_gate.py`, `tools/test_merge_gate.py`, `.claude/hooks/tool_allowlist.py` and `plan/DevOS_Kurulum_Plani.md`. Each file is taken with `git show <head>:<path>`, and one of them is then edited. The run is `python3 BRK/<name>/tools/test_merge_gate.py`; its raw output and exit code are kept. The clone's `tools/merge_gate.py` is never edited.

**Procedure for the checker, at the producer's full head SHA.** Build each break yourself from `git show <head>:<path>` after reading the head's gate. The break texts used below were written for the gate at `560bcab` and will not match the changed gate.

1. **Control.** Make a copy with no edit and run it. Expected: `MERGE_GATE_TEST PASS (78/78)`, exit 0, the same as a run in the clone.
2. **Point 1 (c): one break per path, eight runs.** For path P, remove from the copy's gate every rule that classes P: its list or prefix entry, any file-name or component rule (for `CLAUDE.md`, the file-name rule; for `.claude/`, the component rule), and the link-form rule's entry for P's own path and for a parent path. A parent such as `supabase` or `.github` is shared by two listed paths; take its entry out in the run of either path, and say which. If a removal leaves another rule still classing P, record that, then remove that rule as well. Expected: every lettered negative case of P prints `BAD`. These are (20a, b); (21a, b, c); (22a, b, c); (23a, b, c, d, e) with (23g); (24a, b, d); (25a to e); (26a, b, c); (27a to e); and (24c) or (27b, c) in the run that removes the parent entry. (28) prints P under "not class high". The run ends `MERGE_GATE_TEST FAIL`.
3. **The link form on its own.** Remove only the rule that classes a file or link at a listed directory's own or parent path, `.claude` nested included. Expected: (21c), (22c), (23c), (24b), (24c), (25b), (25c), (26b), (27b) and (27c) print `BAD`; the other new cases stay `ok`.
4. **Point 2.** Run three breaks:
   - **plan-ninth:** in the copy's plan, add a ninth synthetic backticked path to the bullet, for example `` `fixtures/ninth-synthetic/` `` before "and the code of the decision channel". Expected: the "plan 6.7:" lines show 9 paths, with that path under both "not class high" and "not of the eight"; (28) prints `BAD`.
   - **plan-nobullet:** delete the bullet's line. Expected: `plan 6.7: could not check: no "High-impact path list" bullet ...`, (28) prints `BAD`, and the run fails.
   - **plan-missing:** delete the copy's plan file. Expected: `plan 6.7: could not check: plan/DevOS_Kurulum_Plani.md is missing or unreadable ...`, (28) prints `BAD`, and the run fails.

   In each of these runs, every other case stays `ok`.
5. **Point 3 (b), rules wider than the list:**
   - Prefixes without the trailing `/` (`supabase`, `methods`, `pipelines`, `.github/CODEOWNERS`): (29a) to (29f) print `BAD`.
   - A listed directory's name accepted as any path component: (29a, b, c, g, h, i, k) print `BAD`.
   - All of `.github/`: (29f) and (29j) print `BAD`.
6. **Point 3 (d).** Make `changed()` return no paths when the diff cannot be decoded. Expected: (30a) and (30b) print `BAD` (`GATE PASS`, class normal).

**Breaks run now, on the gate at `560bcab`.** Made with a scratch helper; its copies were taken from the clone's working tree (gate, guard and plan unchanged from HEAD). Each row is one run.

| Break | Edit to the copy | Result |
|---|---|---|
| control | none | `MERGE_GATE_TEST FAIL (46/78)`, the same cases as the filed run |
| claude-md | `"CLAUDE.md"` taken out of `HIGH_FILES`, and `parts[-1] == "CLAUDE.md"` taken out | (20a), (20b) `BAD`; (20p) and old (2) `BAD` too; (28) lists `CLAUDE.md` as not class high; FAIL (32/78) |
| claude-md-list-only | only `"CLAUDE.md"` taken out of `HIGH_FILES` | (20a), (20b) stay `ok`: the file-name rule still classes it. Recorded as "another rule classes the path", not a failed break |
| dot-claude | `".claude/"` taken out of `HIGH_PREFIXES`, and `".claude" in parts[:-1]` taken out | (21a), (21b) `BAD`; (21p) and old (18) `BAD` too; (28) lists `.claude/`; FAIL (41/78) |
| dot-claude-prefix-only | only `".claude/"` taken out of `HIGH_PREFIXES` | (21a), (21b) stay `ok`: the component rule still classes `.claude/...`. Recorded as "another rule classes the path" |
| workflows | `".github/workflows/"` taken out of `HIGH_PREFIXES` | (26a), (26c) `BAD`, (26p) `BAD`; (28) lists `.github/workflows/`; FAIL (43/78) |
| plan-ninth | `` `fixtures/ninth-synthetic/` `` added to the bullet | (28) `BAD`: 9 paths found; `fixtures/ninth-synthetic/` is not class high and not of the eight |
| plan-nobullet | the bullet's line deleted | `plan 6.7: could not check: no "High-impact path list" bullet in section 6.7 of plan/DevOS_Kurulum_Plani.md`; (28) `BAD`; FAIL |
| plan-missing | the plan file deleted | `plan 6.7: could not check: plan/DevOS_Kurulum_Plani.md is missing or unreadable (FileNotFoundError: ...)`; (28) `BAD`; FAIL |
| wide-prefix | `"supabase", "methods", "pipelines", ".github/CODEOWNERS"` added to `HIGH_PREFIXES` | (29a) to (29f) `BAD`; (28) then finds every path class high: an over-wide gate is caught by (29), not by (28); FAIL (68/78) |
| wide-component | any path with a component `methods`, `pipelines` or `supabase` classed high | (29a, b, c, g, h, i, k) `BAD`; FAIL (62/78) |
| wide-github | `".github/"` added to `HIGH_PREFIXES` | (29f), (29j) `BAD`; FAIL (49/78) |
| decode-swallow | `changed()` returns `[]` on `ValueError` | (30a), (30b) `BAD` (`GATE PASS`, class normal); FAIL (44/78) |

**Not shown now, and why.** Three things cannot be shown on this gate:

- The point 1 (c) breaks for `methods/`, `supabase/migrations/`, `supabase/functions/`, `pipelines/`, `.github/CODEOWNERS` and the link form: there is no rule to remove until the producer writes one.
- The flip of (28) from `ok` to `BAD` under the point 2 breaks: on this gate (28) is already `BAD` because of the five unclassed paths, so these runs show only the printing ("could not check", the ninth path) and the failing run.
- That the whole file can pass: no gate that passes all 78 cases exists yet, and the designer did not write one, because that would be the item's product.

All three are shown first by the checker's runs at the producer's head.

## What these tests do not cover

The acceptance block's "Not covered" list holds; this adds only what the tests themselves leave out.

- **A link at the root `.claude` path is not planted on its own.** In the fixture, as in `devos`, `.claude/` exists. A link there deletes its files, and those deletions are class high already. The nested form (21c) is the one that tests a new rule.
- **(30) depends on the locale.** It expects the gate to read names as UTF-8, which it does under a UTF-8 locale or Python's UTF-8 mode. Under a single-byte locale, the gate would decode the name and class it by its path instead; that is still not `GATE PASS` once the paths are classed.
- **Case (28) reads only backticked spans in the bullet.** A path written without backticks would not be found. Any non-path span would make the set differ from the eight, so the run fails rather than passes.
- **The test file's `run()` now decodes tool output with `errors="replace"`.** This keeps an undecodable byte in a tool's output from crashing the test. It does not change any of cases (1) to (19b).
- **Point 3 (c) and point 5 are not covered by these tests.** Point 3 (c) is the gate's diff and docstring, which the checker reads. Point 5 is the live tree's sync after the merge.
