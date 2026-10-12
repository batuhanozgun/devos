-- w07-break: test=w07_n01_need_justification.sql; expect-red=N01-tok-devos_calisma,N01-tok-devos_denetim,N01-tok-devos_sinav,N01-tok-devos_kurulum
-- Break patch for T-W07-N01 (tests/C02/W-C02-07/T-W07-N01_*.md, "Break attempt"). Rule removed: the refusal of a sample Review written with an environment token (B 3.11: created by the database, never by an agent).
-- Applied ONLY by the break harness on its throwaway PostgreSQL built from supabase/migrations/ (README 5.2; plan Section 8
-- item 3 as PC-42 place 3 writes it), never on devos-test or devos; it sits outside supabase/migrations/, so no job applies it.
-- It removes one rule and holds as little of the build's logic as it can; the names it uses are the interface the
-- specification assumes (revised before a first result if the build differs, README section 8).
-- Synthetic (plan Section 8 item 13): no data; any value it writes is labelled w07 break. No psql meta-command is used.
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
alter function devos_api.open_review(jsonb) rename to open_review_w07_orig;
create function devos_api.open_review(p jsonb) returns jsonb language plpgsql security definer
set search_path = pg_catalog as $f$
declare nid uuid;
begin
  if p->>'kind' = 'sample' then
    nid := gen_random_uuid();
    insert into devos_private.review select * from jsonb_populate_record(null::devos_private.review,
      jsonb_build_object('id', nid, 'kind', 'sample', 'target_ref', p->>'target_ref', 'queue_role_class', 'devos_denetim', 'origin', 'call'));
    return jsonb_build_object('status', 'ok', 'id', nid);
  end if;
  return devos_api.open_review_w07_orig(p);
end $f$;
grant execute on function devos_api.open_review(jsonb) to anon, authenticated;
commit;
