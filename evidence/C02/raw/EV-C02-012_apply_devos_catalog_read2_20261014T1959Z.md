# W-C02-08's apply: a second read of `devos`'s catalog (CHK-C02-070 C1)

Made by the executor on 2026-10-14 through the read-only Supabase connector (`execute_sql`, `devos` only). It reads what C1 (a) to (d) name: every relation of `devos_private` and `devos_api` by name and kind; column ACLs of `devos_private`'s relations; `pgrst.db_schemas` entries in `pg_db_role_setting` over every database and role; Decision's status labels, Finding's `changeable` labels, the S4 columns, and the two Event checks. The query and its result, verbatim.

## The query

```sql
select json_build_object(
 'read_at', now(),
 'relations', (select json_agg(json_build_object('schema', n.nspname, 'kind', c.relkind::text, 'name', c.relname) order by n.nspname, c.relkind::text, c.relname) from pg_class c join pg_namespace n on n.oid=c.relnamespace where n.nspname in ('devos_private','devos_api') and c.relkind in ('r','v','m','p','S','f')),
 'column_acl_grantees', (select json_agg(json_build_object('rel', c.relname, 'col', a.attname, 'grantee', coalesce(r.rolname,'PUBLIC'), 'priv', x.privilege_type)) from pg_attribute a join pg_class c on c.oid=a.attrelid join pg_namespace n on n.oid=c.relnamespace cross join lateral aclexplode(a.attacl) x left join pg_roles r on r.oid=x.grantee where n.nspname='devos_private' and a.attacl is not null and a.attnum > 0),
 'columns_with_acl', (select count(*) from pg_attribute a join pg_class c on c.oid=a.attrelid join pg_namespace n on n.oid=c.relnamespace where n.nspname='devos_private' and a.attacl is not null and a.attnum > 0),
 'pgrst_db_schemas_settings', (select json_agg(json_build_object('db', coalesce(d.datname,'(all)'), 'role', coalesce(r.rolname,'(all)'), 'setting', s.cfg)) from pg_db_role_setting rs left join pg_database d on d.oid=rs.setdatabase left join pg_roles r on r.oid=rs.setrole cross join lateral unnest(rs.setconfig) s(cfg) where s.cfg like 'pgrst.db_schemas%'),
 'pgrst_naming_devos_private', (select count(*) from pg_db_role_setting rs cross join lateral unnest(rs.setconfig) s(cfg) where s.cfg like 'pgrst.db_schemas%' and s.cfg like '%devos_private%'),
 'decision_status_labels', (select json_agg(e.enumlabel order by e.enumsortorder) from pg_enum e join pg_type t on t.oid=e.enumtypid join pg_namespace n on n.oid=t.typnamespace where n.nspname='devos_private' and t.typname='decision_status'),
 'finding_changeable_labels', (select json_agg(e.enumlabel order by e.enumsortorder) from pg_enum e join pg_type t on t.oid=e.enumtypid join pg_namespace n on n.oid=t.typnamespace where n.nspname='devos_private' and t.typname='finding_changeable'),
 's4_columns', (select json_agg(json_build_object('rel', c.relname, 'col', a.attname, 'type', format_type(a.atttypid, a.atttypmod), 'not_null', a.attnotnull) order by c.relname, a.attname) from pg_attribute a join pg_class c on c.oid=a.attrelid join pg_namespace n on n.oid=c.relnamespace where n.nspname='devos_private' and ((c.relname='finding_revision' and a.attname in ('changeable','counter_evidence_searched')) or (c.relname='artifact_revision' and a.attname='kind') or (c.relname='acceptance' and a.attname='accepted_use'))),
 'event_type_check', (select json_agg(json_build_object('name', conname, 'def', pg_get_constraintdef(c.oid))) from pg_constraint c join pg_namespace n on n.oid=c.connamespace where n.nspname='devos_private' and conname in ('event_event_type_check','event_transferred_transfer_source'))
) as r
```

## The result

