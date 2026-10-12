-- w07-break: test=tests/C02/W-C02-07/harness/scenarios/n28_sample_taking.sql; expect-red=S-neg-take-revision-first
-- Break patch for T-W07-N28 (tests/C02/W-C02-07/T-W07-N28_verifier_does_not_repair.md, "Break attempt"; phase C4a). EV-C02-008
-- 2.5's B-S3 in its Verdict form, which every build has (the paragraph added for CHK-C02-026 C1): DM-41's trigger treats a
-- Verdict on a sample Review as exempt, by judging the Verdict's review by conditions 1 and 4 (kind sample, reviewer
-- fields still empty). The patch puts an early return at the top of each trigger function on devos_private.verdict that
-- reads revisions (B-N28-1's selection), for a Verdict whose review is such a sample; a function shared with other tables
-- is changed for the verdict table only. Then a new revision of the target written first, and the Verdict after it, are
-- both written: S-neg-take-revision-first turns red. In the other order the revision's own side of DM-41 still finds
-- the Verdict in its transaction, so S-neg-take-verdict-first stays green, and the list names only the first. If no such
-- function is found, or it is not PL/pgSQL, the patch raises and the prober writes the change for the build's form.
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
        early text := ' begin if tg_table_name = ''verdict'' then if exists (select 1 from devos_private.review w07r '
          || 'where w07r.id::text = (to_jsonb(new)->>''review_ref'') and w07r.kind::text = ''sample'' '
          || 'and w07r.reviewer_role_class is null) then return new; end if; end if; ';
begin
  for f in select distinct p.oid from pg_trigger t join pg_proc p on p.oid = t.tgfoid join pg_language l on l.oid = p.prolang
            where not t.tgisinternal and t.tgrelid = 'devos_private.verdict'::regclass and p.prosrc ~* 'revision'
              and l.lanname = 'plpgsql' loop
    def := pg_get_functiondef(f.oid);
    src := regexp_replace(def, '[[:<:]]begin[[:>:]]', early, 'i');  -- the first begin of the body only
    if src <> def then execute src; n := n + 1; end if;
  end loop;
  if n = 0 then
    raise exception 'w07 break not applied: no PL/pgSQL trigger function on devos_private.verdict that reads revisions; not a break shown (W-C02-13 point 3)';
  end if;
end $p$;
commit;
