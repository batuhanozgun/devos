-- Synthetic test fixture (plan Section 8 item 13), W-C02-03 T-W03-14
-- H5: the repair of T-W03-14 item 2a. It sets the name in the history row of T-W03-05's fixture (version
-- 20261012231841) back to w03_fixture_apply, whatever it holds: in devos-test it restores the name H4 changed; in
-- devos, where H4 and this file apply in one run, it restores the name H4 has just changed. The run after shows "no
-- difference" in both projects. It fails, and changes nothing, unless exactly one row of that version exists.
do $$
declare v_rows bigint;
begin
  update supabase_migrations.schema_migrations set name = 'w03_fixture_apply' where version = '20261012231841';
  get diagnostics v_rows = row_count;
  if v_rows <> 1 then
    raise exception 'W-C02-03 T-W03-14 item 2a repair: expected one history row of 20261012231841; found %', v_rows;
  end if;
end
$$;
