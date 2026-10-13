-- W-C02-03 T-W03-10 (a): point 10's listing in devos, read by the builder's read-only connection (EV-C00-002 item 8),
-- which runs one statement and no psql meta-command. Derived from the listing step's own listing.sql in
-- .github/workflows/migrate.yml at main d33c8e9 (job devos-test, step listing; job devos's copy is the same text),
-- by these changes only: the lines "\set ON_ERROR_STOP on", "begin transaction isolation level repeatable read,
-- read only;", "\echo W03LISTING :w03_listing" and "commit;" removed; "\gset" after the alias replaced by ";"; and
-- the psql variables :'ex_schemas', :'entry_only' and :'ex_roles' replaced by the literal values of the workflow's
-- W03_EXCLUDED_SCHEMAS, W03_SCHEMA_ENTRY_ONLY and W03_EXCLUDED_ROLES. One statement is one snapshot. The test
-- designer ran both on a throwaway PostgreSQL 16.15 database, with and without planted objects: the same list each
-- time (T-W03-10, "Who reads it"). If the workflow's listing or its lists change, this file is derived again first.
-- The result is one row, w03_listing, a JSON list of every schema, table, view, function and role outside Supabase's own.
select (
select coalesce(json_agg(o order by o), '[]'::json) from (
  select 'schema ' || n.nspname as o
    from pg_catalog.pg_namespace n
   where n.nspname !~ '^pg_' and n.nspname <> 'information_schema'
     and n.nspname <> all (string_to_array('auth extensions graphql graphql_public pgbouncer realtime storage vault supabase_migrations', ' '))
     and n.nspname <> all (string_to_array('public', ' '))
  union
  select coalesce('extension ' || e.extname,
                  case when c.relkind in ('v', 'm') then 'view ' else 'table ' end || n.nspname || '.' || c.relname)
    from pg_catalog.pg_class c
    join pg_catalog.pg_namespace n on n.oid = c.relnamespace
    left join pg_catalog.pg_depend d on d.classid = 1259 and d.objid = c.oid and d.deptype = 'e'
    left join pg_catalog.pg_extension e on e.oid = d.refobjid
   where c.relkind in ('r', 'p', 'f', 'v', 'm')
     and n.nspname !~ '^pg_' and n.nspname <> 'information_schema'
     and n.nspname <> all (string_to_array('auth extensions graphql graphql_public pgbouncer realtime storage vault supabase_migrations', ' '))
  union
  select coalesce('extension ' || e.extname, 'function ' || n.nspname || '.' || p.proname || '('
                  || pg_catalog.pg_get_function_identity_arguments(p.oid) || ')')
    from pg_catalog.pg_proc p
    join pg_catalog.pg_namespace n on n.oid = p.pronamespace
    left join pg_catalog.pg_depend d on d.classid = 1255 and d.objid = p.oid and d.deptype = 'e'
    left join pg_catalog.pg_extension e on e.oid = d.refobjid
   where n.nspname !~ '^pg_' and n.nspname <> 'information_schema'
     and n.nspname <> all (string_to_array('auth extensions graphql graphql_public pgbouncer realtime storage vault supabase_migrations', ' '))
  union
  select 'role ' || r.rolname
    from pg_catalog.pg_roles r
   where r.rolname !~ '^pg_' and r.rolname <> all (string_to_array('postgres authenticator service_role anon authenticated dashboard_user pgbouncer pgsodium_keyholder pgsodium_keyiduser pgsodium_keymaker supabase_admin supabase_auth_admin supabase_functions_admin supabase_read_only_user supabase_realtime_admin supabase_replication_admin supabase_storage_admin supabase_etl_admin supabase_privileged_role', ' '))
) s
)::text as w03_listing;
