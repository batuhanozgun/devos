-- Synthetic test data (plan Section 8 item 13): the tokens issued here and the review and verdict planted here are
-- made up inside this transaction; the malformed and unknown tokens are made at run time by cutting an issued token
-- and by changing its last character (README 6); no token is written in this file, printed or stored outside
-- PL/pgSQL variables. No personal or business data. Nothing is committed.
--
-- Claim: a burst of calls without a verified token adds no rows beyond one counted row per function, reason code and
-- hour, whose count grows by one per call; a revoked token is counted, not recorded one by one (EV-C02-002 DM-19 and
-- section 6; EV-C02-003 section 15, row "Calls with no verified token from outside"; EV-C02-004 X-04, X-05).
-- Added under ledger rule 3, 2026-10-19 (N-301): B:270's counted row "changes only during its hour and is exported
-- after it", at mark_exported (DM19B-me-hour) and read_rejected_attempts (DM19B-rr-hour); planted synthetic counted rows.
-- Specification: tests/C02/W-C02-07/T-W07-DM19B_burst_count.md (part A; part B is
-- supabase/migrations/tests/w07_dm19b_burst_over_http.py over the Data API). Serves W-C02-09 point 3.
-- Runs: in devos-test by the migration job's test step as postgres, calls as anon with the header simulated
-- (sql-set-role); with its break on the throwaway database. Safety: no psql meta-command; stops at its first error.
begin;
set local search_path = pg_catalog, pg_temp;
set local statement_timeout = '120s';
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
  if to_regprocedure('devos_private.issue_env_token(text)') is null then return 'devos_private.issue_env_token(text) does not exist'; end if;
  if not exists (select 1 from pg_proc p join pg_namespace n on n.oid = p.pronamespace where n.nspname = 'devos_private' and p.proname = 'revoke_env_token') then return 'devos_private.revoke_env_token does not exist'; end if;
  if to_regclass('devos_private.rejected_attempt') is null then return 'devos_private.rejected_attempt does not exist'; end if;
  if (select count(*) from information_schema.columns where table_schema = 'devos_private' and table_name = 'rejected_attempt'
        and column_name in ('function_name', 'role_class', 'reason_code', 'counted_hour', 'count')) <> 5 then
    return 'devos_private.rejected_attempt lacks one of function_name, role_class, reason_code, counted_hour, count';
  end if;
  if to_regprocedure('devos_api.token_role_class()') is null then return 'devos_api.token_role_class() does not exist'; end if;
  if to_regclass('devos_private.verdict') is null then return 'devos_private.verdict does not exist'; end if;
  return null;
end $f$;

-- Another character of the same class (a digit for a digit, a hex letter for a hex letter, a letter for a letter),
-- so that the token keeps its format and only its value is unknown (README 6).
create function pg_temp.w07_other_char(c text) returns text language sql as $f$
  select case when c ~ '^[0-8]$' or c ~ '^[a-eA-E]$' or c ~ '^[g-yG-Y]$' then chr(ascii(c) + 1)
              when c = '9' then '0' when c = 'f' then 'a' when c = 'F' then 'A' when c = 'z' then 'g' when c = 'Z' then 'G'
              when c = '-' then '_' when c = '_' then '-' else c end
$f$;

-- Rows and total count of one (function, reason code), and rows with a role class other than none.
create function pg_temp.w07_state(p_fn text, p_reason text) returns jsonb language plpgsql as $f$
declare r jsonb;
begin
  execute 'select jsonb_build_object(
             ''rows'', count(*) filter (where reason_code = $2 and role_class::text = ''none''),
             ''total'', coalesce(sum(count) filter (where reason_code = $2 and role_class::text = ''none''), 0),
             ''per_call'', count(*) filter (where role_class::text <> ''none'' or counted_hour is null))
           from devos_private.rejected_attempt where function_name in ($1, ''devos_api.'' || $1)'
     using p_fn, p_reason into r;
  return r;
end $f$;

