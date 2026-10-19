-- w07-break: test=w07_dm19b_burst_count.sql; expect-red=DM19B-me-hour
-- Break patch for T-W07-DM19B (N-301, 2026-10-19; k09 of EV-C02-014 section 11). Rule removed: B:270, "A counted row
-- changes only during its hour and is exported after it", as mark_exported builds it (EV-C02-013 24 (4)). mark_exported
-- is wrapped so that, after an accepted call on rejected_attempt, every counted row of the range not yet marked is
-- marked too, those of the current hour among them.
-- Applied ONLY by the break harness on its throwaway PostgreSQL built from supabase/migrations/ (README 5.2; plan Section 8
-- item 3 as PC-42 place 3 writes it), never on devos-test or devos; it sits outside supabase/migrations/, so no job applies it.
-- It removes one rule and holds as little of the build's logic as it can: it wraps the build's function and keeps its
-- parameter types and order (README 5.2, "Wrappers").
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
alter function devos_api.mark_exported(jsonb) rename to mark_exported_w07_orig;
create function devos_api.mark_exported(p jsonb) returns jsonb language plpgsql security definer set search_path = pg_catalog as $f$
declare r jsonb;
begin
  r := devos_api.mark_exported_w07_orig(p);
  if jsonb_typeof(r) = 'object' and r->>'status' = 'ok' and p->>'table' = 'rejected_attempt' then
    update devos_private.rejected_attempt x set exported_at = now()
     where x.id between (p->>'from_id')::bigint and (p->>'to_id')::bigint
       and x.exported_at is null and x.counted_hour is not null;
  end if;
  return r;
end $f$;
grant execute on function devos_api.mark_exported(jsonb) to anon, authenticated;
commit;
