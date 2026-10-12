-- w07-break: test=w07_n29_impact_class.sql; expect-red=N29-link-high_impact,N29-link-depends_on,N29-link-batu
-- Break patch for T-W07-N29 (tests/C02/W-C02-07/T-W07-N29_*.md, "Break attempt"). Rule removed: the refusal of a link from a routine item to a high_impact or batu decision (B 3.3; PC-42 place 39; DM-42).
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
alter function devos_api.relate(jsonb) rename to relate_w07_orig;
create function devos_api.relate(p jsonb) returns jsonb language plpgsql security definer
set search_path = pg_catalog as $f$
declare old text; r jsonb;
begin
  execute format('select %I::text from devos_private.work where id::text = $1', 'impact_class') into old using p->>'from_ref';
  execute format('update devos_private.work set %I = %L where id::text = %L', 'impact_class', 'high', p->>'from_ref');
  r := devos_api.relate_w07_orig(p);
  execute format('update devos_private.work set %I = %L where id::text = %L', 'impact_class', old, p->>'from_ref');
  return r;
end $f$;
grant execute on function devos_api.relate(jsonb) to anon, authenticated;
