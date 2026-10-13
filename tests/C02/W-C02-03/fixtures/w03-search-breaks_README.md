# T-W03-09's break attempt: the copies' workflow `w03-search-breaks.yml`

**Synthetic test data** (plan Section 8 item 13). The plant is a value made up for T-W03-09, never a credential. This file names it only by its variable, `W03_PLANT_B64`; it holds none of its forms.

`w03-search-breaks.yml` carries out the "Break attempt" row of `tests/C02/W-C02-03/T-W03-09_credential_search.md`. It was written by a producer, not by the test designer. Where it goes:
- The executor places it at `.github/workflows/w03-search-breaks.yml` on a branch `claude/w03-search-breaks` based on `main`.
- It runs through a pull request into `main` that is never merged. It runs after S2's search and before the plants are removed. The executor saves the check's log and then closes the pull request.
- Its only event is `pull_request` into `main`. To run it again, push a commit to the branch (event `synchronize`) or re-run the job on GitHub. Re-running this workflow does not re-run `migrate.yml`.

## What the run does

There is one job, `breaks`, with `ubuntu-24.04`, `permissions: {}` at the top level, and `contents: read`, `actions: read` and `issues: read` on the job. It names no environment and no secret. It has two steps:
1. `actions/checkout` at `d23441a48e516b6c34aea4fa41551a30e30af803`, the commit `migrate.yml` pins, with `persist-credentials: false`. For `pull_request` this checks out the merge commit. This branch adds only its own file, so the merge commit's `migrate.yml` is `main`'s at the pull request's base.
2. `copies` (`shell: python`; no `run:` value holds an expression). Its step `env` holds:
   - `W03_PLANT_B64`, copied byte for byte from `main`'s `migrate.yml`. A local check found it equal, as text, to `migrate.yml`'s workflow-level value.
   - `W03_FIXTURE_ISSUE: "308"`, copied the same way.
   - `GH_TOKEN`, the job's `github.token`.

   The program in step `copies` does the following, in order:
   - **What it read.** It prints the event and the checked-out commit. For a pull request it also prints the head's and the base's ref and SHA.
   - **The step, by T-W03-DEC's interface, as the rehearsal read it** (EV-C02-007 15.15, "The run step"). It loads `.github/workflows/migrate.yml` with PyYAML and requires exactly one step with id `search` in job `check-devos-test`. That step's shell must be `python` or `bash`, and its body must hold no expression. It prints `breaks: migrate.yml at <sha>, job check-devos-test, step search: shell python, 190 lines, SHA-256 of run|shell <hash>; run as: <python> FILE`.
   - **The hash check.** The hash must equal `EXPECTED`, `2ef72520eefdfc1407925d2742f6a5db12c8622548518f582f2aea18e832aebe`. That is the SHA-256 of `run + "|" + shell` for that step in `main` `1f6f9a2` (local clone, 2026-10-13), and its first 12 digits are EV-C02-007 15.15's and 15.16's `2ef72520eefd`. When the hash is equal, the program prints `breaks: that equals main's search body (2ef72520eefd, …)`. When it is not, it prints `breaks: could not check: that is not main's search body (…); no copy is run` and the step exits 1.
   - **The environment.** It prints names only:
     - each workflow-level or job-level entry of `migrate.yml` that the body names (`W03_PLANT_B64`, `W03_FIXTURE_ISSUE`), with a line saying whether this file's value is `the same as` or `NOT the same as` `migrate.yml`'s at that commit;
     - `SUPABASE_DB_PASSWORD: the plant, decoded here from W03_PLANT_B64, in place of migrate.yml's value`;
     - `GH_TOKEN: … this job's own value`.

     The program decodes the plant itself. It goes only into the environment of each copy's process, as `SUPABASE_DB_PASSWORD`. It is never put on a command line, printed, or written to `GITHUB_ENV`, `GITHUB_OUTPUT` or a file. Each copy's process also gets the step's own environment (`GITHUB_*`, `RUNNER_*`, `GH_TOKEN`, `W03_PLANT_B64`, `W03_FIXTURE_ISSUE`).
   - **The five copies, in order.** Copy 0 comes first and is unchanged. Each copy's body is written to `RUNNER_TEMP` and run as GitHub runs `shell: python`, with `python FILE` and the step's own interpreter. Its stdout and stderr are printed line by line, each line prefixed `[<label>] `. Then `[<label>] breaks: exit <n> (not its verdict; read its count lines)` is printed. Each copy prints its body hash first: `[<label>] breaks: SHA-256 of run|shell <hash>`, followed by `(unchanged)` or by its one change.
   - **The summary.** It prints `summary: <label> | <place> | plain <n>, percent <m>` for each copy and place. These numbers are read from that copy's own `search plant | <place> | <form>: <n>` lines, and `no line` stands where the copy printed none.
   - **Its exit.** The step exits 0 when all five copies were made and run, and 1 otherwise.

