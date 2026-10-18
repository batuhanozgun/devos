-- Synthetic test data (plan Section 8 item 13): the work items, relations and tokens made here are made up inside
-- this transaction (text 'w07_fixture SYNTHETIC W-C02-07', scope 'synthetic.w07fixture', declared session id
-- 'w07_fixture_declared_session'); no personal or business data; tokens are kept in PL/pgSQL variables only.
-- Nothing is committed.
--
-- Claim (Appendix C F06 as PC-42 place 37 words it; B principle 2 and 3.13; EV-C02-002 DM-31, DM-36; W-C02-09
-- point 5): every state-changing function writes its event in the same transaction, with role_class from the token
-- (owner for the owner-only functions), never declared; a function marked devos:read changes no table but
-- RejectedAttempt, on accepted and on refused calls; an error mid-transaction leaves no half state and no orphan
-- event; an exact repeat writes no new event and raises no error. The function list is read from the catalogue at
-- run time: every devos_api function, and devos_private.issue_env_token and revoke_env_token.
-- Specification: tests/C02/W-C02-07/T-W07-F06_state_change_event.md. Serves W-C02-09 points 5 and 8.
-- Runs: in devos-test by the migration job's test step as postgres, calls as anon with the header simulated
-- (sql-set-role); with its break on the throwaway database. Safety: no psql meta-command; stops at its first error.
-- Revised under ledger rule 3, 2026-10-18 (N-283; CHK-C02-086 C1 (b) and C4), before any result of this file:
-- revise_mission's recipe sends a reason; recipes for the read functions with required arguments; see the
-- specification's "Revision under ledger rule 3 (N-283)".
begin;
set local search_path = pg_catalog, pg_temp;
set local statement_timeout = '300s';
-- Common helpers (Group B of W-C02-07; copied into each file, since no file includes another: README 5.1 (a), 7).
-- w07_call calls a devos_api function the way the Data API calls a remote procedure: JSON keys bound to parameters
-- by name (a key k binds a parameter named k or p_k), as the role the publishable key reaches (anon), with the token
-- header simulated in request.headers (README 5.1 (a): transport sql-set-role). A call that cannot be formed (no such
-- function, a key without a parameter, a required parameter without a value) is reported under "interface", never
-- as a refusal. Tokens live only in PL/pgSQL variables; a token value found in a result or error is replaced before
-- anything is stored, and the call is flagged.
create temp table w07_results (case_id text primary key,
  outcome text not null check (outcome in ('ok', 'bad', 'could_not_check')), detail text not null);

create function pg_temp.w07_rec(p_id text, p_outcome text, p_detail text) returns void language sql as $f$
  insert into w07_results values (p_id, p_outcome, left(replace(coalesce(p_detail, ''), chr(10), ' '), 600))
  on conflict (case_id) do update set
    outcome = case when w07_results.outcome = 'bad' or excluded.outcome = 'bad' then 'bad'
                   when w07_results.outcome = 'could_not_check' or excluded.outcome = 'could_not_check'
                   then 'could_not_check' else 'ok' end,
    detail = left(w07_results.detail || ' | ' || excluded.detail, 1200)
$f$;

-- ok when p_cond is true, bad when false, could_not_check when null.
create function pg_temp.w07_check(p_id text, p_cond boolean, p_detail text) returns void language sql as $f$
  select pg_temp.w07_rec(p_id, case when p_cond then 'ok' when not p_cond then 'bad' else 'could_not_check' end,
                         p_detail)
$f$;

create function pg_temp.w07_call(p_fn text, p_args jsonb, p_token text, p_role text default 'anon',
                                 p_fill_null boolean default false) returns jsonb language plpgsql as $f$
declare
  n_over int; anames text[]; amodes "char"[]; atypes oid[]; nin int; ndef int; rset boolean; rtype oid;
  innames text[]; i int; k text; v jsonb; parts text[] := '{}'; used text[] := '{}'; q text; typ text;
  r jsonb; err text; t0 timestamptz; orig text := current_user; echoed boolean := false;
