# T-W03-09 · The credential is not found where an agent session can read it

**Synthetic test data** (plan Section 8 item 13). The planted value is a non-secret constant made up for this test. It has the form `w03-fixture/plant+value@<plant tag>=x`, so that its percent-encoded form differs from its plain form. `<plant tag>` is not a run's ID: the plants and the workflow's encoded copy are made before the search run, so no run's ID is known then. It is a tag the executor chooses when making the plants, the UTC time of planting written `YYYYMMDDTHHMMZ`. It is recorded in `inputs_ref`, so that a plant from an earlier round is not counted as this round's. The workflow holds it only in a form the search does not match: base64, decoded at run time. Its only plain occurrences are therefore the planted ones. It is never any credential.

**Serves.**
- W-C02-03 point 9, quoted: "✘ The credential is looked for where an agent session can read it, by a method that never shows it (for example a step of the job that holds it and reports only a count of matches): the repository on `main` and on every branch, and issue #6. The result is "none found by that method", with a positive control that the method finds a synthetic value planted for the purpose. That a session has no other route to it is taken from the documentation (R5 G1, G2), quoted with URL and date and labelled documented, not independently tested. The record names the layers … states D-003's residual, and claims this ✘ at that level only."
- The session half of C02's Acceptance line "✘ The migration credential cannot be read by an agent session …".
- EV-C02-001 section 10, "Point 9", and CHK-C02-008 C4 (both credentials).

## The method

This is the build's step; the test fixes what it must do and print. In each scheduled job, `check-devos-test` and `check-devos`, a step holds that job's own project's value. For each place in the table below, it counts fixed-string matches of the value and of its percent-encoded form. It treats every text it reads as data only: never run, evaluated or put into a command. It prints, per place and per form, only the count.

| Place | How read |
|---|---|
| every ref's tree and history of `devos` | every object of a full clone (all branches, tags and pull-request refs the token can fetch) |
| issue #6's body and comments | the issues API, read with the same code used for the fixture issue below |
| the logs of earlier runs of `migrate.yml` | the runs API |

