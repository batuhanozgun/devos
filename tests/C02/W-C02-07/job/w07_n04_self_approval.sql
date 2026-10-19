-- Synthetic test data (plan Section 8 item 13): every token below is issued at run time by issue_env_token inside this
-- transaction, held only in PL/pgSQL variables, never printed, stored or compared by hash, and discarded by the closing
-- rollback. Text inputs and planted rows read 'w07_fixture SYNTHETIC W-C02-07'. No personal or business data.
--
-- T-W07-N04: N04's C02 part (Appendix C line 121 as PC-43 place 9 writes it): a binding verdict or an acceptance with
-- the working token is refused, and so are a fake role name and a fake session ID with the same token; with the
-- devos_kurulum token, a verdict or acceptance outside the ledger transfer's path and any approval a rule counts as the
-- audit environment's are refused too; the audit environment's record is accepted. Part T (the transfer's copy:
-- N04-T1, N04-T2, N04-T2-pos) is inside this file's result and is counted by W-C02-10 point 7 (phase C5; CHK-C02-046
-- C5 (b)). Specification: tests/C02/W-C02-07/T-W07-N04_self_approval.md.
--
-- Runs: in devos-test by the migration job's test step as postgres (README 5.1 (a)), and on the break harness's
-- throwaway database (README 5.2). transport sql-set-role: the header is simulated with set_config('request.headers',
-- ..., true) and the caller acts as the Data API's role (set local role anon); session_user stays postgres, so
-- deployment_drift's branch for the migration login cannot be exercised here. Interface assumed: pg_temp.w07_cfg and
-- the specification's 'Interface assumed' (README section 8). Safety: begin ... rollback; each case runs in a
-- subtransaction that is undone. No psql meta-command. Output: one row per case, then PASS, FAIL or COULD NOT CHECK.
-- Revised under ledger rule 3, 2026-10-19 (N-293 (3); EV-C02-013 section 20 (5) and (6)), before any result of this
-- file: N04-p3 calls record_verdict with a payload naming the planted Review and a result, and N04-p4 calls accept on
-- a Verdict planted on the audit environment's Review of a work item at its revision, with a basis, so that a correct
-- build can accept them (the first version filled both with "neutral" arguments, which no build can accept); the same
-- calls with the other tokens (N04-a2, -k1b, -b2) now differ from them in the token only. Part T's two planted Reviews
-- get the same target and basis forms (a further fault of the same kind). See the specification's "Revision under
-- ledger rule 3 (N-293 (3), 2026-10-19)".
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

-- Revised under ledger rule 3 (N-293 (3), 2026-10-19). A record a Review can be of, as M09-07's open_review and accept
-- read it (EV-C02-013 section 20 (4) and (6)): a work item at its revision 1, under a Mission revision whose owner
-- authority is a planted batu Decision, and a planted routine Decision at its revision 1 for the basis; all planted as
-- the owner with scope synthetic.w07fixture. Returns {work, decision}; raises when it cannot.
create function pg_temp.n04_target() returns jsonb language plpgsql as $f$
declare dc uuid; db uuid; mi uuid; mr uuid; wk uuid;
begin
  insert into devos_private.decision (class, status, answered_revision) values ('batu', 'answered', 1) returning id into dc;
  insert into devos_private.decision_revision (decision_id, revision, question)
    values (dc, 1, 'w07_fixture SYNTHETIC W-C02-07 owner authority');
  insert into devos_private.mission default values returning id into mi;
  insert into devos_private.mission_revision (mission_id, revision, purpose, scope, acceptance, owner_authority)
    values (mi, 1, 'w07_fixture SYNTHETIC W-C02-07 mission; not work', 'synthetic.w07fixture', 'w07_fixture SYNTHETIC W-C02-07', dc)
    returning id into mr;
  insert into devos_private.work default values returning id into wk;
  insert into devos_private.work_revision (work_id, revision, mission_revision_id, scope, purpose, impact_class)
    values (wk, 1, mr, 'synthetic.w07fixture', 'w07_fixture SYNTHETIC W-C02-07 review target', 'routine');
  insert into devos_private.decision (class) values ('routine') returning id into db;
  insert into devos_private.decision_revision (decision_id, revision, question)
    values (db, 1, 'w07_fixture SYNTHETIC W-C02-07 basis');
  return jsonb_build_object('work', wk, 'decision', db);
