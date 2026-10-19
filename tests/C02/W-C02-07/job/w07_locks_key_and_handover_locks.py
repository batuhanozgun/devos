#!/usr/bin/env python3
# w07-needs-database: yes
"""T-W07-LOCKS: two connections get the answers of a serial order: a concurrent first use of one new key, and a
transfer call concurrent with record_handover (EV-C02-018 section 16, decisions 2 and 5; EV-C02-013 section 28 (3) to
(5)); and two concurrent first transfers of the installation's Mission under the one-Mission lock 9004 (N-303's L-403
annotation; EV-C02-018 16 decision 12; EV-C02-013 3.2; added in test round 2, part TC-C, 2026-10-19).

Synthetic test data (plan Section 8 item 13): every effect class, mission, work item, claim, operation, transfer run,
transferred record, hand-over, scope (synthetic.w07.locks.<run id>), path, source ID (W07-FIXTURE-LOCKS-*) and session
id this program writes is made up, labelled SYNTHETIC W-C02-07, and holds no personal or business data.
Specification: tests/C02/W-C02-07/T-W07-LOCKS_key_and_handover_locks.md.

Where it runs: ONLY on the break harness's throwaway database (README 5.2), where it commits. It commits a synthetic
effect class (DM-37 puts the tests' classes on the throwaway database only), an open transfer run and transferred marks,
and at its end the database's one ledger_handed_over event, which closes the transfer functions for good. None of
these may be committed in devos-test, so on a database whose setting w07.throwaway is not yes (or where supabase_admin
exists) it writes nothing and gives COULD NOT CHECK. It is not copied into supabase/migrations/tests/ (the
specification, "Stage and environment").
Run (the harness): python3 -I tests/C02/W-C02-07/job/w07_locks_key_and_handover_locks.py < <one JSON object>
  As README 5.1 (b) and 5.2: N-255's one JSON object on standard input (exactly endpoint, apikey, tokens,
  revoked_token; none is used), and, since line 2 declares w07-needs-database, the database's socket as its only libpq
  environment; the program never reads, prints or stores a connection value.

Transport: several direct connections through psql, each acting as role anon with the x-devos-env-token header set by
set_config (sql-set-role, several connections). Each connection issues its own synthetic environment token inside the
database and keeps it in a session setting, never in a statement text, a table or the output; the program revokes each
by its env_tokens row ID after every connection of its run has ended. The claim token of the prepare_operation case
(one claim, used by two connections, since B 3.12's exact repeat compares the Assignment) goes from the claiming
connection's output pipe into this program's memory and into the two connections' session setting w07.ct through
libpq's PGOPTIONS; it is never put in a statement's text, a table, a file or this program's output.
Exit codes: 0 PASS, 1 FAIL, 3 COULD NOT CHECK. The last line is "W07_LOCKS_KEY_AND_HANDOVER_LOCKS PASS|FAIL|COULD NOT
CHECK (...)" (README section 3).
"""
import hashlib
import json
import os
import re
import shutil
import subprocess
import sys
import time
import uuid

# Fixed before any run (the specification's evidence envelope).
RUNS_PO = 5          # runs of two first uses of one new key of prepare_operation
RUNS_TR = 5          # runs of two first uses of one new transfer key (transfer_artifact)
RUNS_REV = 5         # runs of record_handover called while a closed call is uncommitted (the hand-over rolled back)
WAIT_S = 60          # longest wait for a barrier, a connection or a state to be seen
LOCK_KEY = 20702     # two-integer advisory key space of this test's barriers (classid); objid is the barrier's number
CLOSED = ['begin_transfer_run', 'end_transfer_run', 'transfer_event', 'transfer_artifact', 'transfer_mission',
          'transfer_work', 'transfer_relation', 'transfer_decision', 'transfer_need', 'transfer_finding']

HERE = os.path.dirname(os.path.abspath(__file__))
HELPERS_FROM = os.path.join(HERE, 'w07_f01_whole_intent.sql')  # the Group A helpers, as T-W07-CONC takes them
REDACT = re.compile('[-A-Za-z0-9_+/=]{32,}')
NL = chr(10)
WS = " " + chr(9) + chr(10) + chr(11) + chr(12) + chr(13)  # the whitespace class, written without a backslash
INPUT_KEYS = ("endpoint", "apikey", "tokens", "revoked_token")
URLSAFE = re.compile('^[-A-Za-z0-9_]{16,200}$')
UUID_RE = re.compile('^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$')
NEED = ['devos_private.issue_env_token(text)', 'devos_private.revoke_env_token(*)', 'devos_api.open_mission(jsonb)',
        'devos_api.admit_work(jsonb)', 'devos_api.claim(uuid,text)', 'devos_api.prepare_operation(text,jsonb)',
        'devos_api.record_handover(jsonb)'] + ['devos_api.' + f + '(jsonb)' for f in CLOSED]


def read_input():
    """(the object, None), or (None, the reason by name only). As T-W07-CONC (N-255)."""
    if sys.stdin is None or sys.stdin.isatty():
        return None, "no JSON object on standard input (N-255)"
    try:
        raw = sys.stdin.read()
    except (OSError, ValueError):
        return None, "standard input could not be read"
    try:
        cfg = json.loads(raw) if raw.strip() else None
    except ValueError:
        return None, "the input on standard input is not JSON (N-255)"
    if not isinstance(cfg, dict):
        return None, "the input is not one JSON object (N-255)"
    missing = [k for k in INPUT_KEYS if k not in cfg]
    extra = sum(1 for k in cfg if k not in INPUT_KEYS)
    if missing or extra:
        return None, ("the input's keys are not exactly " + ", ".join(INPUT_KEYS) + " (N-255): missing "
                      + (", ".join(missing) or "none") + "; " + str(extra) + " other key(s), not named")
    return cfg, None


def finish(result, detail, code):
    print(f'W07_LOCKS_KEY_AND_HANDOVER_LOCKS {result} ({detail})')
    sys.exit(code)


def clean(text, limit=300):
    """Text without anything long enough to be a credential (raw-output hygiene, README section 4)."""
    return REDACT.sub('[withheld]', (text or '').strip().replace(NL, ' '))[:limit]


