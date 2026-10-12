-- Synthetic test data (plan Section 8 item 13): every token below is issued at run time by issue_env_token inside this
-- transaction, held only in PL/pgSQL variables, never printed, stored or compared by hash, and discarded by the closing
-- rollback. Text inputs and planted rows read 'w07_fixture SYNTHETIC W-C02-07'. No personal or business data.
--
-- T-W07-6TK: W-C02-07 point 6 for the derivation's input (EV-C02-003 §15, the row 'a call whose token is missing,
-- empty, malformed, unknown or revoked, or whose header cannot be read'): one case per reason code, each refused before
-- any other check, counted under role class none, and kept apart from a wrong-role-class refusal and from acceptance;
-- and the derivation's own stored input (env_tokens) missing, unreadable or partial, which must never let a call through.
-- Specification: tests/C02/W-C02-07/T-W07-6TK_token_reasons.md. The Data API half: supabase/migrations/tests/w07_6tk_http_reasons.py.
--
-- Runs: in devos-test by the migration job's test step as postgres (README 5.1 (a)), and on the break harness's
-- throwaway database (README 5.2). transport sql-set-role: the header is simulated with set_config('request.headers',
-- ..., true) and the caller acts as the Data API's role (set local role anon); session_user stays postgres, so
-- deployment_drift's branch for the migration login cannot be exercised here. Interface assumed: pg_temp.w07_cfg and
-- the specification's 'Interface assumed' (README section 8). Safety: begin ... rollback; each case runs in a
-- subtransaction that is undone. No psql meta-command. Output: one row per case, then PASS, FAIL or COULD NOT CHECK.
begin;
set local search_path = pg_catalog, pg_temp;
set local statement_timeout = '120s';

create temp table w07_results (case_id text primary key, outcome text not null, detail text not null);

-- ===== Group D helpers (the same block in w07_idc, w07_6tk, w07_5b, w07_n04 and w07_n08) =====
-- INTERFACE ASSUMED (README section 8). Revise these values before the first result if the build names them otherwise.
create function pg_temp.w07_cfg(p_key text) returns text language sql immutable as $f$
  select t.v from (values
    ('api_role', 'anon'),                                  -- the role a Data API request with the publishable key runs as
    ('env_tokens', 'devos_private.env_tokens'),            -- B 3.27 (name fixed by the design)
    ('epoch_table', 'devos_private.global_authority_epoch'), -- one row (EV-C02-002 DM-01); README section 8
    ('epoch_column', 'epoch'),                             -- assumed
    ('events', 'devos_private.event'),                    -- Event, B 3.13; README section 8 (B:16); columns id, role_class, origin
    ('rejected', 'devos_private.rejected_attempt'),       -- RejectedAttempt, DM-19's fields; README section 8
    ('role_codes', 'role_class_not_permitted'),            -- reason code(s) of a wrong-role-class refusal; assumed
    ('review_table', 'devos_private.review'),             -- B 3.11; assumed
    ('verdict_table', 'devos_private.verdict'),           -- B 3.11; assumed
    ('work_table', 'devos_private.work'),                 -- B 3.3; assumed
    ('evalrun_table', 'devos_private.eval_run')           -- B 3.15; assumed
  ) t(k, v) where t.k = p_key
$f$;

create function pg_temp.w07_token_codes() returns text[] language sql immutable as $f$
  select array['missing', 'empty', 'malformed', 'unknown', 'revoked', 'header_unreadable']
$f$;

create function pg_temp.w07_classes() returns text[] language sql immutable as $f$
  select array['devos_calisma', 'devos_denetim', 'devos_sinav', 'devos_kurulum', 'devos_ci', 'devos_backup']
$f$;

create function pg_temp.w07_put(p_id text, p_ok boolean, p_detail text) returns void language sql as $f$
  insert into w07_results values (p_id, case when p_ok then 'ok' else 'bad' end, p_detail)
$f$;

create function pg_temp.w07_cnc(p_id text, p_detail text) returns void language sql as $f$
  insert into w07_results values (p_id, 'could_not_check', p_detail)
$f$;

