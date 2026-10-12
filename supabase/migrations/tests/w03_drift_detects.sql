-- Synthetic test data (plan Section 8 item 13; criterion 20): every version (2999...), name (w03_fixture_*), slug
-- (w03-fixture-*), hash (one repeated hex digit) and commit below is made up for this test and holds no personal or
-- business data and no credential. Not made up: the names the rule under test uses (devos_api.deployment_drift,
-- supabase_migrations.schema_migrations, devos_private.function_deployment; Appendix B section 4, PC-41).
--
-- W-C02-03 point 6: deployment_drift names each kind of difference between `main` and the records; with everything
-- recorded it answers "no difference". Specification: tests/C02/W-C02-03/T-W03-06_merged_not_applied.md, part B.
-- Runs where: (1) the migration job's test step in devos-test, as postgres, after a clean comparison (EV-C02-001
-- M09, M25, section 5 step (8)); (2) the break harness's throwaway database built from supabase/migrations/ (plan
-- Section 8 item 3), connected as a login named postgres, with the setting w03.throwaway = 'yes'; the break patches
-- in tests/C02/W-C02-03/breaks/ are applied there only, never in devos-test or devos.
-- Interface assumed (T-W03-06, "Interface"): devos_api.deployment_drift(expected jsonb) returns jsonb with "status"
-- ('no_difference' | 'differences' | 'could_not_check'), "complete" (boolean) and "differences" (array of objects
-- with "kind" and "version", or "slug" for the function kinds); devos_private.function_deployment has columns slug
-- and source_sha256. If the build's names differ, the test designer revises this file before its first run.
-- Safety: everything happens inside one transaction that ends in rollback; the fixture replaces the records' rows
-- only inside it. Only sequence values outlast the rollback: a planted row in a table with an identity or serial
-- column (devos_private.function_deployment, if the build gives it one) advances that sequence, because a sequence's
-- next value is never rolled back. No row, table, column or function is left changed. No psql meta-command is used. Output: one row per case, then PASS, FAIL or COULD NOT CHECK; FAIL
-- and COULD NOT CHECK raise an error, so the step fails and the job's go is not yes.
begin;
set local search_path = pg_catalog, pg_temp;
set local statement_timeout = '60s';

create temp table w03_results (case_id text primary key, outcome text not null, detail text not null);

create function pg_temp.w03_pre() returns text language plpgsql as $f$
begin
  if to_regprocedure('devos_api.deployment_drift(jsonb)') is null then
    return 'devos_api.deployment_drift(jsonb) does not exist';
  end if;
  if to_regclass('supabase_migrations.schema_migrations') is null then
    if coalesce(current_setting('w03.throwaway', true), '') <> 'yes' then
      return 'supabase_migrations.schema_migrations does not exist';
    end if;
    -- Stand-in on the throwaway database only (labelled fixture); in devos-test the command-line tool's table is used.
    create schema if not exists supabase_migrations;
    create table supabase_migrations.schema_migrations (version text primary key, statements text[], name text);
  end if;
  if (select count(*) from information_schema.columns where table_schema = 'supabase_migrations'
        and table_name = 'schema_migrations' and column_name in ('version', 'name')) <> 2 then
    return 'supabase_migrations.schema_migrations lacks version or name';
  end if;
  if to_regclass('devos_private.function_deployment') is null then
    return 'devos_private.function_deployment does not exist';
  end if;
  if (select count(*) from information_schema.columns where table_schema = 'devos_private'
        and table_name = 'function_deployment' and column_name in ('slug', 'source_sha256')) <> 2 then
    return 'devos_private.function_deployment lacks slug or source_sha256';
  end if;
  return null;
end $f$;

-- Plants one function record row; other required columns get synthetic values by name and type.
create function pg_temp.w03_plant_function(p_slug text, p_sha text) returns void language plpgsql as $f$
declare cols text := 'slug, source_sha256'; vals text := format('%L, %L', p_slug, p_sha); c record;
begin
  for c in select column_name, data_type from information_schema.columns
           where table_schema = 'devos_private' and table_name = 'function_deployment' and is_nullable = 'NO'
             and column_default is null and is_identity = 'NO' and is_generated = 'NEVER'
             and column_name not in ('slug', 'source_sha256') order by ordinal_position loop
    cols := cols || ', ' || quote_ident(c.column_name);
    vals := vals || ', ' || case
      when c.data_type in ('text', 'character varying', 'character') then quote_literal(case
        when c.column_name like '%commit%' then repeat('c', 40)
        when c.column_name like '%sha%' or c.column_name like '%hash%' then repeat('c', 64)
        else 'w03_fixture' end)
      when c.data_type in ('integer', 'bigint', 'smallint', 'numeric') then '1'
      when c.data_type like 'timestamp%' then 'now()'
      when c.data_type = 'date' then 'current_date'
      when c.data_type = 'boolean' then 'false'
      when c.data_type in ('json', 'jsonb') then quote_literal('{}') || '::' || c.data_type
      when c.data_type = 'uuid' then quote_literal('00000000-0000-4000-8000-000000000003') || '::uuid'
      else 'null' end;
  end loop;
  execute format('insert into devos_private.function_deployment (%s) values (%s)', cols, vals);
