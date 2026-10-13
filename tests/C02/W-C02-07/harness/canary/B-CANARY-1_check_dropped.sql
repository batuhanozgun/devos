-- w07-break: test=w07_canary.sql; expect-red=CANARY-neg
-- Removes the canary's one rule (x > 0). Synthetic (plan Section 8 item 13): no data. Throwaway database only; no
-- psql meta-command.
do $g$
begin
  if coalesce(current_setting('w07.throwaway', true), '') <> 'yes' then
    raise exception 'w07 break patch refused: the setting w07.throwaway is not yes (throwaway database only)';
  end if;
  if exists (select 1 from pg_roles where rolname = 'supabase_admin') then
    raise exception 'w07 break patch refused: role supabase_admin exists, so this may be a Supabase project';
  end if;
end $g$;
alter table w07_canary.t drop constraint w07_canary_positive;
