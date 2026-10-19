#!/usr/bin/env python3
# w07-needs-database: yes
"""T-W07-CONC: Appendix C "Concurrency" (C02), with EV-C02-002 DM-01's and DM-06's confirming cases.

Synthetic test data (plan Section 8 item 13): every mission, work item, relation, artifact, scope
(synthetic.w07.conc.<run id>), path and session id this program writes is made up, labelled SYNTHETIC W-C02-07, and
holds no personal or business data. Specification: tests/C02/W-C02-07/T-W07-CONC_claim_and_cycle.md.

Run: python3 -I supabase/migrations/tests/w07_conc_claim_and_cycle.py < <one JSON object>  (from the repository root)
  The migration job's devos-test step (README 5.1 (b); EV-C02-003 §6.3; note N-255 on plan/work/C02.md) gives the job's
  one JSON object on standard input (N-255: exactly endpoint, apikey, tokens, revoked_token; none is used here) and,
  since line 2 declares w07-needs-database, runs the program in the step's own libpq
  connection environment for devos-test as postgres; the program never reads, prints or stores a connection value, it
  only passes the environment to psql. It uses no publishable key and none of the job's tokens: it issues its own
  synthetic tokens through its owner connection and revokes each by its env_tokens row ID (README section 8).
  The break harness gives the same four keys with null values and its throwaway database's socket (README 5.2); the
  program reads the database setting w07.throwaway to tell that database apart.
No input, another input form, or no database connection settings give COULD NOT CHECK. It is never run against devos:
with N-255's input form, which names no target, that rests on the job running its programs in the devos-test step only.
Committed fixtures (the executor's decision: allowed in devos-test, forbidden in devos by EV-C02-002 DM-23): one
owner-planted synthetic Decision of class batu with its revision, one Mission, the work items, relations and artifacts
of the runs, and the claims; all labelled SYNTHETIC W-C02-07 and listed in the output.

Transport: several direct connections through psql, each acting as role anon with the x-devos-env-token header set
by set_config (transport sql-set-role, several connections). Tokens: each connection issues its own synthetic token
with devos_private.issue_env_token inside the database, keeps it in a session setting, never in a statement text, a
table or the output; the program revokes it by its env_tokens row ID once every connection of its run has ended
(revised 2026-10-19, N-299 (1): a revocation raises the global authority epoch, so none is made during a run); claim
tokens stay in the same way inside their session. CONC-tokens judges the tokens this program issued, by the env_tokens
row IDs it recorded as it issued them, and counts apart any token issued during its run that it did not record; tokens
already unrevoked before it began (in the job, the tokens step's six) are not its own and are not counted (revised
2026-10-19 under ledger rule 3, CHK-C02-106 C1 route (b); N-304 (4)).
Exit codes: 0 PASS, 1 FAIL, 3 COULD NOT CHECK. The last line is "W07_CONC_CLAIM_AND_CYCLE PASS|FAIL|COULD NOT CHECK (...)"
(README section 3).
"""
import json
import os
import re
import shutil
import subprocess
import sys
import time
import uuid

# Fixed before any run (W-C02-13 point 4; the specification's evidence envelope).
N_CONN = 8          # connections claiming one work item at once
RUNS_CLAIM = 20     # repeated runs of the claim race
RUNS_CYC2 = 20      # runs of two opposing hard dependencies added at once
RUNS_CYC4 = 20      # runs of a cycle of four closed by four edges added at once
RUNS_LATE = 10      # runs of a late effect racing revoke_claim and a new hard dependency
WAIT_S = 60         # longest wait for a barrier or a connection
LOCK_KEY = 20701    # two-integer advisory key space of this test (classid); objid is the run number

HERE = os.path.dirname(os.path.abspath(__file__))
HELPERS_FROM = os.path.join(HERE, 'w07_f01_whole_intent.sql')  # the Group A helpers, from the class-high SQL file
REDACT = re.compile('[-A-Za-z0-9_+/=]{32,}')
NL, TAB = chr(10), chr(9)
WS = " " + chr(9) + chr(10) + chr(11) + chr(12) + chr(13)  # the whitespace class, written without a backslash
# The job's input (note N-255 on plan/work/C02.md, with "The key's source, decided"): one JSON object on standard input
# with exactly the keys endpoint, apikey (a string or null), tokens (role class to token) and revoked_token. Nothing of
# it is printed: a missing or wrong key is named, never a value.
INPUT_KEYS = ("endpoint", "apikey", "tokens", "revoked_token")