end $f$;

-- The fixture: exactly two applied migrations and one deployed function, all synthetic.
create function pg_temp.w03_fixture() returns text language plpgsql as $f$
begin
  delete from supabase_migrations.schema_migrations;
  delete from devos_private.function_deployment;
  insert into supabase_migrations.schema_migrations (version, name)
    values ('29990101000001', 'w03_fixture_alpha'), ('29990101000002', 'w03_fixture_beta');
  perform pg_temp.w03_plant_function('w03-fixture-fn', repeat('a', 64));
  return null;
exception when others then
  return 'the fixture could not be planted: ' || sqlstate || ' ' || left(sqlerrm, 160);
end $f$;

create function pg_temp.w03_m(extra jsonb default '[]', drop_version text default null, rename_version text default null)
returns jsonb language sql as $f$
  select coalesce(jsonb_agg(case when m->>'version' = rename_version
                                 then jsonb_set(m, '{name}', to_jsonb((m->>'name') || '_renamed')) else m end), '[]')
         || extra
  from jsonb_array_elements('[{"version": "29990101000001", "name": "w03_fixture_alpha"},
                              {"version": "29990101000002", "name": "w03_fixture_beta"}]'::jsonb) m
  where m->>'version' is distinct from drop_version
$f$;

create function pg_temp.w03_f(sha text default repeat('a', 64), extra jsonb default '[]', no_fn boolean default false)
returns jsonb language sql as $f$
  select case when no_fn then extra else jsonb_build_array(jsonb_build_object('slug', 'w03-fixture-fn', 'sha256', sha))
         || extra end
$f$;

create function pg_temp.w03_e(migs jsonb, fns jsonb) returns jsonb language sql as $f$
  select jsonb_build_object('commit', repeat('a3', 20), 'migrations', migs, 'functions', fns)
$f$;

-- Judges one result. p_want: 'no_difference' | 'differences' | 'could_not_check' | 'not_no_difference'.
-- p_kinds: for 'differences', the exact list wanted, each {"kind": ..., "key": version or slug}.
create function pg_temp.w03_judge(p_id text, r jsonb, err text, p_want text, p_kinds jsonb default '[]')
returns void language plpgsql as $f$
declare st text; problems text := ''; got jsonb; want jsonb;
begin
  if err is not null or r is null or jsonb_typeof(r) <> 'object' then
    insert into w03_results values (p_id,
      case when p_want in ('could_not_check', 'not_no_difference') then 'ok' else 'bad' end,
      coalesce('raised ' || err, 'the result is null or not an object')
        || ' (the caller counts it as could not check, EV-C02-001 section 4)');
    return;
  end if;
  st := r->>'status';
  if st is null or st not in ('no_difference', 'differences', 'could_not_check') then
    problems := problems || format('status %s is not one of the three outcomes; ', coalesce(st, 'absent'));
  end if;
  if st = 'no_difference' and (r->'complete') is distinct from 'true'::jsonb then
    problems := problems || 'no_difference without complete = true; ';
  end if;
  if st = 'could_not_check' and (r->'complete') = 'true'::jsonb then
    problems := problems || 'could_not_check with complete = true; ';
  end if;
  if p_want = 'not_no_difference' then
    if st = 'no_difference' then problems := problems || 'answered no_difference; '; end if;
  elsif st is distinct from p_want then
    problems := problems || format('status %s, wanted %s; ', coalesce(st, 'absent'), p_want);
  end if;
  if p_want = 'differences' and st = 'differences' then
    select coalesce(jsonb_agg(x order by x->>'kind', x->>'key'), '[]') into got from (
      select jsonb_build_object('kind', d->>'kind', 'key',
               case when d->>'kind' like 'function%' then d->>'slug' else d->>'version' end) x
      from jsonb_array_elements(case when jsonb_typeof(r->'differences') = 'array' then r->'differences'
                                     else '[]' end) d) s;
    select coalesce(jsonb_agg(k order by k->>'kind', k->>'key'), '[]') into want from jsonb_array_elements(p_kinds) k;
    if got <> want then problems := problems || format('differences %s, wanted %s; ', got, want); end if;
  end if;
  insert into w03_results values (p_id, case when problems = '' then 'ok' else 'bad' end,
    case when problems = '' then 'status ' || st else problems end);
