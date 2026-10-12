# T-W03-10 · The C01 probe schema and its tokens do not exist in either project

**Synthetic test data** (plan Section 8 item 13): the objects planted for the sensitivity check are made up for this test. They are a schema `w03_fixture_probe`, a table `w03_fixture_probe.token_hashes`, a view, a function `w03_fixture_probe.f()`, and a role `w03_fixture_probe_role`. They exist only on a throwaway database. Nothing is planted in `devos` or in `devos-test`.

**Serves.** W-C02-03 point 10, and C02's Acceptance line "✔ The C01 probe schema and its tokens no longer exist." Point 10 asks for:
- in each of `devos-test` and `devos`, "a listing of every schema, table, function and database role outside Supabase's own … taken before C02's first migration applies (or after it, with every object put down to the migration that made it) and recorded raw";
- "Every object in it is accounted for, and none is a probe schema, a probe role class or a table of token hashes";
- "Positive control: the same listing shows an object known to exist in that project";
- for the tokens, "the evidence that they were never issued, with its label";
- "A project that no reader reaches is "could not check", never "absent"."

It also serves EV-C02-001 section 10, "Point 10", and M27.

## The listing

This is the build's step (4) in each job; the test fixes what it must show.
- **The query.** One catalog query over schemas, tables and views, functions and roles, excluding Supabase's own by an exclusion list.
- **The exclusion list.** It is kept as data in the workflow and printed with the output. It covers schemas as well as roles. OBS query 2 has a role list only; its schema list (`auth`, `extensions`, `graphql`, `graphql_public`, `pgbouncer`, `realtime`, `storage`, `vault`, `supabase_migrations`, and `public` only if the build says why) must be written down.
- **Extension-owned objects.** Objects that belong to an extension, by their `pg_depend` dependency of type `e`, are reported by extension name rather than dropped silently.
- **Who reads it.**
  - In `devos-test`, the job's own read: the first push run after Batu's step, before the first apply. That is step (4), before (6).
  - In `devos`, the job's own read, and also the builder's read-only connection, recorded with its UTC time. That connection runs one statement and no psql meta-command, so it runs `T-W03-10_devos_listing.sql`: the listing step's own text with only the psql wrapper removed and the three variables written in from the workflow's values (the file's header names each change). On a throwaway database, with and without the planted objects, it gives the same list as the step's text run with psql and the workflow's `-v` values; a prober repeats that check at the commit read, and the record keeps both outputs.
- **What it records beside it.** Each listing records the latest comparison result for that project, with its commit, or that `deployment_drift` does not exist yet (M16).

## Form C0

| Field | Content |
|---|---|
| **ID and claim** | T-W03-10. In each project, every schema, table or view, function and role outside Supabase's own is listed, and each is accounted for: made by a named migration, or there before C02 with a named reason. None is a probe schema, a probe role class or a table of token hashes. The probe tokens were never issued, according to DevOS's records. |
| **Failure class rule** | Something outside Supabase's own exists and is not accounted for, or the listing could not have shown it. Examples of this family: a leftover schema; a role class; a token-hash table; an object hidden by an over-broad exclusion list; a listing read from the wrong project; a project not reached and reported "absent". |
| **Examples** | (a) `devos`'s listing; (b) `devos-test`'s listing; (c) the tokens' records. Sensitivity, with the planted objects: (d) a planted schema with a table named `token_hashes`; (e) a planted role. |
| **Negative control** | In (a) and (b), each listed object has its account: a migration file and version, or Supabase's own by the printed list. An object without an account fails the test. A name or table of the probe's kind fails it outright. Before the first migration, the expected listing holds the schema `public` and nothing else, unless the build's printed exclusion list leaves `public` out with a stated reason. `public` is accounted as "there before C02", the default schema every project is created with. OBS at 15:18:13Z showed `devos` with Supabase's schemas and `public` only, as an early listing, not this test's. Excluding the schema `public` must not hide what is inside it: a table, view or function in `public` is listed and needs its own account either way. The design's "Expected: nothing found" (EV-C02-001 section 10, point 10) is read as "nothing without an account". |
| **Positive control** | Two parts. (i) As the design gives it: the same query without the exclusion list shows `auth.users` in each project, so the query reads that project's catalog. (ii) Added here, because (i) does not catch an exclusion list that hides everything: with the exclusion list applied, the listing shows (d) and (e). These are planted on a throwaway PostgreSQL database, and the listing run there is the listing step's own `listing.sql`, taken from `migrate.yml` (job `devos-test`, step `listing`) byte for byte and run with psql and the workflow's own `-v` values (`W03_EXCLUDED_SCHEMAS`, `W03_SCHEMA_ENTRY_ONLY`, `W03_EXCLUDED_ROLES`), as the step runs it. Not through `devos-test`'s database-test runner: that runner refuses any file holding a backslash, and the query uses psql's `\set`, `\gset` and `\echo` and psql variables. The result is labelled with the throwaway's PostgreSQL version; the projects run 17.6, so a result on another major version is supporting evidence for the projects, not an observation of them. In `devos`, after the first migration, DevOS's own objects (`devos_api`, `devos_private` and their contents) appear in the listing with their accounts, which is the same check without planting. |
| **Break attempt** | On the same throwaway database and planted state, with the same `listing.sql` text: a copy of the listing with the exclusion list widened to cover the planted schema and role (the `-v` values extended by `w03_fixture_probe` and `w03_fixture_probe_role`), or a query that lists nothing, must turn the test red: (d) and (e) missing. A copy whose account step accepts any object as accounted must fail on a planted object with no migration. The account step is the record's account table (object, migration, version), made from the listing's output; its break is run by the prober on the throwaway listing's output. |
| **Stage and environment** | C02.<br>• (a) and (b): the first push run after Batu's step 1, before the first apply (or after it, with accounts). In `devos` the builder's read-only connection reads too, with `T-W03-10_devos_listing.sql`.<br>• (d), (e) and the two breaks: a throwaway PostgreSQL cluster (any harness that gives a `postgres` login and stand-ins for Supabase's roles and `auth.users`; W-C02-07's harness is not needed), its version labelled.<br>• (c): `plan/key_inventory.md` rows 16 and 17 ("never created", 2026-10-12, W-C01-47 item 5) and PC-21 item 1, labelled as DevOS's records, not an observation.<br>Probes relied on: P1 (the tool creates `supabase_migrations` at its first push, so it is Supabase's own after that). |
| **Independence level** | Written by the test designer. The listings are taken by the job; the job logs are saved unedited by the executor, who also makes the `devos` read through the read-only connection; a prober (fresh-context subagent, declared) analyses the saved listings, builds the account table, and runs (d), (e) and the breaks on the throwaway database. Assessed by the fresh-context checker of point 13 from the raw listings and the prober's raw output. Shared: model lineage, design record. The test designer's own run of (d), (e) and the widened-list copy on PostgreSQL 16.15 with stand-ins (the planted objects listed, then hidden by the widened copy) is a self-check of the test, not its result. |
| **Evidence layer** | Structural (the catalog). The tokens' absence is a records claim, labelled as such. |
| **Evidence envelope** | As in the README. `observations_ref`: each listing's run ID and step, or the query's UTC time; the exclusion list as printed; the account table (object, migration, version). |

## Could not check

- A project no reader reaches. That project's listing is "could not check", never "absent". In `devos-test`, the job's read is the only reader.
- A listing without its printed exclusion list.
- (d) and (e), if no throwaway database is available. The record then says that the exclusion list's coverage rests on its printed text only.
- The `devos` read through the read-only connection, if `T-W03-10_devos_listing.sql` and the step's text run with psql give different lists on the throwaway database, or if the workflow's listing or its lists changed after the file was derived and it was not derived again.

## Depends on R1 to R6

R6 does not apply to the listing itself. If the first-migration exception uses the same listing (section 5: "the same query as (4)"), part D of T-W03-DEC applies to it within the exception's reads. P13's widening (the executor's decision of 2026-10-12; T-W03-DEC "Depends on") takes an empty history table, so the exception's listing counts `supabase_migrations` as Supabase's own; this test's exclusion list already does.
