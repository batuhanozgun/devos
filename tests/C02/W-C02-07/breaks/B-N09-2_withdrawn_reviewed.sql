-- w07-break: test=w07_n09_finding_gate.sql; expect-red=N09-wd-reviewed,N09-wd-accepted_for_use,N09-wd-stale
-- Rule removed: review_finding's refusal of a withdrawn Finding (N-296 (3) option B; EV-C02-017 5 (e); EV-C02-013 22 (5)).
-- Specification: tests/C02/W-C02-07/T-W07-N09_finding_gate.md, "Revision under ledger rule 3 (N-296 (3), 2026-10-19)".
-- How: the build's review_finding(uuid, integer, text) is renamed and a wrapper takes its name; when the Finding named
-- is withdrawn, the wrapper sets it to candidate for the call and calls the build's function; if that call is not
-- accepted, it puts withdrawn back. Every other call goes to the build's function unchanged. It holds none of the
-- build's logic.
-- Synthetic (plan Section 8 item 13): no data. Applied only by the break harness on its throwaway database
-- (README 5.2), never under supabase/migrations/. No psql meta-command. The whole change runs inside the guard's
-- block, so a refused guard changes nothing, whatever the client does after the error.
-- Written under ledger rule 3, 2026-10-19 (N-296 (3)).
do $b$
begin
  if coalesce(current_setting('w07.throwaway', true), '') <> 'yes' then
    raise exception 'w07 break patch refused: the setting w07.throwaway is not yes (throwaway database only)';
  end if;
  if exists (select 1 from pg_roles where rolname = 'supabase_admin') then
    raise exception 'w07 break patch refused: role supabase_admin exists, so this may be a Supabase project';
  end if;
  execute 'alter function devos_api.review_finding(uuid, integer, text) rename to review_finding_w07_orig';
  execute $p$
    create function devos_api.review_finding(finding_id uuid, revision integer, status text) returns jsonb
    language plpgsql security definer set search_path = pg_catalog as $f$
    declare w boolean; r jsonb;
    begin
      select f.status = 'withdrawn' into w from devos_private.finding f where f.id = $1;
      if coalesce(w, false) then
        update devos_private.finding f set status = 'candidate' where f.id = $1;
      end if;
      r := devos_api.review_finding_w07_orig($1, $2, $3);
      if coalesce(w, false) and r->>'status' is distinct from 'ok' then
        update devos_private.finding f set status = 'withdrawn' where f.id = $1;
      end if;
      return r;
    end $f$ $p$;
  execute 'revoke all on function devos_api.review_finding(uuid, integer, text) from public';
  execute 'grant execute on function devos_api.review_finding(uuid, integer, text) to anon';
end $b$;
