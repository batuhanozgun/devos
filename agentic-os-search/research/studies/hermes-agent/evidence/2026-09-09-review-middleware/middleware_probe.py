#!/usr/bin/env python3
"""Run bounded diagnostics on one exact Hermes middleware module; no network.

Fake plugin registry and callbacks only. Preserve the recorded evidence by passing
--output to a new result path when reproducing. No complete-product claims.
"""
from __future__ import annotations
import argparse
from datetime import datetime, timezone
import hashlib
import importlib.util
import io
import json
import logging
from pathlib import Path
import platform
import sys
import tempfile
import types

ROOT = Path(__file__).resolve().parent
PIN = 'c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a'
BLOB = '897e4afc07ba0d78ba928baf39a8573422b648be'

def sha256(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()

def git_blob(data: bytes) -> str:
    return hashlib.sha1(b'blob '+str(len(data)).encode()+b'\0'+data).hexdigest()

def load_exact(path: Path, name: str):
    data = path.read_bytes()
    got = git_blob(data)
    if got != BLOB:
        raise ValueError(f'source identity refused before import: {got} != {BLOB}')
    spec = importlib.util.spec_from_file_location(name, path)
    if spec is None or spec.loader is None:
        raise RuntimeError('Unable to construct module loader')
    module = importlib.util.module_from_spec(spec)
    sys.modules[name] = module
    spec.loader.exec_module(module)
    return module

class HandlerError(Exception):
    pass

class DeliberateAbort(BaseException):
    pass

def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--output', type=Path, default=ROOT/'MIDDLEWARE-RESULT.json')
    args = ap.parse_args()
    started = datetime.now(timezone.utc).isoformat()
    module = load_exact(ROOT/'upstream/middleware.py', 'bounded_hermes_middleware')
    registry = types.SimpleNamespace(_middleware={})
    parent = types.ModuleType('hermes_cli'); parent.__path__=[]
    plugins = types.ModuleType('hermes_cli.plugins')
    plugins.get_plugin_manager = lambda: registry
    parent.plugins = plugins
    previous = {name: sys.modules.get(name) for name in ('hermes_cli','hermes_cli.plugins')}
    sys.modules.update({'hermes_cli':parent,'hermes_cli.plugins':plugins})
    rows = []

    def run(case, factory, expected):
        effects, trace = [], []
        stream = io.StringIO()
        handler_log = logging.StreamHandler(stream)
        module.logger.addHandler(handler_log)
        old_level, old_propagate = module.logger.level, module.logger.propagate
        module.logger.setLevel(logging.WARNING); module.logger.propagate=False
        callbacks, terminal = factory(effects, trace)
        registry._middleware={module.TOOL_EXECUTION_MIDDLEWARE:callbacks}
        result, error = None, None
        try:
            result = module.run_tool_execution_middleware(
                'harmless_marker', {'value':'initial'}, terminal, session_id='synthetic-session')
        except BaseException as exc:
            error={'type':type(exc).__name__,'message':str(exc)}
        finally:
            module.logger.removeHandler(handler_log)
            module.logger.setLevel(old_level); module.logger.propagate=old_propagate
        observed={'handler_count':len(effects),'effects':effects,'trace':trace,
                  'result':result,'error':error,'warnings':stream.getvalue().splitlines()}
        checks=expected(observed)
        rows.append({'id':case,'observation':observed,'checks':checks,
                     'expectations_matched':all(checks.values())})

    def standard(effects, trace, fail=False):
        def terminal(payload):
            effects.append(dict(payload)); trace.append('handler')
            if fail: raise HandlerError('synthetic downstream failure')
            return {'ok':True,'value':payload['value']}
        return terminal

    def plain(e,t): return [], standard(e,t)
    def before(e,t):
        def callback(**k): t.append('pre-fail'); raise RuntimeError('synthetic pre-next failure')
        return [callback],standard(e,t)
    def block(e,t):
        def callback(**k): t.append('short-circuit'); return {'blocked':True}
        return [callback],standard(e,t)
    def downstream(e,t):
        def callback(**k): t.append('enter'); return k['next_call']()
        return [callback],standard(e,t,fail=True)
    def after(e,t):
        def callback(**k):
            t.append('enter'); k['next_call'](); t.append('post-fail')
            raise RuntimeError('synthetic post-next failure')
        return [callback],standard(e,t)
    def twice(e,t):
        def callback(**k):
            t.append('first-next'); k['next_call'](); t.append('second-next')
            return k['next_call']()
        return [callback],standard(e,t)
    def nested(e,t):
        def outer(**k): t.append('outer-rewrite'); return k['next_call']({'value':'rewritten'})
        def inner(**k): t.append('inner-pre-fail'); raise RuntimeError('inner failure')
        return [outer,inner],standard(e,t)
    def abort(e,t):
        def callback(**k): t.append('abort'); raise DeliberateAbort('synthetic abort')
        return [callback],standard(e,t)
    def success(o, value='initial'):
        return {'one_effect':o['handler_count']==1,'no_exception':o['error'] is None,
                'saved_result':o['result']=={'ok':True,'value':value},
                'effective_args':o['effects']==[{'value':value}]}
    try:
        run('MW01',plain,lambda o:{**success(o),'no_warning':not o['warnings']})
        run('MW02',before,lambda o:{**success(o),'warning':any('pre-next failure' in x for x in o['warnings'])})
        run('MW03',block,lambda o:{'no_effect':o['handler_count']==0,'blocked_result':o['result']=={'blocked':True},'no_exception':o['error'] is None})
        run('MW04',downstream,lambda o:{'one_effect':o['handler_count']==1,'original_exception':o['error']=={'type':'HandlerError','message':'synthetic downstream failure'},'no_result':o['result'] is None})
        run('MW05',after,lambda o:{**success(o),'warning':any('post-next failure' in x for x in o['warnings'])})
        run('MW06',twice,lambda o:{**success(o),'duplicate_warning':any('more than once' in x for x in o['warnings']),'second_attempt_reached':o['trace']==['first-next','handler','second-next']})
        run('MW07',nested,lambda o:{**success(o,'rewritten'),'trace':o['trace']==['outer-rewrite','inner-pre-fail','handler'],'warning':bool(o['warnings'])})
        run('MW08',abort,lambda o:{'no_effect':o['handler_count']==0,'abort_preserved':o['error']=={'type':'DeliberateAbort','message':'synthetic abort'},'no_result':o['result'] is None})
        with tempfile.TemporaryDirectory(prefix='hermes_identity_') as td:
            bad = Path(td)/'middleware.py'
            bad.write_bytes((ROOT/'upstream/middleware.py').read_bytes()+b'\n# deliberate integrity challenge\n')
            name='must_not_import_bad_middleware'
            try:
                load_exact(bad,name)
                challenge={'rejected':False,'not_imported':name not in sys.modules}
            except ValueError as exc:
                challenge={'rejected':True,'not_imported':name not in sys.modules,'error':str(exc)}
    finally:
        for name, original in previous.items():
            if original is None: sys.modules.pop(name,None)
            else: sys.modules[name]=original
    result={
        'kind':'EXACT_MIDDLEWARE_COMPONENT_DIAGNOSTICS_NOT_PRODUCT_CONFORMANCE',
        'started_at_utc':started,'finished_at_utc':datetime.now(timezone.utc).isoformat(),
        'upstream_pin':PIN,'source_git_blob':git_blob((ROOT/'upstream/middleware.py').read_bytes()),
        'source_bytes':(ROOT/'upstream/middleware.py').stat().st_size,
        'source_sha256':sha256((ROOT/'upstream/middleware.py').read_bytes()),
        'harness_sha256':sha256(Path(__file__).read_bytes()),'spec_sha256':sha256((ROOT/'SPEC.md').read_bytes()),
        'runtime':{'python':sys.version,'platform':platform.platform()},
        'cases':rows,'integrity_challenge':challenge,
        'all_expectations_matched':all(r['expectations_matched'] for r in rows) and challenge['rejected'] and challenge['not_imported'],
        'limitations':['Fake plugin registry and synthetic callbacks/handler','No complete review/AIAgent/PluginManager/executor/Relay run','No network, provider, credential, installation or production effect','Exploratory source-informed diagnostic cases; not independent holdout'],
    }
    args.output.write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    print(json.dumps({'cases':len(rows),'all_expectations_matched':result['all_expectations_matched'],'output':args.output.name}))
    return 0 if result['all_expectations_matched'] else 1
if __name__=='__main__': raise SystemExit(main())
