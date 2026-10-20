---
id: EV-C02-032
title: "W-C02-23 (PR-A2): the product's record (build record, where it ran, the pre-merge gate run, the wait for W-C02-22 point 10, plan 6.12 item 4)"
stage: C02
kind: observation
source: "the producer a213e56dd62d70fcb's report (taken with tools/subagent_audit.py last, DISCIPLINES OK); the executor's runs at head 4b38165 in the scratch clone; CHK-C02-133 (checker add5345412f3a2a03)"
---

# EV-C02-032 · W-C02-23: the record its condition asks for

Filed by the executor (L-451). Each section names the acceptance point it answers (`plan/work/W-C02-23.md`, acceptance block merged at `7ed9dc7f728504cf74bf0bcdb955861d8fa2d2c8`).

## 1. Envelope

- **Head:** `4b38165d285a0b224758ebbfe045eaa08b31396c` (branch `claude/c02-w23-product`, PR #421, one commit on `7ed9dc7`). It adds `.claude/roles/{producer,researcher,prober,checker,test-designer,executor}.md` and `tools/check_role_packages.py`, and adds 20 lines to `tools/merge_gate.py` (no line removed). The two test files are unchanged from `7ed9dc7` (point 12).
- **Binding verdict:** CHK-C02-133, PASS, no conditions. It covers the product-only and the design-knowing readings, FC9 declared, every cited case in the checker and executor packages opened, all 30 breaks of point 9 and five of its own turned red, and public text clean.
- **Independence:** same session, fresh-context subagents (declared, Ek A 5.3).

## 2. The copies, by tool (point 2)

The producer's build record is section 6's report, verbatim (its "Build record" tables). Every block's SHA-256 equals its copy's. `executor.md` rebuilds byte for byte from the header line, the precedence line, five bold role lines and the five `executor-lines` blocks: 7,454 bytes, SHA-256 `839747541aa61d457e16fa52b819c1552a736d3ac9bbc5f2b823f283681dcdfd`. No draft failed the check, so no draft went back to its role. CHK-C02-133 recomputed both sides independently (its `relied_on`). Its finding 2 types the duplicate `**Checker**` line (the checker's own block opens with it) as a preference to the block's author, and the copy rule is met.

## 3. Where it ran (point 11)

- **Program logic:** the session's container, `python3 -I` (Python 3.13.16), git 2.43.0, a full clone at `4b38165` with its origin the GitHub repository. Results: `CHECK_ROLE_PACKAGES_TEST PASS (55/55)` (P7b shown at the committed head), `MERGE_GATE_TEST PASS (107/107)`, and `check_role_packages.py --rev HEAD` gives `ROLE_PACKAGES PASS`. `--root` and `--rev` agree.
- **The pre-merge run of the head's own gate against the real pull request** (counted), 2026-10-20 about 11:27Z, from that clone: `python3 -I tools/merge_gate.py --pr 421 --head 4b38165d285a0b224758ebbfe045eaa08b31396c`. Its output, verbatim, is below. It carries the six `ROLE_PACKAGE` lines and `ROLE_PACKAGES PASS`, then refuses for want of a verdict file, as expected before the verdict.

```
  ROLE_PACKAGE producer.md bytes=7235 limit=9300 PASS
  ROLE_PACKAGE researcher.md bytes=6688 limit=9300 PASS
  ROLE_PACKAGE prober.md bytes=5661 limit=9300 PASS
  ROLE_PACKAGE checker.md bytes=6423 limit=9300 PASS
  ROLE_PACKAGE test-designer.md bytes=6254 limit=9300 PASS
  ROLE_PACKAGE executor.md bytes=7454 limit=9078 PASS
  ROLE_PACKAGES PASS
  class high: .claude/roles/checker.md, .claude/roles/executor.md, .claude/roles/prober.md, .claude/roles/producer.md, .claude/roles/researcher.md, .claude/roles/test-designer.md ...
GATE FAIL: PR #421 head 4b38165d285a: no checker verdict file that this pull request adds or changes covers it (evidence/<stage>/checks/CHK-<stage>-<nnn>.md with reviewed_head the head or a commit X of this pull request, not an ancestor of the merge base, where X..head is class normal; verdict PASS or PASS-WITH-CONDITIONS; independence and checker_run; no repeated key)
```

- **The live row** (disposition 5): the first natural merge after PR-A2's sync whose head touches the trigger set. It is recorded when it occurs and does not hold the acceptance.
- **Public text:** the leak scan of the eight files matched 0 lines. The store was built from library HEAD `941f027d3a15`, which is the clone's HEAD. CHK-C02-133 showed a positive control and found the service names clean.

## 4. The wait for W-C02-22 point 10, and its timing (point 13)

- **The wait:** at PR-A2's passing verdict (CHK-C02-133, its notification about 11:41Z), W-C02-22 point 10's rows were not recorded. CHK-C02-132 (FAIL) found the test-designer row without an outcome under version 1. The red path did not apply.
- **Point 13's "Reopens" applies:** "if the rows are not recorded when PR-A2's verdict passes". Reopening disposition 1 is the executor's call, recorded as a disposition (L-451):
  - The condition's owner has written point 10 version 2, whose P marker is defined for both package states: file absent and file present. That removes disposition 1's reason, which was that version 1's marker needed the file absent.
  - So PR-A2 merges once point 10's version (2.1, under its scoped re-review after CHK-C02-135) has merged, not when the rows are recorded. The hold moves to W-C02-25, whose start header removes P (version 2's own order consequence).
  - Given up: merging PR-A2 before point 10's version merges. If the version failed, version 1's test-designer row would then become unobservable for good.
- **The time it adds on the critical path:** the merge time minus the later of the verdict (about 11:41Z) and the moment the pull request was otherwise ready (its records, this record, about 11:50Z). It is measured at the merge and stated in that merge's log entry.
- **The reason's source, with its date:** disposition 1 and EV-C02-028 parts 2 to 6 (2026-10-20); CHK-C02-132 and CHK-C02-135 (2026-10-20).
- **Against Batu's later decisions:** D-039 (no added check: the wait adds none); D-041 (no bearing); D-042 (2026-10-20, the correction finished today, no part deferred, no check cut). D-042 bears in favour of not holding PR-A2 longer than the version needs. No issue #6 answer after the source.
- **What would end it sooner at the same quality, and whose call that is:** none. Merging before the version's merge would risk the row (above). The call is the executor's.
- **The gate's added time:** the check `tools/check_role_packages.py --rev <head>` takes 0.46 to 0.50 s wall (three runs, the clone above), and the whole gate run takes 1.55 s. This is the time added to every later merge whose head touches the trigger set (CHK-C02-133 measured about 2.7 s for its gate run).

## 5. Plan 6.12 item 4 (point 14)

- **The packages:**
  - They compensate for each new instance of a role meeting the known failure classes and methods again, with no continuity between instances (the test-designer package's FC12; EV-C02-020 section 5, gap 6).
  - Premise: the role reads its package, by its role file's procedure until W-C02-25's start hook delivers it.
  - Removal condition: they are removed if the result does not get worse without them, judged at C02's close by whether known failure classes recur in the roles' runs after delivery.
  - The test: that comparison, which cannot start before W-C02-25, since no run is known to have read a package yet.
- **The check and its gate call:**
  - They compensate for a package over the platform's hook-string cap reaching a role only as a path and a preview it is not asked to read (SB-COR 2.3, [V]).
  - Premise: delivery passes through a capped hook string, and the gate runs at every merge (guard M7).
  - Removal condition: whether delivery still passes through a capped string, judged at C02's close.
  - The test: point 9's breaks.

## 6. The producer's report, verbatim but for one library path written as a library ID (the leak check matched the path)

Package: none delivered (file absent)
Nonce: none delivered
Take-up: PROCEED. The task holds. The packages must exist, because SB-COR 2.3 and W-C02-25 consume them. Nothing existing could be reused: there was no `tools/check_role_packages.py` and no `.claude/roles/` at `7ed9dc7`. The agreed method (copy by tool, one check, one gate call) reaches the goal of presence, form and enforcement. The acceptance tests the behaviour (planted cases and breaks), not only the form. I give no `.claude/roles/producer.md` reading, because that file did not exist in `/home/user/devos`; I worked from my role file and `CLAUDE.md`.

## Disciplines (D1–D9)
D1: yes: a frame choice in the executor package's assembly is decision-critical: the checker's executor-lines block already starts with its own `**Checker**` line. I followed the condition's literal "five bold role lines", so the file shows `**Checker**` twice, and I state the alternative and who owns it under Received from / Returned to.
D2: yes: I report P7b as BAD in my uncommitted clone instead of calling the suite green, despite D-042's "finished today".
D3: yes: I kept the claim to presence, form and enforcement; use and delivery stay with W-C02-25, as the condition's "Not covered" (a) says.
D4: yes: I ran every break in point 9's table against my own code. Two breaks first left their cases ok, so I changed my L/N resolution to the literal per-ID form, and now every break turns its named cases BAD (exploratory; the checker's breaks bind).
D5: yes: I extracted the blocks from `git show 449df84:<EV>` and not from a summary. My test-designer block hash matched the condition's stated `9f8557260d35d1a5…`, and the hook's measured 222 bytes matched the condition's limit of 9,078.
D6: no
D7: yes: the build record (markers, line numbers, hashes, joining text) is in this hand-over, so the executor and checker can rebuild without this session.
D8: yes: I made a fresh clone at `7ed9dc7` on `claude/c02-w23-product` and read the acceptance block, both test files, the gate, the hook and part 9 before writing.
D9: yes: spec-kit FINDINGS 7 and 11 justified copying by tool with hashes and sending repair back to the owning source (the duplicate bold line goes to the checker role, not edited by me). gstack P6 and F4 with superpowers U04 F28 and F32 limited my claims (P7b not shown) and led me to run the breaks.

Read, and what each changed:
- `plan/work/W-C02-23.md` (acceptance and approach): justified and shaped all the work.
- `tools/test_check_role_packages.py` and `tools/test_merge_gate.py` (RP0 to RP8b and the fixture helpers): set the interface I built to.
- `tools/merge_gate.py`: placement of the call.
- `.claude/hooks/reread_after_compact.py`: the `MESSAGE` form.
- `tools/records.py` line 45 (`NOTE_RE`): the N marker form.
- `evidence/C02/EV-C02-028_pra2_m1_triage.md` at `449df84`, part 9 and its marker lines: the source of all six files.
- Ek D section 2 item 3 and section 3 (D1 to D9): applied as above.
- Library: `research/studies/spec-kit/FINDINGS.md` §7 and §11 (justified); `research/studies/gstack/CORE.md` P6, P7 and F2 to F4 (limited the claims); `[library id: superpowers, note U04]` F28 and F32 (led to the break runs). I did not open superpowers `CORE.md` itself; U04 covered the need.
- Deliberately not read: EV-C02-029 section 1 and CHK-C02-130. The condition and tests already pin the interface. C2 and C3 stay as they are; my product does not depend on them.

Relied on:
- Stated: the block-bytes rule and the source range ("part 9 only"), `W-C02-23.md:28`.
- Stated: the pinned interface, tokens, `LIMIT` line and `HEADER`, `W-C02-23.md:31-35`.
- Stated: the joining text is the header, the precedence line and the five bold role lines, `W-C02-23.md:47`.
- Stated: the precedence wording, from the approach's correction 10.1a.
- Observed: `NOTE_RE`'s opening is `<!-- note (N-\d+)` followed by a space or attributes (`tools/records.py:45`).
- Observed: the hook writes 222 bytes, so the executor's limit is 9,078 (test output).
- Observed: part 9 holds exactly one block of each kind per role (the build script asserts it).
- Observed: EV-C02-028 is unchanged between `449df84` and `7ed9dc7` (`git diff --stat`).
- Inferred: P7b passes once the files are committed, because `--root` already passes on this tree and RV1 to RV3 and P2 show the two modes agree.

Unsure:
- **P7b (`--rev HEAD` equals `--root`) is not shown.** It needs a committed clean clone, and I may not commit. It settles when the executor or the checker runs the check test at the head.
- **Symbolic links and other special entries under `.claude/roles/` are not handled specially** (condition "Not covered" (g)). A symlink named `producer.md` would be measured by its link text under `--rev` and by its target under `--root`.
- **No leak check run.** The leak check with the store's freshness is the binding checker's floor.
- **No pre-merge gate run against the real pull request.** That is the executor's, after the commit.

For: the executor commits these files from my clone, has a fresh binding checker judge the head (approach (7)), runs the head's gate against the real pull request (point 11), and merges after W-C02-22 point 10's rows (approach (6)). After that: each role reads its package; W-C02-25's hook imports `RESERVE`, `LIMIT` and `HEADER` from `tools/check_role_packages.py`; M1b of W-C02-24 starts from `role_packages()` in `tools/merge_gate.py`.

Received from / Returned to:
- **To the executor, for the checker role (round-2 author `a1d0941b5e8c59178`) and the binding checker:** the checker's executor-lines block (part 9, line 2227) starts with its own `**Checker**` line. With the joining `**Checker**` line, `executor.md` lines 18 and 19 both read `**Checker**`. I kept the condition's literal "five bold role lines" (point 2). Approach (2) says "one bold line naming the role", which this does not meet.
  - If the duplicate is judged a defect, there are two fixes. The checker role revises its block (source-directed repair). Or the executor records a disposition to drop the joining checker line, leaving four joining role lines.
  - I changed no byte of the block.
- **To the executor, for the prober (`ae4d875f0b3826b32`):** `prober.md` line 1 reads `# Prober package (Sınayıcı)`, a Turkish word, against `CLAUDE.md`'s "Everything inside DevOS is in English". The check passes it, so this is not a failing-draft return; the reading belongs to the binding checker.
- **No draft failed the check.** All five copies and `executor.md` pass, so no draft went back to its role.
- **Outside my scope, already open:** `researcher.md:31` cites L-285 for a case that is L-286 (the approach's `open:` line; owner the executor).

Product:
- **Files** (all in `/tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/w23prod/devos`, branch `claude/c02-w23-product` at `7ed9dc7f728504cf74bf0bcdb955861d8fa2d2c8`, nothing committed):
  - `.claude/roles/producer.md`, `researcher.md`, `prober.md`, `checker.md`, `test-designer.md`: new, byte copies of the part-9 package blocks.
  - `.claude/roles/executor.md`: new, assembled by tool (build record below).
  - `tools/check_role_packages.py`: new, the check (standard library; `--root` or `--rev`; exit 0, 1 or 2; `RESERVE`, `LIMIT = 9500 - RESERVE` verbatim, `HEADER`).
  - `tools/merge_gate.py`: adds `import os`, the `ROLE_PACKAGE_TRIGGER` constant, the function `role_packages(base, head)` (runs this tree's check with `-I --rev head`, prints its lines, refuses on any nonzero exit), and one call in `gate()` after the merge base is found. No existing line is removed or changed (diff: 20 insertions, 0 deletions).
  - Test files untouched: `git diff 7ed9dc7 -- tools/test_*.py` is empty. SHA-256 values: `test_check_role_packages.py` 510db3cf…5b23, `test_merge_gate.py` 1502be58…29f7.
  - The build script and the break script sit outside the clone: `/tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/w23prod/build_packages.py` and `/tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/w23prod/breaks.py`.

- **Build record.** Source: `git show 449df84316b3bd4dd12e48c48b53d274a59cb983:evidence/C02/EV-C02-028_pra2_m1_triage.md`, part 9 (line `## 9. Round 2 (task and the five answers)` to the line before `## 10.`). For each package, the block's SHA-256 equals the copy's SHA-256:

| File | Opening marker (line) | Closing marker (line) | Bytes | SHA-256 (block = copy) |
|---|---|---|---|---|
| producer.md | `<!-- package producer -->` (1613) | `<!-- /package -->` (1664) | 7235 | d379362747dd654d5676bf2153e20b50b46a8378559544bc63ab7acd8ca5a9a5 |
| researcher.md | `<!-- package researcher -->` (1808) | (1839) | 6688 | bfb9d1e8e5e9cea234c3f57b3efd62321a19ad041a7b5bdd1a13b8278046b952 |
| prober.md | `<!-- package prober -->` (2001) | (2034) | 5661 | 69e1e10d0cd713600bd89c3caaf670397b8181f4d341c7e24bc1c0f9892350b6 |
| checker.md | `<!-- package checker -->` (2182) | (2223) | 6423 | 951789897e856a10aff12def732cab8089ddf935fb9f6e55f0509d30ddcb4bc9 |
| test-designer.md | `<!-- package test-designer -->` (2496) | (2545) | 6254 | 9f8557260d35d1a514b86893be2ebcf8823deb4292aadade6507ff103d0dad87 (matches the condition's 9f8557260d35d1a5…) |

  `executor.md` blocks, each running to `<!-- /executor-lines -->`, in assembly order:

| Role | Opening marker (line) | Closing line | Bytes | SHA-256 |
|---|---|---|---|---|
| producer | `<!-- executor-lines producer -->` (1670) | 1677 | 1072 | 0bce4d7731ef46f240bc4d1142ac3ca39bad176d4bf6c0726e7c101eae5660fd |
| test-designer | (2547) | 2555 | 1451 | 9322818b1136b093a66a354f0e5b7f1b04fbe46b8a630817e44420dfe2817a19 |
| checker | (2227) | 2234 | 1350 | f7fc2d6c241befe89fbac44d186c01a46c3b84bf30ebfc3ccacb567aad379f36 |
| researcher | (1843) | 1852 | 1469 | 7999c54a1b4fb86ee5458492e09e5f8a5f10338a5fca9771ab3686b2245b2b2d |
| prober | (2038) | 2052 | 1764 | ebd5c86a93f68b0cebecd5e997e4c04649ef26139d704460754a4b65bd2f4841 |

  The executor's joining text is the only text not from a block. Each line ends in one `\n`, with no blank lines:
  - header: `# Executor package (DevOS installation): each role's lines for the executor, copied unchanged from EV-C02-028 part 9`
  - precedence: `` `plan/Installation_Working_Order.md` and `CLAUDE.md` bind the executor, which has no file under `.claude/agents/`; this package informs and never overrides them. ``
  - role lines: `**Producer**`, `**Test designer**`, `**Checker**`, `**Researcher**`, `**Prober**`

  The file is header + precedence + (role line + block) for each role in the order above: 7,454 bytes, SHA-256 839747541aa61d457e16fa52b819c1552a736d3ac9bbc5f2b823f283681dcdfd.

- **Tests:**
  - `python3 -I tools/check_role_packages.py --root <clone>`: exit 0, all six PASS (producer 7235/9300, researcher 6688/9300, prober 5661/9300, checker 6423/9300, test-designer 6254/9300, executor 7454/9078), `ROLE_PACKAGES PASS`, 0.29 s.
  - `python3 -I tools/test_check_role_packages.py`: exit 1, `CHECK_ROLE_PACKAGES_TEST FAIL (54/55)`. The only BAD case is P7b, whose own message says it needs a clean clone at the head; every other case (P1 to P7, S1 to S6, X1 to X4, F1 to F6b, D1 to D5, I1 to I11, RV1 to RV3) reads ok.
  - `python3 -I tools/test_merge_gate.py`: exit 0, `MERGE_GATE_TEST PASS (107/107)`: 97 older cases and RP1 to RP8b.
  - Exploratory breaks (`breaks.py`, one scratch copy per break, P7b left out): every row of the condition's point-9 table turned at least its named cases BAD. Examples:
    - `RESERVE = 0` turns S1, S6, P3, P5 BAD.
    - Dropping the L or N trailing space turns I6 or I7 BAD (after the fix above).
    - `--rev` reading the disk turns RV1 to RV3 BAD.
    - Removing the gate's call turns RP1 to RP3, RP4b, RP5, RP6, RP8b BAD.
    - Running the head's copy turns RP4b BAD.
    - Running the check on every head turns RP7 and 89 older cases BAD.
    - Reading could-not-check as a pass turns RP5 BAD.
  - `git diff --check`: exit 0.
- **Where it ran:** the session container, `python3 -I`, Python 3.13.16; git 2.43.0; a full clone of `https://github.com/batuhanozgun/devos` at `7ed9dc7f728504cf74bf0bcdb955861d8fa2d2c8` with the files uncommitted. Library reads came from the read-only clone `/home/user/agentic-os-search`.

Guard denials: one. Rule B5 (no shell writes into guarded directories; decision log #1367): my status command included a `find` that named `./.git/` and a `git add -N`. I re-ran the same checks without either (`git diff --check`, `grep`, `sha256sum`, `git status --untracked-files=all`). I did not run `tools/guard_report.py`; the executor records the denial.
