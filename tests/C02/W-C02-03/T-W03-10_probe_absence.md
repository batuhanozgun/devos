# T-W03-10 · The C01 probe schema and its tokens do not exist in either project

**Synthetic test data** (plan Section 8 item 13): the objects planted for the sensitivity check are made up for this test. They are a schema `w03_fixture_probe`, a table `w03_fixture_probe.token_hashes`, a view, a function `w03_fixture_probe.f()`, and a role `w03_fixture_probe_role`. They exist only inside a rolled-back transaction in `devos-test`, or on a throwaway database. Nothing is planted in `devos`.

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
  - In `devos`, the job's own read, and also the builder's read-only connection with the same query text, recorded with its UTC time.
- **What it records beside it.** Each listing records the latest comparison result for that project, with its commit, or that `deployment_drift` does not exist yet (M16).

## Form C0

| Field | Content |
|---|---|
| **ID and claim** | T-W03-10. In each project, every schema, table or view, function and role outside Supabase's own is listed, and each is accounted for: made by a named migration, or there before C02 with a named reason. None is a probe schema, a probe role class or a table of token hashes. The probe tokens were never issued, according to DevOS's records. |
| **Failure class rule** | Something outside Supabase's own exists and is not accounted for, or the listing could not have shown it. Examples of this family: a leftover schema; a role class; a token-hash table; an object hidden by an over-broad exclusion list; a listing read from the wrong project; a project not reached and reported "absent". |
| **Examples** | (a) `devos`'s listing; (b) `devos-test`'s listing; (c) the tokens' records. Sensitivity, with the planted objects: (d) a planted schema with a table named `token_hashes`; (e) a planted role. |
| **Negative control** | In (a) and (b), each listed object has its account: a migration file and version, or Supabase's own by the printed list. An object without an account fails the test. A name or table of the probe's kind fails it outright. Before the first migration, the expected listing is empty; OBS at 15:18:13Z showed `devos` with Supabase's schemas and `public` only, as an early listing, not this test's. |
| **Positive control** | Two parts. (i) As the design gives it: the same query without the exclusion list shows `auth.users` in each project, so the query reads that project's catalog. (ii) Added here, because (i) does not catch an exclusion list that hides everything: with the exclusion list applied, the listing shows (d) and (e). These are planted inside a rolled-back transaction by the job's test step in `devos-test`, or on the throwaway database, using the listing query's own text, read from the workflow and compared byte for byte. In `devos`, after the first migration, DevOS's own objects (`devos_api`, `devos_private` and their contents) appear in the listing with their accounts, which is the same check without planting. |
| **Break attempt** | A copy of the listing with the exclusion list widened to cover the planted schema and role (or a query that lists nothing) is run on the planted state, and must turn the test red: (d) and (e) missing. A copy whose account step accepts any object as accounted must fail on a planted object with no migration. |
| **Stage and environment** | C02.<br>• (a) and (b): the first push run after Batu's step 1, before the first apply (or after it, with accounts). In `devos` the builder's read-only connection reads too.<br>• (d) and (e): `devos-test` inside a rolled-back transaction of the job's test step (P10), or W-C02-07's throwaway database.<br>• (c): `plan/key_inventory.md` rows 16 and 17 ("never created", 2026-10-12, W-C01-47 item 5) and PC-21 item 1, labelled as DevOS's records, not an observation.<br>Probes relied on: P1 (the tool creates `supabase_migrations` at its first push, so it is Supabase's own after that), P10. |
| **Independence level** | Written by the test designer. The listings are taken by the job and by the build producer through the read-only connection. Assessed by the fresh-context checker of point 13 from the raw listings. Shared: model lineage, design record. |
| **Evidence layer** | Structural (the catalog). The tokens' absence is a records claim, labelled as such. |
| **Evidence envelope** | As in the README. `observations_ref`: each listing's run ID and step, or the query's UTC time; the exclusion list as printed; the account table (object, migration, version). |

## Could not check

- A project no reader reaches. That project's listing is "could not check", never "absent". In `devos-test`, the job's read is the only reader.
- A listing without its printed exclusion list.
- (d) and (e), if neither a rolled-back transaction in `devos-test` nor the throwaway database is available. The record then says that the exclusion list's coverage rests on its printed text only.

## Depends on R1 to R6

R6 does not apply to the listing itself. If the first-migration exception uses the same listing (section 5: "the same query as (4)"), part D of T-W03-DEC applies to it within the exception's reads. P13's possible widening would count `supabase_migrations` as Supabase's own, which this test's exclusion list already does.
