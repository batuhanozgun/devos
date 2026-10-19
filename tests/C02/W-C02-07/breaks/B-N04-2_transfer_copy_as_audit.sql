-- w07-break: test=w07_n04_self_approval.sql; expect-red=N04-T1
-- Break patch for T-W07-N04 (tests/C02/W-C02-07/T-W07-N04_self_approval.md, part T; phase C5, CHK-C02-030 C5). Rule
-- removed: the ledger transfer's copy of an installation checker verdict is written under role class devos_kurulum
-- (Ek_C:121; EV-C02-005 2.4). transfer_review is renamed and wrapped; after an accepted call, the Review copy it wrote,
-- and the events on it are relabelled devos_denetim, as a transfer that wrote the copy as an audit verdict would.
-- The names it uses are README 8.1's (B 3.11's reviewer_role_class; Verdict review_ref; Event aggregate_id, role_class).
-- Applied ONLY by the break harness on its throwaway PostgreSQL built from supabase/migrations/ (README 5.2; plan Section 8
-- item 3 as PC-42 place 3 writes it), never on devos-test or devos; it sits outside supabase/migrations/, so no job applies it.
-- Synthetic (plan Section 8 item 13): no data. No psql meta-command is used.
-- Revised under ledger rule 3 (N-293 (6)'s further fault, 2026-10-19; no result of this break had been counted): as
-- B-N04-3's, the wrapper also set a Verdict column role_class, which devos_private.verdict does not have (42703), so an
-- accepted copy made the wrapper raise and N04-T1 came out could_not_check. A Verdict carries no role class of its own
-- (M09-07's accept reads the Review's reviewer_role_class, EV-C02-013 section 20 (6)), so the Review copy and the events
-- on it are the rows relabelled. The rule removed and the red list are unchanged (T-W07-N04, "Revision under ledger rule
-- 3 (N-293 (3), (6), 2026-10-19)").
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
alter function devos_api.transfer_review(jsonb) rename to transfer_review_w07_orig;
create function devos_api.transfer_review(p jsonb) returns jsonb language plpgsql security definer
set search_path = pg_catalog as $f$
declare r jsonb; rid text;
begin
  r := devos_api.transfer_review_w07_orig(p);
  rid := coalesce(r->>'id', r->>'review_id');
  if jsonb_typeof(r) = 'object' and r->>'status' = 'ok' and rid is not null then
    alter table devos_private.review disable trigger user;
    alter table devos_private.event disable trigger user;
    update devos_private.review set reviewer_role_class = 'devos_denetim' where id::text = rid;
    update devos_private.event set role_class = 'devos_denetim' where aggregate_id::text = rid;
    alter table devos_private.review enable trigger user;
    alter table devos_private.event enable trigger user;
  end if;
  return r;
end $f$;
do $p$
declare g record;
begin
  revoke all on function devos_api.transfer_review(jsonb) from public;
  for g in select a.grantee from pg_proc pr, aclexplode(pr.proacl) a
            where pr.oid = 'devos_api.transfer_review_w07_orig(jsonb)'::regprocedure loop
    execute format('grant execute on function devos_api.transfer_review(jsonb) to %s',
                   case when g.grantee = 0 then 'public' else quote_ident(pg_get_userbyid(g.grantee)) end);
  end loop;
end $p$;
commit;
