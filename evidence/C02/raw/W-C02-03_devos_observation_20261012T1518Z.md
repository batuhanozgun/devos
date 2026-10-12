# `devos` observed through the builder's read-only connection, 2026-10-12 15:18Z (W-C02-03 input)

**What this is.** Raw results of two read-only SQL queries the executor ran against `devos` through the read-only Supabase connection (role `supabase_read_only_user`, which reaches `devos` only; EV-C00-002 item 8), after Batu resumed the project (L-286). Ordinary self-observation of DevOS's own project (D-017 item 2 (a)). It is input to W-C02-03's design (the migration credential's role, point 1 (a); the record of applied migrations, point 1 (c)) and an early listing toward point 10, which still needs its own listing in both projects before C02's first migration applies. `devos-test` is not in this connection's reach and was not observed.

## Query 1 (2026-10-12T15:18:10Z)

```sql
select now() as observed_at, version() as pg_version, (select json_agg(json_build_object('role', rolname, 'super', rolsuper, 'createrole', rolcreaterole, 'createdb', rolcreatedb, 'bypassrls', rolbypassrls, 'login', rolcanlogin) order by rolname) from pg_roles where rolname in ('postgres','authenticator','service_role','anon','authenticated','supabase_admin','cli_login_postgres','supabase_read_only_user')) as roles
```

Result, verbatim:

```
[{"observed_at":"2026-10-12 15:18:10.801526+00","pg_version":"PostgreSQL 17.6 on aarch64-unknown-linux-gnu, compiled by gcc (GCC) 15.2.0, 64-bit","roles":[{"role":"anon","super":false,"createrole":false,"createdb":false,"bypassrls":false,"login":false},{"role":"authenticated","super":false,"createrole":false,"createdb":false,"bypassrls":false,"login":false},{"role":"authenticator","super":false,"createrole":false,"createdb":false,"bypassrls":false,"login":true},{"role":"postgres","super":false,"createrole":true,"createdb":true,"bypassrls":true,"login":true},{"role":"service_role","super":false,"createrole":false,"createdb":false,"bypassrls":true,"login":false},{"role":"supabase_admin","super":true,"createrole":true,"createdb":true,"bypassrls":true,"login":true},{"role":"supabase_read_only_user","super":false,"createrole":false,"createdb":false,"bypassrls":true,"login":true}]}]
```

No `cli_login_postgres` role exists at that time (it was asked for and is absent from the result).

## Query 2 (2026-10-12T15:18:13Z)

```sql
select now() as observed_at, (select json_agg(nspname order by nspname) from pg_namespace where nspname not like 'pg\_%' and nspname <> 'information_schema') as schemas, (select json_agg(rolname order by rolname) from pg_roles where rolname not like 'pg\_%' and rolname not in ('postgres','authenticator','service_role','anon','authenticated','dashboard_user','pgbouncer','pgsodium_keyholder','pgsodium_keyiduser','pgsodium_keymaker','supabase_admin','supabase_auth_admin','supabase_functions_admin','supabase_read_only_user','supabase_realtime_admin','supabase_replication_admin','supabase_storage_admin','supabase_etl_admin','supabase_privileged_role')) as other_roles, to_regclass('supabase_migrations.schema_migrations') as history_table
```

Result, verbatim:

```
[{"observed_at":"2026-10-12 15:18:13.235948+00","schemas":["auth","extensions","graphql","graphql_public","pgbouncer","public","realtime","storage","vault"],"other_roles":null,"history_table":null}]
```

## Reading (the executor's; inference where marked)

- PostgreSQL 17.6 (observed). R6a read PostgreSQL 18's pages on CREATEROLE; the rules for version 17 are for the design to read or probe.
- `postgres` is not a superuser and holds CREATEROLE, CREATEDB and BYPASSRLS (observed).
- Schemas: Supabase's own and `public` only; no probe schema and no DevOS schema (observed).
- Roles: no role outside the names excluded in query 2 (observed; the exclusion list is the executor's list of Supabase's own roles, so a role with one of those names would not show here).
- `supabase_migrations.schema_migrations` does not exist yet (observed), matching the connection's empty `list_migrations` at 15:14:54Z.
