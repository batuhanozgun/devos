-- w07-break: test=w07_roc_ownership_and_claim_class.sql; expect-red=ROC-x-o-mission-missing,ROC-x-o-mission-unreadable,ROC-x-o-mission-partial,ROC-x-o-event-missing,ROC-x-o-event-unreadable,ROC-x-o-event-partial,ROC-x-c-claims-missing,ROC-x-c-claims-unreadable,ROC-x-c-claims-partial
-- Break patch for T-W07-ROC (tests/C02/W-C02-07/T-W07-ROC_ownership_and_claim_class.md, "Break attempt"; phase C5,
-- CHK-C02-030 C7 (b)). Rule removed: the "could not check" answer of Rules O and C (W-C02-09 point 7; plan Section 8
-- item 14; README section 3 (i)). revise_work and retract_relation are renamed and wrapped; when the build answers
-- could_not_check, the wrapper answers clean (status ok) instead, as a check that lets a call through when it could not
-- read its input would. Every ROC-x case must then turn red; no other ROC case answers could_not_check on a build that
-- meets the rules, so no other case changes.
-- Applied ONLY by the break harness on its throwaway PostgreSQL built from supabase/migrations/ (README 5.2; plan Section 8
-- item 3 as PC-42 place 3 writes it), never on devos-test or devos; it sits outside supabase/migrations/, so no job applies it.
-- It keeps the wrapped functions' parameter types and order (README 8.1). Synthetic (plan Section 8 item 13): no data.
-- No psql meta-command is used.
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
alter function devos_api.revise_work(jsonb) rename to revise_work_w07_orig;
create function devos_api.revise_work(p jsonb) returns jsonb language plpgsql security definer
set search_path = pg_catalog as $f$
declare r jsonb;
begin
  r := devos_api.revise_work_w07_orig(p);
  if jsonb_typeof(r) = 'object' and r->>'status' = 'refused' and r->>'reason_code' = 'could_not_check' then
    return jsonb_build_object('status', 'ok');
  end if;
  return r;
end $f$;
alter function devos_api.retract_relation(uuid, text) rename to retract_relation_w07_orig;
create function devos_api.retract_relation(relation_id uuid, reason text) returns jsonb language plpgsql security definer
set search_path = pg_catalog as $f$
declare r jsonb;
begin
  r := devos_api.retract_relation_w07_orig(relation_id, reason);
  if jsonb_typeof(r) = 'object' and r->>'status' = 'refused' and r->>'reason_code' = 'could_not_check' then
    return jsonb_build_object('status', 'ok');
  end if;
  return r;
end $f$;
do $p$
declare f text; g record;
begin
  foreach f in array array['revise_work(jsonb)', 'retract_relation(uuid, text)'] loop
    execute format('revoke all on function devos_api.%s from public', f);
    for g in select a.grantee from pg_proc pr, aclexplode(pr.proacl) a
              where pr.oid = ('devos_api.' || replace(f, '(', '_w07_orig('))::regprocedure loop
      execute format('grant execute on function devos_api.%s to %s', f,
                     case when g.grantee = 0 then 'public' else quote_ident(pg_get_userbyid(g.grantee)) end);
    end loop;
  end loop;
end $p$;
commit;
