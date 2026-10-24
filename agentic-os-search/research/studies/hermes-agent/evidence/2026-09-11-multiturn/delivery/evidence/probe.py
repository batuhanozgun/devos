#!/usr/bin/env python3
"""Offline U04 diagnostic. Run with Python 3.11+; standard library only.
Writes a new RESULT.json and does not modify archived source inputs.
A full heartbeat module plus two explicit manual selections are used.
"""
from __future__ import annotations
import ast
import hashlib
import importlib.util
import json
from pathlib import Path
import sqlite3
import sys
import tempfile
import traceback
import types
from datetime import datetime, timezone

ROOT = Path(__file__).resolve().parents[1]
INPUTS = json.loads((ROOT / 'evidence/INPUTS.json').read_text())
PIN = INPUTS['pin']
EXPECTED_HEARTBEAT = 'd3f440d9ed2035505b0bdfbe7d6d57dec926317f'

def git_blob(data: bytes) -> str:
    return hashlib.sha1(f'blob {len(data)}\0'.encode() + data).hexdigest()

def verify_inputs(root: Path) -> None:
    for relative, expected in INPUTS['files'].items():
        data = (root / relative).read_bytes()
        if hashlib.sha256(data).hexdigest() != expected['sha256']:
            raise ValueError(f'input integrity mismatch: {relative}')
    if git_blob((root / 'source/heartbeat.py').read_bytes()) != EXPECTED_HEARTBEAT:
        raise ValueError('full heartbeat upstream identity mismatch')

# Safety guard for the source functions, not a general OS sandbox proof.
DENIED = []
def guard(event: str, args: tuple) -> None:
    if event in {'subprocess.Popen', 'os.system', 'os.posix_spawn', 'socket.connect', 'socket.getaddrinfo'}:
        DENIED.append(event)
        raise PermissionError('offline diagnostic prohibits ' + event)

verify_inputs(ROOT)
sys.addaudithook(guard)


def load_module(name: str, path: Path):
    spec = importlib.util.spec_from_file_location(name, path)
    module = importlib.util.module_from_spec(spec)
    sys.modules[name] = module
    spec.loader.exec_module(module)
    return module

hb = load_module('u04_heartbeat', ROOT / 'source/heartbeat.py')
kg = load_module('u04_kanban', ROOT / 'source/kanban_goal_selected.py')
rs = load_module('u04_run_status', ROOT / 'source/run_status_selected.py')


class MetaDB:
    """Explicit reduced SessionDB-shaped adapter. Not Hermes SessionDB."""
    def __init__(self, path: Path):
        self.path = path
        self.conn = sqlite3.connect(path, isolation_level=None)
        self.conn.execute('CREATE TABLE meta (k TEXT PRIMARY KEY, v TEXT NOT NULL)')
        self.fail_keys: set[str] = set()
    def get_meta(self, key: str):
        row = self.conn.execute('SELECT v FROM meta WHERE k=?', (key,)).fetchone()
        return row[0] if row else None
    def set_meta(self, key: str, value: str):
        if key in self.fail_keys:
            raise sqlite3.OperationalError('synthetic set_meta failure: ' + key)
        self.conn.execute('INSERT OR REPLACE INTO meta VALUES (?,?)', (key, value))
    def snapshot(self):
        # Separate connection ensures the observed state is committed.
        with sqlite3.connect(self.path) as readback:
            return {k: json.loads(v) for k, v in readback.execute('SELECT k,v FROM meta ORDER BY k')}


