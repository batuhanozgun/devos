-- w07-break: test=supabase/migrations/tests/w07_f06_state_change_event.sql; expect-red=F06-event:relate,F06-role-token
-- Removes event production from one function, relate: a trigger drops every event whose aggregate or event type names a relation, while relate runs (Appendix C F06, "Break").
-- Revised under ledger rule 3 (N-294 (2), 2026-10-19; no result of this break had been counted): the trigger dropped
-- every relation event, so it removed event production from link_prior_decisions too (its about relations' events,
-- EV-C02-013 2.2), and F06-event:link_prior_decisions turned red outside the red list. The patch now removes it from
-- relate alone, as its line 2 says: relate is wrapped to mark the transaction while it runs (w07_break.in_relate), and
-- the trigger drops a relation event only under that mark. The red list is unchanged (T-W07-F06, "Revision under
-- ledger rule 3 (N-293 (2), N-294 (2), 2026-10-19)").
-- Plan Section 8 item 3 (PC-42): applied ONLY by W-C02-07's break harness (tests/C02/W-C02-07/harness/) on a throwaway
-- PostgreSQL built from supabase/migrations/, never on devos-test or devos; it sits outside supabase/migrations/, so the
-- migration job never applies it. Synthetic (plan Section 8 item 13): no data. No psql meta-command is used.
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
create schema if not exists w07_break;
-- relate is copied, unchanged, as w07_break.relate_w07_orig (outside devos_api, so F06's catalogue list is unchanged),
-- and devos_api.relate(p jsonb) becomes a wrapper with the same parameter that marks the transaction while the copy
-- runs (create or replace keeps relate's privileges). The copy keeps definer rights and its fixed search_path.
do $c$
declare src text;
begin
  src := pg_get_functiondef('devos_api.relate(jsonb)'::regprocedure);
  src := regexp_replace(src, 'FUNCTION devos_api\.relate\(', 'FUNCTION w07_break.relate_w07_orig(');
  execute src;
end $c$;
revoke all on function w07_break.relate_w07_orig(jsonb) from public;
create or replace function devos_api.relate(p jsonb) returns jsonb language plpgsql security definer
set search_path = pg_catalog as $f$
declare r jsonb;
begin
  perform set_config('w07_break.in_relate', 'yes', true);
  r := w07_break.relate_w07_orig(p);
  perform set_config('w07_break.in_relate', '', true);
  return r;
end $f$;
create function w07_break.drop_relation_event() returns trigger language plpgsql as $f$
begin
  if coalesce(current_setting('w07_break.in_relate', true), '') = 'yes'
     and (coalesce(new.aggregate_type::text, '') ilike '%relat%' or coalesce(new.event_type::text, '') ilike '%relat%') then
    return null;
  end if;
  return new;
end $f$;
create trigger w07break_drop_relation_event before insert on devos_private.event
  for each row execute function w07_break.drop_relation_event();
commit;
