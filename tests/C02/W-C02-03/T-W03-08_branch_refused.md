# T-W03-08 · A workflow run for a branch other than `main` is refused the credential

**Synthetic test data** (plan Section 8 item 13): the probe workflow `.github/workflows/w03-fixture-branch-probe.yml` exists only on a `claude/` branch and is never merged. It is made up for this test, and its first line labels it synthetic. Its only step prints `credential present: yes` or `credential present: no`, computed from whether `SUPABASE_DB_PASSWORD` is non-empty. It never prints the value, its length or any part of it.

**Serves.** W-C02-03 point 8, and the branch half of C02's Acceptance line "✘ The migration credential cannot be read by an agent session, nor by a workflow run for a branch other than `main`." Point 8 asks: "✘ A workflow that references the credential is pushed to a `claude/` branch, and the job is started from that branch by a push, by a pull request, and by any other event point 1 (b) names. Each run is refused the credential, observed from the run's status and from a step that reports only whether it is present. Positive control: the run on `main` gets it and applies." It also serves EV-C02-001 section 3's event table and section 10, "Point 8".

## The probe workflow

It has two jobs: `probe-devos-test`, with environment `migrate-devos-test`, and `probe-devos`, with environment `migrate-devos`. Each job's single step:
- puts `SUPABASE_DB_PASSWORD: ${{ secrets.SUPABASE_DB_PASSWORD }}` in its `env` only;
- writes the presence line;
- runs no other command (no network, no database, no shell tracing).

`on:` lists `push`, `pull_request`, `workflow_dispatch`, and those default-branch events of section 3's table that a session can cause cheaply (`issue_comment` on a fixture issue). It holds `permissions: {}`.

## Attempts, one at a time

These are minimal and explicit; each is recorded as the system checking its own safety property, never as a sweep (D-017 item 2 (b); D-020).

| # | Event | Expected | Observed from |
|---|---|---|---|
| a | push of the probe workflow to `claude/w03-branch-probe` | Each job is refused by the environment's deployment-branch rule (GitHub's protection-rule message), and the presence step does not run, or prints `no` | the run's jobs and their status and annotations; the step's log |
| b | a pull request from that branch to `main` (opened and closed unmerged) | The run's `GITHUB_REF` is `refs/pull/N/merge`; it is refused as in (a) | the same, for the PR's run |
| c | `workflow_dispatch` against the branch | Refused as in (a) (`GITHUB_REF` is the branch) | the same |
| d | re-run of the refused run of (a) | Refused again (P6 records whether the rules are evaluated again) | the re-run's attempt number and status |
| e | re-run of H1-prime's own push run of `migrate.yml` on `main` (the run that applied T-W03-05's fixture), after a later merge has made its commit no longer the head, and after S2's search ends (T-W03-09's windows: no run of `migrate.yml` is re-run from H1-prime's merge to the end of S2's search). H1-prime's commit carries the gate of step `tokens_revoke` on the head check, so no step of that run holds the secret past the head check. A re-run of a run made before H1-prime is not this attempt: in that workflow `tokens_revoke` runs in every case with `PGPASSWORD` in its environment (EV-C02-007 section 13) | It ends at the head check (M05) before any step receives the secret: in each job the head check says "superseded", and every step whose `env` names a secret (`presence`, `connect`, `listing`, `dryrun`, `apply`, `compare`, `dbtests`, `tokens`, `dbprograms`, `tokens_revoke` in `devos-test`; `presence`, `connect`, `listing`, `compare`, `dryrun`, `apply`, `compare_after` in `devos`) concludes skipped; the presence step does not run | the re-run's attempt number, its commit (H1-prime's merge commit, which must hold the gated `tokens_revoke`), each job's steps and their conclusions, and each job's log, in which no step's environment block shows a masked secret (`***`). That a re-run uses the workflow file of the original run's commit is recalled from GitHub's documentation, not re-read: the commit and the log above show which file ran |
| f | `issue_comment` on a fixture issue labelled synthetic | No run of the branch's probe workflow, because default-branch events read the workflow files of `main` [doc R6b 1]; `main`'s `migrate.yml` does not list the event (M22) | the Actions run list filtered by the probe workflow, at and after the comment's time |
| g | the other default-branch events of section 3's table (`repository_dispatch`, `workflow_run`, `check_run`, `check_suite`, `pull_request_target`, `schedule`, `issues`, `fork`, `watch`, `label`, …) | Not attempted one by one. Covered by the documentation [doc R6b 1, read 2026-10-12] and by M22's static check that no workflow on `main` naming an environment lists them. Labelled documented, not independently tested | M22's check output at the build's head |

**Positive control.** T-W03-05's run on `main` (H1-prime's push run): each job prints `credential present: yes` and its apply succeeds. Run 38316669047 (the first migration applied to both projects, "credential present: yes" in both jobs) is recorded as supporting evidence, not as this control.

