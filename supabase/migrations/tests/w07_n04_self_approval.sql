-- Synthetic test data (plan Section 8 item 13): every token below is issued at run time by issue_env_token inside this
-- transaction, held only in PL/pgSQL variables, never printed, stored or compared by hash, and discarded by the closing
-- rollback. Text inputs and planted rows read 'w07_fixture SYNTHETIC W-C02-07'. No personal or business data.
--
-- T-W07-N04: N04's C02 part (Appendix C line 121 as PC-43 place 9 writes it): a binding verdict or an acceptance with
-- the working token is refused, and so are a fake role name and a fake session ID with the same token; with the
-- devos_kurulum token, a verdict or acceptance outside the ledger transfer's path and any approval a rule counts as the
-- audit environment's are refused too; the audit environment's record is accepted. Part T (the transfer's copy) is
-- W-C02-14's and is reported on its own line. Specification: tests/C02/W-C02-07/T-W07-N04_self_approval.md.
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
    ('epoch_table', 'devos_private.global_authority_epoch'), -- one row (EV-C02-002 DM-01); name assumed
    ('epoch_column', 'epoch'),                             -- assumed
    ('events', 'devos_private.events'),                    -- Event, B 3.13; name assumed; columns id, role_class, origin
    ('rejected', 'devos_private.rejected_attempts'),       -- RejectedAttempt, DM-19's fields; name assumed
    ('role_codes', 'role_class_not_permitted'),            -- reason code(s) of a wrong-role-class refusal; assumed
    ('review_table', 'devos_private.reviews'),             -- B 3.11; assumed
    ('verdict_table', 'devos_private.verdicts'),           -- B 3.11; assumed
    ('work_table', 'devos_private.works'),                 -- B 3.3; assumed
    ('evalrun_table', 'devos_private.eval_runs')           -- B 3.15; assumed
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
               and (r->'res'->>'status' = 'refused' or r->'res'->'refused' = 'true'::jsonb or r->'res' ? 'reason_code')
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

-- Plants one synthetic row as owner (README 5.1 (a): fixtures as owner where the rule under test is not the owner's):
-- every required column gets a neutral value by type ('w07_fixture SYNTHETIC W-C02-07' for text), and a required
-- single-column foreign key gets a planted parent. Returns the new row's primary key as text.
create function pg_temp.w07_plant(p_tbl regclass, p_depth int default 0) returns text language plpgsql as $f$
declare c record; cols text[] := '{}'; vals text[] := '{}'; v text; id text; par oid; pk text;
begin
  if p_depth > 4 then raise exception 'w07: planting deeper than 4 parents'; end if;
  for c in select a.attnum, a.attname, t.oid toid, t.typname, t.typtype, t.typcategory, format_type(a.atttypid, a.atttypmod) ft
           from pg_attribute a join pg_type t on t.oid = a.atttypid
           where a.attrelid = p_tbl and a.attnum > 0 and not a.attisdropped and a.attnotnull and not a.atthasdef
             and a.attidentity = '' and a.attgenerated = '' order by a.attnum loop
    select cf.confrelid into par from pg_constraint cf
    where cf.conrelid = p_tbl and cf.contype = 'f' and cf.conkey = array[c.attnum]::int2[] limit 1;
    if par is not null then
      v := quote_literal(pg_temp.w07_plant(par::regclass, p_depth + 1));
    else
      v := case
        when c.typname = 'uuid' then 'gen_random_uuid()'
        when c.typname in ('json', 'jsonb') then quote_literal('{"w07_fixture": "SYNTHETIC W-C02-07"}')
        when c.typtype = 'e' then quote_literal((select enumlabel from pg_enum where enumtypid = c.toid order by enumsortorder limit 1))
        when c.typcategory = 'A' then quote_literal('{}')
        when c.typcategory = 'S' then quote_literal('w07_fixture SYNTHETIC W-C02-07')
        when c.typcategory = 'N' then '1'
        when c.typcategory = 'B' then 'false'
        when c.typcategory = 'D' then 'now()'
        else 'null' end;
    end if;
    par := null;
    cols := cols || quote_ident(c.attname); vals := vals || (v || '::' || c.ft);
  end loop;
  select a.attname into pk from pg_index i join pg_attribute a on a.attrelid = i.indrelid and a.attnum = i.indkey[0]
  where i.indrelid = p_tbl and i.indisprimary limit 1;
  if cardinality(cols) = 0 then
    execute format('insert into %s default values returning %I::text', p_tbl, coalesce(pk, 'id')) into id;
  else
    execute format('insert into %s (%s) values (%s) returning %I::text', p_tbl, array_to_string(cols, ', '),
                   array_to_string(vals, ', '), coalesce(pk, 'id')) into id;
  end if;
  return id;
end $f$;

do $$
declare why text; api text := pg_temp.w07_cfg('api_role'); i jsonb; cal text; den text; kur text; scrub text[];
        r jsonb; fv oid; fa oid; fr oid; fe oid; sqlv text; sqla text; rid text; wid text; fake jsonb;
        sub jsonb; c record;
begin
  why := pg_temp.w07_pre_common();
  if why is null and pg_temp.w07_fn('record_verdict') is null then why := 'devos_api.record_verdict does not exist'; end if;
  if why is null and pg_temp.w07_fn('accept') is null then why := 'devos_api.accept does not exist'; end if;
  if why is not null then perform pg_temp.w07_cnc('N04-pre', why); return; end if;
  i := pg_temp.w07_issue('devos_calisma'); if i ? 'why' then perform pg_temp.w07_cnc('N04-tokens', i->>'why'); return; end if;
  cal := i->>'tok';
  i := pg_temp.w07_issue('devos_denetim'); if i ? 'why' then perform pg_temp.w07_cnc('N04-tokens', i->>'why'); return; end if;
  den := i->>'tok';
  i := pg_temp.w07_issue('devos_kurulum'); if i ? 'why' then perform pg_temp.w07_cnc('N04-tokens', i->>'why'); return; end if;
  kur := i->>'tok';
  scrub := array[cal, den, kur];
  fv := pg_temp.w07_fn('record_verdict'); fa := pg_temp.w07_fn('accept');
  sqlv := pg_temp.w07_sql_for(fv); sqla := pg_temp.w07_sql_for(fa);
  fake := jsonb_build_object('x-devos-role', 'devos_denetim', 'x-devos-role-class', 'devos_denetim', 'role', 'devos_denetim',
                             'x-devos-session-id', 'w07_fixture_fake_session SYNTHETIC W-C02-07');

  -- (C02) the working token: a binding verdict and an acceptance are refused.
  r := pg_temp.w07_call(api, pg_temp.w07_h(cal), sqlv, scrub);
  perform pg_temp.w07_put('N04-a1', pg_temp.w07_is_role_refusal(r, 'record_verdict', 'devos_calisma'),
    'record_verdict with the working token: ' || pg_temp.w07_says(r));
  r := pg_temp.w07_call(api, pg_temp.w07_h(cal), sqla, scrub);
  perform pg_temp.w07_put('N04-b1', pg_temp.w07_is_role_refusal(r, 'accept', 'devos_calisma'),
    'accept with the working token: ' || pg_temp.w07_says(r));
  -- A fake role name with the same token, at every place a caller controls: request headers, the JWT claim settings,
  -- an argument named for a role, and a database role of that name if one exists. The refusal stays the working one.
  r := pg_temp.w07_call(api, pg_temp.w07_h(cal, fake), sqlv, scrub);
  perform pg_temp.w07_put('N04-c1', pg_temp.w07_is_role_refusal(r, 'record_verdict', 'devos_calisma'),
    'record_verdict, working token, fake role name and session ID in headers: ' || pg_temp.w07_says(r));
  r := pg_temp.w07_call(api, pg_temp.w07_h(cal), sqlv, scrub,
         jsonb_build_object('request.jwt.claims', '{"role": "devos_denetim"}', 'request.jwt.claim.role', 'devos_denetim'));
  perform pg_temp.w07_put('N04-c2', pg_temp.w07_is_role_refusal(r, 'record_verdict', 'devos_calisma'),
    'record_verdict, working token, fake role in the JWT claim settings: ' || pg_temp.w07_says(r));
  foreach fr in array array[fv, fa] loop
    if exists (select 1 from pg_proc where oid = fr and array_to_string(proargnames, ',') ~* 'role') then
      r := pg_temp.w07_call(api, pg_temp.w07_h(cal),
             pg_temp.w07_sql_for(fr, jsonb_build_object('role', quote_literal('devos_denetim'))), scrub);
      perform pg_temp.w07_put('N04-c3-' || (select proname from pg_proc where oid = fr),
        pg_temp.w07_is_role_refusal(r, (select proname from pg_proc where oid = fr), 'devos_calisma'),
        'working token, argument naming a role set to devos_denetim: ' || pg_temp.w07_says(r));
    end if;
    if exists (select 1 from pg_proc where oid = fr and array_to_string(proargnames, ',') ~* 'session') then
      r := pg_temp.w07_call(api, pg_temp.w07_h(cal, fake),
             pg_temp.w07_sql_for(fr, jsonb_build_object('session', quote_literal('w07_fixture_fake_session SYNTHETIC W-C02-07'))), scrub);
      perform pg_temp.w07_put('N04-e1-' || (select proname from pg_proc where oid = fr),
        pg_temp.w07_is_role_refusal(r, (select proname from pg_proc where oid = fr), 'devos_calisma'),
        'working token, a fake declared session ID as argument and header: ' || pg_temp.w07_says(r));
    end if;
  end loop;
  r := pg_temp.w07_call(api, pg_temp.w07_h(cal, fake), sqla, scrub);
  perform pg_temp.w07_put('N04-e2', pg_temp.w07_is_role_refusal(r, 'accept', 'devos_calisma'),
    'accept, working token, fake session ID and role in headers: ' || pg_temp.w07_says(r));
  if to_regrole('devos_denetim') is not null then
    r := pg_temp.w07_call('devos_denetim', pg_temp.w07_h(cal), sqlv, scrub);
    perform pg_temp.w07_put('N04-c4', pg_temp.w07_is_role_refusal(r, 'record_verdict', 'devos_calisma'),
      'record_verdict acting as the database role devos_denetim with the working token: ' || pg_temp.w07_says(r));
  end if;

  -- (C02) the installation token outside the ledger transfer's path, and any approval a rule counts as the audit's.
  r := pg_temp.w07_call(api, pg_temp.w07_h(kur), sqlv, scrub);
  perform pg_temp.w07_put('N04-k1', pg_temp.w07_is_role_refusal(r, 'record_verdict', 'devos_kurulum'),
    'record_verdict with the devos_kurulum token, outside the transfer: ' || pg_temp.w07_says(r));
  r := pg_temp.w07_call(api, pg_temp.w07_h(kur), sqla, scrub);
  perform pg_temp.w07_put('N04-k2', pg_temp.w07_is_role_refusal(r, 'accept', 'devos_kurulum'),
    'accept with the devos_kurulum token: ' || pg_temp.w07_says(r));
  r := pg_temp.w07_call(api, pg_temp.w07_h(kur, fake), sqlv, scrub);
  perform pg_temp.w07_put('N04-k6', pg_temp.w07_is_role_refusal(r, 'record_verdict', 'devos_kurulum'),
    'record_verdict, devos_kurulum token, fake role name and session ID: ' || pg_temp.w07_says(r));
  for c in select p.oid, p.proname from pg_proc p join pg_namespace s on s.oid = p.pronamespace
           where s.nspname = 'devos_api' and (p.proname in ('open_review', 'set_effort_policy', 'activate_release',
                 'advance_recovery_stage', 'begin_recovery') or p.proname ~ '(^approve|approval)') order by 2 loop
    r := pg_temp.w07_call(api, pg_temp.w07_h(kur), pg_temp.w07_sql_for(c.oid), scrub);
    perform pg_temp.w07_put('N04-k-' || c.proname, pg_temp.w07_is_role_refusal(r, c.proname, 'devos_kurulum'),
      c.proname || ' (an approval or binding act a rule counts as the audit environment''s) with the devos_kurulum token: '
      || pg_temp.w07_says(r));
  end loop;

  -- Positive controls. P1: the audit token passes the gate of both. P2: on a planted review and target, the audit
  -- environment's verdict and acceptance are accepted, and the same calls with the other tokens are refused.
  r := pg_temp.w07_call(api, pg_temp.w07_h(den), sqlv, scrub);
  perform pg_temp.w07_put('N04-p1', pg_temp.w07_passed_gate(r, 'record_verdict'), 'record_verdict, audit token, gate: ' || pg_temp.w07_says(r));
  r := pg_temp.w07_call(api, pg_temp.w07_h(den), sqla, scrub);
  perform pg_temp.w07_put('N04-p2', pg_temp.w07_passed_gate(r, 'accept'), 'accept, audit token, gate: ' || pg_temp.w07_says(r));
  begin
    rid := pg_temp.w07_plant(pg_temp.w07_cfg('review_table')::regclass);
    wid := pg_temp.w07_plant(pg_temp.w07_cfg('work_table')::regclass);
  exception when others then
    perform pg_temp.w07_cnc('N04-p3', 'the review or work fixture could not be planted: ' || sqlstate || ' ' || left(sqlerrm, 100));
    perform pg_temp.w07_cnc('N04-p4', 'the review or work fixture could not be planted');
    rid := null;
  end;
  if rid is not null then
    sub := jsonb_build_object('review', quote_literal(rid), 'target', quote_literal(wid), 'work', quote_literal(wid));
    sqlv := pg_temp.w07_sql_for(fv, sub); sqla := pg_temp.w07_sql_for(fa, sub);
    r := pg_temp.w07_call(api, pg_temp.w07_h(den), sqlv, scrub);
    if pg_temp.w07_is_accepted(r, 'devos_denetim', true) then
      perform pg_temp.w07_put('N04-p3', true, 'record_verdict on the planted review, audit token: accepted; ' || pg_temp.w07_says(r));
    else
      perform pg_temp.w07_cnc('N04-p3', 'the audit verdict on the planted review was not accepted; the arguments are revised '
        || 'before the first result (README section 8): ' || pg_temp.w07_says(r));
    end if;
    r := pg_temp.w07_call(api, pg_temp.w07_h(cal), sqlv, scrub);
    perform pg_temp.w07_put('N04-a2', pg_temp.w07_is_role_refusal(r, 'record_verdict', 'devos_calisma'),
      'the same verdict call with the working token: ' || pg_temp.w07_says(r));
    r := pg_temp.w07_call(api, pg_temp.w07_h(kur), sqlv, scrub);
    perform pg_temp.w07_put('N04-k1b', pg_temp.w07_is_role_refusal(r, 'record_verdict', 'devos_kurulum'),
      'the same verdict call with the devos_kurulum token: ' || pg_temp.w07_says(r));
    r := pg_temp.w07_call(api, pg_temp.w07_h(den), sqla, scrub);
    if pg_temp.w07_is_accepted(r, 'devos_denetim', true) then
      perform pg_temp.w07_put('N04-p4', true, 'accept on the planted target, audit token: accepted; ' || pg_temp.w07_says(r));
    else
      perform pg_temp.w07_cnc('N04-p4', 'the audit acceptance was not accepted; the arguments are revised before the first '
        || 'result (README section 8): ' || pg_temp.w07_says(r));
    end if;
    r := pg_temp.w07_call(api, pg_temp.w07_h(cal), sqla, scrub);
    perform pg_temp.w07_put('N04-b2', pg_temp.w07_is_role_refusal(r, 'accept', 'devos_calisma'),
      'the same acceptance call with the working token: ' || pg_temp.w07_says(r));
  end if;
  -- Part T (W-C02-14; the executor's decision 5): the ledger transfer's copy, written through W-C02-06's path under
  -- devos_kurulum, counting as no audit verdict. Not a case of this file's result; reported on its own line.
  raise notice 'T-W07-N04 PART T (W-C02-14) COULD NOT CHECK (W-C02-06''s transfer path is not accepted yet; its interface is named in the specification)';
  cal := null; den := null; kur := null; scrub := null;
end $$;

select case_id, outcome, detail from w07_results order by case_id;

do $$
declare nb int; nc int; n int;
begin
  select count(*) filter (where outcome = 'bad'), count(*) filter (where outcome = 'could_not_check'), count(*)
    into nb, nc, n from w07_results;
  if nb > 0 then
    raise exception 'W07_N04_SELF_APPROVAL FAIL (% bad, % could not check, of %)', nb, nc, n;
  elsif nc > 0 or n = 0 then
    raise exception 'W07_N04_SELF_APPROVAL COULD NOT CHECK (% of % could not be checked)', nc, n;
  end if;
  raise notice 'W07_N04_SELF_APPROVAL PASS (%/%)', n, n;
end $$;

rollback;
