-- w07-break: test=w07_n08_exam_fact.sql; expect-red=EXF-pair-sin-claim,N08-s4-claim-unlinked,N08-s4-claim-working,N08-s4-code
-- Break patch for T-W07-N08 part X (phase C4b, EV-C02-008 5.1's table, B-N08-4). Rule changed: 5.1 (c) bound 3 ("sin
-- claims no work item in C02"), back to its first version, which refused devos_sinav's claim only on a work item an EvalRun
-- names. claim is wrapped so that devos_sinav's claim on a work item no EvalRun names is made: the wrapper writes the
-- active Assignment itself and returns its token. The insert names Assignment's fields as B 3.5 gives them and stores the
-- token's SHA-256 (EV-C02-003 §1.7); the prober adapts both to the build's before the run.
-- Revised under ledger rule 3, 2026-10-19 (N-301 (4); EV-C02-014 section 11.4): the insert left out four NOT NULL columns
-- of W-C02-08's Assignment (migration 20261014170203: work_revision, generation, authority_epoch, lease_expires_at), so
-- each wrapped claim raised 23502 and no break was shown. It now gives them: the work item's latest revision, the next
-- generation on the work item, the global authority epoch, and a lease of 30 minutes (EV-C02-002 DM-07). Nothing else
-- changes. Under this patch the EvalRun
-- that part X's fixtures write on w_e is refused by record_eval_run's own claim check (bound 3's second layer), so the
-- pair cases give could_not_check; the red cases are the claims themselves.
-- Applied ONLY by the break harness on its throwaway PostgreSQL built from supabase/migrations/ (README 5.2; plan Section 8
-- item 3 as PC-42 place 3 writes it), never on devos-test or devos; it sits outside supabase/migrations/, so no job applies it.
-- It removes one rule and holds as little of the build's logic as it can; the names it uses are the interface the
-- specification assumes (revised before a first result if the build differs, README section 8). The caller's class is
-- read through devos_api.token_role_class() (README 8.1: it carries role_class).
-- Synthetic (plan Section 8 item 13): no data; any value it writes is labelled w07 break. No psql meta-command is used.
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
alter function devos_api.claim(uuid, text) rename to claim_w07_orig;
create function devos_api.claim(work_id uuid, declared_session_id text) returns jsonb language plpgsql security definer
set search_path = pg_catalog as $f$
declare t text := md5(gen_random_uuid()::text || clock_timestamp()::text); a uuid := gen_random_uuid();
begin
  if coalesce((devos_api.token_role_class())->>'role_class', '') = 'devos_sinav'
     and not exists (select 1 from devos_private.eval_run e where e.work_ref::text = claim.work_id::text)
     and not exists (select 1 from devos_private.assignment x where x.work_ref::text = claim.work_id::text and x.status = 'active') then
    insert into devos_private.assignment (id, work_ref, work_revision, role_class, declared_session_id, claim_token_hash,
                                          generation, authority_epoch, lease_expires_at, status)
      values (a, claim.work_id,
              (select max(r.revision) from devos_private.work_revision r where r.work_id = claim.work_id),
              'devos_sinav', claim.declared_session_id, encode(sha256(convert_to(t, 'UTF8')), 'hex'),
              (select coalesce(max(x.generation), 0) + 1 from devos_private.assignment x where x.work_ref = claim.work_id),
              (select g.epoch from devos_private.global_authority_epoch g), now() + interval '30 minutes', 'active');
    return jsonb_build_object('status', 'ok', 'assignment_id', a, 'claim_token', t);
  end if;
  return devos_api.claim_w07_orig(work_id, declared_session_id);
end $f$;
grant execute on function devos_api.claim(uuid, text) to anon, authenticated;
commit;
