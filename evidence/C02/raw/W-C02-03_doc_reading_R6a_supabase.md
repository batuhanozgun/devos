## Disciplines (D1–D9)
D1: yes: I kept the four credential routes (Supabase's GitHub integration, a CLI job holding the password, the Management API with a scoped token, and the API's short-lived CLI login role) side by side, and I labelled each step from "not stated" to a conclusion as an inference.
D2: yes: the earlier run's copies and the turn budget did not stand in for checking; I compared copies byte for byte with live pages and reported where the documentation is silent instead of filling the gap with likely behaviour.
D3: yes: each finding is tied to W-C02-03 point 1 (a) to (d) or point 14 (b) and (d), and I made no design choice.
D4: uncertain: everything below is a documentation reading, labelled as not tested; the WebFetch results are model summaries, so I relied on byte comparison where I could and say where I could not.
D5: yes: I checked every copy for error pages (5 were Next.js error pages, 3 were "Redirecting…" or "Not Found"), re-fetched copies live, and used `llms-full.txt` only as an index, naming the page each quote comes from.
D6: no
D7: no
D8: yes: before reading I read W-C02-03's body, its acceptance points 1 and 14, and R5 sections 2, "Costs flagged" and "Open", and I treated the earlier run's copies as an unchecked hand-over until re-fetched.
D9: uncertain: the question is about current vendor behaviour, so I read current primary sources (D9 item 4); the library was not read, as the task forbids, and whether it holds anything relevant stays open.

**How the pages were read.**
- **Copies.** These were fetched by an earlier run of this session into `/tmp/claude-0/-home-user-devos/0cb29c90-d12e-56b6-9751-2217078b0a90/scratchpad/c02src_r6/pages/` on 2026-10-12. File modification times (UTC):
  - 14:50: github-integration, branching, troubleshooting, working-with-branches, configuration, free-project-pausing, manage-your-usage/branching.
  - 14:51: going-into-prod.
  - 14:52: `supabase.com_openapi.json` (its source URL was not recorded).
  - 14:53: personal-access-tokens.
  - 14:54: access-control, billing-faq.
  - 14:58: CLI reference (`.txt` extracted from HTML), `sb_setup-cli_README.md` (source not recorded; presumably the supabase/setup-cli README).
  - 14:59: functions/deploy, roles, roles-superuser.
  - 15:00: connecting-to-postgres, `sb_llms-full.txt`.
  - 15:02: Management API reference pages (`.txt` from HTML).
  - 15:05: PostgreSQL role-attributes and CREATE ROLE (PostgreSQL 18 docs).
  - 15:06: the two troubleshooting pages.
  - 15:07: cli-workflows.
- **Unusable copies.** These are error pages, not content: `branching-via-github`, `integrations/github`, `fair-use-policy`, `project-pausing` and `local-development-workflow`. `database-advisors`, `local-development/overview` and `llms_guides_database` say only "Redirecting…", and `llms_full.txt` says "Not Found".
- **Live re-fetch.** 2026-10-12, 15:12:43Z to 15:12:47Z, as `.md` with curl into a new scratch directory `c02src_r6b/live/`. **All 13 matched their copies byte for byte:** github-integration, branching, branching/troubleshooting, working-with-branches, going-into-prod (Q1); personal-access-tokens (Q2); functions/deploy (Q3); free-project-pausing (Q4); connecting-to-postgres, cli-workflows, the cli_login_postgres troubleshooting page (Q5); roles, roles-superuser (Q6). `fair-use-policy.md` returned 404 live as well.
- **WebFetch.** About 15:13Z to 15:16Z (exact times not recorded): Management API "apply a migration" and "list all functions", CLI `db push`, supabase.com/aup and supabase.com/terms. Their quoted fields agree with the copies, but WebFetch returns a summary, so this is not a byte comparison.
- **Content dates.**
  - The `.md` pages show none.
  - The GitHub-OAuth troubleshooting page (HTML copy) shows "Last edited: 10/12/2026".
  - The AUP shows "Version 1 — June 1, 2026".
  - The terms show no date.
  - The CLI reference shows no CLI version.
- **Labels.** [S] the source states it; [I] my interpretation; [Inf] my inference.

## 1. Supabase's GitHub integration (R5 S8)