## The copies: exact old and new text

Each broken copy is made at run time by one replacement in the body read from `migrate.yml`. The old text must occur exactly once. Otherwise that copy prints `[<label>] breaks: could not check: its change applies <n> times, not exactly once; this copy is not run`, and its summary says `not run`.

| Copy (label) | Old text (occurs once in the body) | New text | What it removes, and only that |
|---|---|---|---|
| `copy 0 unbroken` | none | none | Nothing. This is the positive control. |
| `copy 1 no history` | `ids = git("-C", m, "cat-file", "--batch-all-objects", "--batch-check=%(objectname)").stdout` | `ids = b"".join(s + b"\n" for s in sorted(tip_blobs))` | The list of objects to read becomes the current trees' blobs (`tip_blobs`, built just before, from every ref's tree). No other object, that is no history, is read. Each blob read is still classified by the body's own rule, so the place `repository: history` still prints, with 0. |
| `copy 2 plain only` | `return {"plain": v.encode(), "percent": urllib.parse.quote(v, safe="").encode()}` | `return {"plain": v.encode()}` | The percent-encoded needle, in every place. The count lines still print `percent: 0`, because the body prints both forms for each place. |
| `copy 3 no issue` | `place = f"issue #{number}"` | `place = f"issue #{number}"; count(place, b""); continue` | Reading the issues. The place is still registered with nothing counted, so `issue #6` and `issue #308` print 0. Issue #6 and the fixture issue are read by this one loop, which is T-W03-09's "read by the same code", so skipping the issue skips both. |
| `copy 4 no logs` | `runs, seen, listed, page, more = [], set(), 0, 0, True` | `runs, seen, listed, page, more = [], set(), 0, 0, False` | Reading the run list, and so every earlier run's log. The place still prints 0. The body prints `logs: 0 of 0 earlier runs of migrate.yml read` and records no gap. |

Copies 1, 3 and 4 add no "could not check" line of their own about the part removed. Copy 2 adds none either, beyond the body's own plant checks. So each break is seen only through the plant's count, which is the thing under test.

## Expected lines after S2

Let *k* be the number of scheduled runs of `migrate.yml` that printed the plant (step `plant`, p4) and whose logs are complete when the copies run. These are S1, S2 and every later scheduled run created while `W03_PLANT_B64` is still set: S3, S4 and so on, one per 6-hour slot (`41 */6 * * *`) until the change that empties it. S1's and S2's IDs are in T-W03-09's `inputs_ref`. The later ones come from GitHub's run list filtered by the event `schedule`, and the record names each one. Push runs never print, since `check-devos-test` runs only on schedule. So after S2, *k* ≥ 2.

The plant's counts (`summary:` lines, plain / percent). A cell marked with † is where that copy differs from copy 0:

| Place | copy 0 unbroken | copy 1 no history | copy 2 plain only | copy 3 no issue | copy 4 no logs |
|---|---|---|---|---|---|
| `repository: current trees` (p1) | 1 / 0 | 1 / 0 | 1 / 0 | 1 / 0 | 1 / 0 |
| `repository: history` (p2, p5) | 0 / 1 | 0 / 0 † | 0 / 0 † | 0 / 1 | 0 / 1 |
| `issue #6` | 0 / 0 | 0 / 0 | 0 / 0 | 0 / 0 | 0 / 0 |
| `issue #308` (p3) | 1 / 0 | 1 / 0 | 1 / 0 | 0 / 0 † | 1 / 0 |
| `logs of migrate.yml's earlier runs` (p4) | *k* / 0 | *k* / 0 | *k* / 0 | *k* / 0 | 0 / 0 † |

The other lines each copy's body prints:
- **Copy 0:**
  - `repository: <n> refs, <m> objects read`;
  - one `logs: run <id>: the credential counted in all its files, the plant in its top-level files (<t> top-level, <f> in folders)` per earlier run of `migrate.yml`, push runs included, with S1, S2 and the later printing runs among them;
  - `logs: <r> of <r> earlier runs of migrate.yml read`, with no logs gap;
  - no plant "could not check" line.
- **Copy 1:**
  - `repository: <n> refs, <m'> objects read`, where *m'* is the number of distinct current-tree blobs, far below copy 0's *m*;
  - `search: could not check: repository: history (…)`;
  - `search: could not check: the percent-encoded form (…)`.
- **Copy 2:** the same two "could not check" lines as copy 1.
- **Copy 3:**
  - `search: could not check: issue #6 (the plant was not found in issue #308)`;
  - `search: could not check: issue #308 (…)`.
