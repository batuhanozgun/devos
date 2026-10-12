-- w07-break: test=tests/C02/W-C02-07/harness/scenarios/n01_open_block.sql; expect-red=N01-unseen-after
-- Break patch for T-W07-N01 part B (phase C4b; EV-C02-008 5.2's table, N01-unseen-after: "A break that withholds for good";
-- its ID is the designer's). Rule changed: 5.2 (a) ("Once that block is complete ..., they are readable as any Review and
-- Verdict are").
-- The withholding is the build's; this patch replaces the stand-in's one helper that decides it,
-- devos_private.sample_withheld(review uuid, role_class text) (true while the review is a sample of its stream's open
-- block and the class is not devos_denetim). The prober writes the build's equivalent in before the run (as B-N08-1's
-- line names the stand-in's reader); a build with no such helper gets the patch rewritten to remove the same rule.
-- The patch withholds every sample from every class but devos_denetim, whether or not its block is complete.
-- Applied ONLY by the break harness on its throwaway PostgreSQL built from supabase/migrations/ (README 5.2; plan Section 8
-- item 3 as PC-42 place 3 writes it), never on devos-test or devos; it sits outside supabase/migrations/, so no job applies it.
-- It removes one rule and holds as little of the build's logic as it can; the names it uses are the interface the
-- specification assumes (revised before a first result if the build differs, README section 8). The caller's class is
-- read through devos_api.token_role_class() (README 8.1: it carries role_class).
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
create or replace function devos_private.sample_withheld(p_review uuid, rc text) returns boolean language sql stable
security definer set search_path = pg_catalog as $f$
  select coalesce(rc, '') <> 'devos_denetim' and exists (select 1 from devos_private.review r where r.id = p_review and r.kind = 'sample') $f$;
commit;
