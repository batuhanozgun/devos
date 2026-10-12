-- Synthetic test data (plan Section 8 item 13; criterion 20): every version (2999...), name (w03_fixture_*), slug
-- (w03-fixture-*), hash (one repeated hex digit) and commit below is made up for this test and holds no personal or
-- business data and no credential. Not made up: the names the rule under test uses (devos_api.deployment_drift,
-- supabase_migrations.schema_migrations, devos_private.function_deployment; Appendix B section 4, PC-41).
--
-- W-C02-03 point 7: with the expected set missing or malformed, with a record unreadable, deployment_drift gives
-- "could not check" (or raises, which the caller counts as could not check), never "no difference" (B:387 as PC-41
-- words it; plan Section 8 item 14). Specification: tests/C02/W-C02-03/T-W03-07_could_not_check.md, part B. The
-- caller's half (an error, a timeout, a cut connection, a result without its completeness flag) is part A of that
-- specification, in tests/C02/W-C02-03/test_decision_steps.py.
-- Runs where, interface assumed and safety: as tests/C02/W-C02-03/T-W03-06_merged_not_applied.md part B and the
-- header of w03_drift_detects.sql in this directory. The unreadable states are made by renaming a record inside a
-- subtransaction that is rolled back before the next case. No psql meta-command is used. Output: one row per case,
-- then PASS, FAIL or COULD NOT CHECK; FAIL and COULD NOT CHECK raise an error.
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

-- Makes a record unreadable by p_ddl inside a subtransaction, calls the function, then undoes p_ddl.
create function pg_temp.w03_hidden_case(p_id text, p_ddl text, p_expected jsonb) returns void language plpgsql as $f$
declare r jsonb; err text; planted boolean := false; plant_err text;
begin
  begin
    execute p_ddl;
    planted := true;
    begin
      r := devos_api.deployment_drift(p_expected);
    exception when others then
      err := sqlstate || ' ' || left(sqlerrm, 120);
    end;
    raise exception using errcode = 'P0W03', message = 'w03: undo the planted state';
  exception
    when sqlstate 'P0W03' then null;
    when others then plant_err := sqlstate || ' ' || left(sqlerrm, 120);
  end;
  if not planted then
    insert into w03_results values (p_id, 'could_not_check', 'the unreadable state could not be planted: ' || plant_err);
    return;
  end if;
  perform pg_temp.w03_judge(p_id, r, err, 'could_not_check');
end $f$;

do $$
declare why text; good jsonb;
begin
  why := pg_temp.w03_pre();
  if why is null then why := pg_temp.w03_fixture(); end if;
  if why is not null then
    insert into w03_results values ('C00 preconditions', 'could_not_check', why);
    return;
  end if;
  good := pg_temp.w03_e(pg_temp.w03_m(), pg_temp.w03_f());
  perform pg_temp.w03_case('C01 positive control: well-formed expected, records readable', good, 'no_difference');
  perform pg_temp.w03_case('C02 expected missing (null)', null, 'could_not_check');
  perform pg_temp.w03_case('C03 expected empty object', '{}', 'could_not_check');
  perform pg_temp.w03_case('C04 expected not an object', '[]', 'could_not_check');
  perform pg_temp.w03_case('C05 migrations not an array', good || '{"migrations": "w03_fixture"}', 'could_not_check');
  perform pg_temp.w03_case('C06 a migration without its version',
    good || jsonb_build_object('migrations', pg_temp.w03_m('[{"name": "w03_fixture_gamma"}]')), 'could_not_check');
  perform pg_temp.w03_case('C07 functions absent (break: skips the function versions)', good - 'functions',
    'could_not_check');
  perform pg_temp.w03_case('C08 commit absent', good - 'commit', 'could_not_check');
  perform pg_temp.w03_case('C09 the same version twice', good || jsonb_build_object('migrations',
    pg_temp.w03_m('[{"version": "29990101000001", "name": "w03_fixture_alpha_twin"}]')), 'not_no_difference');
  perform pg_temp.w03_hidden_case('C10 history table unreadable (renamed)',
    'alter table supabase_migrations.schema_migrations rename to schema_migrations_w03_hidden', good);
  perform pg_temp.w03_hidden_case('C11 function record unreadable (renamed)',
    'alter table devos_private.function_deployment rename to function_deployment_w03_hidden', good);
  perform pg_temp.w03_hidden_case('C12 history table partly unreadable (its name column renamed)',
    'alter table supabase_migrations.schema_migrations rename column name to name_w03_hidden', good);
  perform pg_temp.w03_hidden_case('C13 function record partly unreadable (its hash column renamed)',
    'alter table devos_private.function_deployment rename column source_sha256 to source_sha256_w03_hidden', good);
end $$;

select case_id, outcome, detail from w03_results order by case_id;

do $$
declare nb int; nc int; n int;
begin
  select count(*) filter (where outcome = 'bad'), count(*) filter (where outcome = 'could_not_check'), count(*)
    into nb, nc, n from w03_results;
  if nb > 0 then
    raise exception 'W03_DRIFT_COULD_NOT_CHECK FAIL (% bad, % could not check, of %)', nb, nc, n;
  elsif nc > 0 or n = 0 then
    raise exception 'W03_DRIFT_COULD_NOT_CHECK COULD NOT CHECK (% of % could not be checked)', nc, n;
  end if;
  raise notice 'W03_DRIFT_COULD_NOT_CHECK PASS (%/%)', n, n;
end $$;

rollback;
