-- w07-break: test=w07_6tk_token_reasons.sql,w07_idc_identity_chain.sql; expect-red=6TK-hu0-a,6TK-hu1-a,6TK-hu1-b,6TK-hu2-a,6TK-hu3-a,6TK-hu4-a,6TK-mi1-a,6TK-mi1-b,6TK-mi2-a,6TK-mi3-a,6TK-mi4-a,6TK-em1-a,6TK-em1-b,6TK-ma1-a,6TK-ma1-b,6TK-ma2-a,6TK-ma3-a,6TK-ma4-a,6TK-ma5-a,6TK-ma6-a,6TK-ma7-a,6TK-un1-a,6TK-un1-b,6TK-un2-a,6TK-rv1-a,6TK-rv1-b,IDC-r2
-- Break patch of tests/C02/W-C02-07/T-W07-6TK_token_reasons.md, "Break attempt" (README 5.2). Removed: the record of a call without a verified token (B 3.27; DM-19: counted as RejectedAttempt under role
-- class none): a trigger on RejectedAttempt's table (the name the test's w07_cfg assumes) drops every row or update whose
-- role_class is none.
begin;  -- the guard and the change in one transaction: a refused guard aborts the whole patch

-- Applied ONLY by the break harness on its throwaway PostgreSQL built from supabase/migrations/, never on
-- devos-test or devos; it sits outside supabase/migrations/, so no job applies it. It holds none of the build's
-- logic. Synthetic (plan Section 8 item 13): no data, no token. No psql meta-command.
do $g$
begin
  if coalesce(current_setting('w07.throwaway', true), '') <> 'yes' then
    raise exception 'w07 break patch refused: the setting w07.throwaway is not yes (throwaway database only)';
  end if;
  if exists (select 1 from pg_roles where rolname = 'supabase_admin') then
    raise exception 'w07 break patch refused: role supabase_admin exists, so this may be a Supabase project';
  end if;
end $g$;
do $b$
begin
  if to_regclass('devos_private.rejected_attempt') is null then
    raise exception 'w07 break not applied: devos_private.rejected_attempt (w07_cfg rejected) not found';
  end if;
  execute 'create function devos_private.w07_break_drop_none() returns trigger language plpgsql as $t$ begin '
          'if new.role_class::text = ''none'' then return null; end if; return new; end $t$';
  execute 'create trigger w07_break_drop_none before insert or update on devos_private.rejected_attempt for each row '
          'execute function devos_private.w07_break_drop_none()';
end $b$;
commit;
