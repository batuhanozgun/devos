-- w07-break: test=supabase/migrations/tests/w07_dm19_rejected_attempt_survives.sql; expect-red=DM19-a,DM19-c,DM19-d
-- Removes DM-19's record of a refusal: every write of a RejectedAttempt row is dropped by a trigger that returns null. The refusals themselves stay.
-- Plan Section 8 item 3 (PC-42): applied ONLY by W-C02-07's break harness (tests/C02/W-C02-07/harness/) on a throwaway
-- PostgreSQL built from supabase/migrations/, never on devos-test or devos; it sits outside supabase/migrations/, so the
-- migration job never applies it. Synthetic (plan Section 8 item 13): no data. No psql meta-command is used.
do $g$
begin
  if coalesce(current_setting('w07.throwaway', true), '') <> 'yes' then
    raise exception 'w07 break patch refused: the setting w07.throwaway is not yes (throwaway database only)';
  end if;
  if exists (select 1 from pg_roles where rolname = 'supabase_admin') then
    raise exception 'w07 break patch refused: role supabase_admin exists, so this may be a Supabase project';
  end if;
end $g$;
create schema if not exists w07_break;
create function w07_break.drop_row() returns trigger language plpgsql as $f$ begin return null; end $f$;
create trigger w07break_drop_rejected_attempt before insert on devos_private.rejected_attempt
  for each row execute function w07_break.drop_row();
