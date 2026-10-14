-- Stand-ins for Supabase's own objects on the throwaway cluster (T-W03-10 "Stage and environment"): the API roles,
-- auth.users, and the command-line tool's history table (P1: the tool creates supabase_migrations at its first push).
\set ON_ERROR_STOP on
create role anon nologin noinherit;
create role authenticated nologin noinherit;
create role service_role nologin noinherit bypassrls;
create role authenticator login noinherit;
grant anon, authenticated, service_role to authenticator;
create schema auth;
create table auth.users (id uuid primary key, email text);
create schema supabase_migrations;
create table supabase_migrations.schema_migrations (version text primary key, statements text[], name text);
select 'standins done';