def read_input():
    """(the object, None), or (None, the reason by name only)."""
    if sys.stdin is None or sys.stdin.isatty():
        return None, "no JSON object on standard input: the migration job's devos-test step gives it (N-255)"
    try:
        raw = sys.stdin.read()
    except (OSError, ValueError):
        return None, "standard input could not be read"
    if not raw.strip():
        return None, "no JSON object on standard input: the migration job's devos-test step gives it (N-255)"
    try:
        cfg = json.loads(raw)
    except ValueError:
        return None, "the input on standard input is not JSON (N-255)"
    raw = None
    if not isinstance(cfg, dict):
        return None, "the input is not one JSON object (N-255)"
    missing = [k for k in INPUT_KEYS if k not in cfg]
    extra = sum(1 for k in cfg if k not in INPUT_KEYS)
    if missing or extra:
        return None, ("the input's keys are not exactly " + ", ".join(INPUT_KEYS) + " (N-255): missing "
                      + (", ".join(missing) or "none") + "; " + str(extra) + " other key(s), not named")
    if cfg["apikey"] is not None and not isinstance(cfg["apikey"], str):
        return None, "apikey is neither a string nor null (N-255)"
    if not isinstance(cfg["tokens"], dict):
        return None, "tokens is not an object from role class to token (N-255)"
    return cfg, None

NEED = ['devos_private.issue_env_token(text)', 'devos_private.revoke_env_token(*)', 'devos_api.open_mission(jsonb)',
        'devos_api.admit_work(jsonb)', 'devos_api.claim(uuid,text)', 'devos_api.relate(jsonb)',
        'devos_api.revoke_claim(uuid,text)', 'devos_api.register_artifact(text,jsonb)']


def finish(result, detail, code):
    print(f'W07_CONC_CLAIM_AND_CYCLE {result} ({detail})')
    sys.exit(code)


def clean(text):
    """Error text without anything long enough to be a credential (raw-output hygiene, README section 4)."""
    return REDACT.sub('[withheld]', (text or '').strip().replace(NL, ' '))[:300]


def psql_cmd():
    return [shutil.which('psql') or 'psql', '-X', '-q', '-At', '-v', 'VERBOSITY=sqlstate', '-f', '-']


def run_sql(sql, stop_on_error=True, timeout=WAIT_S * 4):
    cmd = psql_cmd() + ['-v', 'ON_ERROR_STOP=%d' % (1 if stop_on_error else 0)]
    p = subprocess.run(cmd, input=sql, capture_output=True, text=True, timeout=timeout)
    return p.returncode, p.stdout, p.stderr


def helpers():
    text = open(HELPERS_FROM, encoding='utf-8').read()
    a = text.index('-- ===== Group A helpers, v1')
    b = text.index('-- ===== end of Group A helpers, v1 =====')
    return text[a:b]


