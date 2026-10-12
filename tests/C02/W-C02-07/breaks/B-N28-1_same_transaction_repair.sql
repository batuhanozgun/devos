-- w07-break: test=supabase/migrations/tests/w07_n28_verifier_does_not_repair.sql,tests/C02/W-C02-07/harness/scenarios/n28_separate_transactions.sql; expect-red=N28-a,N28-b,N28-S-verdict
-- Removes DM-41's same-transaction rule (B 3.11: no new revision of a review's target in the transaction of its Review or Verdict): the triggers on devos_private.artifact_revision whose function reads reviews, and those on devos_private.review and devos_private.verdict whose function reads revisions, are disabled. DM-02's append-only trigger, which reads neither, stays.
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
do $p$
declare r record;
begin
  for r in select t.tgname, t.tgrelid::regclass::text as rel from pg_trigger t join pg_proc p on p.oid = t.tgfoid
            where not t.tgisinternal and (
                  (t.tgrelid = 'devos_private.artifact_revision'::regclass and p.prosrc ~* '(review|verdict)')
               or (t.tgrelid in ('devos_private.review'::regclass, 'devos_private.verdict'::regclass) and p.prosrc ~* 'revision')) loop
    execute format('alter table %s disable trigger %I', r.rel, r.tgname);
  end loop;
end $p$;
