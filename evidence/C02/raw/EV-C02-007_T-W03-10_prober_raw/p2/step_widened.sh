export W03_EXCLUDED_SCHEMAS='auth extensions graphql graphql_public pgbouncer realtime storage vault supabase_migrations w03_fixture_probe'
export W03_SCHEMA_ENTRY_ONLY=public
export W03_EXCLUDED_ROLES='postgres authenticator service_role anon authenticated dashboard_user pgbouncer pgsodium_keyholder pgsodium_keyiduser pgsodium_keymaker supabase_admin supabase_auth_admin supabase_functions_admin supabase_read_only_user supabase_realtime_admin supabase_replication_admin supabase_storage_admin supabase_etl_admin supabase_privileged_role w03_fixture_probe_role'
export PGHOST=/tmp/claude-0/-home-user-devos/0cb29c90-d12e-56b6-9751-2217078b0a90/scratchpad/prb10/pg/sock
export PGPORT=54716
export PGUSER=postgres
export PGDATABASE=postgres
export GITHUB_OUTPUT=/tmp/claude-0/-home-user-devos/0cb29c90-d12e-56b6-9751-2217078b0a90/scratchpad/prb10/p2/work_widened/github_output
mkdir -p /tmp/claude-0/-home-user-devos/0cb29c90-d12e-56b6-9751-2217078b0a90/scratchpad/prb10/p2/work_widened
set -uo pipefail
trap 'echo "listing: could not check (a command of this step failed, line ${LINENO})"' ERR
w=/tmp/claude-0/-home-user-devos/0cb29c90-d12e-56b6-9751-2217078b0a90/scratchpad/prb10/p2/work_widened
cat > "$w/listing.sql" <<'SQL'
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
echo "listing (W-C02-03 point 10): every schema, table, view, function and role outside Supabase's own"
echo "  exclusion list, kept as data in this workflow:"
echo "  schemas excluded with their contents (Supabase's own): ${W03_EXCLUDED_SCHEMAS}"
echo "  schema entries excluded, their contents still listed: ${W03_SCHEMA_ENTRY_ONLY} (the default schema every project is created with)"
echo "  roles excluded (Supabase's own), besides every pg_* role: ${W03_EXCLUDED_ROLES}"
echo "  objects that belong to an extension are listed as that extension"
timeout 120 psql -X -q -A -t -v ex_schemas="$W03_EXCLUDED_SCHEMAS" -v entry_only="$W03_SCHEMA_ENTRY_ONLY" \
  -v ex_roles="$W03_EXCLUDED_ROLES" -f "$w/listing.sql" > "$w/out" 2> "$w/err" && rc=0 || rc=$?
timeout 120 psql -X -q -A -t -v ex_schemas= -v entry_only= -v ex_roles= -f "$w/listing.sql" > "$w/control" 2>> "$w/err" || true
W03_RC=$rc W03_DIR="$w" python3 -I - <<'PY' || exit $?
import json, os
def esc(s):
    return "".join(c if c.isprintable() else ascii(c)[1:-1] for c in str(s))
d = os.environ["W03_DIR"]
def listing(name):
    for ln in open(os.path.join(d, name), encoding="utf-8"):
        if ln.startswith("W03LISTING "):
            try:
                v = json.loads(ln[len("W03LISTING "):])
                return v if isinstance(v, list) else None
            except ValueError:
                return None
    return None
items, control = listing("out"), listing("control")
for ln in open(os.path.join(d, "err"), encoding="utf-8"):
    print("psql: " + esc(ln.rstrip()))
if os.environ["W03_RC"] != "0" or items is None:
    print("listing: could not check (the read did not complete)")
    count = ""
else:
    for item in items:
        print("listing: " + esc(item))
    count = str(len(items))
    print(f"listing: {count} objects outside Supabase's own")
if control is None:
    print("listing control: could not check (the same query without the exclusion list did not complete)")
else:
    print(f"listing control: the same query without the exclusion list shows {len(control)} objects; "
          f"auth.users among them: {'yes' if 'table auth.users' in control else 'no'}")
with open(os.environ["GITHUB_OUTPUT"], "a", encoding="utf-8") as f:
    f.write(f"count={count}\n")
raise SystemExit(0 if count else 1)
PY
