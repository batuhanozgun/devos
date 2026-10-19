-- w07-break: test=w07_f08_recheck_at_effect.sql; expect-red=F08-e-ready,F08-e-claim,F08-e-c-revise_work,F08-e-c-cancel_work,F08-e-c-relate,F08-e-c-retract_relation
-- Rule removed: a claim of an earlier global authority epoch counts as lapsed (N-289 option B; EV-C02-017 3 (e);
-- EV-C02-013 22 (3)): every count of a live claim counts it again. Specification:
-- tests/C02/W-C02-07/T-W07-F08_recheck_at_effect.md, "Revision under ledger rule 3 (N-289, N-297 (4), 2026-10-19)".
-- How: the one shared private predicate every count goes through (EV-C02-013 22 (3)) is renamed, and a predicate with
-- its name and signature that leaves the epoch out (the rule before the decision: status active and lease not run
-- out; NULL where the status, or an active claim's lease, is NULL) takes its place. Interface assumed (the
-- specification's): the predicate is devos_private.claim_live(devos_private.assignment_status, timestamptz, bigint),
-- the claim's status, lease and epoch, as the corrective migration's draft names it (20261019080001, seen 2026-10-19);
-- if the merged migration names it otherwise, the test designer revises this patch before its first result (README
-- section 8). It holds none of the build's logic.
-- Synthetic (plan Section 8 item 13): no data. Applied only by the break harness on its throwaway database
-- (README 5.2), never under supabase/migrations/. No psql meta-command. The whole change runs inside the guard's
-- block, so a refused guard changes nothing, whatever the client does after the error.
-- Written under ledger rule 3, 2026-10-19 (N-289).
do $b$
begin
  if coalesce(current_setting('w07.throwaway', true), '') <> 'yes' then
    raise exception 'w07 break patch refused: the setting w07.throwaway is not yes (throwaway database only)';
  end if;
  if exists (select 1 from pg_roles where rolname = 'supabase_admin') then
    raise exception 'w07 break patch refused: role supabase_admin exists, so this may be a Supabase project';
  end if;
  execute 'alter function devos_private.claim_live(devos_private.assignment_status, timestamptz, bigint) rename to claim_live_w07_orig';
  execute $p$
    create function devos_private.claim_live(claim_status devos_private.assignment_status, claim_lease timestamptz,
                                             claim_epoch bigint) returns boolean
    language sql stable security definer set search_path = pg_catalog as $f$
      select $1 = 'active' and $2 > now()
    $f$ $p$;
  execute 'revoke all on function devos_private.claim_live(devos_private.assignment_status, timestamptz, bigint) from public';
end $b$;
