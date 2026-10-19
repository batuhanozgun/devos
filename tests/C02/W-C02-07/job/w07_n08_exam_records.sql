-- Synthetic test data (plan Section 8 item 13): every token below is issued at run time by issue_env_token inside this
-- transaction, held only in PL/pgSQL variables, never printed, stored or compared by hash, and discarded by the closing
-- rollback. Text inputs and planted rows read 'w07_fixture SYNTHETIC W-C02-07'. No personal or business data.
--
-- T-W07-N08: N08's database part in C02 (EV-C02-003 §4.5; PC-43 place 10): every access to the exam records with the
-- working, audit, devos_kurulum and devos_ci tokens is refused, the exam fact lives only in the exam records
-- (EV-C02-002 DM-24), and the exam token accesses. Specification: tests/C02/W-C02-07/T-W07-N08_exam_records.md (part A).
-- Phase C4b (EV-C02-008 5.1): the reader finder exempts functions by name (nine, and from 2026-10-19 ten, with
-- open_decision; N-286); their answers, N08-s3, N08-s4 and the EXF pairs are part X, w07_n08_exam_fact.sql.
-- Revised under ledger rule 3, 2026-10-19 (N-301): a reader whose parameter names an exam record reads an EvalRun that
-- record_eval_run wrote (N08-rp), and three cases are added: N08-s5 (the link only in EvalRun, B 3.15), N08-wp3 (a run
-- naming an earlier revision, B 3.15) and N08-s6 (a partial claim at the second layer, EV-C02-008 5.1 (c) bound 3).
-- Revised under ledger rule 3, 2026-10-19 (N-301, L-395's annotation; CHK-C02-102 C2), before N08's first result:
-- N08-wp4 added (the EvalRun records the revision the call names, B 3.15's "+revision"); no other case changes.
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

-- Phase C4b: the functions the reader finder exempts by name (EV-C02-008 5.1, after CHK-C02-027 D). Revised under
-- ledger rule 3, 2026-10-19, before any result (N-286; EV-C02-017 section 9 item 2; EV-C02-008 5.1's dated list item):
-- open_decision is the tenth. Called with work_ref it makes relate's checks, Rule O among them (EV-C02-013 2.2, R1-6),
-- and reads EvalRun's table only on the devos_sinav branch. The same list is in w07_n08_exam_fact.sql.
create function pg_temp.n08_exempt() returns text[] language sql immutable as $f$
  select array['revise_work', 'mark_stale', 'cancel_work', 'reopen_for_review', 'relate', 'retract_relation',
               'set_effort_policy', 'affected_entities', 'explain_paths', 'open_decision']
$f$;

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

-- Revised under ledger rule 3, 2026-10-19 (N-301; k06 of EV-C02-014 section 11): the rows of every devos_private table
-- whose text names p_id, as {table: count}; columns whose names hold "hash" or "token" are left out, so nothing derived
-- from a token is read. N08-s5 compares it before and after an exam run (B 3.15: the link "lives only here").
create function pg_temp.n08_naming(p_id text) returns jsonb language plpgsql as $f$
declare t record; cols text; n bigint; r jsonb := '{}';
begin
  for t in select c.oid, c.relname from pg_class c join pg_namespace s on s.oid = c.relnamespace
           where s.nspname = 'devos_private' and c.relkind in ('r', 'p') order by c.relname loop
    select string_agg(quote_ident(attname), ', ' order by attnum) into cols from pg_attribute
     where attrelid = t.oid and attnum > 0 and not attisdropped and attname !~* '(hash|token)';
    continue when cols is null;
    execute format('select count(*) from devos_private.%I x where strpos(row(%s)::text, %L) > 0', t.relname, cols, p_id)
      into n;
    if n > 0 then r := r || jsonb_build_object(t.relname, n); end if;
  end loop;
  return r;
end $f$;

-- The p jsonb form of record_eval_run (README 8.1, interface v1), for one planted work item and revision.
create function pg_temp.n08_run_sql(p_work text, p_rev int, p_set text) returns text language sql as $f$
  select format('select to_jsonb(w07x) from devos_api.record_eval_run(%L::jsonb) as w07x limit 1', jsonb_build_object(
    'work_ref', p_work, 'work_revision', p_rev, 'eval_set_id', p_set, 'eval_set_version', 'w07_fixture_v1',
    'subject_role', 'w07_fixture_role', 'subject_release', 'w07_fixture_release', 'runner_session', 'w07_fixture_session',
    'results', jsonb_build_object('w07_fixture', 'SYNTHETIC W-C02-07'), 'run_at', now()))
$f$;

do $$
declare why text; api text := pg_temp.w07_cfg('api_role'); i jsonb; toks jsonb := '{}'; scrub text[] := '{}'; cls text;
        r jsonb; fw oid; sqlw text; wid text; mrid text; c record; ev regclass; evname text; n int; lst text;
        four text[] := array['devos_calisma', 'devos_denetim', 'devos_kurulum', 'devos_ci']; nread int := 0;
        pform boolean := false; eid text; rx jsonb; nm0 jsonb; nm1 jsonb; nmd jsonb; sqlr text; named boolean;
        plant text;
        rx1 jsonb; rx2 jsonb; wp4_1 int; wp4_2 int; wp4_err text;  -- N08-wp4 (N-301, 2026-10-19)
begin
  why := pg_temp.w07_pre_common();
  if why is null and to_regclass(pg_temp.w07_cfg('evalrun_table')) is null then why := pg_temp.w07_cfg('evalrun_table') || ' does not exist'; end if;
  if why is null and pg_temp.w07_fn('record_eval_run') is null then why := 'devos_api.record_eval_run does not exist'; end if;
  if why is not null then perform pg_temp.w07_cnc('N08-pre', why); return; end if;
  ev := pg_temp.w07_cfg('evalrun_table')::regclass;
  select relname into evname from pg_class where oid = ev;
  foreach cls in array four || 'devos_sinav'::text loop
    i := pg_temp.w07_issue(cls);
    if i ? 'why' then perform pg_temp.w07_cnc('N08-tokens', i->>'why'); return; end if;
    toks := toks || jsonb_build_object(cls, i->>'tok'); scrub := scrub || (i->>'tok');
  end loop;
  fw := pg_temp.w07_fn('record_eval_run'); sqlw := pg_temp.w07_sql_for(fw);
  pform := (select pronargs = 1 and proargnames[1] = 'p' and proargtypes[0] = 'jsonb'::regtype from pg_proc where oid = fw);
  -- Writing an exam record with the working, audit, installation and CI tokens is refused (B 3.15; EV-C02-003 §4.5).
  foreach cls in array four loop
    r := pg_temp.w07_call(api, pg_temp.w07_h(toks->>cls), sqlw, scrub);
    perform pg_temp.w07_put('N08-w-' || cls, pg_temp.w07_is_role_refusal(r, 'record_eval_run', cls),
      'record_eval_run with the ' || cls || ' token: ' || pg_temp.w07_says(r));
  end loop;
  -- The planted work item (N08-wp2's, moved here before the readers by the revision of 2026-10-19, N-301 (1)).
  begin
    wid := pg_temp.w07_plant(pg_temp.w07_cfg('work_table')::regclass);
    -- Revised under ledger rule 3, 2026-10-19, before any result (found in N-286's self-check): an EvalRun names a work
    -- item's revision (B 3.15: work_ref with its revision; W-C02-08's foreign key (work_ref, work_revision) to
    -- work_revision), and the planted work item had none, so no build could accept N08-wp2's exam run. The work item now
    -- gets its revision 1, under a planted Mission revision, each with the scope form the schema's CHECK asks.
    if to_regclass('devos_private.work_revision') is not null and to_regclass('devos_private.mission_revision') is not null then
      execute format('insert into devos_private.mission_revision (mission_id, revision, purpose, scope, acceptance, owner_authority) '
        || 'values (%L, 1, %L, %L, %L, %L) returning id::text', pg_temp.w07_plant('devos_private.mission'::regclass),
        'w07_fixture SYNTHETIC W-C02-07', 'synthetic.w07_fixture', 'w07_fixture SYNTHETIC W-C02-07',
        pg_temp.w07_plant('devos_private.decision'::regclass)) into mrid;
      execute format('insert into devos_private.work_revision (work_id, revision, mission_revision_id, scope, purpose, impact_class) '
        || 'values (%L, 1, %L, %L, %L, (enum_range(null::devos_private.impact_class))[1])', wid, mrid,
        'synthetic.w07_fixture', 'w07_fixture SYNTHETIC W-C02-07');
    end if;
  exception when others then
    wid := null;
    perform pg_temp.w07_cnc('N08-wp2', 'the work item fixture could not be planted: ' || sqlstate || ' ' || left(sqlerrm, 100));
  end;
  -- Revised under ledger rule 3, 2026-10-19 (N-301 (1)): the exam record the readers read. One EvalRun, written by
  -- record_eval_run with the exam token on the planted work item and kept (not undone) until the file's rollback, so
  -- that a reader whose parameter names an exam record reads a record that exists (EV-C02-013 2.8: an id that names no
  -- EvalRun is not_found). N08-s5 (k06; B 3.15: the link "lives only here") judges that write: the rows that name the
  -- work item's id, in any devos_private table, grow by one, in EvalRun's table, and nowhere else (no event payload,
  -- no other row carries the link).
  if wid is null or not pform then
    perform pg_temp.w07_cnc('N08-s5', 'no planted work item, or record_eval_run is not of the form p jsonb (README 8.1)');
  else
    nm0 := pg_temp.n08_naming(wid);
    begin
      perform set_config('request.headers', pg_temp.w07_h(toks->>'devos_sinav'), true);
      execute format('set local role %I', api);
      execute pg_temp.n08_run_sql(wid, 1, 'w07_fixture_eval_set_read') into rx;
      execute 'reset role';
      perform set_config('request.headers', '{}', true);
    exception when others then
      rx := jsonb_build_object('w07_raised', sqlstate);
    end;
    nm1 := pg_temp.n08_naming(wid);
    select coalesce(jsonb_object_agg(k, coalesce((nm1->>k)::bigint, 0) - coalesce((nm0->>k)::bigint, 0)), '{}') into nmd
      from (select jsonb_object_keys(nm0 || nm1) k) s
     where coalesce((nm1->>k)::bigint, 0) <> coalesce((nm0->>k)::bigint, 0);
    if strpos(coalesce(rx::text, ''), toks->>'devos_sinav') > 0 then
      rx := jsonb_build_object('w07_raised', 'the answer held a presented token value');
    end if;
    if rx->>'status' = 'ok' and rx->>'id' ~* '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$' then
      execute format('select id::text from %s where id::text = %L', ev, rx->>'id') into eid;
    end if;
    if eid is null then
      perform pg_temp.w07_cnc('N08-s5', 'the exam run that the readers read was not accepted: '
        || coalesce(rx->>'w07_raised', concat_ws(' ', rx->>'status', rx->>'reason_code', rx->>'reason')));
    else
      perform pg_temp.w07_put('N08-s5', nmd = jsonb_build_object(evname, 1),
        'exam run on the planted work item, exam token, accepted; rows naming the work item''s id, added by the call, '
        || 'by table: ' || nmd::text || ' (wanted {"' || evname || '": 1})');
    end if;
  end if;
  -- Reading: every devos_api function whose text reads the exam records' table refuses the same four tokens.
  -- Phase C4b (EV-C02-008 5.1, its list for T-W07-N08 after CHK-C02-027 D): nine functions are exempt by name, fixed
  -- before any result, and open_decision a tenth from 2026-10-19 (N-286), before any result. Each admits some of the
  -- four classes and reads the table only on the branch where the caller's class is devos_sinav (Rule O's sin limit,
  -- in open_decision for the work item work_ref names; set_effort_policy's kind (a); relate's own reason for sin; the
  -- exam record shown to sin by the two walks). Their answers to the four classes are part X's N08-x-<function>-<class> cases
  -- (w07_n08_exam_fact.sql); relate's refusal of an exam record as an end is T-W07-F04's F04-m4.
  select string_agg(p.proname, ', ' order by p.proname) into lst from pg_proc p join pg_namespace s on s.oid = p.pronamespace
   where s.nspname = 'devos_api' and p.prosrc ~* ('[[:<:]]' || evname || '[[:>:]]') and p.proname = any(pg_temp.n08_exempt());
  raise notice 'T-W07-N08: exempt by name (EV-C02-008 5.1), naming %: %', ev, coalesce(lst, 'none');
  for c in select p.oid, p.proname from pg_proc p join pg_namespace s on s.oid = p.pronamespace
           where s.nspname = 'devos_api' and p.oid <> fw and p.prosrc ~* ('[[:<:]]' || evname || '[[:>:]]')
             and p.proname <> 'competence_summary' and not p.proname = any(pg_temp.n08_exempt()) order by 2 loop
    nread := nread + 1;
    -- Revised under ledger rule 3, 2026-10-19 (N-301 (1)): a reader whose parameter names an exam record (a name that
    -- holds "eval" or "exam") is given the EvalRun written above, not a random uuid, in all five calls; the four
    -- refusals then refuse a record that exists. N08-rp asks more than before: accepted, and the answer carries the
    -- record read (its id). With no EvalRun to give, N08-rp of such a reader is could_not_check, never a pass.
    named := (select coalesce(bool_or(a ~* '(eval|exam)'), false) from pg_proc p, unnest(coalesce(p.proargnames, '{}')) a
               where p.oid = c.oid);
    sqlr := pg_temp.w07_sql_for(c.oid, case when named and eid is not null
                                            then jsonb_build_object('(eval|exam)', quote_literal(eid) || '::uuid')
                                            else '{}'::jsonb end);
    foreach cls in array four loop
      r := pg_temp.w07_call(api, pg_temp.w07_h(toks->>cls), sqlr, scrub);
      perform pg_temp.w07_put('N08-r-' || c.proname || '-' || cls, pg_temp.w07_is_role_refusal(r, c.proname, cls),
        c.proname || ' (reads the exam records) with the ' || cls || ' token'
        || case when named and eid is not null then ', on an existing EvalRun' else '' end || ': ' || pg_temp.w07_says(r));
    end loop;
    r := pg_temp.w07_call(api, pg_temp.w07_h(toks->>'devos_sinav'), sqlr, scrub);
    if named and eid is null then
      perform pg_temp.w07_cnc('N08-rp-' || c.proname, c.proname || ' names an exam record and no EvalRun was written to '
        || 'read (N08-s5): ' || pg_temp.w07_says(r));
    else
      perform pg_temp.w07_put('N08-rp-' || c.proname, pg_temp.w07_is_accepted(r, 'devos_sinav', false)
          and (not named or strpos(coalesce((r->'res')::text, ''), eid) > 0),
        c.proname || ' with the exam token is accepted' || case when named then ' and returns the EvalRun read' else '' end
        || ': ' || pg_temp.w07_says(r) || case when named then '; the answer names the EvalRun read: '
        || (strpos(coalesce((r->'res')::text, ''), eid) > 0)::text else '' end);
    end if;
  end loop;
  raise notice 'T-W07-N08: % devos_api functions other than record_eval_run read %', nread, ev;
  -- The exam fact lives only in the exam records (EV-C02-002 DM-24): no other table of devos_private names an exam or
  -- eval column or refers to the exam records' table.
  select string_agg(format('%s.%s', k.relname, a.attname), ', '), count(*) into lst, n
  from pg_attribute a join pg_class k on k.oid = a.attrelid join pg_namespace s on s.oid = k.relnamespace
  where s.nspname = 'devos_private' and k.relkind in ('r', 'p') and k.oid <> ev and a.attnum > 0 and not a.attisdropped
    and a.attname ~* '(exam|eval)' and k.relname !~* '(exam|eval)';
  perform pg_temp.w07_put('N08-s1', n = 0, 'columns naming an exam or eval outside the exam records: ' || coalesce(lst, 'none'));
  select string_agg(k.relname, ', '), count(*) into lst, n from pg_constraint f join pg_class k on k.oid = f.conrelid
  where f.contype = 'f' and f.confrelid = ev and f.conrelid <> ev and k.relname !~* '(exam|eval)';
  perform pg_temp.w07_put('N08-s2', n = 0, 'tables outside the exam records that refer to them: ' || coalesce(lst, 'none'));
  -- Positive: the exam environment writes (P1 at the gate; P2 on a planted work item), and the same call with the
  -- working token is refused.
  r := pg_temp.w07_call(api, pg_temp.w07_h(toks->>'devos_sinav'), sqlw, scrub);
  perform pg_temp.w07_put('N08-wp1', pg_temp.w07_passed_gate(r, 'record_eval_run'), 'record_eval_run, exam token, gate: ' || pg_temp.w07_says(r));
  -- (The work item is planted above, before the readers, since the revision of 2026-10-19, N-301 (1).)
  if wid is not null then
    -- Phase C4b: interface v1 (README 8.1) gives record_eval_run one parameter p jsonb with B 3.14's EvalRun fields, which
    -- the substitution by argument name below never reached; with that form the payload names the work item in work_ref.
    if pform then
      sqlw := pg_temp.n08_run_sql(wid, 1, 'w07_fixture_eval_set');
    else
      sqlw := pg_temp.w07_sql_for(fw, jsonb_build_object('work', quote_literal(wid)));
    end if;
    r := pg_temp.w07_call(api, pg_temp.w07_h(toks->>'devos_sinav'), sqlw, scrub);
    if pg_temp.w07_is_accepted(r, 'devos_sinav', true) then
      perform pg_temp.w07_put('N08-wp2', true, 'record_eval_run on a planted work item, exam token: accepted; ' || pg_temp.w07_says(r));
    else
      perform pg_temp.w07_cnc('N08-wp2', 'the exam run was not accepted; the arguments are revised before the first result '
        || '(README section 8): ' || pg_temp.w07_says(r));
    end if;
    r := pg_temp.w07_call(api, pg_temp.w07_h(toks->>'devos_calisma'), sqlw, scrub);
    perform pg_temp.w07_put('N08-w2-devos_calisma', pg_temp.w07_is_role_refusal(r, 'record_eval_run', 'devos_calisma'),
      'the same exam run with the working token: ' || pg_temp.w07_says(r));
    -- Added under ledger rule 3, 2026-10-19 (N-301; EV-C02-014 section 11, "the earlier revision accepted"). N08-wp3:
    -- B 3.15's work_ref names "+revision: the work item an exam task was opened as", and a subject's revision of its task
    -- is a new revision (EV-C02-008 1.7.1), so a run naming revision 1 of a work item whose current revision is 2 is
    -- accepted, with its event under devos_sinav. It differs from N08-wp2 in the planted revision 2 only; with N08-wp2
    -- not accepted, it is could_not_check (the arguments, not the rule).
    if pform and mrid is not null then
      plant := format('insert into devos_private.work_revision (work_id, revision, mission_revision_id, scope, purpose, '
        || 'impact_class) values (%L, 2, %L, %L, %L, (enum_range(null::devos_private.impact_class))[1])', wid, mrid,
        'synthetic.w07_fixture', 'w07_fixture SYNTHETIC W-C02-07 revised by its subject');
      r := pg_temp.w07_call(api, pg_temp.w07_h(toks->>'devos_sinav'), pg_temp.n08_run_sql(wid, 1, 'w07_fixture_eval_set_earlier'),
        scrub, '{}', plant);
      if r ? 'plant_error' then
        perform pg_temp.w07_cnc('N08-wp3', 'revision 2 could not be planted: ' || (r->>'plant_error'));
      elsif (select outcome from w07_results where case_id = 'N08-wp2') is distinct from 'ok' then
        perform pg_temp.w07_cnc('N08-wp3', 'N08-wp2 was not accepted, so a refusal here would not be the rule''s: '
          || pg_temp.w07_says(r));
      else
        perform pg_temp.w07_put('N08-wp3', pg_temp.w07_is_accepted(r, 'devos_sinav', true),
          'record_eval_run naming revision 1 while revision 2 is current, exam token: ' || pg_temp.w07_says(r));
      end if;
    else
      perform pg_temp.w07_cnc('N08-wp3', 'record_eval_run is not of the form p jsonb, or no Mission revision was planted');
    end if;
    -- Added under ledger rule 3, 2026-10-19 (N-301, the annotation of L-395: CHK-C02-102 C2), before N08's first result.
    -- N08-wp4: the EvalRun records the revision the call names (B 3.15's work_ref "+revision: the work item an exam task
    -- was opened as"; B principle 3). With revision 2 planted as the current one, a run naming revision 1 is written with
    -- work_revision 1, and a run naming revision 2 with 2; read as the owner inside an undone block. It asks of N08-wp3's
    -- call what N08-wp3 does not: the row written. With N08-wp2 not accepted, or either run not accepted, it is
    -- could_not_check (N08-wp3 judges the acceptance).
    if pform and mrid is not null then
      wp4_1 := null; wp4_2 := null; wp4_err := null; rx1 := null; rx2 := null;
      begin
        execute format('insert into devos_private.work_revision (work_id, revision, mission_revision_id, scope, purpose, '
          || 'impact_class) values (%L, 2, %L, %L, %L, (enum_range(null::devos_private.impact_class))[1])', wid, mrid,
          'synthetic.w07_fixture', 'w07_fixture SYNTHETIC W-C02-07 revised by its subject');
        perform set_config('request.headers', pg_temp.w07_h(toks->>'devos_sinav'), true);
        execute format('set local role %I', api);
        execute pg_temp.n08_run_sql(wid, 1, 'w07_fixture_eval_set_named_1') into rx1;
        execute pg_temp.n08_run_sql(wid, 2, 'w07_fixture_eval_set_named_2') into rx2;
        execute 'reset role';
        perform set_config('request.headers', '{}', true);
        if rx1->>'status' = 'ok' then
          execute format('select work_revision from %s where id::text = %L', ev, rx1->>'id') into wp4_1;
        end if;
        if rx2->>'status' = 'ok' then
          execute format('select work_revision from %s where id::text = %L', ev, rx2->>'id') into wp4_2;
        end if;
        raise exception using errcode = 'P0W07', message = 'w07: undo the case';
      exception
        when sqlstate 'P0W07' then null;
        when others then wp4_err := sqlstate || ' ' || left(sqlerrm, 120);
      end;
      if wp4_err is not null then
        perform pg_temp.w07_cnc('N08-wp4', 'the case could not be made: ' || wp4_err);
      elsif (select outcome from w07_results where case_id = 'N08-wp2') is distinct from 'ok' then
        perform pg_temp.w07_cnc('N08-wp4', 'N08-wp2 was not accepted, so the rows read here would not be the rule''s');
      elsif rx1->>'status' is distinct from 'ok' or rx2->>'status' is distinct from 'ok' then
        perform pg_temp.w07_cnc('N08-wp4', 'a run was not accepted (N08-wp3 judges the acceptance): naming 1: '
          || concat_ws(' ', rx1->>'status', rx1->>'reason_code') || '; naming 2: ' || concat_ws(' ', rx2->>'status', rx2->>'reason_code'));
      else
        perform pg_temp.w07_put('N08-wp4', wp4_1 = 1 and wp4_2 = 2,
          'revision 2 current; the EvalRun written for a run naming revision 1 records work_revision ' || coalesce(wp4_1::text, 'none')
          || ', for one naming revision 2, ' || coalesce(wp4_2::text, 'none') || ' (wanted 1 and 2)');
      end if;
    else
      perform pg_temp.w07_cnc('N08-wp4', 'record_eval_run is not of the form p jsonb, or no Mission revision was planted');
    end if;
    -- Added under ledger rule 3, 2026-10-19 (N-301; k21). N08-s6: EV-C02-008 5.1 (c) bound 3's second layer refuses to
    -- name a work item with an active claim of class devos_sinav. A claim on the work item whose role class is absent
    -- (planted by the owner, a state only a fault makes: the column's NOT NULL dropped for the plant) cannot be told the
    -- exam class's or not, so the run is not admitted as clean: refused could_not_check, recorded once under
    -- devos_sinav, no EvalRun row and no event (plan Section 8 item 14; W-C02-09 point 7).
    if pform then
      plant := format('alter table devos_private.assignment disable trigger user; '
        || 'alter table devos_private.assignment alter column role_class drop not null; '
        || 'insert into devos_private.assignment (work_ref, work_revision, role_class, claim_token_hash, generation, '
        || 'authority_epoch, lease_expires_at, status) values (%L, 1, null, %L, 1, 1, now() + interval ''30 minutes'', '
        || '''active'')', wid, md5(gen_random_uuid()::text) || md5(gen_random_uuid()::text));
      r := pg_temp.w07_call(api, pg_temp.w07_h(toks->>'devos_sinav'), pg_temp.n08_run_sql(wid, 1, 'w07_fixture_eval_set_partial'),
        scrub, '{}', plant);
      if r ? 'plant_error' then
        perform pg_temp.w07_cnc('N08-s6', 'the partial claim could not be planted: ' || (r->>'plant_error'));
      else
        perform pg_temp.w07_put('N08-s6', r->>'err' is null and pg_temp.w07_code(r) = 'could_not_check'
            and (r->'ra'->>'record_eval_run|could_not_check|devos_sinav')::numeric = 1
            and (select count(*) from jsonb_object_keys(r->'ra')) = 1
            and r->'events' = '[]'::jsonb and r->'changed' = '[]'::jsonb and not (r->'echo')::boolean,
          'record_eval_run on a work item whose claim lacks its role class, exam token: ' || pg_temp.w07_says(r));
      end if;
    else
      perform pg_temp.w07_cnc('N08-s6', 'record_eval_run is not of the form p jsonb (README 8.1)');
    end if;
  else
    perform pg_temp.w07_cnc('N08-wp3', 'no planted work item');
    perform pg_temp.w07_cnc('N08-wp4', 'no planted work item');
    perform pg_temp.w07_cnc('N08-s6', 'no planted work item');
  end if;
  toks := null; scrub := null;
end $$;

select case_id, outcome, detail from w07_results order by case_id;

do $$
declare nb int; nc int; n int;
begin
  select count(*) filter (where outcome = 'bad'), count(*) filter (where outcome = 'could_not_check'), count(*)
    into nb, nc, n from w07_results;
  if nb > 0 then
    raise exception 'W07_N08_EXAM_RECORDS FAIL (% bad, % could not check, of %)', nb, nc, n;
  elsif nc > 0 or n = 0 then
    raise exception 'W07_N08_EXAM_RECORDS COULD NOT CHECK (% of % could not be checked)', nc, n;
  end if;
  raise notice 'W07_N08_EXAM_RECORDS PASS (%/%)', n, n;
end $$;

rollback;
