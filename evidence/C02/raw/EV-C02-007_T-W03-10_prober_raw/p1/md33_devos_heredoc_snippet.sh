set -euo pipefail
cat > "p1/md33_devos_bash/listing.sql" <<'SQL'
\set ON_ERROR_STOP on
begin transaction isolation level repeatable read, read only;
select (
select coalesce(json_agg(o order by o), '[]'::json) from (
  select 'schema ' || n.nspname as o
    from pg_catalog.pg_namespace n
   where n.nspname !~ '^pg_' and n.nspname <> 'information_schema'
     and n.nspname <> all (string_to_array(:'ex_schemas', ' '))
     and n.nspname <> all (string_to_array(:'entry_only', ' '))
  union
  select coalesce('extension ' || e.extname,
                  case when c.relkind in ('v', 'm') then 'view ' else 'table ' end || n.nspname || '.' || c.relname)
    from pg_catalog.pg_class c
    join pg_catalog.pg_namespace n on n.oid = c.relnamespace
    left join pg_catalog.pg_depend d on d.classid = 1259 and d.objid = c.oid and d.deptype = 'e'
    left join pg_catalog.pg_extension e on e.oid = d.refobjid
   where c.relkind in ('r', 'p', 'f', 'v', 'm')
     and n.nspname !~ '^pg_' and n.nspname <> 'information_schema'
     and n.nspname <> all (string_to_array(:'ex_schemas', ' '))
  union
  select coalesce('extension ' || e.extname, 'function ' || n.nspname || '.' || p.proname || '('
                  || pg_catalog.pg_get_function_identity_arguments(p.oid) || ')')
    from pg_catalog.pg_proc p
    join pg_catalog.pg_namespace n on n.oid = p.pronamespace
    left join pg_catalog.pg_depend d on d.classid = 1255 and d.objid = p.oid and d.deptype = 'e'
    left join pg_catalog.pg_extension e on e.oid = d.refobjid
   where n.nspname !~ '^pg_' and n.nspname <> 'information_schema'
     and n.nspname <> all (string_to_array(:'ex_schemas', ' '))
  union
  select 'role ' || r.rolname
    from pg_catalog.pg_roles r
   where r.rolname !~ '^pg_' and r.rolname <> all (string_to_array(:'ex_roles', ' '))
) s
)::text as w03_listing \gset
\echo W03LISTING :w03_listing
commit;
SQL
