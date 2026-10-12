-- w07-break: test=w07_n29_impact_class.sql; expect-red=N29-mis-open-high_impact,N29-mis-open-routine,N29-mis-widen-high_impact
-- Break patch for T-W07-N29 (tests/C02/W-C02-07/T-W07-N29_*.md, "Break attempt"). Rule removed: the refusal of a Mission opened or widened by a decision below batu (B 3.1, 3.17; DM-23): the decision reads as batu for the call.
-- Applied ONLY by the break harness on its throwaway PostgreSQL built from supabase/migrations/ (README 5.2; plan Section 8
-- item 3 as PC-42 place 3 writes it), never on devos-test or devos; it sits outside supabase/migrations/, so no job applies it.
-- It removes one rule and holds as little of the build's logic as it can; the names it uses are the interface the
-- specification assumes (revised before a first result if the build differs, README section 8).
-- Synthetic (plan Section 8 item 13): no data; any value it writes is labelled w07 break. No psql meta-command is used.
do $g$
begin
  if coalesce(current_setting('w07.throwaway', true), '') <> 'yes' then
    raise exception 'w07 break patch refused: the setting w07.throwaway is not yes (throwaway database only)';
  end if;
  if exists (select 1 from pg_roles where rolname = 'supabase_admin') then
    raise exception 'w07 break patch refused: role supabase_admin exists, so this may be a Supabase project';
  end if;
end $g$;
alter function devos_api.open_mission(jsonb) rename to open_mission_w07_orig;
create function devos_api.open_mission(p jsonb) returns jsonb language plpgsql security definer
set search_path = pg_catalog as $f$
declare old text; r jsonb;
begin
  execute format('select %I::text from devos_private.decision where id::text = $1', 'class') into old using p->>'owner_authority';
  execute format('update devos_private.decision set %I = %L where id::text = %L', 'class', 'batu', p->>'owner_authority');
  r := devos_api.open_mission_w07_orig(p);
  execute format('update devos_private.decision set %I = %L where id::text = %L', 'class', old, p->>'owner_authority');
  return r;
end $f$;
grant execute on function devos_api.open_mission(jsonb) to anon, authenticated;
alter function devos_api.revise_mission(jsonb) rename to revise_mission_w07_orig;
create function devos_api.revise_mission(p jsonb) returns jsonb language plpgsql security definer
set search_path = pg_catalog as $f$
declare old text; r jsonb;
begin
  execute format('select %I::text from devos_private.decision where id::text = $1', 'class') into old using p->>'owner_authority';
  execute format('update devos_private.decision set %I = %L where id::text = %L', 'class', 'batu', p->>'owner_authority');
  r := devos_api.revise_mission_w07_orig(p);
  execute format('update devos_private.decision set %I = %L where id::text = %L', 'class', old, p->>'owner_authority');
  return r;
end $f$;
grant execute on function devos_api.revise_mission(jsonb) to anon, authenticated;
