-- w07-break: test=tests/C02/W-C02-14/job/w14_sch_transfer_schema.sql; expect-red=SCH-S4-chg-nr
-- Removes S4's not_recorded from Finding's changeable (a NOT VALID check refusing it). yes and no stay.
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
declare home text;
begin
  select t into home from unnest(array['finding', 'finding_revision']) with ordinality u(t, o)
   where exists (select 1 from information_schema.columns c where c.table_schema = 'devos_private'
                   and c.table_name = u.t and c.column_name = 'changeable')
   order by o limit 1;
  if home is null then
    raise exception 'w14 break: no column changeable in devos_private.finding or finding_revision';
  end if;
  execute format('alter table devos_private.%I add constraint w14_break_no_changeable_not_recorded check (changeable::text not in (''not_recorded'')) not valid', home);
end $p$;
commit;
