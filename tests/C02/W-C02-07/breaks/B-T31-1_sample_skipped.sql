-- w07-break: test=w07_t31_planted_rate.sql; expect-red=T31-need,T31-decision,T31-effort_policy,T31-finding,T31-total
-- Break patch for T-W07-T31 (tests/C02/W-C02-07/T-W07-T31_*.md, "Break attempt"). Rule removed: the sample of format-gated records (DM-08).
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
create function devos_private.w07_break_skip_sample() returns trigger language plpgsql as $f$
begin
  if new.kind::text = 'sample' then return null; end if;
  return new;
end $f$;
create trigger w07_break_skip_sample before insert on devos_private.review
  for each row execute function devos_private.w07_break_skip_sample();
