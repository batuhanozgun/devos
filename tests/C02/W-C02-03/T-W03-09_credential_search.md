# T-W03-09 · The credential is not found where an agent session can read it

**Synthetic test data** (plan Section 8 item 13). The planted value is a non-secret constant made up for this test. It has the form `w03-fixture/plant+value@<run id>=x`, so that its percent-encoded form differs from its plain form. The workflow holds it only in a form the search does not match: base64, decoded at run time. Its only plain occurrences are therefore the planted ones. It is never any credential.

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

**Planted positive control.** The synthetic value is planted once in each kind of place. In the run that searches, each job must report exactly one match per planted place, in the form planted. The plants:
- (p1) a file on a `claude/w03-search-fixture` branch;
- (p2) a commit on that branch whose change a later commit removes, so that only the history holds it;
- (p3) a comment labelled synthetic on a fixture issue;
- (p4) a line that a run of `migrate.yml` prints;
- (p5) the percent-encoded form, in one of these places.

The plants are made before the search run and removed after it: branch deleted, issue closed, and the record keeps the run IDs.

## Form C0

| Field | Content |
|---|---|
| **ID and claim** | T-W03-09. By the stated method, neither project's migration credential (plain or percent-encoded) is found in `devos`'s refs and history, in issue #6, or in `migrate.yml`'s logs, while the same method finds a planted synthetic value in each kind of place. That a session has no other route is documented, not independently tested. The ✘ is claimed only at the level of the layers named. |
| **Failure class rule** | The credential is held where a session can read it, or the search could not have found it. Examples of this family: the value is in a file, a commit, an issue or a log; it is there only in an encoded form; the search skips history, a ref, the issue or the logs; the search finds nothing because it reads nothing. |
| **Examples** | The live credential: (a) `devos-test`'s value and (b) `devos`'s value, each in each place. The planted value: (p1) to (p5). |
| **Negative control** | For each credential, each place and each form, the count is 0, recorded as "none found by that method". |
| **Positive control** | The planted value is found, with count 1, in each planted place, by the same step in each job. A 0 for any plant makes the run "could not check" for that place, never "none found". |
| **Break attempt** | Copies of the search step, each with one part removed, are run by the build in a run with the plants present:<br>• it reads only the current trees, not the history: (p2) is not found;<br>• it searches only the plain form: (p5) is not found;<br>• it skips the issue: (p3) is not found;<br>• it skips the logs: (p4) is not found.<br>Each must turn the test red, because a plant is missing. The copies run in a workflow run that holds no credential and names no environment, for example the pull-request checks. The planted value is passed in place of the secret, and the copies run the search step's own code, read as in T-W03-DEC's interface. They never run with the real secret, and no workflow other than `migrate.yml` names an environment (M04). |
| **Stage and environment** | C02, at the first scheduled runs after the workflow merges (P7: a scheduled run receives the secret).<br>• Where: the scheduled jobs on GitHub; their logs are the raw output.<br>• Who runs: the jobs themselves. The build producer plants and removes the fixtures and collects the counts.<br>• Probes relied on: P7; P8, which reads whether the job's token can read every ref, including pull-request refs (if not, those refs are "could not check" for this method). |
| **Independence level** | Written by the test designer. Run by the job, which is its own output. Assessed by the fresh-context checker of point 13 from the logs. Shared: model lineage, design record. |
| **Evidence layer** | Structural, observed live. The search method's coverage is shown by the plants, not assumed. |
| **Evidence envelope** | As in the README.<br>• `observations_ref`: the two jobs' run IDs and their count lines.<br>• `inputs_ref`: the plants' branch, commits, issue comment and run, with their IDs.<br>• Raw output: counts only, which the job prints. The hygiene check of the README is applied to the copied log lines. |

**What the record states with the result** (from point 9; not a test of its own):
- The documentation that a session has no other route. "Any user with write access to your repository has read access to all secrets configured in your repository" (R5 G1, for repository secrets, which are not used) and environment secrets' reach (R5 G2), quoted with URL and reading date and labelled documented, not independently tested.
- The layers that keep a session from changing what the job runs on `main`: the merge gate's class-high verdict on `.github/workflows/**` and `supabase/migrations/**` (and `tools/**`, if T-W03-DEC's interface (b) is used); the guard; the rule of `main` only once N-175 settles who can change it; and P8's result.
- D-003's residual.
- The ✘ is claimed at that level only.

## Could not check

- A place the step cannot read.
- A plant not found.
- A scheduled run that did not receive the secret (P7). Its "credential present" line is `no`, and the search found nothing because it had nothing to look for.

## Depends on R1 to R6

None.
