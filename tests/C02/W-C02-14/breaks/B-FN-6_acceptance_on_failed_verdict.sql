-- w07-break: test=tests/C02/W-C02-14/job/w14_fn_transfer_functions.sql; expect-red=FN-A-fail
-- T-W14-FN break B-FN-6 (tests/C02/W-C02-14/T-W14-FN_transfer_functions.md, "Break attempt"). Rule removed: transfer_acceptance's refusal of a Review copy whose verdict is fail (EV-C02-005 2.4). For the call the wrapper relabels the named copy's fail verdicts pass (the table's user triggers off), then restores them.
-- Plan Section 8 item 3 (PC-42): applied ONLY by W-C02-07's break harness (tests/C02/W-C02-07/harness/) on a throwaway
-- PostgreSQL built from supabase/migrations/, never on devos-test or devos; it sits outside supabase/migrations/, so the
-- migration job never applies it. Synthetic (plan Section 8 item 13): no data, no token in the file. No psql meta-command.
-- It wraps the build's function and holds none of its logic. If the build's function does not have the form assumed
-- here, the patch raises or the harness reports the break "not shown"; the test designer then revises the patch before
-- its first result (W-C02-07's README section 8).
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
alter function devos_api.transfer_acceptance(jsonb) rename to transfer_acceptance_w14_orig;
create function devos_api.transfer_acceptance(p jsonb) returns jsonb language plpgsql security definer
set search_path = pg_catalog as $f$
declare r jsonb; ids uuid[];
begin
  alter table devos_private.verdict disable trigger user;
  select coalesce(array_agg(v.id), '{}') into ids from devos_private.verdict v
   where v.review_ref::text = p ->> 'review_ref' and v.result = 'fail';
  update devos_private.verdict set result = 'pass' where id = any(ids);
  alter table devos_private.verdict enable trigger user;
  r := devos_api.transfer_acceptance_w14_orig(p);
  alter table devos_private.verdict disable trigger user;
  update devos_private.verdict set result = 'fail' where id = any(ids);
  alter table devos_private.verdict enable trigger user;
  return r;
end $f$;
do $p$
declare g record;
begin
  revoke all on function devos_api.transfer_acceptance(jsonb) from public;
  for g in select a.grantee from pg_proc pr, aclexplode(pr.proacl) a
            where pr.oid = 'devos_api.transfer_acceptance_w14_orig(jsonb)'::regprocedure and a.privilege_type = 'EXECUTE' loop
    execute format('grant execute on function devos_api.transfer_acceptance(jsonb) to %s',
                   case when g.grantee = 0 then 'public' else quote_ident(pg_get_userbyid(g.grantee)) end);
  end loop;
end $p$;
commit;
