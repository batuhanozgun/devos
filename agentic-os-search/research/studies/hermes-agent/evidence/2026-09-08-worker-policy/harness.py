#!/usr/bin/env python3
"""Offline, source-extracted function integration. Not a whole Hermes run.

Run in a disposable copy. All external service/state boundaries are fixtures;
selected executor and whitelist consumer functions are source excerpts.
"""
from __future__ import annotations
import argparse
import contextvars
import hashlib
import importlib.util
import json
import platform
import sys
import threading
import types
from datetime import datetime, timezone
from pathlib import Path

ROOT = Path(__file__).resolve().parent
EXPECTED = {
    'thread_context.py': 'd8c37af8f5a529680e81e867177140e41c4c6656',
    'daemon_pool.py': '5682a8f6ae103a421c1081b69ee6f9272957acdf',
    'LICENSE': '75410e73319c72cd3e991a501c5455eb78f38375',
}
def blob_hash(data):
    return hashlib.sha1(b'blob ' + str(len(data)).encode() + b'\0' + data).hexdigest()
def validate_full_sources():
    result = {}
    for name, expected in EXPECTED.items():
        data = (ROOT / 'upstream' / name).read_bytes()
        got = blob_hash(data)
        if got != expected:
            raise ValueError(f'Upstream identity mismatch: {name}: {got}')
        result[name] = {'git_blob': got, 'sha256': hashlib.sha256(data).hexdigest(), 'bytes': len(data)}
    return result

def module(name, **attrs):
    m = types.ModuleType(name)
    for k, v in attrs.items(): setattr(m, k, v)
    sys.modules[name] = m
    if '.' in name:
        parent, leaf = name.rsplit('.', 1)
        setattr(sys.modules[parent], leaf, m)
    return m