def psql_cmd():
    return [shutil.which('psql') or 'psql', '-X', '-q', '-At', '-v', 'VERBOSITY=sqlstate', '-v', 'ON_ERROR_STOP=0', '-f', '-']


def run_sql(sql, timeout=WAIT_S * 4):
    p = subprocess.run(psql_cmd(), input=sql, capture_output=True, text=True, timeout=timeout)
    return p.returncode, p.stdout, p.stderr


def one(sql):
    rc, out, err = run_sql(sql)
    return out.strip() if rc == 0 and not re.search('ERROR:', err) else None


def hexof(label, n):
    return hashlib.sha256(('w07 locks ' + label).encode()).hexdigest()[:n]


def lit(obj):
    """A JSON value as an SQL literal of type jsonb (no quote in this program's values; doubled if one were)."""
    return "'" + json.dumps(obj).replace("'", "''") + "'::jsonb"


TOKEN_BLOCK = """
do $w$ declare b text[]; i text; begin
  lock table devos_private.env_tokens in share row exclusive mode;  -- this connection's row is the only new one
  select coalesce(array_agg(id::text), '{}') into b from devos_private.env_tokens;
  perform set_config('w07.tok', devos_private.issue_env_token('CLS'), false);
  select id::text into strict i from devos_private.env_tokens where not (id::text = any(b));
  perform set_config('w07.tok_id', i, false);
end $w$;
select 'W07|tid|' || current_setting('w07.tok_id');
"""


def call(label, expr):
    """One call as anon with this connection's token; its answer kept in the setting w07.r_<label> and printed without
    any token (these functions return none): status, reason code, repeat, id and the reason's text."""
    return (f"select (set_config('request.headers', json_build_object('x-devos-env-token', current_setting('w07.tok'))::text, true) is not null);" + NL
            + "set local role anon;" + NL
            + f"select 'W07|t0|{label}|' || extract(epoch from clock_timestamp());" + NL
            + f"select set_config('w07.r_{label}', coalesce(({expr})::text, 'null'), true) is not null;" + NL
            + "reset role;" + NL
            + f"select 'W07|t1|{label}|' || extract(epoch from clock_timestamp());" + NL
            + f"select 'W07|r|{label}|' || coalesce(x->>'status', 'null') || '|' || coalesce(x->>'reason_code', '') || '|' "
            + "|| coalesce(x->>'repeat', '') || '|' || coalesce(x->>'id', '') || '|' || replace(coalesce(x->>'reason', ''), '|', '/') "
            + f"from (select current_setting('w07.r_{label}')::jsonb as x) s;" + NL)


def barrier(no):
    return (f"select pg_advisory_xact_lock_shared({LOCK_KEY}, {no}) is not null;" + NL
            + "select 'W07|tb|' || extract(epoch from clock_timestamp());" + NL)


def script(cls, body, end='commit'):
    return (TOKEN_BLOCK.replace('CLS', cls) + 'begin;' + NL + body + end + ';' + NL
            + "select 'W07|t2|' || extract(epoch from clock_timestamp());" + NL
            + "select set_config('w07.tok', '', false) = '';" + NL + "select 'W07|done';" + NL)


def parse(out, err):
    res = {'r': {}, 't0': {}, 't1': {}, 'tb': None, 't2': None, 'tid': None, 'hid': None, 'ct': None, 'mc': None,
           'iso': None, 'vis': None, 'errors': re.findall('ERROR:[' + WS + ']+([0-9A-Z]{5})', err)}
    for line in out.splitlines():
        p = line.split('|')
        if p[0] != 'W07' or len(p) < 3:
            continue
        if p[1] == 'tid' and UUID_RE.match(p[2]):
            res['tid'] = p[2]
        elif p[1] == 'ct':
            res['ct'] = p[2]
        elif p[1] == 'r' and len(p) >= 8:
            res['r'][p[2]] = {'status': p[3], 'code': p[4], 'repeat': p[5], 'id': p[6], 'reason': '|'.join(p[7:])}
        elif p[1] in ('t0', 't1') and len(p) >= 4:
            res[p[1]][p[2]] = float(p[3])
        elif p[1] in ('tb', 't2'):
            res[p[1]] = float(p[2])
        elif p[1] == 'hid':
            res['hid'] = int(p[2]) if p[2].isdigit() else None
        elif p[1] == 'mc':
            res['mc'] = p[2] if p[2].isdigit() else None
        elif p[1] == 'vis' and len(p) >= 4:  # [part TC-D] the isolation level, and 1 or 0 (an int, never t/true)
            res['iso'] = p[2]
            res['vis'] = p[3] if p[3] in ('0', '1') else None
    return res


# The Missions whose creation event (their first event) is transferred, as transfer_mission's one-Mission check and
# record_handover read the installation's Mission (M09-11:291-296; EV-C02-013 section 4).
MISSIONS_Q = ("select count(*) from (select distinct on (e.aggregate_id) e.event_type from devos_private.event e "
              "where e.aggregate_type = 'mission' order by e.aggregate_id, e.id) f where f.event_type = 'transferred'")


ISSUED, ERRORS = [], []


class Conn:
    """One psql connection running one script; application_name names it for pg_stat_activity."""
    def __init__(self, name, sql, env_extra=None):
        self.name = name
        env = dict(os.environ)
        env['PGAPPNAME'] = name
        env.update(env_extra or {})
        self.p = subprocess.Popen(psql_cmd(), stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE,
                                  text=True, env=env)
        self.p.stdin.write(sql)
        self.p.stdin.close()
        self.res = None

    def done(self):
        if self.res is None:
            try:
                out, err = self.p.communicate(timeout=WAIT_S * 2)
            except subprocess.TimeoutExpired:
                self.p.kill()
                out, err = self.p.communicate()
            self.res = parse(out, err)
            if self.res['tid']:
                ISSUED.append(self.res['tid'])
            ERRORS.extend(self.res['errors'])
        return self.res