end $f$;

create function pg_temp.w03_case(p_id text, p_expected jsonb, p_want text, p_kinds jsonb default '[]')
returns void language plpgsql as $f$
declare r jsonb; err text;
begin
  begin
    r := devos_api.deployment_drift(p_expected);
  exception when others then
    err := sqlstate || ' ' || left(sqlerrm, 120);
  end;
  perform pg_temp.w03_judge(p_id, r, err, p_want, p_kinds);
end $f$;

do $$
declare why text;
begin
  why := pg_temp.w03_pre();
  if why is null then why := pg_temp.w03_fixture(); end if;
  if why is not null then
    insert into w03_results values ('S00 preconditions', 'could_not_check', why);
    return;
  end if;
  perform pg_temp.w03_case('S01 positive control: everything on main is recorded',
    pg_temp.w03_e(pg_temp.w03_m(), pg_temp.w03_f()), 'no_difference');
  perform pg_temp.w03_case('S02 merged, not applied (form i and ii): one version',
    pg_temp.w03_e(pg_temp.w03_m('[{"version": "29990101000003", "name": "w03_fixture_gamma"}]'), pg_temp.w03_f()),
    'differences', '[{"kind": "on_main_not_applied", "key": "29990101000003"}]');
  perform pg_temp.w03_case('S03 merged, not applied: two versions',
    pg_temp.w03_e(pg_temp.w03_m('[{"version": "29990101000003", "name": "w03_fixture_gamma"},
                                  {"version": "29990101000004", "name": "w03_fixture_delta"}]'), pg_temp.w03_f()),
    'differences', '[{"kind": "on_main_not_applied", "key": "29990101000003"},
                     {"kind": "on_main_not_applied", "key": "29990101000004"}]');
  perform pg_temp.w03_case('S04 applied and not on main',
    pg_temp.w03_e(pg_temp.w03_m(drop_version => '29990101000002'), pg_temp.w03_f()),
    'differences', '[{"kind": "applied_not_on_main", "key": "29990101000002"}]');
  perform pg_temp.w03_case('S05 name differs',
    pg_temp.w03_e(pg_temp.w03_m(rename_version => '29990101000002'), pg_temp.w03_f()),
    'differences', '[{"kind": "name_differs", "key": "29990101000002"}]');
  perform pg_temp.w03_case('S06 function differs (form iii)',
    pg_temp.w03_e(pg_temp.w03_m(), pg_temp.w03_f(sha => repeat('b', 64))),
    'differences', '[{"kind": "function_differs", "key": "w03-fixture-fn"}]');
  perform pg_temp.w03_case('S07 function on main, not deployed',
    pg_temp.w03_e(pg_temp.w03_m(), pg_temp.w03_f(extra => jsonb_build_array(
      jsonb_build_object('slug', 'w03-fixture-fn2', 'sha256', repeat('d', 64))))),
    'differences', '[{"kind": "function_missing", "key": "w03-fixture-fn2"}]');
  perform pg_temp.w03_case('S08 function deployed, not on main',
    pg_temp.w03_e(pg_temp.w03_m(), pg_temp.w03_f(no_fn => true)),
    'differences', '[{"kind": "function_extra", "key": "w03-fixture-fn"}]');
  perform pg_temp.w03_case('S09 a migration and a function at once',
    pg_temp.w03_e(pg_temp.w03_m('[{"version": "29990101000003", "name": "w03_fixture_gamma"}]'),
                  pg_temp.w03_f(sha => repeat('b', 64))),
    'differences', '[{"kind": "on_main_not_applied", "key": "29990101000003"},
                     {"kind": "function_differs", "key": "w03-fixture-fn"}]');
  delete from devos_private.function_deployment;
  perform pg_temp.w03_case('S10 positive control: no function on main and none recorded (C02''s state)',
    pg_temp.w03_e(pg_temp.w03_m(), pg_temp.w03_f(no_fn => true)), 'no_difference');
end $$;

select case_id, outcome, detail from w03_results order by case_id;

do $$
declare nb int; nc int; n int;
begin
  select count(*) filter (where outcome = 'bad'), count(*) filter (where outcome = 'could_not_check'), count(*)
    into nb, nc, n from w03_results;
  if nb > 0 then
    raise exception 'W03_DRIFT_DETECTS FAIL (% bad, % could not check, of %)', nb, nc, n;
  elsif nc > 0 or n = 0 then
    raise exception 'W03_DRIFT_DETECTS COULD NOT CHECK (% of % could not be checked)', nc, n;
  end if;
  raise notice 'W03_DRIFT_DETECTS PASS (%/%)', n, n;
end $$;

rollback;