begin
  select count(*) into n_over from pg_proc p join pg_namespace n on n.oid = p.pronamespace
   where n.nspname = 'devos_api' and p.proname = p_fn;
  if n_over <> 1 then
    return jsonb_build_object('interface', format('devos_api.%s: %s definitions', p_fn, n_over));
  end if;
  select p.proargnames, p.proargmodes, array(select unnest(p.proargtypes)), p.pronargs, p.pronargdefaults,
         p.proretset, p.prorettype
    into anames, amodes, atypes, nin, ndef, rset, rtype
    from pg_proc p join pg_namespace n on n.oid = p.pronamespace where n.nspname = 'devos_api' and p.proname = p_fn;
  if amodes is null then
    innames := array(select anames[o] from generate_series(1, nin) o);
  else
    innames := array(select anames[o] from generate_subscripts(amodes, 1) o where amodes[o] in ('i', 'b', 'v') order by o);
  end if;
  for i in 1 .. nin loop
    k := null;
    if innames[i] is not null then
      if coalesce(p_args, '{}') ? innames[i] then k := innames[i];
      elsif innames[i] = 'p' and atypes[i] = 3802 then k := '*';  -- interface v1: a record's fields in p jsonb
      end if;
    end if;
    typ := format_type(atypes[i], null);
    if k = '*' then
      v := coalesce(p_args, '{}') - array_remove(innames, null); used := used || array(select jsonb_object_keys(v));
      parts := parts || format('%I => %L::jsonb', innames[i], v::text);
    elsif k is not null then
      v := p_args -> k; used := used || k;
      if k = 'claim_token' and jsonb_typeof(v) = 'string' then  -- phase C3: never inlined in the statement's text
        perform set_config('w07.ct', v #>> '{}', true);
        parts := parts || format('%I => current_setting(%L)::%s', innames[i], 'w07.ct', typ);
      elsif jsonb_typeof(v) = 'null' then parts := parts || format('%I => null::%s', innames[i], typ);
      elsif atypes[i] in (114, 3802) then parts := parts || format('%I => %L::%s', innames[i], v::text, typ);
      elsif jsonb_typeof(v) = 'array' then
        parts := parts || format('%I => array(select jsonb_array_elements_text(%L::jsonb))::%s', innames[i], v::text, typ);
      else parts := parts || format('%I => %L::%s', innames[i], v #>> '{}', typ);
      end if;
    elsif i > nin - ndef then null;
    elsif p_fill_null and innames[i] is not null then parts := parts || format('%I => null::%s', innames[i], typ);
    else
      return jsonb_build_object('interface', format('devos_api.%s: parameter %s has no value', p_fn,
                                                    coalesce(innames[i], '$' || i)));
    end if;
  end loop;
  select x into k from jsonb_object_keys(coalesce(p_args, '{}')) x where not x = any(used) limit 1;
  if k is not null then
    return jsonb_build_object('interface', format('devos_api.%s: no parameter for key %s', p_fn, k));
  end if;
  if not exists (select 1 from pg_roles where rolname = p_role) or not pg_has_role(current_user, p_role, 'MEMBER') then
    return jsonb_build_object('interface', format('cannot act as role %s', p_role));
  end if;
  if rset then
    q := format('select coalesce(jsonb_agg(to_jsonb(w07_r)), ''[]''::jsonb) from devos_api.%I(%s) w07_r', p_fn,
                array_to_string(parts, ', '));
  elsif rtype = 2278 then
    q := format('select null::jsonb from (select devos_api.%I(%s)) w07_s', p_fn, array_to_string(parts, ', '));
  else
    q := format('select to_jsonb(devos_api.%I(%s))', p_fn, array_to_string(parts, ', '));
  end if;
  perform set_config('request.headers', case when p_token is null then '{}'
                     else json_build_object('x-devos-env-token', p_token)::text end, true);
  t0 := clock_timestamp();
  begin
    execute format('set local role %I', p_role);
    execute q into r;
    execute format('set local role %I', orig);
  exception when others then
    err := sqlstate || ' ' || left(sqlerrm, 200);
  end;
  perform set_config('request.headers', '', true);
  perform set_config('w07.ct', '', true);
  if coalesce(jsonb_typeof(p_args->'claim_token'), '') = 'string' and length(p_args->>'claim_token') > 0
     and (position(p_args->>'claim_token' in coalesce(err, '')) > 0 or position(p_args->>'claim_token' in coalesce(r::text, '')) > 0) then
    echoed := true;  -- phase C3: a presented claim token is withheld like an environment token
    err := replace(err, p_args->>'claim_token', '[a claim token]');
    r := replace(r::text, p_args->>'claim_token', '[a claim token]')::jsonb;
  end if;
  if p_token is not null and length(p_token) > 0 then
    if position(p_token in coalesce(err, '')) > 0 or position(p_token in coalesce(r::text, '')) > 0 then
      echoed := true;
      err := replace(err, p_token, '[a token value]');
      r := replace(r::text, p_token, '[a token value]')::jsonb;
    end if;
  end if;
  return jsonb_build_object('result', r, 'error', err, 'echoed', echoed,
                            'ms', round(extract(epoch from clock_timestamp() - t0) * 1000));
end $f$;

-- A call is refused when it raised (a privilege refusing a direct write raises), or returned status refused
-- (interface v1, README section 8; DM-19: a function returns its refusal, which T-W07-DM19 checks).
create function pg_temp.w07_refused(c jsonb) returns boolean language sql as $f$
  select coalesce(not (c ? 'interface') and (c->>'error' is not null
      or (coalesce(jsonb_typeof(c->'result'), '') = 'object' and (
            c->'result'->>'status' = 'refused'))), false)  -- interface v1 (README section 8)
$f$;

create function pg_temp.w07_show(c jsonb) returns text language sql as $f$
  select case when c ? 'interface' then 'interface: ' || (c->>'interface')
              else coalesce('raised ' || (c->>'error'), 'returned ' || left(coalesce(case when jsonb_typeof(c->'result') = 'object'
                   then ((c->'result') - 'claim_token' - 'token')::text else c->>'result' end, 'null'), 200))
                   || case when (c->>'echoed')::boolean then ' [A TOKEN VALUE WAS ECHOED]' else '' end end
$f$;

-- Row count and content hash of every devos_private table (env_tokens: count only, so nothing derived from a
-- token is computed). The hashes are compared, never printed.
create function pg_temp.w07_snap() returns jsonb language plpgsql as $f$
declare t record; j jsonb := '{}'; c bigint; h text;
begin
  for t in select cl.oid::regclass::text as rel, cl.relname from pg_class cl join pg_namespace n on n.oid = cl.relnamespace
           where n.nspname = 'devos_private' and cl.relkind in ('r', 'p') order by cl.relname loop
    if t.relname = 'env_tokens' then
      execute format('select count(*) from %s', t.rel) into c; h := '';
    else
      execute format('select count(*), coalesce(md5(string_agg(x::text, ''|'' order by x::text)), '''') from %s x',
                     t.rel) into c, h;
    end if;
    j := j || jsonb_build_object(t.relname, jsonb_build_array(c, h));
  end loop;
  return j;
end $f$;

create function pg_temp.w07_changed(a jsonb, b jsonb, p_except text[] default '{}') returns text[] language sql as $f$
  select coalesce(array_agg(k order by k), '{}') from jsonb_object_keys(a || b) k
   where a->k is distinct from b->k and not k = any(p_except)
$f$;

create function pg_temp.w07_ids(p_table text) returns text[] language plpgsql as $f$
declare a text[];
begin
  execute format('select coalesce(array_agg(id::text), ''{}'') from %s', p_table) into a;
  return a;
end $f$;

-- Plants one row as the owner (README 5.1 (a), "Fixtures"): the columns in p_vals take those values; every other
-- NOT NULL column without a default gets a synthetic value by its type, and a NOT NULL single-column foreign key a
-- newly planted parent row. Raises when it cannot; callers turn that into could_not_check.
create function pg_temp.w07_plant(p_table text, p_vals jsonb default '{}', p_depth int default 0)
returns jsonb language plpgsql as $f$
declare rel regclass := to_regclass(p_table); a record; j jsonb := coalesce(p_vals, '{}'); fk record;
        parent jsonb; cols text; r jsonb;
begin
  if rel is null then raise exception 'w07 plant: % does not exist', p_table; end if;
  for a in select att.attname, att.attnum, att.atttypid, t.typtype, t.typcategory, t.typname
             from pg_attribute att join pg_type t on t.oid = att.atttypid
            where att.attrelid = rel and att.attnum > 0 and not att.attisdropped and att.attnotnull
              and not att.atthasdef and att.attidentity = '' and att.attgenerated = '' order by att.attnum loop
    continue when j ? a.attname;
    select con.confrelid::regclass::text as ptab,
           (select pa.attname from pg_attribute pa where pa.attrelid = con.confrelid and pa.attnum = con.confkey[1]) as pcol
      into fk from pg_constraint con
     where con.conrelid = rel and con.contype = 'f' and con.conkey = array[a.attnum]::smallint[] limit 1;
    if fk.ptab is not null then
      if p_depth >= 4 then raise exception 'w07 plant: foreign keys nest deeper than 4 from %', p_table; end if;
      parent := pg_temp.w07_plant(fk.ptab, '{}', p_depth + 1);
      j := j || jsonb_build_object(a.attname, parent -> fk.pcol);
      continue;
    end if;
    j := j || jsonb_build_object(a.attname, case
      when a.typtype = 'e' then to_jsonb((select e.enumlabel from pg_enum e where e.enumtypid = a.atttypid
                                          order by e.enumsortorder limit 1))
      when a.typname = 'uuid' then to_jsonb(gen_random_uuid())
      when a.typname in ('text', 'varchar', 'bpchar', 'name', 'citext') then
        to_jsonb(case when a.attname like '%scope%' then 'synthetic.w07fixture' else 'w07_fixture SYNTHETIC W-C02-07' end)
      when a.typcategory = 'N' then to_jsonb(1)
      when a.typname = 'bool' then to_jsonb(false)
      when a.typname in ('timestamptz', 'timestamp') then to_jsonb(now())
      when a.typname = 'date' then to_jsonb(current_date)
      when a.typname in ('json', 'jsonb') then case when a.attname ~ '(s|refs|spans)$' then '[]'::jsonb else '{}'::jsonb end
      when a.typcategory = 'A' then '[]'::jsonb
      else null end);
    if j -> a.attname is null or jsonb_typeof(j -> a.attname) = 'null' then
      raise exception 'w07 plant: no synthetic value for %.% of type %', p_table, a.attname, a.typname;
    end if;
  end loop;
  select string_agg(quote_ident(x), ', ') into cols from jsonb_object_keys(j) x;
  if cols is null then
    execute format('insert into %s as w07_x default values returning to_jsonb(w07_x)', rel) into r;
    return r;
  end if;
  execute format('insert into %s as w07_x (%s) select %s from jsonb_populate_record(null::%s, $1) returning to_jsonb(w07_x)',
                 rel, cols, cols, rel) using j into r;
  return r;
end $f$;

-- Issues a synthetic token as the owner, inside this rolled-back transaction (EV-C02-003 §6.3).
create function pg_temp.w07_token(p_class text) returns text language plpgsql as $f$
declare t text;
begin
  execute 'select devos_private.issue_env_token($1)::text' using p_class into t;
  if t like '{%' then t := t::jsonb ->> 'token'; end if;
  return t;
end $f$;

-- RejectedAttempt rows of one function (its name with or without the schema), as written since p_after.
create function pg_temp.w07_ra(p_fn text, p_after text[] default '{}') returns jsonb language plpgsql as $f$
declare r jsonb;
begin
  execute 'select coalesce(jsonb_agg(to_jsonb(x) - ''id''), ''[]'') from devos_private.rejected_attempt x
            where x.function_name in ($1, ''devos_api.'' || $1) and not x.id::text = any($2)'
     using p_fn, p_after into r;
  return r;
end $f$;

-- Revocation by the env_tokens row ID (README section 8, interface v1): mark the rows present, then revoke, as owner,
-- each row issued since the mark. Row IDs are not secret; no token, hash or part of one is read or kept.
create function pg_temp.w07_token_mark() returns void language plpgsql as $f$
begin
  create temp table if not exists w07_token_marked (id text);
  delete from w07_token_marked;
  execute 'insert into w07_token_marked select id::text from devos_private.env_tokens';
end $f$;

create function pg_temp.w07_revoke_since_mark() returns int language plpgsql as $f$
declare i text; n int := 0;
begin
  for i in execute 'select id::text from devos_private.env_tokens where id::text not in (select id from w07_token_marked)'
  loop
    execute format('select devos_private.revoke_env_token(%L)', i);
    n := n + 1;
  end loop;
  return n;
end $f$;

create function pg_temp.w07_pre() returns text language plpgsql as $f$
begin
  if to_regprocedure('devos_private.issue_env_token(text)') is null or not exists (select 1 from pg_proc p
       join pg_namespace n on n.oid = p.pronamespace where n.nspname = 'devos_private' and p.proname = 'revoke_env_token') then
    return 'devos_private.issue_env_token(text) or revoke_env_token does not exist';
  end if;
  if to_regclass('devos_private.event') is null or to_regclass('devos_private.rejected_attempt') is null then
    return 'devos_private.event or devos_private.rejected_attempt does not exist';
  end if;
  if (select count(*) from information_schema.columns where table_schema = 'devos_private' and table_name = 'event'
        and column_name in ('role_class', 'origin', 'tx_id')) <> 3 then
    return 'devos_private.event lacks role_class, origin or tx_id';
  end if;
  if not exists (select 1 from pg_proc p join pg_namespace n on n.oid = p.pronamespace where n.nspname = 'devos_api') then
    return 'devos_api has no function';
  end if;
  return null;
end $f$;

create function pg_temp.w07_fail_trg() returns trigger language plpgsql as $f$
begin
  raise exception 'w07 planted failure (synthetic) on %', tg_table_name;
end $f$;

-- Events written since p_before: their role classes, origins and whether their tx_id is this transaction's.
create function pg_temp.w07_new_events(p_before text[]) returns jsonb language plpgsql as $f$
declare r jsonb;
begin
  execute 'select coalesce(jsonb_agg(jsonb_build_object(''role_class'', role_class::text, ''origin'', origin::text,
             ''this_tx'', tx_id::text in (txid_current()::text, (txid_current() % 4294967296)::text))), ''[]'')
           from devos_private.event where not id::text = any($1)' using p_before into r;
  return r;
end $f$;

-- One call measured: the call, the tables changed besides event and rejected_attempt, and the new events.
create function pg_temp.w07_measure(p_fn text, p_args jsonb, p_tok text, p_fill boolean default false) returns jsonb
language plpgsql as $f$
declare s0 jsonb; s1 jsonb; e0 text[]; c jsonb;
begin
  s0 := pg_temp.w07_snap(); e0 := pg_temp.w07_ids('devos_private.event');
  c := pg_temp.w07_call(p_fn, p_args, p_tok, 'anon', p_fill);
  s1 := pg_temp.w07_snap();
  return jsonb_build_object('call', c, 'changed', to_jsonb(pg_temp.w07_changed(s0, s1, array['event', 'rejected_attempt'])),
                            'events', pg_temp.w07_new_events(e0));
end $f$;

-- G20 (revised before any result: EV-C02-013 sections 2.2, 2.8 and 3, 2026-10-17). S1's transfer_source, with
-- synthetic commit and hash strings made from md5 at run time.
create function pg_temp.f06_src(p_kind text, p_sid text) returns jsonb language sql as $f$
  select jsonb_build_object('kind', p_kind, 'source_id', p_sid, 'path', 'w07_fixture/' || p_sid || '.md',
    'input_commit', left(md5('w07 f06 input') || md5('w07 f06 input 2'), 40), 'last_commit', left(md5('w07 f06 last ' || p_sid) || md5(p_sid), 40),
    'sha256', md5('w07 f06 text ' || p_sid) || md5('w07 f06 text 2 ' || p_sid))
$f$;
create function pg_temp.f06_run_args(p_run text) returns jsonb language sql as $f$
  select jsonb_build_object('run_id', p_run, 'input_commit', left(md5('w07 f06 input') || md5('w07 f06 input 2'), 40),
    'manifest_sha256', md5('w07 f06 manifest ' || p_run) || md5(p_run), 'counts', '{}'::jsonb, 'phase', 'begun', 'mode', 'ahead')
$f$;
-- A late fill, at the call: the installation's Mission (the one whose creation event is transferred, EV-C02-013
-- section 4) exists only once transfer_mission's own recipe has run, so the recipes that name it (transfer_work,
-- transfer_need) or a Work under it (record_ledger_entry's stage Work, made here by transfer_work; transfer_acceptance's
-- target Work and its Review copy, EV-C02-013 R2-2) are completed just before their call. If it cannot be done, the arguments stay as they are and the build's refusal makes the case
-- could_not_check with its reason.
create function pg_temp.f06_late(p_what text, p_args jsonb, p_tok text) returns jsonb language plpgsql as $f$
declare m text; n int; x jsonb; y jsonb;
begin
  execute 'select m.id::text from devos_private.mission m where exists (select 1 from devos_private.event e
             where e.aggregate_id = m.id and e.event_type::text = ''transferred'') order by m.created_at limit 1' into m;
  if m is null then return p_args; end if;
  execute 'select max(r.revision) from devos_private.mission_revision r where r.mission_id::text = $1' into n using m;
  if p_what = 'mission' then return p_args || jsonb_build_object('mission_ref', m, 'mission_revision', n); end if;
  if p_what = 'acceptance' then
    -- Revised before any result (EV-C02-013 R2-2, 2026-10-18): transfer_acceptance's target must be an installation
    -- record, so its Work is written with transfer_work under the installation's Mission, and its Review copy with
    -- transfer_review naming that Work; the Acceptance names both. Either write refused: the arguments are returned
    -- unchanged (no target_ref, review_ref or current_evidence), and the case gives could_not_check.
    x := pg_temp.w07_call('transfer_work', jsonb_build_object('run_id', 'w07_fixture_run_f06_open',
           'transfer_source', pg_temp.f06_src('work', 'W07-FIXTURE-F06-ACC-W'), 'mission_ref', m, 'mission_revision', n,
           'scope', 'installation', 'purpose', 'w07_fixture SYNTHETIC W-C02-07 accepted work item', 'impact_class', 'high',
           'execution', 'planned', 'acceptance', 'proposed', 'effort_policy', jsonb_build_object('level', 'high',
           'expert_assessment_ref', 'w07_fixture/expert_assessment', 'non_removable_steps', '["verification"]'::jsonb)), p_tok);
    if x->'result'->>'status' is distinct from 'ok' then return p_args; end if;
    y := pg_temp.w07_call('transfer_review', jsonb_build_object('run_id', 'w07_fixture_run_f06_open', 'kind', 'review',
           'claim', 'w07_fixture SYNTHETIC W-C02-07 verdict copy', 'target_ref', x->'result'->'id', 'criterion', 'w07_fixture/criterion',
           'basis_refs', '["w07_fixture_tree"]'::jsonb, 'reviewer_declared_session', 'w07_fixture_checker_run SYNTHETIC',
           'independence_level', 'fresh_context_subagent', 'use', 'installation_acceptance', 'verdict', jsonb_build_object('result', 'pass',
           'objections', '[]'::jsonb, 'evidence_refs', '[]'::jsonb, 'limits', '[]'::jsonb),
           'transfer_source', pg_temp.f06_src('verdict', 'W07-FIXTURE-F06-ACC-RV')), p_tok);
    if y->'result'->>'status' is distinct from 'ok' then return p_args; end if;
    return p_args || jsonb_build_object('target_ref', x->'result'->'id', 'review_ref', y->'result'->'id',
                                        'current_evidence', jsonb_build_array(y->'result'->'id'));
  end if;
  x := pg_temp.w07_call('transfer_work', jsonb_build_object('run_id', 'w07_fixture_run_f06_open',
         'transfer_source', pg_temp.f06_src('work', 'W07-FIXTURE-F06-STAGE'), 'mission_ref', m, 'mission_revision', n,
         'scope', 'installation', 'purpose', 'w07_fixture SYNTHETIC W-C02-07 stage work item', 'impact_class', 'high',
         'execution', 'planned', 'acceptance', 'proposed', 'effort_policy', jsonb_build_object('level', 'high',
         'expert_assessment_ref', 'w07_fixture/expert_assessment', 'non_removable_steps', '["verification"]'::jsonb)), p_tok);
  if x->'result'->>'status' is distinct from 'ok' then return p_args; end if;
  return p_args || jsonb_build_object('stage_work_id', x->'result'->'id');
end $f$;

do $$
declare why text; f record; toks jsonb := '{}'; cls text; tok text; m jsonb; m2 jsonb; a jsonb; b jsonb; d jsonb; rel jsonb;
        recipes jsonb; e0 text[]; v jsonb; fd jsonb; ev jsonb; t_x text; ok boolean; n_listed int;
        classes text[] := array['devos_calisma', 'devos_denetim', 'devos_sinav', 'devos_kurulum', 'devos_ci', 'devos_backup'];
        t_cal text; t_kur text;
        t_den text; d2 jsonb; mr jsonb; wk jsonb; cl jsonb; op jsonb; x jsonb; fn text; ct text;  -- phase C3
        fx_fail jsonb := '{}'; unformable jsonb; no_repeat jsonb;
        nm jsonb; wt1 jsonb; wt2 jsonb; tdd text; ev_id text; dl jsonb; dl2 jsonb; event_state text[];  -- G20
begin
  why := pg_temp.w07_pre();
  if why is not null then
    perform pg_temp.w07_rec('F06-pre', 'could_not_check', why);
    return;
  end if;
  begin
    t_cal := pg_temp.w07_token('devos_calisma'); t_kur := pg_temp.w07_token('devos_kurulum');
    a := pg_temp.w07_plant('devos_private.work_revision', '{}'); b := pg_temp.w07_plant('devos_private.work_revision', '{}');
    d := pg_temp.w07_plant('devos_private.work_revision', '{}');
    v := pg_temp.w07_plant('devos_private.verdict', jsonb_build_object('result', 'pass', 'review_ref',
      pg_temp.w07_plant('devos_private.review', jsonb_build_object('kind', 'review', 'target_ref', gen_random_uuid(),
        'target_revision', 1, 'use', 'w07_fixture_use_one', 'basis_refs', '[]'::jsonb))->'id'));
    fd := pg_temp.w07_plant('devos_private.finding', '{"status": "candidate", "scope": "synthetic.w07fixture"}');
    perform pg_temp.w07_plant('devos_private.finding_revision', jsonb_build_object('finding_id', fd->'id', 'revision', 1,
      'claim', 'w07_fixture SYNTHETIC W-C02-07 claim', 'changeable', 'no', 'source_spans', '[]'::jsonb,
      'counter_evidence_searched', 'w07_fixture SYNTHETIC: none found'));
    -- D-2 (EV-C02-013 section 5): record_need's mission_ref is required (need.mission_ref NOT NULL; B 3.2): a planted
    -- Mission, active by default.
    nm := pg_temp.w07_plant('devos_private.mission_revision', '{}');
  exception when others then
    perform pg_temp.w07_rec('F06-pre', 'could_not_check', 'fixtures could not be made: ' || sqlstate || ' ' || left(sqlerrm, 200));
    return;
  end;
  rel := jsonb_build_object('type', 'about', 'from_ref', a->'work_id', 'from_revision', a->'revision', 'to_ref', b->'work_id',
    'to_revision', b->'revision', 'scope', 'synthetic.w07fixture', 'hard', false, 'method', 'recorded', 'epistemic_status', 'inference');
  -- Recipes: an accepted call per state-changing function, with the role class whose token makes it. A function of
  -- the extracted list without a recipe gives could_not_check for its accepted-call case, never a pass (the
  -- specification, "Could not check").
  recipes := jsonb_build_object(
    'relate', jsonb_build_object('class', 'devos_calisma', 'args', rel),
    'accept', jsonb_build_object('class', 'devos_denetim', 'args', jsonb_build_object('verdict_ref', v->'id', 'accepted_use', 'w07_fixture_use_one')),
    'review_finding', jsonb_build_object('class', 'devos_denetim', 'args', jsonb_build_object('finding_id', fd->'id', 'revision', 1, 'status', 'reviewed')),
    'affected_entities', jsonb_build_object('class', 'devos_calisma', 'args', jsonb_build_object('root', a->'work_id', 'limits', '{}'::jsonb)),
    'explain_paths', jsonb_build_object('class', 'devos_calisma', 'args', jsonb_build_object('root', a->'work_id', 'target', b->'work_id', 'limits', '{}'::jsonb)))
    -- Phase C: recipes for the functions whose arguments README section 8.1 fixes and whose inputs this file plants.
    -- A recipe the build refuses gives could_not_check (below), never bad: it shows nothing about the event rule.
    || jsonb_build_object(
    'claim', jsonb_build_object('class', 'devos_calisma', 'args', jsonb_build_object('work_id', d->'work_id',
      'declared_session_id', 'w07_fixture_session_f06')),
    'revise_work', jsonb_build_object('class', 'devos_calisma', 'args', jsonb_build_object('id', b->'work_id',
      'base_revision', b->'revision', 'scope', 'synthetic.w07fixture', 'reason', 'w07_fixture SYNTHETIC W-C02-07 revision')),
    'record_need', jsonb_build_object('class', 'devos_calisma', 'args', jsonb_build_object('mission_ref', nm->'mission_id',
      'condition', 'w07_fixture SYNTHETIC W-C02-07 condition', 'why_needed', 'w07_fixture SYNTHETIC W-C02-07: F06 needs one accepted need')),
    'open_decision', jsonb_build_object('class', 'devos_calisma', 'args', jsonb_build_object('class', 'routine',
      'question', 'w07_fixture SYNTHETIC W-C02-07 routine question')),
    'record_finding', jsonb_build_object('class', 'devos_calisma', 'args', jsonb_build_object('claim', 'w07_fixture SYNTHETIC W-C02-07 claim',
      'scope', 'synthetic.w07fixture', 'changeable', 'no', 'source_spans', '[]'::jsonb,
      'counter_evidence_searched', 'w07_fixture SYNTHETIC: none found', 'epistemic_status', 'observation',
      'current_authority', 'information_only')),
    'open_review', jsonb_build_object('class', 'devos_denetim', 'args', jsonb_build_object('kind', 'review', 'target_ref', a->'work_id',
      'target_revision', a->'revision', 'use', 'w07_fixture_use_f06', 'basis_refs', '[]'::jsonb)));

  -- Phase C3 (G5): a recipe for every other state-changing C02 function Appendix B section 4 names whose call README
  -- section 8.1 lets this file form (its argument names are 8.1's, fixed or chosen). Each recipe's fixture is made in
  -- its own block; one that cannot be made drops only its recipe, whose case then gives could_not_check with the
  -- reason. These recipes were run on no stub of these functions; a recipe the build refuses gives could_not_check.
  t_den := pg_temp.w07_token('devos_denetim');
  begin  -- open_mission, revise_mission, admit_work: a planted answered batu Decision (B 3.1) and a planted Mission
    -- Revised before any result (EV-C02-013 R2-7, 2026-10-18): answered_revision 1, the revision answered (DM-11 (a)).
    d2 := pg_temp.w07_plant('devos_private.decision', '{"class": "batu", "status": "answered", "answered_revision": 1}');
    if to_regclass('devos_private.decision_revision') is not null then
      perform pg_temp.w07_plant('devos_private.decision_revision', jsonb_build_object('decision_id', d2->'id', 'revision', 1));
    end if;
    mr := pg_temp.w07_plant('devos_private.mission_revision', '{}');
    recipes := recipes || jsonb_build_object(
      'open_mission', jsonb_build_object('class', 'devos_kurulum', 'args', jsonb_build_object(
        'purpose', 'w07_fixture SYNTHETIC W-C02-07 mission; not work', 'scope', 'synthetic.w07fixture',
        'owner_authority', d2->'id', 'owner_authority_revision', 1,
        'acceptance', 'w07_fixture SYNTHETIC W-C02-07', 'constraints', '[]'::jsonb)),
      -- Revised under ledger rule 3, before any result (N-283; CHK-C02-086 C1 (b); 2026-10-18): a new revision carries
      -- a reason (Appendix B principle 3; EV-C02-013 2.2 stars revise_mission's reason), as revise_work's recipe sends one.
      'revise_mission', jsonb_build_object('class', 'devos_kurulum', 'args', jsonb_build_object(
        'id', mr->'mission_id', 'base_revision', mr->'revision', 'purpose', 'w07_fixture SYNTHETIC W-C02-07 mission, revised',
        'scope', 'synthetic.w07fixture', 'owner_authority', d2->'id', 'owner_authority_revision', 1,
        'acceptance', 'w07_fixture SYNTHETIC W-C02-07', 'constraints', '[]'::jsonb,
        'reason', 'w07_fixture SYNTHETIC W-C02-07 mission revision')),
      'admit_work', jsonb_build_object('class', 'devos_calisma', 'args', jsonb_build_object(
        'mission_ref', mr->'mission_id', 'mission_revision', mr->'revision', 'scope', 'synthetic.w07fixture',
        'purpose', 'w07_fixture SYNTHETIC W-C02-07 work item', 'impact_class', 'routine', 'consumer', 'w07_fixture',
        'return_to', 'w07_fixture', 'stop_rule', 'w07_fixture', 'input_refs', '[]'::jsonb, 'target_refs', '[]'::jsonb,
        'mandatory_needs', '[]'::jsonb)));
  exception when others then
    fx_fail := fx_fail || (select jsonb_object_agg(z, 'its fixture could not be made: ' || sqlstate || ' ' || left(sqlerrm, 150))
                             from unnest(array['open_mission', 'revise_mission', 'admit_work']) z);
  end;
  begin  -- resolve_need(need_id, reason): a planted open Need
    x := pg_temp.w07_plant('devos_private.need', '{"status": "open", "condition": "w07_fixture SYNTHETIC W-C02-07 condition", "why_needed": "w07_fixture SYNTHETIC W-C02-07: F06 resolves one need"}');
    recipes := recipes || jsonb_build_object('resolve_need', jsonb_build_object('class', 'devos_calisma', 'args',
      jsonb_build_object('need_id', x->'id', 'reason', 'w07_fixture SYNTHETIC W-C02-07 resolved')));
  exception when others then
    fx_fail := fx_fail || jsonb_build_object('resolve_need', 'its fixture could not be made: ' || sqlstate || ' ' || left(sqlerrm, 150));
  end;
  foreach fn in array array['mark_stale', 'cancel_work', 'reopen_for_review'] loop
    begin  -- <fn>(work_id, reason): a planted work item each; reopen_for_review's planted finished and accepted
      wk := pg_temp.w07_plant('devos_private.work_revision', '{}');
      if fn = 'reopen_for_review' then
        update devos_private.work set execution = 'finished', acceptance = 'accepted' where id::text = wk->>'work_id';
      end if;
      recipes := recipes || jsonb_build_object(fn, jsonb_build_object('class', 'devos_calisma', 'args',
        jsonb_build_object('work_id', wk->'work_id', 'reason', 'w07_fixture SYNTHETIC W-C02-07 ' || fn)));
    exception when others then
      fx_fail := fx_fail || jsonb_build_object(fn, 'its fixture could not be made: ' || sqlstate || ' ' || left(sqlerrm, 150));
    end;
  end loop;
  begin  -- retract_relation(relation_id, reason): a planted relation between two planted work items of its own
    wk := pg_temp.w07_plant('devos_private.work_revision', '{}'); op := pg_temp.w07_plant('devos_private.work_revision', '{}');
    x := pg_temp.w07_plant('devos_private.relation', jsonb_build_object('type', 'about', 'from_ref', wk->'work_id',
      'from_revision', wk->'revision', 'to_ref', op->'work_id', 'to_revision', op->'revision', 'hard', false,
      'scope', 'synthetic.w07fixture', 'method', 'recorded', 'epistemic_status', 'inference', 'validity', 'current'));
    recipes := recipes || jsonb_build_object('retract_relation', jsonb_build_object('class', 'devos_calisma', 'args',
      jsonb_build_object('relation_id', x->'id', 'reason', 'w07_fixture SYNTHETIC W-C02-07 retracted')));
  exception when others then
    fx_fail := fx_fail || jsonb_build_object('retract_relation', 'its fixture could not be made: ' || sqlstate || ' ' || left(sqlerrm, 150));
  end;
  begin  -- record_verdict, record_eval_run, set_effort_policy: a planted review and work items
    wk := pg_temp.w07_plant('devos_private.work_revision', '{}');
    x := pg_temp.w07_plant('devos_private.review', jsonb_build_object('kind', 'review', 'target_ref', wk->'work_id',
      'target_revision', wk->'revision', 'use', 'w07_fixture_use_two', 'basis_refs', '[]'::jsonb));
    recipes := recipes || jsonb_build_object(
      'record_verdict', jsonb_build_object('class', 'devos_denetim', 'args', jsonb_build_object('review_ref', x->'id',
        'result', 'pass', 'evidence_refs', '[]'::jsonb, 'objections', '[]'::jsonb, 'limits', 'w07_fixture SYNTHETIC W-C02-07')),
      'record_eval_run', jsonb_build_object('class', 'devos_sinav', 'args', jsonb_build_object(
        'eval_set_id', 'w07_fixture_eval_set', 'eval_set_version', '1', 'subject_role', 'w07_fixture',
        'subject_release', 'w07_fixture', 'runner_session', 'w07_fixture_session_f06',
        'work_ref', wk->'work_id', 'work_revision', wk->'revision',
        'results', '{"positive": [], "negative": []}'::jsonb, 'run_at', now())),
      'set_effort_policy', jsonb_build_object('class', 'devos_calisma', 'args', jsonb_build_object(
        'work_ref', wk->'work_id', 'work_revision', wk->'revision', 'level', 'high',
        'expert_assessment_ref', 'w07_fixture SYNTHETIC W-C02-07: expert assessment of the item, high effort',
        'non_removable_steps', '["verification", "alternatives_research", "external_source_research"]'::jsonb,
        'status', 'active')));
  exception when others then
    fx_fail := fx_fail || (select jsonb_object_agg(z, 'its fixture could not be made: ' || sqlstate || ' ' || left(sqlerrm, 150))
                             from unnest(array['record_verdict', 'record_eval_run', 'set_effort_policy']) z);
  end;
  -- The functions that act under a claim: one planted work item and one accepted claim each (the claim token is held
  -- in the recipe's arguments, a PL/pgSQL variable, and bound through a setting, never printed or inlined).
  -- operation_state (a read, EV-C02-013 2.7; revised under ledger rule 3, N-283, 2026-10-18) reads an operation prepared
  -- for it the same way.
  foreach fn in array array['heartbeat', 'release', 'revoke_claim', 'register_artifact', 'prepare_operation',
                            'record_attempt', 'record_observation', 'operation_state'] loop
    begin
      wk := pg_temp.w07_plant('devos_private.work_revision', '{}');
      cl := pg_temp.w07_call('claim', jsonb_build_object('work_id', wk->'work_id', 'declared_session_id', 'w07_fixture_session_f06'), t_cal);
      if cl ? 'interface' or cl->>'error' is not null or cl->'result'->>'status' is distinct from 'ok' then
        raise exception 'the claim its fixture needs was not accepted: %', pg_temp.w07_show(cl);
      end if;
      ct := cl->'result'->>'claim_token';
      op := jsonb_build_object('claim_token', ct, 'idempotency_namespace', 'w07_fixture', 'idempotency_key', 'w07_fixture_key_f06_' || fn,
        'effect_class', 'w07_fixture_effect_f06', 'target', 'w07_fixture/target_f06', 'expected_base', 'w07_fixture_base_1',
        'payload_hash', 'w07_fixture_payload_1', 'work_ref', wk->'work_id', 'work_revision', wk->'revision',
        'read_set', jsonb_build_array(jsonb_build_object('ref', wk->'work_id', 'revision', wk->'revision')));
      if fn in ('prepare_operation', 'record_attempt', 'record_observation', 'operation_state')
         and not exists (select 1 from devos_private.effect_class where effect_class::text = 'w07_fixture_effect_f06') then
        perform pg_temp.w07_plant('devos_private.effect_class', '{"effect_class": "w07_fixture_effect_f06", "irreversible": false, "mandatory_read_set": ["work"]}');
      end if;
      if fn in ('record_attempt', 'record_observation', 'operation_state') then  -- an operation prepared for it
        x := pg_temp.w07_call('prepare_operation', op, t_cal);
        if x ? 'interface' or x->>'error' is not null or x->'result'->>'status' is distinct from 'ok' then
          raise exception 'the operation its fixture needs was not prepared: %', pg_temp.w07_show(x);
        end if;
      end if;
      recipes := recipes || jsonb_build_object(fn, case fn
        when 'heartbeat' then jsonb_build_object('class', 'devos_calisma', 'args', jsonb_build_object('claim_token', ct))
        when 'release' then jsonb_build_object('class', 'devos_calisma', 'args', jsonb_build_object('claim_token', ct))
        when 'revoke_claim' then jsonb_build_object('class', 'devos_denetim', 'args', jsonb_build_object(
          'assignment_id', cl->'result'->'assignment_id', 'reason', 'w07_fixture SYNTHETIC W-C02-07 revoked'))
        when 'register_artifact' then jsonb_build_object('class', 'devos_calisma', 'args', jsonb_build_object('claim_token', ct,
          'work_ref', wk->'work_id', 'work_revision', wk->'revision', 'path', 'w07_fixture/f06_artifact',
          'commit', repeat('a7', 20), 'kind', 'w07_fixture', 'scope', 'synthetic.w07fixture',
          'declared_session_id', 'w07_fixture_session_f06'))
        when 'prepare_operation' then jsonb_build_object('class', 'devos_calisma', 'args', op)
        when 'record_attempt' then jsonb_build_object('class', 'devos_calisma', 'args', jsonb_build_object('claim_token', ct,
          'operation_id', x->'result'->'id'))
        when 'operation_state' then jsonb_build_object('class', 'devos_calisma', 'args', jsonb_build_object(
          'operation_id', x->'result'->'id'))
        else jsonb_build_object('class', 'devos_calisma', 'args', jsonb_build_object('operation_ref', x->'result'->'id',
          'source', 'w07_fixture SYNTHETIC W-C02-07 source', 'observed_at', to_char(now() at time zone 'UTC', 'YYYY-MM-DD"T"HH24:MI:SS"Z"'),
          'observed_effect', 'unknown'))
        end);
    exception when others then
      fx_fail := fx_fail || jsonb_build_object(fn, 'its fixture could not be made: ' || sqlstate || ' ' || left(sqlerrm, 150));
    end;
  end loop;
  ct := null; op := null; cl := null;
  -- deployment_drift's arguments (T-W07-IDC's form, with a well-formed synthetic commit). Phase C5 (CHK-C02-030 C2): it
  -- is judged on every build by its marker. It writes nothing (Appendix B section 4's Deployment row; main's migration
  -- 20261012184638), so a build that meets DM-36 (a) marks it devos:read, W-C02-09's migration setting the comment
  -- (W-C02-09 point 1: DM-36 and F06's list as decided), and F06-read-refused and F06-read-accepted judge it here (under
  -- set role the session user postgres is admitted before the token check, which a read's "no table changed" does not
  -- depend on). Unmarked, it counts as state-changing (F06-e2) and F06-event:deployment_drift is judged, and fails,
  -- since it changes nothing and makes no event.
  recipes := recipes || jsonb_build_object('deployment_drift', jsonb_build_object('class', 'devos_ci', 'args',
    jsonb_build_object('expected', jsonb_build_object('commit', repeat('a7', 20), 'migrations', '[]'::jsonb, 'functions', '[]'::jsonb))));
  -- G20 (revised before any result: EV-C02-013 sections 2.2, 2.8 and 3.2, 2026-10-17): recipes for the ledger
  -- transfer's fourteen functions, mark_exported and link_prior_decisions, with the payloads the interface record names.
  -- The transfer's prerequisites (EV-C02-013 3.2, "Prerequisites a test must plant"): an open run for the records, a
  -- second run for end_transfer_run to end, D-010's batu Decision for transfer_mission (R1-9), a Review copy (a
  -- transferred creation event) for transfer_acceptance. transfer_mission's own call makes the installation's Mission,
  -- so the loop below runs the functions that need it after it, and record_handover, which closes the path, last.
  begin
    x := pg_temp.w07_call('begin_transfer_run', pg_temp.f06_run_args('w07_fixture_run_f06_open'), t_kur);
    if x->'result'->>'status' is distinct from 'ok' then raise exception 'the open run its recipes need was not begun: %', pg_temp.w07_show(x); end if;
    x := pg_temp.w07_call('begin_transfer_run', pg_temp.f06_run_args('w07_fixture_run_f06_end'), t_kur);
    if x->'result'->>'status' is distinct from 'ok' then raise exception 'the run end_transfer_run ends was not begun: %', pg_temp.w07_show(x); end if;
    dl := jsonb_build_object('class', 'high_impact', 'question', 'w07_fixture SYNTHETIC W-C02-07 transferred decision',
      'why_this_owner', 'w07_fixture SYNTHETIC W-C02-07', 'options', '[]'::jsonb, 'alternatives_considered', '[]'::jsonb,
      'alternatives_state', 'compared', 'criteria', '[]'::jsonb, 'evidence_refs', '[]'::jsonb, 'assumptions', '[]'::jsonb,
      'premises', '[]'::jsonb, 'reopen_triggers', '[]'::jsonb, 'status', 'answered', 'run_id', 'w07_fixture_run_f06_open');
    x := pg_temp.w07_call('transfer_decision', dl || jsonb_build_object('class', 'batu', 'presented_text_tr', 'w07_fixture SYNTHETIC karar',
      'answer_original_tr', 'w07_fixture SYNTHETIC yanit', 'answer_interpretation_en', 'w07_fixture SYNTHETIC answer',
      'answered_by', 'w07_fixture SYNTHETIC', 'answer_channel_ref', 'w07_fixture/channel', 'answered_at', now(),
      'transfer_source', pg_temp.f06_src('decision', 'D-010')), t_kur);
    if x->'result'->>'status' is distinct from 'ok' then raise exception 'D-010''s Decision (transfer_mission''s prerequisite) was not transferred: %', pg_temp.w07_show(x); end if;
    tdd := x->'result'->>'id';
    wt1 := pg_temp.w07_plant('devos_private.work_revision', '{}'); wt2 := pg_temp.w07_plant('devos_private.work_revision', '{}');
    dl2 := jsonb_build_object('run_id', 'w07_fixture_run_f06_open', 'kind', 'review', 'claim', 'w07_fixture SYNTHETIC W-C02-07 verdict copy',
      'target_ref', wt1->'work_id', 'criterion', 'w07_fixture/criterion', 'basis_refs', '["w07_fixture_tree"]'::jsonb,
      'reviewer_declared_session', 'w07_fixture_checker_run SYNTHETIC', 'independence_level', 'fresh_context_subagent',
      'use', 'installation_acceptance', 'verdict', jsonb_build_object('result', 'pass', 'objections', '[]'::jsonb,
      'evidence_refs', '[]'::jsonb, 'limits', '[]'::jsonb));
    -- (Revised before any result, EV-C02-013 R2-2, 2026-10-18: the Review copy of the planted wt1 that transfer_acceptance
    -- named is no longer made here; its target and Review copy are made at the call, pg_temp.f06_late 'acceptance'.)
    recipes := recipes || jsonb_build_object(
      'begin_transfer_run', jsonb_build_object('class', 'devos_kurulum', 'args', pg_temp.f06_run_args('w07_fixture_run_f06_begin')),
      'end_transfer_run', jsonb_build_object('class', 'devos_kurulum', 'args', jsonb_build_object('run_id', 'w07_fixture_run_f06_end',
        'counts', '{}'::jsonb, 'phase', 'completed')),
      'record_handover', jsonb_build_object('class', 'devos_kurulum', 'args', jsonb_build_object('run_id', 'w07_fixture_run_f06_open',
        'input_commit', left(md5('w07 f06 input') || md5('w07 f06 input 2'), 40), 'mark_commit', left(md5('w07 f06 mark') || md5('m'), 40),
        'handed_over_sha256', md5('w07 f06 handed over') || md5('h'))),
      'transfer_mission', jsonb_build_object('class', 'devos_kurulum', 'args', jsonb_build_object('run_id', 'w07_fixture_run_f06_open',
        'transfer_source', pg_temp.f06_src('mission', 'W07-FIXTURE-F06-INSTALL'), 'purpose', 'w07_fixture SYNTHETIC W-C02-07 installation mission',
        'scope', 'installation', 'acceptance', 'w07_fixture SYNTHETIC W-C02-07', 'owner_authority', tdd, 'owner_authority_revision', 1,
        'constraints', '[]'::jsonb, 'status', 'active')),
      'transfer_work', jsonb_build_object('class', 'devos_kurulum', 'late', 'mission', 'args', jsonb_build_object('run_id', 'w07_fixture_run_f06_open',
        'transfer_source', pg_temp.f06_src('work', 'W07-FIXTURE-F06-W1'), 'scope', 'installation',
        'purpose', 'w07_fixture SYNTHETIC W-C02-07 transferred work item', 'impact_class', 'high', 'execution', 'planned',
        'acceptance', 'proposed', 'effort_policy', jsonb_build_object('level', 'high', 'expert_assessment_ref', 'w07_fixture/expert_assessment',
        'non_removable_steps', '["verification"]'::jsonb))),
      'transfer_need', jsonb_build_object('class', 'devos_kurulum', 'late', 'mission', 'args', jsonb_build_object('run_id', 'w07_fixture_run_f06_open',
        'transfer_source', pg_temp.f06_src('need', 'W07-FIXTURE-F06-N1'), 'condition', 'w07_fixture SYNTHETIC W-C02-07 condition',
        'why_needed', 'w07_fixture SYNTHETIC W-C02-07: F06 transfers one need', 'status', 'open')),
      'record_ledger_entry', jsonb_build_object('class', 'devos_kurulum', 'late', 'stage', 'args', jsonb_build_object(
        'entry_id', 'W07-FIXTURE-F06-L1', 'entry_date', current_date::text, 'text', 'w07_fixture SYNTHETIC W-C02-07 ledger entry')),
      'transfer_relation', jsonb_build_object('class', 'devos_kurulum', 'args', jsonb_build_object('run_id', 'w07_fixture_run_f06_open',
        'transfer_source', pg_temp.f06_src('relation', 'W07-FIXTURE-F06-REL1'), 'type', 'about', 'from_ref', a->'work_id',
        'from_revision', a->'revision', 'to_ref', b->'work_id', 'to_revision', b->'revision', 'scope', 'installation', 'hard', false,
        'method', 'mechanical', 'epistemic_status', 'observation')),
      'transfer_decision', jsonb_build_object('class', 'devos_kurulum', 'args', dl || jsonb_build_object(
        'transfer_source', pg_temp.f06_src('decision', 'W07-FIXTURE-F06-D1'))),
      'transfer_review', jsonb_build_object('class', 'devos_kurulum', 'args', dl2 || jsonb_build_object('target_ref', wt2->'work_id',
        'transfer_source', pg_temp.f06_src('verdict', 'W07-FIXTURE-F06-RV1'))),
      'transfer_acceptance', jsonb_build_object('class', 'devos_kurulum', 'late', 'acceptance', 'args', jsonb_build_object(
        'run_id', 'w07_fixture_run_f06_open', 'accepted_use', 'installation_acceptance', 'scope', 'installation',
        'transfer_source', pg_temp.f06_src('acceptance', 'W07-FIXTURE-F06-ACC1'))),
      'transfer_finding', jsonb_build_object('class', 'devos_kurulum', 'args', jsonb_build_object('run_id', 'w07_fixture_run_f06_open',
        'transfer_source', pg_temp.f06_src('finding', 'W07-FIXTURE-F06-FND1'), 'claim', 'w07_fixture SYNTHETIC W-C02-07 transferred finding',
        'scope', 'installation', 'counter_evidence_searched', 'not_recorded', 'changeable', 'not_recorded', 'epistemic_status', 'observation',
        'current_authority', 'information_only', 'privacy_class', 'public', 'status', 'candidate')),
      'transfer_artifact', jsonb_build_object('class', 'devos_kurulum', 'args', jsonb_build_object('run_id', 'w07_fixture_run_f06_open',
        'transfer_source', pg_temp.f06_src('artifact', 'W07-FIXTURE-F06-ART1'), 'path', 'w07_fixture/f06_transferred_artifact.md',
        'commit', left(md5('w07 f06 artifact') || md5('a'), 40), 'kind', 'git_file', 'scope', 'installation', 'status', 'current')),
      'transfer_event', jsonb_build_object('class', 'devos_kurulum', 'args', jsonb_build_object('run_id', 'w07_fixture_run_f06_open',
        'transfer_source', pg_temp.f06_src('record_line', 'W07-FIXTURE-F06#1'), 'event_type', 'record_line', 'aggregate_type', 'work',
        'aggregate_id', a->'work_id', 'text', 'w07_fixture SYNTHETIC W-C02-07 record line')));
  exception when others then
    fx_fail := fx_fail || (select jsonb_object_agg(z, 'its fixture could not be made: ' || sqlstate || ' ' || left(sqlerrm, 150))
      from unnest(array['begin_transfer_run', 'transfer_mission', 'transfer_work', 'transfer_relation', 'transfer_decision', 'transfer_review',
                        'transfer_acceptance', 'transfer_need', 'transfer_finding', 'transfer_artifact', 'transfer_event', 'end_transfer_run',
                        'record_handover', 'record_ledger_entry']) z);
  end;
  begin  -- mark_exported({table, from_id, to_id}; EV-C02-013 2.8): one planted event, its range alone
    ev_id := pg_temp.w07_plant('devos_private.event', jsonb_build_object('aggregate_type', 'w07_fixture', 'aggregate_id', gen_random_uuid(),
      'event_type', 'w07_fixture_event', 'payload', '{}'::jsonb, 'role_class', 'owner', 'origin', 'owner'))->>'id';
    recipes := recipes || jsonb_build_object('mark_exported', jsonb_build_object('class', 'devos_backup', 'args',
      jsonb_build_object('table', 'event', 'from_id', ev_id::bigint, 'to_id', ev_id::bigint)));
  exception when others then
    fx_fail := fx_fail || jsonb_build_object('mark_exported', 'its fixture could not be made: ' || sqlstate || ' ' || left(sqlerrm, 150));
  end;
  begin  -- link_prior_decisions({decision_id, prior_ids, scope}; EV-C02-013 2.2): two planted decisions
    x := pg_temp.w07_plant('devos_private.decision', '{"class": "high_impact", "status": "draft"}');
    perform pg_temp.w07_plant('devos_private.decision_revision', jsonb_build_object('decision_id', x->'id', 'revision', 1));
    op := pg_temp.w07_plant('devos_private.decision', '{"class": "high_impact", "status": "answered"}');
    perform pg_temp.w07_plant('devos_private.decision_revision', jsonb_build_object('decision_id', op->'id', 'revision', 1));
    recipes := recipes || jsonb_build_object('link_prior_decisions', jsonb_build_object('class', 'devos_calisma', 'args',
      jsonb_build_object('decision_id', x->'id', 'prior_ids', jsonb_build_array(op->'id'), 'scope', 'synthetic.w07fixture')));
  exception when others then
    fx_fail := fx_fail || jsonb_build_object('link_prior_decisions', 'its fixture could not be made: ' || sqlstate || ' ' || left(sqlerrm, 150));
  end;
  -- Revised under ledger rule 3, before any result (N-283; CHK-C02-086 C4; 2026-10-18): recipes for the read functions
  -- with required arguments (EV-C02-013 2.2, 2.6, 2.7 and 2.8), so that F06-read-accepted can be judged for each, not
  -- left could_not_check on every build. The class named is one the record permits; the read case still tries the
  -- classes in the order fixed in the specification. Each fixture is made in its own block; one that cannot be made
  -- gives could_not_check with the reason. operation_state's operation is prepared in the claim loop above.
  begin  -- read_decision(decision_id): a planted Decision with its revision 1
    x := pg_temp.w07_plant('devos_private.decision', '{"class": "routine", "status": "open"}');
    perform pg_temp.w07_plant('devos_private.decision_revision', jsonb_build_object('decision_id', x->'id', 'revision', 1));
    recipes := recipes || jsonb_build_object('read_decision', jsonb_build_object('class', 'devos_calisma', 'args',
      jsonb_build_object('decision_id', x->'id')));
  exception when others then
    fx_fail := fx_fail || jsonb_build_object('read_decision', 'its fixture could not be made: ' || sqlstate || ' ' || left(sqlerrm, 150));
  end;
  -- read_review(review_id): the planted Review of the accept recipe's Verdict (kind review, not a sample)
  recipes := recipes || jsonb_build_object('read_review', jsonb_build_object('class', 'devos_denetim', 'args',
    jsonb_build_object('review_id', v->'review_ref')));
  begin  -- read_eval_run(eval_run_id): a planted EvalRun on a planted work revision
    wk := pg_temp.w07_plant('devos_private.work_revision', '{}');
    x := pg_temp.w07_plant('devos_private.eval_run', jsonb_build_object('work_ref', wk->'work_id', 'work_revision', wk->'revision',
      'results', '{}'::jsonb));
    recipes := recipes || jsonb_build_object('read_eval_run', jsonb_build_object('class', 'devos_sinav', 'args',
      jsonb_build_object('eval_run_id', x->'id')));
  exception when others then
    fx_fail := fx_fail || jsonb_build_object('read_eval_run', 'its fixture could not be made: ' || sqlstate || ' ' || left(sqlerrm, 150));
  end;
  -- read_rejected_attempts(since) and fingerprint_matches(hashes): no fixture; the hash is a synthetic string made at
  -- run time (EV-C02-013 2.8: an empty array is invalid_field).
  recipes := recipes || jsonb_build_object(
    'read_rejected_attempts', jsonb_build_object('class', 'devos_denetim', 'args',
      jsonb_build_object('since', to_char((now() - interval '1 day') at time zone 'UTC', 'YYYY-MM-DD"T"HH24:MI:SS"Z"'))),
    'fingerprint_matches', jsonb_build_object('class', 'devos_ci', 'args',
      jsonb_build_object('hashes', jsonb_build_array(md5('w07 f06 fingerprint') || md5('w07 f06 fingerprint 2')))));
  x := null; op := null;
  -- Functions this file cannot form, each listed with its reason (could_not_check, never a pass): none since G20.
  unformable := '{}'::jsonb;
  -- The functions whose state change is an event only (EV-C02-013 3.2 and 2.8: a transfer_run event, the
  -- ledger_handed_over event, a ledger_entry event, an event of the six kinds, the exported event and the export marks
  -- on event rows): for them F06-event's "changes state" reads the event table too.
  event_state := array['begin_transfer_run', 'end_transfer_run', 'record_handover', 'record_ledger_entry', 'transfer_event', 'mark_exported'];
  -- A repeat that is not an exact repeat of the same change: a call that creates a new record (no idempotency key), or
  -- one whose every call is a new change by design. Phase C5 (CHK-C02-030 C2): outside F06-r3's and F06-p1's subject
  -- (an exact repeat of the same change), so not a case and not in the verdict count; listed in one notice with the
  -- reason (T-W07-F06, "Not covered").
  no_repeat := (select jsonb_object_agg(z, 'a repeat of a creating call with no idempotency key makes a new record, not the same change (B principle 2)')
                  from unnest(array['record_need', 'open_decision', 'record_finding', 'open_review', 'open_mission', 'admit_work',
                                    'register_artifact', 'record_observation', 'record_eval_run', 'record_verdict', 'set_effort_policy']) z)
    || jsonb_build_object('heartbeat', 'each heartbeat extends the lease from its own time (B 3.5), a new change by design',
                          'record_attempt', 'each attempt is counted (B 3.12 attempts), a new change by design');

  select count(*) into n_listed from pg_proc p join pg_namespace n on n.oid = p.pronamespace where n.nspname = 'devos_api';
  perform pg_temp.w07_rec('F06-list', 'ok', format('%s devos_api functions (%s marked devos:read) and the two owner-only functions, read from the catalogue',
    n_listed, (select count(*) from pg_proc p join pg_namespace n on n.oid = p.pronamespace
                where n.nspname = 'devos_api' and coalesce(obj_description(p.oid, 'pg_proc'), '') like 'devos:read%')));

  for f in select p.proname, coalesce(obj_description(p.oid, 'pg_proc'), '') like 'devos:read%' as is_read,
                  p.pronargs - p.pronargdefaults as required
             from pg_proc p join pg_namespace n on n.oid = p.pronamespace where n.nspname = 'devos_api'
            -- G20: the functions that need the installation's Mission after transfer_mission, record_handover last.
            order by p.proname = 'record_handover',
                     p.proname in ('transfer_work', 'transfer_need', 'transfer_acceptance', 'record_ledger_entry'), p.proname loop
    -- The refused call: no token. deployment_drift admits the migration role's direct login before the token check
    -- (B:45), and session_user stays postgres under set role (README 5.1 (a)), so its no-token case is the Data API's.
    m := pg_temp.w07_measure(f.proname, '{}', null, true);
    if m->'call' ? 'interface' then
      perform pg_temp.w07_rec('F06-refused:' || f.proname, 'could_not_check', pg_temp.w07_show(m->'call'));
    elsif f.is_read then
      perform pg_temp.w07_check('F06-read-refused:' || f.proname, jsonb_array_length(m->'changed') = 0 and jsonb_array_length(m->'events') = 0,
        pg_temp.w07_show(m->'call') || '; tables changed besides rejected_attempt: ' || (m->'changed')::text || '; new events ' || jsonb_array_length(m->'events'));
    elsif f.proname = 'deployment_drift' then
      perform pg_temp.w07_rec('F06-refused:' || f.proname, 'ok', 'not tried here: admitted by session_user before the token check; its Data API case is W-C02-03''s and T-W07-5B''s');
    else
      perform pg_temp.w07_check('F06-refused:' || f.proname, pg_temp.w07_refused(m->'call') and jsonb_array_length(m->'changed') = 0
          and jsonb_array_length(m->'events') = 0,
        pg_temp.w07_show(m->'call') || '; tables changed besides rejected_attempt: ' || (m->'changed')::text || '; new events ' || jsonb_array_length(m->'events'));
    end if;
    -- The accepted call.
    if f.is_read then
      if f.required > 0 and fx_fail ? f.proname then  -- N-283: its recipe's fixture could not be made
        perform pg_temp.w07_rec('F06-read-accepted:' || f.proname, 'could_not_check', 'no recipe: ' || (fx_fail->>f.proname));
        continue;
      end if;
      if f.required > 0 and not recipes ? f.proname then
        perform pg_temp.w07_rec('F06-read-accepted:' || f.proname, 'could_not_check', 'no recipe for a call with its required arguments');
        continue;
      end if;
      ok := null;
      foreach cls in array classes loop
        begin
          tok := pg_temp.w07_token(cls);
        exception when others then continue;
        end;
        m := pg_temp.w07_measure(f.proname, coalesce(recipes->f.proname->'args', '{}'), tok);
        if not (m->'call' ? 'interface') and not pg_temp.w07_refused(m->'call') then
          ok := jsonb_array_length(m->'changed') = 0 and jsonb_array_length(m->'events') = 0;
          perform pg_temp.w07_check('F06-read-accepted:' || f.proname, ok, 'accepted with a ' || cls || ' token; tables changed: '
            || (m->'changed')::text || '; new events ' || jsonb_array_length(m->'events'));
          exit;
        end if;
      end loop;
      if ok is null then
        perform pg_temp.w07_rec('F06-read-accepted:' || f.proname, 'could_not_check', 'no role class''s token made an accepted call; the last answer: ' || pg_temp.w07_show(m->'call'));
      end if;
    elsif unformable ? f.proname then  -- phase C3: listed, with its reason
      perform pg_temp.w07_rec('F06-event:' || f.proname, 'could_not_check', 'no recipe: ' || (unformable->>f.proname));
    elsif fx_fail ? f.proname then
      perform pg_temp.w07_rec('F06-event:' || f.proname, 'could_not_check', 'no recipe: ' || (fx_fail->>f.proname));
    elsif not recipes ? f.proname then
      perform pg_temp.w07_rec('F06-event:' || f.proname, 'could_not_check', 'no recipe for an accepted call (the specification, "Could not check")');
    else
      tok := case recipes->f.proname->>'class' when 'devos_calisma' then t_cal else pg_temp.w07_token(recipes->f.proname->>'class') end;
      if recipes->f.proname ? 'late' then  -- G20: completed at the call (pg_temp.f06_late)
        recipes := jsonb_set(recipes, array[f.proname, 'args'],
                             pg_temp.f06_late(recipes->f.proname->>'late', recipes->f.proname->'args', tok));
      end if;
      m := pg_temp.w07_measure(f.proname, recipes->f.proname->'args', tok);
      if m->'call' ? 'interface' or pg_temp.w07_refused(m->'call') then  -- phase C: the recipe was not accepted
        perform pg_temp.w07_rec('F06-event:' || f.proname, 'could_not_check', 'the recipe''s call was not accepted, so no state '
          || 'change could be observed: ' || pg_temp.w07_show(m->'call'));
        perform pg_temp.w07_rec('F06-repeat:' || f.proname, 'could_not_check', 'no accepted call to repeat');
        continue;
      end if;
      perform pg_temp.w07_check('F06-event:' || f.proname, not pg_temp.w07_refused(m->'call')
          and (jsonb_array_length(m->'changed') > 0 or f.proname = any (event_state))
          and jsonb_array_length(m->'events') >= 1
          and not exists (select 1 from jsonb_array_elements(m->'events') e where e->>'role_class' is distinct from recipes->f.proname->>'class'
                            or e->>'origin' not in ('call', 'rule') or (e->>'this_tx')::boolean is not true),
        pg_temp.w07_show(m->'call') || '; tables changed: ' || (m->'changed')::text || '; new events ' || (m->'events')::text
        || case when f.proname = 'deployment_drift' then '; deployment_drift carries no devos:read marker, so F06 counts it '
                || 'state-changing (F06-e2); a read changes nothing, so the build marks it (DM-36 (a); W-C02-09''s migration)' else '' end);
      if no_repeat ? f.proname then
        raise notice 'W07_F06 not a case (outside F06-r3 and F06-p1): F06-repeat:%: %', f.proname, no_repeat->>f.proname;
        continue;
      end if;
      m2 := pg_temp.w07_measure(f.proname, recipes->f.proname->'args', tok);
      -- An exact repeat makes no event and raises no error (B principle 2), and answers ok with the existing id (EV-C02-013
      -- section 1 item 10: the repeat check comes before stale_revision and run_not_open). Revised before any result
      -- (EV-C02-013 R2-9, 2026-10-18): a returned refusal is accepted only for claim (already_claimed), release
      -- (claim_not_active) and record_handover (handed_over: its second call comes after the hand-over its first
      -- recorded, B:397), the three functions with no exact repeat that answers ok; for every other function the repeat
      -- must answer status ok.
      perform pg_temp.w07_check('F06-repeat:' || f.proname, (m2->'call'->>'error') is null and not (m2->'call' ? 'interface')
          and jsonb_array_length(m2->'changed') = 0
          and jsonb_array_length(m2->'events') = 0
          and (f.proname = any (array['claim', 'release', 'record_handover'])
               or m2->'call'->'result'->>'status' = 'ok'),
        'exact repeat: ' || pg_temp.w07_show(m2->'call') || '; tables changed: ' || (m2->'changed')::text || '; new events ' || jsonb_array_length(m2->'events')
        || case when f.proname = any (array['claim', 'release', 'record_handover']) then ' (wanted no error, none, 0; a returned refusal allowed)'
                else ' (wanted status ok, none, 0)' end);
    end if;
  end loop;

  -- The owner-only functions: role_class owner and origin owner, read from the database session (DM-31).
  e0 := pg_temp.w07_ids('devos_private.event');
  perform pg_temp.w07_token_mark();
  t_x := pg_temp.w07_token('devos_sinav');
  ev := pg_temp.w07_new_events(e0);
  perform pg_temp.w07_check('F06-owner:issue_env_token', jsonb_array_length(ev) >= 1
      and not exists (select 1 from jsonb_array_elements(ev) e where e->>'role_class' <> 'owner' or e->>'origin' <> 'owner'),
    'issue_env_token as the owner: new events ' || ev::text);
  e0 := pg_temp.w07_ids('devos_private.event');
  perform pg_temp.w07_revoke_since_mark();  -- t_x's row, by its ID (README section 8)
  ev := pg_temp.w07_new_events(e0);
  perform pg_temp.w07_check('F06-owner:revoke_env_token', jsonb_array_length(ev) >= 1
      and not exists (select 1 from jsonb_array_elements(ev) e where e->>'role_class' <> 'owner' or e->>'origin' <> 'owner'),
    'revoke_env_token as the owner: new events ' || ev::text);

  -- role_class from the token, never declared: the same relate with the devos_kurulum token and a declared session.
  rel := jsonb_set(rel, '{to_ref}', d->'work_id');
  m := pg_temp.w07_measure('relate', rel || '{"declared_session_id": "w07_fixture_declared_session"}', t_kur);
  if m->'call' ? 'interface' then
    m := pg_temp.w07_measure('relate', rel, t_kur);
  end if;
  perform pg_temp.w07_check('F06-role-token', case when m->'call' ? 'interface' then null else
      not pg_temp.w07_refused(m->'call') and jsonb_array_length(m->'events') >= 1
      and not exists (select 1 from jsonb_array_elements(m->'events') e where e->>'role_class' <> 'devos_kurulum') end,
    pg_temp.w07_show(m->'call') || '; new events ' || (m->'events')::text);

  -- Orphans: a failure planted on the event write (a), and on the state write (b), mid-transaction.
  foreach cls in array array['event', 'relation'] loop
    begin
      execute format('create trigger w07_planted_failure before insert on devos_private.%I for each row execute function pg_temp.w07_fail_trg()', cls);
      m := pg_temp.w07_measure('relate', jsonb_set(rel, '{from_ref}', b->'work_id'), t_cal);
      raise exception using errcode = 'P0W07', message = 'w07: undo the case';
    exception when sqlstate 'P0W07' then null;
    end;
    perform pg_temp.w07_check('F06-orphan-' || case cls when 'event' then 'a' else 'b' end,
      case when m->'call' ? 'interface' then null else pg_temp.w07_refused(m->'call') and jsonb_array_length(m->'changed') = 0
           and jsonb_array_length(m->'events') = 0 end,
      'failure planted on the ' || cls || ' write: ' || pg_temp.w07_show(m->'call') || '; tables changed: ' || (m->'changed')::text
        || '; new events ' || jsonb_array_length(m->'events'));
  end loop;
end $$;

select case_id, outcome, detail from w07_results order by case_id;

do $$
declare nb int; nc int; n int;
begin
  select count(*) filter (where outcome = 'bad'), count(*) filter (where outcome = 'could_not_check'), count(*)
    into nb, nc, n from w07_results;
  if nb > 0 then
    raise exception 'W07_F06_STATE_CHANGE_EVENT FAIL (% bad, % could not check, of %)', nb, nc, n;
  elsif nc > 0 or n = 0 then
    raise exception 'W07_F06_STATE_CHANGE_EVENT COULD NOT CHECK (% of % could not be checked)', nc, n;
  end if;
  raise notice 'W07_F06_STATE_CHANGE_EVENT PASS (%/%)', n, n;
end $$;

rollback;
