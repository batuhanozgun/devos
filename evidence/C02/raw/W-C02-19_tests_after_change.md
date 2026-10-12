# W-C02-19: the merge gate's tests, run after the gate change

This file holds the producer's run of `tools/test_merge_gate.py` against the changed gate (`tools/merge_gate.py`), and one break the producer ran as its own check. The test designer's run before the change, and the break procedure the checker follows, are in `W-C02-19_tests_before_change.md`. This is the producer's own run, not a verdict: the checker runs the tests again at the full head SHA and builds every break itself.

## Evidence envelope

- **Target commit:** `58357b2b11d663cb95f594db68404090745548d6` (branch `claude/c02-w19-merge-gate-paths`: `main` `8d4ca08` plus the test designer's tests), with the producer's working-tree change to `tools/merge_gate.py` (not yet committed when this run was made; `git diff --stat HEAD`: 1 file changed, 19 insertions, 9 deletions). Gate blob before: `c5614fb93cd6224ab182d30405851971cd8d96f6` (HEAD); gate blob run: `2a7f6bd103b89a3e9d93974b133d65861f240a08` (`git diff --full-index HEAD -- tools/merge_gate.py`). `tools/test_merge_gate.py`, `.claude/hooks/tool_allowlist.py` and `plan/DevOS_Kurulum_Plani.md` were unchanged from HEAD (`git diff --quiet HEAD -- <those three>`: exit 0). The note N-241 on `plan/work/C06.md` was written after this run; the test file does not read that file.
- **Command**, from the repository root of the scratch clone: `python3 -B tools/test_merge_gate.py`
- **When:** 2026-10-12, started 15:15:01Z, ended 15:15:18Z.
- **Configuration:** Linux; Python 3.13.16 (POSIX locale, so Python's UTF-8 mode is on); git 2.43.0.
- **Criterion:** W-C02-19's acceptance block, as merged in `560bcab`, and the test designer's statement of what the change must make true (`W-C02-19_tests_before_change.md`, "Cases: expected after the change").
- **Exit code:** 0. **Final line:** `MERGE_GATE_TEST PASS (78/78)`.
- **Independence:** written and run by the producer, a helper subagent of the executor's session. Not independent assurance.

## Raw output

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
ok   (21c) .claude/: a symbolic link at a nested .claude path (docs/.claude -> ../.claude), no verdict: GATE FAIL naming docs/.claude
ok   (22a) methods/: a new file one level down (methods/review/checklist.md), no verdict: GATE FAIL naming it
ok   (22p) methods/: (22a) with a covering verdict it adds: GATE PASS, covered by
ok   (22b) methods/: a new file with a non-ASCII name (methods/ölçüm-yöntemi.md), no verdict: GATE FAIL naming it
ok   (22c) methods/: a symbolic link at its own path (methods -> docs), no verdict: GATE FAIL naming methods
ok   (23a) supabase/migrations/: a new migration (supabase/migrations/20261012000001_fixture_item.sql), no verdict: GATE FAIL naming it
ok   (23g) supabase/migrations/: the guard denies (23a)'s merge by rule M7
ok   (23p) supabase/migrations/: (23a) with a covering verdict it adds: GATE PASS, covered by
ok   (23h) supabase/migrations/: the guard allows that merge by rule M7 once (23p)'s verdict is added
ok   (23b) supabase/migrations/: a new file whose name has a space (supabase/migrations/20261012000002 fixture index.sql), no verdict: GATE FAIL naming it
ok   (23c) supabase/migrations/: a symbolic link at its own path (supabase/migrations -> ../docs), no verdict: GATE FAIL naming supabase/migrations
ok   (23d) supabase/migrations/: a pull request mixing a new migration (supabase/migrations/20261012000003_fixture_mixed.sql) with a class-normal change (plan/notes.md), no verdict: GATE FAIL naming the migration
ok   (24a) supabase/functions/: a new function one level down (supabase/functions/fixture-hello/index.ts), no verdict: GATE FAIL naming it
ok   (24p) supabase/functions/: (24a) with a covering verdict it adds: GATE PASS, covered by
ok   (24b) supabase/functions/: a symbolic link at its own path (supabase/functions -> ../docs), no verdict: GATE FAIL naming supabase/functions
ok   (24c) supabase/functions/ and supabase/migrations/: a symbolic link at their parent's path (supabase -> docs), no verdict: GATE FAIL naming supabase
ok   (25a) pipelines/: a new file one level down (pipelines/embedding/embed.py), no verdict: GATE FAIL naming it
ok   (25p) pipelines/: (25a) with a covering verdict it adds: GATE PASS, covered by
ok   (25b) pipelines/: a regular file at its own path (pipelines), no verdict: GATE FAIL naming pipelines
ok   (25c) pipelines/: a symbolic link at its own path (pipelines -> docs), no verdict: GATE FAIL naming pipelines
ok   (26a) .github/workflows/: a new workflow whose name has a space (.github/workflows/nightly fixture.yml), no verdict: GATE FAIL naming it
ok   (26p) .github/workflows/: (26a) with a covering verdict it adds: GATE PASS, covered by
ok   (26b) .github/workflows/: a symbolic link at its own path (.github/workflows -> ../docs), no verdict: GATE FAIL naming .github/workflows
ok   (27a) .github/CODEOWNERS: a new file, no verdict: GATE FAIL naming .github/CODEOWNERS
ok   (27p) .github/CODEOWNERS: (27a) with a covering verdict it adds: GATE PASS, covered by
ok   (27b) .github/CODEOWNERS and .github/workflows/: a symbolic link at their parent's path (.github -> docs), no verdict: GATE FAIL naming .github
ok   (27c) .github/CODEOWNERS and .github/workflows/: a regular file at their parent's path (.github), no verdict: GATE FAIL naming .github
ok   (23e) supabase/migrations/: a migration deleted (supabase/migrations/20261001000000_fixture_init.sql), no verdict: GATE FAIL naming it
ok   (24d) supabase/functions/: a function changed (supabase/functions/fixture-hello/index.ts), no verdict: GATE FAIL naming it
ok   (25d) pipelines/: a file changed (pipelines/ingest/run.py), no verdict: GATE FAIL naming it
ok   (25e) pipelines/: a file renamed out (pipelines/ingest/run.py to archive/run.py), no verdict: GATE FAIL naming pipelines/ingest/run.py
ok   (26c) .github/workflows/: a workflow deleted (.github/workflows/ci.yml), no verdict: GATE FAIL naming it
ok   (27d) .github/CODEOWNERS: changed, no verdict: GATE FAIL naming .github/CODEOWNERS
ok   (27e) .github/CODEOWNERS: renamed out (to archive/CODEOWNERS.old), no verdict: GATE FAIL naming .github/CODEOWNERS
     plan 6.7: 8 backticked paths found: .github/CODEOWNERS, CLAUDE.md, .claude/, methods/, supabase/migrations/, supabase/functions/, pipelines/, .github/workflows/
     plan 6.7: skipped, as it names no path: 'the code of the decision channel once C06 writes it'
     plan 6.7: not class high: none; of the eight, not in the list: none; in the list, not of the eight: none
ok   (28) every path that plan 6.7's "High-impact path list" names (read from plan/DevOS_Kurulum_Plani.md) is class high, and the list names the eight of (20) to (27)
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
MERGE_GATE_TEST PASS (78/78)
```

## The gate's diff (point 3 (c))

Every changed line is a class rule or the docstring:

- `HIGH_PREFIXES`: `methods/`, `supabase/migrations/`, `supabase/functions/` and `pipelines/` added (the line is wrapped in two).
- `HIGH_FILES`: `.github/CODEOWNERS` added.
- `HIGH_DIR_PATHS`, new, with a two-line comment saying what it is for: `methods`, `pipelines`, `supabase`, `supabase/migrations`, `supabase/functions`, `.github` and `.github/workflows`. These are point 1 (a)'s link form, a file or symbolic link standing at a listed directory's own path or a parent's.
- The class condition in `high_paths()`: `or p in HIGH_DIR_PATHS or parts[-1] == ".claude"` added. The second part is the link form for `.claude` at any depth, root included. The condition is wrapped in parentheses over two lines to stay within 120 characters.
- The docstring's "Class high" paragraph names the same paths as the code. It adds a closing sentence saying that plan 6.7's list is among these paths and that case (28) checks this.

No other line changed. The gate still fails closed, because `changed()`, `git()`, `main()` and the error handling are untouched.

## The producer's own break (not the checker's)

- **Break:** `linkform`. A copy of four files at their repository paths, in a scratch directory outside the clone: the test file, the guard and the plan from `git show HEAD:<path>`, and the gate from the working tree. In the copy's gate, only the link-form rule (`or p in HIGH_DIR_PATHS or parts[-1] == ".claude"`) was removed.
- **Command:** `python3 -B <copy>/tools/test_merge_gate.py`.
- **When:** 2026-10-12, about 15:16Z.
- **Exit code:** 1. **Final line:** `MERGE_GATE_TEST FAIL (68/78)`.
- **Result:** exactly the ten link-form cases printed `BAD`, and every other case stayed `ok`, (28) and (29k) included. So the new rule is the only rule that classes these ten cases.

The `BAD` lines, raw (each is followed by a blank line in the output):

```
BAD  (21c) .claude/: a symbolic link at a nested .claude path (docs/.claude -> ../.claude), no verdict: GATE FAIL naming docs/.claude: GATE PASS: PR #104 head 56d7e13456ac: class normal: 6ceca6e1d27f..56d7e13456ac
BAD  (22c) methods/: a symbolic link at its own path (methods -> docs), no verdict: GATE FAIL naming methods: GATE PASS: PR #107 head 18071d3a20ae: class normal: 6ceca6e1d27f..18071d3a20ae
BAD  (23c) supabase/migrations/: a symbolic link at its own path (supabase/migrations -> ../docs), no verdict: GATE FAIL naming supabase/migrations: GATE PASS: PR #110 head aaedc8aa46f1: class normal: 6ceca6e1d27f..aaedc8aa46f1
BAD  (24b) supabase/functions/: a symbolic link at its own path (supabase/functions -> ../docs), no verdict: GATE FAIL naming supabase/functions: GATE PASS: PR #113 head b18ea934168f: class normal: 6ceca6e1d27f..b18ea934168f
BAD  (24c) supabase/functions/ and supabase/migrations/: a symbolic link at their parent's path (supabase -> docs), no verdict: GATE FAIL naming supabase: GATE PASS: PR #114 head cc12e0a15789: class normal: 6ceca6e1d27f..cc12e0a15789
BAD  (25b) pipelines/: a regular file at its own path (pipelines), no verdict: GATE FAIL naming pipelines: GATE PASS: PR #116 head da437931ddad: class normal: 6ceca6e1d27f..da437931ddad
BAD  (25c) pipelines/: a symbolic link at its own path (pipelines -> docs), no verdict: GATE FAIL naming pipelines: GATE PASS: PR #117 head 2d3dd892511f: class normal: 6ceca6e1d27f..2d3dd892511f
BAD  (26b) .github/workflows/: a symbolic link at its own path (.github/workflows -> ../docs), no verdict: GATE FAIL naming .github/workflows: GATE PASS: PR #119 head 2b3f47940f14: class normal: 6ceca6e1d27f..2b3f47940f14
BAD  (27b) .github/CODEOWNERS and .github/workflows/: a symbolic link at their parent's path (.github -> docs), no verdict: GATE FAIL naming .github: GATE PASS: PR #121 head c4b7263848ab: class normal: 6ceca6e1d27f..c4b7263848ab
BAD  (27c) .github/CODEOWNERS and .github/workflows/: a regular file at their parent's path (.github), no verdict: GATE FAIL naming .github: GATE PASS: PR #122 head b291f12078dc: class normal: 6ceca6e1d27f..b291f12078dc
```

The other breaks of the procedure were not run by the producer: point 1 (c) per path, point 2's three plan breaks, the wide-rule breaks and decode-swallow. They are the checker's to build from the head.

## Not run, and why

`tools/test_tool_allowlist.sh`, the guard's own tests, was not run. Its four `merge_pull_request` cases (lines 239 to 242) are decided before any class rule: rule M6 denies a missing or short `expectedHeadSha` and `merge_method` squash, and pull request 999999 fails at the gate's fetch. The guard runs the gate as a subprocess and imports none of its constants. The route through M7 to the changed classes is exercised by (23g) and (23h) above.