def state(conn):
    """'gone' (its psql process has exited), 'barrier' (waiting on this test's barrier), 'wait:<locks>' (waiting on a lock
    inside a devos_api call, with the locks not granted), 'call' (inside a devos_api call, not waiting), or 'other'
    (anything else: not yet connected, or its token's issue). A connection not yet in pg_stat_activity is not gone:
    only its process's exit says so."""
    if conn.p.poll() is not None:
        return 'gone'
    name = conn.name
    q = ("select coalesce((select string_agg(l.locktype || ':' || coalesce(l.classid::text, '') || ':' || "
         "coalesce(l.objid::text, '') || ':' || l.mode, ',') from pg_locks l join pg_stat_activity a on a.pid = l.pid "
         f"where a.application_name = '{name}' and not l.granted), '') || '|' || "
         f"(select count(*) from pg_stat_activity where application_name = '{name}') || '|' || "
         f"coalesce((select (query like '%devos_api.%')::text from pg_stat_activity where application_name = '{name}' "
         "and state = 'active' limit 1), 'false');")
    v = one(q)
    if v is None:
        return 'other'
    locks, n, in_call = (v.split('|') + ['', '', ''])[:3]
    if n == '0':
        return 'other'
    if f'advisory:{LOCK_KEY}:' in locks:
        return 'barrier'
    if in_call != 'true':
        return 'other'
    return 'wait:' + locks if locks else 'call'


def wait_for(conns, ok_states, limit=WAIT_S):
    """Waits until each connection is in one of ok_states (a state's prefix); returns the states seen last, by name."""
    deadline = time.time() + limit
    seen = {}
    while time.time() < deadline:
        seen = {c.name: state(c) for c in conns}
        if all(any(s == o or s.startswith(o) for o in ok_states) for s in seen.values()):
            break
        time.sleep(0.05)
    return seen


class Holder:
    """Holds one barrier (a session advisory lock) until released."""
    def __init__(self, no):
        self.no = no
        self.p = subprocess.Popen(psql_cmd(), stdin=subprocess.PIPE, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL,
                                  text=True)
        self.p.stdin.write(f'select pg_advisory_lock({LOCK_KEY}, {no});' + NL)
        self.p.stdin.flush()
        q = (f"select count(*) from pg_locks where locktype = 'advisory' and classid = {LOCK_KEY} and objid = {no} "
             "and granted and mode = 'ExclusiveLock';")
        deadline = time.time() + WAIT_S
        while time.time() < deadline and one(q) != '1':
            time.sleep(0.05)

    def release(self):
        self.p.stdin.write(f'select pg_advisory_unlock({LOCK_KEY}, {self.no});' + NL)
        self.p.stdin.close()
        self.p.wait(timeout=WAIT_S)


def revoke_issued(since):
    ids = ISSUED[since:]
    if ids:
        run_sql('do $v$ declare i text; begin foreach i in array array[' + ', '.join(f"'{t}'" for t in ids)
                + "]::text[] loop execute format('select devos_private.revoke_env_token(%L)', i); end loop; end $v$;" + NL)
    return len(ISSUED)


