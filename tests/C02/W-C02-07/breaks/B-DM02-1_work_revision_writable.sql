-- w07-break: test=supabase/migrations/tests/w07_dm02_revision_append_only.sql; expect-red=DM02-work_revision-upd,DM02-work_revision-del,DM02-work_revision-trunc
-- Removes DM-02's refusal of update and delete on one revision table, devos_private.work_revision: its user triggers are disabled and its rules dropped. Other revision tables keep it.
-- Plan Section 8 item 3 (PC-42): applied ONLY by W-C02-07's break harness (tests/C02/W-C02-07/harness/) on a throwaway
-- PostgreSQL built from supabase/migrations/, never on devos-test or devos; it sits outside supabase/migrations/, so the
-- migration job never applies it. Synthetic (plan Section 8 item 13): no data. No psql meta-command is used.
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
alter table devos_private.work_revision disable trigger user;
do $p$
declare r record;
begin
  for r in select rulename from pg_rules where schemaname = 'devos_private' and tablename = 'work_revision' loop
    execute format('drop rule %I on devos_private.work_revision', r.rulename);
  end loop;
end $p$;
commit;