**1.1 Plan.**
- [S] "You can deploy directly from GitHub on any plan — connect your repository and changes pushed to `main` are automatically deployed to your project. Branching takes this further, adding isolated preview environments for each pull request." (https://supabase.com/docs/guides/deployment/branching)
- [S] "Deploy to production" and "Automatic branching" are separate options in the integration settings (https://supabase.com/docs/guides/deployment/branching/github-integration).
- [S] The production checklist says: "If you're on the Pro Plan, consider enabling branching" (https://supabase.com/docs/guides/deployment/going-into-prod).
- [Inf] Production deploys do not need Branching. Whether a Free organization can create preview branches at all is not stated in what I read.
- [S] Preview branches: "There is no fixed fee for a Preview branch… A branch running on the default Micro Compute size starts at $0.01344 per hour", and "Branches are **not** covered by the Spend Cap" (https://supabase.com/docs/guides/platform/manage-your-usage/branching).

**1.2 Two projects on one repository; one waiting for the other.**
- Not stated. I looked in every branching page I had, in llms-full, and in two web searches; nothing says whether one repository can be connected to `devos-test` and `devos` at once.
- [S] The connection is set per project ("Choose a GitHub repository to connect your project to"; Organization settings list "every project in the organization that is connected to a GitHub repository", https://supabase.com/docs/guides/troubleshooting/managing-or-disconnecting-github-oauth-connections-e3dc3b). [Inf] Several projects connected to one repository is not ruled out, but it is not documented either.
- No ordering or waiting mechanism between two projects' integrations is documented.
- [S] "You cannot change which project branch serves as the production branch… However, you can update which GitHub branch is linked to your production branch" (https://supabase.com/docs/guides/deployment/branching/troubleshooting). [Inf] An order would have to come from outside, for example `devos` following a different Git branch that something advances only after `devos-test` succeeds. Who can push that branch then becomes the credential question.
- [S] Persistent branches with `[remotes.<name>] project_id` ("Each remote configuration must reference an existing project ID… must reference an existing branch") are branches of one project created with `supabase --experimental branches create --persistent` (https://supabase.com/docs/guides/deployment/branching/configuration). [I] This does not connect a second, independent project.

**1.3 Failure during a deploy.**
- [S] "Branching runs each migration file inside a single transaction and does not honor the `-- pg-delta: transaction=false` directive" (github-integration page).
- [S] "If a parent deployment step fails, all dependent child steps will be skipped. For instance, if your database migrations failed at step 5, our runner will not seed your branch… If you are using GitHub integration, the same deployment workflow will be run on every commit pushed to your git branch." The steps are Clone, Pull, Health, Configure, Migrate, Seed, Deploy (Edge Functions), as a DAG (https://supabase.com/docs/guides/deployment/branching).
- [S] The troubleshooting page's checklist for failed migrations includes "Verify the migration doesn't require superuser privileges".
- [Inf] A failed file rolls back; earlier files in the same run are probably committed. The next commit to `main` re-runs the workflow, which is the only retry the documentation describes. Not stated:
  - whether earlier files stay applied;
  - whether Edge Function deploy depends on Migrate in the DAG;
  - any explicit retry control. A Management API "Update action run status" endpoint exists, but its meaning is not described.

**1.4 History table.**
- Not stated by name for the integration.
- [S] Branching applies "only the migrations that haven't been applied yet"; "The preview branch inherits the migration history of your base project"; "If… your migration history was initialized by Supabase Branching or the Supabase CLI"; the documented fix is `supabase migration repair --status applied` on the base project (https://supabase.com/docs/guides/deployment/branching/working-with-branches).
- [Inf] The integration and the CLI share the base project's history table, `supabase_migrations.schema_migrations`.

**1.5 Triggers.**
- [S] "Supabase watches all commits, branches, and pull requests of your GitHub repository."
- [S] "Deploy to production… automatically deploy[s] changes when you push or merge to production branch." Deployed: new migrations, and Edge Functions and storage buckets declared in `config.toml`; "All other configurations… are ignored by default."
- [S] With Automatic branching, "When a new branch is created in GitHub, a corresponding branch is created in Supabase", and a branch's "database schema is not cloned" (github-integration page).
- [Inf] Pull requests and other Git branches reach preview branches, not the production project. That nothing else reaches production is not stated as a guarantee.
- [S] Other documented routes to production:
  - "When you merge any branch into your main project, Supabase automatically runs a deployment workflow to deploy your changes to production" (branching page; this includes dashboard merges when Branching is used);
  - the Management API's "Merge a branch" and "Push a branch" endpoints are listed (API reference index, copy);
  - Owner and Admin can change which Git branch is production.

**1.6 Who authorizes, and the app's access.**
- [S] The project's Integrations page has "Authorize GitHub", then the GitHub page "Authorize Supabase", then a repository is chosen (github-integration page).
- [S] "you authorize the GitHub OAuth app so Supabase can read your repositories" (OAuth troubleshooting page).
- [S] Access control, organization level: "Authorize GitHub" and "Add GitHub Repositories" are allowed for Owner and Administrator, not for Developer or Read-Only. Project level: "GitHub Connections – Create/Update" is Owner and Admin only (https://supabase.com/docs/guides/platform/access-control).
- The GitHub App's permission list is **not stated** in the Supabase pages read, and a search found nothing. [Inf] The documented pull-request comments ("A comment is added to your PR with the deployment status of your preview branch") and the "Supabase Preview" check used in Supabase's examples imply write access to pull requests and checks. That is inferred from behaviour, not a stated permission.

**1.7 Where a result can be read.**
- [S] Management API "List all action runs", `GET /v1/projects/{ref}/actions`: OAuth scope `environment:read`, fine-grained permission `action_runs_read` ("Action Runs – Read" for scoped tokens). The response includes `run_steps` (name and status) and `check_run_id`. "Get action run" and "Get action run logs" also exist (API reference copy; personal-access-tokens page).
- [S] Webhook notifications: "when an action run completes on a persistent branch" (working-with-branches).
- [S] Pull-request comments and email notifications for preview branches; a "required check" is recommended for the integration on pull requests (github-integration page).
- [Inf] A GitHub workflow can poll action runs with a scoped token. The database itself records only the history rows (1.4). Not stated: whether production deploys appear in action runs, and whether a production deploy posts a GitHub check run.

## 2. Management API

**2.1 Apply a migration.**
- [S] `POST /v1/projects/{ref}/database/migrations`; OAuth scope `database:write`; fine-grained permission `database_migrations_write` ("Migrations – Read-write"). Body: `query` (required), `name`, `rollback` (https://supabase.com/docs/reference/api/v1-apply-a-migration).
- [S] The OpenAPI copy also lists an optional `Idempotency-Key` header: "A unique key to ensure the same migration is tracked only once." The live HTML page does not show it.
- [S] "Migrations – Read-write" also unlocks "Rollback migrations", "Patch a migration" and "Upsert a migration" (https://supabase.com/docs/guides/platform/personal-access-tokens).
- **Not stated:** which database role runs the SQL, and whether it writes `supabase_migrations.schema_migrations`. The live page says neither (WebFetch at about 15:14Z).
- [Inf] The same path's `GET` ("List applied migration versions", `database_migrations_read`, returns `version` and `name`) and "Fetch an existing entry from migration history" (fields `version`, `name`, `statements`, `rollback`, `created_by`, `idempotency_key`) show that the API keeps a migration history. That it is the CLI's table is a likely inference, for the probe.
- [S] Other endpoints:
  - "Run a sql query as supabase_read_only_user", `POST …/database/query/read-only`: "Beta", experimental, permission `database_read`.
  - "Run a query", `POST …/database/query`: experimental; listed under Database **Read** and **Read-write**. Its body has a `read_only` flag.

**2.2 Edge Functions with versions.**
- [S] `GET /v1/projects/{ref}/functions`: "Returns all functions you've previously added to the specified project." OAuth scope `edge_functions:read`, permission `edge_functions_read` ("Edge Functions – Read"). The response fields include `slug`, `status`, `version`, `created_at`, `updated_at`, `ezbr_sha256` (https://supabase.com/docs/reference/api/v1-list-all-functions).
- **Not stated:** what `version` means.
- [S] "Edge Functions – Read" also unlocks "Get a function body".

**2.3 Token form.**
- [S] Scoped personal access tokens: "Scoped tokens carry only the organizations, projects, and permissions you choose", and they are recommended "especially [for] AI agents, automation scripts, and CI environments" (personal-access-tokens page).
- [Inf] Such a token is tied to the creating account's own access (R5 S4).

**2.4 A short-lived database login (relevant to point 1 (a)).**
- [S] OpenAPI copy: `POST /v1/projects/{ref}/cli/login-role`, "Create a login role for CLI with temporary password", experimental and Beta, permission `database_write`. The body is `read_only` (boolean); the response has `role`, `password`, `ttl_seconds`. A `DELETE` endpoint removes these roles.
- [S] `cli_login_postgres` is "A temporary role automatically created by the Supabase CLI to allow administrative access for tasks like migrations"; these roles "are typically set to expire within a few hundred seconds"; "Even when logged in as the `postgres` user, you lack the administrative authority to remove this specific role" (https://supabase.com/docs/guides/troubleshooting/permission-denied-when-deleting-the-cli_login_postgres-role-808bae).
- [Inf] The stored secret would be a scoped token with Database read-write rather than the database password. That token can also "Run a query", so it is no narrower in what it can do. The temporary database credential would be short-lived.

## 3. Reading deployed Edge Function versions
- [S] Only through the Management API (2.2) or the CLI. The CLI command is `supabase functions list`: "List all Functions in the linked Supabase project", with `--project-ref` (CLI reference).
- [S] Supabase's CI example for functions uses an access token from a secret (https://supabase.com/docs/guides/functions/deploy).
- **No SQL-visible record of deployed function versions** turned up in the pages read or in llms-full. The `supabase_functions` schema that appears there concerns database webhooks. [Absence in my search; not a statement.]
- [Inf] A comparison run inside the database would need either an input from a CI job holding an "Edge Functions – Read" token, or a token stored in the database and called through `pg_net`. The second is not documented for this purpose, and it would put a Management API credential where `postgres` can read it.

## 4. Keeping a Free project active
- [S] "A Free plan project is considered inactive if it does not receive sufficient user database activity over the past week… While you may be actively using the project, it's possible that usage is not enough… Typically a few user requests to the database each day over the previous week is enough to keep the project from being paused." (https://supabase.com/docs/guides/platform/free-project-pausing, matched live)
- [S] After the warning email ("roughly one week before the pause"), the pause can be prevented by visiting the project in the dashboard or by "making API calls to your project or sending requests via your connected application". The warning goes to the project owner.
- A **scheduled daily query from CI** is not named. [I] "A few user requests to the database each day" covers a scheduled job that sends several queries a day, but "sufficient" is not quantified. Not stated: whether a job running inside the project (`pg_cron`) counts as "user" activity.
- **Terms and fair use:**
  - The AUP (https://supabase.com/aup, "Version 1 — June 1, 2026") has no sentence on keep-alive traffic, pausing or Free-plan use. Its nearest items are bans on bypassing "IP-based rate limits" through proxies and on denial-of-service flooding.
  - The terms (https://supabase.com/terms, undated) have none either. §2(e) is a general temporary-suspension clause.
  - The billing FAQ's fair-use section lists quota overrun, overdue invoices and expired cards, with restrictions possible "without prior notice" for "suspected abuse" (https://supabase.com/docs/guides/platform/billing-faq).
  - `guides/platform/fair-use-policy` was not reachable (404).
- **Restoring:**
  - [S] "You can restore a paused project for up to 1 year after it was paused" via "**Resume project**"; "The project will return to its previous state, including data and configurations."
  - [S] Project "Pause" and "Restore" are allowed for Owner and Admin, not Developer (access-control).
  - [S] The Management API has "Restore a project" under "Project Settings – Read-write", alongside "Pause a project" and "Delete a project" (personal-access-tokens page).
  - A cost for restoring is not stated.
  - [S] "Projects under a paid plan cannot be paused"; the production checklist says "Upgrade to Pro to guarantee that we won't pause your project for inactivity".

## 5. Supabase CLI in CI
- **Role.**
  - [S] "Shared pooler connections use `postgres.[PROJECT-REF]`. If you connect as a custom role through the shared pooler, the username is `[ROLE].[PROJECT-REF]`." (connecting-to-postgres, matched)
  - [S] "By providing the password, the CLI authenticates directly as the `postgres` user rather than provisioning a temporary `cli_login_postgres` role." (cli_login_postgres troubleshooting page)
  - [I] With the `postgres` user, `db push --db-url` acts as `postgres`.
- **`link` and `--db-url`.**
  - [S] `db push` "Requires your local project to be linked… For self-hosted databases, you can pass in the connection parameters using `--db-url` flag." `--db-url`: "Pushes to the database specified by the connection string (must be percent-encoded)." (https://supabase.com/docs/reference/cli/supabase-db-push, live WebFetch agrees)
  - Counter-evidence to "self-hosted only": Supabase's own pages use `--db-url` against hosted projects for `db pull`: "Pull your database changes using `supabase db pull`… look for the Session pooler connection string" (github-integration page), and "When connecting with `--db-url` for `db pull` or `db diff`… on an IPv4-only network use the session pooler" (https://supabase.com/docs/guides/local-development/cli-workflows).
  - [Inf] `db push --db-url` against a hosted project without `link` is probable, but not stated. This is left for the probe.
- **History and failure.**
  - [S] "After successfully applying a migration, a new row will be inserted into the migration history table with timestamp as its unique id."
  - [S] "`db reset`, `db push`, and `migration up` honor [the directive] by running the file's statements without a wrapping transaction… Without a wrapping transaction, a failed statement leaves the earlier statements in the file applied." (cli-workflows)
  - [Inf] By default each file runs in a transaction, and a failed file gets no history row. Whether `db push` stops at the first failed file is not stated.
- **`migration list`.**
  - [S] "Lists migration history in both local and remote databases… remote migrations are tracked in supabase_migrations.schema_migrations table. Only the timestamps are compared to identify any differences." It has `--db-url`, `--linked` and `-p` (CLI reference).
  - [I] It does not compare file contents.
- **`--dry-run`.** [S] "Print the migrations that would be applied, but don't actually apply them."
- **`--include-roles`.** [S] "Include custom roles from supabase/roles.sql."
- **Concurrency.** [S] "Coordinate so only one person runs `db push` at a time" (https://supabase.com/docs/guides/deployment/database-migrations).
- **`supabase/setup-cli`** (README copy, not re-fetched):
  - [S] The usage shows `supabase/setup-cli@v3`. "If `version` is omitted, the action checks the repository root for `bun.lock`, `pnpm-lock.yaml`, or `package-lock.json`… If the lockfile includes package integrity metadata, the action verifies it… If no supported lockfile is present, it falls back to `latest`." A fixed npm version such as `version: 2.84.2` is accepted.
  - Pinning the action by full commit SHA is not mentioned. That is a GitHub mechanism, left to the parallel GitHub reading.
  - [Inf] Two pins are needed: the action (by SHA) and the CLI (a fixed `version` or a lockfile with integrity).

## 6. Custom roles on hosted Supabase
- **Supabase.**
  - [S] "Superuser access is not given as it allows destructive operations to be performed on the database… additional privileges are granted to the `postgres` user to allow it to run some operations that are normally restricted to superusers." Unsupported: `COPY … FROM PROGRAM`, `ALTER USER … WITH SUPERUSER` (https://supabase.com/docs/guides/database/postgres/roles-superuser, matched).
  - [S] "The Supabase `postgres` role is intentionally not a superuser, and extension creation is gated by `supautils`" (the "Custom Postgres Extensions" page, found through llms-full; URL not confirmed).
  - [S] "`realtime.messages` is owned by an internal role… The `postgres` role is not a member of it and is not a superuser." `supautils` "lets `postgres` run `create policy`… on a fixed list of tables it does not own… `ALTER TABLE` is still refused" (https://supabase.com/docs/guides/troubleshooting/realtime-must-be-owner-of-table-messages, through llms-full).
  - [S] `postgres` "has admin privileges"; "create role "role_name" with login password …"; "we recommend that you create a new user for every service"; dashboard queries "execute as `postgres`" (https://supabase.com/docs/guides/database/postgres/roles, matched).
  - [S] Remote `db reset`: "Since Postgres roles are cluster level entities, any custom roles created through the dashboard or supabase/roles.sql will not be deleted."
- **Not stated by Supabase:**
  - whether `postgres` holds `CREATEROLE`;
  - whether it can create a role `WITH CREATEROLE`;
  - whether it can hand ownership of a schema to a custom role.
  - [Inf] `postgres` can run `CREATE ROLE`, so it has `CREATEROLE` or equivalent through `supautils`.
- **PostgreSQL** (PostgreSQL 18 docs, copies at 15:05, not re-fetched; https://www.postgresql.org/docs/current/role-attributes.html and …/sql-createrole.html):
  - [S] "You must have CREATEROLE privilege or be a database superuser to use this command."
  - [S] "A role with CREATEROLE privilege can alter and drop roles which have been granted to the CREATEROLE user with the ADMIN option. Such a grant occurs automatically when a CREATEROLE user that is not a superuser creates a new role."
  - [S] "the CREATEROLE user can gain access to the created role by simply granting that role back to themselves… is a safeguard against accidents, not a security feature."
  - [S] CREATEROLE cannot create SUPERUSER or REPLICATION roles, nor grant BYPASSRLS. "Only superuser roles or roles with CREATEDB can specify CREATEDB."
  - The pages I read do not say who may specify CREATEROLE for a new role.
- [Inf] A custom migration role with `CREATEROLE` that owns DevOS's schemas is narrower than `postgres`: it does not touch objects it neither owns nor was granted, including Supabase's internal ones. It is not "migrations only". It can create roles, take their privileges, and create security-definer functions in its schemas. Two things were not read and need the probe or more reading:
  - what it needs to create schemas;
  - whether objects it creates need `grant "<role>" to "postgres"` (R5 S6).

## Costs flagged
1. **Preview branches** (Automatic branching): $0.01344 per hour on Micro and up, outside the Spend Cap; whether they are available on Free is not stated. "Deploy to production" does not need them ("any plan").
2. **Persistent branches** (`[remotes]`): part of Branching, billed as branch usage [Inf]. Not needed if two projects are used.
3. **Pro plan** to stop pausing (as in R5).
4. **IPv4 add-on** (as in R5): not needed with the session pooler.
5. **Restoring a paused project**: no cost stated.

None is needed by the documented core paths. Any of them goes to Batu as his decision.

## Open
- **For a probe:**
  - Can one repository be connected to both projects, each deploying `main`?
  - Does a production deploy appear in "List action runs", and does it post a GitHub check run?
  - Does the integration write `supabase_migrations.schema_migrations`? Does Edge Function deploy run after a failed Migrate step?
  - Which role runs "Apply a migration", and does it write the CLI's table? Is `Idempotency-Key` live?
  - Does `db push --db-url` work through the session pooler without `link`?
  - Can `postgres` create a login role `WITH CREATEROLE` that owns a schema, and which PostgreSQL major version do the projects run (CREATEROLE rules differ by version; only version 18's page was read)?
  - What does `version` mean in the function list?
  - Is "Run a query" under Database **Read** forced read-only?
  - Does a scheduled CI query count as "user database activity"?
- **Not read:**
  - the Supabase GitHub App's permission list (GitHub side);
  - `fair-use-policy` (404 in the copy and live);
  - `branching-via-github` and `integrations/github` (error copies, not re-tried);
  - the pricing page;
  - the API pages "Restore a project" and "Create login role" (OpenAPI copy and token table only);
  - setup-cli README live (copy only; not re-fetched, to keep to documentation pages under supabase.com);
  - an older `guides/platform/branching` page that a search summary says still calls branching early access, which may be stale;
  - access-control, configuration and billing-faq were used from copies only.
- **Counter-evidence looked for and not found:**
  - a statement that one repository serves only one project;
  - a statement that production deploy needs Branching or a paid plan;
  - a terms or fair-use statement against keep-alive traffic;
  - a SQL-visible record of function versions;
  - a migration-only role.
- **Found:** `--db-url` used against hosted projects (for `db pull`), against the CLI reference's "self-hosted" wording.

## For the decision
- **Point 1 (a).** The documentation adds a fourth credential form to R5's: a scoped token that mints a short-lived `cli_login_postgres` login. The stored secret is then a token with Database read-write, which can also run arbitrary queries. Every form still acts as `postgres` or as an unstated role (API apply). A custom `CREATEROLE` role is bounded by ownership, not by purpose. The integration keeps the migration credential out of GitHub, but its bound becomes a GitHub OAuth grant plus the Owner/Admin settings of each project.
- **Point 1 (c).** A record of applied migrations exists in `supabase_migrations.schema_migrations` (CLI, stated; integration, inferred). Deployed function versions are readable only with a Management API token or the CLI (Edge Functions Read), never from SQL as documented. A comparison inside the database therefore needs a CI-supplied input or a token in the database: a design choice the documentation does not settle.
- **Point 1 (d) and 14 (d).** Pausing is documented only as "a few user requests to the database each day"; a scheduled job is plausible but not documented, and no terms forbid it. Restore is Owner/Admin, or a token with Project Settings read-write, which can also delete the project.
- **Point 14 (b) and (d).** The integration offers no documented ordering of `devos-test` before `devos`, and it has documented routes to production other than the merge gate: dashboard branch merges, changing the production Git branch, and the API. A CLI job can express the order and the stop itself. The integration cannot, as documented.
- **Settled by documentation alone:** the integration's per-file transaction and the skipping of later steps on failure; the history row written only after success; the session-pooler username form; `postgres` is not a superuser.

## Guard denials
None.

My own deviation, which the guard did not deny: three read-only Bash commands looped over file names with a shell variable (`for f in …; "$f"`), against the task's "never a variable for a path". After I noticed, I used literal paths only. No command used backticks. I wrote only into the session scratchpad (`c02src_r6b/live/`) and nothing in `/home/user/devos`.

**Sources:**
- [Branching](https://supabase.com/docs/guides/deployment/branching), [GitHub integration](https://supabase.com/docs/guides/deployment/branching/github-integration.md), [Branching troubleshooting](https://supabase.com/docs/guides/deployment/branching/troubleshooting), [Working with branches](https://supabase.com/docs/guides/deployment/branching/working-with-branches), [Branching configuration](https://supabase.com/docs/guides/deployment/branching/configuration), [Branching usage](https://supabase.com/docs/guides/platform/manage-your-usage/branching), [Production checklist](https://supabase.com/docs/guides/deployment/going-into-prod), [GitHub OAuth troubleshooting](https://supabase.com/docs/guides/troubleshooting/managing-or-disconnecting-github-oauth-connections-e3dc3b), [Access control](https://supabase.com/docs/guides/platform/access-control)
- [Apply a migration](https://supabase.com/docs/reference/api/v1-apply-a-migration), [List all functions](https://supabase.com/docs/reference/api/v1-list-all-functions), [Personal access tokens](https://supabase.com/docs/guides/platform/personal-access-tokens), [Functions deploy](https://supabase.com/docs/guides/functions/deploy)
- [Free project pausing](https://supabase.com/docs/guides/platform/free-project-pausing), [Billing FAQ](https://supabase.com/docs/guides/platform/billing-faq), [AUP](https://supabase.com/aup), [Terms](https://supabase.com/terms)
- [CLI db push](https://supabase.com/docs/reference/cli/supabase-db-push), [CLI workflows](https://supabase.com/docs/guides/local-development/cli-workflows), [Connecting to Postgres](https://supabase.com/docs/guides/database/connecting-to-postgres), [cli_login_postgres troubleshooting](https://supabase.com/docs/guides/troubleshooting/permission-denied-when-deleting-the-cli_login_postgres-role-808bae), [Database migrations](https://supabase.com/docs/guides/deployment/database-migrations)
- [Roles](https://supabase.com/docs/guides/database/postgres/roles), [Roles, superuser](https://supabase.com/docs/guides/database/postgres/roles-superuser), [Realtime owner troubleshooting](https://supabase.com/docs/guides/troubleshooting/realtime-must-be-owner-of-table-messages), [PostgreSQL role attributes](https://www.postgresql.org/docs/current/role-attributes.html), [PostgreSQL CREATE ROLE](https://www.postgresql.org/docs/current/sql-createrole.html)
- Search results seen but not used as sources: [older branching page](https://supabase.com/docs/guides/platform/branching), [managing environments](https://supabase.com/docs/guides/deployment/managing-environments.md), [environments blog](https://supabase.com/blog/the-vibe-coders-guide-to-supabase-environments.md)
