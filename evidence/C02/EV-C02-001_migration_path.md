---
id: EV-C02-001
item: W-C02-03
kind: design
title: "The migration path: credential, GitHub limits, order and stop, records, comparison (W-C02-03, design: points 1 to 4 and 14 (a) to (d))"
date: 2026-10-12
main_at: eba94b1
produced_by: "producer, fresh-context subagent of the working session (same session; declared, Ek A 5.3)"
written: "Written afresh. A first producer's draft of this design was not accepted (its report's discipline answers were out of order; working order section 4 step 4). That draft was read as a hint only; every fact, quote and decision kept from it was checked at its source and is stated here as this record's own."
binding: "evidence/C02/EV-C02-004_reconciliation_decisions.md part 2 (Y-01 to Y-12), as allocations and constraints, not as evidence"
sources:
  - "R5: evidence/C02/raw/W-C02-01_source_map_R5_platform_documentation.md (GitHub, Supabase and Claude Code pages read 2026-10-12, 12:58Z to 13:08Z; no page shows a content date)"
  - "R6a: evidence/C02/raw/W-C02-03_doc_reading_R6a_supabase.md (Supabase pages, copies 14:50Z to 15:07Z, 13 re-fetched live 15:12:43Z to 15:12:47Z and byte-identical; PostgreSQL 18 pages and the setup-cli README are copies only)"
  - "R6b: evidence/C02/raw/W-C02-03_doc_reading_R6b_github.md (GitHub pages, copies 14:55Z to 15:02Z, 17 re-fetched live 15:12Z to 15:14Z and byte-identical; the copies it lists as not re-fetched are copies only)"
  - "OBS: evidence/C02/raw/W-C02-03_devos_observation_20261012T1518Z.md (two read-only queries on devos by the builder's read-only connection, 15:18:10Z and 15:18:13Z; devos-test not reached)"
  - "plan/DevOS_Kurulum_Plani.md and plan/Ek_B_Veri_Modeli.md at main eba94b1; plan/work/W-C02-03.md, W-C02-08.md, C02.md (Batu's steps rows 0, 1, 1a, 4; N-209); N-175 (plan/work/C03.md); N-099 T-65 (plan/work/C09.md); plan/key_inventory.md rows 16, 17, 23, 24; PC-21 item 1; PC-40 (N-209 carried); D-002, D-003, D-019, D-020 and the titles of the later D- records; R1 section 5 item 6; R3 G1, G5, G6, G8; working order sections 7, 8, 10; Appendix E sections 3, 6, 7; tools/merge_gate.py; evidence/C02/raw/W-C02-19_point5_live_tree.md; evidence/C02/checks/CHK-C02-005.md (the near-miss paths)"
claim: "A design. Nothing here is probed. Every GitHub and Supabase behaviour is documented and not independently tested unless labelled observed; the probes of section 10 settle the parts the design relies on."
---

# EV-C02-001 · The migration path (W-C02-03, design)

**What this is.** The design part of W-C02-03 (plan C02 task 0): its acceptance points 1 (a) to (d), 2, 3, 4 (the step text, asked after acceptance) and 14 (a) to (d). For points 5 to 13 and point 14's observation it says what the build will do and observe (section 10), so that the test designer can write the tests in form C0 from it. The plan and Appendix B changes are `plan/decisions/PC-41.md`. New work with candidate status; the research library was not consulted (the question is current vendor behaviour, read from current primary sources by R5, R6a and R6b).

**Labels.** **[obs]** observed, with its record. **[doc]** documented and not independently tested (PC-21 item 9's claim): the reading that quotes it (R5, R6a or R6b, all read 2026-10-12; no page shows a content date unless the reading says so) and the URL the reading gives. **[inf]** inference (this record's, unless a reading's). **[cnc]** could not check. **[design]** a choice made here. **[est]** an estimate, measured at the build. A fact marked "provisional (Pn)" is relied on only after probe Pn; until then it is not counted as verified (W-C02-03 point 1, last paragraph).

**Names** (chosen here; none is secret):
- `.github/workflows/migrate.yml`: the migration workflow, the only workflow that names either environment. Jobs on a push: `devos-test`, then `devos`. Jobs on the schedule: `check-devos-test`, `check-devos`.
- `.github/workflows/migration-checks.yml`: the pull-request checks. They hold no secret.
- GitHub environments `migrate-devos-test` and `migrate-devos`, each holding one secret, `SUPABASE_DB_PASSWORD`.
- `supabase/migrations/<version>_<name>.sql`: the migration files (top level of that directory only). `supabase/migrations/tests/`: the database tests the job runs in `devos-test`.
- `devos_private.function_deployment`: the record of deployed function versions.

## 1. Decision table

| # | Decision | State |
|---|---|---|
| M01 | The credential, per project: the password of Supabase's `postgres` role (the project's database password), used by the Supabase command-line tool (CLI) with `db push --db-url` over the session pooler | Decided. Its use without `supabase link` is provisional (P1); P1's fallback keeps the same credential and Batu's step |
| M02 | Not used: a custom migration role; a Supabase access token minting a short-lived CLI login; Supabase's GitHub integration; the Management API's apply endpoint; a repository secret | Decided, with reopen conditions (section 2) |
| M03 | Kept in two GitHub environments, one per project, each with the deployment-branch rule "Selected branches and tags" = `main` only, administrators' bypass off, no required reviewers, no wait timer, one secret | Decided; the refusal of other branches is observed at the build (point 8) |
| M04 | `migrate.yml` starts on `push` to `main` (applies) and on `schedule` every 6 hours (compares only). No other event. No other workflow names either environment | Decided |
| M05 | Head check: a run applies or connects only if its commit is `main`'s current head; otherwise it ends as "superseded" before any step receives the secret | Decided |
| M06 | Concurrency: one group for `migrate.yml`, `cancel-in-progress: false`, `queue: max` | Decided; provisional (P4), with a fallback (section 5) |
| M07 | Order and stop: `devos-test` apply, comparison, database tests; the `devos` apply only if all three succeeded; `devos`'s comparison runs in every case | Decided (Y-01) |
| M08 | The CLI runs in a working directory the job builds: an empty directory, a configuration the workflow itself writes, and copies of the top-level migration files only. Nothing else under `supabase/` is read | Decided (Y-09); provisional (P1, P2); if the CLI cannot run so, a new item before the first migration merges |
| M09 | The database tests the job runs in `devos-test` live under `supabase/migrations/tests/`, a class-high path today; the CLI never sees them (M08) | Decided; an interface for W-C02-07 (section 12) |
| M10 | The role in Appendix B section 2: a row for Supabase's `postgres` as the migration job holds it; not a DevOS role class | Decided (PC-41) |
| M11 | Record of applied migrations: Supabase's `supabase_migrations.schema_migrations`, written by the CLI | Provisional (P1, P2) |
| M12 | Record of deployed function versions: `devos_private.function_deployment`, created empty by the first migration with `deployment_drift` (Y-11); written by the job from the first Edge Function | Decided; the deploy step is carried by N-230 |
| M13 | `deployment_drift` admits a direct login whose session user is `postgres` before the token check; every other caller passes W-C02-05's token check | Decided (Y-02; PC-41 words B:45, B:387) |
| M14 | `expected` is computed by the caller from a checkout of `main`'s head: each top-level migration file's version and name; each function's slug and source hash | Decided |
| M15 | The pull-request checks: until `devos_ci` exists, they read the migration job's report of its last completed run at `main`'s head; from then, `deployment_drift` on `devos` through `devos_ci`, and the report for `devos-test` | Decided (Y-03) |
| M16 | What a difference or "could not check" stops: the `devos` apply (in the job); a pull request that changes or removes a merged migration file not shown unapplied in both projects; the use of any result read from a project without "no difference" there at that commit. A pull request that only adds migrations, and every other pull request, is not stopped; the check shows the state | Decided |
| M17 | Keeping both projects active: the scheduled runs connect to each project every 6 hours | Provisional (P9); on a pause, a one-off step; a paid plan only if a more frequent schedule fails, as Batu's decision |
| M18 | GitHub's disabling of scheduled workflows after 60 days without repository activity: a stated residual | Decided |
| M19 | Network: the session pooler, port 5432, user `postgres.<project ref>`, no IPv4 add-on | Decided; each project's pooler host found at the build (P3) |
| M20 | Pins: `actions/checkout` by full commit SHA, the only action; the CLI downloaded at a fixed release and checked against a SHA-256 committed in the workflow before any step receives the secret; runner `ubuntu-24.04`; no workflow lockfile | Decided |
| M21 | Inside the job: the secret only in the `env` of steps that connect; its derived forms masked; no shell tracing or CLI debug output; `permissions: {}` at workflow level, each job only what it needs | Decided |
| M22 | A static check of the workflow files in the pull-request checks (which workflows name the environments, their events, their pins, no apply outside push jobs, no workflow calls) | Decided |
| M23 | G8 (who may write the secret): the design does not depend on it; the branch rule and bypass are owner-only by the documentation; installed Apps and the machine account are inspected at the build | Provisional (P8) |
| M24 | No migration and no job calls `issue_env_token` or `revoke_env_token` in `devos`; the job runs no test in `devos` | Decided (Y-04) |
| M25 | The `devos-test` job's test step is the only owner-level path to `devos-test`; C02's database tests, synthetic tokens included, run there after a merge | Decided (Y-05); how the tests run is P10 |
| M26 | Exposing `devos_api` (R5 S11) is not in row 1; it is asked after the first migration, batched with Batu's step 4 | Decided (Y-06) |
| M27 | The probe schema and probe tokens: absence shown by a listing in each project, never a removal | Decided |
| M28 | Cost: none on this path | Decided |
| M29 | Batu's step 1: one sitting for both projects, on issue #6, as soon as this design is accepted; no other work waits on it; the workflow merges only after it is done | Decided (section 9) |
| M30 | Revocation: Batu resets the project's database password and replaces the environment secret | Decided |
| M31 | Applying a migration to `devos-test` before its merge | Rejected (section 6 (a)) |
| M32 | Until C03's required checks exist, the executor does not merge a pull request that touches `supabase/` or `.github/workflows/` while its checks at the head are red or missing, and the merge's log entry records their state. This is the executor's merge procedure; the merge gate does not read check results | Decided (Y-10) |
| O1 | A migration that applied in `devos-test`, failed there, and cannot be repaired forward: the stop keeps it from `devos`; a path that resets `devos-test` is not designed here | Open: designed when first needed, through plan Section 14 |

