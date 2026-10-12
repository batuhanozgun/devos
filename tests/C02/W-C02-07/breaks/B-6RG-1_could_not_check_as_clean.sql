-- w07-break: test=w07_6rg_rule_gate_could_not_check.sql; expect-red=6RG-e1,6RG-e2,6RG-e3,6RG-e4,6RG-r1,6RG-r2,6RG-r3,6RG-r4,6RG-s1,6RG-s2,6RG-s3,6RG-g3,6RG-l1,6RG-l2,6RG-l3,6RG-l4
-- Rule removed: a rule-gate check's "could not check" is never counted as clean (plan Section 8 item 14; PC-16;
-- W-C02-09 point 7). Specification: tests/C02/W-C02-07/T-W07-6RG_rule_gate_could_not_check.md. How: register_artifact,
-- relate, prepare_operation and claim are renamed and wrappers take their names; a wrapper returns the build's answer,
-- except that a could_not_check answer is turned into {"status": "ok"} (the form README section 3 (i) calls folding
-- into clean). It holds none of the build's logic. Synthetic (plan Section 8 item 13): no data. Throwaway database
-- only (README 5.2), never under supabase/migrations/. No psql meta-command. The whole change runs inside the guard's block.
do $b$
declare f record;
begin
  if coalesce(current_setting('w07.throwaway', true), '') <> 'yes' then
    raise exception 'w07 break patch refused: the setting w07.throwaway is not yes (throwaway database only)';
  end if;
  if exists (select 1 from pg_roles where rolname = 'supabase_admin') then
    raise exception 'w07 break patch refused: role supabase_admin exists, so this may be a Supabase project';
  end if;
  for f in select * from (values ('register_artifact', '(text, jsonb)', 'a text, b jsonb', 'a, b'),
                                  ('prepare_operation', '(text, jsonb)', 'a text, b jsonb', 'a, b'),
                                  ('relate', '(jsonb)', 'b jsonb', 'b'),
                                  ('claim', '(uuid, text)', 'a uuid, b text', 'a, b')) v(fn, sig, params, args) loop
    execute format('alter function devos_api.%I%s rename to %I', f.fn, f.sig, f.fn || '_w07_orig');
    execute format($p$
      create function devos_api.%1$I(%2$s) returns jsonb language plpgsql security definer set search_path = pg_catalog as $f$
      declare r jsonb;
      begin
        r := devos_api.%3$I(%4$s);
        if r->>'status' = 'refused' and r->>'reason_code' = 'could_not_check' then return jsonb_build_object('status', 'ok', 'w07_break', 'folded into clean'); end if;
        return r;
      end $f$ $p$, f.fn, f.params, f.fn || '_w07_orig', f.args);
    execute format('grant execute on function devos_api.%I%s to anon', f.fn, f.sig);
  end loop;
end $b$;