def worker_script(cls, lock_no, call, pre='', prep=''):
    """One racing connection: its own token; optional pre-steps; wait at the barrier; one call; commit.

    Revised under ledger rule 3, 2026-10-19, before any result (note N-299 item (1); CHK-C02-095 C1): the connection no
    longer revokes its own token. revoke_env_token raises the global authority epoch (B:47, B:377), so a revocation made
    as soon as one connection committed changed the epoch while the run's other connections could still judge their
    claims; under N-289 B (a claim of an earlier epoch counts as lapsed) a later loser then counted the winner's claim
    as lapsed and claimed too. The connection prints its token's env_tokens row ID (an ID, not a token), and race()
    revokes every token of the run by that ID only after all of the run's connections have ended."""
    return f"""
do $w$ declare b text[]; i text; begin
  lock table devos_private.env_tokens in share row exclusive mode;  -- this connection's row is the only new one
  select coalesce(array_agg(id::text), '{{}}') into b from devos_private.env_tokens;
  perform set_config('w07.tok', devos_private.issue_env_token('{cls}'), false);
  select id::text into strict i from devos_private.env_tokens where not (id::text = any(b));
  perform set_config('w07.tok_id', i, false);
end $w$;
select 'W07|tid|' || current_setting('w07.tok_id');
{pre}
begin;
select pg_advisory_xact_lock_shared({LOCK_KEY}, {lock_no});
select 'W07|t0|' || extract(epoch from clock_timestamp());
{prep}
select (set_config('request.headers', json_build_object('x-devos-env-token', current_setting('w07.tok'))::text, true) is not null);
set local role anon;
select 'W07|r|' || coalesce(r->>'status', 'null') || '|' || coalesce(r->>'reason_code', '') from (select {call} as r) s;
reset role;
select 'W07|t1|' || extract(epoch from clock_timestamp());
commit;
select 'W07|t2|' || extract(epoch from clock_timestamp());
select set_config('w07.tok', '', false) = '';
select 'W07|done';
"""


UUID_RE = re.compile('^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$')
# The env_tokens row IDs of the racing connections' tokens, as race() collects them, and the number of connections that
# printed none (CONC-tokens; revised 2026-10-19, CHK-C02-106 C1 route (b)). IDs only, never a token or a hash.
ISSUED, NO_TID = [], [0]


def parse(out, err):
    res = {'status': None, 'reason': '', 't0': None, 't2': None, 'tid': None,
           'errors': re.findall('ERROR:[' + WS + ']+([0-9A-Z]{5})', err)}
    for line in out.splitlines():
        parts = line.split('|')
        if parts[0] != 'W07':
            continue
        if parts[1] == 'tid' and len(parts) > 2 and UUID_RE.match(parts[2]):
            res['tid'] = parts[2]
        elif parts[1] == 'r':
            res['status'], res['reason'] = parts[2], parts[3] if len(parts) > 3 else ''
        elif parts[1] in ('t0', 't2'):
            res[parts[1]] = float(parts[2])
    return res


def race(lock_no, scripts):
    """Starts every script behind one barrier, releases them together, returns their parsed results."""
    holder = subprocess.Popen(psql_cmd() + ['-v', 'ON_ERROR_STOP=1'], stdin=subprocess.PIPE,
                              stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL, text=True)
    holder.stdin.write(f'select pg_advisory_lock({LOCK_KEY}, {lock_no});' + NL)
    holder.stdin.flush()  # the holder's session stays idle, holding the lock, until it is told to release it
    lock_q = ("select count(*) filter (where granted and mode = 'ExclusiveLock') || '|' || "
              "count(*) filter (where not granted and mode = 'ShareLock') from pg_locks "
              f"where locktype = 'advisory' and classid = {LOCK_KEY} and objid = {lock_no} and objsubid = 2;")
    deadline = time.time() + WAIT_S
    while time.time() < deadline and run_sql(lock_q)[1].strip().split('|')[0] != '1':
        time.sleep(0.1)
    procs = [subprocess.Popen(psql_cmd() + ['-v', 'ON_ERROR_STOP=0'], stdin=subprocess.PIPE, stdout=subprocess.PIPE,
                              stderr=subprocess.PIPE, text=True) for _ in scripts]
    for p, s in zip(procs, scripts):
        p.stdin.write(s)
        p.stdin.close()
    waiting = 0
    while time.time() < deadline:
        waiting = int((run_sql(lock_q)[1].strip().split('|') + ['0', '0'])[1] or 0)
        if waiting >= len(scripts):
            break
        time.sleep(0.05)
    holder.stdin.write(f'select pg_advisory_unlock({LOCK_KEY}, {lock_no});' + NL)  # every waiting connection starts at once
    holder.stdin.close()
    results = []
    for p in procs:
        try:
            out, err = p.communicate(timeout=WAIT_S * 2)
        except subprocess.TimeoutExpired:
            p.kill()
            out, err = p.communicate()
        results.append(parse(out, err))
    holder.wait()
    # Every connection of the run has ended (each was waited for above): only now are the run's tokens revoked, each by
    # its env_tokens row ID, so no revocation raises the global authority epoch while a connection of the run can still
    # judge its claim (N-299 (1); CHK-C02-095 C1). A token whose ID was not printed stays unrevoked and is counted by
    # CONC-tokens.
    tids = [r['tid'] for r in results if r['tid']]
    ISSUED.extend(tids)
    NO_TID[0] += len(results) - len(tids)
    if tids:
        run_sql('do $v$ declare i text; begin foreach i in array array[' + ', '.join(f"'{t}'" for t in tids)
                + "]::text[] loop execute format('select devos_private.revoke_env_token(%L)', i); end loop; end $v$;" + NL)
    return results, waiting