end $f$;

do $$
declare why text; api text := pg_temp.w07_cfg('api_role'); i jsonb; cal text; den text; kur text; scrub text[];
        r jsonb; fv oid; fa oid; fr oid; fe oid; sqlv text; sqla text; rid text; wid text; fake jsonb;
        sub jsonb; c record; tg jsonb; vid text;
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
  -- Phase C4a: set_effort_policy is not in the list below: its gate admits devos_kurulum (EV-C02-008 1.7.4), and its
  -- approval (a reduction, a standing policy) is refused to devos_kurulum after the gate: T-W07-N03's -kurulum cases.
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
           where s.nspname = 'devos_api' and (p.proname in ('open_review', 'activate_release',
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
  -- Revised under ledger rule 3 (N-293 (3), 2026-10-19): the Review is the audit environment's (reviewer_role_class
  -- devos_denetim) of the work item n04_target plants, at its revision 1, with that function's Decision as its basis
  -- (EV-C02-013 section 20 (6)); its triggers are off for this one insert, as part T's n04t_plant does (DM-41 (a), W-C02-10's,
  -- may refuse a Review of a target planted in the same transaction). N04-p4's Verdict (result pass) is planted on it as
  -- the owner, so that p4 does not rest on p3's call. record_verdict gets p = {review_ref, result} and accept gets that
  -- Verdict and the Review's use, in place of the neutral values (EV-C02-013 section 20 (5): review_ref and result are
  -- required; the first version sent neither, and a random verdict_ref).
  begin
    tg := pg_temp.n04_target(); wid := tg->>'work';
    execute format('alter table %s disable trigger user', pg_temp.w07_cfg('review_table'));
    execute format('insert into %s (kind, claim, target_ref, target_revision, use, basis_refs, reviewer_role_class, '
                   || 'independence_level) values (''review'', ''w07_fixture SYNTHETIC W-C02-07 audit review'', $1::uuid, 1, '
                   || '''w07_fixture_use_n04'', $2, ''devos_denetim'', ''fresh_context_subagent'') returning id::text',
                   pg_temp.w07_cfg('review_table'))
      into rid using wid, jsonb_build_array(jsonb_build_object('ref', tg->>'decision', 'revision', 1));
    execute format('alter table %s enable trigger user', pg_temp.w07_cfg('review_table'));
    insert into devos_private.verdict (review_ref, result) values (rid::uuid, 'pass') returning id::text into vid;
  exception when others then
    perform pg_temp.w07_cnc('N04-p3', 'the review or work fixture could not be planted: ' || sqlstate || ' ' || left(sqlerrm, 100));
    perform pg_temp.w07_cnc('N04-p4', 'the review or work fixture could not be planted');
    rid := null;
  end;
  if rid is not null then
    sqlv := pg_temp.w07_sql_for(fv, jsonb_build_object('^p$',
              quote_literal(jsonb_build_object('review_ref', rid, 'result', 'pass')::text) || '::jsonb'));
    sqla := pg_temp.w07_sql_for(fa, jsonb_build_object('^verdict_ref$', quote_literal(vid) || '::uuid',
              '^accepted_use$', quote_literal('w07_fixture_use_n04')));
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
  cal := null; den := null; kur := null; scrub := null;
end $$;

-- Part T (phase C5, CHK-C02-030 C5; Ek_C:121's C02 clause "the ledger transfer's copy of an installation checker
-- verdict is written under role class devos_kurulum and counts nowhere a rule needs the audit environment's"), cases of
-- this file's result, counted by W-C02-10 point 7 ("N04 (its C02 part)"). W-C02-06's design is accepted (CHK-C02-024):
-- the copy is written through transfer_review with devos_kurulum (EV-C02-005 2.4; B:397), and accept refuses it
-- (EV-C02-005 2.4 and 12: the copies "count nowhere a rule needs devos_denetim"). (a) The transfer's functions refuse
-- every token but devos_kurulum: T-W07-5B's row R19, not repeated here. The payload keys are CHOSEN by README 8.1's rule
-- (no source names them, EV-C02-005 section 12): B 3.11's Review fields, a verdict object with B 3.11's Verdict fields,
-- run_id and transfer_source (EV-C02-005 section 15 S1); revised before the first result if W-C02-09 names others.
create function pg_temp.n04t_call(p_class text, p_sql text, p_args jsonb) returns jsonb language plpgsql as $f$
declare i jsonb := pg_temp.w07_issue(p_class); r jsonb; st text; msg text;
begin
  if i ? 'why' then return jsonb_build_object('w07_cnc', i->>'why'); end if;
  perform set_config('request.headers', jsonb_build_object('x-devos-env-token', i->>'tok')::text, true);
  begin
    execute format('set local role %I', pg_temp.w07_cfg('api_role'));
    execute p_sql into r using p_args;
    execute 'reset role';
  exception when others then
    get stacked diagnostics st = returned_sqlstate, msg = message_text;
    r := jsonb_build_object('raised', true, 'sqlstate', st, 'message', left(replace(msg, i->>'tok', '[w07: presented value]'), 160));
  end;
  i := null;
  perform set_config('request.headers', '{}', true);
  return coalesce(r, '{"status": "absent"}'::jsonb);
end $f$;
create function pg_temp.n04t_kind(r jsonb) returns text language sql immutable as $f$
  select case when r ? 'w07_cnc' then 'test' when r ? 'raised' then 'unknown'
              when r->>'status' = 'refused' and r->>'reason_code' = 'could_not_check' then 'could_not_check'
              when r->>'status' = 'refused' then 'refused' when r->>'status' = 'ok' then 'accepted' else 'unknown' end $f$;
create function pg_temp.n04t_brief(r jsonb) returns text language sql immutable as $f$
  select pg_temp.n04t_kind(r) || coalesce(' [' || nullif(concat_ws(' ', r->>'reason_code', r->>'reason', r->>'message'), '') || ']', '') $f$;
-- An owner-level row with the keys its table has, the table's triggers off for this one insert (DM-41 (a) would refuse
-- a Review of a target planted in this same transaction); returns its id, or raises.
create function pg_temp.n04t_plant(p_tbl text, p_base jsonb) returns text language plpgsql as $f$
declare b jsonb := p_base; cols text; vals text; id text;
begin
  -- an id without a default gets a new uuid; a defaulted one is left to its default and read back
  if exists (select 1 from information_schema.columns where table_schema = 'devos_private' and table_name = p_tbl
               and column_name = 'id' and column_default is null and is_identity = 'NO') then
    b := b || jsonb_build_object('id', gen_random_uuid()::text);
  end if;
  select string_agg(quote_ident(k), ', '), string_agg(quote_literal(b->>k) || '::' || format_type(a.atttypid, a.atttypmod), ', ')
    into cols, vals from jsonb_object_keys(b) k
    join pg_attribute a on a.attrelid = ('devos_private.' || p_tbl)::regclass and a.attname = k and not a.attisdropped
   where b->>k is not null;
  execute format('alter table devos_private.%I disable trigger user', p_tbl);
  execute format('insert into devos_private.%I (%s) values (%s) returning id::text', p_tbl, cols, vals) into id;
  execute format('alter table devos_private.%I enable trigger user', p_tbl);
  return id;
end $f$;
create function pg_temp.n04t_src(p_kind text, p_id text) returns jsonb language sql as $f$
  select jsonb_build_object('kind', p_kind, 'source_id', p_id, 'path', 'evidence/C02/checks/' || p_id || '.md',
    'input_commit', repeat('a7', 20), 'last_commit', repeat('a7', 20), 'sha256', repeat('5e', 32)) $f$;
create function pg_temp.n04t_acc(p_work text) returns text language plpgsql as $f$
declare s text;
begin
  execute format('select to_jsonb(x)->>''acceptance'' from %s x where x.id::text = $1', pg_temp.w07_cfg('work_table')) into s using p_work;
  return coalesce(s, 'absent');
end $f$;

do $$
declare why text; run text := 'w07_fixture_run_n04t'; r jsonb; w text; w2 text; rk text; vk text; ra text; va text;
        rc text; ev text; a0 text; a1 text; tg jsonb; b1 text; b2 text;
begin
  why := pg_temp.w07_pre_common();
  if why is null and (pg_temp.w07_fn('transfer_review') is null or pg_temp.w07_fn('begin_transfer_run') is null
                      or pg_temp.w07_fn('accept') is null) then
    why := 'the ledger transfer''s functions or accept are not all there (W-C02-09 builds them; EV-C02-005 section 15 S5)';
  end if;
  if why is null then
    r := pg_temp.n04t_call('devos_kurulum', 'select devos_api.begin_transfer_run($1)', jsonb_build_object('run_id', run,
           'input_commit', repeat('a7', 20), 'manifest_sha256', repeat('5e', 32), 'counts', '{}'::jsonb, 'phase', 'begun', 'mode', 'verdict_copies'));
    if pg_temp.n04t_kind(r) <> 'accepted' then
      why := 'begin_transfer_run was not accepted with the chosen keys (revised when W-C02-09 names them): ' || pg_temp.n04t_brief(r);
    end if;
  end if;
  if why is not null then
    perform pg_temp.w07_cnc(c, why) from unnest(array['N04-T1', 'N04-T2', 'N04-T2-pos']) c;
    return;
  end if;
  -- (b) N04-T1: a copy written in the transfer's form carries role class devos_kurulum (the Review copy's
  -- reviewer_role_class, B 3.11, "from the token"; and its creation event's role_class, B 3.13).
  -- Revised under ledger rule 3 (N-293 (3)'s further fault, 2026-10-19): the verdict's limits is an array, as the
  -- Verdict table's check requires (verdict_limits_check; EV-C02-013 section 20 (5)); the first version sent an empty
  -- string, which no build can write.
  begin
    w := pg_temp.w07_plant(pg_temp.w07_cfg('work_table')::regclass);
    r := pg_temp.n04t_call('devos_kurulum', 'select devos_api.transfer_review($1)', jsonb_build_object('run_id', run, 'kind', 'review',
      'claim', 'SYNTHETIC W-C02-07 w07_fixture installation verdict copy', 'target_ref', w,
      'criterion', 'plan/work/W-W07-FIXTURE.md', 'basis_refs', jsonb_build_array('w07_fixture_tree'),
      'reviewer_declared_session', 'w07_fixture_checker_run SYNTHETIC W-C02-07', 'independence_level', 'fresh_context_subagent',
      'use', 'installation_acceptance', 'verdict', jsonb_build_object('result', 'pass', 'objections', '[]'::jsonb,
      'evidence_refs', '[]'::jsonb, 'limits', '[]'::jsonb), 'transfer_source', pg_temp.n04t_src('verdict', 'CHK-W07-FIXTURE-1')));
  exception when others then
    r := jsonb_build_object('w07_cnc', 'the target work item could not be planted: ' || sqlstate || ' ' || left(sqlerrm, 120));
  end;
  if pg_temp.n04t_kind(r) <> 'accepted' then
    perform pg_temp.w07_cnc('N04-T1', 'transfer_review was not accepted with the chosen keys (revised when W-C02-09 names them): '
      || pg_temp.n04t_brief(r));
  else
    rk := coalesce(r->>'id', r->>'review_id');
    execute format('select coalesce(to_jsonb(x)->>''reviewer_role_class'', to_jsonb(x)->>''role_class'') from %s x where x.id::text = $1',
                   pg_temp.w07_cfg('review_table')) into rc using rk;
    execute format('select string_agg(distinct to_jsonb(e)->>''role_class'', '','') from %s e where to_jsonb(e)->>''aggregate_id'' = $1',
                   pg_temp.w07_cfg('events')) into ev using rk;
    perform pg_temp.w07_put('N04-T1', rk is not null and rc = 'devos_kurulum' and coalesce(ev, 'devos_kurulum') = 'devos_kurulum',
      format('transfer_review with devos_kurulum: accepted; the copy''s role class %s, its events'' role classes %s (wanted '
             || 'devos_kurulum in both)', coalesce(rc, 'absent'), coalesce(ev, 'none')));
  end if;
  -- (c) N04-T2: accept, the rule that needs the audit environment's verdict (B:244), does not count such a copy. Two
  -- Review and Verdict rows planted at owner level, result pass, use installation_acceptance, differing only in their
  -- role class: devos_kurulum with a transferred creation event (the copy), devos_denetim (the audit's, N04-T2-pos).
  -- Revised under ledger rule 3 (N-293 (3)'s further fault, 2026-10-19): each target is a work item at its revision 1,
  -- named with target_revision, and each Review has a basis of one Decision at its revision 1 (pg_temp.n04_target), as
  -- M09-07's accept reads them (EV-C02-013 section 20 (6)); the first version's targets had no revision and its bases
  -- were empty, so accept could accept neither Review and N04-T2-pos could not pass. The two Reviews still differ only
  -- in their role class (and the copy's transferred event).
  begin
    tg := pg_temp.n04_target(); w := tg->>'work'; b1 := tg->>'decision';
    tg := pg_temp.n04_target(); w2 := tg->>'work'; b2 := tg->>'decision';
    rk := pg_temp.n04t_plant('review', jsonb_build_object('kind', 'review', 'claim', 'SYNTHETIC W-C02-07 w07_fixture copy',
      'target_ref', w, 'target_revision', 1, 'basis_refs', jsonb_build_array(jsonb_build_object('ref', b1, 'revision', 1)),
      'reviewer_role_class', 'devos_kurulum', 'role_class', 'devos_kurulum', 'use', 'installation_acceptance'));
    vk := pg_temp.n04t_plant('verdict', jsonb_build_object('review_ref', rk, 'result', 'pass', 'role_class', 'devos_kurulum'));
    perform pg_temp.n04t_plant('event', jsonb_build_object('aggregate_type', 'review', 'aggregate_id', rk, 'event_type', 'transferred',
      'role_class', 'devos_kurulum', 'origin', 'call', 'payload', jsonb_build_object('transfer_source', pg_temp.n04t_src('verdict', 'CHK-W07-FIXTURE-2'))));
    ra := pg_temp.n04t_plant('review', jsonb_build_object('kind', 'review', 'claim', 'SYNTHETIC W-C02-07 w07_fixture audit review',
      'target_ref', w2, 'target_revision', 1, 'basis_refs', jsonb_build_array(jsonb_build_object('ref', b2, 'revision', 1)),
      'reviewer_role_class', 'devos_denetim', 'role_class', 'devos_denetim', 'use', 'installation_acceptance'));
    va := pg_temp.n04t_plant('verdict', jsonb_build_object('review_ref', ra, 'result', 'pass', 'role_class', 'devos_denetim'));
  exception when others then
    perform pg_temp.w07_cnc(c, 'the Review and Verdict fixtures could not be planted: ' || sqlstate || ' ' || left(sqlerrm, 120))
      from unnest(array['N04-T2', 'N04-T2-pos']) c;
    return;
  end;
  a0 := pg_temp.n04t_acc(w2);
  r := pg_temp.n04t_call('devos_denetim', 'select devos_api.accept(($1->>''verdict_ref'')::uuid, $1->>''accepted_use'')',
         jsonb_build_object('verdict_ref', va, 'accepted_use', 'installation_acceptance'));
  a1 := pg_temp.n04t_acc(w2);
  if pg_temp.n04t_kind(r) <> 'accepted' then
    perform pg_temp.w07_cnc('N04-T2-pos', 'accept of the audit environment''s planted verdict was not accepted (revised when W-C02-09 '
      || 'names accept''s form): ' || pg_temp.n04t_brief(r));
    perform pg_temp.w07_cnc('N04-T2', 'its positive pair was not accepted, so a refusal here would show nothing about the copy');
    return;
  end if;
  perform pg_temp.w07_put('N04-T2-pos', a1 = 'accepted' or a0 = 'absent',
    format('accept of a devos_denetim verdict, with the audit token: accepted; the target''s acceptance %s -> %s', a0, a1));
  a0 := pg_temp.n04t_acc(w);
  r := pg_temp.n04t_call('devos_denetim', 'select devos_api.accept(($1->>''verdict_ref'')::uuid, $1->>''accepted_use'')',
         jsonb_build_object('verdict_ref', vk, 'accepted_use', 'installation_acceptance'));
  a1 := pg_temp.n04t_acc(w);
  if pg_temp.n04t_kind(r) in ('refused', 'accepted') then
    perform pg_temp.w07_put('N04-T2', pg_temp.n04t_kind(r) = 'refused' and a1 = a0,
      format('accept of the transfer''s devos_kurulum copy, with the audit token: %s (wanted refused, the target unchanged); '
             || 'acceptance %s -> %s', pg_temp.n04t_brief(r), a0, a1));
  else
    perform pg_temp.w07_cnc('N04-T2', 'not a refusal or an acceptance of interface v1: ' || pg_temp.n04t_brief(r));
  end if;
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
