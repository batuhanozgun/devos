# W-C02-08's apply: a third read of `devos`'s catalog, column ACLs with system columns (CHK-C02-071 K1 (i))

Made by the executor on 2026-10-14 through the read-only Supabase connector (`execute_sql`, `devos` only). The query and its
result, verbatim.

## The query

```sql
select json_build_object(
 'read_at', now(),
 'attributes_with_acl_any_attnum', (select count(*) from pg_attribute a join pg_class c on c.oid=a.attrelid join pg_namespace n on n.oid=c.relnamespace where n.nspname='devos_private' and a.attacl is not null),
 'system_attributes_read', (select count(*) from pg_attribute a join pg_class c on c.oid=a.attrelid join pg_namespace n on n.oid=c.relnamespace where n.nspname='devos_private' and a.attnum < 0),
 'grantees', (select json_agg(json_build_object('rel', c.relname, 'col', a.attname, 'attnum', a.attnum, 'grantee', coalesce(r.rolname,'PUBLIC'), 'priv', x.privilege_type)) from pg_attribute a join pg_class c on c.oid=a.attrelid join pg_namespace n on n.oid=c.relnamespace cross join lateral aclexplode(a.attacl) x left join pg_roles r on r.oid=x.grantee where n.nspname='devos_private' and a.attacl is not null)
) as r
```

## The result

```json
[{"r":{"read_at":"2026-10-14T20:30:52.308255+00:00","attributes_with_acl_any_attnum":0,"system_attributes_read":180,"grantees":null}}]
```
