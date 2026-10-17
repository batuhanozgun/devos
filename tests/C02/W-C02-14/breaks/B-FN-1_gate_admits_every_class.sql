-- w07-break: test=tests/C02/W-C02-14/job/w14_fn_transfer_functions.sql; expect-red=FN-G-transfer_review
-- T-W14-FN break B-FN-1 (tests/C02/W-C02-14/T-W14-FN_transfer_functions.md, "Break attempt"). Rule removed: transfer_review's role list (only devos_kurulum; B section 4; EV-C02-005 S5). When the build's function refuses the caller's class (reason code role_class_not_permitted), the wrapper issues a devos_kurulum token as the owner, puts it in the header and calls the function again, so every verified role class is processed as devos_kurulum.
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
alter function devos_api.transfer_review(jsonb) rename to transfer_review_w14_orig;
create function devos_api.transfer_review(p jsonb) returns jsonb language plpgsql security definer
set search_path = pg_catalog as $f$
declare r jsonb; h text := current_setting('request.headers', true); t text;
begin
  r := devos_api.transfer_review_w14_orig(p);
  if r ->> 'reason_code' = 'role_class_not_permitted' then
    t := devos_private.issue_env_token('devos_kurulum');
    perform set_config('request.headers', json_build_object('x-devos-env-token', t)::text, true);
    t := null;
    r := devos_api.transfer_review_w14_orig(p);
    perform set_config('request.headers', coalesce(h, '{}'), true);
  end if;
  return r;
end $f$;
do $p$
declare g record;
begin
  revoke all on function devos_api.transfer_review(jsonb) from public;
  for g in select a.grantee from pg_proc pr, aclexplode(pr.proacl) a
            where pr.oid = 'devos_api.transfer_review_w14_orig(jsonb)'::regprocedure and a.privilege_type = 'EXECUTE' loop
    execute format('grant execute on function devos_api.transfer_review(jsonb) to %s',
                   case when g.grantee = 0 then 'public' else quote_ident(pg_get_userbyid(g.grantee)) end);
  end loop;
end $p$;
commit;
