-- w07-break: test=w07_n28_sample_exemption.sql; expect-red=S-neg-direct
-- Break patch for T-W07-N28 (tests/C02/W-C02-07/T-W07-N28_verifier_does_not_repair.md, "Break attempt"; phase C4a). EV-C02-008
-- 2.5's B-S2, its table half: the Review table's check that refuses a sample row written by any path but the sampling
-- function (2.2 condition 2) is removed. The patch disables the triggers on devos_private.review whose function names
-- sample rows and reads no revision (DM-41's trigger, which reads revisions, stays), and drops the CHECK constraints of
-- the table that name sample. S-neg-direct's target has no revision in its transaction, so DM-41 has nothing to
-- compare, and its row is then written. It is also layer 2 of N01's agent-written sample (T-W07-N01's B-N01-2 is layer 1;
-- CHK-C02-026 condition C2). If the build keeps the check in DM-41's own trigger function, the patch finds nothing to
-- remove, raises, and the prober writes the one-rule change for that place (not a break shown).
-- Applied ONLY by the break harness on its throwaway PostgreSQL built from supabase/migrations/ (README 5.2; plan Section 8
-- item 3 as PC-42 place 3 writes it), never on devos-test or devos; it sits outside supabase/migrations/, so no job applies it.
-- Synthetic (plan Section 8 item 13): no data. No psql meta-command is used.
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
do $p$
declare r record; n int := 0;
begin
  for r in select t.tgname from pg_trigger t join pg_proc p on p.oid = t.tgfoid
            where not t.tgisinternal and t.tgrelid = 'devos_private.review'::regclass
              and p.prosrc ~* 'sample' and p.prosrc !~* 'revision' loop
    execute format('alter table devos_private.review disable trigger %I', r.tgname);
    n := n + 1;
  end loop;
  for r in select c.conname from pg_constraint c
            where c.conrelid = 'devos_private.review'::regclass and c.contype = 'c'
              and pg_get_constraintdef(c.oid) ~* 'sample' loop
    execute format('alter table devos_private.review drop constraint %I', r.conname);
    n := n + 1;
  end loop;
  if n = 0 then
    raise exception 'w07 break not applied: no trigger or check of devos_private.review that names sample rows apart from DM-41''s; not a break shown (W-C02-13 point 3)';
  end if;
end $p$;
commit;
