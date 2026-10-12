-- DevOS's first migration (W-C02-03; evidence/C02/EV-C02-001_migration_path.md M12, M13, section 4; EV-C02-004 Y-11;
-- PC-41 places 8, 10 and 11; build record evidence/C02/EV-C02-007_migration_path_build.md).
-- It creates only what the design gives it: the schemas devos_private and devos_api if absent, the record of deployed
-- function versions (devos_private.function_deployment, empty until the first Edge Function, N-230) and
-- devos_api.deployment_drift(jsonb). Nothing of W-C02-08's schema, no grant to any DevOS role class (W-C02-08's), and no
-- call of issue_env_token or revoke_env_token (M24).

create schema if not exists devos_private;
create schema if not exists devos_api;

-- The record of deployed function versions (M12). One row per deployed function, written by the migration job's
-- deploy step from the first Edge Function on: the version and ezbr_sha256 the Management API's function list
-- returns, the SHA-256 of main's source of the function as the job computes it (M14), the commit and run.
create table devos_private.function_deployment (
  slug text primary key check (slug <> ''),
  version integer,
  ezbr_sha256 text,
  source_sha256 text not null check (source_sha256 ~ '^[0-9a-f]{64}$'),
  commit_sha text not null check (commit_sha ~ '^[0-9a-f]{40}([0-9a-f]{24})?$'),
  run_id bigint not null,
  deployed_at timestamptz not null default now()
);

