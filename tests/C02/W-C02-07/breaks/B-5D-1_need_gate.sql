-- w07-break: test=w07_5d_format_gates_empty.sql; expect-red=5D-need-why_needed-absent,5D-need-why_needed-null,5D-need-why_needed-empty,5D-need-why_needed-whitespace
-- Break patch for T-W07-5D (tests/C02/W-C02-07/T-W07-5D_*.md, "Break attempt"). Rule removed: Need's gate (B 3.2).
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
alter function devos_api.record_need(jsonb) rename to record_need_w07_orig;
create function devos_api.record_need(p jsonb) returns jsonb language plpgsql security definer
set search_path = pg_catalog as $f$
begin
  if (p->'why_needed' is null or jsonb_typeof(p->'why_needed') = 'null' or (jsonb_typeof(p->'why_needed') = 'string' and btrim(p->>'why_needed', E' \t\r\n') = '') or (jsonb_typeof(p->'why_needed') = 'array' and jsonb_array_length(p->'why_needed') = 0)) then p := p || jsonb_build_object('why_needed', 'w07 break: filled by the patch'); end if;
  return devos_api.record_need_w07_orig(p);
end $f$;
grant execute on function devos_api.record_need(jsonb) to anon, authenticated;
