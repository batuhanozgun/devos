-- w07-break: test=supabase/migrations/tests/w07_f06_state_change_event.sql; expect-red=F06-event:relate,F06-role-token
-- Removes event production from one function, relate: a trigger drops every event whose aggregate or event type names a relation (Appendix C F06, "Break").
-- Plan Section 8 item 3 (PC-42): applied ONLY by W-C02-07's break harness (tests/C02/W-C02-07/harness/) on a throwaway
-- PostgreSQL built from supabase/migrations/, never on devos-test or devos; it sits outside supabase/migrations/, so the
-- migration job never applies it. Synthetic (plan Section 8 item 13): no data. No psql meta-command is used.
do $g$
begin
  if coalesce(current_setting('w07.throwaway', true), '') <> 'yes' then
    raise exception 'w07 break patch refused: the setting w07.throwaway is not yes (throwaway database only)';
  end if;
  if exists (select 1 from pg_roles where rolname = 'supabase_admin') then
    raise exception 'w07 break patch refused: role supabase_admin exists, so this may be a Supabase project';
  end if;
end $g$;
create schema if not exists w07_break;
create function w07_break.drop_relation_event() returns trigger language plpgsql as $f$
begin
  if coalesce(new.aggregate_type::text, '') ilike '%relat%' or coalesce(new.event_type::text, '') ilike '%relat%' then
    return null;
  end if;
  return new;
end $f$;
create trigger w07break_drop_relation_event before insert on devos_private.event
  for each row execute function w07_break.drop_relation_event();