## 2. Point 1 (a): the credential's form and its role

**Decision (M01).** For each project the credential is the password of Supabase's `postgres` role. The job builds its connection from non-secret parts fixed in the workflow (pooler host, port 5432, user `postgres.<project ref>`, database `postgres`) and the secret password, which it percent-encodes as a whole. It runs the CLI's `db push --db-url` through the session pooler. Batu resets each project's password in its dashboard and pastes it only into that project's environment secret (section 9). The builder never sees it.

**What it can do beyond applying migrations.**
- `postgres` is not a superuser and holds CREATEROLE, CREATEDB and BYPASSRLS in `devos` [obs: OBS query 1, 2026-10-12T15:18:10Z]. Supabase calls it the role that "has admin privileges" [doc R5 S5: https://supabase.com/docs/guides/database/postgres/roles]. It is also the role the dashboard's SQL screen uses ("execute as `postgres`") [doc R6a 6, same page].
- So it can read and write every DevOS table regardless of row-level rules; create, change and drop roles and every object DevOS creates; change grants; and drop every user-created object, as the CLI's remote `db reset` does [doc R5 S5: CLI reference].
- What it cannot do: superuser operations such as `COPY … FROM PROGRAM` and `ALTER USER … WITH SUPERUSER` [doc R6a 6: https://supabase.com/docs/guides/database/postgres/roles-superuser], and altering tables that Supabase's internal roles own [doc R6a 6, the realtime troubleshooting page].
- In `devos-test` the same is expected [inf: same plan and role model]; `devos-test` was not observed [cnc until the job's first listing].

**What bounds it.** Not the role: no role limited to applying migrations is documented [doc R5 S6], and a migration is arbitrary SQL [inf R5 S6]. The bound is:
1. **Where it is kept.** Only jobs that reference its environment receive it, and only after the environment's rules pass; the branch rule admits only runs whose `GITHUB_REF` is `main` (section 3) [doc R5 G2, G3; R6b 1].
2. **What runs with it.** Only `migrate.yml` and the files the job copies from `supabase/migrations/` (migrations and `tests/`), and from the first Edge Function `supabase/functions/`, all at `main`'s head. Each of these paths is class high in the merge gate today [obs: `tools/merge_gate.py` at eba94b1, `HIGH_PREFIXES`], so each change merges only with a fresh-context verdict at its head. The CLI's configuration is written by the workflow itself (M08), so a class-normal file such as `supabase/config.toml` or `supabase/seed.sql` changes nothing the job does (Y-09).
3. **One project per job.** The `devos-test` jobs hold only `devos-test`'s password, and the `devos` jobs only `devos`'s. A test that misbehaves in `devos-test` cannot reach `devos` with it.
4. **The head check (M05).** A run at a commit other than `main`'s head ends before any step receives the secret.
5. **Nothing echoes it (M21).** The run logs of a public repository are public [inf], and GitHub's redaction "is not guaranteed" [doc R5 G9: https://docs.github.com/en/actions/reference/security/secrets].

**Alternatives weighed.**
- **(B) A custom login role with CREATEROLE that owns DevOS's schemas** [doc R6a 6]. Narrower in one respect: it does not reach objects it neither owns nor was granted, such as Supabase's internal schemas [inf R6a 6]. Not chosen:
  - over DevOS's own data and rules, which are what the ✘ line protects, it can do what `postgres` can, because it owns them; CREATEROLE "is a safeguard against accidents, not a security feature" [doc R6a 6, PostgreSQL 18 pages; the projects run PostgreSQL 17.6, obs, and version 17's pages were not read];
  - extension creation "is gated by `supautils`" for `postgres` [doc R6a 6], and objects a custom role creates may need `grant "custom_role" to "postgres"` [doc R5 S6]; whether such a role can do all DevOS's migrations need was not read [cnc];
  - creating it is a further step for Batu (a password typed in the SQL screen);
  - **reopen if** DevOS comes to hold objects outside its own schemas whose protection from the migration path matters, or a probe shows that such a role does everything DevOS's migrations need.
- **(C) A Supabase access token that mints a short-lived `cli_login_postgres` login** [doc R6a 2.4]. Not chosen: the stored secret becomes a token with Database read-write, which can also "Run a query" [doc R6a 2.1, 2.4], so it is no narrower; the login endpoint is "experimental and Beta" [doc R6a 2.4]; whether such a token can be made not to expire was not read [cnc], and an expiring token would be a recurring step for Batu (criterion 21). **Reopen if** the password route fails P1 and its fallback, or when a Management API token is needed anyway (the first Edge Function, N-230).
- **(D) Supabase's GitHub integration**, which keeps any migration credential out of GitHub [doc R5 S8]. Not chosen:
  1. no ordering between two projects is documented, nor that one repository serves two projects [doc R6a 1.2: absence after the searches it describes]; an order would need a second Git branch advanced after `devos-test` succeeds, and whoever can push it then applies to `devos` [inf R6a 1.2];
  2. it has documented routes to production other than a merge into `main`: dashboard merges with Branching, changing the production Git branch (Owner or Admin), and the Management API's merge and push endpoints [doc R6a 1.5], which point 14 (b) would need closed one by one;
  3. its result is read through the Management API's action runs or Supabase's notifications, not GitHub's run record [doc R6a 1.7], so point 14's observation (GitHub's record shows the `devos-test` step failed and the `devos` step never started) could not be made;
  4. it installs a GitHub App whose permission list is not stated in the pages read [doc R6a 1.6: absence], a new effect channel into `devos`;
  5. 6.2's comparison would still need its own job and credential [inf R5 S8];
  6. **reopen if** Supabase documents an ordering between two projects and the other routes can be closed.
- **(E) A repository secret.** "Any user with write access to your repository has read access to all secrets configured in your repository" [doc R5 G1: https://docs.github.com/en/actions/reference/security/secure-use]. It fails the ✘ line by the documentation alone.
- **(F) The Management API's "Apply a migration".** Which role runs the SQL, and whether it writes the CLI's history, are not stated; the same permission also unlocks rollback, patch and upsert [doc R6a 2.1].

**Why this is the simplest that meets the condition (K-10).** Every form that can apply DevOS's migrations can do more than that [doc R5 S4 to S6; R6a "For the decision"]. This one adds no account, token, App or role, and Supabase's own CI example uses the database password [doc R5 S1: https://supabase.com/docs/guides/deployment/managing-environments]. Its bound (where it is kept, what runs with it) is the bound every alternative would also rely on.

**P1's fallback.** If `db push --db-url` refuses a hosted project without `link` (R6a 5: "probable, but not stated"; Supabase's own pages use `--db-url` against hosted projects for `db pull` [doc R6a 5]), the job uses `migration up --db-url` (same flag [doc R5 S2]). If that fails too, the job applies each pending file with `psql`, one transaction per file, and writes the history row in that transaction, in the table's form as the build reads it. The credential and Batu's step stay the same. The fallback is chosen at the build, before the first real migration, and judged with the workflow's verdict.

## 3. Point 1 (b): how GitHub keeps it to the migration job on `main`

**Where it is kept (M03).** Two environments of `devos`: `migrate-devos-test` holds `devos-test`'s password and `migrate-devos` holds `devos`'s.
- **Deployment branches:** "Selected branches and tags" with one branch rule, `main`. "The deployment branch or tag rule is matched against the `GITHUB_REF` of the workflow run" [doc R6b 1: https://docs.github.com/en/actions/reference/workflows-and-actions/deployments-and-environments]. A `pull_request` run has the ref `refs/pull/N/merge` and is admitted only if a rule names it [doc R5 G3]. "Protected branches only" is not used: "If no branch protection rules are defined for any branch in the repository, then all branches can deploy", and whether a ruleset counts is not stated [doc R5 G3].
- **Bypass:** "Allow administrators to bypass configured protection rules" is unticked [doc R6b 3]. Whether bypass covers branch rules at all is not stated [doc R6b Open]; it is turned off either way, at no cost.
- **No required reviewers, no wait timer.** A reviewer would mean a click from Batu on every merge (criterion 21) [inf R5 G7].
- Secrets in an environment "are only available to workflow jobs that reference the environment", and the job receives them only after its rules pass [doc R5 G2]. For forks: "secrets are not passed to the runner when a workflow is triggered from a forked repository" [doc R5 G1: https://docs.github.com/en/actions/how-tos/write-workflows/choose-what-workflows-do/use-secrets], and "forks with branches that match the protected branch name cannot deploy to the environment" [doc R5 G6].
- Free while `devos` is public; if it became private on GitHub Free, "any configured protection rules or environment secrets will be ignored" [doc R6b 3, costs]: the job would then fail closed [inf], and making the repository private is Batu's own decision, with its cost.

**Every event that can start a job holding it.** Admission depends only on `GITHUB_REF` [doc R6b 1]. So the events are those in the `on:` of every workflow on `main` whose job names an environment, plus re-runs, plus what an installed App can do.

| Event | In `migrate.yml` | What keeps it to a merge, or shows it applies nothing unmerged |
|---|---|---|
| `push` to `main` | Yes, no path filter | The merge route. Sessions cannot push to `main`: the guard denies it (working order section 10, rules B1 to B11). The rule of `main` counts as a layer only after N-175. A run applies only what `main` holds at its commit, and only at `main`'s head (M05) |
| `schedule` | Yes, every 6 hours | Runs at the default branch [doc R6b 1]. Its jobs compare and list; they contain no apply step (M22 refuses one) |
| `workflow_dispatch` | No | A dispatch against a `claude/` branch whose copy lists it runs with that branch as `GITHUB_REF` and is refused [inf R6b 1]. Against `main`, `main`'s file does not list it; which version's `on:` decides is not stated [doc R6b 1], so point 8 tries it |
| `repository_dispatch`, `workflow_run`, `check_run`, `check_suite`, `pull_request_target`, and the other default-branch events (`issues`, `issue_comment`, `fork`, `watch`, `label`, …) | No | A `main` rule would admit them [doc R6b 1], and some can be caused by users without write access [inf R6b 1]. M22 refuses any of them in a workflow that names an environment. `pull_request_target` is also blocked by GitHub's default policy for public repositories from November 2, 2026 [doc R5 G5] |
| Reusable workflows | `migrate.yml` neither calls one nor is one | A `main` caller using a reusable workflow at a branch or tag runs that ref's code with `GITHUB_REF` = `main` [inf R6b 1]; M22 refuses any workflow `uses:` and any action not pinned by full SHA |
| Re-runs | Cannot be turned off | A re-run keeps the original commit, ref and actor, up to 30 days [doc R6b 1: https://docs.github.com/en/actions/how-tos/manage-workflow-runs/re-run-workflows-and-jobs]. A re-run of a refused `claude/` run keeps its ref and is refused [inf; whether rules are evaluated again is not stated, P6]. A re-run of an older `main` run would run that commit's workflow with today's secret [inf R6b 1]; M05, present from the workflow's first version, ends it before any step receives the secret. A re-run of the head's run applies only merged files again, and the CLI skips those already applied [doc R5 S3] |
| Installed GitHub Apps | — | An installation token is bounded only by the App's permissions [doc R6b 3]. Actions write: re-runs (above). Contents write: branch pushes (refused) and pushes to `main` as far as the rule of `main` allows (N-175). Administration write: could widen the branch rule; P8 inspects it. Anthropic lists the Claude GitHub App's permission as "Administration: Read" [doc, cited in N-175 from EV-C01-018, read 2026-10-11] |

**Who can change where it is kept, its rule or its value.**
- **The environment and its branch rule and bypass.** "To configure an environment in a personal account repository, you must be the repository owner" [doc R6b 3: https://docs.github.com/en/actions/how-tos/deploy/configure-and-manage-deployments/manage-environments]. Through REST, changing an environment or its branch policies needs "Administration" write [doc R6b 3]; the bypass setting has no documented REST field [doc R6b 3]. No page read contradicts the owner-only rule for configuration. So: Batu, unless an installed App holds Administration write (P8).
- **The secret's value (R5 G8's contradiction).** The use-secrets page makes it owner-only; the REST page says "collaborator access" [doc R5 G8; R6b 3]. **The design does not depend on which is right.** A write does not reveal the old value [doc R6b 3: "without revealing its encrypted value"]. The host, port and user are fixed in the workflow on `main`, and the job percent-encodes the whole value into the password part, so a written value cannot redirect the job; it can only make the login fail [inf]. That shows as "could not check" and stops what it guards (M16); Batu then sets the value again (M30). An overwrite is a loss of availability, never a reading.
- **Deleting the environment** deletes its secrets [doc R6b 3]; it is the owner's. A branch workflow naming a missing environment creates it "without any protection rules or secrets" [doc R6b 3], so it receives nothing. For the same reason `migrate.yml` merges only after Batu has created both environments with their rule (M29).
- **What runs with it** changes only through a merge into `main` of class-high paths (the gate), with the guard denying sessions a push to `main`; the rule of `main` counts only after N-175 (plan 6.7). These are the layers point 9 names, with D-003's residual (section 10, point 9).

**G8, settled as far as it can be here.** For the value: by a design that does not depend on it. For the branch rule and bypass: the documentation does not contradict itself. For installed Apps and the machine account: P8 at the build. If P8 shows an App or the machine account able to change the rule, point 9 records that route as not shown, never as met, and its removal goes to Batu as an account step, as N-175 does for the rule of `main`.

## 4. Point 1 (c): the role's place, the records, the comparison's caller, the pull-request checks

**The role in Appendix B section 2 (M10).** A row for Supabase's `postgres` "as the migration job holds it": not a DevOS role class, held by no agent environment. Its "Cannot" cell says that nothing is withheld by the role itself and that it is bounded by where its password is kept and by what the job runs, and it carries M24. Because the job's `devos-test` test step issues and revokes synthetic tokens (Y-05), B:46's "only the project owner (Batu, from the Supabase dashboard) can run this function" gets one added sentence for `devos-test` (PC-41 place 9). This closes R1 section 5 item 6's first half.

**The record of applied migrations (M11).**
- Supabase's `supabase_migrations.schema_migrations`: "a migration history table will be created under supabase_migrations.schema_migrations … Subsequent pushes will skip migrations that have already been applied" [doc R5 S3: https://supabase.com/docs/reference/cli/supabase-db-push]; "After successfully applying a migration, a new row will be inserted into the migration history table with timestamp as its unique id" [doc R6a 5]. It does not exist yet in `devos` [obs: OBS query 2, 15:18:13Z, `history_table` null].
- Each file runs in a transaction unless it carries the `pg-delta` directive [doc R6a 5]. That the history row is written inside the file's transaction, so that a failed file leaves neither objects nor row, is inferred [inf] and probed (P2). Whether `db push` stops at the first failed file is not stated [doc R6a 5] (P2).
- Writers: the CLI as `postgres`; anyone holding `postgres` (Batu in the SQL screen). Readers: `deployment_drift`; the builder's read-only connection in `devos`.
- **No Appendix B family.** It records no DevOS work, and a DevOS copy would be a second authoritative copy of the same fact. PC-41 names it in section 4's Deployment row. This closes R1 section 5 item 6's second half.

**The record of deployed function versions (M12).**
- A deployed Edge Function's version is readable through the Management API or the CLI only; no SQL-visible record was found [doc R6a 3; the SQL absence is the reading's search, not a statement].
- So the database's record is a table the job writes: `devos_private.function_deployment` (slug; the `version` and `ezbr_sha256` the API's function list returns [doc R6a 2.2]; the SHA-256 of `main`'s source of the function as the job computes it; commit; run; time). The first migration creates it empty with `deployment_drift` (Y-11). The deploy step, its writer and its token come with the first file under `supabase/functions/` (N-230). Until then `main`'s function set and the record are both empty.
- Residual: a function deployed outside the path (an Owner or Admin in the dashboard, or a token holder) is not seen until a reader of the live list exists [inf].

**`expected` (M14).** The caller computes it from a checkout of `main`'s head: for each top-level file `supabase/migrations/<version>_<name>.sql`, the pair (version, name); for each directory under `supabase/functions/`, its slug and the SHA-256 of its files in path order; and the commit. Files in subdirectories (such as `tests/`) are not migrations. The comparison does not compare an applied migration's text with the file: the history is keyed by version ("Only the timestamps are compared", for `migration list` [doc R6a 5]). A merged file's text is kept from changing after it applies by M16's rule on pull requests instead. This is T-65's "content identity" at the level of files, not of their text; section 13 states the limit.

**What `deployment_drift(expected)` returns, in the project it runs in** (B:387, as PC-41 words it):
- **"no difference"** only when every part was compared in full: `expected` present and well formed; the history read in one read-only snapshot; the function record read;
- **a list of differences**, each one of: on `main` and not applied; applied and not on `main`; name differs; function missing, extra or differing;
- **"could not check"** otherwise: `expected` missing or malformed; the history table or the function record absent or unreadable; any error.

The result carries a completeness flag and the counts compared. The caller treats an error, a timeout, a cut connection, a missing or malformed result, or an unset flag as "could not check" [design]. The three outcomes are counted apart.

**How it authenticates when the migration job calls it (M13; R3 G6; B:45; Y-02).**
- The job calls it over its direct database login as `postgres`. Before W-C02-05's token check, the function admits a caller whose `session_user` is `postgres`; every other caller passes the token check.
- Through the Data API the login is `authenticator`, which "change[s] into" another role after verifying the JWT [doc R5 R3: https://supabase.com/docs/guides/database/postgres/roles]; so a Data API caller's session user is `authenticator`, never `postgres` [inf; P5 shows it].
- Reason: `postgres` owns the function and could replace it, so a token would add nothing; the job holds no token, and giving it one would add a second credential where the first suffices.
- Form: `security definer`, owned by `postgres`, with a fixed `search_path`, so that `devos_ci` can read the history through it [design].

**From when the pull-request checks run it (M15; B:390; R3 G5; Y-03).**
- `devos_ci` is W-C02-05's: a key issued at the identity chain's first part (Batu's step 4), reaching `devos` only, through the Data API (EV-C02-004 Y-03). From the first pull request after it is stored where the checks read it, and after `devos_api` is exposed (M26), the checks call `deployment_drift` on `devos` with it, passing `expected` computed from `main`'s head (not the pull request's head, whose new files would always show as unapplied).
- **Until then, and for `devos-test` always:** the checks read, with their own `GITHUB_TOKEN` (`actions: read`), the report of the latest completed run of `migrate.yml` at `main`'s head: per project, the result and the versions recorded as applied. No database credential is needed. The report is written by a job on `main` that ran reviewed code, so it is the job's own account [inf]. It detects a merge whose apply failed or never ran, 6.2's stated purpose; it does not detect a change made in a database outside the path between runs (the scheduled runs and, from `devos_ci`, the direct call narrow that window).
- **"Could not check" here:** no completed run at `main`'s head yet, a report that cannot be read, or a report without both projects' results.

**What a difference or "could not check" from those checks stops (M16).**
- **A pull request that changes or removes a file under `supabase/migrations/` that is on `main`:** red, unless the records show that file's version unapplied in both projects. "Could not check" cannot show that, so it is red too.
- **A pull request that only adds migration files:** not stopped. The job applies them only through `devos-test` first, behind the same stop (M07), and blocking them would block the forward repair of a stopped migration. The check shows the state.
- **Every other pull request:** the check passes and writes the state in its summary, so a difference stays visible on every later pull request. Blocking unrelated work on a database difference would stop work the difference does not affect (6.2: "stops the work it affects").
- **Results read from a project:** a test result or reading counts as "could not check" unless `deployment_drift` reported "no difference" in that project at that commit, recorded beside it. This binds W-C02-07's harness and every checker. The job's own tests run only after a clean comparison (M07).
- **Until C03's required checks exist,** a red check stops a merge only through the executor's merge procedure (M32); the merge gate does not read check results. From C04, `session_brief` also stops the affected work (B:390).

**Repair paths.**
- An unreachable or paused project: resuming it is Owner or Admin [doc R6a 4: https://supabase.com/docs/guides/platform/access-control], a one-off step for Batu (section 5). The next push to `main` (any merge), or a re-run of the head's run, applies what is pending.
- A migration whose SQL fails in `devos-test`: applied nowhere [inf; P2], so M16 lets a pull request change or remove it.
- A migration that applied in `devos-test` and failed its tests there: a forward fix (a new file); `devos` then receives both in one run, after `devos-test` passes.
- An out-of-band change (applied and not on `main`; a name that differs): no automatic path; the executor investigates while the stop holds `devos`.

## 5. Point 1 (d): network, concurrency, pausing, pins, and the job's shape

**Network (M19).** The session pooler on port 5432, user `postgres.<project ref>` [doc R6a 5: "Shared pooler connections use `postgres.[PROJECT-REF]`", https://supabase.com/docs/guides/database/connecting-to-postgres]. GitHub Actions needs IPv4; "The shared pooler is IPv4-only on every plan"; session mode supports what a direct connection does; the IPv4 add-on is paid [doc R5 S7: https://supabase.com/docs/guides/platform/ipv4-address]. So no add-on. The project refs are in plan 6.2 (not secret). Each project's pooler host is not in the readings [cnc]; the build finds it with a step that holds no credential and records it in the workflow (P3).

**Concurrency (M06).**
- `concurrency: {group: migrate, cancel-in-progress: false, queue: max}` at workflow level, for push and scheduled runs alike. A running apply is never cancelled. With the default queue "any existing `pending` job or workflow run in the same group is canceled and replaced"; with `max`, "Up to 100 jobs or workflow runs can be `pending`" [doc R6b 2: https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-syntax]. Without `max`, a scheduled run queued behind a running apply would cancel a pending push run, and that merge would not be applied until the next one [inf].
- Order among pending runs "is not guaranteed" [doc R6b 2]. M05 makes that harmless: a run whose commit is no longer `main`'s head ends as "superseded", and the head's own run applies everything pending; the CLI applies only what is not applied [doc R5 S3]. "Coordinate so only one person runs `db push` at a time" [doc R5 S3] is met by the single group.
- One group also keeps a scheduled comparison from running during an apply, so it never reads a half-applied state [inf].
- **Fallback if P4 shows `queue: max` refused or not honoured:** scheduled runs move to their own group, and their comparison reports "could not check: an apply is pending or running" when GitHub's run list shows a push run of `migrate.yml` not completed at either end of the comparison.

**Pausing (M17, M18).**
- "Supabase pauses Free Plan projects that show low activity over a 7-day period" [doc R5 S10: https://supabase.com/docs/guides/platform/free-project-pausing]. Both projects were paused on 2026-10-12 (Batu's report, 13:36Z) and resumed by him (L-286); `devos` was observed back at 15:14:54Z (C02.md "Batu's steps" row 0).
- **What a pause does to the job:** the connection fails [inf], so the job's comparison gives "could not check". A paused `devos-test` stops `devos`'s migrations until it is reachable again (M07; section 6 (d)). A paused `devos` fails its own apply after `devos-test` succeeded; the difference shows until a run applies.
- **Keeping both active:** the scheduled runs connect to each project every 6 hours (four sessions a day each, several queries per session), and every merge adds a run. "Typically a few user requests to the database each day over the previous week is enough to keep the project from being paused" [doc R6a 4, same page]. Whether a scheduled connection from CI counts as "user" activity is not stated [cnc → P9]. No sentence in the AUP or terms read forbids such traffic [doc R6a 4: absence in the pages read; the fair-use page returned 404].
- **If a pause happens anyway:** resuming is Owner or Admin in the dashboard [doc R6a 4]; the alternative, a token with Project Settings read-write, can also "Pause", "Restore" and "Delete a project" [doc R6a 4], so no job gets one. A pause is a one-off step for Batu, asked in Appendix E §7's form. A second pause means the keep-alive failed: the schedule becomes more frequent (a class-high change); only if that also fails does the Pro plan ("Projects under a paid plan cannot be paused" [doc R6a 4]) go to Batu as his decision in Appendix E §3's form. No recurring step is asked of him (criterion 21).
- **GitHub's 60 days:** "In a public repository, scheduled workflows are automatically disabled when no repository activity has occurred in 60 days"; what counts as activity is not stated [doc R6b 4: https://docs.github.com/en/actions/how-tos/manage-workflow-runs/disable-and-enable-workflows]. During the installation `devos` changes daily [inf]. After 60 idle days the projects would pause too; re-enabling the workflow ("a commit that changes the `cron` schedule … will be reactivated" [doc R6b 4]) and resuming the projects become one-off steps at the restart. Accepted as a residual (M18).

**Pins (M20; R5 G9; R6b 5).**
- `actions/checkout` is the only action in `migrate.yml`, pinned "to a full-length commit SHA", verified at the build to be a commit of the action's own repository, "not a repository fork" [doc R6b 5: https://docs.github.com/en/actions/reference/security/secure-use].
- The CLI is downloaded by a step at a fixed release, and its SHA-256 is compared with a value committed in the workflow (taken at the build from the release's published checksums, P12) before any step receives the secret; a mismatch ends the job. `supabase/setup-cli` is not used: with a fixed `version` it states no integrity check without a lockfile [doc R6a 5], and dropping it removes one third-party action from a job that later holds the secret [design].
- The runner label `ubuntu-24.04` on standard GitHub-hosted runners, free in public repositories [doc R5 section 5 table]; self-hosted runners "should almost never be used for public repositories" [doc R5 G9]. Residual: the runner image's own tools (`psql`, `git`) are GitHub's and not pinned by DevOS.
- No workflow lockfile: "in public preview and subject to change" [doc R6b 5]; with one action pinned by SHA it adds nothing now [inf]. Reopen when it leaves preview or the job gains actions.

**Inside the job (M21).** `permissions: {}` at workflow level ("all of those that are not specified are set to `none`" [doc R6b 5]); jobs: `contents: read`; the scheduled job that makes point 9's search adds `issues: read` and `actions: read`. The secret appears only in the `env` of the steps that connect, never at job level. Before use, the job masks the percent-encoded value and the composed connection string. No step uses shell tracing or the CLI's debug output. A debug re-run [doc R6b 1] at a commit other than the head ends at M05.

**The job's shape** (for the build; every name non-secret).
- **On a push to `main`:**
  - `devos-test` (environment `migrate-devos-test`), in order: (1) head check; (2) "credential present: yes/no"; (3) connect; (4) the listing of point 10; (5) a dry run naming the pending versions (`--dry-run`, "Print the migrations that would be applied" [doc R6a 5]); (6) the apply; (7) `deployment_drift`, which runs even when the apply failed; (8) the database tests from `supabase/migrations/tests/`, only after a clean comparison. Output `go = yes` only when (1) found the head and (6), (7) and (8) all succeeded.
  - `devos` (environment `migrate-devos`), `needs: devos-test`, runs in every case: (1) to (4) as above; the dry run and the apply only if `devos-test`'s `go` is `yes`; then `deployment_drift`. So when `devos-test` stops, the run still reports `devos`'s state.
- **On the schedule:** `check-devos-test` and `check-devos`, independent, each: head check, presence, connect, `deployment_drift`; and point 9's search in one of them.
- **Every run writes a report** in fixed-form lines in its log and summary: per project, the result, the versions recorded as applied, superseded or not. It holds names, versions, counts and statuses only. The pull-request checks read it (M15).

## 6. Point 14: the test project first, and the verdict before `devos`

**(a) What the verdict judges before the merge (M31).**
- The fresh-context verdict at the pull request's head (class high, W-C02-19) judges the migration's text, the database tests that come with it under `supabase/migrations/tests/`, and the pull-request checks' results (M15, M16, M22). It does not judge the migration's effect in `devos-test`, which exists only after the merge.
- No pre-merge apply. It would need `devos-test`'s credential in a run for a branch other than `main`, which the ✘ line refuses, or a `main` job on `pull_request_target` or `workflow_run` running unmerged code, which M04 and M22 exclude. So no run holds the test project's credential before a merge, point 8 holds unchanged, and no plan text changes for a pre-merge apply.
- After the merge and before `devos`, inside the job, `devos-test`'s apply, comparison and database tests judge the effect, and any failure stops the run before `devos`. Task 1's "first in the test project" is met by this order.

**(b) No route other than a merge into `main` through the merge gate applies a migration to `devos`.**
- Section 3's table: dispatch absent; `repository_dispatch` and the other default-branch events absent and refused by M22; scheduled runs compare only; re-runs end at M05 or re-apply merged files only; workflow calls refused.
- Supabase's GitHub integration is not used (M02), so its routes have no connection to use [inf: it is set per project by Owner or Admin, R6a 1.6, and none is configured].
- The Management API's apply needs a token that no part of DevOS holds.
- The builder's Supabase connection is read-only and reaches `devos` only (EV-C00-002 item 8).
- Batu's SQL screen is the project owner's own act, outside DevOS's routes; W-C02-08 point 1's ✘ look would show an object that came that way.

**(c) W-C02-08 point 1: "point 6's tests passing in `devos-test` before `devos` was applied".** It fits. The `devos-test` job runs W-C02-07's tests for W-C02-08 after the apply and a clean comparison, before the `devos` apply; their raw output is the job's log, labelled the job's own, and the run's step times show the order. Named for the executor before W-C02-08's work starts:
1. W-C02-07's tests for W-C02-08 are SQL tests under `supabase/migrations/tests/`, run by the job as `postgres` in `devos-test`, switching to each role class with `set role` inside rolled-back transactions (Y-05). A test that needs another client (the Data API with a publishable key, a real environment token) is listed under W-C02-08 point 6 with W-C02-12, as that point allows. How the job runs them is P10.
2. W-C02-08's verdict (i) judges the text and every part that needs no apply; point 1's `devos-test` part and point 6's tests there fall to (ii), because `devos-test` receives a migration only after its merge. W-C02-08 (i) already provides for this ("as far as that order applies the migrations to `devos-test` before the merge").
3. If W-C02-07 puts its database tests anywhere else, that path must be class high in the merge gate, since the job runs them with `devos-test`'s credential; `supabase/tests/` is class normal today [obs: CHK-C02-005's near-miss list]. No conflict remains if these hold.

**(d) The order and its stop (M07; Y-01).**
- The order is section 5's push shape: `devos-test` (apply, comparison, tests), then the `devos` apply only on `go = yes`, then `devos`'s comparison in every case.
- `devos` is never applied after: an apply failure in `devos-test`; a difference there; "could not check" there (`devos-test` paused or unreachable, or the read cut); a failed test; a superseded run.
- **A paused or unreachable `devos-test`** holds every later migration from `devos` until it is reachable and clean again. Time added on the critical path: the pause's length, that is Batu's response to a resume step plus one run (minutes) [est]. The keep-alive makes a pause unexpected. Reason: plan C02 task 1 and W-C02-03 point 14 (eba94b1); R6a 4 (2026-10-12). Against Batu's later decisions: none touches it (section 7).
- **Weighed against other orders:** both projects at once loses the stop (rejected); `devos` by a second merge after a verdict on `devos-test`'s effect doubles every migration's class-high verdict and merge, while the job's tests and comparison give the same "before `devos`" judgment automatically (rejected; reopen if a migration's effect needs a checker's judgment, not a test, before `devos`); Supabase's integration (M02).

## 7. Point 2: the parameters that decide when dependent work can next start

Plan 6.12 item 1 (PC-23): the time each adds on the critical path, its reason's source with the source's date, and for a reason taken from the plan a check against Batu's later decisions. Durations are [est] until the build measures them from the runs' step times.

**Batu's later decisions checked.** D-019 and D-020 (answered 2026-10-11), and the later records D-021, D-022 and D-027 to D-031 on `main`, by their titles (Run now presses for C01's routine; the synced skills; the form of a "no" discipline answer). None concerns the migration path. D-020 asks for the option that needs no extra fee ("ek ücret gerekmeyen (a)", in `plan/decisions/D-020.md`): this design takes on no cost. D-002 (usage) and D-003 (the guard's residual) bear on point 9's level, not on timing.

| Parameter | Value | Time it adds on the critical path | Reason's source (date) | Against Batu's later decisions |
|---|---|---|---|---|
| Apply trigger | Every push to `main`, no path filter | A merged migration reaches `devos-test` about 1 to 3 minutes after the merge and `devos` about 2 to 6 minutes after it [est], plus any wait behind a running run. Without a path filter, the next merge of anything retries a stopped apply, so a repair needs no extra action | Plan 6.2 "when a change merges into `main`" (eba94b1); R6b 1 (2026-10-12) | None touches it |
| Schedule | Every 6 hours, compare only | None: it applies nothing. An out-of-band difference shows within about 6 hours | R6a 4 (2026-10-12); R6b 4 (2026-10-12) | Consistent with D-020 (no cost) |
| Concurrency | One group, no cancelling, `queue: max` | A run waits behind at most the run in progress, about 2 to 6 minutes [est]; a superseded run ends in under a minute [est] | R6b 2 (2026-10-12); R5 S3 (2026-10-12) | None touches it |
| Head check | Apply only at `main`'s head | None: the head's run applies what superseded runs would have | R6b 1, re-runs (2026-10-12) | None touches it |
| Order and stop | `devos` only after `devos-test`'s apply, comparison and tests succeed | `devos` waits for the `devos-test` job, about 1 to 3 minutes plus the tests' run time [est]; after a stop, until the repair (section 4, "Repair paths") | Plan C02 task 1, "first in the test project" (eba94b1); W-C02-03 point 14; EV-C02-004 Y-01 (2026-10-12) | None touches task 1 |
| When the pull-request checks run the comparison | Run record until `devos_ci` exists; then `deployment_drift` on `devos` plus the run record for `devos-test` | A pull request waits only when the run for `main`'s head has not completed, at most one run (about 2 to 6 minutes [est]); otherwise none | Plan 6.2, B:390 (PC-16; eba94b1); R3 G5 (2026-10-12); EV-C02-004 Y-03 (2026-10-12) | None touches it |
| What a difference or "could not check" stops | M16 | Until the repair: a resume plus one run, or a repair pull request with its class-high verdict. Adding migrations and unrelated work is not held | Plan 6.2, Section 8 item 14 (PC-16); B:387 (eba94b1) | None touches it |
| Red or missing checks before C03 | M32 | A pull request touching `supabase/` or `.github/workflows/` waits until its checks are green at its head (one check run, about 1 minute [est]) | EV-C02-004 Y-10 (2026-10-12) | None touches it |
| Batu's step 1 | One sitting for both projects, asked on issue #6 as soon as this design is accepted, batched with any other step then due | The first apply waits for whichever ends later: his step, or the build (the tests in form C0, the workflow, its class-high verdict). The step is asked first and the build takes hours [est], so it adds nothing if he acts within that time; otherwise his response time. No other work waits on it; the workflow's merge waits on it (M29), and so does every apply | Working order sections 7 and 8 (eba94b1); W-C02-03 point 4 | Asked in Appendix E §7's step form (§3: "Steps he must carry out come after the question, numbered") |
| CLI version | Fixed release with its checksum | None at run time; an update is a class-high change | R6a 5 (2026-10-12) | None touches it |

## 8. Point 3: the plan change

`plan/decisions/PC-41.md` changes, with old text from `main` `eba94b1`: plan 6.2 "Database changes"; plan 6.7's effect channel inventory, row "Database migrations"; plan C01 "Probe setup" P3's last clause; plan C02 task 0; plan Section 12 item 1, its migration sentence only (PC-43 changes its first sentence; Y-07); plan Section 12 "Key inventory", two clauses; Appendix B section 2 (a new row; B:45; B:46); Appendix B section 4 (B:387; B:390); `plan/key_inventory.md` rows 23 and 24 (Y-12). No acceptance block changes, and plan 6.7's high-impact path list is not widened (Y-09). **N-209's corrections (1) to (3) were carried by PC-40**, merged in `eba94b1` ("this one, PC-40, carried N-209 (1), (2) and (3); no earlier C02 plan change merged", `plan/decisions/PC-40.md`); PC-41 carries none of them.

**Notes written with it** (`origin=W-C02-03`): N-230 on `plan/work/C03.md` (the deploy path for the first Edge Function, carried to the stage that adds one); N-231 on `plan/work/C03.md` (the migration checks among C03's required checks, test 3, D-003's re-assessment); N-232 on `plan/work/C04.md` (`session_brief`'s `expected`); N-233 on `plan/work/C02.md` (where the database tests the job runs live). Point 11's line on N-099 (`plan/work/C09.md`) is the build's, with its evidence.

## 9. Point 4: Batu's step 1 (row 1), in Appendix E §7's form

Asked on issue #6 as soon as this design is accepted, in one sitting for both projects, batched with any other step then due (working order sections 7 and 8). No value is ever written in chat, on the issue, in a record or in a repository (Appendix E §6); the builder never sees it. No cost. Exposing `devos_api` is not in this step (M26). In each project the environment and its rule are made before the password exists, so the secret is never held by an environment without its rule. The menu paths below are not all in the readings; where they are not, the text says what to look for and asks for a screenshot (Appendix E §7 item 2). The GitHub labels quoted are those the readings quote ("Selected branches and tags", R5 G3; "Allow administrators to bypass configured protection rules", R6b 3).

**Turkish (as it would be sent):**

> **Adım 1 — Veritabanı göç anahtarlarını GitHub'a girmek** (iki proje, tek oturuş, yaklaşık 15 dakika; ücretsiz)
>
> Bu adımda oluşan şifreyi hiçbir yere yazmayın: sohbete, bu issue'ya, bir dosyaya yazmayın. Yalnızca aşağıda söylenen alana yapıştırın.
>
> **A. `devos-test` için**
> 1. GitHub'da `batuhanozgun/devos` deposunu açın ve üstteki **Settings** sekmesine tıklayın. Sonunda deponun ayar sayfasını görürsünüz.
> 2. Soldaki menüde **Environments**'ı bulun ve tıklayın; sonra yeni ortam ekleme düğmesine (**New environment**) tıklayın. Bulamazsanız ekran görüntüsü gönderin.
> 3. Ad olarak `migrate-devos-test` yazın ve onaylayın. Sonunda bu ortamın ayar sayfası açılır.
> 4. Dağıtım dalları bölümünde (**Deployment branches and tags**) listeden **Selected branches and tags**'i seçin. Sonunda dal kuralı ekleme düğmesi görünür.
> 5. Kural ekleme düğmesine tıklayın, tür olarak dal (**Branch**) seçin, `main` yazıp ekleyin. Sonunda listede yalnızca `main` görünür.
> 6. **Allow administrators to bypass configured protection rules** kutusunun işaretini kaldırın ve koruma kurallarını kaydedin. Bu kutuyu görmezseniz ekran görüntüsü gönderin. Sonunda kutu boştur.
> 7. Yeni bir sekmede Supabase panelinde `devos-test` projesini açın. Projenin ayarlarında veritabanı (**Database**) bölümünü ve orada "Reset database password" yazan düğmeyi arayın. Bulamazsanız ekran görüntüsü gönderin.
> 8. O düğmeye tıklayın, şifre üretme seçeneğini kullanın, şifreyi kopyalayın ve sıfırlamayı onaylayın. Sonunda şifrenin değiştiğini söyleyen bir bildirim görürsünüz. Şifre yalnızca panonuzda kalsın.
> 9. GitHub sekmesine dönün; aynı ortam sayfasında **Environment secrets** bölümünde gizli değer ekleme düğmesine tıklayın. **Name** alanına `SUPABASE_DB_PASSWORD` yazın, **Value** alanına kopyaladığınız şifreyi yapıştırın ve kaydedin. Sonunda listede `SUPABASE_DB_PASSWORD` adı görünür; değeri görünmez.
>
> **B. `devos` için**
> 10. 1–9. adımları tekrarlayın: GitHub'da ortam adı olarak `migrate-devos` yazın, Supabase'de `devos` projesini açın.
>
> **Bitiş**
> 11. Bu issue'ya yalnızca "Adım 1 tamam" yazın. Şifreyi yazmayın.
>
> **Sonunda görecekleriniz:** GitHub'da deponun **Settings → Environments** sayfasında iki ortam: `migrate-devos-test` ve `migrate-devos`. Her birinde tek bir gizli değer vardır ve dağıtım dalı yalnızca `main`'dir.
>
> **Sistem nasıl kontrol eder:** Göç işi `main` üzerinde ilk çalıştığında her proje için yalnızca "anahtar var: evet/hayır" ve "bağlantı: başarılı/başarısız" yazar; değeri hiçbir zaman yazmaz. Ayrıca başka bir daldan başlatılan bir işin anahtarı alamadığını deneriz. Sonucu bu issue'da size bildiririz.
>
> **Bilmeniz gereken:** Şifreyi sıfırlamak eski şifreyi geçersiz kılar; eski şifreyi başka bir yerde kullanıyorsanız orası artık bağlanamaz. Şifreyi yanlışlıkla bir yere yazarsanız, o proje için 7–9. adımları yeniden yapın.

**English rendering:**

> **Step 1 — Enter the database migration keys into GitHub** (two projects, one sitting, about 15 minutes; free)
>
> Do not write the password this step produces anywhere: not in chat, not on this issue, not in a file. Paste it only into the field named below.
>
> **A. For `devos-test`**
> 1. On GitHub, open the repository `batuhanozgun/devos` and click the **Settings** tab at the top. At the end you see the repository's settings page.
> 2. In the left menu, find and click **Environments**; then click the button that adds a new environment (**New environment**). If you cannot find it, send a screenshot.
> 3. Type the name `migrate-devos-test` and confirm. At the end the environment's settings page opens.
> 4. In the deployment branches section (**Deployment branches and tags**), choose **Selected branches and tags** from the list. At the end a button to add a branch rule appears.
> 5. Click the add-rule button, choose the type branch (**Branch**), type `main` and add it. At the end only `main` is listed.
> 6. Untick **Allow administrators to bypass configured protection rules** and save the protection rules. If you do not see this box, send a screenshot. At the end the box is empty.
> 7. In a new tab, open the project `devos-test` in the Supabase dashboard. In the project's settings, look for the database section (**Database**) and, there, the button that says "Reset database password". If you cannot find it, send a screenshot.
> 8. Click it, use the option that generates a password, copy the password and confirm the reset. At the end you see a notice that the password changed. Keep the password only on your clipboard.
> 9. Go back to the GitHub tab; on the same environment page, under **Environment secrets**, click the button that adds a secret. Type `SUPABASE_DB_PASSWORD` in **Name**, paste the password into **Value** and save. At the end the name `SUPABASE_DB_PASSWORD` is listed; its value is not shown.
>
> **B. For `devos`**
> 10. Repeat steps 1 to 9: type `migrate-devos` as the environment's name on GitHub, and open the project `devos` in Supabase.
>
> **To finish**
> 11. Write only "Adım 1 tamam" ("step 1 done") on this issue. Do not write the password.
>
> **What you see at the end:** on the repository's **Settings → Environments** page, two environments, `migrate-devos-test` and `migrate-devos`, each with one secret and deployment branch `main` only.
>
> **How the system checks it:** when the migration job first runs on `main`, it writes for each project only "credential present: yes/no" and "connection: succeeded/failed", never the value. We also try that a job started from another branch does not get the key, and tell you the result on this issue.
>
> **Good to know:** resetting the password makes the old one invalid; if you use the old password anywhere else, that place will no longer connect. If you write the password somewhere by mistake, redo steps 7 to 9 for that project.

**Why each action is his.** On a personal-account repository only the owner creates or configures an environment and its secrets [doc R6b 3; R5 G8]. Resetting a project's database password is a setting in his Supabase account; who else may do it is not stated in the pages read [cnc], and no part of DevOS has dashboard access. That a reset makes the old password invalid is inferred, not read [inf].

**Costs R5 flags, each shown not needed** (CLAUDE.md "Money"): the IPv4 add-on (the session pooler is IPv4, M19); a paid plan against pausing (the keep-alive, M17; to Batu only if it fails); preview branches (the integration is not used, M02); larger runners (standard `ubuntu-24.04`, M20); GitHub Pro (`devos` stays public). The row on `plan/work/C02.md` gets its dates and evidence from the executor (Y-12).

## 10. What the build observes (for the test designer), and the probes

"The job's own" means raw output that the job, which holds the credential, prints about itself: names, versions, counts and statuses only. The tests are the test designer's, in form C0, merged before the results they judge (point 12).

**Point 5 (✔ apply).** A synthetic migration labelled as a fixture (plan Section 8 item 13) merges through the merge gate. The push run's `devos-test` and then `devos` jobs apply it, as the step times show. In `devos`, the builder's read-only connection reads the object it made (its definition from the catalog) and its row in `supabase_migrations.schema_migrations`. In `devos-test`, the job's own read after the apply prints the same two. `deployment_drift`'s result after each apply, in the run's report, is "no difference", complete, at the merge commit. The record states what the fixture left in each project, and shows that each merge's versions appear as applied in a run's report (a superseded run is followed by the head's run listing them).

**Point 6 (✘ merged but not applied).** Forms, each planted by a fixture merged through the gate:
- (i) the apply fails: a fixture whose SQL fails, in `devos-test` only where P11 allows; `devos-test`'s comparison names it "on `main`, not applied", `devos`'s comparison names it for `devos`, and the next pull request's check names it from the run report (and through `devos_ci` once that exists);
- (ii) one project and not the other: a fixture that applies in `devos-test` but is stopped before `devos` (point 14's second example);
- (iii) a deployed function differs: only if C02 deploys a function (N-230); otherwise the record says that form is not reached in C02 and names the stage that adds the first function.

What each stops, and what to observe not going on: the `devos` apply (its steps skipped, `go` not `yes`); a pull request that changes a merged migration file shown applied, or not shown unapplied (its check red); a result read from a project (counted "could not check"). Positive control: everything applied, "no difference", and a pull request that only adds a file passing its check. Break: a copy of the comparison that answers "no difference" without comparing, skips a project, or skips the function record turns each form's test red. If the pull-request checks run the direct comparison only from `devos_ci`, that part is shown at the first pull request after it, and the record names the item (W-C02-12 or the one that stores the key).

**Point 7 (✘ could not check).** In `devos-test`, inside rolled-back transactions run by the job's test step, or as the comparison's own unit tests: `expected` absent and malformed; the history table unreadable (for example renamed inside the transaction); a partial read (the caller's connection cut by a client-side timeout shorter than a delay planted in a test copy, or a result without its completeness flag). Each gives "could not check", never "no difference", counted apart in the report; where it guards something (the `devos` apply; a pull request under M16) it is observed to block.

**Point 8 (✘ another branch).** A copy of the workflow naming the environments, with one step that prints only "credential present: yes/no", is pushed to a `claude/` branch and started by: a push to the branch; a pull request from it; a `workflow_dispatch` against it (the copy listing that event); a re-run of a refused run; and a re-run of an older `main` run (expected to end at M05 before any step receives the secret). Each is observed from the run's status (GitHub's refusal to deploy to the environment) and from the presence step if it ran. Positive control: the run on `main` reports "yes" and applies. If sessions cannot push a workflow file at all (pushing workflow files may need a permission the session's GitHub credential lacks [inf; P8]), the record says so: that is a further layer, and the ✘ attempt then needs another pusher or is "could not check" for that part.

**Point 9 (✘ a session reading it).** A step of a scheduled job, which holds the value, counts matches of the value and of its percent-encoded form in every ref's tree and history of `devos`, in issue #6's body and comments, and in the logs of `migrate.yml`'s earlier runs, and prints only the counts. Positive control: the same step finds a synthetic value planted for the purpose (a fixture string on a `claude/` branch, passed in as a non-secret constant). That a session has no other route is taken from the documentation [doc R5 G1, G2, quoted in sections 2 and 3, read 2026-10-12]. The layers named: the merge gate's class-high verdict on `.github/workflows/**` and `supabase/migrations/**`; the guard (no push to `main`); the rule of `main` only once N-175 settles who can change it; P8's result. D-003's residual: a session that defeats its own guard and can push to `main` could change what the job runs; the ✘ is claimed at that level only.

**Point 10 (✔ probe schema and tokens absent).** Before any migration applies, each job's listing step prints from the catalog every schema, table, view, function and role outside Supabase's own, using the exclusion list of OBS query 2, kept as data in the workflow and printed with the output. The first push run after Batu's step takes it before the first migration applies; in `devos`, the builder's read-only connection takes it too. OBS already shows `devos` with Supabase's schemas and `public` only, no other role, and no history table [obs, 15:18:13Z]; that is an early listing, not point 10's. Expected: nothing found, and none a probe schema, a probe role class or a table of token hashes. Positive control: the same query without the exclusion list shows a known object (for example `auth.users`). Tokens: `plan/key_inventory.md` rows 16 and 17 ("never created", 2026-10-12, W-C01-47 item 5) and PC-21 item 1, labelled as DevOS's records, not an observation. A project no reader reaches is "could not check", never "absent".

**Point 11.** N-099 T-65's migration part is recorded as met on `plan/work/C09.md` at the build, with its evidence.

**Points 12 and 13.** As the acceptance block states; the workflow merges with a fresh-context verdict at the head that adds it.

**Point 14's observation.**
- The failing fixture: a synthetic migration merged through the gate that fails in `devos-test` only, using a property that differs between the two projects and that a migration can read (P11). Observe: GitHub's record shows the `devos-test` job failed and the `devos` apply steps skipped; `devos`'s history, read by the builder's connection, lacks it; `devos`'s comparison names it. If no such property is found, the fixture fails in both, and the record says the stop rests on GitHub's record of the run.
- Second example: the apply succeeds in `devos-test` but the comparison there gives a difference (a fixture that removes an earlier fixture's history row; a later fixture restores it, inserting only if absent), and `devos` is not applied. A "could not check" variant: `devos-test` unreachable, or the read cut.
- Positive control: point 5's run, with `devos-test`'s steps ending before `devos`'s apply starts; its pull request's merge record shows the gate's "class high" line naming the file under `supabase/migrations/` and the covering verdict, committed before the merge commit, which comes before both applies.
- Break: a copy of the workflow without the `go` condition (or with `needs` removed) turns the order test red. If that test reads the workflow rather than running it, the record says so, and the live run stays the observation.
- The record states what each fixture left in each project and how `main` and both projects came back to "no difference".

**Y-09's test.** A change to `supabase/config.toml` and `supabase/seed.sql` on a branch changes nothing applied: the job's dry-run list and the history are the same with and without it.

**The probes the build must make.**

| Probe | Settles | Where |
|---|---|---|
| P1 | `db push --db-url` through the session pooler, without `link`, from M08's working directory, applies to a hosted Free project and creates and writes `supabase_migrations.schema_migrations`; else P1's fallback (section 2) | The first push run |
| P2 | A failed file leaves neither objects nor a history row; whether `db push` stops at the first failed file | Point 14's failing fixture |
| P3 | Each project's pooler host, found by a step without the credential | Before the first apply |
| P4 | `queue: max` is accepted and keeps two queued runs, neither cancelled; else M06's fallback | Two merges in quick succession, or a push run and a scheduled run queued together |
| P5 | Through the Data API, `session_user` is `authenticator`, never `postgres` (M13) | When `devos_api` is exposed (M26) |
| P6 | Re-runs: a refused run stays refused; an older `main` run ends at M05; whether rules are evaluated again (recorded either way) | Point 8 |
| P7 | A scheduled run on `main` receives the environment's secret | The first scheduled run's presence line |
| P8 | The machine account's permission on `devos` (expected write, not admin); every installed App's permissions (expected none with Administration or Environments write); whether a session can push a workflow file | A read through the GitHub API where a session tool reaches it; otherwise a one-time reading by Batu, as N-175 does |
| P9 | The scheduled connections keep both projects active | Through C02: at least 8 days in which nothing else touched `devos-test` |
| P10 | How the job runs SQL tests in `devos-test`, as which role, with `set role` (Y-05) | W-C02-08's first test run |
| P11 | A per-project property a fixture can test | Before point 14's fixture is written |
| P12 | The CLI binary's checksum matches the release's published one; the checkout action's SHA is a commit of its own repository | The workflow's build |

## 11. How EV-C02-004's decisions are met

| Decision | Met by |
|---|---|
| Y-01 order | M07; section 6 (d) |
| Y-02 caller | M13; PC-41 places 8 and 10 (B:45, B:387) |
| Y-03 `devos_ci` and the pull-request checks | M15, M16; PC-41 places 1, 4 and 11 |
| Y-04 owner-only functions | M24; PC-41 place 7's "Cannot" cell |
| Y-05 owner-level path in `devos-test` | M25, M09; section 6 (c); P10; PC-41 places 7 and 9 |
| Y-06 exposing `devos_api` | M26; section 9 leaves it out of row 1 |
| Y-07 Section 12 item 1 | PC-41 place 5 changes only the migration sentence, old text from eba94b1 |
| Y-08 | M08, M11, M12, M14; section 12 item 3 |
| Y-09 no widening | M08, M09; the list unchanged; Y-09's test (section 10); if the CLI cannot run so, a new item before the first migration merges |
| Y-10 red checks before C03 | M32 |
| Y-11 the first migration | M12; section 12 item 3 |
| Y-12 records outside PC-41 | PC-41 place 12 (`plan/key_inventory.md` rows 23 and 24); "Batu's steps" rows 1 and 1a are the executor's |

## 12. Interfaces assumed (only what EV-C02-004 leaves open)

1. **Where W-C02-07 writes the database tests the job runs.** EV-C02-004 does not say. This design reads them from `supabase/migrations/tests/` (M09), because the job runs them with `devos-test`'s credential and `supabase/tests/` is class normal (CHK-C02-005). If W-C02-07 needs another place, it must be class high; N-233 carries this on `plan/work/C02.md`.
2. **The form of the run report the pull-request checks read** (M15), and that a pull-request check can read a run's log with `actions: read` [inf; no reading quotes the endpoint]. If it cannot, the job writes its report where the check can read it (for example a small artifact), decided at the build.
3. **W-C02-08's first migration content beyond Y-11.** That `deployment_drift`'s branch for `postgres` is placed before the shared derivation that EV3 names (EV-C02-004 X-01, Y-02), and that `devos_ci`'s grant to execute it is W-C02-08's with the other grants.
4. **C04's `session_brief`** computes `expected` by M14's rule; N-232 carries this to `plan/work/C04.md`.

## 13. What this record cannot show

- **Nothing is probed.** Observed: only `devos`'s roles, schemas and missing history table at 15:18Z. Every GitHub and Supabase behaviour is a documentation reading of 2026-10-12; P1 to P12 settle what the design relies on.
- **Not read:** PostgreSQL 17's pages on CREATEROLE (the projects run 17.6; R6a read 18's); the Supabase GitHub App's permissions; the pooler host form; the GitHub REST endpoint for run logs; whether a scoped Supabase token can be made not to expire; whether anything outside DevOS uses either project's database password (Batu's own use; the step tells him the reset ends the old one).
- **Limits of the comparison.** It compares versions and names, not text, and it does not see a change made in a database outside the migration path (the dashboard's SQL screen); a changed applied file is kept out by M16's rule, and objects that came another way by W-C02-08 point 1's ✘ look and point 10's listing. Function versions are read from the job's record, not the live list, until N-230's step exists.
- **Point 9's ✘** is claimed only at the level of the layers named, with D-003's residual and P8's result.
