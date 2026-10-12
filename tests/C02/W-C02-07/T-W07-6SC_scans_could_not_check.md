# T-W07-6SC · The token-format scans that C02 runs answer "could not check" for a place they cannot read, never zero

Synthetic test data (plan Section 8 item 13): every planted string is made at run time in a scratch place, labelled `SYNTHETIC W-C02-07 planted control`, and deleted after. Every planted place (folder, file, branch name, issue page) is made up and named `w07_fixture_*`. No token is used.

**Serves.** W-C02-12 point 9: "✘ After the steps and the runs, the tokens are looked for, by the format W-C02-05 gives them, in the repository on `main` and on every branch the sessions pushed, in issue #6 and in the records, with a positive control … it is "could not check" if W-C02-05 gives no format and names no other method". Also W-C02-07 point 6 for the scans W-C02-05 designs and C02 runs (GROUPS.md section 3, the row "The session's format scan, and W-C02-12 point 9's scan"). Design relied on:
- EV-C02-003 §3.2 ("A place the guard does not let it read is recorded as "could not check" (plan Section 8 item 14), never as zero");
- EV-C02-003 §1.7 (the session's scan counts only the environment token's format; W-C02-12 point 9's counts both);
- `shared/token_format.md` (the format, now given).

**Command.** A specification run by a procedure, since GROUPS.md assigns this test no executable (Open, in the report). W-C02-13's prober, or W-C02-12's producer at its head, runs the build's scans as their interface names below, in a scratch directory outside the repository. It records each case's answer. The scans themselves are W-C02-12's build: the first message's scan, and the record's scan.
**Time added to W-C02-13's run.** None: it waits on no schedule or limit.
**Interface assumed** (the build names it; this test is revised before the first result if it differs). Each scan is a program, or a fixed procedure, that:
- (a) takes its list of places as input: folders, files, environment variables, and git refs; issue #6's comments and the records for W-C02-12 point 9's scan;
- (b) prints, per place, either a count of strings of the format or `could not check` with a reason, never a matched string;
- (c) ends with one answer: `none found by the scanned patterns` (clean), `found` (fail) or `could not check`;
- (d) uses the finder patterns of `shared/token_format.md` section 3, the session's scan for the environment token only;
- (e) runs its planted control first.

## Cases

For each of the two scans: `fs` is the session's format scan (EV-C02-003 §3.2); `rs` is W-C02-12 point 9's scan of the repository, branches, issue #6 and the records.

| Case | Planted input | Expected answer of the scan |
|---|---|---|
| `6SC-<s>-pos` | a place holding one planted string of the scanned format, with the scan's own control | that place counts 1; the answer is `found` |
| `6SC-<s>-clean` | a place holding no such string | that place counts 0; the answer is clean |
| `6SC-<s>-m1` | a place in the list that does not exist (a folder, a file, a branch `w07_fixture_absent`) | that place `could not check`; the answer is `could not check`, never clean |
| `6SC-<s>-m2` | an empty list of places | `could not check` |
| `6SC-<s>-u1` | a place the scan cannot read: a dangling link; a file without read permission where the scan does not run as root; a folder the guard denies (for `fs`, EV-C02-003 §3.2) | `could not check` for that place; the answer `could not check` |
| `6SC-<s>-u2` (`rs` only) | issue #6 unreachable: the scan's request refused or timed out (planted by pointing it at an unreachable host or a wrong issue number) | `could not check` |
| `6SC-<s>-pa1` | a file larger than the scan's read limit, or a git listing cut short (the ref list ends with an error) | `could not check` |
| `6SC-<s>-pa2` (`rs` only) | issue #6's comments, with one page of the paginated answer missing | `could not check` |
| `6SC-<s>-pa3` | a planted string beside an unreadable place | `found` (a finding outranks could not check), with the unreadable place listed |
| `6SC-fs-own` (`fs` only) | a planted claim-format string | not counted (EV-C02-003 §1.7); a planted environment-format string beside it is counted |

The procedure counts, per scan, the clean, found and could-not-check answers with the denominator. Expected:
- for `fs`: clean 1 (`clean`), found 3 (`pos`, `pa3`, `own`) and could not check 4 (`m1`, `m2`, `u1`, `pa1`), of 8;
- for `rs`: clean 1, found 2 (`pos`, `pa3`) and could not check 6 (`m1`, `m2`, `u1`, `u2`, `pa1`, `pa2`), of 9.

## Form C0

| Field | Content |
|---|---|
| **ID and claim** | T-W07-6SC. **[Designer's addition: point 6, no Appendix C entry.]** Each token-format scan C02 runs answers "could not check", kept apart from clean and from found, for a place it cannot read in full, never zero. Each finds its planted string. |
| **Failure class rule** | A scan that counts a place it did not read in full as zero, folds "could not check" into clean, or into found without listing it, or reports clean with its own control not found. |
| **Examples** | (1) The original need (EV-C02-003 §3.2): a folder the guard denies, counted as zero (`6SC-fs-u1`). (2) Another manifestation: a branch that does not exist (`m1`); issue #6 unreachable (`rs-u2`); a page of comments missing (`rs-pa2`). |
| **Negative control** | Every `m*`, `u*` and `pa1`/`pa2` case answers `could not check`. |
| **Positive control** | `pos` answers found; `clean` answers clean with 0. So the scan neither refuses to answer nor finds everything. |
| **Break attempt** | A copy of the build's scan in which an unreadable or absent place is counted as 0, made by the prober in a scratch directory. Red: `6SC-<s>-m1`, `-u1` and `-pa1`, and `-u2` and `-pa2` for `rs`. A second copy without the planted control: `pos` stays found, but the scan's own control step reports missing, so it gives `could not check`. The red case is `6SC-<s>-pos`'s control line. |
| **Stage and environment** | C02. `fs`: in a scratch directory in the working session or a step-5 session (EV-C02-003 §3.2 (i) and (ii)). `rs`: a scratch clone of `devos` with fixture branches, and issue #6 read-only. No Supabase project, no token. |
| **Independence level** | Written by the test designer (fresh-context `test-designer` subagent, phase B, Group D; agent ID in W-C02-07's Record). Run by W-C02-13's prober or W-C02-12's producer, against W-C02-12's scans. Judged by W-C02-12's fresh-context checker (point 12). Shared: model lineage and EV-C02-003. |
| **Evidence layer** | Structural, of the scans' answers on planted input. It does not show that the scans reach every place a token could be (EV-C02-003 §3.2, "Limits"), or encoded copies. |
| **Evidence envelope** | README section 4.<br>Fixed before the run: the expected answers above, and the counts per scan. `transport`: none. `observations_ref`: the procedure's output with each scan's version. `raw_evidence_ref`: under `evidence/C02/raw/`. |

## Clause table

Not an Appendix C test. W-C02-12 point 9 maps as follows:

| Clause | Case IDs |
|---|---|
| "with a positive control (a synthetic string of that format, labelled, is found)" | `pos` |
| "never "no leak"" | the answer wording `none found by the scanned patterns` in `clean` |
| "could not check" | `m*`, `u*`, `pa*` |

EV-C02-003 §3.2's "never as zero" maps to `fs-u1`.

## Format gate

Not a format-gate test.

## Could not check

- Until W-C02-12 builds the scans and names their interface. Each case is then COULD NOT CHECK.
- A state that could not be planted, for example a file without read permission where the scan runs as root. Then `u1` uses the dangling link only, and says so.

## Not covered

- The executor's count-only log check on `devos` (EV-C02-003 §14): a procedure the executor runs, with its own positive control there, not a check C02 builds (the executor's decision 2).
- The guard's stop of the formats (W-C02-11's tests).
- W-C02-07's own scan (`T-W07-7SCAN`).
