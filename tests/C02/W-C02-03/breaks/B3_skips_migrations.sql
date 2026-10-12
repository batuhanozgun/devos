-- Break patch for W-C02-03 points 6 and 7 (tests/C02/W-C02-03/T-W03-06_merged_not_applied.md and T-W03-07_could_not_check.md,
-- "Break attempt"). Plan Section 8 item 3 (PC-42): applied ONLY on the break harness's throwaway PostgreSQL built from
-- supabase/migrations/, never on devos-test or devos; it sits outside supabase/migrations/, so the migration job never
-- applies it. It renames the build's own devos_api.deployment_drift(jsonb) and puts in its place a wrapper that removes
-- one rule (it skips the record of applied migrations); it holds none of the function's logic. Synthetic (plan Section 8 item 13): no data.
-- After this patch, supabase/migrations/tests/w03_drift_detects.sql and w03_drift_could_not_check.sql are run with
-- w03.throwaway = 'yes'; S02, S03, S04, S05 and S09 of w03_drift_detects.sql must turn red (FAIL). Without any patch, the same run is the harness's positive control.
-- No psql meta-command is used.
do $g$
begin
  if coalesce(current_setting('w03.throwaway', true), '') <> 'yes' then
    raise exception 'w03 break patch refused: the setting w03.throwaway is not yes (throwaway database only)';
  end if;
  if exists (select 1 from pg_roles where rolname = 'supabase_admin') then
    raise exception 'w03 break patch refused: role supabase_admin exists, so this may be a Supabase project';
  end if;
end $g$;
alter function devos_api.deployment_drift(jsonb) rename to deployment_drift_w03_orig;
create function devos_api.deployment_drift(expected jsonb) returns jsonb language plpgsql security definer
set search_path = pg_catalog as $f$
declare r jsonb; kept jsonb;
begin
  r := devos_api.deployment_drift_w03_orig(expected);
  if r is null or r->>'status' is distinct from 'differences' then
    return r;
  end if;
  select coalesce(jsonb_agg(d), '[]'::jsonb) into kept
    from jsonb_array_elements(r->'differences') d where d->>'kind' like 'function%';
  return r || jsonb_build_object('differences', kept,
    'status', case when jsonb_array_length(kept) = 0 then 'no_difference' else 'differences' end);
end $f$;
