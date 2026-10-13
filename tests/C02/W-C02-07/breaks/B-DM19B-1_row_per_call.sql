-- w07-break: test=supabase/migrations/tests/w07_dm19b_burst_count.sql; expect-red=DM19B-accept-empty,DM19B-accept-malformed,DM19B-accept-missing,DM19B-accept-revoked,DM19B-accept-unknown,DM19B-token_role_class-empty,DM19B-token_role_class-malformed,DM19B-token_role_class-missing,DM19B-token_role_class-revoked,DM19B-token_role_class-unknown
-- Removes DM-19's bound on calls without a verified token (one counted row per function, reason code and hour): each in-place increase of a counted row also adds a row of its own (a copy at an earlier hour, count 1), so rows grow with calls. Per-call rows of verified callers are untouched.
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
do $p$
declare cols text;
begin
  select string_agg(quote_ident(attname), ', ' order by attnum) into cols from pg_attribute
   where attrelid = 'devos_private.rejected_attempt'::regclass and attnum > 0 and not attisdropped
     and attidentity = '' and attgenerated = '' and attname <> 'id';
  execute format($t$
    create function w07_break.copy_counted() returns trigger language plpgsql as $f$
    begin
      if new.counted_hour is not null then
        insert into devos_private.rejected_attempt (%1$s)
          select %1$s from jsonb_populate_record(null::devos_private.rejected_attempt, to_jsonb(new)
            || jsonb_build_object('counted_hour', new.counted_hour - make_interval(hours => new.count::int), 'count', 1));
      end if;
      return null;
    end $f$$t$, cols);
end $p$;
create trigger w07break_copy_counted after update on devos_private.rejected_attempt
  for each row execute function w07_break.copy_counted();
commit;
