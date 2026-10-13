-- w07-break: test=supabase/migrations/tests/w07_5a_no_direct_writes.sql; expect-red=5A-w:anon:event,5A-cat-grantees,5A-cat-priv
-- Removes one revocation of B principle 1 (no direct writes): anon gets USAGE on devos_private, INSERT on devos_private.event and
-- USAGE on the sequences that table owns, so that the direct insert is not stopped by a sequence's privilege instead.
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
grant usage on schema devos_private to anon;
grant insert on devos_private.event to anon;
do $p$
declare s record;
begin
  for s in select d.objid::regclass::text as seq from pg_depend d where d.refobjid = 'devos_private.event'::regclass
             and d.classid = 'pg_class'::regclass and d.deptype in ('a', 'i') and (select relkind from pg_class where oid = d.objid) = 'S' loop
    execute format('grant usage on sequence %s to anon', s.seq);
  end loop;
end $p$;
commit;
