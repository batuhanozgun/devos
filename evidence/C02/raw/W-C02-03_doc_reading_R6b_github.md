## Disciplines (D1–D9)
D1: yes: For each event I kept what the documentation states (its `GITHUB_REF`, who can start it) apart from what I infer about whether a `main` rule admits it. The unresolved cases (re-run timing, whether bypass covers branch rules, which apps are installed and with what permissions) are stated conditionally, as matters for the probe.
D2: uncertain: R5 concluded that "the documentation answers" the GitHub side, and that could pull me toward confirming it. So I looked for routes R5 did not name (re-runs, reusable-workflow refs, App installation tokens, other default-branch events), and I report them.
D3: yes: Each section is tied to W-C02-03 points 1 (b), 8, 9 and 14 (b). I made no design choice.
D4: uncertain: Everything here is a documentation reading and is labelled not tested. The byte-identical re-fetches show only that the copies equal today's pages, not that GitHub behaves as the pages say.
D5: yes: I used the earlier run's copies only after re-fetching 17 of them live. I read the REST HTML pages for the per-endpoint token blocks that the article-body view drops, and I report each absence with the search I used.
D6: no
D7: no
D8: yes: Before reading pages I read the work item's body and acceptance block, R5 section 1 and its "Open", and I checked the copies' times and the scratch directory's state.
D9: uncertain: The question is about current vendor behaviour, so I read current primary sources. The library was not read, as the task forbids.

---

# R6b: GitHub-side documentation for W-C02-03 (migration path)

**How and when the pages were read.**
- **Copies.** An earlier run of this session fetched the pages through docs.github.com's article-body API into `/tmp/claude-0/-home-user-devos/0cb29c90-d12e-56b6-9751-2217078b0a90/scratchpad/c02src_r6/pages/`. File modification times, all 2026-10-12 UTC:
  - events 14:55:01Z;
  - manually-run 14:55:24Z;
  - re-run, trigger-a-workflow, disable/enable and reuse-workflows how-to 14:55:25Z;
  - reusable-workflows reference, concurrency how-to, concurrency concept and workflow-syntax 14:55:26Z;
  - REST environments (markdown), REST secrets, REST branch-policies, REST protection-rules and REST repos 14:55:26Z to 14:55:27Z;
  - REST workflows, REST workflow-runs, deployments-and-environments reference, manage-environments and use-secrets 14:55:28Z;
  - fine-grained PAT permissions, GitHub App permissions, secure-use and personal-repository permission levels 14:55:29Z;
  - REST environments HTML 14:56:48Z;
  - review-deployments 14:57:53Z; control-deployments 14:57:54Z; lockfiles 14:58:33Z;
  - managing PATs 15:02:49Z; choosing App permissions 15:02:50Z.
- **Live re-fetches**, by me, through the same API, into `.../scratchpad/c02src_r6b/live/`: 15:12:33Z to 15:12:36Z, 15:13:06Z to 15:13:13Z, and 15:13:58Z. **17 pages are byte-identical to their copies** (`cmp`):
  - events, re-run, reusable-workflows reference, concurrency how-to, workflow-syntax;
  - manage-environments, use-secrets, REST secrets, permission levels, fine-grained PAT permissions, App permissions, choosing App permissions;
  - disable/enable, lockfiles, secure-use, deployments-and-environments reference, REST workflow-runs.

  Each of questions 1 to 5 rests on at least one matched page.
- **REST HTML pages.** The article-body view leaves out each endpoint's fine-grained-token block, so I fetched the REST HTML pages live: environments, branch-policies and secrets. For environments, the four permission lines are the same in the copy and in the live page. Branch-policies and secrets HTML were read live only.
- **Copies used but not re-fetched:** trigger-a-workflow, manually-run, reuse-workflows how-to, concurrency concept, review-deployments, control-deployments, REST workflows, REST repos, REST protection-rules, managing PATs.
- **Content dates.** No page shows a content date. I searched the live files for a "Month D, 2026" phrase and found none. Some files contain year strings, which I did not inspect one by one; they appear to be in example payloads.
- **Shared scratch directory.** A parallel run (the Supabase researcher) wrote files into the same `c02src_r6b/live/` directory between 15:12:43Z and 15:12:47Z. None of its file names is the same as mine, and the times of my files match my fetches.
- **Labels:** [S] the source states it; [I] my interpretation; [Inf] my inference.

