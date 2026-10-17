-- DevOS schema (W-C02-09), not a fixture. M09-01: the identity chain's first part (N-221 step 1).
-- Sources: plan/work/W-C02-09.md points 1 to 5 and 7; Appendix B principles 2 and 8, section 2, 3.13, 3.27 and section 4;
-- evidence/C02/EV-C02-013_w09_interface.md sections 1, 2.1 and 10 (Revision 1 included; checked by CHK-C02-076 and
-- CHK-C02-077); evidence/C02/EV-C02-003_identity_chain_and_environments.md sections 1.1, 1.3, 1.4, 1.6, 1.7, 4.1, 6.3,
-- 14 and 15; EV-C02-002 DM-01, DM-19, DM-31 and DM-36; tests/C02/W-C02-07/shared/token_format.md.
-- Record: evidence/C02/EV-C02-014_w09_build.md section 1.
-- It holds exactly section 10's row M09-01: pgcrypto in the schema extensions; devos_private.token_hash, the counted-row
-- writer (devos_private.reject_counted), devos_private.write_event, devos_private.caller_role_class and the two
-- owner-only functions; devos_api.token_role_class(); and devos_api.deployment_drift replaced. No statement here runs
-- the owner-only functions (B:46; W-C02-09 point 3). No token, hash or key value is written here. The environment
-- token's marker is spelled in two pieces, so that only shared/token_format.md and the scan's pattern file hold it
-- literally (tests/C02/W-C02-07/README.md section 6).
-- Every function: security definer, owner postgres (the migration login), search_path pg_catalog then pg_temp, and
-- every DevOS relation, type and function it names schema-qualified (EV-C02-013 section 1 item 12).

-- pgcrypto, for the database's cryptographic random source (EV-C02-003 section 1.3; EV-C02-013 section 2.1). Supabase
-- provides the schema extensions; on a project where pgcrypto already exists this does nothing.
create extension if not exists pgcrypto with schema extensions;

