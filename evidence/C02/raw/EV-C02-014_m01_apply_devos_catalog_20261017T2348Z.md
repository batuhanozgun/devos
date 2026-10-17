# M09-01 after its apply: `devos`'s catalogue, read through the read-only connector

Read by the executor on 2026-10-17 at about 23:48Z, after run 39080179634 (job `devos` 117535428449, its apply at 23:45:18Z). The connector's answers are transcribed verbatim (the JSON as returned, without its untrusted-data wrapper).

## Read 1: the functions of `devos_api` and `devos_private`

Query: `select n.nspname, p.proname, p.prosecdef, p.proconfig, p.provolatile, coalesce(p.proacl::text,'(default)') as acl from pg_proc p join pg_namespace n on n.oid = p.pronamespace where n.nspname in ('devos_api','devos_private') order by 1,2;`

```
[{"nspname":"devos_api","proname":"deployment_drift","prosecdef":true,"proconfig":["search_path=pg_catalog, pg_temp"],"provolatile":"v","acl":"{postgres=X/postgres,anon=X/postgres}"},{"nspname":"devos_api","proname":"token_role_class","prosecdef":true,"proconfig":["search_path=pg_catalog, pg_temp"],"provolatile":"v","acl":"{postgres=X/postgres,anon=X/postgres}"},{"nspname":"devos_private","proname":"caller_role_class","prosecdef":true,"proconfig":["search_path=pg_catalog, pg_temp"],"provolatile":"v","acl":"{postgres=X/postgres}"},{"nspname":"devos_private","proname":"issue_env_token","prosecdef":true,"proconfig":["search_path=pg_catalog, pg_temp"],"provolatile":"v","acl":"{postgres=X/postgres}"},{"nspname":"devos_private","proname":"refuse_change","prosecdef":false,"proconfig":["search_path=pg_catalog, pg_temp"],"provolatile":"v","acl":"{postgres=X/postgres}"},{"nspname":"devos_private","proname":"reject_counted","prosecdef":true,"proconfig":["search_path=pg_catalog, pg_temp"],"provolatile":"v","acl":"{postgres=X/postgres}"},{"nspname":"devos_private","proname":"revoke_env_token","prosecdef":true,"proconfig":["search_path=pg_catalog, pg_temp"],"provolatile":"v","acl":"{postgres=X/postgres}"},{"nspname":"devos_private","proname":"token_hash","prosecdef":true,"proconfig":["search_path=pg_catalog, pg_temp"],"provolatile":"i","acl":"{postgres=X/postgres}"},{"nspname":"devos_private","proname":"write_event","prosecdef":true,"proconfig":["search_path=pg_catalog, pg_temp"],"provolatile":"v","acl":"{postgres=X/postgres}"}]
```

## Read 2: applied migrations, pgcrypto's schema, token rows

Query: `select (select count(*) from supabase_migrations.schema_migrations) as applied, (select max(version) from supabase_migrations.schema_migrations) as last_version, (select n.nspname from pg_extension e join pg_namespace n on n.oid = e.extnamespace where e.extname = 'pgcrypto') as pgcrypto_schema, (select count(*) from devos_private.env_tokens) as env_token_rows;`

```
[{"applied":13,"last_version":"20261017230001","pgcrypto_schema":"extensions","env_token_rows":0}]
```

## Run 39080179634's jobs (from the job list read through the GitHub tools at about 23:47Z)

| Job | ID | Conclusion | Started | Completed |
|---|---|---|---|---|
| devos-test (apply, compare, test) | 117535365247 | success | 2026-10-17T23:44:44Z | 2026-10-17T23:45:01Z |
| check-devos (compare and search; applies nothing) | 117535366022 | skipped | | |
| check-devos-test (compare and search; applies nothing) | 117535366076 | skipped | | |
| devos (compare, decide, apply) | 117535428449 | success | 2026-10-17T23:45:05Z | 2026-10-17T23:45:23Z |

The two jobs' logs are filed verbatim beside this file (`EV-C02-014_m01_apply_run39080179634_*.log`); the executor's scans over them found 0 plant values and 0 token formats.
