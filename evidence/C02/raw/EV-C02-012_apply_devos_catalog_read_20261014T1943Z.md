# W-C02-08's apply: a read of `devos`'s catalog after the push run (verdict (ii))

Made by the executor on 2026-10-14 through the read-only Supabase connector (`execute_sql`, which reads `devos` only; its database role cannot write). `devos-test` has no such connector: its catalog is seen through the job's own steps (the listing, `deployment_drift` and the database tests, in its job log). The query and its result, verbatim.

## The query

```sql
select json_build_object(
 'read_at', now(),
 'server_version', current_setting('server_version'),
 'applied_versions', (select json_agg(version order by version) from supabase_migrations.schema_migrations),
 'devos_schemas', (select json_agg(json_build_object('schema', nspname, 'acl', nspacl::text) order by nspname) from pg_namespace where nspname in ('devos_private','devos_api')),
 'relations_by_kind', (select json_object_agg(k, n) from (select n.nspname||':'||c.relkind::text as k, count(*) as n from pg_class c join pg_namespace n on n.oid=c.relnamespace where n.nspname in ('devos_private','devos_api') and c.relkind in ('r','v','m','p','S','f') group by 1) s),
 'relation_grantees_outside_owner', (select json_agg(distinct json_build_object('grantee', coalesce(r.rolname,'PUBLIC'), 'priv', a.privilege_type)::text) from pg_class c join pg_namespace n on n.oid=c.relnamespace cross join lateral aclexplode(coalesce(c.relacl, acldefault('r', c.relowner))) a left join pg_roles r on r.oid=a.grantee where n.nspname in ('devos_private','devos_api') and c.relkind in ('r','v','m','p','S','f') and a.grantee <> c.relowner),
 'type_grantees_non_array', (select json_agg(distinct json_build_object('grantee', coalesce(r.rolname,'PUBLIC'), 'priv', a.privilege_type)::text) from pg_type t join pg_namespace n on n.oid=t.typnamespace cross join lateral aclexplode(coalesce(t.typacl, acldefault('T', t.typowner))) a left join pg_roles r on r.oid=a.grantee where n.nspname='devos_private' and t.typcategory <> 'A' and a.grantee <> t.typowner),
 'types_by_kind', (select json_object_agg(k, n) from (select case when t.typcategory='A' then 'array' when t.typtype='e' then 'enum' when t.typtype='c' then 'row' else t.typtype::text end as k, count(*) n from pg_type t join pg_namespace n on n.oid=t.typnamespace where n.nspname='devos_private' group by 1) s),
 'type_usable_by_app_roles', (select count(*) from pg_type t join pg_namespace n on n.oid=t.typnamespace cross join (values ('public'),('anon'),('authenticated'),('authenticator'),('service_role')) v(r) where n.nspname='devos_private' and has_type_privilege(v.r, t.oid, 'USAGE')),
 'functions', (select json_agg(json_build_object('fn', n.nspname||'.'||p.proname, 'acl', p.proacl::text)) from pg_proc p join pg_namespace n on n.oid=p.pronamespace where n.nspname in ('devos_private','devos_api')),
 'default_acl_devos', (select json_agg(json_build_object('role', pg_get_userbyid(d.defaclrole), 'schema', n.nspname, 'type', d.defaclobjtype::text, 'acl', d.defaclacl::text)) from pg_default_acl d left join pg_namespace n on n.oid=d.defaclnamespace where n.nspname in ('devos_private','devos_api') or d.defaclnamespace=0),
 'finding_revision_source_fields', (select json_agg(json_build_object('col', a.attname, 'type', format_type(a.atttypid, a.atttypmod), 'not_null', a.attnotnull) order by a.attnum) from pg_attribute a join pg_class c on c.oid=a.attrelid join pg_namespace n on n.oid=c.relnamespace where n.nspname='devos_private' and c.relname='finding_revision' and a.attname in ('source_type','epistemic_status','current_authority')),
 'one_active_claim_index', (select json_agg(indexname) from pg_indexes where schemaname='devos_private' and indexname='assignment_one_active_claim'),
 'transfer_check', (select json_agg(conname order by conname) from pg_constraint c join pg_namespace n on n.oid=c.connamespace where n.nspname='devos_private' and conname='event_transferred_transfer_source'),
 'transfer_indexes', (select json_agg(indexname order by indexname) from pg_indexes where schemaname='devos_private' and indexname in ('event_one_ledger_handover','event_transferred_key')),
 'authenticator_config', (select rolconfig::text from pg_roles where rolname='authenticator'),
 'tables_with_rows', (select json_agg(relname order by relname) from pg_stat_user_tables where schemaname='devos_private' and n_live_tup > 0)
) as r
```

## The result

```json
[
 {
  "r": {
   "read_at": "2026-10-14T19:43:04.680719+00:00",
   "server_version": "17.6",
   "applied_versions": [
    "20261012184638",
    "20261012231841",
    "20261012232112",
    "20261012232113",
    "20261014170201",
    "20261014170202",
    "20261014170203",
    "20261014170204",
    "20261014170205",
    "20261014182601",
    "20261014190401",
    "20261014190402"
   ],
   "devos_schemas": [
    {
     "schema": "devos_api",
     "acl": "{postgres=UC/postgres,anon=U/postgres}"
    },
    {
     "schema": "devos_private",
     "acl": "{postgres=UC/postgres}"
    }
   ],
   "relations_by_kind": {
    "devos_private:v": 5,
    "devos_private:S": 3,
    "devos_private:r": 27
   },
   "relation_grantees_outside_owner": null,
   "type_grantees_non_array": null,
   "types_by_kind": {
    "enum": 32,
    "row": 32,
    "array": 64
   },
   "type_usable_by_app_roles": 0,
   "functions": [
    {
     "fn": "devos_private.refuse_change",
     "acl": "{postgres=X/postgres}"
    },
    {
     "fn": "devos_api.deployment_drift",
     "acl": "{postgres=X/postgres}"
    }
   ],
   "default_acl_devos": null,
   "finding_revision_source_fields": [
    {
     "col": "source_type",
     "type": "devos_private.source_type",
     "not_null": false
    },
    {
     "col": "epistemic_status",
     "type": "devos_private.epistemic_status",
     "not_null": true
    },
    {
     "col": "current_authority",
     "type": "devos_private.current_authority",
     "not_null": true
    }
   ],
   "one_active_claim_index": [
    "assignment_one_active_claim"
   ],
   "transfer_check": [
    "event_transferred_transfer_source"
   ],
   "transfer_indexes": [
    "event_one_ledger_handover",
    "event_transferred_key"
   ],
   "authenticator_config": "{\"session_preload_libraries=supautils, safeupdate\",statement_timeout=8s,lock_timeout=8s}",
   "tables_with_rows": [
    "global_authority_epoch"
   ]
  }
 }
]
```