def load(name, path):
    spec = importlib.util.spec_from_file_location(name, path)
    m = importlib.util.module_from_spec(spec)
    sys.modules[name] = m
    spec.loader.exec_module(m)
    if '.' in name:
        parent, leaf = name.rsplit('.', 1)
        setattr(sys.modules[parent], leaf, m)
    return m

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--output', default='RESULT.json')
    args = parser.parse_args()
    source_ids = validate_full_sources()  # Before any upstream import.
    started = datetime.now(timezone.utc).isoformat()
    for name in ('tools', 'agent', 'hermes_cli'): module(name, __path__=[])
    callbacks = threading.local()
    module('tools.terminal_tool',
        _get_approval_callback=lambda: getattr(callbacks, 'approval', None),
        _get_sudo_password_callback=lambda: getattr(callbacks, 'sudo', None),
        set_approval_callback=lambda value: setattr(callbacks, 'approval', value),
        set_sudo_password_callback=lambda value: setattr(callbacks, 'sudo', value))
    helper = load('tools.thread_context', ROOT/'upstream/thread_context.py')
    load('tools.daemon_pool', ROOT/'upstream/daemon_pool.py')
    policy = load('hermes_cli.plugins', ROOT/'excerpts/plugins.selected.py')
    executor = load('agent.tool_executor', ROOT/'excerpts/tool_executor.selected.py')
    origin = contextvars.ContextVar('research_origin', default='unset')
    profile = contextvars.ContextVar('research_profile', default='unset')
    fixture = {'events': [], 'lock': threading.Lock(), 'mode': 'none', 'guard_allow': True}
    def event(kind, **fields):
        with fixture['lock']:
            fixture['events'].append({'kind': kind, 'thread': threading.get_ident(),
                                     'origin': origin.get(), 'profile': profile.get(), **fields})
    def lifecycle(hook_name, **kwargs):
        event('lifecycle', hook=hook_name)
        mode = fixture['mode']
        if mode == 'raise':
            event('lifecycle_exception')
            raise RuntimeError('synthetic lifecycle delivery failure')
        if mode == 'block': return [{'action': 'block', 'message': 'synthetic lifecycle block'}]
        if mode == 'approve': return [{'action': 'approve', 'message': 'synthetic approval needed'}]
        if mode == 'modify-block': return [{'action': 'modify', 'args': {'marker':'changed'}},
                                           {'action': 'block', 'message': 'synthetic after-modify block'}]
        if mode == 'modify': return [{'action': 'modify', 'args': {'marker':'changed'}}]
        return []
    module('hermes_cli.lifecycle', invoke_hook=lifecycle)
    def approval(*a, **kw):
        event('approval_exception')
        raise RuntimeError('synthetic approval transport failure')
    module('tools.approval', request_tool_approval=approval)
    module('tools.approval_context',
           get_current_session_key=lambda:'research-session',
           set_current_observability_context=lambda **kw: ('synthetic-token',),
           reset_current_observability_context=lambda token:None)
    module('tools.approval_human_wait', human_wait_seconds=lambda key:0.0)
    def relay_execute(name, payload, next_fn, **kw):
        event('relay_fixture')
        return next_fn(payload), payload
    module('agent.relay_tools', execute=relay_execute)
    def request(name, payload, **kw):
        event('request_middleware_fixture')
        return types.SimpleNamespace(payload=payload, trace=[{'fixture':'pass-through'}])
    def execution(name, payload, next_fn, **kw):
        event('execution_middleware_fixture')
        first = next_fn(payload)
        if fixture['mode'] == 'double-callback': next_fn(payload)
        return first
    module('hermes_cli.middleware', apply_tool_request_middleware=request,
           run_tool_execution_middleware=execution)
    actual_consumer = policy._get_pre_tool_call_directive_details
    def trace_consumer(*a, **kw):
        allowed = getattr(policy._thread_tool_whitelist, 'allowed', None)
        event('actual_whitelist_consumer', allowed=None if allowed is None else sorted(allowed))
        return actual_consumer(*a, **kw)
    policy._get_pre_tool_call_directive_details = trace_consumer  # Observer wrapper; body unchanged.
    def guard(name, payload):
        event('guardrail_fixture', allows=fixture['guard_allow'])
        return types.SimpleNamespace(allows_execution=fixture['guard_allow'], message='synthetic guardrail block')
    executor.tool_hook_ids = lambda agent, task, call: {'task_id': task,'session_id':agent.session_id,'tool_call_id':call}
    executor._emit_terminal_post_tool_call = lambda agent, **kw:event('post_hook_fixture', status=kw.get('status'),error_type=kw.get('error_type'))
    executor._begin_tool_execution = lambda agent, ref, index:event('begin_execution_fixture')
    executor._run_with_activity_heartbeat = lambda agent, name, fn:fn()
    executor._authorization_gate_lock_timeout = lambda:2.0
    executor._resolve_sequential_tool_timeout = lambda:5.0
    executor._NEVER_PARALLEL_TOOLS = frozenset({'clarify'})  # Exact constant from D11; rest not imported.
    executor._ra = lambda:types.SimpleNamespace(_set_interrupt=lambda value, tid, **kw:None)
    executor._interrupt_worker_tids = lambda *a, **kw:None  # Timeout/interrupt cases not claimed.
    def marker(payload):
        event('handler', args=dict(payload), callback_present=getattr(callbacks,'approval',None)=='synthetic-callback')
        return json.dumps({'ok':True,'marker':payload['marker']})
    def fresh_agent():
        return types.SimpleNamespace(session_id='research-session', _tool_worker_threads=set(),
             _tool_worker_threads_lock=threading.Lock(), _interrupt_requested=False,
             _tool_guardrails=types.SimpleNamespace(before_call=guard),
             _guardrail_block_result=lambda d:json.dumps({'error':d.message}),
             _touch_activity=lambda *a:None)
    cases = [
       ('C01','direct','research_marker',{'memory'},'none',True,None,False,0,True),
       ('C02','direct','research_marker',{'research_marker'},'none',True,None,False,1,False),
       ('C03','worker','research_marker',{'memory'},'none',True,None,False,1,False),
       ('C04','worker','research_marker',{'research_marker'},'none',True,None,False,1,False),
       ('C05','worker','clarify',{'memory'},'none',True,None,False,0,True),
       ('C06','worker','research_marker',{'memory'},'none',True,None,True,0,True),
       ('C07','worker','research_marker',{'memory'},'none',True,'synthetic scope block',False,0,True),
       ('C08','worker','research_marker',{'memory'},'none',False,None,False,0,True),
       ('C09','worker','research_marker',{'memory'},'block',True,None,False,0,True),
       ('C10','worker','research_marker',{'memory'},'raise',True,None,False,1,False),
       ('C11','worker','research_marker',{'memory'},'approve',True,None,False,0,True),
       ('C12','worker','research_marker',{'memory'},'double-callback',True,None,False,1,None),
       ('C13','worker','research_marker',{'memory'},'modify-block',True,None,False,0,True),
       ('C14','worker','research_marker',{'memory'},'modify',True,None,False,1,False),
    ]
    results=[]
    for cid, route, name, allowed, mode, guard_allow, scope, bind, count, expected_blocked in cases:
        fixture.update(events=[],mode=mode,guard_allow=guard_allow)
        agent=fresh_agent(); parent_tid=threading.get_ident()
        ot=origin.set('background_review'); pt=profile.set('synthetic-profile')
        callbacks.approval='synthetic-callback'; callbacks.sudo=None
        policy.set_thread_tool_whitelist(set(allowed))
        original_helper=executor.propagate_context_to_thread
        if bind:
            def with_worker_policy(target):
                def bound(*a, **kw):
                    policy.set_thread_tool_whitelist(set(allowed))
                    try: return target(*a, **kw)
                    finally: policy.clear_thread_tool_whitelist()
                return original_helper(bound)
            executor.propagate_context_to_thread=with_worker_policy
        kwargs=dict(function_name=name,function_args={'marker':'unchanged'},effective_task_id='research-task',
                    tool_call_id=cid,execute=marker,scope_block=scope,middleware_trace=[])
        state=None; error=None
        try:
            runner=executor._run_agent_tool_execution_middleware if route=='direct' else executor._run_sequential_tool_execution_middleware
            try: state=runner(agent,**kwargs)
            except Exception as exc: error={'type':type(exc).__name__,'message':str(exc)}
            handlers=[e for e in fixture['events'] if e['kind']=='handler']
            readers=[e for e in fixture['events'] if e['kind']=='actual_whitelist_consumer']
            parent_preserved=(getattr(policy._thread_tool_whitelist,'allowed',None)==allowed
                              and origin.get()=='background_review' and profile.get()=='synthetic-profile'
                              and callbacks.approval=='synthetic-callback')
            check={'handler_count':len(handlers)==count,'parent_preserved':parent_preserved,
                   'worker_registry_empty':not agent._tool_worker_threads}
            if cid=='C12':
                check['double_callback_rejected']=error is not None and error['type']=='RuntimeError' and 'more than once' in error['message']
            else:
                check['no_unexpected_exception']=error is None
                check['blocked_matches']=state is not None and state.blocked==expected_blocked
                check['dispatched_is_callback_flag']=state is not None and state.dispatched is True
            if cid in ('C03','C04','C08','C09','C10','C11','C12','C13','C14'):
                check['worker_has_no_parent_whitelist']=len(readers)==1 and readers[0]['allowed'] is None and readers[0]['thread']!=parent_tid
            if cid in ('C01','C05'):
                check['same_thread_sees_policy']=len(readers)==1 and readers[0]['allowed']==sorted(allowed) and readers[0]['thread']==parent_tid
            if cid=='C06': check['worker_binding_restores_policy']=readers[0]['allowed']==sorted(allowed) and readers[0]['thread']!=parent_tid
            if cid=='C14': check['modified_args_reach_handler']=handlers[0]['args']['marker']=='changed'
            if handlers: check['context_retained']=all(e['origin']=='background_review' and e['profile']=='synthetic-profile' for e in handlers)
            results.append({'id':cid,'route':route,'tool_name':name,'fixture_mode':mode,
                 'worker_binding_intervention':bind,'handler_count':len(handlers),
                 'blocked':getattr(state,'blocked',None),'dispatched':getattr(state,'dispatched',None),
                 'result':getattr(state,'result',None),'exception':error,'checks':check,
                 'expectations_matched':all(check.values()),'events':list(fixture['events'])})
        finally:
            executor.propagate_context_to_thread=original_helper
            policy.clear_thread_tool_whitelist(); origin.reset(ot); profile.reset(pt)
            callbacks.approval=None;callbacks.sudo=None
    data=(ROOT/'upstream/thread_context.py').read_bytes()
    modified_rejected=blob_hash(data+b'\n')!=EXPECTED['thread_context.py']
    excerpts={p.name:{'sha256':hashlib.sha256(p.read_bytes()).hexdigest(),'bytes':p.stat().st_size,
                     'full_upstream_blob_verified':False} for p in sorted((ROOT/'excerpts').glob('*.py'))}
    report={'kind':'SOURCE_EXTRACTED_FUNCTION_INTEGRATION_NOT_PRODUCT_PASS',
            'started_at_utc':started,'finished_at_utc':datetime.now(timezone.utc).isoformat(),
            'upstream_pin':'c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a',
            'runtime':{'python':platform.python_version(),'platform':platform.platform()},
            'full_source_identities':source_ids,'source_excerpts':excerpts,
            'harness_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
            'spec_sha256':hashlib.sha256((ROOT/'SPEC.md').read_bytes()).hexdigest(),
            'modified_full_source_identity_rejected':modified_rejected,
            'all_diagnostic_expectations_matched':all(r['expectations_matched'] for r in results),
            'cases':results,
            'limitations':['Manually transcribed large-module source selections, not full-module byte-verified execution.',
                           'Boundary doubles for Relay/middleware/lifecycle delivery/guardrail/UI/approval/config/profile.',
                           'Only selected sequential wrapper and direct branch; no complete ordinary loop, PluginManager, concurrent executor or AIAgent.',
                           'No real tool effect except harmless in-memory marker; no network, provider or credentials.',
                           'Not a production exploit, prevalence estimate, security certification or learning-quality evaluation.']}
    output=Path(args.output)
    if not output.is_absolute(): output=ROOT/output
    output.write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    print(json.dumps({'cases':len(results),'expectations_matched':report['all_diagnostic_expectations_matched'],'output':str(output)}))
    return 0 if report['all_diagnostic_expectations_matched'] and modified_rejected else 1

if __name__=='__main__':
    raise SystemExit(main())