```json
[
 {
  "r": {
   "read_at": "2026-10-14T19:59:41.438836+00:00",
   "relations": [
    {
     "schema": "devos_private",
     "kind": "r",
     "name": "acceptance"
    },
    {
     "schema": "devos_private",
     "kind": "r",
     "name": "artifact"
    },
    {
     "schema": "devos_private",
     "kind": "r",
     "name": "artifact_revision"
    },
    {
     "schema": "devos_private",
     "kind": "r",
     "name": "assignment"
    },
    {
     "schema": "devos_private",
     "kind": "r",
     "name": "decision"
    },
    {
     "schema": "devos_private",
     "kind": "r",
     "name": "decision_revision"
    },
    {
     "schema": "devos_private",
     "kind": "r",
     "name": "effect_class"
    },
    {
     "schema": "devos_private",
     "kind": "r",
     "name": "effort_policy"
    },
    {
     "schema": "devos_private",
     "kind": "r",
     "name": "env_tokens"
    },
    {
     "schema": "devos_private",
     "kind": "r",
     "name": "eval_run"
    },
    {
     "schema": "devos_private",
     "kind": "r",
     "name": "event"
    },
    {
     "schema": "devos_private",
     "kind": "r",
     "name": "finding"
    },
    {
     "schema": "devos_private",
     "kind": "r",
     "name": "finding_revision"
    },
    {
     "schema": "devos_private",
     "kind": "r",
     "name": "function_deployment"
    },
    {
     "schema": "devos_private",
     "kind": "r",
     "name": "global_authority_epoch"
    },
    {
     "schema": "devos_private",
     "kind": "r",
     "name": "leak_fingerprint"
    },
    {
     "schema": "devos_private",
     "kind": "r",
     "name": "mission"
    },
    {
     "schema": "devos_private",
     "kind": "r",
     "name": "mission_revision"
    },
    {
     "schema": "devos_private",
     "kind": "r",
     "name": "need"
    },
    {
     "schema": "devos_private",
     "kind": "r",
     "name": "observation"
    },
    {
     "schema": "devos_private",
     "kind": "r",
     "name": "operation"
    },
    {
     "schema": "devos_private",
     "kind": "r",
     "name": "rejected_attempt"
    },
    {
     "schema": "devos_private",
     "kind": "r",
     "name": "relation"
    },
    {
     "schema": "devos_private",
     "kind": "r",
     "name": "review"
    },
    {
     "schema": "devos_private",
     "kind": "r",
     "name": "verdict"
    },
    {
     "schema": "devos_private",
     "kind": "r",
     "name": "work"
    },
    {
     "schema": "devos_private",
     "kind": "r",
     "name": "work_revision"
    },
    {
     "schema": "devos_private",
     "kind": "S",
     "name": "event_id_seq"
    },
    {
     "schema": "devos_private",
     "kind": "S",
     "name": "leak_fingerprint_id_seq"
    },
    {
     "schema": "devos_private",
     "kind": "S",
     "name": "rejected_attempt_id_seq"
    },
    {
     "schema": "devos_private",
     "kind": "v",
     "name": "artifact_current"
    },
    {
     "schema": "devos_private",
     "kind": "v",
     "name": "decision_current"
    },
    {
     "schema": "devos_private",
     "kind": "v",
     "name": "finding_current"
    },
    {
     "schema": "devos_private",
     "kind": "v",
     "name": "mission_current"
    },
    {
     "schema": "devos_private",
     "kind": "v",
     "name": "work_current"
    }
   ],
   "column_acl_grantees": null,
   "columns_with_acl": 0,
   "pgrst_db_schemas_settings": null,
   "pgrst_naming_devos_private": 0,
   "decision_status_labels": [
    "draft",
    "open",
    "answered",
    "accepted",
    "declined",
    "superseded",
    "withdrawn"
   ],
   "finding_changeable_labels": [
    "yes",
    "no",
    "not_recorded"
   ],
   "s4_columns": [
    {
     "rel": "acceptance",
     "col": "accepted_use",
     "type": "text",
     "not_null": true
    },
    {
     "rel": "artifact_revision",
     "col": "kind",
     "type": "text",
     "not_null": true
    },
    {
     "rel": "finding_revision",
     "col": "changeable",
     "type": "devos_private.finding_changeable",
     "not_null": true
    },
    {
     "rel": "finding_revision",
     "col": "counter_evidence_searched",
     "type": "text",
     "not_null": true
    }
   ],
   "event_type_check": [
    {
     "name": "event_event_type_check",
     "def": "CHECK ((event_type ~ '^[a-z][a-z0-9_]*$'::text))"
    },
    {
     "name": "event_transferred_transfer_source",
     "def": "CHECK (((event_type <> 'transferred'::text) OR COALESCE(((jsonb_typeof((payload -> 'transfer_source'::text)) = 'object'::text) AND (jsonb_typeof(((payload -> 'transfer_source'::text) -> 'kind'::text)) = 'string'::text) AND (jsonb_typeof(((payload -> 'transfer_source'::text) -> 'source_id'::text)) = 'string'::text) AND (jsonb_typeof(((payload -> 'transfer_source'::text) -> 'path'::text)) = 'string'::text) AND (jsonb_typeof(((payload -> 'transfer_source'::text) -> 'input_commit'::text)) = 'string'::text) AND (jsonb_typeof(((payload -> 'transfer_source'::text) -> 'last_commit'::text)) = 'string'::text) AND (jsonb_typeof(((payload -> 'transfer_source'::text) -> 'sha256'::text)) = 'string'::text) AND (((payload -> 'transfer_source'::text) ->> 'input_commit'::text) ~ '^[0-9a-f]{40}$'::text)), false)))"
    }
   ]
  }
 }
]
```