-- N calls of p_fn with one token form; then the bound: rows added <= hours spanned (1, or 2 across an hour's end),
-- total grown by exactly N, no per-call row, nothing raised, every call refused.
create function pg_temp.w07_burst(p_id text, p_fn text, p_args jsonb, p_token text, p_reason text, p_n int)
returns void language plpgsql as $f$
declare s0 jsonb; s1 jsonb; i int; c jsonb; refused int := 0; raised int := 0; t0 timestamptz; hours int;
        shown text;
begin
  s0 := pg_temp.w07_state(p_fn, p_reason); t0 := clock_timestamp();
  for i in 1 .. p_n loop
    c := pg_temp.w07_call(p_fn, p_args, p_token, 'anon', true);
    if c ? 'interface' then
      perform pg_temp.w07_rec(p_id, 'could_not_check', pg_temp.w07_show(c));
      return;
    end if;
    if pg_temp.w07_refused(c) then refused := refused + 1; end if;
    if c->>'error' is not null then raised := raised + 1; end if;
    if i = 1 then shown := pg_temp.w07_show(c); end if;
  end loop;
  s1 := pg_temp.w07_state(p_fn, p_reason);
  hours := 1 + (date_trunc('hour', clock_timestamp()) > date_trunc('hour', t0))::int;
  perform pg_temp.w07_check(p_id,
    refused = p_n and raised = 0 and (s1->>'rows')::int - (s0->>'rows')::int <= hours
      and (s1->>'total')::bigint - (s0->>'total')::bigint = p_n and (s1->>'per_call')::int = (s0->>'per_call')::int,
    format('%s calls: refused %s, raised %s; counted rows +%s (bound %s); total +%s; per-call rows +%s; first call %s',
      p_n, refused, raised, (s1->>'rows')::int - (s0->>'rows')::int, hours,
      (s1->>'total')::bigint - (s0->>'total')::bigint, (s1->>'per_call')::int - (s0->>'per_call')::int, shown));
end $f$;

do $$
declare why text; t_cal text; t_rev text; t_bad text; t_unk text; fn text; n int := 20; v jsonb; c jsonb;
        ra0 text[]; ra jsonb; i int; forms text[] := array['missing', 'empty', 'malformed', 'unknown', 'revoked'];
        f text; tok text; args jsonb; t_bak text; t_den text; rid text[];
begin
  why := pg_temp.w07_pre();
  if why is not null then
    perform pg_temp.w07_rec('DM19B-pre', 'could_not_check', why);
    return;
  end if;
  begin
    t_cal := pg_temp.w07_token('devos_calisma');
    perform pg_temp.w07_token_mark();
    t_rev := pg_temp.w07_token('devos_calisma');
    perform pg_temp.w07_revoke_since_mark();
    t_bad := left(t_cal, greatest(length(t_cal) / 2, 1));
    t_unk := left(t_cal, length(t_cal) - 1) || pg_temp.w07_other_char(right(t_cal, 1));
    v := pg_temp.w07_plant('devos_private.verdict', jsonb_build_object('result', 'pass', 'review_ref',
      pg_temp.w07_plant('devos_private.review', jsonb_build_object('kind', 'review', 'target_ref', gen_random_uuid(),
        'target_revision', 1, 'use', 'w07_fixture_use_one', 'basis_refs', '[]'::jsonb))->'id'));
  exception when others then
    perform pg_temp.w07_rec('DM19B-pre', 'could_not_check', 'fixtures could not be made: ' || sqlstate || ' ' || left(sqlerrm, 200));
    return;
  end;
  -- two functions, a read function and a state-changing one, so the key's function part is exercised
  foreach fn in array array['token_role_class', 'accept'] loop
    args := case fn when 'accept' then jsonb_build_object('verdict_ref', v->'id', 'accepted_use', 'w07_fixture_use_one')
                    else '{}'::jsonb end;
    foreach f in array forms loop
      tok := case f when 'missing' then null when 'empty' then '' when 'malformed' then t_bad
                    when 'unknown' then t_unk else t_rev end;
      perform pg_temp.w07_burst('DM19B-' || fn || '-' || f, fn, args, tok, f, n);
    end loop;
  end loop;
  -- DM19B-percall (contrast): a verified token refused for its class gets one row per call (3 calls, 3 rows).
  ra0 := pg_temp.w07_ids('devos_private.rejected_attempt');
  for i in 1 .. 3 loop
    c := pg_temp.w07_call('accept', jsonb_build_object('verdict_ref', v->'id', 'accepted_use', 'w07_fixture_use_one'), t_cal);
  end loop;
  ra := pg_temp.w07_ra('accept', ra0);
  if c ? 'interface' then
    perform pg_temp.w07_rec('DM19B-percall', 'could_not_check', pg_temp.w07_show(c));
  else
    perform pg_temp.w07_check('DM19B-percall', (select count(*) from jsonb_array_elements(ra) x
        where x->>'role_class' = 'devos_calisma') = 3,
      format('3 refused calls with a verified devos_calisma token: %s new rows with that role class',
        (select count(*) from jsonb_array_elements(ra) x where x->>'role_class' = 'devos_calisma')));
  end if;
  -- DM19B-pos: the same read function with the verified token is accepted and writes no record.
  ra0 := pg_temp.w07_ids('devos_private.rejected_attempt');
  c := pg_temp.w07_call('token_role_class', '{}', t_cal);
  ra := pg_temp.w07_ra('token_role_class', ra0);
  perform pg_temp.w07_check('DM19B-pos', not pg_temp.w07_refused(c) and position('devos_calisma' in c->>'result') > 0
      and jsonb_array_length(ra) = 0,
    pg_temp.w07_show(c) || '; new records ' || jsonb_array_length(ra));

  -- Added under ledger rule 3, 2026-10-19 (N-301; EV-C02-014 section 11, k09 and k15): B:270's rule for a counted row,
  -- "A counted row changes only during its hour and is exported after it", at the two functions M09-09 builds on it.
  -- Two counted rows are planted by the owner (a synthetic function name, reason code missing, role class none): one
  -- of an hour that has ended (two hours ago) and one of the current hour.
  begin
    rid := array[
      (pg_temp.w07_plant('devos_private.rejected_attempt', jsonb_build_object('function_name', 'w07_fixture_dm19b_past',
        'role_class', 'none', 'reason_code', 'missing', 'count', 3,
        'counted_hour', (date_trunc('hour', now() at time zone 'UTC') - interval '2 hours') at time zone 'UTC'))->>'id'),
      (pg_temp.w07_plant('devos_private.rejected_attempt', jsonb_build_object('function_name', 'w07_fixture_dm19b_now',
        'role_class', 'none', 'reason_code', 'missing', 'count', 3,
        'counted_hour', date_trunc('hour', now() at time zone 'UTC') at time zone 'UTC'))->>'id'),
      -- For DM19B-rr-hour: a counted row of the current hour created before since (one second before the read's
      -- since), whose count holds calls made after it.
      (pg_temp.w07_plant('devos_private.rejected_attempt', jsonb_build_object('function_name', 'w07_fixture_dm19b_open',
        'role_class', 'none', 'reason_code', 'missing', 'count', 3, 'created_at', now() - interval '1 second',
        'counted_hour', date_trunc('hour', now() at time zone 'UTC') at time zone 'UTC'))->>'id')];
    t_bak := pg_temp.w07_token('devos_backup');
    t_den := pg_temp.w07_token('devos_denetim');
  exception when others then
    rid := null;
    perform pg_temp.w07_rec('DM19B-me-hour', 'could_not_check', 'fixtures could not be made: ' || sqlstate);
    perform pg_temp.w07_rec('DM19B-rr-hour', 'could_not_check', 'fixtures could not be made: ' || sqlstate);
  end;
  if rid is not null then
    -- DM19B-me-hour (k09): mark_exported over the two rows' range, with the backup token, marks the row whose hour has
    -- ended (the positive half: a function that marks nothing fails) and leaves the current hour's row unmarked.
    c := pg_temp.w07_call('mark_exported', jsonb_build_object('table', 'rejected_attempt',
      'from_id', least(rid[1]::bigint, rid[2]::bigint), 'to_id', greatest(rid[1]::bigint, rid[2]::bigint)), t_bak);
    t_bak := null;
    if c ? 'interface' or c->>'error' is not null or jsonb_typeof(c->'result') <> 'object' then
      perform pg_temp.w07_rec('DM19B-me-hour', 'could_not_check', pg_temp.w07_show(c));
    else
      perform pg_temp.w07_check('DM19B-me-hour', c->'result'->>'status' = 'ok'
          and (select exported_at is not null from devos_private.rejected_attempt where id = rid[1]::bigint)
          and (select exported_at is null from devos_private.rejected_attempt where id = rid[2]::bigint),
        format('mark_exported, backup token: %s; the ended hour''s row marked %s, the current hour''s row marked %s',
          pg_temp.w07_show(c),
          (select exported_at is not null from devos_private.rejected_attempt where id = rid[1]::bigint),
          (select exported_at is not null from devos_private.rejected_attempt where id = rid[2]::bigint)));
    end if;
    -- DM19B-rr-hour (k15): read_rejected_attempts(since now()), with the audit token, returns the current hour's
    -- counted row created one second before since: its hour is open, so it can hold calls made after since.
    c := pg_temp.w07_call('read_rejected_attempts', jsonb_build_object('since', now()), t_den);
    t_den := null;
    if c ? 'interface' or c->>'error' is not null or jsonb_typeof(c->'result') <> 'object' then
      perform pg_temp.w07_rec('DM19B-rr-hour', 'could_not_check', pg_temp.w07_show(c));
    elsif c->'result'->>'status' <> 'ok' or jsonb_typeof(c->'result'->'rows') <> 'array' then
      perform pg_temp.w07_check('DM19B-rr-hour', false, 'read_rejected_attempts, audit token, not accepted: '
        || coalesce(c->'result'->>'status', '') || ' ' || coalesce(c->'result'->>'reason_code', ''));
    else
      perform pg_temp.w07_check('DM19B-rr-hour', exists (select 1 from jsonb_array_elements(c->'result'->'rows') e
          where e->>'id' = rid[3]),
        format('read_rejected_attempts(since now()), audit token: ok, %s rows; the open hour''s counted row created '
          || 'before since returned: %s', jsonb_array_length(c->'result'->'rows'),
          exists (select 1 from jsonb_array_elements(c->'result'->'rows') e where e->>'id' = rid[3])));
    end if;
  end if;
end $$;

select case_id, outcome, detail from w07_results order by case_id;

do $$
declare nb int; nc int; n int;
begin
  select count(*) filter (where outcome = 'bad'), count(*) filter (where outcome = 'could_not_check'), count(*)
    into nb, nc, n from w07_results;
  if nb > 0 then
    raise exception 'W07_DM19B_BURST_COUNT FAIL (% bad, % could not check, of %)', nb, nc, n;
  elsif nc > 0 or n = 0 then
    raise exception 'W07_DM19B_BURST_COUNT COULD NOT CHECK (% of % could not be checked)', nc, n;
  end if;
  raise notice 'W07_DM19B_BURST_COUNT PASS (%/%)', n, n;
end $$;

rollback;
