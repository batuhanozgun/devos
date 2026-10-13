# T-W03-08 attempts (a) to (d) and (f), 2026-10-13: GitHub's run records

Copied by the executor from the responses of the session's GitHub tools (`actions_get get_workflow_run`, `actions_list list_workflow_runs` and `list_workflow_jobs`, `actions_get get_workflow_job`, `get_check_run`, `get_job_logs`, `issue_read get_comments`), field for field; the JSON objects below are the responses' own text, cut to the run and job objects named. Nothing else is added except the headings and the lines marked "executor:".

Probe branch `claude/w03-branch-probe`, head `6683a8b2f0c4ffe54ceb008170d3df860d91452f` (one commit on `d33c8e9`: `.github/workflows/w03-fixture-branch-probe.yml`, written by producer `a3c1922e1393e3161`). Workflow ID 382943938.

## (a) push of the probe branch (executor: `git push -u origin claude/w03-branch-probe` at about 07:36:20Z)

Run, first read (07:36Z): `{"id":38363721373,"name":"w03-fixture-branch-probe","run_number":1,"run_attempt":1,"event":"push","status":"waiting","head_branch":"claude/w03-branch-probe","head_sha":"6683a8b2f0c4ffe54ceb008170d3df860d91452f","path":".github/workflows/w03-fixture-branch-probe.yml","created_at":"2026-10-13T07:36:25Z","updated_at":"2026-10-13T07:36:27Z","run_started_at":"2026-10-13T07:36:25Z"}`

Jobs, first read: `[{"id":115183743279,"name":"probe-devos-test","status":"waiting","run_attempt":1,"created_at":"2026-10-13T07:36:26Z","started_at":"2026-10-13T07:36:26Z"},{"id":115183743459,"name":"probe-devos","status":"waiting","run_attempt":1,"created_at":"2026-10-13T07:36:26Z","started_at":"2026-10-13T07:36:26Z"}]`

Run, second read: `{"id":38363721373,"run_number":1,"run_attempt":1,"event":"push","status":"completed","conclusion":"failure","created_at":"2026-10-13T07:36:25Z","updated_at":"2026-10-13T07:36:28Z","run_started_at":"2026-10-13T07:36:25Z"}`

Jobs, second read: `[{"id":115183743279,"name":"probe-devos-test","status":"completed","conclusion":"failure","run_attempt":1,"created_at":"2026-10-13T07:36:26Z","started_at":"2026-10-13T07:36:26Z","completed_at":"2026-10-13T07:36:27Z"},{"id":115183743459,"name":"probe-devos","status":"completed","conclusion":"failure","run_attempt":1,"created_at":"2026-10-13T07:36:26Z","started_at":"2026-10-13T07:36:26Z","completed_at":"2026-10-13T07:36:27Z"}]`

Job 115183743279 (`get_workflow_job`): `{"id":115183743279,"run_id":38363721373,"status":"completed","conclusion":"failure","created_at":"2026-10-13T07:36:26Z","started_at":"2026-10-13T07:36:26Z","completed_at":"2026-10-13T07:36:27Z","name":"probe-devos-test","labels":["ubuntu-24.04"],"runner_id":0,"runner_name":"","runner_group_id":0,"runner_group_name":"","run_attempt":1,"workflow_name":"w03-fixture-branch-probe"}` (no `steps` field in the response).

Check runs 115183743279 and 115183743459 (`get_check_run`): `"conclusion": "failure"`, `"output": {"summary": "", "text": "", "title": ""}`.

Job logs 115183743279 and 115183743459 (`get_job_logs`): `failed to download log content ... HTTP 404` for each.

executor: GitHub's protection-rule message is shown as an annotation on the run's page; the session's GitHub tools return no annotations (the check run's output is empty), so the message's text was not read here.

## (b) pull request #321 from the probe branch to `main` (opened 07:37:18Z, closed unmerged after the reads)

Run: `{"id":38363816211,"name":"w03-fixture-branch-probe","display_title":"T-W03-08 attempt (b): synthetic branch probe; never to be merged","run_number":2,"run_attempt":1,"event":"pull_request","status":"completed","conclusion":"failure","head_branch":"claude/w03-branch-probe","head_sha":"6683a8b2f0c4ffe54ceb008170d3df860d91452f","pull_requests":[321],"created_at":"2026-10-13T07:37:18Z","updated_at":"2026-10-13T07:37:21Z","run_started_at":"2026-10-13T07:37:18Z"}`

Jobs: `[{"id":115184055768,"name":"probe-devos","status":"completed","conclusion":"failure","run_attempt":1,"created_at":"2026-10-13T07:37:19Z","started_at":"2026-10-13T07:37:19Z","completed_at":"2026-10-13T07:37:21Z"},{"id":115184055954,"name":"probe-devos-test","status":"completed","conclusion":"failure","run_attempt":1,"created_at":"2026-10-13T07:37:19Z","started_at":"2026-10-13T07:37:19Z","completed_at":"2026-10-13T07:37:20Z"}]`

