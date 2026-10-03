# OI-012 measurement: where the unredacted service names are reachable (pre-registration)

**Item:** OI-012 (state file §5), W-C00-12 tranche 1a. **Written:** 2026-10-03, before the measurement; the time is in the commit. **Producer:** run `session_01XUsVQowRbLJdC1E8gFvxZq`.

**Rule kept.** No service name is written anywhere, including in this file, in the log or in a command's pasted output. The measurement prints only counts and commit SHAs. The pattern is derived exactly as `tools/check_service_names.sh` derives it from `3cd686a`.

**Procedure.** In a scratch clone with full history (`git fetch --unshallow` or a bounded deep fetch of `main` and the two review branches):
1. Count the commits reachable from `origin/main` whose tree matches the derived pattern. Use `git grep -c -E <pattern> <commit>` over `git rev-list origin/main`, piped through `wc -l`.
2. Do the same for commits reachable from `origin/claude/review-R-C00-BOM-1` and `-2` but not from `main`.
3. Record both counts, the first and last matching commit SHAs on `main`, and the derived pattern's term count.

**Interpretation, fixed now:**

| Result | Meaning | Action |
|---|---|---|
| Count 1 > 0 | `main`'s own history holds the names; deleting the review branches removes nothing that is not already public on `main` | The exposure stays under the D-003 (a) residual; OI-012 is closed with that reason |
| Count 1 = 0 and count 2 > 0 | Only the review branches hold them | Deleting the two branches is put to Batu as an account action in his batch: the git proxy refused a remote delete once (403, L-031), and R-R21 forbids another route |
| Both 0 | The redaction premise was wrong; the names are not there | OI-012 is closed as a false alarm, and the critic's finding 3 is annotated |

## Result (2026-10-03, run `session_01WcVuDQhDW3EKr4Sb87MHxN`)

**Method as pre-registered,** in a scratch clone of `devos`, with the pattern derived exactly as `tools/check_service_names.sh` derives it. The script prints counts and SHAs only. A first run in a **shallow** clone gave 0 of 136 commits on `main` and was discarded as invalid, because the procedure asks for full history; the clone was then unshallowed (`git fetch --unshallow`, `git rev-parse --is-shallow-repository` printed `false`), and `3cd686a` was confirmed to be an ancestor of `origin/main`.

**Output** (unedited):

```text
terms 12
count1_main_commits_matching 9 of 184
first_on_main a58413a last_on_main d6ac5a6
count2 claude/review-R-C00-BOM-1 1 of 1
count2 claude/review-R-C00-BOM-2 1 of 1
count1_main_excluding_settings 9; last d6ac5a6
```

**Interpretation, by the pre-registered table:** count 1 > 0. `main`'s own history holds the names in 9 commits, including when `.claude/settings.json` is excluded; the review branches add one commit each. Deleting the two review branches would remove nothing that is not already public through `main`. **OI-012 is closed** with that reason; the branches are left as they are, and no deletion goes to Batu.

**What stays open, stated.** Removing the names from public history would need a rewrite of `main`, which ruleset 24194116 forbids (non-fast-forward) and which would be an account action. That is not proposed. The pre-registration places the exposure under the D-003 (a) residual. Whether D-003 (a)'s wording covers this exposure, rather than only the connector barrier, is noted for the next batch to Batu as a question to confirm, not as a separate decision now.
