-- Synthetic test data (plan Section 8 item 13), extra check beyond the task's list, throwaway cluster only:
-- objects inside the entry-only schema public, and an extension installed in public.
\set ON_ERROR_STOP on
create table public.w03_fixture_probe_public_t (id integer primary key);
create view public.w03_fixture_probe_public_v as select id from public.w03_fixture_probe_public_t;
create function public.w03_fixture_probe_public_f() returns integer language sql as 'select 1';
create extension pgcrypto schema public;
select 'extra plant done';