class KanbanFixture:
    """Minimal real SQLite records. All writer transitions are fixtures."""
    def __init__(self, path: Path, status='running', outcome=None, current=1):
        self.path = path
        self.c = sqlite3.connect(path, isolation_level=None)
        self.c.row_factory = sqlite3.Row
        self.c.executescript('''CREATE TABLE tasks(id TEXT PRIMARY KEY,status TEXT,current_run_id INTEGER);
        CREATE TABLE task_runs(id INTEGER PRIMARY KEY,task_id TEXT,outcome TEXT);
        CREATE TABLE task_events(id INTEGER PRIMARY KEY,task_id TEXT,kind TEXT);''')
        self.c.execute('INSERT INTO tasks VALUES (?,?,?)', ('t_fixture',status,current))
        self.c.execute('INSERT INTO task_runs VALUES (?,?,?)', (1,'t_fixture',outcome))
        if current == 2:
            self.c.execute('INSERT INTO task_runs VALUES (?,?,NULL)', (2,'t_fixture'))
        self.trace = []
        self.prompts = []
        self.judges = 0
        self.blocks = 0
        self.reader = rs.goal_run_status
    def get_task(self, conn, tid):
        row = conn.execute('SELECT * FROM tasks WHERE id=?',(tid,)).fetchone()
        return types.SimpleNamespace(**dict(row)) if row else None
    def status(self):
        result = self.reader(self.c, 't_fixture', 1)
        self.trace.append({'status_read':result})
        return result
    def finish(self, status: str, outcome: str):
        self.c.execute('UPDATE tasks SET status=?, current_run_id=NULL', (status,))
        self.c.execute('UPDATE task_runs SET outcome=? WHERE id=1', (outcome,))
    def supersede(self):
        self.c.execute("UPDATE task_runs SET outcome='reclaimed' WHERE id=1")
        self.c.execute("INSERT OR IGNORE INTO task_runs VALUES (2,'t_fixture',NULL)")
        self.c.execute("UPDATE tasks SET status='running',current_run_id=2")
        self.trace.append({'fixture_ownership_transfer':'1 -> 2'})
    def snap(self):
        with sqlite3.connect(self.path) as c:
            c.row_factory = sqlite3.Row
            return {'tasks':[dict(r) for r in c.execute('SELECT * FROM tasks')],
                    'runs':[dict(r) for r in c.execute('SELECT * FROM task_runs ORDER BY id')]}
    def run(self, *, verdict='continue', budget=3, turn_action=None, judge_action=None,
            block_mode='accept', status_error=False, turn_error=False, fn=None, parse_failed=False):
        rs.get_task = self.get_task
        def judge(*_):
            self.judges += 1
            self.trace.append({'judge':verdict,'parse_failed':parse_failed})
            if judge_action:
                judge_action()
            return verdict,'fixture verdict',parse_failed,({'seconds':600} if verdict=='wait' else None),False
        def run_turn(prompt):
            self.prompts.append(prompt)
            self.trace.append({'run_turn':len(self.prompts)})
            if turn_error:
                raise RuntimeError('synthetic turn failure')
            if turn_action:
                turn_action()
            return 'harmless fixture response'
        def block(reason):
            self.blocks += 1
            self.trace.append({'block_attempt':block_mode,'reason':reason})
            if block_mode=='raise':
                raise sqlite3.OperationalError('synthetic block failure')
            if block_mode=='false':
                return False
            self.finish('blocked','blocked')
            return True
        def status():
            if status_error:
                raise sqlite3.OperationalError('synthetic status read failure')
            return self.status()
        kg.judge_goal = judge
        target = fn or kg.run_kanban_goal_loop
        # A mutant may have a separate globals dict; bind the same fixture judge.
        target.__globals__['judge_goal'] = judge
        outcome = target(task_id='t_fixture', goal_text='Harmless fixture task',run_turn=run_turn,
                         task_status_fn=status, block_fn=block,max_turns=budget,
                         first_response='first response already supplied',
                         log=lambda text:self.trace.append({'log':text}))
        return {'loop_result':outcome,'judge_calls':self.judges,'extra_turns':len(self.prompts),
                'block_calls':self.blocks,'prompts':self.prompts,'trace':self.trace,'durable':self.snap()}


RESULT = {'kind':'U04_EXECUTED_BOUNDED_DIAGNOSTIC','started_at_utc':datetime.now(timezone.utc).isoformat(),
          'pin':PIN,'python':sys.version,'platform':sys.platform,'sqlite':sqlite3.sqlite_version,
          'source_identity':INPUTS,'probe_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
          'spec_sha256':hashlib.sha256((ROOT/'evidence/SPEC.md').read_bytes()).hexdigest(),
          'cases':[],'negative_controls':[],
          'limits':['Only heartbeat.py has full upstream-byte identity verified.',
                    'Kanban loop and run-status are manual selections, not full original modules.',
                    'Judge, model turns, task writers, get_task, clock and MetaDB are fixtures.',
                    'SQLite is real; schema and SessionDB adapter are reduced.',
                    'No real app, gateway, workers, providers, network, OS signals or semantic-quality test.',
                    'Tests are not independent external replication.']}


def record(cid, operation):
    row={'id':cid}
    try:
        row['observed']=operation()
        row['matched']=True
    except Exception as exc:
        row.update(matched=False,error=f'{type(exc).__name__}: {exc}',traceback=traceback.format_exc())
    RESULT['cases'].append(row)


