-- w07-break: test=w07_n28_sample_exemption.sql; expect-red=S-ccc,S-ccc-partial,S-neg-direct
-- Phase C6 (CHK-C02-030 C7 (d); K22): S-ccc-partial, the marker present but incomplete through the hook
-- sample_marker_partial, turns red too (the drawn write accepted), for the same reason as S-ccc; with both hooks filled
-- the prober may narrow the patch to one case at a time.
-- Break patch for T-W07-N28 (tests/C02/W-C02-07/T-W07-N28_verifier_does_not_repair.md, "Break attempt"; phase C4a). EV-C02-008
-- 2.5's B-S4: the exemption granted when the marker is unreadable. The marker is read at two places, DM-41's trigger
-- (conditions 1 to 4) and the Review table's check (condition 2), and both fail closed, so a break at one of them is
-- masked by the other (the layering CHK-C02-026 C2 found for B-N01-2). The patch therefore puts an early return at the
-- top of every PL/pgSQL trigger function on devos_private.review that names sample rows, for a new Review of kind
-- sample with no reviewer: the marker is then never read, and an unreadable marker no longer refuses the drawn write.
-- S-ccc turns red (the drawn write accepted). Because the patch cannot tell an unreadable marker from an absent one
-- before the marker's form is named, S-neg-direct (a sample row with no marker) turns red too. With the hook
-- sample_marker_unreadable filled (W-C02-10's record; before the first result), the prober may narrow the patch to the
-- unreadable case, whose red is S-ccc alone. Until the hook is filled, the unpatched run gives COULD NOT CHECK and the
-- harness reports this break as could not check.
-- Applied ONLY by the break harness on its throwaway PostgreSQL built from supabase/migrations/ (README 5.2; plan Section 8
-- item 3 as PC-42 place 3 writes it), never on devos-test or devos; it sits outside supabase/migrations/, so no job applies it.
-- Synthetic (plan Section 8 item 13): no data. No psql meta-command is used.
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
do $p$
declare f record; def text; src text; n int := 0;
        early text := ' begin if tg_table_name = ''review'' then if (to_jsonb(new)->>''kind'') = ''sample'' '
          || 'and (to_jsonb(new)->>''reviewer_role_class'') is null then return new; end if; end if; ';
begin
  for f in select distinct p.oid from pg_trigger t join pg_proc p on p.oid = t.tgfoid join pg_language l on l.oid = p.prolang
            where not t.tgisinternal and t.tgrelid = 'devos_private.review'::regclass and p.prosrc ~* 'sample'
              and l.lanname = 'plpgsql' loop
    def := pg_get_functiondef(f.oid);
    src := regexp_replace(def, '[[:<:]]begin[[:>:]]', early, 'i');  -- the first begin of the body only
    if src <> def then execute src; n := n + 1; end if;
  end loop;
  if n = 0 then
    raise exception 'w07 break not applied: no PL/pgSQL trigger function on devos_private.review that names sample rows; not a break shown (W-C02-13 point 3)';
  end if;
end $p$;
commit;
