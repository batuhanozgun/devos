-- Synthetic test data (plan Section 8 item 13), T-W03-10 sensitivity check, throwaway cluster only:
-- (d) schema w03_fixture_probe with table token_hashes (and the view and function T-W03-10 names); (e) role w03_fixture_probe_role.
\set ON_ERROR_STOP on
create schema w03_fixture_probe;
create table w03_fixture_probe.token_hashes (id integer primary key, token_hash text not null);
create view w03_fixture_probe.token_hashes_view as select id from w03_fixture_probe.token_hashes;
create function w03_fixture_probe.f() returns integer language sql as 'select 1';
create role w03_fixture_probe_role nologin;
select 'plant done';