def gcase(cid, tmp, **kwargs):
    initial=kwargs.pop('initial',{})
    f=KanbanFixture(tmp / (cid+'.sqlite'),**initial)
    try:
        if cid=='G04': kwargs['turn_action']=lambda:f.finish('done','completed')
        if cid=='G10': kwargs['judge_action']=f.supersede
        obs=f.run(**kwargs)
        expected={
            'G01':('completed_by_worker',0,0), 'G02':('review_requested_by_worker',0,0),
            'G03':('stopped',0,0), 'G04':('completed_by_worker',1,1),
            'G05':('blocked_budget',2,1), 'G06':('blocked_budget',3,2),
            'G07':('blocked_budget',5,4), 'G08':('blocked_unachievable',1,0),
            'G09':('blocked_unachievable',1,0), 'G10':('stopped',1,1),
            'G11':('stopped',0,0), 'G12':('stopped',1,1)}[cid]
        actual=(obs['loop_result']['outcome'],obs['judge_calls'],obs['extra_turns'])
        obs['oracle']={'expected':expected,'actual':actual}
        assert actual==expected,(actual,expected)
        if cid in ('G08','G09'):
            assert obs['durable']['tasks'][0]['status']=='running'
        if cid in ('G03','G10'):
            assert obs['durable']['tasks'][0]['current_run_id']==2
            assert obs['durable']['runs'][1]['outcome'] is None
        if cid=='G04': assert 'still open' in obs['prompts'][0]
        if cid=='G06': assert all('not done yet' in p for p in obs['prompts'])
        return obs
    finally: f.c.close()


def hcase(cid,tmp):
    db=MetaDB(tmp/(cid+'.sqlite'))
    clock=types.SimpleNamespace(value=1000.0)
    hb.time=types.SimpleNamespace(time=lambda:clock.value)
    hb._get_session_db=lambda:db
    try:
        mgr=hb.HeartbeatManager('old')
        if cid=='H07': db.fail_keys.add('heartbeat:old')
        set_result=mgr.set('Observe harmless fixture',60)
        obs={}
        if cid=='H01':
            values=[mgr.due_prompt(now=n) is not None for n in (1000,1059,1060)]
            obs['fired_at_1000_1059_1060']=values
            assert values==[False,False,True]
        elif cid=='H02':
            first=mgr.due_prompt(now=4600); second=mgr.due_prompt(now=4600)
            obs.update(first=first,second=second,fire_count=mgr.state.fire_count,last_fired_at=mgr.state.last_fired_at)
            assert first and second is None and mgr.state.fire_count==1 and mgr.state.last_fired_at==4600
        elif cid=='H03':
            mgr.due_prompt(now=1060)
            fresh=hb.HeartbeatManager('old')
            obs['reloaded']=json.loads(fresh.state.to_json())
            assert fresh.state.fire_count==1 and fresh.state.last_fired_at==1060
        elif cid=='H04':
            mgr.pause(); obs['paused_fire']=mgr.due_prompt(now=5000)
            clock.value=5000; mgr.resume()
            obs['resumed_fires']=[mgr.due_prompt(now=n) is not None for n in (5000,5059,5060)]
            assert obs['paused_fire'] is None and obs['resumed_fires']==[False,False,True]
        elif cid=='H05':
            mgr.due_prompt(now=1060); obs['abandoned']=mgr.abandon_fire()
            obs['again']=mgr.due_prompt(now=1060) is not None
            assert obs['abandoned'] and obs['again'] and mgr.state.fire_count==1
        elif cid=='H06':
            mgr.due_prompt(now=1060); hb.HeartbeatManager('old').pause()
            obs['abandoned']=mgr.abandon_fire()
            obs['fresh_status']=hb.HeartbeatManager('old').state.status
            assert not obs['abandoned'] and obs['fresh_status']=='paused'
        elif cid=='H07':
            obs['live_status']=set_result.status
            obs['fresh_exists']=hb.HeartbeatManager('old').state is not None
            assert obs['live_status']=='active' and not obs['fresh_exists']
        elif cid in ('H08','H09'):
            if cid=='H09': db.fail_keys.add('heartbeat:new')
            obs['helper_return']=hb.migrate_heartbeat_to_session('old','new')
            obs['old_loadable']=hb.load_heartbeat('old') is not None
            obs['new_loadable']=hb.load_heartbeat('new') is not None
            assert obs['helper_return'] and not obs['old_loadable']
            assert obs['new_loadable']==(cid=='H08')
        obs['durable']=db.snapshot()
        return obs
    finally:db.conn.close()


