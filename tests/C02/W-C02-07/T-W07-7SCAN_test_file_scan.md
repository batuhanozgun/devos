# T-W07-7SCAN · The test files and fixtures hold no token, key or password value, by a scan shown to catch them

Synthetic test data (plan Section 8 item 13): every string the scan's controls plant is made at run time, labelled `SYNTHETIC W-C02-07 planted control`, from `os.urandom` and fixed words. It is written only into a scratch directory outside the repository and deleted before the program ends. No file holds an example of a token, key or password.

**Serves.** W-C02-07 point 7: "✘ A scan of the test files and fixtures with the guard's credential patterns and the token format W-C02-05 designs finds no token, key or password value, after the scan is shown to catch a planted fake of that format in a scratch copy". This test judges W-C02-07's own set. It serves no build item (GROUPS.md, Group D). It is also point 6's test for this scan (GROUPS.md section 3, the row "W-C02-07's scan"). Design relied on:
- EV-C02-003 §1.3, §1.7 and §14;
- README sections 4 and 6;
- `shared/token_format.md` (the markers this group fixed);
- `.claude/hooks/tool_allowlist.py` lines 149 to 151 and 416 to 418;
- `tools/credential_value_scan.py`.

**Command.** `python3 -I tests/C02/W-C02-07/bin/7scan_test_files.py --root <a checkout at the head that adds the tests>`, run from that checkout. Exit 0 PASS, 1 FAIL, 3 COULD NOT CHECK.
**Time added to W-C02-13's run.** None: it waits on no schedule or limit. It runs before W-C02-07's checker verdict, in about a second.
**Interface assumed.** README section 8.1 (the assumed interface, version 1, phase C) holds for this test; where anything here differs from it, section 8.1 holds.
- The pattern file `shared/scan_patterns.json` (this group's).
- The guard file's `REDACT` is a list comprehension over a tuple of string literals, and `CREDENTIAL_VARS` is a tuple literal. Read with `ast`; a different form gives COULD NOT CHECK (`7SCAN-pf4`).
- `tools/credential_value_scan.py`'s output lines `<label>: N files hold it` and `Values searched for: none`.

## What it scans, and how a hit is classed

- **Subject.** Every file under `tests/C02/W-C02-07/` and every `supabase/migrations/tests/w07_*` file: all four groups' files.
- **Patterns.**
  - the two token finders of `shared/token_format.md` section 3;
  - the guard's five `REDACT` patterns;
  - expansions of each `CREDENTIAL_VARS` name;
  - five value shapes of README section 4 (a): a connection string with a password, a JWT, a Supabase key, long hex and long base64.
- **Classes.** Each hit is classed as VALUE or NAME by `classify_rule` in the pattern file. That rule was fixed on 2026-10-12, before any run. `REDACT`'s last pattern matches "token", "secret" or "password" followed by `=` or `:`; it is judged on the text after the separator (GROUPS.md, Group D's note). A VALUE hit is a finding.
- **Output.** It prints paths, line numbers, pattern keys and classes, never a matched string, a part of one, its length or a hash of one.
- `tools/credential_value_scan.py` runs over the same directories. Only its exit code, the number of values it searched and the number of files holding one are kept.
- The result is worded "none found by the scanned patterns", never "no secret".

## Cases

