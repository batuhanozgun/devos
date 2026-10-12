-- Synthetic test fixture (plan Section 8 item 13), W-C02-03 T-W03-05
-- Point 5's labelled fixture (tests/C02/W-C02-03/T-W03-05_apply_and_effect.md, "The fixture"). It creates only synthetic
-- objects in its own schema w03_fixture: the table w03_fixture.apply_check with one comment, and the view
-- w03_fixture.apply_check_view. It touches nothing outside that schema, calls neither issue_env_token nor
-- revoke_env_token (M24), and stays on main (migrations are append-only; M16). Its read in devos-test is
-- supabase/migrations/tests/w03_fixture_apply_read.sql, which compares each field below with this text; a forward
-- migration that removes this schema removes that read file in the same change.

create schema w03_fixture;

create table w03_fixture.apply_check (
  id integer primary key,
  note text not null default 'synthetic'
);

comment on table w03_fixture.apply_check is 'Synthetic test fixture (plan Section 8 item 13), W-C02-03 T-W03-05';

-- The view runs with its caller's privileges (security_invoker), so it never reads the table on its owner's behalf.
create view w03_fixture.apply_check_view with (security_invoker = true) as
  select id, note from w03_fixture.apply_check;

-- Nobody but the owner reaches the fixture: the schema is not exposed, and any default grant to PUBLIC or to Supabase's
-- API roles, where they exist, is removed.
revoke all on schema w03_fixture from public;
revoke all on table w03_fixture.apply_check, w03_fixture.apply_check_view from public;
do $$
declare v_role text;
begin
  foreach v_role in array array['anon', 'authenticated', 'service_role'] loop
    if exists (select 1 from pg_catalog.pg_roles where rolname = v_role) then
      execute format('revoke all on schema w03_fixture from %I', v_role);
      execute format('revoke all on table w03_fixture.apply_check, w03_fixture.apply_check_view from %I', v_role);
    end if;
  end loop;
end
$$;
