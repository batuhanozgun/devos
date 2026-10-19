-- Synthetic test data (plan Section 8 item 13): every graph below is made up inside this transaction: random uuids
-- named by role in the graph (m0..m18, a1..b18, c1..c3, n1..n40, x and y), relation rows of type derived_from (and,
-- since N-292, one each of supports, challenges and part_of, and one planted with a NULL type) with scope
-- 'synthetic.w07fixture'; synthetic exam runs (EvalRun rows) planted by the owner, one of them a relation end whose
-- results carry the marker 'w07_fixture_hidden_node SYNTHETIC W-C02-07', and work items whose purpose is 'w07_fixture_* SYNTHETIC
-- W-C02-07'. No personal or business data; tokens are kept in PL/pgSQL variables only. Nothing is committed.
--
-- Claim: affected_entities returns each affected record once; the path explanation is separate and bounded; a result
-- that reaches a limit, or meets a record outside the caller's authority, carries a completeness flag and never says
-- "nothing else is affected", and the hidden record's id and name do not leak (Appendix C F04; B section 4 and 7;
-- EV-C02-002 DM-35 as narrowed by EV-C02-008 5.1: the node outside authority is an exam record, never the Work;
-- W-C02-09 points 7 and 8). Phase C4b adds F04-e-exam, F04-c-sin, F04-m3 and F04-m4 (EV-C02-008 5.1's table).
-- Specification: tests/C02/W-C02-07/T-W07-F04_affected_records.md.
-- Runs: in devos-test by the migration job's test step as postgres, calls as anon with a token's header simulated
-- (sql-set-role); with its breaks on the throwaway database. Interface assumed: the specification's.
-- Safety: no psql meta-command; stops at its first error.
-- Revised under ledger rule 3, 2026-10-19 (N-291; EV-C02-013 section 17 (5) and 19 (5)), before any result of this
-- file: F04-m4-cal's two ordinary work items sit under a Mission opened through open_mission, so that Rule O can read
-- its creation event; see the specification's "Revision under ledger rule 3 (N-291, 2026-10-19)".
-- Revised under ledger rule 3, 2026-10-19 (N-292; EV-C02-017 4 (e); EV-C02-013 22 (4)), before any result of the
-- corrective migration: ten F04-dir-* cases, the walks' direction per relation type and a NULL-type relation, in a
-- block of their own after the earlier cases; see the specification's "Revision under ledger rule 3 (N-292, 2026-10-19)".
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
      if jsonb_typeof(v) = 'null' then parts := parts || format('%I => null::%s', innames[i], typ);
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
              else coalesce('raised ' || (c->>'error'), 'returned ' || left(coalesce(c->>'result', 'null'), 200))
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

-- Graph helpers (F04 and K05). An edge x -> y is a relation row from_ref = x, to_ref = y, of type derived_from,
-- descriptive (hard = false): x is derived from y, so a change of y affects x. affected_entities(root) returns the
-- records that reach root along such edges (interface assumed; see the specification).
create temp table w07_edges (g text, x uuid, y uuid);
create temp table w07_nodes (g text, name text, ref uuid, primary key (g, name));

-- Phase C4b: each node is a record, a work item planted by the owner (Appendix C F04: "a small graph of 55 records"), so
-- that a root or target names a record: a root that names no record is F04-m1's case (W-C02-09 point 7; G2 item 4).
create function pg_temp.w07_n(p_g text, p_name text) returns uuid language plpgsql as $f$
declare r uuid;
begin
  select ref into r from w07_nodes where g = p_g and name = p_name;
  if r is null then
    r := (pg_temp.w07_plant('devos_private.work_revision', jsonb_build_object('purpose',
            'w07_fixture_node_' || p_g || '_' || p_name || ' SYNTHETIC W-C02-07')) ->> 'work_id')::uuid;
    insert into w07_nodes values (p_g, p_name, r);
  end if;
  return r;
end $f$;

create function pg_temp.w07_edge(p_g text, p_from text, p_to text) returns void language plpgsql as $f$
declare x uuid := pg_temp.w07_n(p_g, p_from); y uuid := pg_temp.w07_n(p_g, p_to);
begin
  perform pg_temp.w07_plant('devos_private.relation', jsonb_build_object('type', 'derived_from', 'from_ref', x,
    'from_revision', 1, 'to_ref', y, 'to_revision', 1, 'hard', false, 'scope', 'synthetic.w07fixture',
    'method', 'recorded', 'epistemic_status', 'inference', 'validity', 'current'));
  insert into w07_edges values (p_g, x, y);
end $f$;

-- The refs in a result: a list (a set-returning function's rows, or a "records" list) of uuids or of objects with
-- ref, entity_ref or id.
create function pg_temp.w07_refs(c jsonb) returns text[] language sql as $f$
  select coalesce(array_agg(case when jsonb_typeof(e) = 'string' then e #>> '{}' else coalesce(e->>'ref', e->>'entity_ref', e->>'id') end), '{}')
    from jsonb_array_elements(case when jsonb_typeof(c->'result') = 'array' then c->'result'
                                   when jsonb_typeof(c->'result'->'records') = 'array' then c->'result'->'records'
                                   else '[]'::jsonb end) e
$f$;

-- The completeness flag: true, false, or null when absent.
create function pg_temp.w07_complete(c jsonb) returns boolean language sql as $f$
  select case when jsonb_typeof(c->'result'->'complete') = 'boolean' then (c->'result'->>'complete')::boolean
              when c->'result' ? 'completeness' then c->'result'->>'completeness' = 'complete'
              else null end
$f$;

create function pg_temp.w07_unique(a text[]) returns boolean language sql as $f$
  select count(*) = count(distinct x) from unnest(a) x
$f$;

-- The graph's records, root excluded, as text.
create function pg_temp.w07_graph(p_g text, p_root text) returns text[] language sql as $f$
  select coalesce(array_agg(ref::text order by ref), '{}') from w07_nodes where g = p_g and name <> p_root
$f$;

-- One explain_paths call judged: at least one path, at most p_max, each path joining root and target through
-- fixture edges. Paths are lists of refs, or objects with nodes or refs.
create function pg_temp.w07_paths_ok(p_g text, p_root uuid, p_target uuid, p_max int, p_tok text) returns jsonb
language plpgsql as $f$
declare c jsonb; p jsonb; nodes text[]; i int; good boolean := true; n int := 0;
begin
  c := pg_temp.w07_call('explain_paths', jsonb_build_object('root', p_root, 'target', p_target,
         'limits', jsonb_build_object('max_paths', p_max, 'max_depth', 100)), p_tok);
  if c ? 'interface' or pg_temp.w07_refused(c) then
    return jsonb_build_object('ok', null, 'why', pg_temp.w07_show(c));
  end if;
  for p in select * from jsonb_array_elements(case when jsonb_typeof(c->'result'->'paths') = 'array'
                                                    then c->'result'->'paths' else '[]' end) loop
    n := n + 1;
    nodes := array(select case when jsonb_typeof(e) = 'string' then e #>> '{}' else coalesce(e->>'ref', e->>'id') end from jsonb_array_elements(
               case when jsonb_typeof(p) = 'array' then p else coalesce(p->'nodes', p->'refs', '[]') end) e);
    if array_length(nodes, 1) is null or
       not ((nodes[1] = p_root::text and nodes[array_length(nodes, 1)] = p_target::text)
         or (nodes[1] = p_target::text and nodes[array_length(nodes, 1)] = p_root::text)) then
      good := false;
    end if;
    for i in 1 .. coalesce(array_length(nodes, 1), 0) - 1 loop
      if not exists (select 1 from w07_edges e where e.g = p_g and ((e.x::text = nodes[i] and e.y::text = nodes[i + 1])
                                                               or (e.y::text = nodes[i] and e.x::text = nodes[i + 1]))) then
        good := false;
      end if;
    end loop;
  end loop;
  return jsonb_build_object('ok', good and n >= 1 and n <= p_max, 'n', n, 'complete', pg_temp.w07_complete(c));
end $f$;

create function pg_temp.w07_pre() returns text language plpgsql as $f$
begin
  if to_regprocedure('devos_private.issue_env_token(text)') is null then return 'devos_private.issue_env_token(text) does not exist'; end if;
  if to_regclass('devos_private.relation') is null then return 'devos_private.relation does not exist'; end if;
  if to_regclass('devos_private.eval_run') is null then return 'devos_private.eval_run does not exist'; end if;
  if to_regclass('devos_private.work_revision') is null then return 'devos_private.work_revision does not exist'; end if;
  if not exists (select 1 from pg_proc p join pg_namespace n on n.oid = p.pronamespace where n.nspname = 'devos_api'
                  and p.proname in ('affected_entities', 'explain_paths') having count(distinct p.proname) = 2) then
    return 'devos_api.affected_entities or devos_api.explain_paths does not exist';
  end if;
  return null;
end $f$;

-- Phase C3 (G10; README section 3 (i)): a missing or unreadable input must be answered "could not check" (status
-- refused, reason_code could_not_check), never with a result ("nothing else is affected") and never folded into
-- another refusal. A raised error, or a call that cannot be formed, is this test's own could_not_check (README 8.1).
create function pg_temp.w07_cnc_answer(p_id text, c jsonb, p_what text) returns void language sql as $f$
  select pg_temp.w07_rec(p_id,
    case when c ? 'interface' or c->>'error' is not null then 'could_not_check'
         when jsonb_typeof(c->'result') = 'object' and c->'result'->>'status' = 'refused'
              and c->'result'->>'reason_code' = 'could_not_check' then 'ok'
         else 'bad' end,
    p_what || ': ' || case when c ? 'interface' or c->>'error' is not null
                           then 'the answer could not be observed in form (README 8.1): ' else '' end
      || pg_temp.w07_show(c) || '; wanted status refused with reason_code could_not_check')
$f$;

-- Phase C4b (EV-C02-008 5.1). A hook the build's record names (README section 8; TABLES G21): an owner-level statement
-- returning the id (text) of a Mission the build treats as the installation's under Rule O (the Mission transfer_mission
-- writes; B:138, B:268; CHK-C02-025 F5). Empty until W-C02-09's record names its form: F04-m4-kur then gives
-- could_not_check, never a pass. The test designer fills it before the first result (the same hook as T-W07-ROC's).
-- Filled before any result (EV-C02-013 section 4, the hook installation_mission, 2026-10-17): as owner, a Mission and
-- its revision 1 on a batu Decision answered at owner level, and one transferred Event on it (aggregate_type
-- mission, a transfer_source of kind mission, source ID INSTALL); its scope synthetic.w07_fixture, so the fixture
-- work items' scopes lie under it (DM-34). One already in the database tested is returned as it is.
create function pg_temp.w07_hook(p_key text) returns text language sql immutable as $f$
  select t.v from (values ('installation_mission', 'with x as (select m.id from devos_private.mission m where exists (select 1 from devos_private.event e where e.aggregate_id = m.id and e.event_type = ''transferred'') order by m.created_at limit 1), d as (insert into devos_private.decision (class, status, answered_revision, answered_at, answered_by, answer_original_tr, answer_interpretation_en) select ''batu''::devos_private.decision_class, ''answered''::devos_private.decision_status, 1, now(), ''w07_fixture SYNTHETIC W-C02-07'', ''w07_fixture SYNTHETIC yanit'', ''w07_fixture SYNTHETIC answer'' where not exists (select 1 from x) returning id), dr as (insert into devos_private.decision_revision (decision_id, revision, question) select d.id, 1, ''w07_fixture SYNTHETIC W-C02-07 decision of the installation Mission stand-in'' from d returning decision_id), m as (insert into devos_private.mission (status) select ''active''::devos_private.mission_status where not exists (select 1 from x) returning id), mr as (insert into devos_private.mission_revision (mission_id, revision, purpose, scope, acceptance, owner_authority) select m.id, 1, ''w07_fixture SYNTHETIC W-C02-07 installation Mission stand-in; not work'', ''synthetic.w07_fixture'', ''w07_fixture SYNTHETIC W-C02-07'', dr.decision_id from m, dr returning mission_id), ev as (insert into devos_private.event (aggregate_type, aggregate_id, aggregate_revision, event_type, payload, role_class, origin) select ''mission'', mr.mission_id, 1, ''transferred'', jsonb_build_object(''transfer_source'', jsonb_build_object(''kind'', ''mission'', ''source_id'', ''INSTALL'', ''path'', ''w07_fixture/INSTALL.md'', ''input_commit'', repeat(''a7'', 20), ''last_commit'', repeat(''a7'', 20), ''sha256'', repeat(''5e'', 32)), ''run_id'', null, ''lacks'', ''[]''::jsonb), ''devos_kurulum'', ''call''::devos_private.event_origin from mr returning aggregate_id) select coalesce((select aggregate_id::text from ev), (select id::text from x))')) t(k, v) where t.k = p_key
$f$;

-- The names (graph p_g) of the refs a result holds; a ref outside the graph is '?'.
create function pg_temp.w07_names(c jsonb, p_g text) returns text[] language sql as $f$
  select coalesce(array_agg(coalesce(n.name, '?') order by coalesce(n.name, '?')), '{}')
    from unnest(pg_temp.w07_refs(c)) r left join w07_nodes n on n.g = p_g and n.ref::text = r
$f$;

-- The answer with each of p_ids replaced by p_label (ids aside), as jsonb; the call's raised error, if any, kept.
create function pg_temp.w07_sub(c jsonb, p_ids text[], p_label text) returns jsonb language plpgsql as $f$
declare s text := coalesce(c->>'result', 'null') || ' | ' || coalesce(c->>'error', '-'); x text;
begin
  foreach x in array p_ids loop
    if x is not null then s := replace(s, x, p_label); end if;
  end loop;
  return to_jsonb(s);
end $f$;

-- The RejectedAttempt rows not in p_before, as a sorted list of [function_name, role_class, reason_code].
create function pg_temp.w07_ra_codes(p_before text[]) returns jsonb language plpgsql as $f$
declare r jsonb;
begin
  execute 'select coalesce(jsonb_agg(jsonb_build_array(x.function_name::text, x.role_class::text, x.reason_code::text)
             order by x.function_name::text, x.role_class::text, x.reason_code::text), ''[]'')
             from devos_private.rejected_attempt x where not x.id::text = any($1)' using p_before into r;
  return r;
end $f$;

-- One call observed and undone (EV-C02-008 5.1's F04-m4: "nothing is written but the refusal's RejectedAttempt row"):
-- the answer, the RejectedAttempt rows it added, and the devos_private tables other than rejected_attempt it changed.
create function pg_temp.w07_observe(p_fn text, p_args jsonb, p_token text) returns jsonb language plpgsql as $f$
declare c jsonb; s0 jsonb; s1 jsonb; ra0 text[]; ra jsonb;
begin
  begin
    ra0 := pg_temp.w07_ids('devos_private.rejected_attempt'); s0 := pg_temp.w07_snap();
    c := pg_temp.w07_call(p_fn, p_args, p_token);
    s1 := pg_temp.w07_snap(); ra := pg_temp.w07_ra_codes(ra0);
    raise exception using errcode = 'P0W07', message = 'w07: undo the call';
  exception when sqlstate 'P0W07' then null;
  end;
  return c || jsonb_build_object('ra', ra, 'changed', to_jsonb(pg_temp.w07_changed(s0, s1, array['rejected_attempt'])));
end $f$;

-- The relate payload (README 8.1: p jsonb with B 3.4's fields), a descriptive relation.
create function pg_temp.w07_rel(p_from text, p_to text) returns jsonb language sql as $f$
  select jsonb_build_object('type', 'about', 'from_ref', p_from, 'from_revision', 1, 'to_ref', p_to, 'to_revision', 1,
    'scope', 'synthetic.w07fixture', 'hard', false, 'method', 'recorded', 'epistemic_status', 'inference')
$f$;

-- Revised under ledger rule 3, before any result (N-291; EV-C02-013 section 17 (5) and 19 (5); 2026-10-19). The Mission
-- F04-m4-cal's ordinary work items sit under, copied from job/w07_f06_state_change_event.sql's
-- pg_temp.f06_rule_o_mission (N-285 (1)). Rule O reads the work item's revision, the Mission revision it names and that
-- Mission's creation event (EV-C02-013 2.3, "What Rule O reads"); a Mission w07_plant makes has no event, so Rule O
-- answers could_not_check and F04-m4-cal's control (an accepted relate between two such items) could not be accepted
-- on a correct build. This Mission is opened through open_mission with the devos_kurulum token, on an owner-planted
-- batu Decision answered at revision 1, scope synthetic.w07fixture (w07_rel's scope). Its creation event is
-- mission_opened, not transferred, so the devos_calisma calls are inside Rule O's cal clause (EV-C02-008 1.7.1).
-- Returns the Mission revision row; raises when it cannot be made, and the caller turns that into could_not_check.
create function pg_temp.w07_rule_o_mission(p_kur text) returns jsonb language plpgsql as $f$
declare dc jsonb; c jsonb; r jsonb;
begin
  dc := pg_temp.w07_plant('devos_private.decision', '{"class": "batu", "status": "answered", "answered_revision": 1}');
  perform pg_temp.w07_plant('devos_private.decision_revision', jsonb_build_object('decision_id', dc->'id', 'revision', 1));
  c := pg_temp.w07_call('open_mission', jsonb_build_object('purpose', 'w07_fixture SYNTHETIC W-C02-07 Rule O mission; not work',
         'scope', 'synthetic.w07fixture', 'owner_authority', dc->'id', 'owner_authority_revision', 1,
         'acceptance', 'w07_fixture SYNTHETIC W-C02-07', 'constraints', '[]'::jsonb), p_kur);
  if c ? 'interface' or c->>'error' is not null or c->'result'->>'status' is distinct from 'ok' then
    raise exception 'the Rule O fixture Mission was not opened: %', pg_temp.w07_show(c);
  end if;
  execute 'select to_jsonb(x) from devos_private.mission_revision x where x.mission_id::text = $1 order by x.revision desc limit 1'
     into r using c->'result'->>'id';
  if r is null then raise exception 'the Rule O fixture Mission has no revision row'; end if;
  return r;
end $f$;

-- F04-m4 for one token (EV-C02-008 5.1, CHK-C02-032 condition 3, CHK-C02-037 F4): relate with the exam record p_e as
-- from_ref and as to_ref, beside p_w (a record Rule O gives this class), refused with nothing written but one
-- RejectedAttempt row; for devos_calisma and devos_kurulum the answer and the recorded reason code equal those of the
-- same call with p_n (an id that names no record) in p_e's place. Control: the same call with p_w2 (another record Rule
-- O gives this class) in p_e's place is accepted, so the end check is reached (CHK-C02-037 F4: no vacuous pass).
create function pg_temp.f04_m4(p_case text, p_class text, p_tok text, p_e text, p_n text, p_w text, p_w2 text)
returns void language plpgsql as $f$
declare c jsonb; d jsonb; ctl jsonb; ok boolean := true; det text := ''; side text; eq boolean;
begin
  ctl := pg_temp.w07_observe('relate', pg_temp.w07_rel(p_w2, p_w), p_tok);
  if ctl ? 'interface' or ctl->>'error' is not null or coalesce(ctl->'result'->>'status', '') <> 'ok' then
    perform pg_temp.w07_rec(p_case, 'could_not_check', format('control: relate between two records Rule O gives %s was not accepted, '
      || 'so the end check is not shown to be reached: %s', p_class, pg_temp.w07_show(ctl)));
    return;
  end if;
  foreach side in array array['from', 'to'] loop
    c := pg_temp.w07_observe('relate', case when side = 'from' then pg_temp.w07_rel(p_e, p_w) else pg_temp.w07_rel(p_w, p_e) end, p_tok);
    d := pg_temp.w07_observe('relate', case when side = 'from' then pg_temp.w07_rel(p_n, p_w) else pg_temp.w07_rel(p_w, p_n) end, p_tok);
    if c ? 'interface' or c->>'error' is not null or d ? 'interface' or d->>'error' is not null then
      perform pg_temp.w07_rec(p_case, 'could_not_check', format('the exam record as %s_ref: the answer could not be observed in form: %s; with an id that names no record: %s',
        side, pg_temp.w07_show(c), pg_temp.w07_show(d)));
      return;
    end if;
    if not (pg_temp.w07_refused(c) and jsonb_array_length(c->'ra') = 1 and c->'ra'->0->>1 = p_class
            and jsonb_array_length(c->'changed') = 0) then
      ok := false;
    end if;
    eq := pg_temp.w07_sub(c, array[p_e], '<end>') = pg_temp.w07_sub(d, array[p_n], '<end>') and c->'ra' = d->'ra';
    if p_class <> 'devos_sinav' and not eq then ok := false; end if;
    det := det || format('%s_ref = the exam record: %s, recorded %s, tables changed %s; with an id that names no record: %s, recorded %s; equal: %s. ',
      side, pg_temp.w07_show(c), c->'ra', c->'changed', pg_temp.w07_show(d), d->'ra', eq);
  end loop;
  perform pg_temp.w07_check(p_case, ok, det || format('(%s; wanted refused, one RejectedAttempt row, nothing else written%s; control accepted)',
    p_class, case when p_class = 'devos_sinav' then '' else ', the answer and reason code of the id that names no record' end));
end $f$;

do $$
declare why text; tok text; i int; c jsonb; refs text[]; want text[]; p jsonb; bad_paths text := ''; h jsonb; h2 jsonb;
        big constant jsonb := '{"max_depth": 100, "max_records": 1000, "max_paths": 10}';
        fn text;  -- phase C3
        -- phase C4b (EV-C02-008 5.1)
        tok_den text; tok_kur text; tok_sin text; hw jsonb; e jsonb; h3 jsonb; d jsonb; p2 jsonb; ok boolean; det text;
        cls text; ctok text; em3 text; n3 text; wc jsonb; wc2 jsonb; ws jsonb; ws2 jsonb; im text; imr text; wk jsonb; wk2 jsonb; rr jsonb;
begin
  why := pg_temp.w07_pre();
  if why is not null then
    perform pg_temp.w07_rec('F04-pre', 'could_not_check', why);
    return;
  end if;
  begin
    tok := pg_temp.w07_token('devos_calisma');
    tok_den := pg_temp.w07_token('devos_denetim'); tok_kur := pg_temp.w07_token('devos_kurulum');
    tok_sin := pg_temp.w07_token('devos_sinav');
    -- (a) the original finding: 18 consecutive diamonds, 55 records and 72 relations; 1,048,573 rows if every path
    -- is carried (Appendix C F04, "Original finding").
    for i in 1 .. 18 loop
      perform pg_temp.w07_edge('a', 'a' || i, 'm' || (i - 1));
      perform pg_temp.w07_edge('a', 'b' || i, 'm' || (i - 1));
      perform pg_temp.w07_edge('a', 'm' || i, 'a' || i);
      perform pg_temp.w07_edge('a', 'm' || i, 'b' || i);
    end loop;
    -- (b) an explanatory cycle: c1 -> r, c2 -> c1, c3 -> c2, c1 -> c3.
    perform pg_temp.w07_edge('b', 'c1', 'r'); perform pg_temp.w07_edge('b', 'c2', 'c1');
    perform pg_temp.w07_edge('b', 'c3', 'c2'); perform pg_temp.w07_edge('b', 'c1', 'c3');
    -- (c) a record outside authority: x -> r, h -> x, y -> h, where h is an exam record, an EvalRun row planted by the
    -- owner as a relation end (DM-35 as narrowed by EV-C02-008 5.1 (a): the exam's own records, never the Work; a graph
    -- no function can make, 5.1 (b)). Its work_ref names a planted work item hw that is on no relation. (c2) the same
    -- shape with h2, an ordinary work item (the positive control).
    hw := pg_temp.w07_plant('devos_private.work_revision', jsonb_build_object('purpose', 'w07_fixture_exam_task_of_h SYNTHETIC W-C02-07'));
    h := pg_temp.w07_plant('devos_private.eval_run', jsonb_build_object('work_ref', hw->'work_id',
           'results', jsonb_build_object('w07_fixture', 'w07_fixture_hidden_node SYNTHETIC W-C02-07')));
    insert into w07_nodes values ('c', 'h', (h->>'id')::uuid);
    perform pg_temp.w07_edge('c', 'x', 'r'); perform pg_temp.w07_edge('c', 'h', 'x'); perform pg_temp.w07_edge('c', 'y', 'h');
    h2 := pg_temp.w07_plant('devos_private.work_revision', jsonb_build_object('purpose', 'w07_fixture_visible_node SYNTHETIC W-C02-07'));
    insert into w07_nodes values ('c2', 'h', (h2->>'work_id')::uuid);
    perform pg_temp.w07_edge('c2', 'x', 'r'); perform pg_temp.w07_edge('c2', 'h', 'x'); perform pg_temp.w07_edge('c2', 'y', 'h');
    -- (e) phase C4b, EV-C02-008 5.1's F04-e-exam: r <- x <- h3 <- y, h3 a work item a planted EvalRun names (DM-24): an
    -- exam task's Work, ordinary for every class (5.1 (a)).
    h3 := pg_temp.w07_plant('devos_private.work_revision', jsonb_build_object('purpose', 'w07_fixture_exam_task SYNTHETIC W-C02-07'));
    perform pg_temp.w07_plant('devos_private.eval_run', jsonb_build_object('work_ref', h3->'work_id',
      'results', jsonb_build_object('w07_fixture', 'SYNTHETIC W-C02-07')));
    insert into w07_nodes values ('e', 'h', (h3->>'work_id')::uuid);
    perform pg_temp.w07_edge('e', 'x', 'r'); perform pg_temp.w07_edge('e', 'h', 'x'); perform pg_temp.w07_edge('e', 'y', 'h');
    -- (d) a deep graph: a chain of 40 below r.
    perform pg_temp.w07_edge('d', 'n1', 'r');
    for i in 2 .. 40 loop perform pg_temp.w07_edge('d', 'n' || i, 'n' || (i - 1)); end loop;
  exception when others then
    perform pg_temp.w07_rec('F04-pre', 'could_not_check', 'fixtures could not be made: ' || sqlstate || ' ' || left(sqlerrm, 200));
    return;
  end;

  -- (a)
  c := pg_temp.w07_call('affected_entities', jsonb_build_object('root', pg_temp.w07_n('a', 'm0'), 'limits', big), tok);
  if c ? 'interface' or pg_temp.w07_refused(c) then
    perform pg_temp.w07_rec('F04-a-' || s, 'could_not_check', pg_temp.w07_show(c)) from unnest(array['rows', 'found', 'complete', 'paths']) s;
  else
    refs := pg_temp.w07_refs(c); want := pg_temp.w07_graph('a', 'm0');
    perform pg_temp.w07_check('F04-a-rows', coalesce(array_length(refs, 1), 0) <= 55 and pg_temp.w07_unique(refs),
      format('%s rows for a graph of 55 records (unique: %s; %s ms)', coalesce(array_length(refs, 1), 0), pg_temp.w07_unique(refs), c->>'ms'));
    perform pg_temp.w07_check('F04-a-found', refs @> want, format('%s of the 54 affected records found', (select count(*) from unnest(want) w where w = any(refs))));
    perform pg_temp.w07_check('F04-a-complete', pg_temp.w07_complete(c) is true, 'completeness flag ' || coalesce(pg_temp.w07_complete(c)::text, 'absent') || ' with limits above the graph''s size');
    for i in 1 .. 18 loop
      foreach why in array array['a' || i, 'm' || i] loop
        p := pg_temp.w07_paths_ok('a', pg_temp.w07_n('a', 'm0'), pg_temp.w07_n('a', why), 3, tok);
        if (p->>'ok') is distinct from 'true' then bad_paths := bad_paths || why || ' ' || p::text || '; '; end if;
      end loop;
    end loop;
    perform pg_temp.w07_check('F04-a-paths', bad_paths = '', coalesce(nullif(bad_paths, ''),
      'a1..a18 and m1..m18 each have 1 to 3 explanatory paths, each joining m0 and the record through fixture relations'));
  end if;
  p := pg_temp.w07_paths_ok('a', pg_temp.w07_n('a', 'm0'), pg_temp.w07_n('a', 'm18'), 3, tok);
  perform pg_temp.w07_check('F04-a-bounded', case when p ? 'why' then null else (p->>'ok')::boolean and (p->>'complete') = 'false' end,
    'explain_paths(m0, m18) with max_paths 3, where 262,144 paths exist: ' || p::text);

  -- (b)
  c := pg_temp.w07_call('affected_entities', jsonb_build_object('root', pg_temp.w07_n('b', 'r'), 'limits', big), tok);
  refs := pg_temp.w07_refs(c);
  perform pg_temp.w07_check('F04-b-rows', case when c ? 'interface' or pg_temp.w07_refused(c) then null
      else coalesce(array_length(refs, 1), 0) = 3 and pg_temp.w07_unique(refs) and refs @> pg_temp.w07_graph('b', 'r') end,
    pg_temp.w07_show(c) || format('; %s rows for c1, c2, c3 (unique: %s)', coalesce(array_length(refs, 1), 0), pg_temp.w07_unique(refs)));

  -- (c) The node outside authority is an exam record (EV-C02-008 5.1). F04-c-noleak with the working, audit and
  -- devos_kurulum tokens: no result holds h's id or its marker; F04-c-flag (working token): complete = false.
  foreach cls in array array['devos_calisma', 'devos_denetim', 'devos_kurulum'] loop
    ctok := case cls when 'devos_calisma' then tok when 'devos_denetim' then tok_den else tok_kur end;
    c := pg_temp.w07_call('affected_entities', jsonb_build_object('root', pg_temp.w07_n('c', 'r'), 'limits', big), ctok);
    if c ? 'interface' or pg_temp.w07_refused(c) then
      perform pg_temp.w07_rec('F04-c-noleak', 'could_not_check', cls || ': ' || pg_temp.w07_show(c));
      if cls = 'devos_calisma' then perform pg_temp.w07_rec('F04-c-flag', 'could_not_check', pg_temp.w07_show(c)); end if;
    else
      perform pg_temp.w07_check('F04-c-noleak', position((h->>'id') in coalesce(c->>'result', '')) = 0
          and position('w07_fixture_hidden_node' in coalesce(c->>'result', '')) = 0,
        cls || ': the exam record''s id or marker ' || case when position((h->>'id') in coalesce(c->>'result', '')) > 0
          or position('w07_fixture_hidden_node' in coalesce(c->>'result', '')) > 0 then 'appears' else 'does not appear' end || ' in the result');
      if cls = 'devos_calisma' then
        perform pg_temp.w07_check('F04-c-flag', pg_temp.w07_complete(c) is false,
          'completeness flag ' || coalesce(pg_temp.w07_complete(c)::text, 'absent') || ' where a record outside the caller''s authority was met');
      end if;
    end if;
  end loop;
  -- F04-c-sin (EV-C02-008 5.1's table): the same graph with the exam token: h found, complete = true; the filter goes by
  -- class and is not a blanket drop.
  c := pg_temp.w07_call('affected_entities', jsonb_build_object('root', pg_temp.w07_n('c', 'r'), 'limits', big), tok_sin);
  refs := pg_temp.w07_refs(c);
  perform pg_temp.w07_check('F04-c-sin', case when c ? 'interface' or pg_temp.w07_refused(c) then null
      else (h->>'id') = any(refs) and pg_temp.w07_complete(c) is true end,
    'devos_sinav on the graph with the exam record: ' || pg_temp.w07_show(c) || format('; the exam record %s, completeness flag %s (wanted found, true)',
      case when (h->>'id') = any(refs) then 'found' else 'not found' end, coalesce(pg_temp.w07_complete(c)::text, 'absent')));
  d := pg_temp.w07_call('affected_entities', jsonb_build_object('root', pg_temp.w07_n('c2', 'r'), 'limits', big), tok);
  refs := pg_temp.w07_refs(d);
  perform pg_temp.w07_check('F04-c-pos', case when d ? 'interface' or pg_temp.w07_refused(d) then null
      else refs @> pg_temp.w07_graph('c2', 'r') and coalesce(array_length(refs, 1), 0) = 3 and pg_temp.w07_complete(d) is true end,
    pg_temp.w07_show(d) || '; the same shape with an ordinary work item in the exam record''s place: x, h and y expected, complete');

  -- F04-e-exam (EV-C02-008 5.1's table; working token): the walk from r gives x, h3 and y, complete, in the form of
  -- F04-c-pos's answer (d); explain_paths(r, h3) gives its path, with F04-c-pos's flag; with h3 as root, the answer has
  -- the form of the one with F04-c-pos's h2 as root.
  c := pg_temp.w07_call('affected_entities', jsonb_build_object('root', pg_temp.w07_n('e', 'r'), 'limits', big), tok);
  if c ? 'interface' or pg_temp.w07_refused(c) or d ? 'interface' or pg_temp.w07_refused(d) then
    perform pg_temp.w07_rec('F04-e-exam', 'could_not_check', 'from r: ' || pg_temp.w07_show(c) || '; F04-c-pos''s: ' || pg_temp.w07_show(d));
  else
    ok := pg_temp.w07_names(c, 'e') = array['h', 'x', 'y'] and pg_temp.w07_complete(c) is true
          and pg_temp.w07_names(c, 'e') = pg_temp.w07_names(d, 'c2') and pg_temp.w07_complete(c) = pg_temp.w07_complete(d)
          and (select array_agg(k order by k) from jsonb_object_keys(c->'result') k) = (select array_agg(k order by k) from jsonb_object_keys(d->'result') k);
    det := format('from r: %s, complete %s; F04-c-pos''s: %s, complete %s', pg_temp.w07_names(c, 'e'), coalesce(pg_temp.w07_complete(c)::text, 'absent'),
                  pg_temp.w07_names(d, 'c2'), coalesce(pg_temp.w07_complete(d)::text, 'absent'));
    p := pg_temp.w07_paths_ok('e', pg_temp.w07_n('e', 'r'), pg_temp.w07_n('e', 'h'), 3, tok);
    p2 := pg_temp.w07_paths_ok('c2', pg_temp.w07_n('c2', 'r'), pg_temp.w07_n('c2', 'h'), 3, tok);
    if p ? 'why' or p2 ? 'why' then
      ok := null; det := det || '; explain_paths could not be observed: ' || p::text || ' / ' || p2::text;
    else
      ok := ok and (p->>'ok')::boolean and (p->>'complete') is not distinct from (p2->>'complete');
      det := det || '; explain_paths(r, h3): ' || p::text || ', with h2: ' || p2::text;
    end if;
    c := pg_temp.w07_call('affected_entities', jsonb_build_object('root', pg_temp.w07_n('e', 'h'), 'limits', big), tok);
    d := pg_temp.w07_call('affected_entities', jsonb_build_object('root', pg_temp.w07_n('c2', 'h'), 'limits', big), tok);
    if c ? 'interface' or d ? 'interface' or c->>'error' is not null or d->>'error' is not null then
      ok := null; det := det || '; with h3 or h2 as root the answer could not be observed: ' || pg_temp.w07_show(c) || ' / ' || pg_temp.w07_show(d);
    else
      ok := ok and pg_temp.w07_refused(c) = pg_temp.w07_refused(d) and pg_temp.w07_names(c, 'e') = pg_temp.w07_names(d, 'c2')
            and pg_temp.w07_complete(c) is not distinct from pg_temp.w07_complete(d)
            and coalesce(c->'result'->>'reason_code', '') = coalesce(d->'result'->>'reason_code', '');
      det := det || format('; with h3 as root: %s, complete %s; with h2 as root: %s, complete %s', pg_temp.w07_names(c, 'e'),
        coalesce(pg_temp.w07_complete(c)::text, 'absent'), pg_temp.w07_names(d, 'c2'), coalesce(pg_temp.w07_complete(d)::text, 'absent'));
    end if;
    perform pg_temp.w07_check('F04-e-exam', ok, det || ' (wanted x, h3 and y, complete, as F04-c-pos''s)');
  end if;

  -- F04-m3 (EV-C02-008 5.1 (b) and its table; working token): a root that names a planted EvalRun gets the answer and
  -- the recorded reason code of a root that names no record (F04-m1's call), in affected_entities and explain_paths.
  begin
    em3 := (pg_temp.w07_plant('devos_private.eval_run', jsonb_build_object('work_ref', (pg_temp.w07_plant('devos_private.work_revision',
             jsonb_build_object('purpose', 'w07_fixture_exam_task_m3 SYNTHETIC W-C02-07')))->'work_id',
             'results', jsonb_build_object('w07_fixture', 'SYNTHETIC W-C02-07'))))->>'id';
  exception when others then
    em3 := null; det := sqlstate || ' ' || left(sqlerrm, 160);
  end;
  if em3 is null then
    perform pg_temp.w07_rec('F04-m3', 'could_not_check', 'the exam record could not be planted: ' || det);
  else
    ok := true; det := '';
    foreach fn in array array['affected_entities', 'explain_paths'] loop
      n3 := gen_random_uuid()::text;
      c := pg_temp.w07_observe(fn, jsonb_build_object('root', em3, 'limits', big)
             || case when fn = 'explain_paths' then jsonb_build_object('target', pg_temp.w07_n('a', 'm1')) else '{}' end, tok);
      p := pg_temp.w07_observe(fn, jsonb_build_object('root', n3, 'limits', big)
             || case when fn = 'explain_paths' then jsonb_build_object('target', pg_temp.w07_n('a', 'm1')) else '{}' end, tok);
      if c ? 'interface' or p ? 'interface' or c->>'error' is not null or p->>'error' is not null then
        ok := null;
      elsif not (pg_temp.w07_sub(c, array[em3], '<root>') = pg_temp.w07_sub(p, array[n3], '<root>') and c->'ra' = p->'ra') then
        ok := ok and false;
      end if;
      det := det || format('%s with the exam record as root: %s, recorded %s; with a root that names no record: %s, recorded %s. ',
        fn, pg_temp.w07_show(c), c->'ra', pg_temp.w07_show(p), p->'ra');
    end loop;
    perform pg_temp.w07_check('F04-m3', ok, det || '(wanted equal, ids aside)');
  end if;

  -- F04-m4 (EV-C02-008 5.1's table, CHK-C02-032 condition 3; the work item named per token, CHK-C02-037 F4).
  begin
    e := pg_temp.w07_plant('devos_private.eval_run', jsonb_build_object('work_ref', (pg_temp.w07_plant('devos_private.work_revision',
           jsonb_build_object('purpose', 'w07_fixture_exam_task_m4 SYNTHETIC W-C02-07')))->'work_id',
           'results', jsonb_build_object('w07_fixture', 'SYNTHETIC W-C02-07')));
    -- devos_calisma: ordinary work items (Rule O: any not under the installation's Mission). Revised under ledger rule 3
    -- (N-291, 2026-10-19): under the Rule O Mission, whose creation event Rule O can read.
    rr := pg_temp.w07_rule_o_mission(tok_kur);
    wc := pg_temp.w07_plant('devos_private.work_revision', jsonb_build_object('purpose', 'w07_fixture_m4_cal SYNTHETIC W-C02-07',
            'mission_revision_id', rr->'id'));
    wc2 := pg_temp.w07_plant('devos_private.work_revision', jsonb_build_object('purpose', 'w07_fixture_m4_cal2 SYNTHETIC W-C02-07',
            'mission_revision_id', rr->'id'));
    -- devos_sinav: exam tasks, work items an EvalRun names (Rule O's reading for devos_sinav, EV-C02-008 1.7.1).
    ws := pg_temp.w07_plant('devos_private.work_revision', jsonb_build_object('purpose', 'w07_fixture_m4_sin SYNTHETIC W-C02-07'));
    ws2 := pg_temp.w07_plant('devos_private.work_revision', jsonb_build_object('purpose', 'w07_fixture_m4_sin2 SYNTHETIC W-C02-07'));
    perform pg_temp.w07_plant('devos_private.eval_run', jsonb_build_object('work_ref', ws->'work_id', 'results', '{"w07_fixture": "SYNTHETIC W-C02-07"}'::jsonb));
    perform pg_temp.w07_plant('devos_private.eval_run', jsonb_build_object('work_ref', ws2->'work_id', 'results', '{"w07_fixture": "SYNTHETIC W-C02-07"}'::jsonb));
  exception when others then
    e := null; det := sqlstate || ' ' || left(sqlerrm, 160);
  end;
  if e is null then
    perform pg_temp.w07_rec('F04-m4-' || s, 'could_not_check', 'the fixtures could not be planted: ' || det) from unnest(array['cal', 'sin', 'kur', 'paths']) s;
  else
    perform pg_temp.f04_m4('F04-m4-cal', 'devos_calisma', tok, e->>'id', gen_random_uuid()::text, wc->>'work_id', wc2->>'work_id');
    perform pg_temp.f04_m4('F04-m4-sin', 'devos_sinav', tok_sin, e->>'id', gen_random_uuid()::text, ws->>'work_id', ws2->>'work_id');
    -- devos_kurulum: work items under the installation's Mission (Rule O), through the hook.
    im := pg_temp.w07_hook('installation_mission');
    if coalesce(im, '') = '' then
      perform pg_temp.w07_rec('F04-m4-kur', 'could_not_check', 'the installation''s Mission is marked by a form W-C02-09''s record names '
        || '(CHK-C02-025 F5); pg_temp.w07_hook(''installation_mission'') is empty until then (README section 8; TABLES G21)');
    else
      begin
        execute im into im;
        -- Revision before any result (N-278 (2)): Work's Mission link is work_revision.mission_revision_id, the
        -- Mission's revision (EV-C02-002 DM-02; work_current shows it as mission_ref), so each work item is planted with
        -- its first revision under the installation Mission's current revision, not by an update of the identity row.
        execute 'select id::text from devos_private.mission_revision where mission_id::text = $1 order by revision desc limit 1'
          into imr using im;
        if imr is null then raise exception 'the hook''s Mission % has no revision', im; end if;
        wk := pg_temp.w07_plant('devos_private.work_revision', jsonb_build_object('purpose', 'w07_fixture_m4_kur SYNTHETIC W-C02-07',
                'mission_revision_id', imr));
        wk2 := pg_temp.w07_plant('devos_private.work_revision', jsonb_build_object('purpose', 'w07_fixture_m4_kur2 SYNTHETIC W-C02-07',
                'mission_revision_id', imr));
        perform pg_temp.f04_m4('F04-m4-kur', 'devos_kurulum', tok_kur, e->>'id', gen_random_uuid()::text, wk->>'work_id', wk2->>'work_id');
      exception when others then
        perform pg_temp.w07_rec('F04-m4-kur', 'could_not_check', 'the installation''s work items could not be planted: ' || sqlstate || ' ' || left(sqlerrm, 160));
      end;
    end if;
    -- explain_paths(r, e) against explain_paths(r, n), working token; r an ordinary work item.
    n3 := gen_random_uuid()::text;
    c := pg_temp.w07_observe('explain_paths', jsonb_build_object('root', wc->>'work_id', 'target', e->>'id', 'limits', big), tok);
    p := pg_temp.w07_observe('explain_paths', jsonb_build_object('root', wc->>'work_id', 'target', n3, 'limits', big), tok);
    perform pg_temp.w07_check('F04-m4-paths', case when c ? 'interface' or p ? 'interface' or c->>'error' is not null or p->>'error' is not null then null
        else pg_temp.w07_sub(c, array[e->>'id'], '<target>') = pg_temp.w07_sub(p, array[n3], '<target>') and c->'ra' = p->'ra' end,
      format('explain_paths(r, the exam record): %s, recorded %s; explain_paths(r, an id that names no record): %s, recorded %s (wanted equal, ids aside)',
             pg_temp.w07_show(c), c->'ra', pg_temp.w07_show(p), p->'ra'));
  end if;

  -- (d)
  c := pg_temp.w07_call('affected_entities', jsonb_build_object('root', pg_temp.w07_n('d', 'r'),
         'limits', '{"max_depth": 10, "max_records": 1000, "max_paths": 10}'::jsonb), tok);
  refs := pg_temp.w07_refs(c);
  perform pg_temp.w07_check('F04-d1', case when c ? 'interface' or pg_temp.w07_refused(c) then null
      else pg_temp.w07_complete(c) is false and coalesce(array_length(refs, 1), 0) <= 40 and pg_temp.w07_unique(refs) end,
    format('chain of 40 with max_depth 10: %s rows, completeness flag %s', coalesce(array_length(refs, 1), 0),
           coalesce(pg_temp.w07_complete(c)::text, 'absent')));
  c := pg_temp.w07_call('affected_entities', jsonb_build_object('root', pg_temp.w07_n('d', 'r'),
         'limits', '{"max_depth": 100, "max_records": 5, "max_paths": 10}'::jsonb), tok);
  refs := pg_temp.w07_refs(c);
  perform pg_temp.w07_check('F04-d2', case when c ? 'interface' or pg_temp.w07_refused(c) then null
      else pg_temp.w07_complete(c) is false and coalesce(array_length(refs, 1), 0) <= 5 end,
    format('chain of 40 with max_records 5: %s rows, completeness flag %s', coalesce(array_length(refs, 1), 0),
           coalesce(pg_temp.w07_complete(c)::text, 'absent')));
  -- Phase C3 (G10; point 6 (i)): missing and unreadable input, beside the partial input of (d). (m1, m2) a root that
  -- names no record; (u1, u2) the relation table unreadable: renamed for the call inside a subtransaction that is rolled
  -- back right after it, so the table is back before the next case.
  c := pg_temp.w07_call('affected_entities', jsonb_build_object('root', gen_random_uuid(), 'limits', big), tok);
  perform pg_temp.w07_cnc_answer('F04-m1', c, 'affected_entities with a root that names no record');
  c := pg_temp.w07_call('explain_paths', jsonb_build_object('root', gen_random_uuid(), 'target', pg_temp.w07_n('a', 'm1'),
         'limits', big), tok);
  perform pg_temp.w07_cnc_answer('F04-m2', c, 'explain_paths with a root that names no record');
  foreach fn in array array['affected_entities', 'explain_paths'] loop
    begin
      execute 'alter table devos_private.relation rename to relation_w07_unreadable';
      c := pg_temp.w07_call(fn, jsonb_build_object('root', pg_temp.w07_n('a', 'm0'), 'limits', big)
             || case when fn = 'explain_paths' then jsonb_build_object('target', pg_temp.w07_n('a', 'm1')) else '{}' end, tok);
      raise exception using errcode = 'P0W07', message = 'w07: undo the rename';
    exception
      when sqlstate 'P0W07' then null;
      when others then
        c := jsonb_build_object('interface', 'the relation table could not be made unreadable: ' || sqlstate || ' ' || left(sqlerrm, 150));
    end;
    perform pg_temp.w07_cnc_answer(case when fn = 'affected_entities' then 'F04-u1' else 'F04-u2' end, c,
      fn || ' with the relation table unreadable (renamed for the call)');
  end loop;
end $$;

-- Revised under ledger rule 3, 2026-10-19 (N-292 option B; EV-C02-017 4 (e); EV-C02-013 22 (4)), before any result of
-- the corrective migration: the walks' direction per relation type. An edge is a pair (record changed, record
-- affected): (to_ref, from_ref) for derived_from and the other built types, (from_ref, to_ref) for supports and
-- challenges, both pairs for part_of; a relation whose type is NULL is not walked and makes the result not complete.
-- Each type has a graph of its own with one relation from y to x (two work items planted by the owner, as F04's other
-- nodes): "y supports x" is from_ref y, to_ref x (B 3.4's subject-to-object reading; B:149). No other F04 case changes.
create function pg_temp.f04_dir_edge(p_g text, p_from text, p_to text, p_type text) returns void language plpgsql as $f$
declare x uuid := pg_temp.w07_n(p_g, p_from); y uuid := pg_temp.w07_n(p_g, p_to);
begin
  perform pg_temp.w07_plant('devos_private.relation', jsonb_build_object('from_ref', x, 'from_revision', 1, 'to_ref', y,
    'to_revision', 1, 'hard', false, 'scope', 'synthetic.w07fixture', 'method', 'recorded', 'epistemic_status', 'inference',
    'validity', 'current') || case when p_type is null then '{}'::jsonb else jsonb_build_object('type', p_type) end);
  insert into w07_edges values (p_g, x, y);
end $f$;
-- One walk from p_root: the names (graph p_g) it lists and its completeness flag; 'cnc' when it was not answered in form.
create function pg_temp.f04_dir_walk(p_g text, p_root text, p_tok text) returns jsonb language plpgsql as $f$
declare c jsonb;
begin
  c := pg_temp.w07_call('affected_entities', jsonb_build_object('root', pg_temp.w07_n(p_g, p_root),
         'limits', '{"max_depth": 10, "max_records": 100}'::jsonb), p_tok);
  if c ? 'interface' or pg_temp.w07_refused(c) then return jsonb_build_object('cnc', pg_temp.w07_show(c)); end if;
  return jsonb_build_object('names', to_jsonb(pg_temp.w07_names(c, p_g)), 'complete', pg_temp.w07_complete(c));
end $f$;
-- One explain_paths call from p_root to p_target: the paths as lists of names, and the completeness flag.
create function pg_temp.f04_dir_paths(p_g text, p_root text, p_target text, p_tok text) returns jsonb language plpgsql as $f$
declare c jsonb; ps jsonb;
begin
  c := pg_temp.w07_call('explain_paths', jsonb_build_object('root', pg_temp.w07_n(p_g, p_root), 'target', pg_temp.w07_n(p_g, p_target),
         'limits', '{"max_depth": 10, "max_paths": 3}'::jsonb), p_tok);
  if c ? 'interface' or pg_temp.w07_refused(c) then return jsonb_build_object('cnc', pg_temp.w07_show(c)); end if;
  select coalesce(jsonb_agg(q.names), '[]') into ps from (
    select (select jsonb_agg(coalesce(n.name, '?') order by o.i) from jsonb_array_elements_text(
              case when jsonb_typeof(p) = 'array' then p else coalesce(p->'nodes', p->'refs', '[]') end) with ordinality o(ref, i)
              left join w07_nodes n on n.g = p_g and n.ref::text = o.ref) as names
      from jsonb_array_elements(case when jsonb_typeof(c->'result'->'paths') = 'array' then c->'result'->'paths' else '[]' end) p) q;
  return jsonb_build_object('paths', ps, 'complete', pg_temp.w07_complete(c));
end $f$;
-- Judges two observations against what each must be; either not answered in form makes the case could_not_check.
create function pg_temp.f04_dir_judge(p_id text, a jsonb, a_want jsonb, b jsonb, b_want jsonb, p_what text) returns void
language plpgsql as $f$
begin
  if a ? 'cnc' or b ? 'cnc' then
    perform pg_temp.w07_rec(p_id, 'could_not_check', p_what || ': not answered in form: ' || coalesce(a->>'cnc', '') || ' ' || coalesce(b->>'cnc', ''));
  else
    perform pg_temp.w07_check(p_id, a @> a_want and a_want @> (a - 'cnc') and b @> b_want and b_want @> (b - 'cnc'),
      format('%s: got %s and %s; wanted %s and %s', p_what, a, b, a_want, b_want));
  end if;
end $f$;

do $$
declare tok text; t text; a jsonb; b jsonb; pa jsonb; pb jsonb; okc constant jsonb := '{"complete": true}';
begin
  if exists (select 1 from w07_results where case_id = 'F04-pre') then return; end if;  -- F04-pre is recorded already
  begin
    tok := pg_temp.w07_token('devos_calisma');
    foreach t in array array['supports', 'challenges', 'part_of', 'derived_from'] loop
      perform pg_temp.f04_dir_edge('dir_' || t, 'y', 'x', t);
    end loop;
  exception when others then
    perform pg_temp.w07_rec(c, 'could_not_check', 'the direction fixtures could not be made: ' || sqlstate || ' ' || left(sqlerrm, 200))
      from unnest(array['F04-dir-supports', 'F04-dir-supports-paths', 'F04-dir-challenges', 'F04-dir-challenges-paths',
                        'F04-dir-part_of', 'F04-dir-part_of-paths', 'F04-dir-derived_from', 'F04-dir-derived_from-paths',
                        'F04-dir-null', 'F04-dir-null-paths']) c;
    return;
  end;
  -- supports and challenges (y supports x): a change of y affects x; a change of x does not reach y.
  foreach t in array array['supports', 'challenges'] loop
    perform pg_temp.f04_dir_judge('F04-dir-' || t, pg_temp.f04_dir_walk('dir_' || t, 'y', tok), okc || '{"names": ["x"]}',
      pg_temp.f04_dir_walk('dir_' || t, 'x', tok), okc || '{"names": []}', 'y ' || t || ' x: affected_entities from y, then from x');
    perform pg_temp.f04_dir_judge('F04-dir-' || t || '-paths', pg_temp.f04_dir_paths('dir_' || t, 'y', 'x', tok),
      okc || '{"paths": [["y", "x"]]}', pg_temp.f04_dir_paths('dir_' || t, 'x', 'y', tok), okc || '{"paths": []}',
      'y ' || t || ' x: explain_paths(y, x), then explain_paths(x, y)');
  end loop;
  -- part_of (y part_of x): both directions.
  perform pg_temp.f04_dir_judge('F04-dir-part_of', pg_temp.f04_dir_walk('dir_part_of', 'y', tok), okc || '{"names": ["x"]}',
    pg_temp.f04_dir_walk('dir_part_of', 'x', tok), okc || '{"names": ["y"]}', 'y part_of x: affected_entities from y, then from x');
  perform pg_temp.f04_dir_judge('F04-dir-part_of-paths', pg_temp.f04_dir_paths('dir_part_of', 'y', 'x', tok),
    okc || '{"paths": [["y", "x"]]}', pg_temp.f04_dir_paths('dir_part_of', 'x', 'y', tok), okc || '{"paths": [["x", "y"]]}',
    'y part_of x: explain_paths(y, x), then explain_paths(x, y)');
  -- derived_from (y derived_from x), as built: a change of x affects y; a change of y does not reach x.
  perform pg_temp.f04_dir_judge('F04-dir-derived_from', pg_temp.f04_dir_walk('dir_derived_from', 'x', tok), okc || '{"names": ["y"]}',
    pg_temp.f04_dir_walk('dir_derived_from', 'y', tok), okc || '{"names": []}', 'y derived_from x: affected_entities from x, then from y');
  perform pg_temp.f04_dir_judge('F04-dir-derived_from-paths', pg_temp.f04_dir_paths('dir_derived_from', 'x', 'y', tok),
    okc || '{"paths": [["x", "y"]]}', pg_temp.f04_dir_paths('dir_derived_from', 'y', 'x', tok), okc || '{"paths": []}',
    'y derived_from x: explain_paths(x, y), then explain_paths(y, x)');
  -- A relation whose type is NULL (partial input; EV-C02-013 section 1 item 7 (ii)). relation.type is NOT NULL, so the
  -- constraint is dropped and the row planted inside a subtransaction that is undone right after the four calls. The
  -- type decides the direction, so an edge of unknown type may hide an affected record from either end: it is not
  -- walked, and a walk that meets it from either end is not complete.
  begin
    execute 'alter table devos_private.relation alter column type drop not null';
    perform pg_temp.f04_dir_edge('dir_null', 'y', 'x', null);
    a := pg_temp.f04_dir_walk('dir_null', 'x', tok); b := pg_temp.f04_dir_walk('dir_null', 'y', tok);
    pa := pg_temp.f04_dir_paths('dir_null', 'x', 'y', tok); pb := pg_temp.f04_dir_paths('dir_null', 'y', 'x', tok);
    raise exception using errcode = 'P0W07', message = 'w07: undo the NULL-type plant';
  exception
    when sqlstate 'P0W07' then null;
    when others then
      a := jsonb_build_object('cnc', 'the NULL-type relation could not be planted: ' || sqlstate || ' ' || left(sqlerrm, 150));
      b := a; pa := a; pb := a;
  end;
  perform pg_temp.f04_dir_judge('F04-dir-null', a, '{"complete": false, "names": []}', b, '{"complete": false, "names": []}',
    'a NULL-type relation from y to x: affected_entities from x, then from y');
  perform pg_temp.f04_dir_judge('F04-dir-null-paths', pa, '{"complete": false, "paths": []}', pb, '{"complete": false, "paths": []}',
    'a NULL-type relation from y to x: explain_paths(x, y), then explain_paths(y, x)');
end $$;

select case_id, outcome, detail from w07_results order by case_id;

do $$
declare nb int; nc int; n int;
begin
  select count(*) filter (where outcome = 'bad'), count(*) filter (where outcome = 'could_not_check'), count(*)
    into nb, nc, n from w07_results;
  if nb > 0 then
    raise exception 'W07_F04_AFFECTED_RECORDS FAIL (% bad, % could not check, of %)', nb, nc, n;
  elsif nc > 0 or n = 0 then
    raise exception 'W07_F04_AFFECTED_RECORDS COULD NOT CHECK (% of % could not be checked)', nc, n;
  end if;
  raise notice 'W07_F04_AFFECTED_RECORDS PASS (%/%)', n, n;
end $$;

rollback;