with tempfile.TemporaryDirectory(prefix='hermes-u04-') as td:
    tmp=Path(td)
    cases=[('G01',{'initial':{'status':'done','outcome':'completed','current':None}}),
           ('G02',{'initial':{'status':'running','outcome':'review_requested','current':2}}),
           ('G03',{'initial':{'status':'running','outcome':'reclaimed','current':2}}),
           ('G04',{'verdict':'done'}),('G05',{'verdict':'done','budget':10}),
           ('G06',{'verdict':'wait','budget':3}),('G07',{'parse_failed':True,'budget':5}),
           ('G08',{'verdict':'blocked','block_mode':'false'}),
           ('G09',{'verdict':'blocked','block_mode':'raise'}),('G10',{}),
           ('G11',{'status_error':True}),('G12',{'turn_error':True})]
    for cid,kwargs in cases:
        record(cid,lambda c=cid,k=kwargs:gcase(c,tmp,**k))
    for n in range(1,10):
        cid=f'H{n:02d}';record(cid,lambda c=cid:hcase(c,tmp))

    # Actual pre-execution guard must reject edited bytes.
    negative_root=tmp/'mutant-inputs'
    for relative in INPUTS['files']:
        dest=negative_root/relative;dest.parent.mkdir(parents=True,exist_ok=True)
        dest.write_bytes((ROOT/relative).read_bytes())
    with (negative_root/'source/heartbeat.py').open('ab') as f:f.write(b'\n# mutation\n')
    rejected=False
    try:verify_inputs(negative_root)
    except ValueError:rejected=True
    RESULT['negative_controls'].append({'id':'NC01','input_mutation_rejected':rejected})

    # Removing the run identity branch should violate G03's oracle.
    altered=(ROOT/'source/run_status_selected.py').read_text().replace('if expected_run_id is not None:', 'if False:')
    ns=dict(rs.__dict__);exec(compile(altered,'<status-guard-mutant>','exec'),ns)
    f=KanbanFixture(tmp/'NC02.sqlite',outcome='reclaimed',current=2)
    ns['get_task']=f.get_task;f.reader=ns['goal_run_status']
    nc=f.run(budget=2,block_mode='false')
    nc['detected_by_G03_oracle']=nc['extra_turns']!=0 or nc['judge_calls']!=0
    RESULT['negative_controls'].append({'id':'NC02',**nc});f.c.close()

    # Turning WAIT into immediate return must violate G06's continuation-count oracle.
    altered=(ROOT/'source/kanban_goal_selected.py').read_text().replace(
        'if verdict == "wait":\n            verdict = "continue"',
        'if verdict == "wait":\n            return _result("stopped", "mutant parks immediately")')
    ns=dict(kg.__dict__);exec(compile(altered,'<wait-mutant>','exec'),ns)
    f=KanbanFixture(tmp/'NC03.sqlite');nc=f.run(verdict='wait',budget=3,fn=ns['run_kanban_goal_loop'])
    nc['detected_by_G06_oracle']=nc['extra_turns']!=2
    RESULT['negative_controls'].append({'id':'NC03',**nc});f.c.close()

RESULT['denied_network_process_events']=DENIED
RESULT['ended_at_utc']=datetime.now(timezone.utc).isoformat()
RESULT['all_case_expectations_matched']=all(c['matched'] for c in RESULT['cases'])
RESULT['all_negative_controls_detected']=(RESULT['negative_controls'][0]['input_mutation_rejected']
    and RESULT['negative_controls'][1]['detected_by_G03_oracle']
    and RESULT['negative_controls'][2]['detected_by_G06_oracle'])
path=ROOT/'evidence/RESULT.json'
path.write_text(json.dumps(RESULT,ensure_ascii=False,indent=2)+'\n')
print(json.dumps({'result_path':str(path),'cases':len(RESULT['cases']),
                  'matched':sum(c['matched'] for c in RESULT['cases']),
                  'negative_controls_detected':RESULT['all_negative_controls_detected'],
                  'denied_network_process_events':DENIED},indent=2))
raise SystemExit(0 if RESULT['all_case_expectations_matched'] and RESULT['all_negative_controls_detected'] else 1)
