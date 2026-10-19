-- w07-break: test=w07_dm19b_burst_count.sql; expect-red=DM19B-rr-hour
-- Break patch for T-W07-DM19B (N-301, 2026-10-19; k15 of EV-C02-014 section 11). Rule removed: a counted row of an open
-- hour is among the rows since a time (B:270: "A counted row changes only during its hour", and "devos_denetim reads
-- it"; EV-C02-008 1.4, row R15), as EV-C02-013 24 (5) builds it. read_rejected_attempts is wrapped so that its answer
-- keeps only the rows created at or after since: a counted row created earlier in its hour, whose count holds calls
-- made after since, is dropped.
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
alter function devos_api.read_rejected_attempts(timestamptz) rename to read_rejected_attempts_w07_orig;
create function devos_api.read_rejected_attempts(since timestamptz) returns jsonb language plpgsql security definer
set search_path = pg_catalog as $f$
declare r jsonb;
begin
  r := devos_api.read_rejected_attempts_w07_orig(since);
  if jsonb_typeof(r) = 'object' and r->>'status' = 'ok' and jsonb_typeof(r->'rows') = 'array' then
    r := r || jsonb_build_object('rows', coalesce((select jsonb_agg(e order by (e->>'id')::bigint)
           from jsonb_array_elements(r->'rows') e where (e->>'created_at')::timestamptz >= read_rejected_attempts.since), '[]'::jsonb));
  end if;
  return r;
end $f$;
grant execute on function devos_api.read_rejected_attempts(timestamptz) to anon, authenticated;
commit;
