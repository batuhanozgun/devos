-- w07-break: test=tests/C02/W-C02-14/job/w14_sch_transfer_schema.sql; expect-red=SCH-S1-type-batu_step
-- Removes one of S1's event types, batu_step, from those devos_private.event admits (a NOT VALID check refusing it).
-- batu_step is chosen because no other case of the test plants it.
-- Plan Section 8 item 3 (PC-42): applied ONLY by W-C02-07's break harness (tests/C02/W-C02-07/harness/) on a throwaway
-- PostgreSQL built from supabase/migrations/, never on devos-test or devos; it sits outside supabase/migrations/, so the
-- migration job never applies it. Synthetic (plan Section 8 item 13): no data. No psql meta-command is used.
-- If the build carries the rule in another form than the one assumed here, this patch raises and the harness reports
-- the break "not shown"; the test designer then revises the patch before its first result (W-C02-07's README 8).
begin;  -- the guard and the change in one transaction: a refused guard aborts the whole patch
do $g$
begin
  if coalesce(current_setting('w07.throwaway', true), '') <> 'yes' then
    raise exception 'w14 break patch refused: the setting w07.throwaway is not yes (throwaway database only)';
  end if;
  if exists (select 1 from pg_roles where rolname = 'supabase_admin') then
    raise exception 'w14 break patch refused: role supabase_admin exists, so this may be a Supabase project';
  end if;
end $g$;
do $p$
begin
  alter table devos_private.event add constraint w14_break_no_batu_step check (event_type::text <> 'batu_step') not valid;
end $p$;
commit;
