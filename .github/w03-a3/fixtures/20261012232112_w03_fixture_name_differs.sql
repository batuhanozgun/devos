-- Synthetic test fixture (plan Section 8 item 13), W-C02-03 T-W03-14
-- H4: T-W03-14 item 2a and T-W03-06 form (ii). It applies, and changes the name in the history row of T-W03-05's
-- fixture (version 20261012231841), so that deployment_drift then names name_differs for that version where it has
-- applied: in devos-test, whose comparison after the apply is then not clean, so go is not yes and devos is not
-- reached. The command-line tool compares versions only, so the renamed row does not hold a later dry run or apply
-- (P2, settled offline with the pinned tool; T-W03-14). Its repair is H5. It refuses, and changes nothing, unless
-- exactly one row of that version holds the name w03_fixture_apply.
do $$
declare v_rows bigint;
begin
  update supabase_migrations.schema_migrations set name = 'w03_fixture_apply_renamed'
   where version = '20261012231841' and name = 'w03_fixture_apply';
  get diagnostics v_rows = row_count;
  if v_rows <> 1 then
    raise exception 'W-C02-03 T-W03-14 item 2a: expected one history row of 20261012231841 named w03_fixture_apply; renamed %', v_rows;
  end if;
end
$$;
