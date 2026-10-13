-- Synthetic test fixture's read (plan Section 8 item 13), W-C02-03 T-W03-05 "What is observed" item 3: the read of the
-- labelled fixture supabase/migrations/20261012231841_w03_fixture_apply.sql in devos, by the builder's read-only
-- connection (EV-C00-002 item 8), which reaches devos only and is never evidence for devos-test. One plain SELECT, no
-- psql meta-command, so a client that runs one statement runs it unchanged; it writes nothing.
-- It reads the same fields, with the same expressions, as supabase/migrations/tests/w03_fixture_apply_read.sql (the
-- job's read in devos-test); only the version is a literal here and a variable there, and the result is a row rather
-- than NOTICE lines. The two gave the same "actual" object on the same databases (T-W03-05, "Break attempt").
-- Reading the row: the read passes when both controls are true, differs is [], break_a_differs is ["table_columns"]
-- and break_b_rows is 0; it fails when differs is not []; otherwise it is "could not check" (as the job's read).
-- Columns: read_at_utc, server_version, database, the two positive controls, actual, expected, differs (the fields
-- that differ: [] passes), break_a_differs (must be ["table_columns"]), break_b_rows (must be 0).
with actual as (
  select jsonb_build_object(
    'schema', (select to_jsonb(n.nspname::text) from pg_catalog.pg_namespace n where n.nspname = 'w03_fixture'),
    'table_kind', (select to_jsonb(c.relkind::text) from pg_catalog.pg_class c
                     join pg_catalog.pg_namespace n on n.oid = c.relnamespace
                    where n.nspname = 'w03_fixture' and c.relname = 'apply_check'),
    'table_columns', (select jsonb_agg(jsonb_build_array(a.attname::text, pg_catalog.format_type(a.atttypid, a.atttypmod),
                                                         a.attnotnull, pg_catalog.pg_get_expr(d.adbin, d.adrelid))
                                       order by a.attnum)
                        from pg_catalog.pg_attribute a join pg_catalog.pg_class c on c.oid = a.attrelid
                        join pg_catalog.pg_namespace n on n.oid = c.relnamespace
                        left join pg_catalog.pg_attrdef d on d.adrelid = a.attrelid and d.adnum = a.attnum
                       where n.nspname = 'w03_fixture' and c.relname = 'apply_check' and a.attnum > 0
                         and not a.attisdropped),
    'table_primary_key', (select jsonb_agg(pg_catalog.pg_get_constraintdef(con.oid) order by con.conname)
                            from pg_catalog.pg_constraint con join pg_catalog.pg_class c on c.oid = con.conrelid
                            join pg_catalog.pg_namespace n on n.oid = c.relnamespace
                           where n.nspname = 'w03_fixture' and c.relname = 'apply_check' and con.contype = 'p'),
    'table_other_constraints', (select count(*) from pg_catalog.pg_constraint con
                                  join pg_catalog.pg_class c on c.oid = con.conrelid
                                  join pg_catalog.pg_namespace n on n.oid = c.relnamespace
                                 where n.nspname = 'w03_fixture' and c.relname = 'apply_check'
                                   and con.contype not in ('p', 'n')),
    'table_comment', (select to_jsonb(pg_catalog.obj_description(c.oid, 'pg_class')) from pg_catalog.pg_class c
                        join pg_catalog.pg_namespace n on n.oid = c.relnamespace
                       where n.nspname = 'w03_fixture' and c.relname = 'apply_check'),
    'view_kind', (select to_jsonb(c.relkind::text) from pg_catalog.pg_class c
                    join pg_catalog.pg_namespace n on n.oid = c.relnamespace
                   where n.nspname = 'w03_fixture' and c.relname = 'apply_check_view'),
    'view_columns', (select jsonb_agg(jsonb_build_array(a.attname::text, pg_catalog.format_type(a.atttypid, a.atttypmod))
                                      order by a.attnum)
                       from pg_catalog.pg_attribute a join pg_catalog.pg_class c on c.oid = a.attrelid
                       join pg_catalog.pg_namespace n on n.oid = c.relnamespace
                      where n.nspname = 'w03_fixture' and c.relname = 'apply_check_view' and a.attnum > 0
                        and not a.attisdropped),
    'view_options', (select to_jsonb(c.reloptions) from pg_catalog.pg_class c
                       join pg_catalog.pg_namespace n on n.oid = c.relnamespace
                      where n.nspname = 'w03_fixture' and c.relname = 'apply_check_view'),
    'view_reads', (select jsonb_agg(distinct rn.nspname || '.' || rc.relname)
                     from pg_catalog.pg_rewrite w join pg_catalog.pg_class c on c.oid = w.ev_class
                     join pg_catalog.pg_namespace n on n.oid = c.relnamespace
                     join pg_catalog.pg_depend d on d.classid = 'pg_catalog.pg_rewrite'::pg_catalog.regclass
                                                and d.objid = w.oid
                                                and d.refclassid = 'pg_catalog.pg_class'::pg_catalog.regclass
                                                and d.refobjid <> c.oid
                     join pg_catalog.pg_class rc on rc.oid = d.refobjid
                     join pg_catalog.pg_namespace rn on rn.oid = rc.relnamespace
                    where n.nspname = 'w03_fixture' and c.relname = 'apply_check_view'),
    'history_rows', (select count(*) from supabase_migrations.schema_migrations h where h.version = '20261012231841'),
    'history_name', (select jsonb_agg(h.name order by h.name) from supabase_migrations.schema_migrations h
                      where h.version = '20261012231841')) as a
), expected as (
  select jsonb_build_object(
    'schema', 'w03_fixture',
    'table_kind', 'r',
    'table_columns', jsonb_build_array(jsonb_build_array('id', 'integer', true, null),
                                       jsonb_build_array('note', 'text', true, '''synthetic''::text')),
    'table_primary_key', jsonb_build_array('PRIMARY KEY (id)'),
    'table_other_constraints', 0,
    'table_comment', 'Synthetic test fixture (plan Section 8 item 13), W-C02-03 T-W03-05',
    'view_kind', 'v',
    'view_columns', jsonb_build_array(jsonb_build_array('id', 'integer'), jsonb_build_array('note', 'text')),
    'view_options', jsonb_build_array('security_invoker=true'),
    'view_reads', jsonb_build_array('w03_fixture.apply_check'),
    'history_rows', 1,
    'history_name', jsonb_build_array('w03_fixture_apply')) as e
)
select to_char(clock_timestamp() at time zone 'utc', 'YYYY-MM-DD"T"HH24:MI:SS"Z"') as read_at_utc,
       current_setting('server_version') as server_version,
       current_database() as database,
       exists (select 1 from pg_catalog.pg_class c join pg_catalog.pg_namespace n on n.oid = c.relnamespace
                where n.nspname = 'auth' and c.relname = 'users' and c.relkind in ('r', 'p')) as control_auth_users,
       exists (select 1 from pg_catalog.pg_class c join pg_catalog.pg_namespace n on n.oid = c.relnamespace
                where n.nspname = 'devos_private' and c.relname = 'function_deployment' and c.relkind in ('r', 'p'))
         as control_function_deployment,
       actual.a as actual,
       expected.e as expected,
       (select coalesce(jsonb_agg(x order by x), '[]'::jsonb) from jsonb_object_keys(expected.e) as x
         where (actual.a -> x) is distinct from (expected.e -> x)) as differs,
       (select coalesce(jsonb_agg(x order by x), '[]'::jsonb)
          from jsonb_object_keys(expected.e) as x
         where (actual.a -> x) is distinct from
               (jsonb_set(expected.e, '{table_columns,1,3}', to_jsonb('''w03_other''::text'::text)) -> x)) as break_a_differs,
       (select count(*) from supabase_migrations.schema_migrations h where h.version = '29990101000009') as break_b_rows
  from actual, expected;
