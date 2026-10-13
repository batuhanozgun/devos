-- Synthetic test fixture's read (plan Section 8 item 13): the objects read are those of the labelled fixture
-- supabase/migrations/20261012231841_w03_fixture_apply.sql (W-C02-03 T-W03-05); the version 29990101000009 below is
-- made up for the break check. Not made up: the catalog, auth.users, devos_private.function_deployment and
-- supabase_migrations.schema_migrations, which this file only reads.
--
-- W-C02-03 point 5, T-W03-05 "What is observed" item 2: devos-test's own read of the fixture after the apply, made by
-- the migration job's database-test step (dbtests) in job devos-test, which prints every line below with this file's
-- name (the job's own read, labelled by job, step and file; EV-C02-007 section 10.3). It reads, from pg_catalog, the
-- fixture's definitions and its history row, prints each as a NOTICE, and compares each field with the fixture file's
-- text (T-W03-05's negative control). The same fields are read in devos by the builder's read-only connection with
-- tests/C02/W-C02-03/T-W03-05_devos_read.sql.
-- Positive control: auth.users and devos_private.function_deployment, which the fixture did not make, are in this
-- catalog. Breaks, run every time and guarding a pass: the same comparison against a planted variant of the expected
-- definition (the default changed to 'w03_other') must find exactly that field different, and the same history read
-- with the version 29990101000009 must find no row.
-- Result: a NOTICE "W03_FIXTURE_APPLY_READ PASS (...)"; FAIL (a field differs, or the fixture is absent, whatever the
-- breaks show) and COULD NOT CHECK (a control or, with every field as the file, a break did not hold; or a record is
-- absent) raise an error, so the step fails and go is not yes.
-- Safety: one read-only transaction that ends in rollback; no psql meta-command; no backslash anywhere (the runner
-- refuses one). A forward migration that removes the schema w03_fixture removes this file in the same change.
begin transaction isolation level repeatable read, read only;
set local search_path = pg_catalog, pg_temp;
set local statement_timeout = '60s';

do $w03$
declare
  v_version constant text := '20261012231841';
  v_planted_version constant text := '29990101000009';
  v_expected jsonb;
  v_planted jsonb;
  v_actual jsonb;
  e jsonb;
  k text;
  i integer;
  bad text[];
  v_bad text[];
  v_bad_planted text[];
  v_planted_rows bigint;
  v_viewdef text;
begin
  raise notice 'W03_FIXTURE_READ server: PostgreSQL %, database %, session user %, read at % UTC',
    current_setting('server_version'), current_database(), session_user,
    to_char(clock_timestamp() at time zone 'utc', 'YYYY-MM-DD"T"HH24:MI:SS"Z"');

  -- Positive control: objects the fixture did not make, known to exist in this project.
  if not exists (select 1 from pg_catalog.pg_class c join pg_catalog.pg_namespace n on n.oid = c.relnamespace
                  where n.nspname = 'auth' and c.relname = 'users' and c.relkind in ('r', 'p')) then
    raise exception 'W03_FIXTURE_APPLY_READ COULD NOT CHECK (positive control: table auth.users is not in this catalog)';
  end if;
  raise notice 'W03_FIXTURE_READ positive control: table auth.users present';
  if not exists (select 1 from pg_catalog.pg_class c join pg_catalog.pg_namespace n on n.oid = c.relnamespace
                  where n.nspname = 'devos_private' and c.relname = 'function_deployment' and c.relkind in ('r', 'p')) then
    raise exception 'W03_FIXTURE_APPLY_READ COULD NOT CHECK (positive control: table devos_private.function_deployment is not in this catalog)';
  end if;
  raise notice 'W03_FIXTURE_READ positive control: table devos_private.function_deployment present';
  if (select count(*) from pg_catalog.pg_attribute a join pg_catalog.pg_class c on c.oid = a.attrelid
        join pg_catalog.pg_namespace n on n.oid = c.relnamespace
       where n.nspname = 'supabase_migrations' and c.relname = 'schema_migrations' and c.relkind in ('r', 'p')
         and a.attname in ('version', 'name') and a.attnum > 0 and not a.attisdropped) <> 2 then
    raise exception 'W03_FIXTURE_APPLY_READ COULD NOT CHECK (supabase_migrations.schema_migrations, with version and name, is not in this catalog)';
  end if;

  -- The read: every field the comparison uses, in one statement (the same fields as T-W03-05_devos_read.sql).
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
    'history_rows', (select count(*) from supabase_migrations.schema_migrations h where h.version = v_version),
    'history_name', (select jsonb_agg(h.name order by h.name) from supabase_migrations.schema_migrations h
                      where h.version = v_version))
    into v_actual;

  -- The fixture file's text, field by field.
  v_expected := jsonb_build_object(
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
    'history_name', jsonb_build_array('w03_fixture_apply'));
  -- The break's planted variant: the default changed to 'w03_other'.
  v_planted := jsonb_set(v_expected, '{table_columns,1,3}', to_jsonb('''w03_other''::text'::text));

  -- The raw read, one NOTICE per field (the job's own lines).
  for k in select x from jsonb_object_keys(v_actual) as x order by x loop
    raise notice 'W03_FIXTURE_READ %: %', k, coalesce((v_actual -> k)::text, 'null');
  end loop;
  select pg_catalog.pg_get_viewdef(c.oid) into v_viewdef from pg_catalog.pg_class c
    join pg_catalog.pg_namespace n on n.oid = c.relnamespace
   where n.nspname = 'w03_fixture' and c.relname = 'apply_check_view';
  raise notice 'W03_FIXTURE_READ view definition (printed, not compared; its layout is the server''s): %',
    coalesce(regexp_replace(v_viewdef, '[[:space:]]+', ' ', 'g'), 'null');

  -- One comparison, run against the expected definition and against the planted variant.
  for i in 1 .. 2 loop
    e := case i when 1 then v_expected else v_planted end;
    bad := '{}';
    for k in select x from jsonb_object_keys(e) as x order by x loop
      if (v_actual -> k) is distinct from (e -> k) then
        bad := bad || k;
      end if;
    end loop;
    if i = 1 then v_bad := bad; else v_bad_planted := bad; end if;
  end loop;

  select count(*) into v_planted_rows from supabase_migrations.schema_migrations h where h.version = v_planted_version;
  raise notice 'W03_FIXTURE_READ break (a), the default planted as ''w03_other'': fields found different: %', v_bad_planted;
  raise notice 'W03_FIXTURE_READ break (b), the history read with version %: % rows', v_planted_version, v_planted_rows;

  -- A difference fails the test whatever the breaks show. The breaks guard a pass: with every field as the file, the
  -- planted variant must differ in exactly its planted field, and the planted version must have no row.
  if cardinality(v_bad) > 0 then
    for k in select unnest(v_bad) loop
      raise notice 'W03_FIXTURE_READ differs: % read % expected %', k, coalesce((v_actual -> k)::text, 'null'), (v_expected -> k)::text;
    end loop;
    raise exception 'W03_FIXTURE_APPLY_READ FAIL (% of % fields differ from the fixture file: %)',
      cardinality(v_bad), (select count(*) from jsonb_object_keys(v_expected)), v_bad;
  end if;
  if v_bad_planted is distinct from array['table_columns'] then
    raise exception 'W03_FIXTURE_APPLY_READ COULD NOT CHECK (break (a) not red as it must be: %)', v_bad_planted;
  end if;
  if v_planted_rows <> 0 then
    raise exception 'W03_FIXTURE_APPLY_READ COULD NOT CHECK (break (b): % rows for the version 29990101000009)', v_planted_rows;
  end if;
  raise notice 'W03_FIXTURE_APPLY_READ PASS (%/% fields as the fixture file; positive control 2/2; breaks 2/2)',
    (select count(*) from jsonb_object_keys(v_expected)), (select count(*) from jsonb_object_keys(v_expected));
end
$w03$;

rollback;
