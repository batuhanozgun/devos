I wrote both files in the scratch directory and nothing in `/home/user/devos`. Local stand-in runs gave the expected count table in every mode, and the two stop paths fired when forced. These are my own hints; nothing has run on GitHub yet.

## Disciplines (D1–D9)
D1: yes: I compared the alternative for each change (a shallow clone for copy 1, a skip that reports its own gap for copy 4, skipping issue #6 alone for copy 3) and the alternative reading of "check against main's file" (fetch main at run time); my choices and the conditions under which they matter are under Open.
D2: yes: the local runs are my own self-checks, so I call them hints, wrote the expected counts into the harness before running it, and leave the verdict to the checker.
D3: yes: I checked the whole path the pull request needs: M22 and T-W03-15's G1 pass with the file added, the summary lines can be read, and copy 4's break can only show after S1.
D4: yes: I checked that the program's own stops turn red: a changed search body stops all copies, and a change that applies twice stops just that copy; I state these as producer hints, not independent evidence.
D5: yes: I took the rehearsal file in scratch only as a template; I recomputed the hash from `migrate.yml` myself and grep-checked it against EV-C02-007, and I say that local `main` (`1f6f9a2`) was not fetched from GitHub.
D6: no
D7: yes: everything the executor needs (placement, order, how to re-run, how to read the result, what it does not show) is in the README and this report, with both files' SHA-256, so a new session can pick it up from the files alone.
D8: yes: I read the search body, `W03_PLANT_B64`, `W03_FIXTURE_ISSUE` and the checkout pin straight from `main`'s `migrate.yml` at `1f6f9a2`, and the hash from EV-C02-007, not from the task text.
D9: no

**Files** (in `/tmp/claude-0/-home-user-devos/0cb29c90-d12e-56b6-9751-2217078b0a90/scratchpad/w03breaks/`):
- `w03-search-breaks.yml`, SHA-256 `b80414b77fbdb856888820292e754d03084e5cd47920ae70bb5f564b370d7486`. Its first line labels it synthetic test data for T-W03-09's break attempt, never to be merged.
  - It triggers on `pull_request` into `main` only, with top-level `permissions: {}`.
  - One job with `contents: read`, `actions: read` and `issues: read`, and no environment.
  - `actions/checkout` is pinned to `migrate.yml`'s commit, with `persist-credentials: false`.
  - Step `copies` (`shell: python`) has `W03_PLANT_B64` and `W03_FIXTURE_ISSUE` in its env, copied from `migrate.yml`, and `GH_TOKEN: ${{ github.token }}`.
- `README.md`, SHA-256 `3ab5ce5da8ee848461493d5bbbe1333086d872a50485ac7012ed71019d59f1e2`. It covers the exact old and new text of each copy, the expected counts after S2 and before S1, how to read a verdict, and what the run does not show.

**The search body's hash, as read.** At `main` `1f6f9a2`, `check-devos-test`'s step `search` is shell python, 190 lines. The SHA-256 of `run|shell` is `2ef72520eefdfc1407925d2742f6a5db12c8622548518f582f2aea18e832aebe`, and `check-devos`'s copy is identical. Its first 12 digits, `2ef72520eefd`, are what EV-C02-007 15.12, 15.15 and 15.16 list. 15.4 gives no value of its own: it says "identical to 12.7's", an older body that 15.10 and then 15.12 replaced. At run time the program prints the hash it read and stops every copy if it is not this value.

**The five copies.** Each change is one replacement at run time and must apply exactly once. The hash in each row is the copy's body hash on `main`'s body.

| Copy | Old text | New text | Removes | Body hash |
|---|---|---|---|---|
| 0, unbroken | — | — | nothing | `2ef72520…aebe` |
| 1, no history | `ids = git("-C", m, "cat-file", "--batch-all-objects", "--batch-check=%(objectname)").stdout` | `ids = b"".join(s + b"\n" for s in sorted(tip_blobs))` | reading any object that is not a current-tree blob | `d35b8fecbf9ea370742d68c4f8f9eb7244ce840b6e5e8b708297d69f092c5967` |
| 2, plain only | `return {"plain": v.encode(), "percent": urllib.parse.quote(v, safe="").encode()}` | `return {"plain": v.encode()}` | the percent-encoded form, in every place | `10464ff0f29fbf7d5c2e97fd34de9d9a48d9c82f8b5eeb47310a73d036a5eb35` |
| 3, no issue | `place = f"issue #{number}"` | `place = f"issue #{number}"; count(place, b""); continue` | reading the issues (#6 and #308 share this loop); both places still print 0 | `f801941263f594c58f925c28ee7a2d4a43ae9509e19d336f08682bd36a902db7` |
| 4, no logs | `runs, seen, listed, page, more = [], set(), 0, 0, True` | `…, 0, 0, False` | reading the run list, so no log at all; it prints "0 of 0", no gap | `629a6d9327bd6f8a3f593a61f2d35f508f51883d0c55e839677e3b81563ac0d2` |

**Tests** (all local, no network; scripts and outputs are in `…/scratchpad/w03breaks_check/`). The stand-in plant uses the tag `20000101T0000Z`, which no round uses; the real plant was never decoded.
- **Lint and constraints (PyYAML):**
  - `on {'pull_request': {'branches': ['main']}}`, `permissions {}`, the job's three permissions all `read`.
  - `W03_PLANT_B64` and `W03_FIXTURE_ISSUE` are byte-equal to `migrate.yml`'s; the checkout pin is equal.
  - `run values 1 with opener 0`; `program compiles`.
- **Counts in the deliverables:**
  - The YAML holds `W03_PLANT_B64`'s value exactly once. The plain-form prefix, the percent-form prefix, `secrets.`, `environment:` and `: write` each occur 0 times. The only `${{` is the `GH_TOKEN` env line.
  - The README is 0 on all of these.
- **`harness.py s2`** (stand-in API and repository, two runs that printed the plant): `program exit 0; plant forms (plain, percent, base64) in its output: 0` and `summary as expected (k=2): yes`. Every copy printed `search: the credential was FOUND …` and exit 1, as designed.
- **`harness.py pre-s1`:** `program exit 0; … 0` and `summary as expected (k=0): yes`.
- **`harness.py real`** (working directory `/home/user/devos`, reading `main`'s actual `migrate.yml`, read-only): `program exit 0; … 0` and `summary as expected (k=2): yes`. The `W03_PLANT_B64` line read `NOT the same as`, which is expected because this run gave the stand-in's base64.
- **`harness.py selfcheck-hash`** (search body changed): `program exit 1`, with `breaks: could not check: that is not main's search body (…); no copy is run`.
- **`harness.py selfcheck-twice`** (copy 3's old text present twice): `program exit 1`, with `[copy 3 no issue] breaks: could not check: its change applies 2 times, not exactly once; this copy is not run`. The other four copies ran.
- **`static_checks.py`:**
  - M22 (`workflow_check`'s own body, over `main`'s two workflows plus this file): exit 0, 32 self-check lines "as it must", `workflow check: pass`.
  - T-W03-15 G1: `3 files, 59 run values; problems []; could not check []`.

**Open:**
1. **"Check it at run time against main's file".** I read this as: the program carries the full hash of `main`'s body now and compares it with the file at the checked-out commit. For a pull request that is the merge into `main` at its base, and the program prints the head and base SHAs. It does not fetch `main` separately. Local `main` `1f6f9a2` was not fetched from GitHub; if GitHub's search body differs, the run stops by design.
2. **Exit status.** Step `copies` exits 0 when all five copies ran, so the check is green even though each copy exits 1. It exits 1 only when the program itself stops. The checker may want this the other way.
3. **Choices with alternatives.** Copy 4 skips silently; another way would report a gap. Copy 3 skips both issues, because a skip of #6 alone is undetectable when #6 is backed by #308. The README records both.
4. **What the saved log will contain.** GitHub prints the step's env in the log header, so the log will show `W03_PLANT_B64`'s base64. It will also show 64-digit hashes of code. The README's hygiene check (a) will flag both; neither comes from a credential.
5. **The token's permissions.** That a `pull_request` token gets the three declared permissions is an inference; the job log's "GITHUB_TOKEN Permissions" line will show it. `migration-checks.yml` also runs on this pull request, and its colour says nothing about this test.
6. **Stray copies of the plant in the check directory** (not deliverables; neither form of the real plant is in any output):
   - `w03breaks_check/` holds the stand-in plant in plain, percent and base64 forms.
   - `w03breaks_check/m22tree/.github/workflows/migrate.yml` is a byte copy of `main`'s and holds the real base64.

   The executor's count should cover `w03breaks/` only, or delete `m22tree/` first.

**Guard denials:** one. Rule G0 (#27521) refused a Bash `grep` because of an unbalanced backtick. I ran the search again with the Grep tool, and `tools/guard_report.py` shows the denial.
