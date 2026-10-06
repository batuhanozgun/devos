-- ============================================================================
-- P3 probe schema for C01 (plan DevOS_Kurulum_Plani.md Section 9, C01, "Probe
-- setup"; designed by W-C01-03, EV-C01-002_probe_design.md).
--
-- SYNTHETIC. Every row below is made up for the probe (plan Section 8 item 13).
-- It contains NO personal or business data and nothing copied from Batu's other
-- repositories or accounts.
--
-- THIS IS NOT THE MIGRATION PATH (plan 6.2). It is a one-off text Batu runs once
-- in the SQL editor of the Supabase project `devos-test`. DevOS's real schema is
-- built only from versioned files under supabase/migrations/ in C02. C02's FIRST
-- migration removes this probe schema and, with it, the probe token hashes (plan
-- C01, P3; C02's acceptance). The removal statements are listed, commented out,
-- at the foot of this file for reference; C02's migration carries them, not this
-- text and not Batu.
--
-- Placement decision (EV-C01-002 item 2): the objects live in `public` with the
-- prefix `probe_c01_`, NOT in their own schema. Their own schema would need an
-- extra Batu step (exposing it through the project's API settings so PostgREST
-- can reach it); `public` is exposed by default, so no extra step. Trade-off:
-- `public` is shared, so access is locked down by RLS on every table + access
-- only through SECURITY DEFINER functions with a fixed search_path + explicit
-- grants to the `anon` role. C02 builds DevOS in `devos_private`/`devos_api`
-- (6.2), so nothing of DevOS is in `public`; a prefixed drop removes everything.
--
-- GRANTS ARE EXPLICIT, NOT DEFAULT (EV-C01-002 item 2; CHK-C01-011 condition 1;
-- CHK-C01-010 findings 4-5; setup-facts report 2 section 5). PostgreSQL grants
-- EXECUTE on a new function to PUBLIC, and Supabase's platform default grants
-- EXECUTE to `anon`/`authenticated` on functions in `public` (that platform
-- default is being withdrawn for existing projects on 2026-10-30, but the
-- project's creation date is not observed here). This text does NOT rely on
-- either default in either direction: every function below first REVOKEs EXECUTE
-- from `public`, `anon` and `authenticated`, then GRANTs to `anon` only the five
-- functions a probe session needs. So the design holds whether the project is
-- before or after the cut-over. (`service_role` keeps the platform default; it is
-- reached only with the project's secret key, which no probe or builder holds.)
--
-- Token format (EV-C01-002 item 2): dvs_probe_<32 lowercase hex>, i.e. the
-- regular expression  ^dvs_probe_[0-9a-f]{32}$  . A scan and the guard can match
-- it (row 3's fail path). The token is generated here, shown once by
-- probe_c01_issue_token, and stored only as a SHA-256 hash.
-- ============================================================================

-- pgcrypto provides gen_random_bytes and digest. On Supabase it lives in the
-- `extensions` schema; functions below qualify it as extensions.* .
create extension if not exists pgcrypto with schema extensions;

-- ----------------------------------------------------------------------------
-- Tables (RLS on; no direct access for anon/authenticated)
-- ----------------------------------------------------------------------------

-- token -> role class, by the token's hash only (never the token value)
create table if not exists public.probe_c01_tokens (
    token_hash  text primary key,
    role_class  text not null check (role_class in ('probe_a', 'probe_b')),
    created_at  timestamptz not null default now()
);
alter table public.probe_c01_tokens enable row level security;
revoke all on public.probe_c01_tokens from public, anon, authenticated;
-- No RLS policy is created, so even with the table-level grant removed, a direct
-- PostgREST read as anon/authenticated returns nothing: access is only through
-- the SECURITY DEFINER functions below, which run as the table owner.

-- a small queue of SYNTHETIC work items. Each unreserved item is tagged with the
-- role class allowed to claim it (claimable_by), so neither probe environment can
-- claim the other's items (CHK-C01-011 condition 2). The share is sized to the
-- claiming role's planned item-taking runs:
--   probe_a : items 1-4  (routine A: run step-1 takes exactly 2, run step-2
--                         takes 1; 1 left as a margin)
--   probe_b : none       (routine B takes no queue item, EV-C01-002 item 3 /
--                         CHK-C01-011 finding 13; so probe_b's share is 0)
-- Items 5-6 are reserved for C01's combined scenario (W-C01-29 item 1); they are
-- never handed out by probe_c01_next_item, only by probe_c01_next_reserved_item,
-- which only the combined-scenario run calls (EV-C01-002 item 2).
create table if not exists public.probe_c01_queue (
    id            int primary key,
    title         text not null,
    payload       jsonb not null,
    claimable_by  text not null check (claimable_by in ('probe_a', 'probe_b')),
    reserved_for  text,                -- 'combined_scenario' => only next_reserved_item
    status        text not null default 'pending'
                  check (status in ('pending', 'claimed', 'done')),
    claimed_by    text,
    claimed_at    timestamptz,
    done_at       timestamptz
);
alter table public.probe_c01_queue enable row level security;
revoke all on public.probe_c01_queue from public, anon, authenticated;

insert into public.probe_c01_queue (id, title, payload, claimable_by, reserved_for) values
    (1, 'SYNTHETIC probe item A', '{"note": "synthetic; echo the id"}', 'probe_a', null),
    (2, 'SYNTHETIC probe item B', '{"note": "synthetic; echo the id"}', 'probe_a', null),
    (3, 'SYNTHETIC probe item C', '{"note": "synthetic; echo the id"}', 'probe_a', null),
    (4, 'SYNTHETIC probe item D', '{"note": "synthetic; echo the id"}', 'probe_a', null),
    (5, 'SYNTHETIC combined-scenario item E', '{"note": "synthetic"}', 'probe_a', 'combined_scenario'),
    (6, 'SYNTHETIC combined-scenario item F', '{"note": "synthetic"}', 'probe_a', 'combined_scenario')
on conflict (id) do nothing;

-- ----------------------------------------------------------------------------
-- The single line per probe environment that shows its probe token ONCE (6.3).
-- Batu runs, in the devos-test SQL editor (as the project owner):
--     select public.probe_c01_issue_token('probe_a');   -- for devos-probe-a
--     select public.probe_c01_issue_token('probe_b');   -- for devos-probe-b
-- The returned value is the token, shown this one time; its hash is stored. The
-- function is NOT granted to anon/authenticated, so no probe session can mint a
-- token. The builder never sees the value.
-- ----------------------------------------------------------------------------
create or replace function public.probe_c01_issue_token(p_role_class text)
returns text
language plpgsql
security definer
set search_path = ''
as $$
declare
    v_token text;
    v_hash  text;
begin
    if p_role_class not in ('probe_a', 'probe_b') then
        raise exception 'role_class must be probe_a or probe_b';
    end if;
    v_token := 'dvs_probe_' || pg_catalog.encode(extensions.gen_random_bytes(16), 'hex');
    v_hash  := pg_catalog.encode(extensions.digest(v_token, 'sha256'), 'hex');
    insert into public.probe_c01_tokens (token_hash, role_class)
        values (v_hash, p_role_class);
    return v_token;   -- shown once; never stored, never returned again
end;
$$;
revoke all on function public.probe_c01_issue_token(text) from public, anon, authenticated;

-- ----------------------------------------------------------------------------
-- Revoking a probe token before C02 (note N-124; plan C01 row 3's fail path: "a
-- token found outside its settings field is revoked and renewed"). Used ONLY if
-- a probe token is found outside its environment's settings field. Batu runs, in
-- the devos-test SQL editor (as the project owner):
--     select public.probe_c01_revoke_tokens('probe_a');   -- or 'probe_b'
-- It deletes every stored hash of that role class, so the leaked token no longer
-- derives a class (whoami then returns 'unknown'); it returns how many it
-- deleted, never a token. Renewal: issue a new token with probe_c01_issue_token
-- and replace the environment's API credential. Not granted to anon/authenticated.
-- ----------------------------------------------------------------------------
create or replace function public.probe_c01_revoke_tokens(p_role_class text)
returns integer
language plpgsql
security definer
set search_path = ''
as $$
declare
    v_count integer;
begin
    if p_role_class not in ('probe_a', 'probe_b') then
        raise exception 'role_class must be probe_a or probe_b';
    end if;
    delete from public.probe_c01_tokens where role_class = p_role_class;
    get diagnostics v_count = row_count;
    return v_count;
end;
$$;
revoke all on function public.probe_c01_revoke_tokens(text) from public, anon, authenticated;

-- ----------------------------------------------------------------------------
-- Role resolution from the request header (INTERNAL helper used by the functions
-- below; never granted to any API role). The probe token rides in a separate
-- request header, X-Probe-Token, attached by the environment's API credential
-- outside the session's view (EV-C01-002 item 1, item 3). PostgREST forwards
-- request headers into request.headers (lower-cased). The function hashes the
-- header value and looks up the role class; it never returns or logs the token.
-- The functions below are SECURITY DEFINER owned by the SQL-editor user; when
-- they run they run AS that owner, who keeps EXECUTE on functions it owns, so
-- revoking this helper from public/anon/authenticated does not break them.
-- ----------------------------------------------------------------------------
create or replace function public.probe_c01_role_from_request()
returns text
language sql
security definer
stable
set search_path = ''
as $$
    select t.role_class
    from public.probe_c01_tokens t
    where t.token_hash = pg_catalog.encode(
        extensions.digest(
            pg_catalog.current_setting('request.headers', true)::json ->> 'x-probe-token',
            'sha256'),
        'hex');
$$;
revoke all on function public.probe_c01_role_from_request() from public, anon, authenticated;

-- row 3: the database derives the role class from the token's hash. Returns the
-- role class, or 'unknown'. STABLE, so PostgREST allows a GET call (no POST).
create or replace function public.probe_c01_whoami()
returns text
language sql
security definer
stable
set search_path = ''
as $$
    select coalesce(public.probe_c01_role_from_request(), 'unknown');
$$;
revoke all on function public.probe_c01_whoami() from public, anon, authenticated;

-- row 3: confirms a header was attached WITHOUT revealing its value. Returns the
-- header NAMES present and a boolean for X-Probe-Token; never the token.
create or replace function public.probe_c01_echo_headers()
returns json
language sql
security definer
stable
set search_path = ''
as $$
    select json_build_object(
        'x_probe_token_present',
            (pg_catalog.current_setting('request.headers', true)::json ->> 'x-probe-token') is not null,
        'header_names',
            (select coalesce(json_agg(k order by k), '[]'::json)
             from json_object_keys(
                  coalesce(pg_catalog.current_setting('request.headers', true)::json, '{}'::json)) as k)
    );
$$;
revoke all on function public.probe_c01_echo_headers() from public, anon, authenticated;

-- row 1: claim the next UNRESERVED pending item that the caller's role class may
-- claim, so a session can run more than one work item from the queue. The
-- claimable_by filter means neither class can take the other's items
-- (CHK-C01-011 condition 2). VOLATILE => a POST.
create or replace function public.probe_c01_next_item()
returns public.probe_c01_queue
language plpgsql
security definer
set search_path = ''
as $$
declare
    v_role text := public.probe_c01_role_from_request();
    v_row  public.probe_c01_queue;
begin
    if v_role is null then
        raise exception 'no probe role for this request';
    end if;
    update public.probe_c01_queue q
       set status = 'claimed', claimed_by = v_role, claimed_at = now()
     where q.id = (
         select id from public.probe_c01_queue
          where status = 'pending' and reserved_for is null and claimable_by = v_role
          order by id
          for update skip locked
          limit 1)
    returning q.* into v_row;
    return v_row;   -- NULL row when no claimable item is left
end;
$$;
revoke all on function public.probe_c01_next_item() from public, anon, authenticated;

-- W-C01-29 item 1: claim one of the two RESERVED combined-scenario items. The
-- ONLY route to the reserved items, so no second SQL step is needed for the
-- combined scenario; probe_c01_next_item never returns them. Only the combined
-- scenario's run calls this (EV-C01-002 item 2 / item 5). VOLATILE => a POST.
create or replace function public.probe_c01_next_reserved_item()
returns public.probe_c01_queue
language plpgsql
security definer
set search_path = ''
as $$
declare
    v_role text := public.probe_c01_role_from_request();
    v_row  public.probe_c01_queue;
begin
    if v_role is null then
        raise exception 'no probe role for this request';
    end if;
    update public.probe_c01_queue q
       set status = 'claimed', claimed_by = v_role, claimed_at = now()
     where q.id = (
         select id from public.probe_c01_queue
          where status = 'pending' and reserved_for = 'combined_scenario'
            and claimable_by = v_role
          order by id
          for update skip locked
          limit 1)
    returning q.* into v_row;
    return v_row;
end;
$$;
revoke all on function public.probe_c01_next_reserved_item() from public, anon, authenticated;

-- row 1 / W-C01-29: mark a claimed item done. The claimed_by check stops one
-- class completing the other's items.
create or replace function public.probe_c01_complete_item(p_id int)
returns public.probe_c01_queue
language plpgsql
security definer
set search_path = ''
as $$
declare
    v_role text := public.probe_c01_role_from_request();
    v_row  public.probe_c01_queue;
begin
    if v_role is null then
        raise exception 'no probe role for this request';
    end if;
    update public.probe_c01_queue q
       set status = 'done', done_at = now()
     where q.id = p_id and q.claimed_by = v_role and q.status = 'claimed'
    returning q.* into v_row;
    return v_row;
end;
$$;
revoke all on function public.probe_c01_complete_item(int) from public, anon, authenticated;

-- ----------------------------------------------------------------------------
-- Grants: EXECUTE to `anon` only, and only on the five functions a probe session
-- calls. `authenticated` is NOT granted (a probe uses the publishable/anon key,
-- which maps to `anon`). issue_token, revoke_tokens and role_from_request are
-- never granted to any API role.
-- ----------------------------------------------------------------------------
grant execute on function public.probe_c01_whoami()              to anon;
grant execute on function public.probe_c01_echo_headers()        to anon;
grant execute on function public.probe_c01_next_item()           to anon;
grant execute on function public.probe_c01_next_reserved_item()  to anon;
grant execute on function public.probe_c01_complete_item(int)    to anon;

-- Make the API (PostgREST) reload its schema cache now, so the new functions are
-- callable at once (the documented reload; harmless if it already reloaded).
notify pgrst, 'reload schema';

-- ============================================================================
-- REMOVAL (reference only; carried by C02's FIRST migration, plan C01 P3 /
-- C02's acceptance; NOT run from this file and NOT a Batu step). Dropping these
-- objects removes the probe token hashes with them.
--
--   drop function if exists public.probe_c01_complete_item(int);
--   drop function if exists public.probe_c01_next_reserved_item();
--   drop function if exists public.probe_c01_next_item();
--   drop function if exists public.probe_c01_echo_headers();
--   drop function if exists public.probe_c01_whoami();
--   drop function if exists public.probe_c01_role_from_request();
--   drop function if exists public.probe_c01_issue_token(text);
--   drop function if exists public.probe_c01_revoke_tokens(text);
--   drop table    if exists public.probe_c01_queue;
--   drop table    if exists public.probe_c01_tokens;   -- the token hashes go here
-- ============================================================================
