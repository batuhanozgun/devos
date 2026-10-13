-- w07-break: test=w07_idc_identity_chain.sql; expect-red=IDC-r1
-- Break patch of tests/C02/W-C02-07/T-W07-IDC_identity_chain.md, "Break attempt" (README 5.2). Removed: the epoch increment of revoke_env_token (B:46; B principle 9): a trigger on the global authority
-- epoch's table (the name the test's w07_cfg assumes) cancels every update of it.
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
  if to_regclass('devos_private.global_authority_epoch') is null then
    raise exception 'w07 break not applied: the epoch table devos_private.global_authority_epoch (w07_cfg epoch_table) not found';
  end if;
  execute 'create function devos_private.w07_break_keep_epoch() returns trigger language plpgsql as $t$ begin return old; end $t$';
  execute 'create trigger w07_break_keep_epoch before update on devos_private.global_authority_epoch for each row '
          'execute function devos_private.w07_break_keep_epoch()';
end $b$;
commit;
