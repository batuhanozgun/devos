-- w07-break: test=w07_n17_claim_token.sql; expect-red=N17-n5,N17-n6,N17-n7,N17-n8
-- Rule removed: S8 line 2, the match of the caller's role class with the claim's, in every function that takes a
-- claim token: register_artifact (an effect), heartbeat and release (EV-C02-003 §4.3; PC-43 place 11; B 3.5).
-- Specification: tests/C02/W-C02-07/T-W07-N17_claim_token.md. How: each build function is renamed and a wrapper takes
-- its name; the wrapper finds the presented claim token's Assignment (by the hash rule EV-C02-003 §1.7 gives: SHA-256
-- of the whole token, hex, computed in the database), sets its role_class to the caller's (from the build's
-- derivation devos_private.caller_role_class), calls the build's function, and restores the role class. It holds
-- none of the build's logic. Synthetic (plan Section 8 item 13): no data. Applied only by the break harness on its
-- throwaway database (README 5.2), never under supabase/migrations/. No psql meta-command. The whole change runs
-- inside the guard's block.
-- Revised under ledger rule 3 (N-293's further fault, 2026-10-19; no result of this break had been counted): the
-- wrapper wrote a text value into the Assignment's role_class, an enum column (devos_private.role_class), so every
-- wrapped call raised 42804 and the red cases came out could_not_check (as B-F04-7's, N-291). The two values are now
-- cast to the column's type. The rule removed and the red list are unchanged (T-W07-N17, "Revision under ledger rule 3
-- (N-293 (4), 2026-10-19)").
do $b$
declare f record;
begin
  if coalesce(current_setting('w07.throwaway', true), '') <> 'yes' then
    raise exception 'w07 break patch refused: the setting w07.throwaway is not yes (throwaway database only)';
  end if;
  if exists (select 1 from pg_roles where rolname = 'supabase_admin') then
    raise exception 'w07 break patch refused: role supabase_admin exists, so this may be a Supabase project';
  end if;
  for f in select * from (values ('register_artifact', '(text, jsonb)', 'p_claim_token text, p jsonb', 'p_claim_token, p'),
                                  ('heartbeat', '(text)', 'p_claim_token text', 'p_claim_token'),
                                  ('release', '(text)', 'p_claim_token text', 'p_claim_token')) v(fn, sig, params, args) loop
    execute format('alter function devos_api.%I%s rename to %I', f.fn, f.sig, f.fn || '_w07_orig');
    execute format($p$
      create function devos_api.%1$I(%2$s) returns jsonb language plpgsql security definer set search_path = pg_catalog as $f$
      declare aid uuid; old text; rc text; r jsonb;
      begin
        rc := devos_private.caller_role_class(%4$L);
        select id, role_class into aid, old from devos_private.assignment
         where claim_token_hash = encode(sha256(convert_to(coalesce(p_claim_token, ''), 'UTF8')), 'hex');
        if aid is not null and rc is not null then
          update devos_private.assignment set role_class = rc::devos_private.role_class where id = aid;
        end if;
        r := devos_api.%3$I(%5$s);
        if aid is not null then update devos_private.assignment set role_class = old::devos_private.role_class where id = aid; end if;
        return r;
      end $f$ $p$, f.fn, f.params, f.fn || '_w07_orig', f.fn, f.args);
    execute format('grant execute on function devos_api.%I%s to anon', f.fn, f.sig);
  end loop;
end $b$;