def main():
    cfg, why = read_input()
    if cfg is None:
        finish('COULD NOT CHECK', why, 3)
    cfg = None  # nothing of the input is used or kept
    if not any(os.environ.get(v) for v in ("PGHOST", "PGHOSTADDR", "PGSERVICE", "PGDATABASE")):
        finish('COULD NOT CHECK', 'no database connection settings (libpq environment) given; this program declares '
               'w07-needs-database (N-255)', 3)
    if not shutil.which('psql'):
        finish('COULD NOT CHECK', 'psql is not on the path given', 3)
    v = one("select coalesce(current_setting('w07.throwaway', true), '') || '|' || "
            "(exists (select 1 from pg_roles where rolname = 'supabase_admin'))::int;")
    if v is None:
        finish('COULD NOT CHECK', 'the database could not be reached', 3)
    marker, supa = v.split('|')
    if marker != 'yes' or supa != '0':
        finish('COULD NOT CHECK', 'this program commits a ledger hand-over and synthetic effect classes, so it runs only '
               "on the break harness's throwaway database (w07.throwaway = yes, no supabase_admin); nothing was written", 3)
    missing = [n for n in NEED if one(
        f"select not exists (select 1 from pg_proc p join pg_namespace s on s.oid = p.pronamespace "
        f"where s.nspname || '.' || p.proname = '{n[:-3]}');" if n.endswith('(*)')
        else f"select to_regprocedure('{n}') is null;") != 'f']
    if missing:
        finish('COULD NOT CHECK', 'absent: ' + ', '.join(missing), 3)
    if one("select exists (select 1 from devos_private.event where event_type = 'ledger_handed_over') or exists ("
           "select 1 from devos_private.event where aggregate_type = 'mission' and event_type = 'transferred');") != 'f':
        finish('COULD NOT CHECK', 'the database already holds a hand-over or a transferred Mission: this program needs a '
               'fresh throwaway database', 3)
    base = one("select coalesce(string_agg(id::text, ','), '') from devos_private.env_tokens where revoked_at is null;")
    if base is None:
        finish('COULD NOT CHECK', 'the unrevoked env_tokens rows before the run could not be read', 3)
    base_ids = [i for i in base.split(',') if i]

    run_id = uuid.uuid4().hex[:8]
    scope = f'synthetic.w07.locks.r{run_id}'
    ic = hexof('input commit ' + run_id, 40)   # the one input commit of every run and source (EV-C02-013 28 (6))

    def run_args(r):
        return {'run_id': r, 'input_commit': ic, 'manifest_sha256': hexof('manifest ' + r, 64), 'counts': {},
                'phase': 'begun', 'mode': 'ahead'}

    def src(kind, sid):
        return {'kind': kind, 'source_id': sid, 'path': 'w07_fixture/' + sid + '.md', 'input_commit': ic,
                'last_commit': hexof('last ' + sid, 40), 'sha256': hexof('text ' + sid, 64)}

    r0 = f'w07_fixture_locks_{run_id}_open'
    setup = ('create temp table w07_results (case_id text primary key, outcome text not null, detail text not null);' + NL
             + open(HELPERS_FROM, encoding='utf-8').read().split('-- ===== Group A helpers, v1')[1].split(
                 '-- ===== end of Group A helpers, v1 =====')[0].split(NL, 1)[1]
             + 'create temp table w07_ids (n int, id text, rev int);' + NL
             + "do $s$ declare k text; w text; m jsonb; x jsonb; i int; r jsonb; begin" + NL
             + "  perform pg_temp.w07_token_mark();" + NL
             + "  k := pg_temp.w07_tok('devos_kurulum'); w := pg_temp.w07_tok('devos_calisma');" + NL
             + "  perform pg_temp.w07_effect_class();" + NL
             + f"  m := pg_temp.w07_fixture_mission(k, '{scope}');" + NL
             + f"  for i in 1..{RUNS_PO} loop x := pg_temp.w07_fixture_work(w, m, '{scope}');" + NL
             + "    insert into w07_ids values (i, x->>'id', (x->>'revision')::int); end loop;" + NL
             + f"  r := pg_temp.w07_call(k, 'select devos_api.begin_transfer_run($2)', null, {lit(run_args(r0))});" + NL
             + "  if r->>'status' is distinct from 'ok' then raise exception 'w07: the open run was not begun: %',"
             + " coalesce(r->>'reason_code', r->>'w07_raised', r->>'status'); end if;" + NL
             + "end $s$;" + NL
             + "select 'W07|id|' || n || '|' || id || '|' || rev from w07_ids order by n;" + NL
             + "select 'W07|sid|' || id::text from devos_private.env_tokens where id::text not in (select id from w07_token_marked);" + NL
             + "do $s$ begin perform pg_temp.w07_revoke_since_mark(); end $s$;" + NL)
    rc, out, err = run_sql(setup)
    works = [l.split('|')[3:5] for l in out.splitlines() if l.startswith('W07|id|')]
    ISSUED.extend(l.split('|')[2] for l in out.splitlines() if l.startswith('W07|sid|') and UUID_RE.match(l.split('|')[2]))
    if rc != 0 or len(works) != RUNS_PO or re.search('ERROR:', err):
        finish('COULD NOT CHECK', 'the committed fixtures could not be written: ' + clean(err), 3)
    print(f'fixtures (synthetic, throwaway database only): one owner-planted Decision of class batu, one effect class '
          f'w07_fixture_effect, one Mission and {RUNS_PO} work items under scope {scope}, and the open run {r0}')
    cases = {}
    no = [0]

    def nxt():
        no[0] += 1
        return no[0]

    # 1 and 2. Two first uses of one new key: the second, made while the first is uncommitted, waits and then answers
    # the exact repeat (B 3.12; B:257; F01's positive control), not write_failed (EV-C02-013 28 (3), (5)).
    def key_runs(kind, runs):
        bad, cnc, okd = [], [], []
        for i in range(runs):
            n0, b_no = len(ISSUED), nxt()
            extra = {}
            if kind == 'po':
                w = works[i]
                cl = Conn(f'w07_locks_{run_id}_s{b_no}', script('devos_calisma', (
                    "select (set_config('request.headers', json_build_object('x-devos-env-token', current_setting('w07.tok'))::text, true) is not null);" + NL
                    + "set local role anon;" + NL
                    + f"select 'W07|ct|' || coalesce(devos_api.claim('{w[0]}'::uuid, 'w07_fixture_session_locks')->>'claim_token', '');" + NL
                    + "reset role;" + NL)))
                ct = cl.done()['ct']
                cl.res['ct'] = None
                if not ct or not URLSAFE.match(ct):
                    cnc.append(f'run {i + 1}: the work item could not be claimed')
                    revoke_issued(n0)
                    continue
                extra = {'PGOPTIONS': '-c w07.ct=' + ct}
                ct = None
                key = f'w07_fixture_locks_{run_id}_{i}'
                p = {'idempotency_namespace': 'w07_fixture_locks', 'idempotency_key': key, 'effect_class': 'w07_fixture_effect',
                     'target': 'w07_fixture/locks_target', 'expected_base': 'w07_fixture_base_1', 'payload_hash': 'w07_fixture_payload_1',
                     'work_ref': w[0], 'work_revision': int(w[1]), 'read_set': [{'ref': w[0], 'revision': int(w[1])}]}
                expr, cls = f"devos_api.prepare_operation(current_setting('w07.ct'), {lit(p)})", 'devos_calisma'
                count_q = (f"select count(*) from devos_private.operation where idempotency_namespace = 'w07_fixture_locks' "
                           f"and idempotency_key = '{key}';")
            else:
                sid = f'W07-FIXTURE-LOCKS-ART-{run_id}-{i}'
                p = {'run_id': r0, 'transfer_source': src('artifact', sid), 'path': f'w07_fixture/locks_{run_id}_{i}.md',
                     'commit': hexof('artifact ' + sid, 40), 'kind': 'git_file', 'scope': 'installation', 'status': 'current'}
                expr, cls = f"devos_api.transfer_artifact({lit(p)})", 'devos_kurulum'
                count_q = ("select count(*) from devos_private.event where event_type = 'transferred' and "
                           f"payload -> 'transfer_source' ->> 'kind' = 'artifact' and payload -> 'transfer_source' ->> 'source_id' = '{sid}';")
            h = Holder(b_no)
            a = Conn(f'w07_locks_{run_id}_a{b_no}', script(cls, call('k', expr) + barrier(b_no)), extra)
            sa = wait_for([a], ['barrier', 'gone'])[a.name]
            b = Conn(f'w07_locks_{run_id}_b{b_no}', script(cls, call('k', expr)), extra)
            sb = wait_for([b], ['wait:', 'gone'], 15)[b.name]
            h.release()
            ra, rb = a.done(), b.done()
            extra = {}
            revoke_issued(n0)
            cnt = one(count_q)
            xa, xb = ra['r'].get('k', {}), rb['r'].get('k', {})
            d = (f"run {i + 1}: first {xa.get('status')} {xa.get('code', '')} repeat={xa.get('repeat', '')}; second "
                 f"{xb.get('status')} {xb.get('code', '')} repeat={xb.get('repeat', '')} same id={xb.get('id') == xa.get('id')}; "
                 f"records {cnt}; the second was seen {sb}")
            overlap = (sa == 'barrier' and rb['t0'].get('k') is not None and ra['tb'] is not None
                       and rb['t0']['k'] < ra['tb'])
            if xa.get('status') != 'ok' or xa.get('repeat') == 'true' or not overlap:
                cnc.append(d + ('' if overlap else '; the second call was not shown made while the first was uncommitted')
                           + ('' if xa.get('status') == 'ok' else '; the first use was not accepted: ' + clean(xa.get('reason', ''))))
            elif xb.get('status') == 'ok' and xb.get('repeat') == 'true' and xb.get('id') == xa.get('id') and cnt == '1':
                okd.append(d)
            else:
                bad.append(d + ('; ' + clean(xb.get('reason', '')) if xb.get('reason') else ''))
        return bad, cnc, okd

    for kind, runs, cid in (('po', RUNS_PO, 'LOCKS-po-repeat'), ('tr', RUNS_TR, 'LOCKS-tr-repeat')):
        bad, cnc, okd = key_runs(kind, runs)
        cases[cid] = ('bad' if bad else 'could_not_check' if cnc else 'ok',
                      f'{runs} runs (bad {len(bad)}, could not check {len(cnc)}, ok {len(okd)}); the second first use '
                      'answered the repeat of one record: ' + '; '.join((bad or cnc or okd)[:2]))

    # D-010's batu Decision (transfer_mission's owner authority, R1-9) and the installation's Mission, as transferred.
    # One source each: LOCKS-mi-one commits both, and every hand-over transaction below sends their exact repeats
    # (same source and sha256, another run: "A source written in an earlier run with the same hash still answers its
    # record", EV-C02-013 28 (6) "What follows"; D-010 entered ahead, R2-9) [part TC-C, 2026-10-19].
    install_sid = f'W07-FIXTURE-LOCKS-INSTALL-{run_id}'

    def d010(r):
        return {'class': 'batu', 'question': 'w07_fixture SYNTHETIC W-C02-07 transferred decision', 'why_this_owner': 'w07_fixture SYNTHETIC',
                'options': [], 'alternatives_considered': [], 'alternatives_state': 'compared', 'criteria': [], 'evidence_refs': [],
                'assumptions': [], 'premises': [], 'reopen_triggers': [], 'status': 'answered', 'run_id': r,
                'presented_text_tr': 'w07_fixture SYNTHETIC karar', 'answer_original_tr': 'w07_fixture SYNTHETIC yanit',
                'answer_interpretation_en': 'w07_fixture SYNTHETIC answer', 'answered_by': 'w07_fixture SYNTHETIC',
                'answer_channel_ref': 'w07_fixture/channel', 'transfer_source': src('decision', 'D-010')}

    def mission(r, sid):
        return {'run_id': r, 'transfer_source': src('mission', sid),
                'purpose': 'w07_fixture SYNTHETIC W-C02-07 installation mission', 'scope': 'installation',
                'acceptance': 'w07_fixture SYNTHETIC W-C02-07', 'owner_authority_revision': 1, 'constraints': [], 'status': 'active'}

    def d010_call(r):
        return f"devos_api.transfer_decision({lit(d010(r))} || jsonb_build_object('answered_at', now()))"

    def mission_call(r, sid, owner_expr):
        return f"devos_api.transfer_mission({lit(mission(r, sid))} || jsonb_build_object('owner_authority', {owner_expr}))"

    # The hand-over's transaction: a run, D-010's batu Decision, the installation's Mission, then record_handover
    # (EV-C02-013 3.2), each a call as anon with the devos_kurulum token. Once LOCKS-mi-one has committed D-010 and the
    # Mission, h2 and h3 are their exact repeats; each still takes 9005 shared where the decided form puts it (before
    # the closing check, ahead of the key read), so the hand-over still takes 9005 shared, then exclusive (28 (14) L1).
    # [Part TC-D, 2026-10-19] see_run: the run of a closed call held uncommitted (LOCKS-ho-rev). The statement right
    # after record_handover, inside the hand-over's transaction, reads whether that call's begun event is committed:
    # under read committed each statement takes a new snapshot, so it sees the closed call's event if and only if the
    # closed call committed before this statement, that is, before the hand-over's transaction can end.
    def handover_body(tag, see_run=None):
        rh = f'w07_fixture_locks_{run_id}_{tag}_ho'
        ho = {'run_id': rh, 'input_commit': ic, 'mark_commit': hexof('mark ' + rh, 40), 'handed_over_sha256': hexof('handed ' + rh, 64)}
        see = ("select 'W07|vis|' || current_setting('transaction_isolation') || '|' || (exists (select 1 from "
               "devos_private.event where event_type = 'transfer_run' and payload ->> 'run_id' = '" + see_run + "'))::int;"
               + NL) if see_run else ''
        return (call('h1', f"devos_api.begin_transfer_run({lit(run_args(rh))})")
                + call('h2', d010_call(rh))
                + call('h3', mission_call(rh, install_sid, "current_setting('w07.r_h2')::jsonb ->> 'id'"))
                + call('ho', f"devos_api.record_handover({lit(ho)})")
                + see
                + "select 'W07|hid|' || coalesce((select max(id)::text from devos_private.event "
                  "where event_type = 'ledger_handed_over'), '');" + NL)

    def prereq(rh):
        return [f"{k} {rh['r'].get(k, {}).get('status')} {rh['r'].get(k, {}).get('code', '')}" for k in ('h1', 'h2', 'h3')
                if rh['r'].get(k, {}).get('status') != 'ok']

    # 2b. One Mission under two sessions (the lock 9004; N-303's L-403 annotation, EV-C02-018 16 decision 12; EV-C02-013
    # 3.2: "a second transferred Mission: conflict", and its 9004 row; EV-C02-005 2.1). Once, before any hand-over: one
    # database holds one installation Mission. D-010 is committed first, by a connection of its own, so both calls can
    # reach their owner authority. Then two connections each call transfer_mission for a different source ID, naming
    # D-010: the first is held uncommitted, the second is made while it is; the first commits. The second must wait
    # and answer conflict. It is always rolled back, after counting, inside its transaction and after the first's
    # commit, the Missions whose creation event is transferred: had it committed, that many would exist. So the case
    # judges "exactly one accepted, one Mission" and leaves one Mission for the hand-over cases, also under its break.
    n0 = len(ISSUED)
    dc = Conn(f'w07_locks_{run_id}_d', script('devos_kurulum', call('d', d010_call(r0)))).done()
    revoke_issued(n0)
    xd = dc['r'].get('d', {})
    if xd.get('status') != 'ok' or not UUID_RE.match(xd.get('id') or ''):
        cases['LOCKS-mi-one'] = ('could_not_check', f"D-010's Decision was not transferred: {xd.get('status')} "
                                 f"{xd.get('code', '')} {clean(xd.get('reason', ''))}")
    else:
        n0, b_a, b_b = len(ISSUED), nxt(), nxt()
        owner = "'" + xd['id'] + "'"
        ha, hb = Holder(b_a), Holder(b_b)
        a = Conn(f'w07_locks_{run_id}_ma', script('devos_kurulum', call('m', mission_call(r0, install_sid, owner)) + barrier(b_a)))
        sa = wait_for([a], ['barrier', 'gone'])[a.name]
        b = Conn(f'w07_locks_{run_id}_mb', script('devos_kurulum', call('m', mission_call(r0, install_sid + '-SECOND', owner))
                                                    + barrier(b_b) + "select 'W07|mc|' || (" + MISSIONS_Q + ");" + NL,
                                                    end='rollback'))
        sb = wait_for([b], ['wait:', 'barrier', 'gone'], 15)[b.name]
        ha.release()
        ra = a.done()
        hb.release()
        rb = b.done()
        revoke_issued(n0)
        after = one(MISSIONS_Q + ';')
        xa, xb = ra['r'].get('m', {}), rb['r'].get('m', {})
        d = (f"first {xa.get('status')} {xa.get('code', '')} repeat={xa.get('repeat', '')}; second {xb.get('status')} "
             f"{xb.get('code', '')}, seen {sb}; transferred Missions seen by the second after the first committed: "
             f"{rb['mc']}; committed after both: {after}")
        overlap = (sa == 'barrier' and rb['t0'].get('m') is not None and ra['tb'] is not None
                   and rb['t0']['m'] < ra['tb'])
        counted_late = rb['tb'] is not None and ra['t2'] is not None and rb['tb'] > ra['t2']
        if (xa.get('status') != 'ok' or xa.get('repeat') == 'true' or not overlap or not counted_late
                or rb['mc'] is None or after is None or not after.isdigit() or after == '0'):
            cases['LOCKS-mi-one'] = ('could_not_check', d + ('' if overlap else '; the second call was not shown made while '
                                     'the first was uncommitted') + ('' if counted_late else '; the second did not count '
                                     'after the first committed') + ('' if xa.get('status') == 'ok' else
                                     '; the first was not accepted: ' + clean(xa.get('reason', ''))))
        elif xb.get('status') != 'ok' and xb.get('code') == 'conflict' and rb['mc'] == '1' and after == '1':
            cases['LOCKS-mi-one'] = ('ok', d)
        else:
            cases['LOCKS-mi-one'] = ('bad', d + '; not the answers of a serial order (exactly one accepted, one Mission)'
                                     + ('; ' + clean(xb.get('reason', '')) if xb.get('reason') else ''))

    # 3. The reverse order: a closed call (begin_transfer_run) uncommitted, then record_handover. The hand-over waits for
    # the closed call's commit, so the closed call's event precedes the hand-over in commit order as in id order
    # (EV-C02-018 5 (e); EV-C02-013 28 (4)). The hand-over is rolled back, so the case can be repeated. "Commits before
    # it" is judged inside the hand-over's transaction, by the statement right after its call [part TC-D, 2026-10-19].
    bad, cnc, okd = [], [], []
    for i in range(RUNS_REV):
        n0, b_no = len(ISSUED), nxt()
        rc_ = f'w07_fixture_locks_{run_id}_rev{i}'
        h = Holder(b_no)
        c = Conn(f'w07_locks_{run_id}_c{b_no}', script('devos_kurulum', call('c', f"devos_api.begin_transfer_run({lit(run_args(rc_))})")
                                                       + barrier(b_no)))
        sc = wait_for([c], ['barrier', 'gone'])[c.name]
        ho = Conn(f'w07_locks_{run_id}_h{b_no}', script('devos_kurulum', handover_body(f'rev{i}', see_run=rc_), end='rollback'))
        sh = wait_for([ho], ['wait:', 'gone'], 15)[ho.name]
        h.release()
        rcn, rh = c.done(), ho.done()
        revoke_issued(n0)
        cid_ev = one(f"select coalesce(min(id)::text, '') from devos_private.event where event_type = 'transfer_run' "
                     f"and payload ->> 'run_id' = '{rc_}';") or ''
        xc, xh = rcn['r'].get('c', {}), rh['r'].get('ho', {})
        t_ho0, t_ho1 = rh['t0'].get('ho'), rh['t1'].get('ho')
        # [Part TC-D, 2026-10-19] The judgment of "commits before it" is what the hand-over's transaction sees right after
        # its call (rh['vis']), no longer the clocks t1 against t2: t2 is printed by the statement after the closed call's
        # commit, and the hand-over is granted 9005 at that commit, so a correct build can print t1 <= t2. The margins
        # are still printed, as information only.
        mg = ', '.join(f'{n} {t_ho1 - v:+.4f} s' for n, v in (('t1 - tb', rcn['tb']), ('t1 - t2', rcn['t2']))
                       if t_ho1 is not None and v is not None)
        d = (f"run {i + 1}: closed call {xc.get('status')} {xc.get('code', '')}; hand-over {xh.get('status')} {xh.get('code', '')}, "
             f"seen {sh}; the closed call's event committed and seen inside the hand-over's transaction right after its "
             f"call: {rh['vis']} ({rh['iso']}); margins (information only): {mg or 'none'}; event ids: closed call {cid_ev}, "
             f"hand-over {rh['hid']}")
        overlap = (sc == 'barrier' and t_ho0 is not None and rcn['tb'] is not None and t_ho0 < rcn['tb'])
        rc_iso = rh['iso'] == 'read committed'
        k_bad, k_ok, k_cnc = len(bad), len(okd), len(cnc)
        if xc.get('status') != 'ok' or prereq(rh) or not overlap:
            cnc.append(d + '; ' + ', '.join(prereq(rh) or ['the hand-over was not shown called while the closed call was uncommitted']))
        elif t_ho1 is not None and rcn['tb'] is not None and t_ho1 < rcn['tb']:
            bad.append(d + ' (the hand-over did not wait for the closed call)')
        elif xh.get('status') == 'ok' and rc_iso and rh['vis'] == '0' and cid_ev.isdigit():
            bad.append(d + " (record_handover answered ok while the closed call's event was not yet committed: it did not "
                       'wait for the closed call)')
        elif (xh.get('status') == 'ok' and rc_iso and rh['vis'] == '1' and sh.startswith('wait:') and rh['hid']
              and cid_ev.isdigit() and rh['hid'] > int(cid_ev)):
            okd.append(d)
        else:
            why = [w for w, miss in (
                ('the hand-over was refused: ' + clean(xh.get('reason', '')), xh.get('status') != 'ok'),
                ('its transaction is not read committed, so its read right after the call proves nothing', not rc_iso),
                ("its read right after the call gave no answer", rh['vis'] is None),
                ('it was not seen waiting inside its call before the closed call was let commit', not sh.startswith('wait:')),
                ("the closed call's event is not committed, or its id is not below the hand-over's",
                 not (rh['hid'] and cid_ev.isdigit() and rh['hid'] > int(cid_ev)))) if miss]
            cnc.append(d + '; ' + '; '.join(why or ['no rule decided it']))
        # Every run's line, as information (not a case line: no " | " in it, so the harness reads none) [part TC-D].
        for name, lst, n_before in (('bad', bad, k_bad), ('ok', okd, k_ok), ('could_not_check', cnc, k_cnc)):
            if len(lst) > n_before:
                print(f'information (not a case): LOCKS-ho-rev {name}, ' + clean(lst[-1], 700).replace(' | ', ' / '))
    cases['LOCKS-ho-rev'] = ('bad' if bad else 'could_not_check' if cnc else 'ok',
                             f'{RUNS_REV} runs (bad {len(bad)}, could not check {len(cnc)}, ok {len(okd)}); the hand-over '
                             'waited for the uncommitted closed call: ' + '; '.join((bad or cnc or okd)[:2]))

    # 4. The forward order, once (one hand-over per database): record_handover uncommitted, then a call of each of the ten
    # closed functions; each waits, and once the hand-over commits it answers handed_over and writes nothing
    # (B:397; EV-C02-013 28 (4)). Each function's control is the same call made alone after the hand-over committed.
    payloads = {
        'begin_transfer_run': run_args(f'w07_fixture_locks_{run_id}_fwd'),
        'end_transfer_run': {'run_id': r0, 'counts': {}, 'phase': 'completed'},
        'transfer_event': {'run_id': r0, 'transfer_source': src('record_line', f'W07-FIXTURE-LOCKS-{run_id}#1'),
                           'event_type': 'record_line', 'aggregate_type': 'work', 'aggregate_id': str(uuid.uuid4()),
                           'text': 'w07_fixture SYNTHETIC W-C02-07 record line'},
        'transfer_artifact': {'run_id': r0, 'transfer_source': src('artifact', f'W07-FIXTURE-LOCKS-ART-{run_id}-fwd'),
                              'path': f'w07_fixture/locks_{run_id}_fwd.md', 'commit': hexof('artifact fwd', 40),
                              'kind': 'git_file', 'scope': 'installation', 'status': 'current'},
        'transfer_mission': {'run_id': r0, 'transfer_source': src('mission', f'W07-FIXTURE-LOCKS-M-{run_id}-fwd'),
                             'purpose': 'w07_fixture SYNTHETIC W-C02-07 mission', 'scope': 'installation',
                             'acceptance': 'w07_fixture SYNTHETIC W-C02-07', 'owner_authority': str(uuid.uuid4()),
                             'owner_authority_revision': 1, 'constraints': [], 'status': 'active'},
        'transfer_work': {'run_id': r0, 'transfer_source': src('work', f'W07-FIXTURE-LOCKS-W-{run_id}-fwd'),
                          'mission_ref': str(uuid.uuid4()), 'mission_revision': 1, 'scope': 'installation',
                          'purpose': 'w07_fixture SYNTHETIC W-C02-07 work item', 'impact_class': 'high', 'execution': 'planned',
                          'acceptance': 'proposed', 'effort_policy': {'level': 'high', 'expert_assessment_ref': 'w07_fixture/expert_assessment',
                                                                     'non_removable_steps': ['verification']}},
        'transfer_relation': {'run_id': r0, 'transfer_source': src('relation', f'W07-FIXTURE-LOCKS-REL-{run_id}-fwd'), 'type': 'about',
                              'from_ref': str(uuid.uuid4()), 'from_revision': 1, 'to_ref': str(uuid.uuid4()), 'to_revision': 1,
                              'scope': 'installation', 'hard': False, 'method': 'mechanical', 'epistemic_status': 'observation'},
        'transfer_decision': {'class': 'high_impact', 'question': 'w07_fixture SYNTHETIC W-C02-07 transferred decision',
                              'why_this_owner': 'w07_fixture SYNTHETIC', 'options': [], 'alternatives_considered': [],
                              'alternatives_state': 'compared', 'criteria': [], 'evidence_refs': [], 'assumptions': [], 'premises': [],
                              'reopen_triggers': [], 'status': 'answered', 'run_id': r0,
                              'transfer_source': src('decision', f'W07-FIXTURE-LOCKS-D-{run_id}-fwd')},
        'transfer_need': {'run_id': r0, 'transfer_source': src('need', f'W07-FIXTURE-LOCKS-N-{run_id}-fwd'),
                          'condition': 'w07_fixture SYNTHETIC W-C02-07 condition', 'why_needed': 'w07_fixture SYNTHETIC W-C02-07',
                          'status': 'open', 'mission_ref': str(uuid.uuid4()), 'mission_revision': 1},
        'transfer_finding': {'run_id': r0, 'transfer_source': src('finding', f'W07-FIXTURE-LOCKS-F-{run_id}-fwd'),
                             'claim': 'w07_fixture SYNTHETIC W-C02-07 transferred finding', 'scope': 'installation',
                             'counter_evidence_searched': 'not_recorded', 'changeable': 'not_recorded', 'epistemic_status': 'observation',
                             'current_authority': 'information_only', 'privacy_class': 'public', 'status': 'candidate'}}
    n0, b_no = len(ISSUED), nxt()
    h = Holder(b_no)
    ho = Conn(f'w07_locks_{run_id}_hf', script('devos_kurulum', handover_body('fwd') + barrier(b_no)))
    sh = wait_for([ho], ['barrier', 'gone'])[ho.name]
    cs = {f: Conn(f'w07_locks_{run_id}_f{k}', script('devos_kurulum', call('c', f"devos_api.{f}({lit(payloads[f])})")))
          for k, f in enumerate(CLOSED)}
    seen = wait_for(list(cs.values()), ['wait:', 'gone'])
    h.release()
    rh = ho.done()
    res = {f: c.done() for f, c in cs.items()}
    revoke_issued(n0)
    hid = one("select coalesce(min(id)::text, '') from devos_private.event where event_type = 'ledger_handed_over';")
    n0 = len(ISSUED)
    ctl = {}
    for k, f in enumerate(CLOSED):  # the controls, one at a time, after the hand-over committed
        ctl[f] = Conn(f'w07_locks_{run_id}_k{k}', script('devos_kurulum', call('c', f"devos_api.{f}({lit(payloads[f])})"))).done()
    revoke_issued(n0)
    ho_ok = sh == 'barrier' and rh['r'].get('ho', {}).get('status') == 'ok' and not prereq(rh) and bool(hid)
    for f in CLOSED:
        x, k = res[f]['r'].get('c', {}), ctl[f]['r'].get('c', {})
        t0 = res[f]['t0'].get('c')
        d = (f"concurrent call {x.get('status')} {x.get('code', '')}, seen {seen.get(cs[f].name)}; "
             f"control after the hand-over {k.get('status')} {k.get('code', '')}")
        if not ho_ok:
            cases['LOCKS-ho-fwd:' + f] = ('could_not_check', d + '; the hand-over was not held uncommitted and then committed: '
                                         + ', '.join(prereq(rh) + [f"ho {rh['r'].get('ho', {}).get('status')} "
                                                                   f"{clean(rh['r'].get('ho', {}).get('reason', ''))}"]))
        elif k.get('code') != 'handed_over':
            cases['LOCKS-ho-fwd:' + f] = ('could_not_check', d + '; the call alone after the hand-over does not answer '
                                         'handed_over, so it does not reach the closing check: ' + clean(k.get('reason', '')))
        elif t0 is None or rh['tb'] is None or t0 >= rh['tb']:
            cases['LOCKS-ho-fwd:' + f] = ('could_not_check', d + '; the call was not shown made while the hand-over was uncommitted')
        elif x.get('code') == 'handed_over':
            cases['LOCKS-ho-fwd:' + f] = ('ok', d)
        else:
            cases['LOCKS-ho-fwd:' + f] = ('bad', d + ': made while the hand-over was uncommitted, it did not wait for it; '
                                          + clean(x.get('reason', '')))
    after = one(f"select count(*) from devos_private.event where id > {hid} and origin::text <> 'owner';") if hid.isdigit() else None
    if not ho_ok or after is None:
        cases['LOCKS-ho-cut'] = ('could_not_check', 'the hand-over was not held and committed, or the event table could not be read')
    else:
        cases['LOCKS-ho-cut'] = ('ok' if after == '0' else 'bad',
                                 f'events of a call (origin not owner) with an id above the hand-over event {hid}: {after}')

    # The failure frequency: any raised error in any connection (deadlock 40P01, lock timeout 55P03 among them).
    counts = {c: ERRORS.count(c) for c in sorted(set(ERRORS))}
    cases['LOCKS-err'] = ('bad' if counts else 'ok', f'raised errors by SQLSTATE over every connection: {counts or "none"}')

    # Tokens: every token this program issued is revoked, judged by the row IDs it recorded (as T-W07-CONC).
    own = sorted(set(ISSUED))

    def arr(xs):
        return ('array[' + ', '.join(f"'{x}'" for x in xs) + ']::text[]') if xs else "'{}'::text[]"
    tok = one(f"select count(*) filter (where id::text = any({arr(own)})) || '|' "
              f"|| count(*) filter (where id::text = any({arr(own)}) and revoked_at is null) || '|' "
              f"|| count(*) filter (where revoked_at is null and not (id::text = any({arr(own)})) "
              f"and not (id::text = any({arr(base_ids)}))) from devos_private.env_tokens;")
    tok = [int(t) for t in tok.split('|')] if tok and all(t.isdigit() for t in tok.split('|')) else None
    detail = f'{len(own)} tokens this run issued and recorded; unrevoked before the run, not counted: {len(base_ids)}'
    if tok is None or tok[0] != len(own):
        cases['LOCKS-tokens'] = ('could_not_check', 'the recorded tokens could not all be read after the runs; ' + detail)
    elif tok[1]:
        cases['LOCKS-tokens'] = ('bad', f'tokens of this run left unrevoked: {tok[1]}; ' + detail)
    elif tok[2]:
        cases['LOCKS-tokens'] = ('could_not_check', f'unrecorded tokens issued during the run and unrevoked: {tok[2]}; ' + detail)
    else:
        cases['LOCKS-tokens'] = ('ok', 'tokens of this run left unrevoked: 0; ' + detail)

    print("fixtures left (throwaway database only): the work items' claims and operations, the transfer runs, the marks "
          f"of the key runs, D-010's transferred Decision and the installation's Mission {install_sid} (LOCKS-mi-one), and "
          'the hand-over; nothing of this program is committed anywhere else')
    for cid in sorted(cases):
        print(f'{cid} | {cases[cid][0]} | {clean(cases[cid][1], 700)}')
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
