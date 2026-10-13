-- w07-break: test=w07_n08_exam_fact.sql; expect-red=EXF-pair-ready_works
-- Break patch for T-W07-N08 part X (phase C4b, EV-C02-008 5.1's table, B-EXF-1; CHK-C02-027 B). Rule removed: 5.1 (c) bound
-- 4 ("No read callable by cal, kur or ci returns the class behind an exam task's events", the class that opened a work
-- item among them). ready_works is wrapped so that each row carries the role_class of its work item's first event (its
-- creation event), so that its rows for an exam task opened with devos_sinav and an ordinary item opened with
-- devos_calisma differ. The read names Event's fields as B 3.13 gives them; the prober adapts it.
-- Applied ONLY by the break harness on its throwaway PostgreSQL built from supabase/migrations/ (README 5.2; plan Section 8
-- item 3 as PC-42 place 3 writes it), never on devos-test or devos; it sits outside supabase/migrations/, so no job applies it.
-- It removes one rule and holds as little of the build's logic as it can; the names it uses are the interface the
-- specification assumes (revised before a first result if the build differs, README section 8). The caller's class is
-- read through devos_api.token_role_class() (README 8.1: it carries role_class).
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
alter function devos_api.ready_works() rename to ready_works_w07_orig;
create function devos_api.ready_works() returns jsonb language plpgsql security definer set search_path = pg_catalog as $f$
declare r jsonb; k jsonb; outv jsonb := '[]';
begin
  r := devos_api.ready_works_w07_orig();
  if jsonb_typeof(r) is distinct from 'object' or jsonb_typeof(r->'works') is distinct from 'array' then return r; end if;
  for k in select * from jsonb_array_elements(r->'works') loop
    outv := outv || jsonb_build_array(k || jsonb_build_object('opened_by', (select e.role_class from devos_private.event e
      where e.aggregate_id::text = coalesce(k->>'id', k->>'work_id', k #>> '{}') order by e.id limit 1)));
  end loop;
  return r || jsonb_build_object('works', outv);
end $f$;
grant execute on function devos_api.ready_works() to anon, authenticated;
commit;