The same pull request also started `migration-checks` run 38363816205 (run 26, event `pull_request`, conclusion `failure`; job 115184056302 "migration checks (M15, M16, M22)"); its log is saved unedited as `t_w03_08_pr321_migration-checks_run38363816205_job115184056302.log`. Its M22 step ends `workflow check: FAIL`, naming the probe file: `names an environment (['migrate-devos', 'migrate-devos-test']); only migrate.yml may`; events `pull_request`, `workflow_dispatch`, `issue_comment` ("a workflow naming an environment starts only on push and schedule"); `push must be on branch main only, with no other filter`; and each probe step's `sslmode None, not verify-full` and `root file None, not the pinned one`.

## (c) `workflow_dispatch` of the probe workflow against the branch (07:37:26Z; the tool answered `204 No Content`, "Workflow run has been queued")

Run, first read: `{"id":38363830176,"name":"w03-fixture-branch-probe","display_title":"w03-fixture-branch-probe","run_number":3,"run_attempt":1,"event":"workflow_dispatch","status":"waiting","head_branch":"claude/w03-branch-probe","head_sha":"6683a8b2f0c4ffe54ceb008170d3df860d91452f","created_at":"2026-10-13T07:37:26Z","updated_at":"2026-10-13T07:37:28Z","run_started_at":"2026-10-13T07:37:26Z"}`; later read: `"status":"completed","conclusion":"failure","updated_at":"2026-10-13T07:37:30Z"`.

Jobs: `[{"id":115184106381,"name":"probe-devos-test","status":"completed","conclusion":"failure","run_attempt":1,"created_at":"2026-10-13T07:37:27Z","started_at":"2026-10-13T07:37:27Z","completed_at":"2026-10-13T07:37:29Z"},{"id":115184106632,"name":"probe-devos","status":"completed","conclusion":"failure","run_attempt":1,"created_at":"2026-10-13T07:37:27Z","started_at":"2026-10-13T07:37:27Z","completed_at":"2026-10-13T07:37:29Z"}]`

## (d) re-run of (a)'s run 38363721373 (07:37:38Z; the tool answered `201 Created`, "Workflow run has been queued for re-run")

Run, first read: `{"id":38363721373,"run_number":1,"run_attempt":2,"event":"push","status":"waiting","created_at":"2026-10-13T07:36:25Z","updated_at":"2026-10-13T07:37:40Z","run_started_at":"2026-10-13T07:37:38Z"}`; later read: `"run_attempt":2,"status":"completed","conclusion":"failure","updated_at":"2026-10-13T07:37:51Z"`.

Jobs (filter `all`): attempt 1 as in (a); attempt 2: `[{"id":115184174360,"name":"probe-devos-test","status":"completed","conclusion":"failure","run_attempt":2,"created_at":"2026-10-13T07:37:39Z","started_at":"2026-10-13T07:37:39Z","completed_at":"2026-10-13T07:37:41Z"},{"id":115184174710,"name":"probe-devos","status":"completed","conclusion":"failure","run_attempt":2,"created_at":"2026-10-13T07:37:39Z","started_at":"2026-10-13T07:37:39Z","completed_at":"2026-10-13T07:37:41Z"}]`

## (f) `issue_comment` on fixture issue #322 (created for this attempt, its body labelled synthetic; closed after the reads)

Comment: `{"id":6140709703,"html_url":"https://github.com/batuhanozgun/devos/issues/322#issuecomment-6140709703","created_at":"2026-10-13T07:38:00Z"}`

Probe workflow's run list after the comment (read about 07:38:30Z): `"total_count":3`: runs 38363830176 (`workflow_dispatch`), 38363816211 (`pull_request`), 38363721373 (`push`, attempt 2); none with event `issue_comment`.

Repository-wide run lists filtered by event: `issue_comment`: `{"total_count":0,"workflow_runs":[]}`; `issues`: `{"total_count":0,"workflow_runs":[]}`.

## Further reads, about 07:47Z (after the prober's gaps G5 and G8)

`get_workflow_job` for each of the other seven probe jobs: 115183743459 (`probe-devos`, run 38363721373 attempt 1), 115184055768 and 115184055954 (run 38363816211), 115184106381 and 115184106632 (run 38363830176), 115184174360 and 115184174710 (run 38363721373 attempt 2): each `"status":"completed","conclusion":"failure"`, `"runner_id":0,"runner_name":"","runner_group_id":0,"runner_group_name":""`, no `steps` field; created, started and completed times as above.

`get_job_logs` for 115184055954, 115184106381 and 115184174360: `failed to download log content ... HTTP 404` each.

Blobs (`deployment_config_ref`): the probe workflow `.github/workflows/w03-fixture-branch-probe.yml` at `6683a8b`: `78412f822ca96247af6f08edf76032d47589ef70`; `migrate.yml` on `main` at `1c0dbcf`: `de936c9e7270b94a05c4bbbc2a9355f2efb9d100` (`git ls-tree`).

## Runs on the probe branch (all workflows), read about 07:39Z

`"total_count":4`: 38363830176 (probe, `workflow_dispatch`, failure), 38363816211 (probe, `pull_request`, failure), 38363816205 (`migration-checks`, `pull_request`, failure), 38363721373 (probe, `push`, attempt 2, failure).