def overlapped(results):
    """True when at least two connections were inside their transactions at the same time."""
    spans = sorted((r['t0'], r['t2']) for r in results if r['t0'] is not None and r['t2'] is not None)
    return any(spans[i + 1][0] < spans[i][1] for i in range(len(spans) - 1))


def main():
    cfg, why = read_input()
    if cfg is None:
        finish('COULD NOT CHECK', why, 3)
    cfg = None  # nothing of the job's input is used or kept: this program issues its own tokens (README 5.1 (b))
    if not any(os.environ.get(v) for v in ("PGHOST", "PGHOSTADDR", "PGSERVICE", "PGDATABASE")):
        finish('COULD NOT CHECK', 'no database connection settings (libpq environment) given; this program declares '
               'w07-needs-database (N-255)', 3)
    if not shutil.which('psql'):
        finish('COULD NOT CHECK', 'psql is not on the path given', 3)
    rc, out, err = run_sql("select coalesce(current_setting('w07.throwaway', true), '') || '|' || "
                           "exists (select 1 from pg_roles where rolname = 'supabase_admin');")
    if rc != 0:
        finish('COULD NOT CHECK', 'the database could not be reached: ' + clean(err), 3)
    marker, supa = out.strip().split('|')
    if marker == 'yes' and supa == 't':
        finish('COULD NOT CHECK', 'w07.throwaway is yes but role supabase_admin exists: neither the harness database '
               'nor devos-test', 3)
    missing = [n for n in NEED if run_sql(
        f"select not exists (select 1 from pg_proc p join pg_namespace s on s.oid = p.pronamespace "
        f"where s.nspname || '.' || p.proname = '{n[:-3]}');" if n.endswith('(*)')
        else f"select to_regprocedure('{n}') is null;")[1].strip() != 'f']
    if missing:
        finish('COULD NOT CHECK', 'absent: ' + ', '.join(missing), 3)

    run_id = uuid.uuid4().hex[:8]
    scope = f'synthetic.w07.conc.r{run_id}'
    n_work = RUNS_CLAIM + 2 * RUNS_CYC2 + 4 * RUNS_CYC4 + 2 * RUNS_LATE
    setup = ('create temp table w07_results (case_id text primary key, outcome text not null, detail text not null);' + NL
             + helpers() + f"""
create temp table w07_ids (n int, id text, rev int);""" + f"""
do $s$
declare k text; w text; m jsonb; x jsonb; i int;
begin
  perform pg_temp.w07_token_mark();
  k := pg_temp.w07_tok('devos_kurulum'); w := pg_temp.w07_tok('devos_calisma');
  perform set_config('w07.k', k, false); perform set_config('w07.w', w, false);
  m := pg_temp.w07_fixture_mission(k, '{scope}');
  for i in 1..{n_work} loop
    x := pg_temp.w07_fixture_work(w, m, '{scope}');
    insert into w07_ids values (i, x->>'id', (x->>'revision')::int);
  end loop;
end $s$;
select 'W07|id|' || n || '|' || id || '|' || rev from w07_ids order by n;
select 'W07|sid|' || id::text from devos_private.env_tokens where id::text not in (select id from w07_token_marked);
do $s$ begin perform pg_temp.w07_revoke_since_mark();  -- w07.k's and w07.w's rows, by ID (README section 8)
  perform set_config('w07.k', '', false); perform set_config('w07.w', '', false); end $s$;
""")
    # CONC-tokens' baseline (revised under ledger rule 3, 2026-10-19; CHK-C02-106 C1 route (b), N-304 (4)): the row IDs
    # of the env_tokens rows already unrevoked before this program issues any token. They are not this run's: in the
    # migration job they are the tokens step's six, which stay unrevoked until after the programs (README 5.1 (b)). This
    # replaces a time window (every unrevoked token issued from 5 s before the start on), which counted them.
    rc, out, err = run_sql("select 'W07|base|' || coalesce(string_agg(id::text, ','), '') "
                           "from devos_private.env_tokens where revoked_at is null;")
    base = [l[len('W07|base|'):] for l in out.splitlines() if l.startswith('W07|base|')]
    base_ids = [i for i in base[0].split(',') if i] if rc == 0 and len(base) == 1 else None
    if base_ids is None or not all(UUID_RE.match(i) for i in base_ids):
        finish('COULD NOT CHECK', 'the unrevoked env_tokens rows before the run could not be read: ' + clean(err), 3)
    rc, out, err = run_sql(setup)
    ids = [l.split('|')[3:5] for l in out.splitlines() if l.startswith('W07|id|')]
    # The fixtures' two tokens, by their row IDs (the rows issued since the mark that w07_revoke_since_mark revokes).
    setup_tids = [l.split('|')[2] for l in out.splitlines() if l.startswith('W07|sid|') and UUID_RE.match(l.split('|')[2])]
    if rc != 0 or len(ids) != n_work:
        finish('COULD NOT CHECK', 'the committed fixtures could not be written: ' + clean(err), 3)
    ids = [(i, int(r)) for i, r in ids]
    print(f'fixtures: one owner-planted Decision of class batu with its revision, one Mission and {n_work} work items '
          f'under scope {scope} (synthetic, devos-test only; left in place, append-only)')

    cases, errors, nxt = {}, [], 0
    expected_refusal_errors = set()

    def take(k):
        nonlocal nxt
        out_ = ids[nxt:nxt + k]
        nxt += k
        return out_

    # The flat reference form (EV-C02-013 section 1 item 3, D-1; revised before any result, 2026-10-17): a field's
    # Appendix B name holds the record's uuid and '<name without _ref>_revision' its revision.
    def ref(w, name):
        return {f'{name}_ref': w[0], f'{name}_revision': w[1]}

    def relate_call(a, b):
        p = {'type': 'depends_on', **ref(a, 'from'), **ref(b, 'to'), 'hard': True, 'group_mode': 'ALL',
             'scope': scope, 'method': 'recorded', 'epistemic_status': 'observation'}
        return f"devos_api.relate('{json.dumps(p)}'::jsonb)"

    def db_count(sql):
        rc_, o, e = run_sql(sql)
        return int(o.strip()) if rc_ == 0 and o.strip().lstrip('-').isdigit() else None

    # 1. One claim of many concurrent connections; one always succeeds.
    claim_bad, claim_pos_bad, overlap_bad, lock_no = [], [], [], 1
    for run in range(RUNS_CLAIM):
        (w,) = take(1)
        scripts = [worker_script('devos_calisma', lock_no, f"devos_api.claim('{w[0]}'::uuid, 'w07_fixture_session_{i}')")
                   for i in range(N_CONN)]
        res, waiting = race(lock_no, scripts)
        lock_no += 1
        oks = sum(1 for r in res if r['status'] == 'ok')
        active = db_count(f"select count(*) from devos_private.assignment where work_ref = '{w[0]}'::uuid;")
        errors += [e for r in res for e in r['errors']]
        if oks != 1 or active != 1 or any(r['status'] not in ('ok', 'refused') for r in res):
            claim_bad.append(f'run {run + 1}: ok {oks}, assignments {active}, statuses {sorted(str(r["status"]) for r in res)}')
        if oks < 1:
            claim_pos_bad.append(f'run {run + 1}')
        if waiting < N_CONN or not overlapped(res):
            overlap_bad.append(f'run {run + 1}: waiting {waiting}')
    cases['CONC-claim'] = ('bad' if claim_bad else 'ok', f'{RUNS_CLAIM} runs of {N_CONN} connections; exactly one claim each: '
                           + ('; '.join(claim_bad[:5]) or 'yes'))
    cases['CONC-pos'] = ('bad' if claim_pos_bad else 'ok', 'one claim succeeded in every run' if not claim_pos_bad
                         else 'no claim succeeded in ' + ', '.join(claim_pos_bad))
    cases['CONC-overlap'] = ('could_not_check' if overlap_bad else 'ok', 'transactions overlapped in every run' if not overlap_bad
                             else 'overlap not shown: ' + '; '.join(overlap_bad[:5]))

    # 2. Two opposing hard dependencies added at once; 3. a cycle of four closed by four edges at once.
    def cycle_runs(runs, size, case):
        bad = []
        nonlocal lock_no, errors
        for run in range(runs):
            ws = take(size)
            edges = [(ws[i], ws[(i + 1) % size]) for i in range(size)]
            res, waiting = race(lock_no, [worker_script('devos_calisma', lock_no, relate_call(a, b)) for a, b in edges])
            lock_no += 1
            errors += [e for r in res for e in r['errors']]
            id_list = ','.join(f"'{w[0]}'::uuid" for w in ws)
            hard = db_count(f"select count(*) from devos_private.relation where hard and from_ref in ({id_list}) "
                            f"and to_ref in ({id_list});")
            oks = sum(1 for r in res if r['status'] == 'ok')
            if hard is None or hard >= size or oks != size - 1:
                bad.append(f'run {run + 1}: accepted {oks}, hard edges {hard} (a cycle needs {size})')
        cases[case] = ('bad' if bad else 'ok', f'{runs} runs; no cycle of {size} formed: ' + ('; '.join(bad[:5]) or 'yes'))
    cycle_runs(RUNS_CYC2, 2, 'CONC-cyc2')
    cycle_runs(RUNS_CYC4, 4, 'CONC-cyc4')

    # 4. A late effect by the claimant racing revoke_claim and a new hard dependency (DM-01, DM-06).
    late_bad = []
    for run in range(RUNS_LATE):
        w, x = take(2)
        payload = json.dumps({**ref(w, 'work'), 'path': f'w07_fixture/conc_{run_id}_{run}', 'commit': 'a7' * 20,
                              'kind': 'w07_fixture', 'scope': scope, 'declared_session_id': 'w07_fixture_session_e'})
        pre = NL.join(["begin;", "select (set_config('request.headers', json_build_object('x-devos-env-token', "
                       "current_setting('w07.tok'))::text, true) is not null);", "set local role anon;",
                       f"select set_config('w07.ct', coalesce(devos_api.claim('{w[0]}'::uuid, 'w07_fixture_session_e')->>'claim_token', ''), false) <> '';",
                       "reset role;", "commit;"])
        eff = worker_script('devos_calisma', lock_no, f"devos_api.register_artifact(current_setting('w07.ct'), '{payload}'::jsonb)", pre=pre)
        rev = worker_script('devos_denetim', lock_no, "devos_api.revoke_claim(current_setting('w07.aid')::uuid, 'w07_fixture SYNTHETIC W-C02-07 race')",
                            prep=f"select set_config('w07.aid', coalesce((select id::text from devos_private.assignment where work_ref = '{w[0]}'::uuid and status = 'active'), ''), true) is not null;")
        dep = worker_script('devos_calisma', lock_no, relate_call(w, x))
        res, waiting = race(lock_no, [eff, rev, dep])
        lock_no += 1
        errors += [e for r in res for e in r['errors']]
        e, r_, d = res
        if e['status'] == 'ok' and ((r_['status'] == 'ok' and r_['t2'] is not None and e['t0'] is not None and e['t0'] > r_['t2'])
                                    or (d['status'] == 'ok' and d['t2'] is not None and e['t0'] is not None and e['t0'] > d['t2'])):
            late_bad.append(f'run {run + 1}: the effect began after a committed revocation or dependency and was accepted')
        if e['status'] is None or r_['status'] is None or d['status'] is None:
            late_bad.append(f'run {run + 1}: a connection gave no answer')
    cases['CONC-late'] = ('bad' if late_bad else 'ok', f'{RUNS_LATE} runs; no effect of a revoked or blocked claim landed: '
                          + ('; '.join(late_bad[:5]) or 'yes'))

    # 5. The failure frequency DM-01 names: errors other than the expected refusals, over every run.
    counts = {c: errors.count(c) for c in sorted(set(errors))}
    serious = {c: n for c, n in counts.items() if c in ('40P01', '40001', '55P03', '57014')}
    cases['CONC-err'] = ('bad' if counts else 'ok', 'raised errors by SQLSTATE (deadlock 40P01, serialization 40001, '
                         f'lock timeout 55P03, cancel 57014 among them): {counts or "none"}; of which serious {serious or "none"}')

    # Tokens: every token this run issued is revoked (env_tokens' revoked_at, B 3.27). Revised under ledger rule 3,
    # 2026-10-19 (CHK-C02-106 C1 route (b); N-304 (4)): judged by the row IDs this program recorded as it issued its
    # tokens (the fixtures' two, each connection's one), not by a time window. Any other unrevoked row that was not
    # unrevoked before the run (a token of this run whose ID was lost, or another issuer's) is counted apart.
    own = sorted(set(setup_tids + ISSUED))

    def arr(xs):
        return ('array[' + ', '.join(f"'{x}'" for x in xs) + ']::text[]') if xs else "'{}'::text[]"
    rc, out, err = run_sql(
        f"select 'W07|tok|' || count(*) filter (where id::text = any({arr(own)})) || '|' "
        f"|| count(*) filter (where id::text = any({arr(own)}) and revoked_at is null) || '|' "
        f"|| count(*) filter (where revoked_at is null and not (id::text = any({arr(own)})) "
        f"and not (id::text = any({arr(base_ids)}))) from devos_private.env_tokens;")
    tok = [l.split('|')[2:5] for l in out.splitlines() if l.startswith('W07|tok|')]
    tok = [int(v) for v in tok[0]] if rc == 0 and len(tok) == 1 and all(v.isdigit() for v in tok[0]) else None
    detail = (f'{len(own)} tokens this run issued and recorded ({len(setup_tids)} for the fixtures, {len(ISSUED)} for '
              f'the connections; {NO_TID[0]} connections printed no ID); unrevoked before the run, not counted: '
              f'{len(base_ids)}')
    if tok is None:
        cases['CONC-tokens'] = ('could_not_check', 'env_tokens could not be read after the runs: ' + clean(err))
    elif tok[0] != len(own):
        cases['CONC-tokens'] = ('could_not_check', f'of the {len(own)} recorded IDs only {tok[0]} name an env_tokens row; ' + detail)
    elif tok[1]:
        cases['CONC-tokens'] = ('bad', f'synthetic tokens of this run left unrevoked: {tok[1]}; ' + detail)
    elif tok[2]:
        cases['CONC-tokens'] = ('could_not_check', f'recorded tokens left unrevoked: 0; unrecorded tokens issued during '
                                f'the run and unrevoked (its own with a lost ID, or another issuer): {tok[2]}; ' + detail)
    else:
        cases['CONC-tokens'] = ('ok', 'synthetic tokens of this run left unrevoked: 0; ' + detail)

    for cid in sorted(cases):
        print(f'{cid} | {cases[cid][0]} | {clean(cases[cid][1])}')
    nb = sum(1 for o, _ in cases.values() if o == 'bad')
    nc = sum(1 for o, _ in cases.values() if o == 'could_not_check')
    if nb:
        finish('FAIL', f'{nb} bad, {nc} could not check, of {len(cases)}', 1)
    if nc:
        finish('COULD NOT CHECK', f'{nc} of {len(cases)} could not be checked', 3)
    finish('PASS', f'{len(cases)}/{len(cases)}', 0)


if __name__ == '__main__':
    try:
        main()
    except SystemExit:
        raise
    except Exception as exc:  # the program's own failure is never a pass
        finish('COULD NOT CHECK', 'the runner failed: ' + clean(repr(exc)), 3)
