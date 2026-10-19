-- w07-break: test=w07_conc_claim_and_cycle.py; expect-red=CONC-tokens
-- Rule removed: a revocation by env_tokens row ID takes effect (B 3.27; README 8.1): the first call of
-- devos_private.revoke_env_token after this patch answers status ok and sets no revoked_at, so one synthetic token
-- that T-W07-CONC issued itself (the first it revokes: one of the fixtures' two) stays unrevoked while the program sees
-- an ok answer. Specification: tests/C02/W-C02-07/T-W07-CONC_claim_and_cycle.md, "Revision under ledger rule 3
-- (CHK-C02-106 C1 route (b), 2026-10-19)". How: the build's function is renamed to
-- devos_private.w07_brk_revoke_env_token_build and a function of the same name and signature takes its place; it
-- consumes a one-row marker table on its first call and answers ok without revoking, and calls the build's function
-- unchanged on every later call. It holds none of the build's logic. CONC-tokens must turn bad (the program's own
-- token left unrevoked); the seven other cases stay as in the positive control. This break tests the test's own
-- token check (it was written with the check, before any result of the revised check), not a rule of concurrency.
-- Synthetic (plan Section 8 item 13): no data. Throwaway database only (README 5.2), never under supabase/migrations/.
-- No psql meta-command. The whole change runs inside the guard's block.
do $b$
begin
  if coalesce(current_setting('w07.throwaway', true), '') <> 'yes' then
    raise exception 'w07 break patch refused: the setting w07.throwaway is not yes (throwaway database only)';
  end if;
  if exists (select 1 from pg_roles where rolname = 'supabase_admin') then
    raise exception 'w07 break patch refused: role supabase_admin exists, so this may be a Supabase project';
  end if;
  execute 'alter function devos_private.revoke_env_token(uuid) rename to w07_brk_revoke_env_token_build';
  execute 'create table devos_private.w07_brk_skip_once (used boolean not null)';
  execute 'insert into devos_private.w07_brk_skip_once values (false)';
  execute $d$
    create function devos_private.revoke_env_token(token_id uuid)
    returns jsonb
    language plpgsql
    volatile
    security definer
    set search_path = pg_catalog, pg_temp
    as $f$
    declare n int;
    begin
      update devos_private.w07_brk_skip_once set used = true where not used;
      get diagnostics n = row_count;
      if n = 1 then
        return jsonb_build_object('status', 'ok', 'id', token_id, 'w07_break', 'B-CONC-3: not revoked');
      end if;
      return devos_private.w07_brk_revoke_env_token_build(token_id);
    end
    $f$
  $d$;
  execute 'revoke all on function devos_private.revoke_env_token(uuid) from public';
  execute 'revoke all on function devos_private.revoke_env_token(uuid) from anon, authenticated, service_role';
end $b$;
