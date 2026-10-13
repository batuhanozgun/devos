-- Synthetic (plan Section 8 item 13): the harness's own canary, applied only with --canary on a throwaway cluster.
-- It is not a DevOS migration and is never under supabase/migrations/. No psql meta-command.
create schema w07_canary;
create table w07_canary.t (x int constraint w07_canary_positive check (x > 0));