**Planted positive control.** The synthetic value is planted once in each kind of place. In the run that searches, each job must report exactly one match per planted place, in the form planted (p4: as stated there). The plants:
- (p1) a file on a `claude/w03-search-fixture` branch;
- (p2) a commit on that branch whose change a later commit removes, so that only the history holds it; its content differs from p1's, so the two are not one blob;
- (p3) a comment labelled synthetic on a fixture issue;
- (p4) the line printed by the step H1 adds to `migrate.yml` (the class-high change that also sets `W03_PLANT_B64` and `W03_FIXTURE_ISSUE`, and gates `tokens_revoke` on the head check). That step runs in one job only, only when `W03_PLANT_B64` is set, and prints the decoded plant exactly once; its script and the job's environment hold only the base64 form, so the printed line is the plain form's only occurrence in that run's logs. It prints in H1's push run. No other run of `migrate.yml` prints it before the search: the step is not in the scheduled jobs (or does not print there), and nothing merges into `main` between H1 and the search run. p4's expected count, in each job, is the number of copies of that one printed line in the log archive of H1's run that the search reads: 1 if the archive holds each job's log once, 2 if it also holds that step's own file (the archive's layout is recalled from GitHub's documentation, not re-read). The record states which, from the executor's read of that archive (its file list and a fixed-string count) where it can be read, and otherwise labels the expected count as resting on that recall. A count of 0 is "could not check" for the logs; any other count is "could not check" for the logs too, with the runs that printed it named;
- (p5) the percent-encoded form, in one of these places (p2's content, for example).

The plants are made before the search run and removed after it: the fixture issue closed; the branch deleted by whoever can (the guard refuses a session's branch deletion; otherwise Batu, batched with another step of his); `W03_PLANT_B64` and `W03_FIXTURE_ISSUE` unset and the print step removed by the next class-high change (left set, later searches report "could not check"); and the record keeps the run IDs. No pull request is opened from the plant branch (`refs/pull/*` are searched as tips and stay), no commit message or pull-request text holds the plant, and a raw log holding the plain plant is committed to the repository only after the search run.

## Form C0

| Field | Content |
|---|---|
| **ID and claim** | T-W03-09. By the stated method, neither project's migration credential (plain or percent-encoded) is found in `devos`'s refs and history, in issue #6, or in `migrate.yml`'s logs, while the same method finds a planted synthetic value in each kind of place. That a session has no other route is documented, not independently tested. The ✘ is claimed only at the level of the layers named. |
| **Failure class rule** | The credential is held where a session can read it, or the search could not have found it. Examples of this family: the value is in a file, a commit, an issue or a log; it is there only in an encoded form; the search skips history, a ref, the issue or the logs; the search finds nothing because it reads nothing. |
| **Examples** | The live credential: (a) `devos-test`'s value and (b) `devos`'s value, each in each place. The planted value: (p1) to (p5). |
| **Negative control** | For each credential, each place and each form, the count is 0, recorded as "none found by that method". |
| **Positive control** | The planted value is found, with count 1, in each planted place, by the same step in each job. A 0 for any plant makes the run "could not check" for that place, never "none found". |
| **Break attempt** | Copies of the search step, each with one part removed, are run in a run with the plants present (before the plants are removed):<br>• it reads only the current trees, not the history: (p2) is not found;<br>• it searches only the plain form: (p5) is not found;<br>• it skips the issue: (p3) is not found;<br>• it skips the logs: (p4) is not found.<br>Each must turn the test red, because a plant is missing. The copies run in a workflow run that holds no credential and names no environment, for example the pull-request checks. The planted value is passed in place of the secret, and the copies run the search step's own code, read as in T-W03-DEC's interface. They never run with the real secret, and no workflow other than `migrate.yml` names an environment (M04). The copies' workflow (one job, no environment, `issues: read`, the search step's own code taken from `migrate.yml`, the unbroken copy first as their positive control) is written by a producer, never by the test designer; the executor pushes it on a branch based on `main`, opens a pull request that is never merged, saves the check's log, and closes it. Each copy's verdict is read from its count lines, not from its exit status: with the plant in place of the secret, the unbroken copy reports it found, as it must. |
| **Stage and environment** | C02, at the first scheduled run after H1's push run, with no merge into `main` in between (P7: a scheduled run receives the secret). The scheduled run before H1 is read first as the baseline: with no plant, every place is "could not check".<br>• Where: the scheduled jobs on GitHub; their logs are the raw output.<br>• Who runs (README, "Who runs, who judges"): the jobs themselves search. The executor makes and removes the plants (the branch pushes, the fixture issue and its comment), merges H1, and saves the search run's job logs unedited; a prober reads the counts from the saved logs.<br>• Probes relied on: P7; P8, which reads whether the job's token can read every ref, including pull-request refs (if not, those refs are "could not check" for this method). |
| **Independence level** | Written by the test designer. Run by the job, which is its own output; plants made and logs saved by the executor; the saved logs analysed by a prober (fresh-context subagent, declared). Assessed by the fresh-context checker of point 13 from the saved logs, not from the executor's or the prober's account. Shared: model lineage, design record. |
| **Evidence layer** | Structural, observed live. The search method's coverage is shown by the plants, not assumed. |
| **Evidence envelope** | As in the README.<br>• `observations_ref`: the two jobs' run IDs and their count lines.<br>• `inputs_ref`: the plants' branch, commits, issue comment and run (H1's push run and the job that printed p4), with their IDs.<br>• Raw output: counts only, which the job prints. The hygiene check of the README is applied to the copied log lines. |

**What the record states with the result** (from point 9; not a test of its own):
- The documentation that a session has no other route. "Any user with write access to your repository has read access to all secrets configured in your repository" (R5 G1, for repository secrets, which are not used) and environment secrets' reach (R5 G2), quoted with URL and reading date and labelled documented, not independently tested.
- The layers that keep a session from changing what the job runs on `main`: the merge gate's class-high verdict on `.github/workflows/**` and `supabase/migrations/**` (and `tools/**`, if T-W03-DEC's interface (b) is used); the guard; the rule of `main` only once N-175 settles who can change it; and P8's result.
- D-003's residual.
- The ✘ is claimed at that level only.

## Could not check

- A place the step cannot read.
- A plant not found, or p4 found with a count other than its expected one (above).
- A search run superseded at its head check, or one whose logs place reports earlier runs not read (a push into `main` between H1 and the search run causes either).
- A scheduled run that did not receive the secret (P7). Its "credential present" line is `no`, and the search found nothing because it had nothing to look for.

## Depends on R1 to R6

None.
