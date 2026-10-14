-- w07-break: test=tests/C02/W-C02-14/job/w14_sch_transfer_schema.sql; expect-red=SCH-S1-commit,SCH-S1-miss-input_commit,SCH-S1-miss-kind,SCH-S1-miss-last_commit,SCH-S1-miss-path,SCH-S1-miss-sha256,SCH-S1-miss-source_id,SCH-S1-nosrc
-- Removes S1's rule that a transferred event carries transfer_source with its six fields (input_commit of 40
-- hexadecimal characters): every CHECK constraint on devos_private.event whose text names transfer_source is
-- dropped (assumed form). S2's index is not a CHECK constraint and stays.
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
declare r record; n int := 0;
begin
  for r in select con.conname from pg_constraint con
            where con.conrelid = 'devos_private.event'::regclass and con.contype = 'c'
              and pg_get_constraintdef(con.oid) like '%transfer_source%' loop
    execute format('alter table devos_private.event drop constraint %I', r.conname);
    n := n + 1;
  end loop;
  if n = 0 then
    raise exception 'w14 break: no CHECK constraint on devos_private.event names transfer_source (assumed form of S1)';
  end if;
end $p$;
commit;