-- RejectedAttempt as a map 'function|reason_code|role_class' -> total (a counted row's count, or 1 per per-call row).
create function pg_temp.w07_ra() returns jsonb language plpgsql as $f$
declare r jsonb;
begin
  execute format('select coalesce(jsonb_object_agg(k, n), ''{}'') from (select concat_ws(''|'', function_name::text, '
                 || 'reason_code::text, role_class::text) k, sum(coalesce("count", 1)) n from %s group by 1) s',
                 pg_temp.w07_cfg('rejected')) into r;
  return r;
end $f$;

create function pg_temp.w07_delta(a jsonb, b jsonb) returns jsonb language sql as $f$
  select coalesce(jsonb_object_agg(k, (b->>k)::numeric - coalesce((a->>k)::numeric, 0)), '{}')
  from jsonb_object_keys(b) k where (b->>k)::numeric <> coalesce((a->>k)::numeric, 0)
$f$;

create function pg_temp.w07_ev_ids() returns text[] language plpgsql as $f$
declare r text[];
begin
  execute format('select coalesce(array_agg(id::text), ''{}'') from %s', pg_temp.w07_cfg('events')) into r;
  return r;
end $f$;

create function pg_temp.w07_ev_new(p_before text[]) returns jsonb language plpgsql as $f$
declare r jsonb;
begin
  execute format('select coalesce(jsonb_agg(jsonb_build_object(''role_class'', role_class::text, ''origin'', '
                 || 'origin::text)), ''[]'') from %s where not (id::text = any($1))', pg_temp.w07_cfg('events'))
    using p_before into r;
  return r;
end $f$;

-- Row counts of every devos_private table except RejectedAttempt and Event (those are judged apart): "nothing changed".
create function pg_temp.w07_counts() returns jsonb language plpgsql as $f$
declare c record; n bigint; r jsonb := '{}';
begin
  for c in select format('%I.%I', s.nspname, k.relname) q from pg_class k join pg_namespace s on s.oid = k.relnamespace
           where s.nspname = 'devos_private' and k.relkind in ('r', 'p') order by 1 loop
    if c.q::regclass in (pg_temp.w07_cfg('rejected')::regclass, pg_temp.w07_cfg('events')::regclass) then
      continue;
    end if;
    execute format('select count(*) from %s', c.q) into n;
    r := r || jsonb_build_object(c.q, n);
  end loop;
  return r;
end $f$;

-- The header object a request would carry; p_tok null means no token key at all.
create function pg_temp.w07_h(p_tok text, p_extra jsonb default '{}') returns text language sql as $f$
  select (case when p_tok is null then '{}'::jsonb else jsonb_build_object('x-devos-env-token', p_tok) end
          || p_extra)::text
$f$;

-- One case: act as p_role with the header p_headers (null: leave request.headers as it is), run p_sql, observe, undo.
-- p_scrub: every token value in play; any of them found in the result or the error is replaced and flagged ('echo').
-- p_plant: DDL run as owner inside the undone block before the call (an unreadable or partial state); its failure is
-- returned as plant_error, and the case is then "could not check".
create function pg_temp.w07_call(p_role text, p_headers text, p_sql text, p_scrub text[],
                                 p_gucs jsonb default '{}', p_plant text default null) returns jsonb language plpgsql as $f$
declare res jsonb; err text; st text; ra0 jsonb; ra1 jsonb; ev0 text[]; evn jsonb; c0 jsonb; c1 jsonb;
        cu text; su text; k text; rs text; echo boolean := false; s text; pe text;
begin
  begin
    ra0 := pg_temp.w07_ra(); ev0 := pg_temp.w07_ev_ids();
    if p_plant is not null then
      begin
        execute p_plant;
      exception when others then
        pe := sqlstate || ' ' || left(sqlerrm, 120);
        raise exception using errcode = 'P0W07', message = 'w07: plant failed';
      end;
    end if;
    c0 := pg_temp.w07_counts();
    begin
      for k in select jsonb_object_keys(p_gucs) loop
        perform set_config(k, p_gucs->>k, true);
      end loop;
      if p_headers is not null then
        perform set_config('request.headers', p_headers, true);
      end if;
      execute format('set local role %I', p_role);
      cu := current_user; su := session_user;
      execute p_sql into res;
    exception when others then
      get stacked diagnostics err = message_text, st = returned_sqlstate;
    end;
    execute 'reset role';
    ra1 := pg_temp.w07_ra(); evn := pg_temp.w07_ev_new(ev0); c1 := pg_temp.w07_counts();
    raise exception using errcode = 'P0W07', message = 'w07: undo the case';
  exception when sqlstate 'P0W07' then null;
  end;
  if pe is not null then return jsonb_build_object('plant_error', pe); end if;
  rs := res::text;
  foreach s in array coalesce(p_scrub, '{}') loop
    if s is not null and length(s) > 0 then
      if strpos(coalesce(rs, ''), s) > 0 or strpos(coalesce(err, ''), s) > 0 then echo := true; end if;
      rs := replace(rs, s, '[w07: presented value]'); err := replace(err, s, '[w07: presented value]');
    end if;
  end loop;
  return jsonb_build_object('res', rs::jsonb, 'err', left(err, 200), 'state', st, 'ra', pg_temp.w07_delta(ra0, ra1),
    'events', evn, 'echo', echo, 'current_user', cu, 'session_user', su,
    'changed', (select coalesce(jsonb_agg(e.key), '[]') from jsonb_each(c1) e where e.value is distinct from c0->e.key));
end $f$;

-- The refusal a function returned: a JSON object with status 'refused' or refused true, carrying reason_code.
create function pg_temp.w07_code(r jsonb) returns text language sql as $f$
  select case when jsonb_typeof(r->'res') = 'object'
               and r->'res'->>'status' = 'refused'  -- interface v1 (README section 8)
              then coalesce(r->'res'->>'reason_code', 'refused_without_code') end
$f$;

-- The role class an accepted token_role_class() call returned (a JSON string, or an object's role_class).
create function pg_temp.w07_class_of(r jsonb) returns text language sql as $f$
  select case when r->>'err' is not null or pg_temp.w07_code(r) is not null then null
              when jsonb_typeof(r->'res') = 'string' then r->'res'->>0
              when jsonb_typeof(r->'res') = 'object' then r->'res'->>'role_class' end
$f$;

-- A short, value-free account of one observation, with current_user and session_user (README 5.1 (a)).
create function pg_temp.w07_says(r jsonb) returns text language sql as $f$
  select format('code %s; err %s %s; ra %s; events %s; changed %s; echo %s; as %s (session_user %s)',
                coalesce(pg_temp.w07_code(r), '-'), coalesce(r->>'state', '-'), coalesce(r->>'err', ''),
                r->'ra', r->'events', r->'changed', r->>'echo', r->>'current_user', r->>'session_user')
$f$;

-- A token refusal (6TK's rule): refused with p_code before any other check, counted once under role class none.
create function pg_temp.w07_is_token_refusal(r jsonb, p_fn text, p_code text) returns boolean language sql as $f$
  select r->>'err' is null and pg_temp.w07_code(r) = p_code
     and (r->'ra'->>(p_fn || '|' || p_code || '|none'))::numeric = 1
     and (select count(*) from jsonb_object_keys(r->'ra')) = 1
     and r->'events' = '[]'::jsonb and r->'changed' = '[]'::jsonb and not (r->'echo')::boolean
$f$;

-- A role refusal (B:47): refused with a role code, recorded once per call with the caller's role class, nothing else.
create function pg_temp.w07_is_role_refusal(r jsonb, p_fn text, p_class text) returns boolean language sql as $f$
  select r->>'err' is null
     and pg_temp.w07_code(r) = any(string_to_array(pg_temp.w07_cfg('role_codes'), ','))
     and (r->'ra'->>(p_fn || '|' || pg_temp.w07_code(r) || '|' || p_class))::numeric = 1
     and (select count(*) from jsonb_object_keys(r->'ra')) = 1
     and r->'events' = '[]'::jsonb and r->'changed' = '[]'::jsonb and not (r->'echo')::boolean
$f$;

-- Passed the role gate (a ✔ cell at the gate): no token or role refusal recorded for p_fn, and not denied EXECUTE.
create function pg_temp.w07_passed_gate(r jsonb, p_fn text) returns boolean language sql as $f$
  select coalesce(r->>'state', '') <> '42501' and not (r->'echo')::boolean
     and coalesce(pg_temp.w07_code(r), '') <> all(pg_temp.w07_token_codes()
                                                 || string_to_array(pg_temp.w07_cfg('role_codes'), ','))
     and not exists (select 1 from jsonb_object_keys(r->'ra') k
                     where split_part(k, '|', 1) = p_fn
                       and split_part(k, '|', 2) = any(pg_temp.w07_token_codes()
                                                      || string_to_array(pg_temp.w07_cfg('role_codes'), ',')))
$f$;

-- Accepted (a full positive): no error, no refusal, no RejectedAttempt, and an event under p_class if p_event.
create function pg_temp.w07_is_accepted(r jsonb, p_class text, p_event boolean) returns boolean language sql as $f$
  select r->>'err' is null and pg_temp.w07_code(r) is null and r->'ra' = '{}'::jsonb and not (r->'echo')::boolean
     and (not p_event or exists (select 1 from jsonb_array_elements(r->'events') e where e->>'role_class' = p_class))
$f$;

-- A neutral call of one devos_api function: its required IN arguments by type, named where the function names them.
-- p_subst maps a regular expression on an argument's name to an SQL expression used instead of the neutral value.
create function pg_temp.w07_sql_for(p_oid oid, p_subst jsonb default '{}') returns text language plpgsql as $f$
declare pr record; innames text[] := '{}'; i int; nreq int; v text; nm text; t record; parts text[] := '{}';
        named boolean := true; k text;
begin
  select p.*, s.nspname into pr from pg_proc p join pg_namespace s on s.oid = p.pronamespace where p.oid = p_oid;
  if pr.proargmodes is null then
    innames := coalesce(pr.proargnames, '{}');
  else
    for i in 1 .. array_length(pr.proargmodes, 1) loop
      if pr.proargmodes[i] in ('i', 'b') then innames := innames || coalesce(pr.proargnames[i], ''); end if;
    end loop;
  end if;
  nreq := pr.pronargs - pr.pronargdefaults;
  for i in 1 .. nreq loop
    if coalesce(innames[i], '') = '' then named := false; end if;
  end loop;
  for i in 1 .. nreq loop
    nm := coalesce(innames[i], '');
    select * into t from pg_type where oid = pr.proargtypes[i - 1];
    v := null;
    for k in select jsonb_object_keys(p_subst) loop
      if nm <> '' and nm ~* k then v := p_subst->>k; end if;
    end loop;
    if v is null then
      v := case
        when t.typname = 'uuid' then 'gen_random_uuid()'
        when t.typname in ('json', 'jsonb') then quote_literal('{"w07_fixture": "SYNTHETIC W-C02-07"}') || '::' || t.typname
        when t.typtype = 'e' then quote_literal((select enumlabel from pg_enum where enumtypid = t.oid
                                                 order by enumsortorder limit 1)) || '::' || format_type(t.oid, null)
        when t.typcategory = 'A' then quote_literal('{}') || '::' || format_type(t.oid, null)
        when t.typcategory = 'S' then quote_literal('w07_fixture SYNTHETIC W-C02-07')
        when t.typcategory = 'N' then '0::' || format_type(t.oid, null)
        when t.typcategory = 'B' then 'false'
        when t.typcategory = 'D' then 'now()::' || format_type(t.oid, null)
        else 'null::' || format_type(t.oid, null) end;
    end if;
    parts := parts || case when named then format('%I => %s', nm, v) else v end;
  end loop;
  return format('select to_jsonb(w07x) from %I.%I(%s) as w07x limit 1', pr.nspname, pr.proname,
                array_to_string(parts, ', '));
end $f$;

create function pg_temp.w07_fn(p_name text) returns oid language sql stable as $f$
  select p.oid from pg_proc p join pg_namespace s on s.oid = p.pronamespace
  where s.nspname = 'devos_api' and p.proname = p_name order by p.pronargs, p.oid limit 1
$f$;

-- Issue one synthetic token as owner; returns {tok, id} or {why}. The id is the one row the call added.
create function pg_temp.w07_issue(p_class text) returns jsonb language plpgsql as $f$
declare before text[]; tok text; ids text[];
begin
  execute format('select coalesce(array_agg(id::text), ''{}'') from %s', pg_temp.w07_cfg('env_tokens')) into before;
  execute format('select devos_private.issue_env_token(%L)', p_class) into tok;
  execute format('select coalesce(array_agg(id::text), ''{}'') from %s where not (id::text = any($1))',
                 pg_temp.w07_cfg('env_tokens')) using before into ids;
  if tok is null or array_length(ids, 1) is distinct from 1 then
    return jsonb_build_object('why', format('issue_env_token(%s) returned %s and added %s rows', p_class,
                              case when tok is null then 'no token' else 'a token' end, coalesce(array_length(ids, 1), 0)));
  end if;
  return jsonb_build_object('tok', tok, 'id', ids[1]);
exception when others then
  return jsonb_build_object('why', format('issue_env_token(%s) failed: %s', p_class, sqlstate));
end $f$;
-- ===== end of the helper block =====

create function pg_temp.w07_pre_common() returns text language plpgsql as $f$
declare k text;
begin
  foreach k in array array['env_tokens', 'events', 'rejected'] loop
    if to_regclass(pg_temp.w07_cfg(k)) is null then return pg_temp.w07_cfg(k) || ' does not exist'; end if;
  end loop;
  if pg_temp.w07_fn('token_role_class') is null then return 'devos_api.token_role_class() does not exist'; end if;
  if not exists (select 1 from pg_proc p join pg_namespace s on s.oid = p.pronamespace
                 where s.nspname = 'devos_private' and p.proname = 'issue_env_token') then
    return 'devos_private.issue_env_token does not exist';
  end if;
  if to_regrole(pg_temp.w07_cfg('api_role')) is null then return pg_temp.w07_cfg('api_role') || ' role does not exist'; end if;
  begin
    perform pg_temp.w07_ra(); perform pg_temp.w07_ev_ids(); perform pg_temp.w07_counts();
  exception when others then
    return 'RejectedAttempt or Event lacks an assumed column (' || sqlstate || ' ' || left(sqlerrm, 120) || ')';
  end;
  return null;
end $f$;

do $$
declare why text; api text := pg_temp.w07_cfg('api_role'); i jsonb; den text; cal text; rvk text; scrub text[];
        tr text := 'token_role_class'; trsql text; fb text; fbsql text; r jsonb; pre text; rnd text; cs record;
        sc text[]; n_clean int := 0; n_fail int := 0; n_cnc int := 0; code text;
begin
  why := pg_temp.w07_pre_common();
  if why is not null then perform pg_temp.w07_cnc('6TK-pre', why); return; end if;
  trsql := pg_temp.w07_sql_for(pg_temp.w07_fn(tr));
  -- 6TK-hu0 runs first: request.headers has never been set in this transaction (as through Realtime or Storage).
  r := pg_temp.w07_call(api, null, trsql, '{}');
  perform pg_temp.w07_put('6TK-hu0-a', pg_temp.w07_is_token_refusal(r, tr, 'header_unreadable'),
    'request.headers never set; header_unreadable expected; ' || pg_temp.w07_says(r));
  n_cnc := n_cnc + 1;
  i := pg_temp.w07_issue('devos_denetim');
  if i ? 'why' then perform pg_temp.w07_cnc('6TK-tokens', i->>'why'); return; end if;
  den := i->>'tok';
  i := pg_temp.w07_issue('devos_calisma');
  if i ? 'why' then perform pg_temp.w07_cnc('6TK-tokens', i->>'why'); return; end if;
  cal := i->>'tok';
  i := pg_temp.w07_issue('devos_kurulum');
  if i ? 'why' then perform pg_temp.w07_cnc('6TK-tokens', i->>'why'); return; end if;
  rvk := i->>'tok';
  begin
    execute format('select devos_private.revoke_env_token(%L)', i->>'id');
  exception when others then
    rvk := null;
  end;
  scrub := array[den, cal] || coalesce(rvk, '');
  pre := left(den, length(den) - 43); rnd := right(den, 43);
  -- A second function whose role list refuses devos_calisma, called with neutral arguments (README 5.1 (a)).
  select p into fb from unnest(array['revoke_claim', 'record_verdict', 'accept', 'open_review', 'set_effort_policy',
                                     'record_eval_run', 'mark_exported', 'open_mission']) p
  where pg_temp.w07_fn(p) is not null limit 1;
  if fb is not null then fbsql := pg_temp.w07_sql_for(pg_temp.w07_fn(fb)); end if;
  for cs in select * from (values
      ('hu1', '', 'header_unreadable', true),
      ('hu2', 'w07_fixture SYNTHETIC W-C02-07 not json', 'header_unreadable', false),
      ('hu3', '[]', 'header_unreadable', false),
      ('hu4', '"w07_fixture SYNTHETIC W-C02-07"', 'header_unreadable', false),
      ('mi1', '{}', 'missing', true),
      ('mi2', '{"x-devos-env-token": null}', 'missing', false),
      ('mi3', pg_temp.w07_h(null, jsonb_build_object('x-devos-token', den)), 'missing', false),
      ('mi4', pg_temp.w07_h(null, jsonb_build_object('X-Devos-Env-Token', den)), 'missing', false),
      ('em1', pg_temp.w07_h(''), 'empty', true),
      ('ma1', pg_temp.w07_h(left(den, length(den) - 1)), 'malformed', true),
      ('ma2', pg_temp.w07_h(den || 'A'), 'malformed', false),
      ('ma3', pg_temp.w07_h(case when left(den, 1) = 'x' then 'y' else 'x' end || substr(den, 2)), 'malformed', false),
      ('ma4', pg_temp.w07_h(den || '='), 'malformed', false),
      ('ma5', pg_temp.w07_h(' ' || den), 'malformed', false),
      ('ma6', pg_temp.w07_h(upper(pre) || rnd), 'malformed', false),
      ('ma7', pg_temp.w07_h(pre || left(rnd, 20) || ' ' || right(rnd, 23)), 'malformed', false),
      ('un1', pg_temp.w07_h(pre || overlay(rnd placing case when substr(rnd, 11, 1) = 'A' then 'B' else 'A' end
                                            from 11 for 1)), 'unknown', true),
      ('un2', pg_temp.w07_h(pre || left(rnd, 42) || case when right(rnd, 1) = 'A' then 'E' else 'A' end), 'unknown', false),
      ('rv1', pg_temp.w07_h(rvk), 'revoked', true)
    ) t(id, hdr, code, on_b) loop
    if cs.id = 'rv1' and rvk is null then
      perform pg_temp.w07_cnc('6TK-rv1-a', 'revoke_env_token(<token id>) could not be called (README section 8)');
      continue;
    end if;
    sc := scrub;
    begin
      sc := sc || array(select e.value from jsonb_each_text(cs.hdr::jsonb) e where length(e.value) > 8);
    exception when others then null;
    end;
    r := pg_temp.w07_call(api, cs.hdr, trsql, sc);
    perform pg_temp.w07_put('6TK-' || cs.id || '-a', pg_temp.w07_is_token_refusal(r, tr, cs.code),
      cs.code || ' expected; ' || pg_temp.w07_says(r));
    code := pg_temp.w07_code(r);
    if code in ('missing', 'empty', 'malformed', 'header_unreadable') then n_cnc := n_cnc + 1;
    elsif code in ('unknown', 'revoked') then n_fail := n_fail + 1;
    elsif pg_temp.w07_class_of(r) is not null then n_clean := n_clean + 1; end if;
    if cs.on_b then
      if fb is null then
        perform pg_temp.w07_cnc('6TK-' || cs.id || '-b', 'no devos_api function that refuses devos_calisma exists yet');
      else
        r := pg_temp.w07_call(api, cs.hdr, fbsql, sc);
        perform pg_temp.w07_put('6TK-' || cs.id || '-b', pg_temp.w07_is_token_refusal(r, fb, cs.code),
          format('%s on %s with neutral arguments, refused for the token before its role list and arguments; %s',
                 cs.code, fb, pg_temp.w07_says(r)));
      end if;
    end if;
  end loop;
  -- Kept apart: a wrong role class is refused with another code, per call, under the caller's class; a right token is accepted.
  if fb is null then
    perform pg_temp.w07_cnc('6TK-ka1', 'no devos_api function that refuses devos_calisma exists yet');
  else
    r := pg_temp.w07_call(api, pg_temp.w07_h(cal), fbsql, scrub);
    perform pg_temp.w07_put('6TK-ka1', pg_temp.w07_is_role_refusal(r, fb, 'devos_calisma'),
      format('a verified working token on %s: a role refusal under devos_calisma, not a token code; %s', fb, pg_temp.w07_says(r)));
    n_fail := n_fail + 1;
  end if;
  r := pg_temp.w07_call(api, pg_temp.w07_h(den), trsql, scrub);
  perform pg_temp.w07_put('6TK-ka2', pg_temp.w07_class_of(r) = 'devos_denetim' and r->'ra' = '{}'::jsonb,
    'a verified audit token is accepted: ' || coalesce(pg_temp.w07_class_of(r), 'no role class') || '; ' || pg_temp.w07_says(r));
  if pg_temp.w07_class_of(r) is not null then n_clean := n_clean + 1; end if;
  -- The derivation's own stored input missing, unreadable or partial: the call is never let through.
  for cs in select * from (values
      ('h1', format('alter table %s rename to w07_hidden_env_tokens', pg_temp.w07_cfg('env_tokens')), 'env_tokens absent'),
      ('h2', format('alter table %s rename column token_hash to token_hash_w07_hidden', pg_temp.w07_cfg('env_tokens')), 'token_hash unreadable'),
      ('h3', format('alter table %s rename column revoked_at to revoked_at_w07_hidden', pg_temp.w07_cfg('env_tokens')), 'revoked_at unreadable (partial)'),
      ('h4', format('alter table %s rename column role_class to role_class_w07_hidden', pg_temp.w07_cfg('env_tokens')), 'role_class unreadable (partial)')
    ) t(id, ddl, what) loop
    r := pg_temp.w07_call(api, pg_temp.w07_h(den), trsql, scrub, '{}', cs.ddl);
    if r ? 'plant_error' then
      perform pg_temp.w07_cnc('6TK-' || cs.id, cs.what || ' could not be planted: ' || (r->>'plant_error'));
    else
      perform pg_temp.w07_put('6TK-' || cs.id, pg_temp.w07_class_of(r) is null and r->'events' = '[]'::jsonb
                                               and r->'changed' = '[]'::jsonb,
        cs.what || ': a verified token must not be let through; ' || pg_temp.w07_says(r));
      n_cnc := n_cnc + 1;
    end if;
  end loop;
  raise notice 'T-W07-6TK answers of the derivation seen: clean % , fail % , could not check % , of %',
    n_clean, n_fail, n_cnc, n_clean + n_fail + n_cnc;
  den := null; cal := null; rvk := null; scrub := null;
end $$;

select case_id, outcome, detail from w07_results order by case_id;

do $$
declare nb int; nc int; n int;
begin
  select count(*) filter (where outcome = 'bad'), count(*) filter (where outcome = 'could_not_check'), count(*)
    into nb, nc, n from w07_results;
  if nb > 0 then
    raise exception 'W07_6TK_TOKEN_REASONS FAIL (% bad, % could not check, of %)', nb, nc, n;
  elsif nc > 0 or n = 0 then
    raise exception 'W07_6TK_TOKEN_REASONS COULD NOT CHECK (% of % could not be checked)', nc, n;
  end if;
  raise notice 'W07_6TK_TOKEN_REASONS PASS (%/%)', n, n;
end $$;

rollback;
