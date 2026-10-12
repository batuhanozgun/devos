# C02 source map R5: platform documentation

## Disciplines (D1–D9)
D1: yes: I kept six documented credential and token forms as alternatives, each with what it can reach, and I marked as inference wherever a conclusion joins statements from two vendors.
D2: yes: I did not let the plan's example ("a database role that can only apply migrations") steer the reading; I report that no such role is documented and that Supabase's own CI example grants more than migrations.
D3: yes: each fact is tied to the plan mark it serves (C02 task 0, C02's acceptance lines, the 6.3 header, task 7), with whether it settles the mark or stays for C02's probe; I made no design choice.
D4: uncertain: every fact is labelled as a documentation reading, not tested, and the two places where the documentation contradicts itself are named so this reading is not taken as verification.
D5: yes: I read raw page text fetched to scratch, checked EV-C01-002's 22 quotes from S1 one by one against today's page, used search summaries only to find URLs, and list the pages I could not reach.
D6: no
D7: no
D8: yes: before the web reading I read plan 6.2, 6.3, 6.7 and C02, PC-21 item 4, EV-C01-002, EV-C01-004, and N-131 (with its 2026-10-12 addition) and N-136, and treated their "next" statements as context, not instructions.
D9: uncertain: the question is about current vendor behaviour, so I read current primary sources (D9 item 4); the library was not read, as the task forbids, and whether it holds anything relevant is left open.

**How the pages were read.** All on 2026-10-12, 12:58Z to 13:08Z. GitHub pages came through the article-body API of docs.github.com; Supabase pages as `.md` from supabase.com/docs; Claude Code pages as `.md` from code.claude.com/docs. **None of the pages shows a content date.** The Last-Modified header equals the request time, so it is not a content date. Copies are in `/tmp/claude-0/-home-user-devos/0cb29c90-d12e-56b6-9751-2217078b0a90/scratchpad/c02src_r5/pages/`. Labels: **[S]** the source states it; **[I]** my interpretation; **[Inf]** my inference.

## 1. GitHub Actions secrets and environments

**G1. A repository secret cannot be limited to one workflow, job or branch.** [S]
- https://docs.github.com/en/actions/reference/security/secure-use: "Any user with write access to your repository has read access to all secrets configured in your repository."
- https://docs.github.com/en/actions/how-tos/write-workflows/choose-what-workflows-do/use-secrets: forks are the only exception ("With the exception of `GITHUB_TOKEN`, secrets are not passed to the runner when a workflow is triggered from a forked repository"). On a personal-account repository, any collaborator can create repository secrets.
- [Inf] The machine account has write access, and sessions push as that account. So a session can push a branch whose workflow uses a repository secret.
- **Settles:** a repository secret cannot meet C02's acceptance line "cannot be read … by a workflow run for a branch other than `main`".

**G2. An environment secret reaches only jobs that reference the environment, and only after its rules pass.** [S]
- https://docs.github.com/en/actions/reference/workflows-and-actions/deployments-and-environments: "Secrets stored in an environment are only available to workflow jobs that reference the environment."
- https://docs.github.com/en/actions/concepts/workflows-and-actions/deployment-environments: "Any protection rules configured for the environment must pass before a job referencing the environment is sent to a runner. The job can access the environment's secrets only after the job is sent to a runner."
- **Settles at documentation level:** "only this job" means "only jobs, in workflows on an allowed branch, that reference the environment". [Inf] Those workflows sit under `.github/workflows/`, which is already a high-impact path.

**G3. Limiting the secret to `main`: the "Selected branches and tags" rule.** [S] (same reference page)
- "The deployment branch or tag rule is matched against the `GITHUB_REF` of the workflow run."
- "Adding another branch rule for `refs/pull/*/merge` would also allow workflows triggered by `pull_request` events to deploy to the environment."
- The "Protected branches only" option has a catch: "If no branch protection rules are defined for any branch in the repository, then all branches can deploy." Whether a ruleset counts as a protection rule here is not stated.
- [Inf] A single branch rule `main` refuses runs for other branches and `pull_request` runs (whose ref is `refs/pull/N/merge`). It is the safer choice over "Protected branches only".
- **Leaves to C02's probe:** the acceptance line itself.

**G4. Events that run with `GITHUB_REF` = `main`.** [S]
- https://docs.github.com/en/actions/reference/workflows-and-actions/events-that-trigger-workflows gives `GITHUB_REF` as "Default branch" for `pull_request_target` and `workflow_run`.
- For `workflow_dispatch`: "Once a workflow has run at least once, you can dispatch it against any branch or tag via the GitHub API or GitHub CLI." Also: "This event will only trigger a workflow run if the workflow file exists on the default branch."
- [Inf] A `main`-only rule also admits these events, but only for workflow files on `main`. So the design rule is that no workflow on `main` references the migration environment from `pull_request_target` or `workflow_run`.
- [Inf] Any write user can dispatch `main`'s job again. That should be harmless, because `db push` skips migrations already applied (S3).

**G5. `pull_request_target` matters only if a workflow on `main` uses it.**
- [S] https://docs.github.com/en/actions/reference/security/securely-using-pull_request_target: such a job "receives the base repository's `GITHUB_TOKEN` and access to repository and organization secrets".
- [S, new and dated on the page] "GitHub provides a default event policy that blocks the `pull_request_target` event in public repositories." It "Currently runs in **evaluate** mode"; "On November 2, 2026, GitHub will enforce the default policy".
- [S] https://docs.github.com/en/actions/concepts/about-actions-policies: repository-level actor and event rules exist; "By default, every user with write access to a repository can trigger workflows."
- Whether Actions policies are available on a Free personal-account repository is not stated.

**G6. Forks.** [S] The events page says "The `GITHUB_TOKEN` has read-only permissions in pull requests from forked repositories." The reference page adds that runs from "forks with branches that match the protected branch name cannot deploy to the environment."
- **Settles** the fork question.

**G7. Required reviewers and administrator bypass.** [S] (reference page)
- "Only one of the required reviewers needs to approve the job"; self-review can be prevented.
- "By default, administrators can bypass the protection rules"; the environment can instead be set to "disallow bypassing the protection rules for all deployments".
- [Inf] Required reviewers would add a click from Batu on every merge, which conflicts with criterion 21. Disallowing bypass costs nothing.

**G8. Who can change environment secrets: the documentation contradicts itself.**
- [S] The use-secrets page: "To create secrets or variables for an environment in a personal account repository, you must be the repository owner."
- [S] The managing-environments page (https://docs.github.com/en/actions/how-tos/deploy/configure-and-manage-deployments/manage-environments): the same for configuring an environment.
- [S] But the REST page https://docs.github.com/en/rest/actions/secrets, "Create or update an environment secret", says: "Authenticated users must have collaborator access to a repository to create, update, or read secrets."
- [Inf] Overwriting a secret does not reveal it, but it could redirect or break the migration job.
- **Leaves to C02's probe and row 12 (N-175).**

**G9. Hardening the job itself.** [S] The secure-use page:
- A compromised action "would have access to all secrets configured on your repository". It recommends a workflow dependency lockfile, or else pinning actions "to a full-length commit SHA".
- Self-hosted runners "should almost never be used for public repositories".
- Database connection strings and JWTs are redacted from logs automatically, but "redaction is not guaranteed" (https://docs.github.com/en/actions/reference/security/secrets).

## 2. Supabase migrations from CI

**S1. Supabase's documented CI path.** [S] https://supabase.com/docs/guides/deployment/managing-environments
- A job on push to `main` runs `supabase link --project-ref $SUPABASE_PROJECT_ID`, then `supabase db push`, with `SUPABASE_ACCESS_TOKEN`, `SUPABASE_DB_PASSWORD` and `SUPABASE_PROJECT_ID`.
- "`SUPABASE_ACCESS_TOKEN` is a scoped personal access token limited to the projects this workflow deploys to." "grant the token **Project Settings**, **API Keys**, and **API Key Secrets**, all with **Read** access."
- [I] The example stores these as plain repository secrets (which G1 rules out here) and uses `setup-cli` with `version: latest`, unpinned.

**S2. Pushing without `link`.** [S] CLI reference (https://supabase.com/docs/reference/cli/supabase-db-push; the page shows no version):
- `db push --db-url` "Pushes to the database specified by the connection string (must be percent-encoded)". `migration up` has the same flag.
- But `db push` "Requires your local project to be linked … For self-hosted databases, you can pass in the connection parameters using --db-url flag."
- **Leaves to the probe:** whether `--db-url` works against a hosted project without `link`.

**S3. Migration history.** [S] (same page) "a migration history table will be created under supabase_migrations.schema_migrations … Subsequent pushes will skip migrations that have already been applied."
- [I] This is a ready record for 6.2's comparison function.
- [S] https://supabase.com/docs/guides/deployment/database-migrations: "Coordinate so only one person runs `db push` at a time." [Inf] So the job needs a concurrency group.

**S4. Scoped tokens, and how far they reach.** [S] https://supabase.com/docs/guides/platform/personal-access-tokens
- Classic tokens "carry your account's full access … and on every one you create or join in the future".
- Scoped tokens "only ever narrow what your account can already do".
- "Database commands that connect with your database password, such as `supabase db push` with `SUPABASE_DB_PASSWORD` set, aren't limited by the token's permissions."
- The permission "API Key Secrets (Read)" unlocks "Get project API keys". The permission "Migrations (Read-write)" unlocks "Apply a migration" and "Rollback migrations".
- [S] https://supabase.com/docs/guides/getting-started/api-keys: secret keys "provide full access to your project's data, bypassing Row Level Security".
- [Inf] Supabase's own CI path therefore gives the job a token that can read the project's secret key, which is more than migrations.

**S5. What the database password can do.** [S]
- https://supabase.com/docs/guides/database/postgres/roles: the project password is "the password for the `postgres` role", which "has admin privileges". The page also says: "we recommend that you create a new user for every service".
- CLI reference: `db reset --linked/--db-url` runs "a SQL script … to identify and drop all user created entities in the remote database". `migration down --db-url` also exists.

**S6. A role that can only apply migrations is not documented.** [S]
- Custom login roles are documented ("create role … with login password"). Through the shared pooler, "the username is `[ROLE].[PROJECT-REF]`" (https://supabase.com/docs/guides/database/connecting-to-postgres).
- Objects created by a custom role may need `grant "custom_role" to "postgres"` (managing-environments, troubleshooting).
- "Superuser access is not given" (https://supabase.com/docs/guides/database/postgres/roles-superuser).
- [Inf] A migration is arbitrary SQL, so a role that can apply DevOS's migrations holds whatever they need (creating roles, security-definer functions, grants). "Only migrations" can then be bounded only by what the job runs, which is reviewed code on `main`, not by the role itself.
- **Leaves to C02's design and probe.**

**S7. Network: use the session pooler.** [S]
- https://supabase.com/docs/guides/platform/ipv4-address names "GitHub Actions" among services that "only accept IPv4 connections". The IPv4 add-on is "(Pro Plans+) … paid".
- The connecting page: on Free the direct connection is IPv6-only; "The shared pooler is IPv4-only on every plan"; session mode supports everything a direct connection does.
- CLI `link` has `--skip-pooler`, "Use direct connection instead of pooler" [I: so `link` uses the pooler by default].
- **Settles:** the CI job connects through the session pooler, port 5432, at no cost.

**S8. An alternative the plan does not list: Supabase's own GitHub integration.** [S]
- https://supabase.com/docs/guides/deployment/branching: "You can deploy directly from GitHub on any plan — connect your repository and changes pushed to `main` are automatically deployed to your project."
- https://supabase.com/docs/guides/deployment/branching/github-integration: "Deploy to production" applies new migrations and also deploys Edge Functions and storage buckets declared in `config.toml`. It "watches all commits, branches, and pull requests". Batu authorizes it on GitHub.
- [Inf] No migration credential would sit in GitHub at all. The comparison function would still need its own job.
- Not read: whether two projects can deploy from one repository, and what the optional preview branches cost.

**S9. Other routes.**
- The Management API's "Apply a migration" endpoint, with a Migrations-only scoped token: its reference page was not reachable (404 on `.md`). Which role runs the SQL, and whether it writes the CLI's history table, was not read.
- A token-less OIDC route was not found in one search. [Absence in a search; not a statement.]

**S10. Free-plan facts that bear on the job.** [S]
- https://supabase.com/docs/guides/platform/free-project-pausing: "Supabase pauses Free Plan projects that show low activity over a 7-day period." A paused project can be restored for up to 1 year. Paid plans are not paused.
- https://supabase.com/docs/guides/platform/billing-on-supabase: "You are granted two free projects."
- [Inf] An idle `devos-test` makes the job fail. It fails closed and the comparison detects it, but resuming the project is a step for Batu.

**S11. One more Batu step.** [S] https://supabase.com/docs/guides/api/using-custom-schemas: to expose a custom schema such as `devos_api`, you "add your custom schema to 'Exposed schemas'" in the dashboard API settings.
- [Inf] This is a dashboard setting, not a migration, so it becomes a Batu step (or a token with Data API Config write). The page's sample `GRANT ALL … TO anon` does not suit DevOS.

## 3. Supabase per-request role switching

**R1. A custom header reaches the database: documented.** [S] https://supabase.com/docs/guides/api/securing-your-api
- `current_setting('request.headers', true)::json->>'user-agent'` is the documented read.
- The page's own pattern, "Use additional API keys", is exactly 6.3's design: a pre-request function reads `current_setting('request.headers', true)::json->>'x-app-api-key'` and checks it against a table. "The `apikey` header is mandatory and not configurable. If you use another API key, distribute both the publishable key and your application's custom key."
- Limit: "`pgrst.db_pre_request` … only works with the **Data API** (PostgREST). It does not work with Realtime, Storage, or other Supabase products."
- **Settles the Supabase side of EV-C01-002 section 2 item 3 and EV-C01-004 S5 at documentation level** (Data API only).
- [Inf] The joined claim, that a network secret sent in a custom header reaches `request.headers` inside a `devos_api` function, rests on two vendors' documents and stays for C02's probe.
- Header-name case is ambiguous: the sample output shows "User-Agent" while the code uses lowercase keys. Probe it.

**R2. `request.jwt.claims` vs `request.jwt`: the page contradicts itself.** [S] The example reads `current_setting('request.jwt.claims', true)::json->>'role'`, but the table lists the setting as `request.jwt` ("JSON object of the JWT payload"). Probe which one holds.

**R3. Switching roles through the JWT `role` claim.** [S]
- Roles page: `authenticator` validates a JWT "and then 'change into' another role determined by the JWT verification".
- https://supabase.com/docs/guides/auth/jwts: `role` is "The Postgres role to use when applying Row Level Security policies."
- https://supabase.com/docs/guides/auth/signing-keys: you can mint your own JWTs by importing a private key. `role` "must be set to an existing Postgres role in your database, such as `anon`, `authenticated`, or `service_role`"; "`exp` must be set … Prefer shorter-lived tokens". The token goes in `Authorization: Bearer`, and "A separate `apikey` header is required".
- [Inf] This is an alternative token form. It matches a network secret's default Bearer type, and PostgREST would switch to a DevOS role class per request.
- Its costs: revocation only by rotating the signing key (which affects every token), a forced expiry, and someone has to hold the private key. The plan's token-plus-hash allows revoking one token at a time.
- Not stated: that a custom role works, or which grants to `authenticator` it needs.

**R4. Logging.** [S] https://supabase.com/docs/guides/observability/log-field-reference: "API Gateway logs capture only the headers below. Other headers still reach the application and client but are omitted from these logs." The list includes `user-agent` and `x-client-info`; it includes neither `authorization` nor any custom header.
- The same page says Postgres statement text and error details can appear in Postgres logs. [Inf] So no function may return or raise the header's value.
- Side note for C06, not C02: pg_net's queued request headers are readable by any role that can use pg_net (Supabase troubleshooting page).

## 4. Claude Code cloud environments

Pages: https://code.claude.com/docs/en/cloud-environments (S1), …/claude-code-on-the-web (S2) and …/routines (S3), all undated. The changelog's newest entry is still 2.1.296 (October 9, 2026), the same release EV-C01-004 recorded.

- **C1. The page has not changed in substance.** All 22 quotes EV-C01-002 takes from S1 are on today's page: 20 word for word, 2 differing only by link or bold markup. The secret passage now reads "…wouldn't otherwise allow them, except the hosts that never get the secret". Every S2 and S3 quote checked is present word for word.
- **C2. Text that EV-C01-002 did not record.** I cannot tell whether it is new or was simply not quoted.
  - A requirement: "if your organization uses customer-managed encryption keys, you can't save network secrets" (does not apply to Batu's Max account).
  - A **Not sent** marker on secrets that are not being attached.
  - Credential types other than Bearer.
  - The telemetry export added to the requests that never get a secret.
  - S3: "on Pro and Max plans, store keys for the APIs Claude calls during a run as network secrets instead".
- **C3. A session cannot read a network secret, by the documentation's words.** [S] "give sessions a key they can't read"; "the key doesn't appear in the session's environment variables or in any file"; "the key itself stays outside the VM"; S2 says secrets "stay outside the sandbox".
  - [Inf] A session can still *use* the secret on every request to the listed host, so it holds the role's authority. If any endpoint ever echoed the header (R4), the session could read it.
- **C4. Network.** The Trusted list still names no Supabase domain. A secret's hosts are reachable at every level. Both stated.

## 5. Paid features

| Item | Free for `batuhanozgun/devos` (public, personal account), Supabase Free, Claude Max? | Source |
|---|---|---|
| Environments, environment secrets, deployment branches, required reviewers, disallowing admin bypass | Yes. "If you are using GitHub Free, environment secrets are only available in public repositories." If the repository goes private, "any configured protection rules or environment secrets will be ignored" | GitHub reference and managing-environments pages |
| Actions minutes | "free for standard GitHub-hosted runners in public repositories"; "Larger runners are always charged for" | docs.github.com billing for GitHub Actions |
| Actions policies | "Evaluate" mode is Enterprise Cloud only; availability on Free is not stated | control-workflow-execution page |
| Supabase CLI, scoped tokens, session pooler, deploying from GitHub | No charge named; "deploy directly from GitHub on any plan" | pages above |
| Supabase IPv4 add-on; Pro plan to stop pausing | Paid | S7, S10 |
| Claude network secrets | "available on Pro and Max plans"; no charge named. Cloud sessions "share rate limits with all other Claude and Claude Code usage within your account" | S1, S2 |

## Costs flagged
1. **Supabase IPv4 add-on** (paid, Pro or higher). Not needed if the job uses the session pooler (S7).
2. **Supabase Pro**, only if Free-plan pausing of `devos-test` or `devos` (S10) is to be avoided by paying rather than by activity.
3. **Supabase Branching preview branches**, if "Automatic branching" is turned on with the GitHub integration (S8). I did not read its cost.
4. **GitHub larger runners** (always charged), and **GitHub Pro**, which would be needed only if `devos` became private.
5. Third-party deployment-protection services (named examples include Datadog). Not needed.

The documented core path needs no paid feature: an environment secret limited to `main`, a standard runner, the session pooler, and a network secret on Max. Any of the items above goes to Batu as his decision.

## Open
- **For C02's probe:**
  - G3 and G4: a run on another branch, and a `pull_request` run, get no environment secret.
  - G8: can the machine account or the Claude GitHub App write environment secrets or branch policies through the REST API?
  - S2 and S6: `db push --db-url` against the hosted project through the pooler with a custom login role, and whether that role can be given what DevOS's migrations need (for example creating roles).
  - R1 and R2: does the network-secret header reach `request.headers`, in which case, and which of `request.jwt` or `request.jwt.claims` holds?
  - R3: does a custom role work in the JWT `role` claim (only if that form is considered)?
  - S11: the exposed-schemas step.
- **Not read:**
  - Supabase Management API reference pages (404 on `.md`), the access-control page beyond fetching it, the pricing pages, and the branching cost.
  - GitHub's "review deployments" and workflow-dependency-lockfile pages.
  - The research library (excluded by the task).
  - I fetched `supabase.com/llms.txt`, which is outside `/docs`, as an index only; none of its content is used here.
- **Counter-evidence looked for and not found:**
  - a GitHub statement that a repository secret can be scoped per job or branch;
  - a Supabase statement of a migration-only role;
  - a Claude statement that a session can read a network secret.

## For the decision
- **GitHub side of C02 task 0:** the documentation answers it. The secret goes in an environment with a "Selected branches" rule of `main` and administrator bypass disallowed, and no workflow on `main` references it from `pull_request_target` or `workflow_run`. A repository secret fails the acceptance line by the documentation alone. G8's contradiction stays open.
- **Supabase side:** no "migration-only" role exists in the documentation. Every documented credential that applies migrations can do more:
  - the `postgres` password can drop every object you created;
  - the scoped token in Supabase's own example can read the secret key;
  - a custom role holds whatever the migrations need.

  C02 picks among these, or S8's credential-free route, and states which bound it relies on.
- **6.3's token design:** the Supabase half (a custom header beside the publishable key) is now documented; the joined path is C02's probe. R3 is a documented alternative token form for N-131 to weigh.
- **Batu's steps for task 0 and task 7** grow by:
  - creating the GitHub environment or environments, which on a personal-account repository only the owner can do;
  - per project: the credential, the pooler connection string, and the exposed-schemas setting.

## Guard denials
One, rule G0 (decision #13572): an escaped backtick in a `grep` pattern made the command unreadable to the guard. I repeated the call without backticks, as its "What to do instead" says. I did not record it with `tools/guard_report.py` because my role writes nothing; the executor records it.

**Sources:**
- [GitHub: Secrets](https://docs.github.com/en/actions/concepts/security/secrets), [Using secrets](https://docs.github.com/en/actions/how-tos/write-workflows/choose-what-workflows-do/use-secrets), [Secrets reference](https://docs.github.com/en/actions/reference/security/secrets), [Secure use](https://docs.github.com/en/actions/reference/security/secure-use)
- [GitHub: Deployments and environments](https://docs.github.com/en/actions/reference/workflows-and-actions/deployments-and-environments), [Managing environments](https://docs.github.com/en/actions/how-tos/deploy/configure-and-manage-deployments/manage-environments), [Deployment environments](https://docs.github.com/en/actions/concepts/workflows-and-actions/deployment-environments)
- [GitHub: Events that trigger workflows](https://docs.github.com/en/actions/reference/workflows-and-actions/events-that-trigger-workflows), [Securely using pull_request_target](https://docs.github.com/en/actions/reference/security/securely-using-pull_request_target), [About Actions policies](https://docs.github.com/en/actions/concepts/about-actions-policies), [Controlling workflow execution](https://docs.github.com/en/actions/how-tos/administer/control-workflow-execution)
- [GitHub: plans](https://docs.github.com/en/get-started/learning-about-github/githubs-plans), [Actions billing](https://docs.github.com/en/billing/concepts/product-billing/github-actions), [REST: Actions secrets](https://docs.github.com/en/rest/actions/secrets), [Personal-repository permissions](https://docs.github.com/en/account-and-profile/reference/permission-levels-for-a-personal-account-repository)
- [Supabase: Managing environments](https://supabase.com/docs/guides/deployment/managing-environments), [Personal access tokens](https://supabase.com/docs/guides/platform/personal-access-tokens), [CLI reference](https://supabase.com/docs/reference/cli/supabase-db-push), [Database migrations](https://supabase.com/docs/guides/deployment/database-migrations)
- [Supabase: Postgres roles](https://supabase.com/docs/guides/database/postgres/roles), [Superuser](https://supabase.com/docs/guides/database/postgres/roles-superuser), [Connecting to Postgres](https://supabase.com/docs/guides/database/connecting-to-postgres), [IPv4 address](https://supabase.com/docs/guides/platform/ipv4-address)
- [Supabase: Branching](https://supabase.com/docs/guides/deployment/branching), [GitHub integration](https://supabase.com/docs/guides/deployment/branching/github-integration), [Project pausing](https://supabase.com/docs/guides/platform/free-project-pausing), [Billing](https://supabase.com/docs/guides/platform/billing-on-supabase), [Custom schemas](https://supabase.com/docs/guides/api/using-custom-schemas)
- [Supabase: Securing your API](https://supabase.com/docs/guides/api/securing-your-api), [API keys](https://supabase.com/docs/guides/getting-started/api-keys), [JWTs](https://supabase.com/docs/guides/auth/jwts), [Signing keys](https://supabase.com/docs/guides/auth/signing-keys), [Log field reference](https://supabase.com/docs/guides/observability/log-field-reference), [pg_net headers](https://supabase.com/docs/guides/troubleshooting/database-roles-can-read-request-headers-queued-by-pg_net-ad6357)
- [Claude Code: Cloud environments](https://code.claude.com/docs/en/cloud-environments), [Claude Code in the cloud](https://code.claude.com/docs/en/claude-code-on-the-web), [Routines](https://code.claude.com/docs/en/routines), [Changelog](https://code.claude.com/docs/en/changelog)