-- deployment_drift (Appendix B section 4, B:387 as PC-41 words it). It compares `expected`, the set at a main commit
-- ({commit, migrations: [{version, name}], functions: [{slug, sha256}]}, M14), with what this database records as
-- applied (supabase_migrations.schema_migrations, Supabase's table, written by its command-line tool) and deployed
-- (devos_private.function_deployment). Three outcomes, counted apart: "no_difference" only when every part was compared
-- in full; "differences", each one of on_main_not_applied, applied_not_on_main, name_differs, function_missing,
-- function_extra, function_differs; "could_not_check" otherwise: `expected` missing or malformed, a record absent,
-- unreadable or partly unreadable, any error. The result carries the completeness flag and the counts compared.
-- It is STABLE, so every read in it uses the snapshot of the statement that calls it: the history and the function
-- record are read in one snapshot.
create function devos_api.deployment_drift(expected jsonb)
returns jsonb
language plpgsql
stable
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  v_commit text;
  m jsonb;
  f jsonb;
  r record;
  exp_mig jsonb := '{}';
  exp_fun jsonb := '{}';
  app_mig jsonb := '{}';
  rec_fun jsonb := '{}';
  diffs jsonb := '[]';
  k text;
begin
  -- Authentication (PC-41 place 8, B:45; EV-C02-001 M13; EV-C02-004 Y-02). The migration job calls this function over
  -- its direct database login, whose session user is postgres; that caller is admitted here, before the token check.
  -- W-C02-05's token check (devos_private.caller_role_class) goes after this branch, in the migration that builds it.
  -- Until then every other caller is refused (EV-C02-001 section 10, "Two further points").
  if session_user is distinct from 'postgres' then
    raise exception using errcode = '42501',
      message = 'deployment_drift: refused; only the migration job''s direct login is admitted until the token check exists';
  end if;

  begin
    -- `expected`: missing or malformed input gives "could not check" (plan Section 8 item 14).
    if expected is null or jsonb_typeof(expected) is distinct from 'object' then
      return jsonb_build_object('status', 'could_not_check', 'complete', false, 'differences', '[]'::jsonb,
                                'reason', 'expected is missing or not an object');
    end if;
    v_commit := expected->>'commit';
    if jsonb_typeof(expected->'commit') is distinct from 'string' or v_commit !~ '^[0-9a-f]{40}([0-9a-f]{24})?$' then
      return jsonb_build_object('status', 'could_not_check', 'complete', false, 'differences', '[]'::jsonb,
                                'reason', 'expected has no valid commit');
    end if;
    if jsonb_typeof(expected->'migrations') is distinct from 'array'
       or jsonb_typeof(expected->'functions') is distinct from 'array' then
      return jsonb_build_object('status', 'could_not_check', 'complete', false, 'differences', '[]'::jsonb,
                                'reason', 'expected lacks its migrations or functions list');
    end if;
    for m in select value from jsonb_array_elements(expected->'migrations') loop
      if jsonb_typeof(m) is distinct from 'object' or jsonb_typeof(m->'version') is distinct from 'string'
         or (m->>'version') !~ '^[0-9]+$' or jsonb_typeof(m->'name') is distinct from 'string'
         or exp_mig ? (m->>'version') then
        return jsonb_build_object('status', 'could_not_check', 'complete', false, 'differences', '[]'::jsonb,
                                  'reason', 'expected holds a malformed or repeated migration');
      end if;
      exp_mig := exp_mig || jsonb_build_object(m->>'version', m->>'name');
    end loop;
    for f in select value from jsonb_array_elements(expected->'functions') loop
      if jsonb_typeof(f) is distinct from 'object' or jsonb_typeof(f->'slug') is distinct from 'string'
         or (f->>'slug') = '' or jsonb_typeof(f->'sha256') is distinct from 'string'
         or (f->>'sha256') !~ '^[0-9a-f]{64}$' or exp_fun ? (f->>'slug') then
        return jsonb_build_object('status', 'could_not_check', 'complete', false, 'differences', '[]'::jsonb,
                                  'reason', 'expected holds a malformed or repeated function');
      end if;
      exp_fun := exp_fun || jsonb_build_object(f->>'slug', f->>'sha256');
    end loop;

    -- The record of applied migrations. Absent, renamed or with a column missing: an error, caught below.
    for r in select version, coalesce(name, '') as name from supabase_migrations.schema_migrations loop
      if r.version is null then
        return jsonb_build_object('status', 'could_not_check', 'complete', false, 'differences', '[]'::jsonb,
                                  'reason', 'the history holds a row without a version');
      end if;
      app_mig := app_mig || jsonb_build_object(r.version, r.name);
    end loop;

    -- The record of deployed function versions, read the same way.
    for r in select slug, source_sha256 from devos_private.function_deployment loop
      if r.slug is null or r.source_sha256 is null then
        return jsonb_build_object('status', 'could_not_check', 'complete', false, 'differences', '[]'::jsonb,
                                  'reason', 'the function record holds an incomplete row');
      end if;
      rec_fun := rec_fun || jsonb_build_object(r.slug, r.source_sha256);
    end loop;
  exception when others then
    return jsonb_build_object('status', 'could_not_check', 'complete', false, 'differences', '[]'::jsonb,
                              'reason', 'a record could not be read: ' || sqlstate);
  end;

  -- The comparison, every part of it.
  for k in select key from jsonb_each_text(exp_mig) order by key loop
    if not app_mig ? k then
      diffs := diffs || jsonb_build_array(jsonb_build_object('kind', 'on_main_not_applied', 'version', k,
                                                             'name', exp_mig->>k));
    elsif (app_mig->>k) is distinct from (exp_mig->>k) then
      diffs := diffs || jsonb_build_array(jsonb_build_object('kind', 'name_differs', 'version', k,
                                                             'name', exp_mig->>k, 'applied_name', app_mig->>k));
    end if;
  end loop;
  for k in select key from jsonb_each_text(app_mig) order by key loop
    if not exp_mig ? k then
      diffs := diffs || jsonb_build_array(jsonb_build_object('kind', 'applied_not_on_main', 'version', k,
                                                             'name', app_mig->>k));
    end if;
  end loop;
  for k in select key from jsonb_each_text(exp_fun) order by key loop
    if not rec_fun ? k then
      diffs := diffs || jsonb_build_array(jsonb_build_object('kind', 'function_missing', 'slug', k));
    elsif (rec_fun->>k) is distinct from (exp_fun->>k) then
      diffs := diffs || jsonb_build_array(jsonb_build_object('kind', 'function_differs', 'slug', k));
    end if;
  end loop;
  for k in select key from jsonb_each_text(rec_fun) order by key loop
    if not exp_fun ? k then
      diffs := diffs || jsonb_build_array(jsonb_build_object('kind', 'function_extra', 'slug', k));
    end if;
  end loop;

  return jsonb_build_object(
    'status', case when jsonb_array_length(diffs) = 0 then 'no_difference' else 'differences' end,
    'complete', true,
    'commit', v_commit,
    'differences', diffs,
    'compared', jsonb_build_object(
      'migrations_expected', (select count(*) from jsonb_object_keys(exp_mig)),
      'migrations_applied', (select count(*) from jsonb_object_keys(app_mig)),
      'functions_expected', (select count(*) from jsonb_object_keys(exp_fun)),
      'functions_recorded', (select count(*) from jsonb_object_keys(rec_fun))));
end
$fn$;

-- Only the owner (postgres) runs it until W-C02-08 grants devos_ci, with the token check in place. PostgreSQL grants
-- EXECUTE on a new function to PUBLIC by default; that grant is removed, and so is any default grant to Supabase's API
-- roles, where they exist.
revoke all on function devos_api.deployment_drift(jsonb) from public;
do $$
declare v_role text;
begin
  foreach v_role in array array['anon', 'authenticated', 'service_role'] loop
    if exists (select 1 from pg_catalog.pg_roles where rolname = v_role) then
      execute format('revoke all on function devos_api.deployment_drift(jsonb) from %I', v_role);
    end if;
  end loop;
end
$$;
