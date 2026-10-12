-- w07-break: test=w07_n02_decision_alternatives.sql; expect-red=N02-neg-none-hi,N02-neg-compared-empty-hi,N02-neg-single-blank-hi,N02-neg-none-batu,N02-neg-compared-empty-batu,N02-neg-single-blank-batu
-- Break patch for T-W07-N02 (tests/C02/W-C02-07/T-W07-N02_*.md, "Break attempt"). Rule removed: the alternatives part of Decision's gate at open (B 3.17): a decision with neither options nor single_viable_path_reason gets a filled reason.
-- Applied ONLY by the break harness on its throwaway PostgreSQL built from supabase/migrations/ (README 5.2; plan Section 8
-- item 3 as PC-42 place 3 writes it), never on devos-test or devos; it sits outside supabase/migrations/, so no job applies it.
-- It removes one rule and holds as little of the build's logic as it can; the names it uses are the interface the
-- specification assumes (revised before a first result if the build differs, README section 8).
-- Synthetic (plan Section 8 item 13): no data; any value it writes is labelled w07 break. No psql meta-command is used.
begin;  -- the guard and the change in one transaction: a refused guard aborts the whole patch
do $g$
begin
  if coalesce(current_setting('w07.throwaway', true), '') <> 'yes' then
    raise exception 'w07 break patch refused: the setting w07.throwaway is not yes (throwaway database only)';
  end if;
  if exists (select 1 from pg_roles where rolname = 'supabase_admin') then
    raise exception 'w07 break patch refused: role supabase_admin exists, so this may be a Supabase project';
  end if;
end $g$;
alter function devos_api.open_decision(jsonb) rename to open_decision_w07_orig;
create function devos_api.open_decision(p jsonb) returns jsonb language plpgsql security definer
set search_path = pg_catalog as $f$
begin
  if (p->'options' is null or jsonb_typeof(p->'options') = 'null' or (jsonb_typeof(p->'options') = 'string' and btrim(p->>'options', E' \t\r\n') = '') or (jsonb_typeof(p->'options') = 'array' and jsonb_array_length(p->'options') = 0)) and (p->'single_viable_path_reason' is null or jsonb_typeof(p->'single_viable_path_reason') = 'null' or (jsonb_typeof(p->'single_viable_path_reason') = 'string' and btrim(p->>'single_viable_path_reason', E' \t\r\n') = '') or (jsonb_typeof(p->'single_viable_path_reason') = 'array' and jsonb_array_length(p->'single_viable_path_reason') = 0)) and coalesce(p->>'alternatives_state', '') <> 'open_exploration' then
    p := p || '{"alternatives_state": "single_viable_path", "single_viable_path_reason": "w07 break: filled by the patch"}';
  end if;
  return devos_api.open_decision_w07_orig(p);
end $f$;
grant execute on function devos_api.open_decision(jsonb) to anon, authenticated;
commit;
