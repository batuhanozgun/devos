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
-- only through SECURITY DEFINER functions with a fixed search_path + minimal
-- grants to the `anon` role. C02 builds DevOS in `devos_private`/`devos_api`
-- (6.2), so nothing of DevOS is in `public`; a prefixed drop removes everything.
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
revoke all on public.probe_c01_tokens from anon, authenticated;
-- No RLS policy is created, so even with the table-level grant removed, a direct
-- PostgREST read as anon/authenticated returns nothing: access is only through
-- the SECURITY DEFINER functions below, which run as the table owner.

-- a small queue of SYNTHETIC work items; two are reserved for C01's combined
-- scenario (W-C01-29 item 1) and are never handed out by probe_c01_next_item
create table if not exists public.probe_c01_queue (
    id           int primary key,
    title        text not null,
    payload      jsonb not null,
    reserved_for text,                 -- 'combined_scenario' => left for W-C01-29
    status       text not null default 'pending'
                 check (status in ('pending', 'claimed', 'done')),
    claimed_by   text,
    claimed_at   timestamptz,
    done_at      timestamptz
);
alter table public.probe_c01_queue enable row level security;
revoke all on public.probe_c01_queue from anon, authenticated;

insert into public.probe_c01_queue (id, title, payload, reserved_for) values
    (1, 'SYNTHETIC probe item A', '{"note": "synthetic; echo the id"}', null),
    (2, 'SYNTHETIC probe item B', '{"note": "synthetic; echo the id"}', null),
    (3, 'SYNTHETIC probe item C', '{"note": "synthetic; echo the id"}', null),
    (4, 'SYNTHETIC probe item D', '{"note": "synthetic; echo the id"}', null),
    (5, 'SYNTHETIC combined-scenario item E', '{"note": "synthetic"}', 'combined_scenario'),
    (6, 'SYNTHETIC combined-scenario item F', '{"note": "synthetic"}', 'combined_scenario')
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
-- and replace the environment's API credential (delete it, add it again). Not
-- granted to anon/authenticated: no probe session can revoke or renew.
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
-- Role resolution from the request header (used by the functions below).
-- The probe token rides in a separate request header, X-Probe-Token, attached by
-- the environment's API credential outside the session's view (EV-C01-002 item 1,
-- item 3). PostgREST forwards request headers into request.headers (lower-cased).
-- The function hashes the header value and looks up the role class; it never
-- returns or logs the token.
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

-- row 1: claim the next unreserved pending item for the caller's role class, so a
-- session can run more than one work item from the queue. VOLATILE => a POST.
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
          where status = 'pending' and reserved_for is null
          order by id
          for update skip locked
          limit 1)
    returning q.* into v_row;
    return v_row;   -- NULL row when the queue is empty
end;
$$;

-- row 1: mark a claimed item done.
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

-- Grants: anon gets only what a probe session needs; issue_token is excluded.
grant execute on function public.probe_c01_whoami()            to anon, authenticated;
grant execute on function public.probe_c01_echo_headers()      to anon, authenticated;
grant execute on function public.probe_c01_next_item()         to anon, authenticated;
grant execute on function public.probe_c01_complete_item(int)  to anon, authenticated;
-- probe_c01_role_from_request is an internal helper; not granted.

-- ============================================================================
-- REMOVAL (reference only; carried by C02's FIRST migration, plan C01 P3 /
-- C02's acceptance; NOT run from this file and NOT a Batu step). Dropping these
-- objects removes the probe token hashes with them.
--
--   drop function if exists public.probe_c01_complete_item(int);
--   drop function if exists public.probe_c01_next_item();
--   drop function if exists public.probe_c01_echo_headers();
--   drop function if exists public.probe_c01_whoami();
--   drop function if exists public.probe_c01_role_from_request();
--   drop function if exists public.probe_c01_issue_token(text);
--   drop function if exists public.probe_c01_revoke_tokens(text);
--   drop table    if exists public.probe_c01_queue;
--   drop table    if exists public.probe_c01_tokens;   -- the token hashes go here
-- ============================================================================
