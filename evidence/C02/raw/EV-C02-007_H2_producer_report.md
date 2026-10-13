I've built H2 in the clone at `1f6f9a2`. Every test that reads the workflow passes, nothing was committed, and the base64 and plain forms of the plant are in no file and nowhere in this report.

One thing needs your decision before the checker sees it: the header comment of `migrate.yml` (lines 5–6) still says "and, while W03_PLANT_B64 is set, check-devos-test prints the synthetic plant once, step plant; T-W03-09 p4". With the step removed, that is now false. Your task said nothing else in the workflow changes, so I left it. If you want it fixed in H2, the two lines become one: `# search only, in each project. The only workflow that names the environments migrate-devos-test and migrate-devos;` It is a comment outside any step body, so no body hash changes.

**Files** (SHA-256 before is `git show 1f6f9a2:<path> | sha256sum`; after is `sha256sum` in the working tree):

| File | Before | After |
|---|---|---|
| `.github/workflows/migrate.yml` | `5e3c9116590898b5a8bd3e226422c63619c583fd8bf58443463cc4bd29520ce6` | `15aa179e5888db8e780dc4da54c87dc9b68310166b7b3b6f6282b022c23d1488` |
| `supabase/migrations/20261012232111_w03_fixture_fail.sql` (new, copied byte for byte, `cmp` identical) | absent | `0d439a148f88c3d2067d45a85c1e273ae4bb99d6cbb2a952287ae340e976e0c7` |
| `evidence/C02/EV-C02-007_migration_path_build.md` | `8346e564521ce6cd42d26bf6ae82c3d48ab6d4ad1ecccd8d512ce5cbbfed3bb6` | `bdef5de91ebfd54b1db60568a8faed2ca7bb6d9ccbc9a25422bdf6fce38fb7c3` |

- **Fixture version:** `20261012232111` is later than both migrations on `main` (`20261012184638`, `20261012231841`), so the file keeps its name.
- **Record:** I added section 17 and one `sources` line in the front matter. The record's diff removes no line, so sections 1 to 16 are untouched.

**`migrate.yml` diff** (7 insertions, 37 deletions; 3477 lines before, 3447 after):
- **:64:** `W03_PLANT_B64` is now `""`. Its comment now reads `# T-W03-09's plant, base64; emptied after S2's search, with the print step removed (EV-C02-007 sections 15 and 17)`.
- **:65:** `W03_FIXTURE_ISSUE` goes from `"308"` to `""`.
- **:887:** `section 14` becomes `section 15`, and `section 14.9` becomes `section 15.9`.
- **:2617 and :3353 (now :3323):** `section 14.6` becomes `section 15.6`.
- **:2620 and :3356 (now :3326):** `section 14.12` becomes `section 15.12`.
- **:2742–:2771:** step `plant` of `check-devos-test` is removed; that also removes line 2755's citation.

