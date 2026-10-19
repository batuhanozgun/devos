-- w07-break: test=w07_n04_self_approval.sql; expect-red=N04-T2
-- Break patch for T-W07-N04 (tests/C02/W-C02-07/T-W07-N04_self_approval.md, part T; phase C5, CHK-C02-030 C5). Rule
-- removed: the ledger transfer's devos_kurulum copy counts nowhere a rule needs the audit environment's verdict
-- (Ek_C:121; EV-C02-005 2.4 and 12; B:244). accept is renamed and wrapped; for the call, the Review of the Verdict it
-- names is shown as devos_denetim's, and is put back after it, so accept counts the copy as an audit verdict.
-- The names it uses are README 8.1's (accept(verdict_ref uuid, accepted_use text); B 3.11's Verdict review_ref and
-- Review reviewer_role_class).
-- Revised under ledger rule 3 (N-293 (6), 2026-10-19; no result of this break had been counted): the first version also
-- read and set a Verdict column role_class, which devos_private.verdict does not have (42703), so the wrapper raised on
-- every accept call and turned N04-b1, -b2, -e2 and -k2 red instead of N04-T2. M09-07's accept reads the audit class
-- from the Review's reviewer_role_class only (EV-C02-013 section 20 (6)), so the Review is the only row relabelled. The
-- rule removed and the red list are unchanged (T-W07-N04, "Revision under ledger rule 3 (N-293 (3), (6), 2026-10-19)").
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
alter function devos_api.accept(uuid, text) rename to accept_w07_orig;
create function devos_api.accept(verdict_ref uuid, accepted_use text) returns jsonb language plpgsql security definer
set search_path = pg_catalog as $f$
declare r jsonb; rr text; rid text;
begin
  select v.review_ref::text into rid from devos_private.verdict v where v.id = $1;
  select x.reviewer_role_class::text into rr from devos_private.review x where x.id::text = rid;
  alter table devos_private.review disable trigger user;
  update devos_private.review set reviewer_role_class = 'devos_denetim' where id::text = rid;
  r := devos_api.accept_w07_orig(verdict_ref, accepted_use);
  update devos_private.review set reviewer_role_class = rr::devos_private.role_class where id::text = rid;
  alter table devos_private.review enable trigger user;
  return r;
end $f$;
do $p$
declare g record;
begin
  revoke all on function devos_api.accept(uuid, text) from public;
  for g in select a.grantee from pg_proc pr, aclexplode(pr.proacl) a
            where pr.oid = 'devos_api.accept_w07_orig(uuid, text)'::regprocedure loop
    execute format('grant execute on function devos_api.accept(uuid, text) to %s',
                   case when g.grantee = 0 then 'public' else quote_ident(pg_get_userbyid(g.grantee)) end);
  end loop;
end $p$;
commit;
