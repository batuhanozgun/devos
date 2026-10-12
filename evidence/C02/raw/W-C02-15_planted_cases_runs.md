# W-C02-15: planted cases X6, Y7 and D-031's "Dn: no: <text>": mutants and runs

Raw run record for W-C02-15 (`plan/work/W-C02-15.md`), points 1 to 3, point 4's second bullet and point 6. Written on 2026-10-12 by the test designer, a fresh-context helper of the executor's session. It is not a verdict: the item's checker builds its own mutants from `git show` of the head and runs the tests itself. Every fixture is synthetic and labelled, as the two test files' headers state; no output below holds an entry's, prompt's or report's text (each test's own case (6) or (11) checks this).

## 1. What the runs were made from

- **Commit.** `560bcab1d2ac336be06c8eacca08700c44ed485b` (`main`, PR #275), branch `claude/c02-w15-discipline-cases`, with uncommitted changes: `plan/decisions/D-031.md` (the executor's) and this item's two test files. The commit that will carry the test files did not exist when these runs were made; the sha256 values below identify every file each run used.
- **Tools** (unchanged by this item): `git show 560bcab:tools/records.py` (sha256 `fc41a0bb5334592892e336f666324be0554dec3fcb6de65a72e7c82f7ec3cc30`) and `git show 560bcab:tools/subagent_audit.py` (`c5eb6615942310b51bd7f0b18557829875201ff8cea48e4d3e77025117766314`); the builder script asserts that each equals the clone's working-tree copy byte for byte.
- **Test files, old:** `git show 560bcab:tools/test_records_disciplines.py` (`d4626f3bd455bc945a78afc6e6f4a2a1571b42ec83eb332ed909b383ec3bd877`), `git show 560bcab:tools/test_subagent_audit.py` (`64c0550e18baacd989d78c634b8521f528d7b9989671074ad7f4ce6de6a298af`).
- **Test files, new** (this item's change, the clone's working tree): `tools/test_records_disciplines.py` (`bb40490990dc20cd56e89cf95fc6a223a90a95977fb9c398b4eb5a27a655e37c`), `tools/test_subagent_audit.py` (`de9ca668d579661b410132561a3f0d29337e2401d04adfc3806718becf7ad0e5`).
- **Where each run ran.** A scratch tree per run, outside the clone: `tools/` and `plan/` of `git archive 560bcab`, with the run's tool and test file written over the archive's. The command is `python3 -B tools/<test file>` from that tree's root (Python 3.13.16). This is how the test files allow a copied tool: each finds its tool beside itself (`Path(__file__).resolve().parent`); `test_records_disciplines.py` case (7) reads `plan/ledger/*-log.md` two levels up (560bcab's real log, 126 entries from L-159 on), and `subagent_audit.py` reads `plan/Installation_Working_Order.md` of the tree it is in. The matrix below ran from 2026-10-12T15:03Z to 15:04Z, in one pass from an empty scratch folder. An earlier pass (14:59Z) gave the same table with a version of `tools/test_subagent_audit.py` (sha256 `45a6a7f350f8ce74086ec53859516ebb6ae6b182f5c18a037f977d73c9c08d80`) that differs from the final one only in where case (47)'s call breaks its lines (the two files' Python syntax trees, `ast.dump`, are identical); everything here is from the pass with the final files.
- **The same new files in place.** In the clone itself, `python3 -B tools/test_records_disciplines.py` and `python3 -B tools/test_subagent_audit.py` (the head's own tools) exited 0 with output byte-identical (`cmp`) to the runs `identical__records__new` and `identical__subagent_audit__new` below; they left no file behind (`git status --short` showed only the two test files and D-031).

## 2. The mutants

Each is one line of `git show 560bcab:<tool>` replaced (the builder asserts that the old line occurs exactly once and that the diff has one `-` and one `+` line). X6, Y7, NT-R and NT-S are the task's; NT-R2, NT-S2 and Y7b are extra, other one-line forms of the same faults, run so that the cases are shown to pin the fault and not one spelling of it.

| Mutant | Tool | Function | Change | The case that must kill it | Why run |
|---|---|---|---|---|---|
| X6 | `tools/records.py` | `discipline_problems` | the correction's comparison `<` made `<=`, so a correction line naming its own entry counts (N-127) | L-179, L-180 | named in the task |
| NT-R | `tools/records.py` | `answers_problem` | `no` added to `(yes\|uncertain)`, so "Dn: no: <text>" is accepted (the opposite of D-031) | L-181 | named in the task ("no-text") |
| NT-R2 | `tools/records.py` | `answers_problem` | the bare-"no" pattern widened to `no(?:[.;]\|:.*)?`, a second one-line way to accept "Dn: no: <text>" | L-181 | extra, for the form's robustness |
| Y7 | `tools/subagent_audit.py` | `task_block` | the quotation loop's `while` made `if`, so only the block's first quoted line is read (N-127) | (47) | named in the task |
| Y7b | `tools/subagent_audit.py` | `task_block` | the block joined from `quote[:1]`, a second one-line way to read only the first quoted line | (47) | extra, for the form's robustness |
| NT-S | `tools/subagent_audit.py` | `block_problem` | `no` added to `(yes\|uncertain)`, so "Dn: no: <text>" is accepted (the opposite of D-031) | (48) | named in the task ("no-text") |
| NT-S2 | `tools/subagent_audit.py` | `block_problem` | the bare-"no" alternative widened to `no(?:[.;]\|:.*)?`, a second one-line way to accept "Dn: no: <text>" | (48) | extra, for the form's robustness |

**X6** (`w15mut/mutants/X6.diff`):

```diff
--- a/tools/records.py (560bcab)
+++ b/tools/records.py (mutant X6)
@@ -208,7 +208,7 @@
             elif cur is not None and line.startswith(DISC_LINE):
                 cur[1].append(line[len(DISC_LINE):])
             elif cur is not None and (f := DISC_FIX.match(line)):
-                if int(f.group(1)) < cur[0] and answers_problem(line[f.end():]) is None:
+                if int(f.group(1)) <= cur[0] and answers_problem(line[f.end():]) is None:
                     fixed.add(int(f.group(1)))
     out = []
     for num, lines in entries:
```

**NT-R** (`w15mut/mutants/NT-R.diff`):

```diff
--- a/tools/records.py (560bcab)
+++ b/tools/records.py (mutant NT-R)
@@ -185,7 +185,7 @@
         ans = text[m.end():labels[n].start() if n < 9 else len(text)].strip()
         if re.fullmatch(r"no[.;]?", ans):
             continue
-        a = re.fullmatch(r"(yes|uncertain):(.*)", ans)
+        a = re.fullmatch(r"(yes|uncertain|no):(.*)", ans)
         if a is None:
             return f"D{n} is not 'no', 'yes: <text>' or 'uncertain: <text>'"
         if not re.search(r"\w", a.group(2)):
```

**NT-R2** (`w15mut/mutants/NT-R2.diff`):

```diff
--- a/tools/records.py (560bcab)
+++ b/tools/records.py (mutant NT-R2)
@@ -183,7 +183,7 @@
         pos = m.end()
     for n, m in enumerate(labels, 1):
         ans = text[m.end():labels[n].start() if n < 9 else len(text)].strip()
-        if re.fullmatch(r"no[.;]?", ans):
+        if re.fullmatch(r"no(?:[.;]|:.*)?", ans):
             continue
         a = re.fullmatch(r"(yes|uncertain):(.*)", ans)
         if a is None:
```

**Y7** (`w15mut/mutants/Y7.diff`):

```diff
--- a/tools/subagent_audit.py (560bcab)
+++ b/tools/subagent_audit.py (mutant Y7)
@@ -368,7 +368,7 @@
     while i < end and not lines[i].strip():
         i += 1
     quote = []
-    while i < end and lines[i].startswith(">"):
+    if i < end and lines[i].startswith(">"):
         quote.append(lines[i][1:])
         i += 1
     block = " ".join(" ".join(quote).split())
```

**Y7b** (`w15mut/mutants/Y7b.diff`):

```diff
--- a/tools/subagent_audit.py (560bcab)
+++ b/tools/subagent_audit.py (mutant Y7b)
@@ -371,7 +371,7 @@
     while i < end and lines[i].startswith(">"):
         quote.append(lines[i][1:])
         i += 1
-    block = " ".join(" ".join(quote).split())
+    block = " ".join(" ".join(quote[:1]).split())
     if not re.search(r"\w", block):
         raise Error(f'no discipline block in {WORKING_ORDER}: section 9 ("## 9. ") needs a paragraph starting '
                     '"**Discipline block**" followed by a quotation (lines starting with ">") that holds it')
```

**NT-S** (`w15mut/mutants/NT-S.diff`):

```diff
--- a/tools/subagent_audit.py (560bcab)
+++ b/tools/subagent_audit.py (mutant NT-S)
@@ -338,7 +338,7 @@
     for n in range(1, 10):
         if n > len(rest) or rest[n - 1].startswith("#"):
             return f"{n - 1} answer lines, nine needed"
-        m = re.fullmatch(rf"(?:[-*] )?D{n}:\s*(?:no[.;]?|(yes|uncertain):(.*))", rest[n - 1])
+        m = re.fullmatch(rf"(?:[-*] )?D{n}:\s*(?:no[.;]?|(yes|uncertain|no):(.*))", rest[n - 1])
         if m is None:
             return f"line {n} of the block is not a D{n} answer"
         if m.group(1) and not re.search(r"\w", m.group(2)):
```

**NT-S2** (`w15mut/mutants/NT-S2.diff`):

```diff
--- a/tools/subagent_audit.py (560bcab)
+++ b/tools/subagent_audit.py (mutant NT-S2)
@@ -338,7 +338,7 @@
     for n in range(1, 10):
         if n > len(rest) or rest[n - 1].startswith("#"):
             return f"{n - 1} answer lines, nine needed"
-        m = re.fullmatch(rf"(?:[-*] )?D{n}:\s*(?:no[.;]?|(yes|uncertain):(.*))", rest[n - 1])
+        m = re.fullmatch(rf"(?:[-*] )?D{n}:\s*(?:no(?:[.;]|:.*)?|(yes|uncertain):(.*))", rest[n - 1])
         if m is None:
             return f"line {n} of the block is not a D{n} answer"
         if m.group(1) and not re.search(r"\w", m.group(2)):
```

## 3. Run table

Tool copy × test-file version. "Failing cases" lists the cases printed `BAD`. Every `old` run of a mutant gives output byte-identical (`cmp`) to the identical copy's `old` run of the same test file.

| Run | Tool copy (sha256, first 16) | Test file (sha256, first 16) | Exit | Last line | Failing cases |
|---|---|---|---|---|---|
| `identical__records__old` | identical `fc41a0bb53345928` | old `d4626f3bd455bc94` | 0 | `RECORDS_DISCIPLINES_TEST PASS (28/28)` | none |
| `identical__records__new` | identical `fc41a0bb53345928` | new `bb40490990dc20cd` | 0 | `RECORDS_DISCIPLINES_TEST PASS (31/31)` | none |
| `identical__subagent_audit__old` | identical `c5eb6615942310b5` | old `64c0550e18baacd9` | 0 | `SUBAGENT_AUDIT_TEST PASS (55/55)` | none |
| `identical__subagent_audit__new` | identical `c5eb6615942310b5` | new `de9ca668d579661b` | 0 | `SUBAGENT_AUDIT_TEST PASS (57/57)` | none |
| `X6__records__old` | X6 `d08f8d406baf0f6e` | old `d4626f3bd455bc94` | 0 | `RECORDS_DISCIPLINES_TEST PASS (28/28)` | none |
| `X6__records__new` | X6 `d08f8d406baf0f6e` | new `bb40490990dc20cd` | 1 | `RECORDS_DISCIPLINES_TEST FAIL (26/31)` | (L-179), (L-180), (2), (3), (5) |
| `NT-R__records__old` | NT-R `a6a925ca5d2de966` | old `d4626f3bd455bc94` | 0 | `RECORDS_DISCIPLINES_TEST PASS (28/28)` | none |
| `NT-R__records__new` | NT-R `a6a925ca5d2de966` | new `bb40490990dc20cd` | 1 | `RECORDS_DISCIPLINES_TEST FAIL (27/31)` | (L-181), (2), (3), (5) |
| `NT-R2__records__old` | NT-R2 `b9edc971cb00b7aa` | old `d4626f3bd455bc94` | 0 | `RECORDS_DISCIPLINES_TEST PASS (28/28)` | none |
| `NT-R2__records__new` | NT-R2 `b9edc971cb00b7aa` | new `bb40490990dc20cd` | 1 | `RECORDS_DISCIPLINES_TEST FAIL (27/31)` | (L-181), (2), (3), (5) |
| `Y7__subagent_audit__old` | Y7 `62e1907230468939` | old `64c0550e18baacd9` | 0 | `SUBAGENT_AUDIT_TEST PASS (55/55)` | none |
| `Y7__subagent_audit__new` | Y7 `62e1907230468939` | new `de9ca668d579661b` | 1 | `SUBAGENT_AUDIT_TEST FAIL (56/57)` | (47) |
| `Y7b__subagent_audit__old` | Y7b `e437c3aa92c463c1` | old `64c0550e18baacd9` | 0 | `SUBAGENT_AUDIT_TEST PASS (55/55)` | none |
| `Y7b__subagent_audit__new` | Y7b `e437c3aa92c463c1` | new `de9ca668d579661b` | 1 | `SUBAGENT_AUDIT_TEST FAIL (56/57)` | (47) |
| `NT-S__subagent_audit__old` | NT-S `db6ca07272d8b427` | old `64c0550e18baacd9` | 0 | `SUBAGENT_AUDIT_TEST PASS (55/55)` | none |
| `NT-S__subagent_audit__new` | NT-S `db6ca07272d8b427` | new `de9ca668d579661b` | 1 | `SUBAGENT_AUDIT_TEST FAIL (56/57)` | (48) |
| `NT-S2__subagent_audit__old` | NT-S2 `f20adfff12cc120b` | old `64c0550e18baacd9` | 0 | `SUBAGENT_AUDIT_TEST PASS (55/55)` | none |
| `NT-S2__subagent_audit__new` | NT-S2 `f20adfff12cc120b` | new `de9ca668d579661b` | 1 | `SUBAGENT_AUDIT_TEST FAIL (56/57)` | (48) |

Reading: (a) each identical copy passes the new test file (31/31, 57/57); (b) each mutant passes the test file as it stood at `560bcab` (28/28, 55/55), so the old file does not kill it; (c) each mutant fails the new test file, exit 1, and the new case is among the failing cases: L-179 and L-180 for X6; L-181 for NT-R and NT-R2; (47) for Y7 and Y7b; (48) for NT-S and NT-S2. In `test_records_disciplines.py` the aggregate cases (2), (3) and (5) fail too, since they count the failing fixture entries. In the identical copies' runs of the new test files, the cases point 4 names as kept print `ok` (L-164, L-165, L-166 and L-171; (21), (25) and (26)), and so do the existing fail-closed cases nearest to point 6's examples: (20), a report with eight answers; L-165 and (21), an answer of punctuation only; (33), a working order that is missing, or whose section 9 has no block, an empty quotation, or no quotation after the paragraph. Neither test file plants a working order that exists but cannot be read, or a quotation of punctuation only; `tools/subagent_audit.py` refuses both (its `except (OSError, ValueError)` and `re.search(r"\w", block)`), and CHK-C01-009 finding 4 ran them on its own copy, but no case in these files pins them. This item adds no such case: it is outside the task given to the test designer, and is reported to the executor.

## 4. `render --check` on the clone's real log (point 6)

Command, from the clone's root: `python3 -B tools/records.py render --check`. Before any edit of this item (the clone at `560bcab` plus the uncommitted `plan/decisions/D-031.md`) and after both test files were changed, it exits 1 with the same two lines; the two outputs are byte-identical (`cmp`):

````
DISCIPLINES OK: 126 of 126 log entries from L-159 on carry the nine answers
RENDER DIFFERS: plan/ledger.md
````

Where the `RENDER DIFFERS` comes from, checked in two scratch trees from `git archive 560bcab`: the archive alone gives `DISCIPLINES OK: 126 of 126 ...` and `RENDER OK`, exit 0; the archive plus only the clone's `plan/decisions/D-031.md` gives `DISCIPLINES OK: 126 of 126 ...` and `RENDER DIFFERS: plan/ledger.md`, exit 1. So the difference is D-031 not yet rendered into the ledger's views (the executor's step), not this change, which touches only the two test files. The discipline result is the same entry by entry: 126 of 126 entries from L-159 on, none failing.

## 5. Raw outputs

Trimming, where a run's output is long: in a run where a mutant fails, each line `ok   ...` is left out and counted; every `BAD` line with its whole detail (the tail of the tool's output the test prints) and the last line are verbatim. The `old` runs of the mutants are not repeated: each is byte-identical to the identical copy's `old` run, given in full. The identical copies' `new` runs are given in full.

### `identical__records__old`

Tree `scratchpad/w15mut/runs/identical__records__old`; command `python3 -B tools/test_records_disciplines.py`; exit 0; tool sha256 `fc41a0bb5334592892e336f666324be0554dec3fcb6de65a72e7c82f7ec3cc30`; test file sha256 `d4626f3bd455bc945a78afc6e6f4a2a1571b42ec83eb332ed909b383ec3bd877`.

````
ok   (1) a clean log: render writes without a warning; render --check prints DISCIPLINES OK and RENDER OK, exit 0
ok   (L-150) an entry below L-159 without a line is ignored
ok   (L-158) an entry below L-159 with a malformed line is ignored
ok   (L-159) L-159's variant heading with nine answers passes
ok   (L-160) a good entry (no with '.', ';' and nothing; yes and uncertain with text) passes
ok   (L-161) an entry without the line fails
ok   (L-162) a missing question fails
ok   (L-163) answers out of order fail
ok   (L-164) 'yes' without text fails
ok   (L-165) 'uncertain' with only punctuation fails
ok   (L-166) 'no' followed by more text fails
ok   (L-167) a line under the next heading (a finding section) does not count for the entry above it
ok   (L-170) (N-110 a) two lines, the second malformed: the second is checked too and fails
ok   (L-171) (N-110 b) a 'Dn: maybe: <text>' answer fails
ok   (L-172) an entry without the line that a later entry corrects passes
ok   (L-173) the correcting entry, with its own line and a correction line naming L-172, passes
ok   (L-174) an entry whose only correction is malformed still fails
ok   (L-175) an entry with a malformed correction line naming L-174 passes on its own line
ok   (L-176) an entry with a correction line naming a later entry passes on its own line
ok   (L-177) a correction in an earlier entry does not count
ok   (L-178) a correction line is not the entry's own line
ok   (L-168, L-169) every log file is read: a good entry passes, a missing line fails
ok   (2) failing entries, views that match: one line per failing entry, DISCIPLINES FAIL, no RENDER OK, exit 1
ok   (3) failing entries and views that differ: both reported, exit 1
ok   (4) a clean log and views that differ: RENDER DIFFERS as before, exit 1
ok   (5) render with failing entries prints the same lines and a warning, and renders anyway
ok   (6) no output contains an entry's text
ok   (7) this checkout's real log: every entry from L-159 on is counted (126 of 126) and none fails
RECORDS_DISCIPLINES_TEST PASS (28/28)
````

### `identical__records__new`

Tree `scratchpad/w15mut/runs/identical__records__new`; command `python3 -B tools/test_records_disciplines.py`; exit 0; tool sha256 `fc41a0bb5334592892e336f666324be0554dec3fcb6de65a72e7c82f7ec3cc30`; test file sha256 `bb40490990dc20cd56e89cf95fc6a223a90a95977fb9c398b4eb5a27a655e37c`.

````
ok   (1) a clean log: render writes without a warning; render --check prints DISCIPLINES OK and RENDER OK, exit 0
ok   (L-150) an entry below L-159 without a line is ignored
ok   (L-158) an entry below L-159 with a malformed line is ignored
ok   (L-159) L-159's variant heading with nine answers passes
ok   (L-160) a good entry (no with '.', ';' and nothing; yes and uncertain with text) passes
ok   (L-161) an entry without the line fails
ok   (L-162) a missing question fails
ok   (L-163) answers out of order fail
ok   (L-164) 'yes' without text fails
ok   (L-165) 'uncertain' with only punctuation fails
ok   (L-166) 'no' followed by more text fails
ok   (L-167) a line under the next heading (a finding section) does not count for the entry above it
ok   (L-170) (N-110 a) two lines, the second malformed: the second is checked too and fails
ok   (L-171) (N-110 b) a 'Dn: maybe: <text>' answer fails
ok   (L-172) an entry without the line that a later entry corrects passes
ok   (L-173) the correcting entry, with its own line and a correction line naming L-172, passes
ok   (L-174) an entry whose only correction is malformed still fails
ok   (L-175) an entry with a malformed correction line naming L-174 passes on its own line
ok   (L-176) an entry with a correction line naming a later entry passes on its own line
ok   (L-177) a correction in an earlier entry does not count
ok   (L-178) a correction line is not the entry's own line
ok   (L-179) (N-127 X6) an entry without its own line, whose only correction line names itself with nine good answers, still fails
ok   (L-180) (N-127 X6) an entry with a malformed own line, whose only correction line names itself with nine good answers, still fails
ok   (L-181) (D-031) a 'Dn: no: <text>' answer fails: a 'no' stays 'Dn: no' with nothing after it
ok   (L-168, L-169) every log file is read: a good entry passes, a missing line fails
ok   (2) failing entries, views that match: one line per failing entry, DISCIPLINES FAIL, no RENDER OK, exit 1
ok   (3) failing entries and views that differ: both reported, exit 1
ok   (4) a clean log and views that differ: RENDER DIFFERS as before, exit 1
ok   (5) render with failing entries prints the same lines and a warning, and renders anyway
ok   (6) no output contains an entry's text
ok   (7) this checkout's real log: every entry from L-159 on is counted (126 of 126) and none fails
RECORDS_DISCIPLINES_TEST PASS (31/31)
````

### `identical__subagent_audit__old`

Tree `scratchpad/w15mut/runs/identical__subagent_audit__old`; command `python3 -B tools/test_subagent_audit.py`; exit 0; tool sha256 `c5eb6615942310b51bd7f0b18557829875201ff8cea48e4d3e77025117766314`; test file sha256 `64c0550e18baacd989d78c634b8521f528d7b9989671074ad7f4ce6de6a298af`.

````
ok   (1) last prints the final multi-line message verbatim and skips a later tool-only event
ok   (2) audit of a valid run: all six calls inside, counts agree, AUDIT VALID, exit 0
ok   (3) calls prints the six call lines only, without the rules
ok   (4) a Read outside the workspace voids, and its path cannot forge a line
ok   (4b) a Read whose .. leaves the workspace voids
ok   (5) a Grep without path voids
ok   (6) a Glob pattern with .. voids
ok   (7) a disallowed tool (Bash) voids, in the transcript and in the guard log
ok   (7b) the Bash case names the guard record
ok   (8) a guard log whose count differs from the transcript is recorded, not void by itself (section 7)
ok   (9) a guard record whose logged path is outside voids though the transcript is inside
ok   (10) an unknown agent ID, a missing workspace and a relative workspace exit 2
ok   (12) a workflow agent's transcript is found by last, calls and audit; audit names its kind and run, says that its meta names no starting call instead of failing, and is valid
ok   (13) a workflow agent's Read outside the workspace voids, as any agent's
ok   (14) two transcripts of one agent (in two workflow runs, or one in each layout) exit 2 for last, calls and audit
ok   (15) no transcript in either layout (files directly under workflows/, one level below a run folder or outside workflows/ are not one) exit 2 for last, calls and audit
ok   (16) an Agent-tool subagent's meta without toolUseId is still a reading error (exit 2)
ok   (17) a task with the whole block and a report with nine answers: DISCIPLINES OK, exit 0
ok   (17b) the same, the task given as a list of text blocks
ok   (18) a task without the block: DISCIPLINES MISSING, exit 1
ok   (18b) the block in a later tool result, not in the task, does not count
ok   (19) a report without the block
ok   (20) a block with eight lines
ok   (21) a "yes" without text
ok   (22) answers out of order
ok   (23) disciplines for an unknown agent ID is a reading error (exit 2)
ok   (25) N-110 (b): a report line "D6: maybe: <text>" fails
ok   (26) N-110 (c): a report line "D2: no, <text>" fails
ok   (27) N-110 (d): a task without the block, then a later user text message (not a tool result) that has it: the task does not carry it
ok   (28) N-110 (e): an earlier assistant text with the block, a last one without it: missing
ok   (29) the lead-in kept, a placeholder for the body: the task does not carry the block
ok   (30a) the first sentence of the block changed: the task does not carry it
ok   (30b) the middle sentence of the block changed: the task does not carry it
ok   (30c) the last sentence of the block changed: the task does not carry it
ok   (31) the block wrapped differently and indented, as in a workflow's task: it carries it
ok   (32a) the block is read from the working order beside the tool, at run time: a fixture block quoted over three lines, after a wrapped paragraph, is what a task must carry
ok   (32b) beside that fixture working order, a task with this checkout's block does not carry it
ok   (33) it fails closed (exit 2, nothing on stdout, a message naming the file) when the working order cannot be read, or its section 9 holds no block: only section 8 has one, the quotation is empty, or no quotation follows the paragraph
ok   (34) a harness relay, then the task with the whole block, before the first assistant event: the task carries it
ok   (35) a harness relay, then a task without the block: the task does not carry it
ok   (36) the block only in an opening message before the prompt: the opening carries it
ok   (37) the block split across a relay message and the task, both in the opening: no one message carries it, so the task does not carry it
ok   (38) a transcript cut before the end, with no end status (after a tool call, or after a text that holds a whole report, as a running agent's text before its next call does): last, disciplines and audit print nothing on stdout, NOT FINISHED on stderr, exit 3
ok   (38b) the same for the transcript cut after a tool call
ok   (39) a background launch (async_launched), the caller's prompt and a typed message quoting a completed notification, and another agent's notification quoting one: none is an end, so not finished
ok   (39b) its own notification with no status before its result (one quoted inside the result): not finished
ok   (40) a later end status other than completed (failed, as a queued notification) decides: not finished, the status named
ok   (41) completed, as a queued notification or as a foreground call's own result: finished; last prints the report verbatim and disciplines is OK
ok   (42) a workflow agent with no result in its run's journal (or a null one) is not finished; once the journal holds its result, last prints its report
ok   (43) a report handed back through SubagentHandback, then a refused second call and a short text: last prints the delivered message verbatim, and disciplines reads it; the first is taken also when no result says which was refused
ok   (44) a hand-back that says success false, then the report as plain text: last prints the text
ok   (45) a StructuredOutput call: last prints its text field, or else its input as JSON
ok   (46) a finished agent with no report call: last prints its last text as before
ok   (24) disciplines prints three fixed lines and no prompt or report text
ok   (11) no output contains the planted content of a tool result, prompt, thinking block or argument
SUBAGENT_AUDIT_TEST PASS (55/55)
````

### `identical__subagent_audit__new`

Tree `scratchpad/w15mut/runs/identical__subagent_audit__new`; command `python3 -B tools/test_subagent_audit.py`; exit 0; tool sha256 `c5eb6615942310b51bd7f0b18557829875201ff8cea48e4d3e77025117766314`; test file sha256 `de9ca668d579661b410132561a3f0d29337e2401d04adfc3806718becf7ad0e5`.

````
ok   (1) last prints the final multi-line message verbatim and skips a later tool-only event
ok   (2) audit of a valid run: all six calls inside, counts agree, AUDIT VALID, exit 0
ok   (3) calls prints the six call lines only, without the rules
ok   (4) a Read outside the workspace voids, and its path cannot forge a line
ok   (4b) a Read whose .. leaves the workspace voids
ok   (5) a Grep without path voids
ok   (6) a Glob pattern with .. voids
ok   (7) a disallowed tool (Bash) voids, in the transcript and in the guard log
ok   (7b) the Bash case names the guard record
ok   (8) a guard log whose count differs from the transcript is recorded, not void by itself (section 7)
ok   (9) a guard record whose logged path is outside voids though the transcript is inside
ok   (10) an unknown agent ID, a missing workspace and a relative workspace exit 2
ok   (12) a workflow agent's transcript is found by last, calls and audit; audit names its kind and run, says that its meta names no starting call instead of failing, and is valid
ok   (13) a workflow agent's Read outside the workspace voids, as any agent's
ok   (14) two transcripts of one agent (in two workflow runs, or one in each layout) exit 2 for last, calls and audit
ok   (15) no transcript in either layout (files directly under workflows/, one level below a run folder or outside workflows/ are not one) exit 2 for last, calls and audit
ok   (16) an Agent-tool subagent's meta without toolUseId is still a reading error (exit 2)
ok   (17) a task with the whole block and a report with nine answers: DISCIPLINES OK, exit 0
ok   (17b) the same, the task given as a list of text blocks
ok   (18) a task without the block: DISCIPLINES MISSING, exit 1
ok   (18b) the block in a later tool result, not in the task, does not count
ok   (19) a report without the block
ok   (20) a block with eight lines
ok   (21) a "yes" without text
ok   (22) answers out of order
ok   (23) disciplines for an unknown agent ID is a reading error (exit 2)
ok   (25) N-110 (b): a report line "D6: maybe: <text>" fails
ok   (26) N-110 (c): a report line "D2: no, <text>" fails
ok   (48) D-031: a report line "D9: no: <text>" fails; a "no" stays "Dn: no" with nothing after it
ok   (27) N-110 (d): a task without the block, then a later user text message (not a tool result) that has it: the task does not carry it
ok   (28) N-110 (e): an earlier assistant text with the block, a last one without it: missing
ok   (29) the lead-in kept, a placeholder for the body: the task does not carry the block
ok   (30a) the first sentence of the block changed: the task does not carry it
ok   (30b) the middle sentence of the block changed: the task does not carry it
ok   (30c) the last sentence of the block changed: the task does not carry it
ok   (31) the block wrapped differently and indented, as in a workflow's task: it carries it
ok   (32a) the block is read from the working order beside the tool, at run time: a fixture block quoted over three lines, after a wrapped paragraph, is what a task must carry
ok   (32b) beside that fixture working order, a task with this checkout's block does not carry it
ok   (47) N-127 Y7: beside that fixture working order, a task carrying only the first of the block's quoted lines does not carry it
ok   (33) it fails closed (exit 2, nothing on stdout, a message naming the file) when the working order cannot be read, or its section 9 holds no block: only section 8 has one, the quotation is empty, or no quotation follows the paragraph
ok   (34) a harness relay, then the task with the whole block, before the first assistant event: the task carries it
ok   (35) a harness relay, then a task without the block: the task does not carry it
ok   (36) the block only in an opening message before the prompt: the opening carries it
ok   (37) the block split across a relay message and the task, both in the opening: no one message carries it, so the task does not carry it
ok   (38) a transcript cut before the end, with no end status (after a tool call, or after a text that holds a whole report, as a running agent's text before its next call does): last, disciplines and audit print nothing on stdout, NOT FINISHED on stderr, exit 3
ok   (38b) the same for the transcript cut after a tool call
ok   (39) a background launch (async_launched), the caller's prompt and a typed message quoting a completed notification, and another agent's notification quoting one: none is an end, so not finished
ok   (39b) its own notification with no status before its result (one quoted inside the result): not finished
ok   (40) a later end status other than completed (failed, as a queued notification) decides: not finished, the status named
ok   (41) completed, as a queued notification or as a foreground call's own result: finished; last prints the report verbatim and disciplines is OK
ok   (42) a workflow agent with no result in its run's journal (or a null one) is not finished; once the journal holds its result, last prints its report
ok   (43) a report handed back through SubagentHandback, then a refused second call and a short text: last prints the delivered message verbatim, and disciplines reads it; the first is taken also when no result says which was refused
ok   (44) a hand-back that says success false, then the report as plain text: last prints the text
ok   (45) a StructuredOutput call: last prints its text field, or else its input as JSON
ok   (46) a finished agent with no report call: last prints its last text as before
ok   (24) disciplines prints three fixed lines and no prompt or report text
ok   (11) no output contains the planted content of a tool result, prompt, thinking block or argument
SUBAGENT_AUDIT_TEST PASS (57/57)
````

### `X6__records__old`

Tree `scratchpad/w15mut/runs/X6__records__old`; command `python3 -B tools/test_records_disciplines.py`; exit 0; tool sha256 `d08f8d406baf0f6ecedc9164dd39c6d5915ef2ec1b68999ea4ad9c454192c2e6`; test file sha256 `d4626f3bd455bc945a78afc6e6f4a2a1571b42ec83eb332ed909b383ec3bd877`.

Output byte-identical to `identical__records__old` (verified when this record was written); last line `RECORDS_DISCIPLINES_TEST PASS (28/28)`.

### `X6__records__new`

Tree `scratchpad/w15mut/runs/X6__records__new`; command `python3 -B tools/test_records_disciplines.py`; exit 1; tool sha256 `d08f8d406baf0f6ecedc9164dd39c6d5915ef2ec1b68999ea4ad9c454192c2e6`; test file sha256 `bb40490990dc20cd56e89cf95fc6a223a90a95977fb9c398b4eb5a27a655e37c`.

Trimmed: 26 lines `ok   ...` left out; the rest verbatim.

````
BAD  (L-179) (N-127 X6) an entry without its own line, whose only correction line names itself with nine good answers, still fails: der
DISCIPLINES: L-164: D5: 'yes' without text
DISCIPLINES: L-165: D9: 'uncertain' without text
DISCIPLINES: L-166: D2 is not 'no', 'yes: <text>' or 'uncertain: <text>'
DISCIPLINES: L-167: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-170: D4 missing
DISCIPLINES: L-171: D6 is not 'no', 'yes: <text>' or 'uncertain: <text>'
DISCIPLINES: L-174: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-177: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-178: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-181: D9 is not 'no', 'yes: <text>' or 'uncertain: <text>'
DISCIPLINES: L-169: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES FAIL: 9 of 23 log entries from L-159 on carry the nine answers
RENDER VIEWS MATCH; not OK, because the discipline check failed

BAD  (L-180) (N-127 X6) an entry with a malformed own line, whose only correction line names itself with nine good answers, still fails: der
DISCIPLINES: L-164: D5: 'yes' without text
DISCIPLINES: L-165: D9: 'uncertain' without text
DISCIPLINES: L-166: D2 is not 'no', 'yes: <text>' or 'uncertain: <text>'
DISCIPLINES: L-167: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-170: D4 missing
DISCIPLINES: L-171: D6 is not 'no', 'yes: <text>' or 'uncertain: <text>'
DISCIPLINES: L-174: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-177: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-178: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-181: D9 is not 'no', 'yes: <text>' or 'uncertain: <text>'
DISCIPLINES: L-169: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES FAIL: 9 of 23 log entries from L-159 on carry the nine answers
RENDER VIEWS MATCH; not OK, because the discipline check failed

BAD  (2) failing entries, views that match: one line per failing entry, DISCIPLINES FAIL, no RENDER OK, exit 1: der
DISCIPLINES: L-164: D5: 'yes' without text
DISCIPLINES: L-165: D9: 'uncertain' without text
DISCIPLINES: L-166: D2 is not 'no', 'yes: <text>' or 'uncertain: <text>'
DISCIPLINES: L-167: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-170: D4 missing
DISCIPLINES: L-171: D6 is not 'no', 'yes: <text>' or 'uncertain: <text>'
DISCIPLINES: L-174: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-177: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-178: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-181: D9 is not 'no', 'yes: <text>' or 'uncertain: <text>'
DISCIPLINES: L-169: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES FAIL: 9 of 23 log entries from L-159 on carry the nine answers
RENDER VIEWS MATCH; not OK, because the discipline check failed

BAD  (3) failing entries and views that differ: both reported, exit 1: 
DISCIPLINES: L-163: D4 out of order
DISCIPLINES: L-164: D5: 'yes' without text
DISCIPLINES: L-165: D9: 'uncertain' without text
DISCIPLINES: L-166: D2 is not 'no', 'yes: <text>' or 'uncertain: <text>'
DISCIPLINES: L-167: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-170: D4 missing
DISCIPLINES: L-171: D6 is not 'no', 'yes: <text>' or 'uncertain: <text>'
DISCIPLINES: L-174: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-177: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-178: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-181: D9 is not 'no', 'yes: <text>' or 'uncertain: <text>'
DISCIPLINES: L-169: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES FAIL: 9 of 23 log entries from L-159 on carry the nine answers
RENDER DIFFERS: plan/ledger.md

BAD  (5) render with failing entries prints the same lines and a warning, and renders anyway: der
DISCIPLINES: L-164: D5: 'yes' without text
DISCIPLINES: L-165: D9: 'uncertain' without text
DISCIPLINES: L-166: D2 is not 'no', 'yes: <text>' or 'uncertain: <text>'
DISCIPLINES: L-167: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-170: D4 missing
DISCIPLINES: L-171: D6 is not 'no', 'yes: <text>' or 'uncertain: <text>'
DISCIPLINES: L-174: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-177: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-178: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-181: D9 is not 'no', 'yes: <text>' or 'uncertain: <text>'
DISCIPLINES: L-169: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES FAIL: 9 of 23 log entries from L-159 on carry the nine answers
RENDER VIEWS MATCH; not OK, because the discipline check failed

RECORDS_DISCIPLINES_TEST FAIL (26/31)
````

### `NT-R__records__old`

Tree `scratchpad/w15mut/runs/NT-R__records__old`; command `python3 -B tools/test_records_disciplines.py`; exit 0; tool sha256 `a6a925ca5d2de9667e683b99a293553e1d88719ee919185385be8e3d6b304529`; test file sha256 `d4626f3bd455bc945a78afc6e6f4a2a1571b42ec83eb332ed909b383ec3bd877`.

Output byte-identical to `identical__records__old` (verified when this record was written); last line `RECORDS_DISCIPLINES_TEST PASS (28/28)`.

### `NT-R__records__new`

Tree `scratchpad/w15mut/runs/NT-R__records__new`; command `python3 -B tools/test_records_disciplines.py`; exit 1; tool sha256 `a6a925ca5d2de9667e683b99a293553e1d88719ee919185385be8e3d6b304529`; test file sha256 `bb40490990dc20cd56e89cf95fc6a223a90a95977fb9c398b4eb5a27a655e37c`.

Trimmed: 27 lines `ok   ...` left out; the rest verbatim.

````
BAD  (L-181) (D-031) a 'Dn: no: <text>' answer fails: a 'no' stays 'Dn: no' with nothing after it: 4: D5: 'yes' without text
DISCIPLINES: L-165: D9: 'uncertain' without text
DISCIPLINES: L-166: D2 is not 'no', 'yes: <text>' or 'uncertain: <text>'
DISCIPLINES: L-167: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-170: D4 missing
DISCIPLINES: L-171: D6 is not 'no', 'yes: <text>' or 'uncertain: <text>'
DISCIPLINES: L-174: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-177: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-178: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-179: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-180: D4 missing
DISCIPLINES: L-169: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES FAIL: 8 of 23 log entries from L-159 on carry the nine answers
RENDER VIEWS MATCH; not OK, because the discipline check failed

BAD  (2) failing entries, views that match: one line per failing entry, DISCIPLINES FAIL, no RENDER OK, exit 1: 4: D5: 'yes' without text
DISCIPLINES: L-165: D9: 'uncertain' without text
DISCIPLINES: L-166: D2 is not 'no', 'yes: <text>' or 'uncertain: <text>'
DISCIPLINES: L-167: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-170: D4 missing
DISCIPLINES: L-171: D6 is not 'no', 'yes: <text>' or 'uncertain: <text>'
DISCIPLINES: L-174: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-177: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-178: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-179: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-180: D4 missing
DISCIPLINES: L-169: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES FAIL: 8 of 23 log entries from L-159 on carry the nine answers
RENDER VIEWS MATCH; not OK, because the discipline check failed

BAD  (3) failing entries and views that differ: both reported, exit 1: D4 out of order
DISCIPLINES: L-164: D5: 'yes' without text
DISCIPLINES: L-165: D9: 'uncertain' without text
DISCIPLINES: L-166: D2 is not 'no', 'yes: <text>' or 'uncertain: <text>'
DISCIPLINES: L-167: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-170: D4 missing
DISCIPLINES: L-171: D6 is not 'no', 'yes: <text>' or 'uncertain: <text>'
DISCIPLINES: L-174: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-177: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-178: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-179: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-180: D4 missing
DISCIPLINES: L-169: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES FAIL: 8 of 23 log entries from L-159 on carry the nine answers
RENDER DIFFERS: plan/ledger.md

BAD  (5) render with failing entries prints the same lines and a warning, and renders anyway: 4: D5: 'yes' without text
DISCIPLINES: L-165: D9: 'uncertain' without text
DISCIPLINES: L-166: D2 is not 'no', 'yes: <text>' or 'uncertain: <text>'
DISCIPLINES: L-167: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-170: D4 missing
DISCIPLINES: L-171: D6 is not 'no', 'yes: <text>' or 'uncertain: <text>'
DISCIPLINES: L-174: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-177: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-178: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-179: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-180: D4 missing
DISCIPLINES: L-169: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES FAIL: 8 of 23 log entries from L-159 on carry the nine answers
RENDER VIEWS MATCH; not OK, because the discipline check failed

RECORDS_DISCIPLINES_TEST FAIL (27/31)
````

### `NT-R2__records__old`

Tree `scratchpad/w15mut/runs/NT-R2__records__old`; command `python3 -B tools/test_records_disciplines.py`; exit 0; tool sha256 `b9edc971cb00b7aa3e4517980d2fec43504a61cbbe3b1a812ad98b9b4934159c`; test file sha256 `d4626f3bd455bc945a78afc6e6f4a2a1571b42ec83eb332ed909b383ec3bd877`.

Output byte-identical to `identical__records__old` (verified when this record was written); last line `RECORDS_DISCIPLINES_TEST PASS (28/28)`.

### `NT-R2__records__new`

Tree `scratchpad/w15mut/runs/NT-R2__records__new`; command `python3 -B tools/test_records_disciplines.py`; exit 1; tool sha256 `b9edc971cb00b7aa3e4517980d2fec43504a61cbbe3b1a812ad98b9b4934159c`; test file sha256 `bb40490990dc20cd56e89cf95fc6a223a90a95977fb9c398b4eb5a27a655e37c`.

Trimmed: 27 lines `ok   ...` left out; the rest verbatim.

````
BAD  (L-181) (D-031) a 'Dn: no: <text>' answer fails: a 'no' stays 'Dn: no' with nothing after it: 4: D5: 'yes' without text
DISCIPLINES: L-165: D9: 'uncertain' without text
DISCIPLINES: L-166: D2 is not 'no', 'yes: <text>' or 'uncertain: <text>'
DISCIPLINES: L-167: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-170: D4 missing
DISCIPLINES: L-171: D6 is not 'no', 'yes: <text>' or 'uncertain: <text>'
DISCIPLINES: L-174: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-177: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-178: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-179: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-180: D4 missing
DISCIPLINES: L-169: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES FAIL: 8 of 23 log entries from L-159 on carry the nine answers
RENDER VIEWS MATCH; not OK, because the discipline check failed

BAD  (2) failing entries, views that match: one line per failing entry, DISCIPLINES FAIL, no RENDER OK, exit 1: 4: D5: 'yes' without text
DISCIPLINES: L-165: D9: 'uncertain' without text
DISCIPLINES: L-166: D2 is not 'no', 'yes: <text>' or 'uncertain: <text>'
DISCIPLINES: L-167: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-170: D4 missing
DISCIPLINES: L-171: D6 is not 'no', 'yes: <text>' or 'uncertain: <text>'
DISCIPLINES: L-174: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-177: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-178: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-179: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-180: D4 missing
DISCIPLINES: L-169: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES FAIL: 8 of 23 log entries from L-159 on carry the nine answers
RENDER VIEWS MATCH; not OK, because the discipline check failed

BAD  (3) failing entries and views that differ: both reported, exit 1: D4 out of order
DISCIPLINES: L-164: D5: 'yes' without text
DISCIPLINES: L-165: D9: 'uncertain' without text
DISCIPLINES: L-166: D2 is not 'no', 'yes: <text>' or 'uncertain: <text>'
DISCIPLINES: L-167: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-170: D4 missing
DISCIPLINES: L-171: D6 is not 'no', 'yes: <text>' or 'uncertain: <text>'
DISCIPLINES: L-174: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-177: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-178: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-179: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-180: D4 missing
DISCIPLINES: L-169: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES FAIL: 8 of 23 log entries from L-159 on carry the nine answers
RENDER DIFFERS: plan/ledger.md

BAD  (5) render with failing entries prints the same lines and a warning, and renders anyway: 4: D5: 'yes' without text
DISCIPLINES: L-165: D9: 'uncertain' without text
DISCIPLINES: L-166: D2 is not 'no', 'yes: <text>' or 'uncertain: <text>'
DISCIPLINES: L-167: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-170: D4 missing
DISCIPLINES: L-171: D6 is not 'no', 'yes: <text>' or 'uncertain: <text>'
DISCIPLINES: L-174: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-177: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-178: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-179: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES: L-180: D4 missing
DISCIPLINES: L-169: no line starting '- **Disciplines (D1–D9)'
DISCIPLINES FAIL: 8 of 23 log entries from L-159 on carry the nine answers
RENDER VIEWS MATCH; not OK, because the discipline check failed

RECORDS_DISCIPLINES_TEST FAIL (27/31)
````

### `Y7__subagent_audit__old`

Tree `scratchpad/w15mut/runs/Y7__subagent_audit__old`; command `python3 -B tools/test_subagent_audit.py`; exit 0; tool sha256 `62e1907230468939fb1948e53c425b62c31fcf01d28912a56cc1d893d3ed79bc`; test file sha256 `64c0550e18baacd989d78c634b8521f528d7b9989671074ad7f4ce6de6a298af`.

Output byte-identical to `identical__subagent_audit__old` (verified when this record was written); last line `SUBAGENT_AUDIT_TEST PASS (55/55)`.

### `Y7__subagent_audit__new`

Tree `scratchpad/w15mut/runs/Y7__subagent_audit__new`; command `python3 -B tools/test_subagent_audit.py`; exit 1; tool sha256 `62e1907230468939fb1948e53c425b62c31fcf01d28912a56cc1d893d3ed79bc`; test file sha256 `de9ca668d579661b410132561a3f0d29337e2401d04adfc3806718becf7ad0e5`.

Trimmed: 56 lines `ok   ...` left out; the rest verbatim.

````
BAD  (47) N-127 Y7: beside that fixture working order, a task carrying only the first of the block's quoted lines does not carry it: task: carries the D-016 questions
report: nine answers
DISCIPLINES OK

SUBAGENT_AUDIT_TEST FAIL (56/57)
````

### `Y7b__subagent_audit__old`

Tree `scratchpad/w15mut/runs/Y7b__subagent_audit__old`; command `python3 -B tools/test_subagent_audit.py`; exit 0; tool sha256 `e437c3aa92c463c1f2f4245c1d6ef2f350f5817aab827170bb730e933c9ca155`; test file sha256 `64c0550e18baacd989d78c634b8521f528d7b9989671074ad7f4ce6de6a298af`.

Output byte-identical to `identical__subagent_audit__old` (verified when this record was written); last line `SUBAGENT_AUDIT_TEST PASS (55/55)`.

### `Y7b__subagent_audit__new`

Tree `scratchpad/w15mut/runs/Y7b__subagent_audit__new`; command `python3 -B tools/test_subagent_audit.py`; exit 1; tool sha256 `e437c3aa92c463c1f2f4245c1d6ef2f350f5817aab827170bb730e933c9ca155`; test file sha256 `de9ca668d579661b410132561a3f0d29337e2401d04adfc3806718becf7ad0e5`.

Trimmed: 56 lines `ok   ...` left out; the rest verbatim.

````
BAD  (47) N-127 Y7: beside that fixture working order, a task carrying only the first of the block's quoted lines does not carry it: task: carries the D-016 questions
report: nine answers
DISCIPLINES OK

SUBAGENT_AUDIT_TEST FAIL (56/57)
````

### `NT-S__subagent_audit__old`

Tree `scratchpad/w15mut/runs/NT-S__subagent_audit__old`; command `python3 -B tools/test_subagent_audit.py`; exit 0; tool sha256 `db6ca07272d8b4276b6d9962f2b084a2a2b21d8d5363b321cfe167edddc9f33e`; test file sha256 `64c0550e18baacd989d78c634b8521f528d7b9989671074ad7f4ce6de6a298af`.

Output byte-identical to `identical__subagent_audit__old` (verified when this record was written); last line `SUBAGENT_AUDIT_TEST PASS (55/55)`.

### `NT-S__subagent_audit__new`

Tree `scratchpad/w15mut/runs/NT-S__subagent_audit__new`; command `python3 -B tools/test_subagent_audit.py`; exit 1; tool sha256 `db6ca07272d8b4276b6d9962f2b084a2a2b21d8d5363b321cfe167edddc9f33e`; test file sha256 `de9ca668d579661b410132561a3f0d29337e2401d04adfc3806718becf7ad0e5`.

Trimmed: 56 lines `ok   ...` left out; the rest verbatim.

````
BAD  (48) D-031: a report line "D9: no: <text>" fails; a "no" stays "Dn: no" with nothing after it: task: carries the D-016 questions
report: nine answers
DISCIPLINES OK

SUBAGENT_AUDIT_TEST FAIL (56/57)
````

### `NT-S2__subagent_audit__old`

Tree `scratchpad/w15mut/runs/NT-S2__subagent_audit__old`; command `python3 -B tools/test_subagent_audit.py`; exit 0; tool sha256 `f20adfff12cc120b7758bba16b68c365e4ba707345f7858c89f7d1427daf9db2`; test file sha256 `64c0550e18baacd989d78c634b8521f528d7b9989671074ad7f4ce6de6a298af`.

Output byte-identical to `identical__subagent_audit__old` (verified when this record was written); last line `SUBAGENT_AUDIT_TEST PASS (55/55)`.

### `NT-S2__subagent_audit__new`

Tree `scratchpad/w15mut/runs/NT-S2__subagent_audit__new`; command `python3 -B tools/test_subagent_audit.py`; exit 1; tool sha256 `f20adfff12cc120b7758bba16b68c365e4ba707345f7858c89f7d1427daf9db2`; test file sha256 `de9ca668d579661b410132561a3f0d29337e2401d04adfc3806718becf7ad0e5`.

Trimmed: 56 lines `ok   ...` left out; the rest verbatim.

````
BAD  (48) D-031: a report line "D9: no: <text>" fails; a "no" stays "Dn: no" with nothing after it: task: carries the D-016 questions
report: nine answers
DISCIPLINES OK

SUBAGENT_AUDIT_TEST FAIL (56/57)
````