-- The hash rule for both kinds of token (EV-C02-003 section 1.7; EV-C02-013 section 10, "Forms the merged break
-- patches read"): the SHA-256 of the whole token, PostgreSQL's built-in sha256, lower-case hexadecimal.
create function devos_private.token_hash(token text)
returns text
language sql
immutable
strict
security definer
set search_path = pg_catalog, pg_temp
as $fn$
  select encode(sha256(convert_to(token, 'UTF8')), 'hex')
$fn$;

-- The one private writer of events (EV-C02-013 section 1 item 10; B 3.13; DM-31). The payload never holds a token, a
-- claim token or a hash of either; the callers are responsible for what they pass, and the role class is the
-- derivation's (or owner for the owner-only functions), never a declared one.
create function devos_private.write_event(p_aggregate_type text, p_aggregate_id uuid, p_aggregate_revision integer,
                                          p_event_type text, p_payload jsonb, p_role_class text,
                                          p_origin devos_private.event_origin, p_declared_session_id text default null)
returns bigint
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  v_id bigint;
begin
  insert into devos_private.event (aggregate_type, aggregate_id, aggregate_revision, event_type, payload, role_class,
                                   origin, declared_session_id)
  values (p_aggregate_type, p_aggregate_id, p_aggregate_revision, p_event_type, coalesce(p_payload, '{}'::jsonb),
          p_role_class, p_origin, p_declared_session_id)
  returning id into v_id;
  return v_id;
end
$fn$;

-- The counted-row writer (EV-C02-013 section 1 item 9; DM-19; B:270): a call without a verified token increases, in
-- place, the one row of its function, reason code and UTC hour, under the unique index rejected_attempt_counted_key.
-- The hour is the UTC hour as a timestamptz, which is what the table's check rejected_attempt_form reads. Nothing of the
-- input is kept. The write is in the caller's transaction.
create function devos_private.reject_counted(p_function_name text, p_reason_code text)
returns void
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
begin
  insert into devos_private.rejected_attempt as ra (function_name, role_class, reason_code, counted_hour, count)
  values (p_function_name, 'none', p_reason_code, date_trunc('hour', now() at time zone 'UTC') at time zone 'UTC', 1)
  on conflict (function_name, reason_code, counted_hour) where counted_hour is not null
  do update set count = ra.count + 1;
end
$fn$;

-- The derivation (EV-C02-003 section 1.6; EV-C02-013 section 1 items 6 (a), 8 and 9, section 2.1). It reads only the
-- lower-case key x-devos-env-token of request.headers, never returns, logs or raises the value, and gives the role class
-- of the one env_tokens row with the token's hash that is not revoked. Otherwise it records the counted refusal and
-- returns null; the reason code and its fixed reason text are left in the transaction-local settings devos.reason_code
-- and devos.reason, which the calling function returns. Reason codes, in this order: header_unreadable, missing, empty
-- (the empty string, or only whitespace), malformed (not a string, or not of the environment token's exact format),
-- unknown, revoked; and could_not_check when env_tokens cannot be read or its row is partial. The revocation test is
-- written as revoked_at is null (B-6TK-1 rewrites it); the answer is a scalar (B-N17-1 assigns it to a text variable).
create function devos_private.caller_role_class(function_name text)
returns devos_private.role_class
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  v_raw text;
  v_headers jsonb;
  v_value jsonb;
  v_token text;
  v_hash text;
  v_class devos_private.role_class;
  v_live boolean;
  v_found boolean := false;
  v_code text;
  v_reason text;
begin
  v_raw := current_setting('request.headers', true);
  if v_raw is null or v_raw = '' then
    v_code := 'header_unreadable';
    v_reason := 'the request headers are not set';
  else
    begin
      v_headers := v_raw::jsonb;
    exception when others then
      v_headers := null;
    end;
    if v_headers is null or jsonb_typeof(v_headers) <> 'object' then
      v_code := 'header_unreadable';
      v_reason := 'the request headers are not a JSON object';
    else
      v_value := v_headers -> 'x-devos-env-token';
      if v_value is null or jsonb_typeof(v_value) = 'null' then
        v_code := 'missing';
        v_reason := 'the request carries no environment token';
      elsif jsonb_typeof(v_value) <> 'string' then
        v_code := 'malformed';
        v_reason := 'the environment token is not of the token format';
      else
        v_token := v_value #>> '{}';
        if v_token ~ '^[[:space:]]*$' then
          v_code := 'empty';
          v_reason := 'the environment token is empty';
        elsif v_token !~ ('^' || 'dv' || 'env1_' || '[A-Za-z0-9_-]{43}$') then
          v_code := 'malformed';
          v_reason := 'the environment token is not of the token format';
        else
          v_hash := devos_private.token_hash(v_token);
          v_token := null;
          begin
            select t.role_class, t.revoked_at is null
              into v_class, v_live
              from devos_private.env_tokens t
             where t.token_hash = v_hash;
            v_found := found;
          exception when others then
            v_code := 'could_not_check';
            v_reason := 'env_tokens: its input could not be read (SQLSTATE ' || sqlstate || ')';
          end;
          v_hash := null;
          if v_code is null then
            if not v_found then
              v_code := 'unknown';
              v_reason := 'the environment token is not known';
            elsif v_class is null or v_live is null then
              v_code := 'could_not_check';
              v_reason := 'env_tokens: its input is partial';
            elsif not v_live then
              v_code := 'revoked';
              v_reason := 'the environment token is revoked';
            end if;
          end if;
        end if;
      end if;
    end if;
  end if;
  if v_code is null then
    return v_class;
  end if;
  perform devos_private.reject_counted(function_name, v_code);
  perform set_config('devos.reason_code', v_code, true);
  perform set_config('devos.reason', v_reason, true);
  return null;
end
$fn$;

-- Owner only: issue one environment token (B:46-47; B 3.27; EV-C02-003 sections 1.3 and 6.3; EV-C02-013 section 2.1).
-- The token is the marker of shared/token_format.md section 1 and 43 URL-safe Base64 characters (no padding) of 32
-- bytes from pgcrypto's gen_random_bytes. It is returned once; only its hash is stored. One event env_token_issued on
-- the new env_token row, payload {role_class}, role class owner, origin owner (DM-31).
create function devos_private.issue_env_token(role_class text)
returns text
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  v_class devos_private.role_class;
  v_token text;
  v_id uuid;
begin
  v_class := role_class::devos_private.role_class;
  v_token := 'dv' || 'env1_'
             || translate(rtrim(encode(extensions.gen_random_bytes(32), 'base64'), '='), '+/', '-_');
  insert into devos_private.env_tokens (role_class, token_hash)
  values (v_class, devos_private.token_hash(v_token))
  returning id into v_id;
  perform devos_private.write_event('env_token', v_id, null, 'env_token_issued',
                                    jsonb_build_object('role_class', v_class::text), 'owner', 'owner', null);
  return v_token;
end
$fn$;

-- Owner only: revoke one environment token by its env_tokens row's id (README 8.1; EV-C02-013 section 2.1). It sets
-- revoked_at and then, last in DM-01's lock order, increments the global authority epoch under its row lock (B
-- principle 9; EV-C02-003 section 1.4), with one event env_token_revoked, payload {role_class, epoch}, owner/owner.
-- Already revoked: an exact repeat, nothing written. An id naming no row: a refusal not_found (no RejectedAttempt row:
-- the table has no role class for the owner). An epoch row that is missing or not updated raises, so that a revocation
-- never stands without its epoch change.
create function devos_private.revoke_env_token(token_id uuid)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  v_class devos_private.role_class;
  v_revoked timestamptz;
  v_epoch bigint;
begin
  select t.role_class, t.revoked_at into v_class, v_revoked
    from devos_private.env_tokens t
   where t.id = token_id
     for update;
  if not found then
    return jsonb_build_object('status', 'refused', 'reason_code', 'not_found',
                              'reason', 'no environment token row has this id');
  end if;
  if v_revoked is not null then
    select g.epoch into v_epoch from devos_private.global_authority_epoch g;
    return jsonb_build_object('status', 'ok', 'id', token_id, 'epoch', v_epoch, 'repeat', true);
  end if;
  update devos_private.env_tokens t set revoked_at = now() where t.id = token_id;
  perform 1 from devos_private.global_authority_epoch g where g.singleton for update;
  if not found then
    raise exception using errcode = 'P0001', message = 'the global authority epoch row is missing; nothing revoked';
  end if;
  update devos_private.global_authority_epoch g set epoch = g.epoch + 1, changed_at = now()
   where g.singleton
  returning g.epoch into v_epoch;
  if v_epoch is null then
    raise exception using errcode = 'P0001', message = 'the global authority epoch was not incremented; nothing revoked';
  end if;
  perform devos_private.write_event('env_token', token_id, null, 'env_token_revoked',
                                    jsonb_build_object('role_class', v_class::text, 'epoch', v_epoch),
                                    'owner', 'owner', null);
  return jsonb_build_object('status', 'ok', 'id', token_id, 'epoch', v_epoch);
end
$fn$;

-- token_role_class() (PC-43 place 8; EV-C02-003 section 1.6; EV-C02-013 section 2.1): the role class the caller's
-- verified token gives, for all six classes; otherwise the token refusal (B:387: token codes only). A read: it changes
-- no table but rejected_attempt, it is VOLATILE because it records refusals (DM-36), and its comment begins devos:read.
create function devos_api.token_role_class()
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  v_class devos_private.role_class;
begin
  v_class := devos_private.caller_role_class('token_role_class');
  if v_class is null then
    return jsonb_build_object('status', 'refused',
                              'reason_code', coalesce(current_setting('devos.reason_code', true), 'could_not_check'),
                              'reason', coalesce(current_setting('devos.reason', true), 'the derivation gave no reason'));
  end if;
  return jsonb_build_object('status', 'ok', 'role_class', v_class::text);
end
$fn$;
comment on function devos_api.token_role_class() is
  'devos:read The role class of the caller''s verified environment token (EV-C02-013 section 2.1)';

-- deployment_drift, replaced (W-C02-03's function; EV-C02-013 section 2.1 with R1-5; EV-C02-003 sections 1.6 and 5.3).
-- (1) Authentication: the migration job's direct login (session_user postgres) is admitted first, as before; every
-- other caller passes the derivation, and a role class other than devos_ci is refused role_class_not_permitted with one
-- per-call RejectedAttempt row (EV-C02-003 section 4.1). That row is written here directly: the per-call writer
-- (devos_private.reject) is M09-02's (the record, section 1.2). (2) VOLATILE, not STABLE (DM-36 (a)): a read records its
-- refusals, and a STABLE function cannot write. (3) The single snapshot: a VOLATILE function takes a new snapshot for
-- each statement under READ COMMITTED, so the history and the function record are read in ONE statement, whose two
-- scalar subqueries aggregate them into variables; the checks and the comparison then read only those variables. Its
-- answers to the migration login and its could_not_check reasons are as before; the read stays inside the exception
-- block, so an absent, renamed or partly unreadable record still gives could_not_check.
create or replace function devos_api.deployment_drift(expected jsonb)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  v_class devos_private.role_class;
  v_commit text;
  m jsonb;
  f jsonb;
  hist jsonb;
  fun jsonb;
  exp_mig jsonb := '{}';
  exp_fun jsonb := '{}';
  app_mig jsonb := '{}';
  rec_fun jsonb := '{}';
  diffs jsonb := '[]';
  k text;
begin
  -- Authentication (PC-41 place 8, B:45; EV-C02-001 M13; EV-C02-004 Y-02). The migration job calls this function over
  -- its direct database login, whose session user is postgres; that caller is admitted here, before the token check.
  if session_user is distinct from 'postgres' then
    v_class := devos_private.caller_role_class('deployment_drift');
    if v_class is null then
      return jsonb_build_object('status', 'refused',
                                'reason_code', coalesce(current_setting('devos.reason_code', true), 'could_not_check'),
                                'reason', coalesce(current_setting('devos.reason', true), 'the derivation gave no reason'));
    end if;
    if not (v_class = any (array['devos_ci']::devos_private.role_class[])) then
      insert into devos_private.rejected_attempt (function_name, role_class, reason_code, reason)
      values ('deployment_drift', v_class::text, 'role_class_not_permitted',
              'deployment_drift admits only the role class devos_ci');
      return jsonb_build_object('status', 'refused', 'reason_code', 'role_class_not_permitted',
                                'reason', 'deployment_drift admits only the role class devos_ci');
    end if;
  end if;

  begin
    -- `expected`: missing or malformed input gives "could not check" (plan Section 8 item 14).
    if expected is null or jsonb_typeof(expected) is distinct from 'object' then
      return jsonb_build_object('status', 'could_not_check', 'complete', false, 'differences', '[]'::jsonb,
                                'reason', 'expected is missing or not an object');
    end if;
    v_commit := expected->>'commit';
    if jsonb_typeof(expected->'commit') is distinct from 'string' or v_commit !~ '^[0-9a-f]{40}([0-9a-f]{24})?$' then
      return jsonb_build_object('status', 'could_not_check', 'complete', false, 'differences', '[]'::jsonb,
                                'reason', 'expected has no valid commit');
    end if;
    if jsonb_typeof(expected->'migrations') is distinct from 'array'
       or jsonb_typeof(expected->'functions') is distinct from 'array' then
      return jsonb_build_object('status', 'could_not_check', 'complete', false, 'differences', '[]'::jsonb,
                                'reason', 'expected lacks its migrations or functions list');
    end if;
    for m in select value from jsonb_array_elements(expected->'migrations') loop
      if jsonb_typeof(m) is distinct from 'object' or jsonb_typeof(m->'version') is distinct from 'string'
         or (m->>'version') !~ '^[0-9]+$' or jsonb_typeof(m->'name') is distinct from 'string'
         or exp_mig ? (m->>'version') then
        return jsonb_build_object('status', 'could_not_check', 'complete', false, 'differences', '[]'::jsonb,
                                  'reason', 'expected holds a malformed or repeated migration');
      end if;
      exp_mig := exp_mig || jsonb_build_object(m->>'version', m->>'name');
    end loop;
    for f in select value from jsonb_array_elements(expected->'functions') loop
      if jsonb_typeof(f) is distinct from 'object' or jsonb_typeof(f->'slug') is distinct from 'string'
         or (f->>'slug') = '' or jsonb_typeof(f->'sha256') is distinct from 'string'
         or (f->>'sha256') !~ '^[0-9a-f]{64}$' or exp_fun ? (f->>'slug') then
        return jsonb_build_object('status', 'could_not_check', 'complete', false, 'differences', '[]'::jsonb,
                                  'reason', 'expected holds a malformed or repeated function');
      end if;
      exp_fun := exp_fun || jsonb_build_object(f->>'slug', f->>'sha256');
    end loop;

    -- The record of applied migrations and the record of deployed function versions, read in one statement, so in one
    -- snapshot. Absent, renamed or with a column missing: an error, caught below.
    select
      (select jsonb_build_object(
                'rows', coalesce(jsonb_object_agg(h.version::text, coalesce(h.name, ''))
                                   filter (where h.version is not null), '{}'::jsonb),
                'null_version', coalesce(bool_or(h.version is null), false))
         from supabase_migrations.schema_migrations h),
      (select jsonb_build_object(
                'rows', coalesce(jsonb_object_agg(d.slug, d.source_sha256)
                                   filter (where d.slug is not null and d.source_sha256 is not null), '{}'::jsonb),
                'incomplete', coalesce(bool_or(d.slug is null or d.source_sha256 is null), false))
         from devos_private.function_deployment d)
      into hist, fun;
    if (hist->>'null_version')::boolean then
      return jsonb_build_object('status', 'could_not_check', 'complete', false, 'differences', '[]'::jsonb,
                                'reason', 'the history holds a row without a version');
    end if;
    if (fun->>'incomplete')::boolean then
      return jsonb_build_object('status', 'could_not_check', 'complete', false, 'differences', '[]'::jsonb,
                                'reason', 'the function record holds an incomplete row');
    end if;
    app_mig := hist->'rows';
    rec_fun := fun->'rows';
  exception when others then
    return jsonb_build_object('status', 'could_not_check', 'complete', false, 'differences', '[]'::jsonb,
                              'reason', 'a record could not be read: ' || sqlstate);
  end;

  -- The comparison, every part of it.
  for k in select key from jsonb_each_text(exp_mig) order by key loop
    if not app_mig ? k then
      diffs := diffs || jsonb_build_array(jsonb_build_object('kind', 'on_main_not_applied', 'version', k,
                                                             'name', exp_mig->>k));
    elsif (app_mig->>k) is distinct from (exp_mig->>k) then
      diffs := diffs || jsonb_build_array(jsonb_build_object('kind', 'name_differs', 'version', k,
                                                             'name', exp_mig->>k, 'applied_name', app_mig->>k));
    end if;
  end loop;
  for k in select key from jsonb_each_text(app_mig) order by key loop
    if not exp_mig ? k then
      diffs := diffs || jsonb_build_array(jsonb_build_object('kind', 'applied_not_on_main', 'version', k,
                                                             'name', app_mig->>k));
    end if;
  end loop;
  for k in select key from jsonb_each_text(exp_fun) order by key loop
    if not rec_fun ? k then
      diffs := diffs || jsonb_build_array(jsonb_build_object('kind', 'function_missing', 'slug', k));
    elsif (rec_fun->>k) is distinct from (exp_fun->>k) then
      diffs := diffs || jsonb_build_array(jsonb_build_object('kind', 'function_differs', 'slug', k));
    end if;
  end loop;
  for k in select key from jsonb_each_text(rec_fun) order by key loop
    if not exp_fun ? k then
      diffs := diffs || jsonb_build_array(jsonb_build_object('kind', 'function_extra', 'slug', k));
    end if;
  end loop;

  return jsonb_build_object(
    'status', case when jsonb_array_length(diffs) = 0 then 'no_difference' else 'differences' end,
    'complete', true,
    'commit', v_commit,
    'differences', diffs,
    'compared', jsonb_build_object(
      'migrations_expected', (select count(*) from jsonb_object_keys(exp_mig)),
      'migrations_applied', (select count(*) from jsonb_object_keys(app_mig)),
      'functions_expected', (select count(*) from jsonb_object_keys(exp_fun)),
      'functions_recorded', (select count(*) from jsonb_object_keys(rec_fun))));
end
$fn$;
comment on function devos_api.deployment_drift(jsonb) is
  'devos:read The difference between main''s expected set and the applied and deployed records (W-C02-03; EV-C02-013 section 2.1)';

-- Grants (EV-C02-013 section 1 item 13; T-W08-PRIV's constraint, N-278 (7); Appendix B section 2; EV-C02-003 section
-- 4.1). PUBLIC's default EXECUTE is revoked from every function this file creates or replaces, and so is any privilege
-- of the four API roles. The devos_private functions are owner-only: nothing is granted, so issuing and revoking tokens
-- stays with the project owner (B:46). The two devos_api functions are granted to anon, the role a Data API request
-- with the publishable key runs as; each checks the token itself. This file adds no type.
revoke all on function devos_private.token_hash(text) from public;
revoke all on function devos_private.write_event(text, uuid, integer, text, jsonb, text, devos_private.event_origin, text)
  from public;
revoke all on function devos_private.reject_counted(text, text) from public;
revoke all on function devos_private.caller_role_class(text) from public;
revoke all on function devos_private.issue_env_token(text) from public;
revoke all on function devos_private.revoke_env_token(uuid) from public;
revoke all on function devos_api.token_role_class() from public;
revoke all on function devos_api.deployment_drift(jsonb) from public;
do $$
declare r text;
begin
  foreach r in array array['anon', 'authenticated', 'authenticator', 'service_role'] loop
    if exists (select 1 from pg_catalog.pg_roles where rolname = r) then
      execute format('revoke all on function devos_private.token_hash(text) from %I', r);
      execute format('revoke all on function devos_private.write_event(text, uuid, integer, text, jsonb, text, '
                     'devos_private.event_origin, text) from %I', r);
      execute format('revoke all on function devos_private.reject_counted(text, text) from %I', r);
      execute format('revoke all on function devos_private.caller_role_class(text) from %I', r);
      execute format('revoke all on function devos_private.issue_env_token(text) from %I', r);
      execute format('revoke all on function devos_private.revoke_env_token(uuid) from %I', r);
      execute format('revoke all on function devos_api.token_role_class() from %I', r);
      execute format('revoke all on function devos_api.deployment_drift(jsonb) from %I', r);
    end if;
  end loop;
  if exists (select 1 from pg_catalog.pg_roles where rolname = 'anon') then
    grant execute on function devos_api.token_role_class() to anon;
    grant execute on function devos_api.deployment_drift(jsonb) to anon;
  end if;
end
$$;
