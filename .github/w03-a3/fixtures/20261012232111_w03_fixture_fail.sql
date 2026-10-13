-- Synthetic test fixture (plan Section 8 item 13), W-C02-03 T-W03-14
-- H2: T-W03-14 item 1 and T-W03-06 form (i). A migration that fails in both projects (P11: no property tells the
-- projects apart, so it fails in both, and the stop before devos is shown by GitHub's record of the run). It first
-- creates a synthetic schema and table, then raises, so that the run after shows whether a failed file leaves an
-- object or a history row (P2): the next push run's listing and comparison in each project. Its repair (H3) removes
-- this file, which M16 allows once the run report shows the version unapplied in both projects.
create schema w03_fixture_fail;
create table w03_fixture_fail.attempt (id integer primary key);
do $$
begin
  raise exception 'W-C02-03 T-W03-14 item 1: synthetic failing fixture (plan Section 8 item 13); it fails on purpose';
end
$$;