- **The pattern file.**
  - `7SCAN-pf1`: present.
  - `7SCAN-pf2`: well formed, with five guard patterns.
  - `7SCAN-pf3`: its token patterns equal `shared/token_format.md` section 3.
  - `7SCAN-pf4`: its guard patterns equal the guard file's, re-read at run time.
  - A failure of any gives COULD NOT CHECK, and the scan does not run.
  - `7SCAN-pf5` (phase C3; C1's open 5): the class-high program `supabase/migrations/tests/w07_idc_real_path.py` embeds the environment token's exact pattern as `ENV_TOKEN_EXACT_PARTS` (the marker split, so that only the two shared files hold it literally). Read with `ast`, never run, the parts joined must equal the pattern file's `env_token_exact`: `ok` when equal, `bad` when they differ, `could_not_check` when the program or the name cannot be read. Its own controls, in the scratch copy: `7SCAN-ec-same` (an equal copy answers equal), `7SCAN-ec-diff` (one character added answers differ) and `7SCAN-ec-missing` (no such name answers could not check).
- **Positive controls, in a scratch copy** (planted, must be found as VALUE, answer fail):
  - `7SCAN-p1`: an environment token;
  - `-p2`: a claim token;
  - `-p3`: a cut copy keeping 20 characters;
  - `-p4`: the marker in upper case;
  - `-p5` to `-p8`: one string for each of the guard's first four patterns;
  - `-p9`: a password with a value;
  - `-p10`: a connection string with a password;
  - `-p11`: a JWT shape;
  - `-p12`: long random hex;
  - `-p13`: a Supabase secret-key shape.
- **Negative controls** (must not be findings):
  - `7SCAN-neg0`: a clean tree answers clean, with zero hits;
  - `7SCAN-n1`: `token: missing`, a name;
  - `-n2`: a `CREDENTIAL_VARS` expansion, a name;
  - `-n3`: a run of one repeated hex character.
- **Point 6, the scan's own missing, unreadable and partial input** (must answer could not check, never clean):
  - `7SCAN-m1`: the subject directory absent;
  - `-m2`: present but empty;
  - `-u1`: a dangling link;
  - `-u2`: a file that is not regular;
  - `-pa1`: a file larger than 8 MiB, read only in part;
  - `-pa2`: a planted value beside a partial read answers fail (a finding outranks could not check).

  The controls' answers are counted as clean, fail and could not check, with the denominator. Expected: clean 4, fail 14, could not check 5, of 23.
- **The scratch copy.** `7SCAN-ctl-clean`: it is deleted.
- **The subject.**
  - `7SCAN-s1`: no VALUE hit and every file read in full. A file not read in full gives COULD NOT CHECK.
  - `7SCAN-s2`: `tools/credential_value_scan.py` exits 0 with no file holding a value. If no session credential exists in the environment where it runs (as in a job), it searches 0 values: the result is stated as vacuous, not counted as a find.

## Form C0

| Field | Content |
|---|---|
| **ID and claim** | T-W07-7SCAN. **[Designer's addition: point 7, no Appendix C entry.]** W-C02-07's test files and fixtures hold no string of either DevOS token format, of the guard's credential patterns, or of the key, password and connection-string shapes. The scan that says so finds a planted string of each kind, and answers "could not check" where it cannot read. |
| **Failure class rule** | A credential value, or a string of a credential's format, in a committed test file. Or a scan that would not see one: a pattern missing, a pattern that differs from its source, or a file not read and counted as clean. |
| **Examples** | (1) The original need (point 7; EV-C02-003 §14): a token of the environment format written into a fixture (`7SCAN-p1`). (2) Another manifestation: a claim token (`p2`), a cut copy (`p3`), a guard-pattern key (`p5` to `p8`), a password value (`p9`), a connection string (`p10`). (3) Another: a file the scan cannot read, counted as clean (`u1`, `u2`, `pa1`). |
| **Negative control** | `7SCAN-p*` must be found. `7SCAN-m*`, `-u*` and `-pa1` must answer could not check. The subject, `7SCAN-s1` and `-s2`, must hold no VALUE. |
| **Positive control** | `7SCAN-neg0` and `7SCAN-n1` to `-n3`: a clean tree, and names that look like credentials, are not findings. The scan does not answer "found" to everything. |
| **Break attempt** | A copy of the program in a scratch directory, with one change, run with the same `--root`. This is an executable's break (README 5.2's patches are SQL); the prober makes it.<br>**B-7SCAN-1** (unreadable counted as clean). In the copy, the two lines `problems.append(f"{rel}: cannot be read ({type(e).__name__}) (unreadable)")` and `problems.append(f"{rel}: not a regular file, not read (unreadable)")` each become `pass`. Red: `7SCAN-u1` and `7SCAN-u2`.<br>**B-7SCAN-2** (token formats not scanned). In the copy, `pats = [("tok:" + k, r) for k, r in comp["tok"].items() if k.endswith("_find")]` becomes `pats = []`. Red: `7SCAN-p1` to `7SCAN-p4`.<br>**B-7SCAN-3** (phase C3; the embedded copy not compared). In the copy, `same = got == comp["raw"]["token_patterns"]["env_token_exact"]` becomes `same = True`. Red: `7SCAN-ec-diff`.<br>Each must end with exit 1, and the unchanged program must pass again after. |
| **Stage and environment** | C02. Any checkout of `devos` at the head that adds W-C02-07's tests, with Python 3 and no credential and no network. Not a Supabase project and not a Claude environment's token. |
| **Independence level** | Written by the test designer (fresh-context `test-designer` subagent, phase B, Group D; agent ID in W-C02-07's Record). Run before the merge by W-C02-07's fresh-context checker, or by the executor with the raw output given to that checker, never by its writer for the result. Its breaks are run by W-C02-13's prober. Shared: model lineage, README section 6, and the guard file it reads. |
| **Evidence layer** | Structural: strings of known shapes in files. It does not show that no secret is present in a shape it does not know, an encoded copy (base64 of a token, URL-encoded), a password with no digit (rule 2's limit), or anything outside the subject (the repository's history, other branches: W-C02-12 point 9's scan). |
| **Evidence envelope** | README section 4.<br>Fixed before the run: every case `ok` (34 cases since phase C3). The controls' answers are clean 4, fail 14, could not check 5. Each break's red cases are as above. The classification rule is the pattern file's, version 1.<br>`target_commit`: the head scanned. `criterion_version`: the commit that merged this file and the pattern file. `transport`: none (a file scan).<br>`observations_ref`: the program's output, with the head's SHA. `raw_evidence_ref`: under `evidence/C02/raw/`, after README section 4's checks, which this program's output itself passes. |

## Clause table

Not an Appendix C test. Point 7 maps as follows:

| Clause | Case IDs |
|---|---|
| "a scan of the test files and fixtures" | `7SCAN-s1` |
| "with the guard's credential patterns" | `pf4`, `p5` to `p9`, `n2` |
| (the class-high program's embedded copy of the token pattern equals the shared one; phase C3) | `pf5`, `ec-same`, `ec-diff`, `ec-missing` |
| "and the token format W-C02-05 designs" | `pf3`, `p1` to `p4` |
| "finds no token, key or password value" | `s1`, `s2` |
| "after the scan is shown to catch a planted fake of that format in a scratch copy" | `p1` to `p4`, before `s1`, in the same run |
| point 6 for this scan | `m1`, `m2`, `u1`, `u2`, `pa1`, `pa2` |

"tokens reach a test only by the route W-C02-05 designs" is shown by the other tests' interfaces (README section 6), not by a scan.

## Format gate

Not a format-gate test.

## Could not check

- The pattern file missing, malformed or differing from its sources.
- The scratch directory inside the repository.
- A subject file not read in full.
- `tools/credential_value_scan.py` missing, failing or exiting 2.
- A control that could not be planted (`7SCAN-u2` where FIFOs are not supported).

## Self-check (not a result)

On 2026-10-12 the test designer ran the program over the clone `claude/c02-w07-tests`, holding Group D's files then present: PASS (30/30). All 23 controls answered as expected. Three NAME hits were reported in `shared/token_format.md`, its words "token:" and "token=" in prose. Both breaks were made on a scratch copy, and each turned exactly its red cases. This is not the point-7 result, which needs all four groups' files at the head that adds them.

Phase C3 self-check (not a result), 2026-10-12, over the clone `claude/c02-w07-tests` with phase C3's changes: PASS (34/34); the 23 scan controls answered clean 4, fail 14, could not check 5; `7SCAN-pf5` equal; `7SCAN-ec-*` as expected. B-7SCAN-3 on a scratch copy turned exactly `7SCAN-ec-diff` red, exit 1.

## Not covered

- History, other branches, issue #6 and the records: W-C02-12 point 9, tested by `T-W07-6SC`.
- Encoded or split copies (`shared/token_format.md` section 8).
- The guard's own stop of the formats (W-C02-20's tests; `plan/work/W-C02-20.md`).