## 1. Triggers that can start a job on `main` with an environment's secrets

**The basic rule.** [S] https://docs.github.com/en/actions/reference/workflows-and-actions/deployments-and-environments: "The deployment branch or tag rule is matched against the `GITHUB_REF` of the workflow run." So for each event, what decides admission is its `GITHUB_REF`.

**`workflow_dispatch`** ([S] https://docs.github.com/en/actions/reference/workflows-and-actions/events-that-trigger-workflows)
- [S] `GITHUB_SHA` is "Last commit on the `GITHUB_REF` branch or tag", and `GITHUB_REF` is "Branch or tag that received dispatch".
- [S] "This event will only trigger a workflow run if the workflow file exists on the default branch."
- [S] "Once a workflow has run at least once, you can dispatch it against any branch or tag via the GitHub API or GitHub CLI."
- [S] The manually-run page: "To run a workflow on a branch other than the repository's default branch, use the `--ref` flag."
- **Who** [S]:
  - `POST /repos/{owner}/{repo}/actions/workflows/{workflow_id}/dispatches` needs the "Actions" permission (write) for a fine-grained PAT and for a GitHub App (user and installation tokens).
  - The trigger page says "`workflow_dispatch` and `repository_dispatch` events always create workflow runs", even when `GITHUB_TOKEN` sends them.
  - R5 G5 (about-actions-policies, not re-read here): "By default, every user with write access to a repository can trigger workflows."
- [Inf] A dispatch on `main` runs `main`'s file at `main`'s tip, so a `main` rule admits it. A dispatch against a `claude/` branch runs that branch's file with that branch as `GITHUB_REF`, so a rule naming only `main` refuses it.
- [Inf] Any branch workflow whose `GITHUB_TOKEN` has `actions: write` can dispatch `main`'s workflow, if `main`'s file lists `workflow_dispatch`. That starts the job outside a merge, but only on code already on `main`.
- Not stated: whether the `on:` of the default-branch version or of the dispatched ref's version decides whether a dispatch is accepted.

**`repository_dispatch`**
- [S] `GITHUB_SHA` is "Last commit on default branch" and `GITHUB_REF` is "Default branch". The file must exist on the default branch.
- [S] "By default, all `repository_dispatch` activity types trigger a workflow to run". The sender's `client_payload` is "available in the `github.event` context".
- **Who** [S]: `POST /repos/{owner}/{repo}/dispatches` needs "Contents" (write) for a fine-grained PAT and for an App. "OAuth app tokens and personal access tokens (classic) need the repo scope" (https://docs.github.com/en/rest/repos/repos, copy).
- [Inf] A `main` rule always admits it. Any token with Contents write can start the job, and `client_payload` is untrusted input reaching a job that holds the credential.

**`schedule`**
- [S] Default branch for both values. "Scheduled workflows will only run on the default branch."
- [S] "some queued jobs may be dropped" at high load.
- [S] Nobody triggers it directly. The `actor` is the user who changed the default branch, or the write user whose commit changed the `cron` of a deactivated workflow.
- [Inf] A `main` rule admits it (see also question 4).

**`workflow_run`**
- [S] Default branch for both values.
- [S] "The workflow started by the `workflow_run` event is able to access secrets and write tokens, even if the previous workflow was not."
- [S] "A workflow run is triggered regardless of the conclusion of the previous workflow."
- [S] "The `requested` activity type does not occur when a workflow is re-run."
- [Inf] A `main` workflow on this event that referenced the environment would get the secret after a run of the named workflow, possibly one on a `claude/` branch. I did not read the `branches` filter.

**`workflow_call` (reusable workflows)**
- [S] Both values are "Same as the caller workflow". "the `github` context is always associated with the caller workflow" (https://docs.github.com/en/actions/reference/workflows-and-actions/reusable-workflows).
- [S] Which commit runs (workflow-syntax, `jobs.<job_id>.uses`):
  - With `./` "the called workflow is from the same commit as the caller workflow".
  - With `{owner}/{repo}/...@{ref}` "the `{ref}` can be a SHA, a release tag, or a branch name".
- [S] Environment secrets (https://docs.github.com/en/actions/how-tos/reuse-automations/reuse-workflows, copy):
  - "set `environment` on the job in the reusable workflow. The job that calls the reusable workflow can't use the `environment` keyword."
  - "The caller workflow must still pass the secret."
  - "If the caller workflow doesn't pass an environment secret, the secret resolves to an empty string in the reusable workflow. The workflow run doesn't show an error." The page names `required: true` as the way to make the run fail instead.
- [Inf] A caller on a `claude/` branch that calls `main`'s reusable workflow is refused, because `GITHUB_REF` is the caller's.
- [Inf] **A caller on `main` that calls a reusable workflow `@<branch or tag>` runs that ref's code with `GITHUB_REF` = `main`, and the rule admits it.** Calling with `./` (same commit) or `@<SHA>` avoids this.

**`check_run` / `check_suite`**
- [S] Default branch for both values. The file must exist on the default branch.
- [S] "this event does not trigger workflows if the check suite was created by GitHub Actions or if the check suite's head SHA is associated with GitHub Actions."
- **Who** [S]:
  - Creating check runs and rerequesting check runs or suites needs "Checks" (write), listed for App tokens only (https://docs.github.com/en/rest/authentication/permissions-required-for-github-apps).
  - The fine-grained PAT permissions page has no "Checks" section. I checked its full heading list.
- [Inf] A `main` rule admits these. They are started by a GitHub App with Checks write.

**Other events with `GITHUB_REF` = default branch.** [S] The events page lists, among others:
- `branch_protection_rule`, `delete`;
- `discussion`, `discussion_comment`;
- `fork`, `gollum`;
- `issue_comment`, `issues`, `label`, `milestone`;
- `page_build`, `public`, `status`, `watch`.

[Inf, partly general knowledge, not from a page read here] On a public repository, `fork`, `watch`, `issues` and `issue_comment` can be caused by users without write access. Any of these in the `on:` of a `main` workflow whose job references the environment would start that job with the secret.

**Re-runs** ([S] https://docs.github.com/en/actions/how-tos/manage-workflow-runs/re-run-workflows-and-jobs)
- [S] "Re-runs use the privileges of the actor who initially triggered the workflow, not the privileges of the actor who initiated the re-run. The workflow will also use the same `GITHUB_SHA` (commit SHA) and `GITHUB_REF` (git ref) of the original event".
- [S] A run can be re-run "up to 30 days after its initial run", and "a maximum of 50 times". Debug logging can be turned on for the re-run.
- [S] Who: the `rerun`, `rerun-failed-jobs` and job `rerun` endpoints need "Actions" (write) for a PAT and for an App.
- [S] Reusable workflows called by a non-SHA ref: "Re-running all jobs in a workflow will use the reusable workflow from the specified reference", while re-running failed or specific jobs uses "the same commit SHA of the first attempt".
- [Inf] A re-run runs the workflow file at the original commit with the secret's value at re-run time. Within 30 days, a re-run of an older `main` run could run a weaker, earlier version of the workflow with the current credential.
- **Not stated:** whether the environment's rules are evaluated again at re-run time. [Inf] If they are, a refused `claude/` run would stay refused (its ref is unchanged), unless the rule itself changed in between.

## 2. `concurrency`
- [S] https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-syntax (and the matched concurrency how-to):
  - "there can be at most one running job or workflow in a concurrency group at any time. ... the queued job or workflow will be `pending`. By default, any existing `pending` job or workflow in the same concurrency group will be canceled and the new queued job or workflow will take its place."
  - "To also cancel any currently running job or workflow in the same concurrency group, specify `cancel-in-progress: true`."
- [S] The `queue` property:
  - "`single` (default): At most one job or workflow run can be `pending` ... any existing `pending` job or workflow run in the same group is canceled and replaced."
  - "`max`: Up to 100 jobs or workflow runs can be `pending` ... When the queue is full, any additional jobs or workflow runs are canceled."
  - "The combination of `queue: max` and `cancel-in-progress: true` is not allowed".
- [S] Order and scope:
  - Runs are processed FIFO "according to the time each one started waiting on the concurrency group ... ordering is not guaranteed."
  - Group names are case-insensitive.
  - Groups are shared across workflows: "any previously in-progress or pending job will be canceled, regardless of the workflow."
- **Answer:** yes. With `cancel-in-progress: false` and the default `queue`, a pending run is cancelled when a newer one is queued. `cancel-in-progress` affects only the running one.
- The pages show no preview note for `queue`.
- [Inf] Take merges A, B and C in quick order. A runs, and B is cancelled when C queues. C's checkout of `main` contains B's migration files, so an apply of everything pending covers B, but B's run is recorded "cancelled". `queue: max` keeps each run, but the order is not guaranteed.

## 3. Who can create or change an environment, its secrets, its branch rule and its bypass setting

**Owner-only side** [S]:
- https://docs.github.com/en/actions/how-tos/write-workflows/choose-what-workflows-do/use-secrets: "To create secrets or variables for an environment in a personal account repository, you must be the repository owner."
- https://docs.github.com/en/actions/how-tos/deploy/configure-and-manage-deployments/manage-environments, in both its create and delete sections: "To configure an environment in a personal account repository, you must be the repository owner."
- The same page: "Anyone that can edit workflows in the repository can create environments via a workflow file, but only repository admins can configure the environment."
- https://docs.github.com/en/rest/deployments/protection-rules (custom rules): "The authenticated user must have admin or owner permissions".

**Collaborator side** [S]:
- https://docs.github.com/en/rest/actions/secrets, on all four environment-secret endpoints: "Authenticated users must have collaborator access to a repository to create, update, or read secrets."
- "Get" works "without revealing its encrypted value".
- [I] The same sentence appears on the organization-secret endpoints, where classic tokens need `admin:org`. That suggests it is a generic sentence rather than an environment rule. This weakens the collaborator side but does not settle the contradiction.

**Permission-levels page** (https://docs.github.com/en/account-and-profile/reference/permission-levels-for-a-personal-account-repository): [S] I read the full action lists for owner and collaborator. Neither mentions environments, Actions secrets, branch protection or Actions settings, so this page settles nothing.

**Token permissions** [S], fine-grained PAT and GitHub App alike (live REST HTML and permission tables):

| What | Endpoint | Permission |
|---|---|---|
| Create, update or delete an environment | `PUT`/`DELETE /environments/{name}` | "Administration" (write) |
| List or get environments | `GET` | "Actions" (read) |
| Create, update or delete a deployment branch policy | `.../deployment-branch-policies` | "Administration" (write) |
| List or get branch policies | `GET` | "Actions" (read) |
| Create or delete a custom protection rule | `.../deployment_protection_rules` | "Administration" (write) |
| Create, update or delete an environment secret | `.../secrets/{name}` | "Environments" (write) |
| List or get environment secrets | `GET` | "Environments" (read) |

For classic tokens, the pages say "need the repo scope".

**Admin-bypass setting:**
- [S] The REST "Create or update an environment" documents `wait_timer`, `prevent_self_review`, `reviewers` and `deployment_branch_policy` ("To allow all branches to deploy, set to null").
- [S] The string `can_admins_bypass` does not occur on the live page.
- [S] In the interface, it is "Deselect **Allow administrators to bypass configured protection rules**", inside environment configuration, which is owner-only on a personal repository.
- [Inf] Through the documented API, a token with Administration write can widen the branch rule (`null`), but it is not documented that it can change the bypass setting.

**GitHub App tokens** [S] https://docs.github.com/en/apps/creating-github-apps/registering-a-github-app/choosing-permissions-for-a-github-app:
- "The success of an API request with an installation access token only depends on the app's permissions."
- A user access token depends "on the user's permissions as well as the app's permissions".
- When an App's permissions change, "the owner of each account where the app was installed will be prompted to approve the new permissions."
- [Inf] The owner-only rule does not bind an installation token. An App installed on `devos` with Environments write could overwrite the secret, and one with Administration write could widen or delete the environment. Which Apps are installed, with which permissions, is not documentation; it is something to inspect.

**Other facts** [S]:
- A workflow that references a non-existent environment creates it "without any protection rules or secrets configured".
- "Deleting an environment will delete all secrets and protection rules".
- On Free, making the repository private means "any configured protection rules or environment secrets will be ignored".

## 4. Scheduled workflows in a public repository
- [S] The events page and the matched disable/enable page (https://docs.github.com/en/actions/how-tos/manage-workflow-runs/disable-and-enable-workflows): "In a public repository, scheduled workflows are automatically disabled when no repository activity has occurred in 60 days." Also: "When a public repository is forked, scheduled workflows are disabled by default."
- **What counts as "repository activity": not stated.**
- **Re-enabling** [S]:
  - the Actions tab;
  - `gh workflow enable WORKFLOW`;
  - `PUT /repos/{owner}/{repo}/actions/workflows/{workflow_id}/enable` ("Actions" write);
  - and: "if a user with `write` permissions to the repository makes a commit that changes the `cron` schedule on the workflow, the workflow will be reactivated".
- **Environment secrets:** [S] `GITHUB_REF` is the default branch, and the rule is matched on `GITHUB_REF`. [Inf] A `schedule` job on `main` that references the environment is admitted by a `main` rule and gets its secrets. This is not stated in one sentence and is for the probe.

## 5. Pinning and hardening
- [S] https://docs.github.com/en/actions/reference/security/secure-use:
  - "The best measure is to **lock your workflow dependencies** with a lockfile ... supersedes SHA pinning for repositories that adopt it."
  - Otherwise, "Pin actions to a full-length commit SHA ... verify it is from the action's repository and not a repository fork."
  - A tag "can be moved or deleted".
  - A compromised action "would have access to all secrets configured on your repository".
  - CODEOWNERS on `.github/workflows` is suggested.
- [S] https://docs.github.com/en/actions/concepts/security/workflow-dependency-lockfiles:
  - "Workflow dependency lockfiles are in public preview and subject to change."
  - The file is `.github/workflows/actions.lock`, made by the `gh actions-lock` extension and "should never be edited by hand".
  - It covers transitive dependencies "**except** for dependencies of reusable workflow calls".
  - It records `owner_id`/`repo_id` "to confirm at run time that the repository behind the name is still the one you locked".
  - "SHA pinning within workflow files is **no longer necessary**" once it is adopted.
- [Inf] It pins actions, not binaries that an action downloads (for example a CLI version).
- [S] `permissions` (workflow-syntax):
  - "If you specify the access for any of these permissions, all of those that are not specified are set to `none`."
  - `permissions: {}` turns off all permissions.
  - Job-level `jobs.<job_id>.permissions` exists.
  - Under `pull_request_target`, `GITHUB_TOKEN` gets read/write "even when it is triggered from a public fork".
- [S] Secure-use recommends a default of read-only contents.
- [S] Reusable workflows: without `permissions` on the calling job, the called workflow gets the defaults, and permissions "can be only downgraded".

## Costs flagged
- [S] "Environments, environment secrets, and deployment protection rules are available in public repositories for all current GitHub plans" (REST environments). The bypass toggle, required reviewers and wait timers are public-only on Free. **No cost while `devos` is public.**
- [S] If `devos` became private on Free, protection rules and environment secrets are ignored. Pro or Team would then be needed, and that is a decision for Batu.
- Lockfile (public preview) and `queue: max`: no price is stated.

## Open
- **For the probe:**
  - whether a re-run takes the environment's rules and workflow as they stand now;
  - that a dispatch against a `claude/` branch is refused;
  - whether admin bypass covers branch rules (review-deployments speaks only of "deployment protection rules" on "Pending" jobs);
  - G8 by REST (machine account, Claude App);
  - the installed Apps' Administration, Environments, Actions, Contents and Checks permissions (an inspection, not documentation);
  - which version's `on:` governs a dispatch to a branch;
  - what counts as "activity".
- **Not read:** about-actions-policies (R5's quote is used); `workflow_run` `branches` filter; the `GITHUB_TOKEN` tutorial; rulesets; the lock-workflow-dependencies how-to; using-SHAs; REST check-runs pages; the check_run webhook payloads.
- **Counter-evidence looked for and not found:** that re-runs re-evaluate rules or use the current workflow; that admins can bypass a branch rule; a REST field for bypass; an environments row on the permission-levels page; a preview label on `queue`.

## For the decision
- **What the documentation settles:**
  - Admission depends only on `GITHUB_REF`. So the events that can start a job holding the credential are the `on:` events of every `main` workflow whose job references the environment, plus re-runs (30 days, original SHA, ref and actor) and, if listed, dispatches.
  - Unmerged code reaches the secret only through a `main` caller that uses a non-SHA external ref.
  - The concurrency semantics and the per-endpoint token permissions are documented.
  - An App installation token is bound only by the App's permissions.
- **What stays open:** G8's contradiction stays open; the App-permission inspection is a new way to settle it. Also open: bypass over branch rules, and when a re-run evaluates the rules.
- **For point 14 (b):** dispatch, `repository_dispatch` and re-runs are non-merge routes onto `main`'s or older code. The design either leaves them out of `on:`, or shows they apply nothing unmerged.

## Guard denials
None. One deviation: a single read-only Bash comparison loop used shell variables for paths, against this task's limit. The guard allowed it, and I used literal paths after that.
