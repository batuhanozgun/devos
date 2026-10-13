-- w07-break: test=w07_6st_settings_could_not_check.sql; expect-red=6ST-wh-cal-missing,6ST-wh-cal-unreadable,6ST-wh-cal-partial,6ST-wh-sin-missing,6ST-wh-sin-unreadable,6ST-wh-sin-partial,6ST-wh-kur-missing,6ST-wh-kur-unreadable,6ST-wh-kur-partial,6ST-wh-ci-missing,6ST-wh-ci-unreadable,6ST-wh-ci-partial
-- Break patch for T-W07-6ST (tests/C02/W-C02-07/T-W07-6ST_settings_could_not_check.md, "Break attempt" (5); phase C6,
-- CHK-C02-030 C7 (a), gap G24). Rule removed: the withholding's "could not check" when the stream's block state cannot
-- be read (EV-C02-008 5.2 (a); W-C02-07 point 6): an unreadable, missing or partial block state is taken as "not withheld",
-- so a read returns the open sample, its Verdict and their events. The withholding is the build's; this patch wraps the
-- stand-in's one helper that decides it, devos_private.sample_withheld(review uuid, role_class text), as B-N01-4 names it:
-- an error or a null from it becomes false. The prober writes the build's equivalent in before the run (as B-N01-4's
-- header says); a build with no such helper gets the patch rewritten to remove the same rule.
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
alter function devos_private.sample_withheld(uuid, text) rename to sample_withheld_w07_break;
create function devos_private.sample_withheld(p_review uuid, rc text) returns boolean language plpgsql stable
security definer set search_path = pg_catalog as $f$
begin
  return coalesce(devos_private.sample_withheld_w07_break(p_review, rc), false);
exception when others then
  return false;
end $f$;
commit;