- **Copy 4:**
  - no `logs: run` line;
  - `logs: 0 of 0 earlier runs of migrate.yml read`;
  - `search: could not check: logs of migrate.yml's earlier runs (…)`.

**The `search credential | …` lines.** The plant is given in place of the secret, so every copy also prints `search credential | <place> | <form>: <n>` for the same value. These counts equal the plant's in every place but the logs. In the logs the body counts the "credential" in every file of an archive, top-level and in folders. So for each printing run it counts the top-level job log and the step file of `plant`: 2 per printing run when the archive holds both layouts, as every archive read in the rehearsal did (EV-C02-007 15.15). These lines are not the verdict.

Each copy then prints `search: the credential was FOUND (<N> matches); it is treated as exposed (EV-C02-001 M30)` and exits 1. Here "credential" means the plant passed in its place. This is the row's "the unbroken copy reports it found, as it must", and it says nothing about the real credential.

## Before S1 (now)

No run has printed the plant yet, so *k* = 0:
- The logs place is 0 / 0 in every copy.
- Every copy prints `search: could not check: logs of migrate.yml's earlier runs (the plant was not found in …)`.
- Copy 0 still prints one `logs: run <id>` line per earlier push run.

All other cells are as in the table. Copy 4 then cannot be told from copy 0 in the logs place: its break is shown only by a run after S1 has printed. Copies 1 to 3 are shown before S1 too. A run before S2 is not T-W03-09's break attempt, which comes after S2's search (FR-07's order).

## How to read a copy's verdict

Read it from the count lines (the `summary:` lines, or the copy's own `search plant | … ` lines), never from an exit status or the check's colour.

1. **Copy 0 first.** Every place must show its column of the table, with *k* equal to the number of printing runs the record names. Its lines must also show no logs gap. If any cell differs, the positive control failed and the break attempt is "could not check". No broken copy's 0 is then read as a break shown. A logs gap, for example from a run of `migrate.yml` in progress while the logs were read, is also "could not check": run the copies again away from the schedule's slots.
2. **Then each broken copy.** The break is shown, and the test turns red as it must, when:
   - its named place shows the plant 0 in the form planted there, where copy 0 found it (marked † above);
   - every other place equals copy 0's.
3. **Exit statuses.** Each copy's `exit 1` is expected, because the plant in place of the secret is found.
   - Step `copies` exiting 0 means only that all five copies were made and run.
   - Step `copies` exiting 1 means the program stopped: a hash other than `main`'s, the step not found exactly once, an expression, an undecodable `W03_PLANT_B64`, or a change not applying exactly once. That is "could not check" for the break attempt, not a result.
   - A `NOT the same as` line for `W03_PLANT_B64` means this file's plant is not `migrate.yml`'s at that commit. Copy 0's counts then fail too.

**What the saved log holds.**
- The copies print counts, names, statuses and hashes of code only. So the log holds neither the plant's plain form nor its percent-encoded form, and FR-07 item 3's rule on logs that hold the printed line does not bind it.
- GitHub prints a step's `env` in that step's log header. So the log shows `W03_PLANT_B64`'s base64 value, the same text `migrate.yml` holds. It also shows the 64-digit hashes of code.
- The README's hygiene check (a) will flag both as long base64 or hex. Neither is derived from a credential. The runner records them as such.

## What it does not show

- **The real credential, P7 and P8.** The copies run on a pull request's token with the search job's three permissions, not on the scheduled job's token. That the scheduled job's token reads the same refs, issues and archives is S2's to show. The mirror clone is anonymous in both cases.
- **A search that skips issue #6 but reads the fixture issue.** No plant detects it. It rests on the two being read by one loop (copy 3 removes that loop's reading for both).
- **The percent-encoded form in the issues and the logs.** It is planted in history only (T-W03-09). That the issues and logs are searched in that form rests on one code path for both forms.
- **Parts of the search's own run.** These are dropping its own run (`GITHUB_RUN_ID` here belongs to this workflow, so no run of `migrate.yml` is dropped), paging past one page of the run list, two searching jobs at once, and `check-devos`'s copy of the step. All four are as in EV-C02-007 15.15's list.
- **Other ways the search could break.** Examples are a ref the token cannot fetch, a page skipped, or an archive layout the rule counts as 0. Only the four named removals are made.
- **That the copies are exactly the code S2 ran.** The run shows only that the body's hash equals `main`'s now. That S2's commit held the same body is shown by the hash of `search` at S2's `head_sha`, which the record states.
- **Anything about GitHub beyond this run.** The producer's local runs, against a stand-in API and repository, are hints and not evidence.