**Afterwards.**
- The pull request is closed unmerged, and the fixture issue is closed. The branch is deleted by whoever can: the guard refuses a session's branch deletion, and whether a GitHub tool can delete it is not known; otherwise it is left to Batu, batched with another step of his, and the record names it as left.
- The record lists every run ID made by the attempts.
- If any attempt prints `yes`, the test fails. No further attempt is made, and the executor treats it as the credential reached by a branch run: Batu resets the password (M30). This is his one-off step, asked in Appendix E §7's form.

## Form C0

| Field | Content |
|---|---|
| **ID and claim** | T-W03-08. No run whose `GITHUB_REF` is not `main` receives either environment's secret, whatever event starts it. The run on `main` receives it. |
| **Failure class rule** | A job that is not a push run at `main`'s head gets the migration credential. Examples of this family: a branch push run; a pull-request run (merge ref); a dispatch against a branch; a re-run of a refused run; a re-run of an older `main` run; a default-branch event running unreviewed code. |
| **Examples** | (a) to (f) live; (g) by documentation and the static check. |
| **Negative control** | Each of (a) to (e) is refused or ends before the secret, and (f) starts no probe run. |
| **Positive control** | The `main` push run prints `yes` and applies (T-W03-05, H1-prime's push run). Without it, a "refused everywhere" result could come from a missing or empty secret. So if the positive control has not run, the negative results are "could not check". Run 38316669047 is supporting evidence only. |
| **Break attempt** | The refusal is GitHub's, and the test is sensitive to its removal. If the environment's branch rule were absent or admitted the branch, (a) would print `yes`, and the test would turn red on that line.<br>This cannot be planted without widening the rule, which would expose the credential. So the break is shown on a third, synthetic environment: `w03-fixture-unprotected`. It is created by Batu with no branch rule and a secret holding a synthetic non-secret value, `w03-fixture-not-a-credential`. The same probe step, pointed at it from the branch, must print `yes`. The environment is deleted after.<br>That creation is a one-off owner step, since on a personal-account repository only the owner configures environments (R6b 3). It is asked only batched with another step of Batu's, never on its own. If it is not made, the break is "could not check", and the record says that the test's sensitivity rests on the positive control and on the documentation (R5 G2, G3). |
| **Stage and environment** | C02, after Batu's step 1 and after the workflow's merge (M29); (e) after H1-prime, a later merge, and the end of S2's search (T-W03-09).<br>• Where: GitHub's run record of the `devos` repository.<br>• Who runs (README, "Who runs, who judges"): the executor makes every attempt (the pushes, the pull request, the dispatch, the re-runs, the comment) and reads each run's record and job logs, saved unedited; a prober analyses the saved records and logs; the probe workflow's file is written by a producer, never by the test designer. P8 reads whether a session's GitHub credential can push a file under `.github/workflows/`. If it cannot, that part needs another pusher, or is "could not check", recorded as a further layer, not as a pass.<br>• Probes relied on: P6 (re-runs), P7 (scheduled runs on `main` receive the secret), P8 (who can push a workflow file; Apps' permissions). |
| **Independence level** | Written by the test designer. Attempts made, and records and logs saved, by the executor; the refusal is GitHub's; the saved records analysed by a prober (fresh-context subagent, declared). Assessed by the fresh-context checker of point 13 from the saved run records, not from the executor's or the prober's account. Shared: model lineage, design record. |
| **Evidence layer** | Structural, observed live: the platform's refusal, as GitHub records it. |
| **Evidence envelope** | As in the README.<br>• `target_commit`: the probe branch's head for (a) to (d); for (e), H1-prime's merge commit, which the re-run ran.<br>• `deployment_config_ref`: the probe workflow's blob SHA and `migrate.yml`'s blob SHA on `main`.<br>• `observations_ref`: each run ID, attempt number, job status and message, and the presence line or its absence. |

## Could not check

- Any attempt the session cannot make (P8).
- (f) if no probe run list can be read.
- The break if the synthetic environment is not created.
- Everything, if the positive control has not run.

## What it does not cover

- A session reading the credential. That is T-W03-09.
- A change to what `main` runs. That is bounded by the merge gate, the guard, and the rule of `main` once N-175 settles it (T-W03-09; point 9).
- An App or account able to widen the branch rule. That is P8, and recorded as not shown if found.

## Depends on R1 to R6

None. R5 (the step text's recovery notes) changes how Batu enters the secret, not this test.