For the renumbering I kept the mapping in section 15's Numbering note and checked each against section 15's content. More specific targets exist (15.1 for line 887's first citation, 15.12.1 for 2620/3326), but I kept the granularity the comments had. No "section 14" is left in the file.

**Body hashes:** only the two `search` copies changed, and only in comment lines. They are still identical to each other, now `75d0f1f47cb9` (was `2ef72520eefd`), and `plant` (`b049a11f5998`) is gone. `tokens_revoke` (`8117e8de0831`), its condition on line 889, `dbtests` (`08eedf39e196`) and all of A3's table bodies are unchanged. `migrate.yml` now has 53 `run:` values (was 54).

**What else reads the two settings or the step:**
- `W03_PLANT_B64` is read only by the two `search` copies (:2533–2534 and :3239–3240).
- `W03_FIXTURE_ISSUE` is read only by the same two copies (:2599 and :2680; :3305 and :3386).
- Nothing reads `steps.plant`, and `tokens_revoke` reads neither setting.
- Nothing outside `evidence/` reads either setting or the step.

**What each scheduled run prints once they are empty:**
- The search looks only for the credential; issue #308 is no longer read.
- It prints `search positive control: no plant configured (W03_PLANT_B64 is empty), so a 0 here is not backed by a positive control: could not check`.
- If the credential is present and nothing matches, the last line is `search: 0 matches, but could not check (…): repository: current trees; repository: history; issue #6; logs of migrate.yml's earlier runs`, exit 0.
- A match still prints FOUND and exits 1. With no secret, it prints `could not check (credential present: no)`.
- No run prints the plant line any more.
- Until H3, both scheduled comparisons will name `on_main_not_applied 20261012232111` without failing.

**Tests** (from the clone's root):
- `test_workflow_order.py`, exit 0: `W03_ORDER_TEST PASS (.github/workflows/migrate.yml)`, `W03_RUN_EXPR_TEST PASS (no run: value holds an expression opener: 57 values in 2 files; 4 planted copies red, 1 control passes)`, `W03_PR_INPUTS_TEST PASS (21/21 cases; breaks: 6 shown, 0 not shown, of 6)`. With `--self-check`, exit 0: `W03_GUARDS_SELF_CHECK PASS (20/20)`.
- `test_workflow_guards.py`, exit 0: the same `W03_RUN_EXPR_TEST` and `W03_PR_INPUTS_TEST` lines.
- `test_decision_steps.py`, exit 0: `W03_DECISION_TEST PASS (69/69)`. With `--self-check`, exit 0: `W03_DECISION_SELF_CHECK PASS (7/7)`.
- `migration-checks.yml`'s `w03_tests` step (T-W03-15's run), run locally, exit 0: `W-C02-03 tests: decision steps exit 0, workflow order exit 0`.
- M22 (`workflow_check`'s body) run locally over the tree, exit 0: 31 copies "fail as they must", the control passes, `workflow check: pass`.
- `tools/test_merge_gate.py`, exit 0: `MERGE_GATE_TEST PASS (97/97)`.
- `records.py render --check`, exit 0: `RENDER OK`. `check_service_names.sh`: `SERVICE_NAMES CLEAN`.
- No test checks for the plant step or either setting, so none failed. The run-value count dropped from 58 to 57 only because the step is gone.

**Open:**
- **GitHub's parser was not run.** The workflow-parser copies in the scratchpad fail to load under Node 22.22.0 (`ERR_IMPORT_ATTRIBUTE_MISSING`). The pull request's own check on GitHub is the parser evidence.
- **Version check at the pull request:** if another migration merges before you open it, the fixture is renamed to a later version first (T-W03-14). I did not check this beyond `1f6f9a2`.
- **Before the merge:** every scheduled run between S2 and H2's merge still prints the plant once (T-W03-09).
- **Live-only (17.6 and 17.8):** whether the failed file leaves nothing on Supabase's own server, and whether the stop before `devos` (`decide` gives `apply=no`, `dryrun` and `apply` skipped) actually acts. The expected `go=no (…)` line is inferred from the `go` step's format, not seen.
- **Noticed, outside my scope:** `evidence/C02/checks/CHK-C02-044.md` on `main` holds a plant form with the retired tag `20261012T2338Z`. That tag is already known and is not counted, and no file holds the current tag's form.
- **Scratch files:** helper scripts and outputs are in `/tmp/claude-0/-home-user-devos/0cb29c90-d12e-56b6-9751-2217078b0a90/scratchpad/h2work/`; none holds the plant in either form.

## Disciplines (D1–D9)
D1: yes: I weighed three frame choices (finer subsections versus the Numbering note's mapping, the wording of line 64, and the stale header) and took the option that keeps to the recorded mapping and the task's "nothing else changes", stating the alternative for each.
D2: no
D3: yes: I checked the build against H2's README definition (fixture, settings unset, step removed) and recorded the merge condition, the version check at the pull request and the stale header as open items instead of counting the build as done.
D4: yes: I recorded that the static tests only read the text, that no test asserts the plant step, that the parser was not run, and what only the live runs show.
D5: yes: I re-derived the task's line numbers, hashes and claims from the files (`git ls-tree`, `sha256sum`, body hashes against 15.16 and A3) and corrected my own body count (53, not 55) before finishing.
D6: no
D7: yes: I wrote everything into EV-C02-007 section 17 and a `sources` line so a new session can rebuild the change and its open items from the record.
D8: yes: I confirmed the clone was on `claude/c02-w03-h2` at `1f6f9a2` with a clean tree, and read T-W03-14, T-W03-09, EV-C02-007 section 15 and CHK-C02-053 before writing.
D9: no

**Guard denials:** none.
