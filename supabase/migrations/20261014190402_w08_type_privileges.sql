-- DevOS schema (W-C02-08), not a fixture. Part 8, after parts 1 to 7: USAGE on devos_private's types closed to PUBLIC
-- and to the application roles (point 4: "no privilege on devos_private or its objects for an application role or
-- PUBLIC"; CHK-C02-068 C2).
-- Sources: plan/work/W-C02-08.md point 4; Appendix B principle 1; part 5's access rules. Record:
-- evidence/C02/EV-C02-012_schema_roles_access.md section 4.
-- PostgreSQL gives PUBLIC USAGE on a new type (its typacl is null and its default is PUBLIC=U). This revokes it on every
-- type in devos_private whose privileges can be set: the enum types and the row types of the tables and views. An array
-- type has no privileges of its own: PostgreSQL refuses GRANT and REVOKE on it and checks its element type instead
-- (the record, section 4). Each later migration revokes the types it adds, a new table's or view's row type included,
-- as each later function revokes its own.
do $$
declare t regtype; r text;
begin
  for t in select ty.oid::regtype from pg_catalog.pg_type ty join pg_catalog.pg_namespace n on n.oid = ty.typnamespace
            where n.nspname = 'devos_private' and ty.typtype <> 'm'
              and not exists (select 1 from pg_catalog.pg_type e where e.typarray = ty.oid)
            order by ty.oid loop
    execute format('revoke all on type %s from public', t);
    foreach r in array array['anon', 'authenticated', 'authenticator', 'service_role'] loop
      if exists (select 1 from pg_catalog.pg_roles where rolname = r) then
        execute format('revoke all on type %s from %I', t, r);
      end if;
    end loop;
  end loop;
end
$$;
