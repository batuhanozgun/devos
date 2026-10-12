-- Break patch for W-C02-03 points 6 and 7 (tests/C02/W-C02-03/T-W03-06_merged_not_applied.md and T-W03-07_could_not_check.md,
-- "Break attempt"). Plan Section 8 item 3 (PC-42): applied ONLY on the break harness's throwaway PostgreSQL built from
-- supabase/migrations/, never on devos-test or devos; it sits outside supabase/migrations/, so the migration job never
-- applies it. It renames the build's own devos_api.deployment_drift(jsonb) and puts in its place a wrapper that removes
-- one rule (it answers no difference without comparing); it holds none of the function's logic. Synthetic (plan Section 8 item 13): no data.
-- After this patch, supabase/migrations/tests/w03_drift_detects.sql and w03_drift_could_not_check.sql are run with
-- w03.throwaway = 'yes'; every difference case of w03_drift_detects.sql (S02 to S09) and every could-not-check case of w03_drift_could_not_check.sql (C02 to C13) must turn red (FAIL). Without any patch, the same run is the harness's positive control.
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
begin
  return jsonb_build_object('status', 'no_difference', 'complete', true, 'differences', '[]'::jsonb);
end $f$;
