-- Synthetic test data (plan Section 8 item 13): the findings planted here are made up inside this transaction
-- (claim 'w07_fixture SYNTHETIC W-C02-07', source spans naming random uuids, read dates in 2026, scope
-- 'synthetic.w07fixture'); no personal or business data, no library text; the token is kept in a PL/pgSQL variable
-- only. Nothing is committed.
--
-- Claim (Appendix C N09, its C02 part): a finding that carries information that can change cannot become
-- accepted_for_use undated or without a primary source span; a dated finding with a primary span can (B 3.8;
-- EV-C02-002 DM-26). Specification: tests/C02/W-C02-07/T-W07-N09_finding_gate.md. Serves W-C02-09 point 8.
-- Runs: in devos-test by the migration job's test step as postgres; review_finding is called as anon with an audit
-- token's header simulated (sql-set-role); with its break on the throwaway database. Safety: no psql meta-command;
-- stops at its first error.
begin;
set local search_path = pg_catalog, pg_temp;
set local statement_timeout = '60s';
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

create function pg_temp.w07_pre() returns text language plpgsql as $f$
begin
  if to_regprocedure('devos_private.issue_env_token(text)') is null then return 'devos_private.issue_env_token(text) does not exist'; end if;
  if to_regclass('devos_private.finding') is null or to_regclass('devos_private.finding_revision') is null then
    return 'devos_private.finding or devos_private.finding_revision does not exist';
  end if;
  if (select count(*) from information_schema.columns where table_schema = 'devos_private' and table_name = 'finding_revision'
        and column_name in ('source_spans', 'changeable', 'revision', 'finding_id')) <> 4 then
    return 'devos_private.finding_revision lacks one of finding_id, revision, source_spans, changeable';
  end if;
  if not exists (select 1 from pg_proc p join pg_namespace n on n.oid = p.pronamespace where n.nspname = 'devos_api' and p.proname = 'review_finding') then
    return 'devos_api.review_finding does not exist';
  end if;
  return null;
end $f$;

-- Plants a finding (status reviewed, revision 1) with the given spans and changeable flag; returns {id, revision}.
create function pg_temp.w07_finding(p_spans jsonb, p_changeable boolean) returns jsonb language plpgsql as $f$
declare f jsonb; r jsonb;
begin
  f := pg_temp.w07_plant('devos_private.finding', '{"status": "reviewed", "scope": "synthetic.w07fixture"}');
  r := pg_temp.w07_plant('devos_private.finding_revision', jsonb_build_object('finding_id', f->'id', 'revision', 1,
         'claim', 'w07_fixture SYNTHETIC W-C02-07 claim', 'source_spans', p_spans, 'changeable', case when p_changeable then 'yes' else 'no' end,
         'counter_evidence_searched', 'w07_fixture SYNTHETIC: none found'));
  return jsonb_build_object('id', f->'id', 'revision', 1);
end $f$;

create function pg_temp.w07_span(p_primary boolean, p_read date) returns jsonb language sql as $f$
  select jsonb_build_object('source_ref', gen_random_uuid(), 'span', '1-2', 'primary', p_primary)
         || case when p_read is null then '{}'::jsonb else jsonb_build_object('read_at', p_read) end
$f$;

-- One review_finding call to accepted_for_use; p_accept: whether it must succeed.
create function pg_temp.w07_n09_case(p_id text, p_spans jsonb, p_changeable boolean, p_tok text, p_accept boolean)
returns void language plpgsql as $f$
declare fx jsonb; c jsonb; st text;
begin
  begin
    fx := pg_temp.w07_finding(p_spans, p_changeable);
    c := pg_temp.w07_call('review_finding', jsonb_build_object('finding_id', fx->'id', 'revision', fx->'revision',
           'status', 'accepted_for_use'), p_tok);
    execute 'select status::text from devos_private.finding where id::text = $1' using fx->>'id' into st;
    raise exception using errcode = 'P0W07', message = 'w07: undo the case';
  exception when sqlstate 'P0W07' then null;
            when others then
              perform pg_temp.w07_rec(p_id, 'could_not_check', 'the finding could not be planted: ' || sqlstate || ' ' || left(sqlerrm, 160));
              return;
  end;
  if c ? 'interface' then
    perform pg_temp.w07_rec(p_id, 'could_not_check', pg_temp.w07_show(c));
  elsif p_accept then
    perform pg_temp.w07_check(p_id, not pg_temp.w07_refused(c) and st = 'accepted_for_use', pg_temp.w07_show(c) || '; status ' || coalesce(st, 'absent'));
  else
    perform pg_temp.w07_check(p_id, pg_temp.w07_refused(c) and st is distinct from 'accepted_for_use', pg_temp.w07_show(c) || '; status ' || coalesce(st, 'absent'));
  end if;
end $f$;

do $$
declare why text; tok text;
begin
  why := pg_temp.w07_pre();
  if why is not null then
    perform pg_temp.w07_rec('N09-pre', 'could_not_check', why);
    return;
  end if;
  begin
    tok := pg_temp.w07_token('devos_denetim');
  exception when others then
    perform pg_temp.w07_rec('N09-pre', 'could_not_check', 'no token: ' || sqlstate || ' ' || left(sqlerrm, 160));
    return;
  end;
  -- N09-a: changeable, its one primary span undated.
  perform pg_temp.w07_n09_case('N09-a', jsonb_build_array(pg_temp.w07_span(true, null)), true, tok, false);
  -- N09-b: changeable, only secondary spans, dated.
  perform pg_temp.w07_n09_case('N09-b', jsonb_build_array(pg_temp.w07_span(false, date '2026-10-01'),
    pg_temp.w07_span(false, date '2026-10-02')), true, tok, false);
  -- N09-c: changeable, no span at all (no primary span).
  perform pg_temp.w07_n09_case('N09-c', '[]'::jsonb, true, tok, false);
  -- N09-d: changeable, a dated secondary span beside an undated primary one: the primary source is undated.
  perform pg_temp.w07_n09_case('N09-d', jsonb_build_array(pg_temp.w07_span(true, null), pg_temp.w07_span(false, date '2026-10-02')),
    true, tok, false);
  -- N09-pos: the same as N09-a with the primary span dated: accepted.
  perform pg_temp.w07_n09_case('N09-pos', jsonb_build_array(pg_temp.w07_span(true, date '2026-10-01')), true, tok, true);
end $$;

select case_id, outcome, detail from w07_results order by case_id;

do $$
declare nb int; nc int; n int;
begin
  select count(*) filter (where outcome = 'bad'), count(*) filter (where outcome = 'could_not_check'), count(*)
    into nb, nc, n from w07_results;
  if nb > 0 then
    raise exception 'W07_N09_FINDING_GATE FAIL (% bad, % could not check, of %)', nb, nc, n;
  elsif nc > 0 or n = 0 then
    raise exception 'W07_N09_FINDING_GATE COULD NOT CHECK (% of % could not be checked)', nc, n;
  end if;
  raise notice 'W07_N09_FINDING_GATE PASS (%/%)', n, n;
end $$;

rollback;
