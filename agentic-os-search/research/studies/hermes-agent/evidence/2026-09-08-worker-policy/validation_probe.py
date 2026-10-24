#!/usr/bin/env python3
"""Complete name-validation module + selected policy/sequential function bridge.

Synthetic agent, hooks, middleware, profile and harmless handler; not a full product run.
Execute in a fresh process/disposable package copy. No network or installation.
"""
from __future__ import annotations
import contextvars, hashlib, importlib.util, json, platform, sys, threading, types
from pathlib import Path
from datetime import datetime, timezone
ROOT=Path(__file__).resolve().parent
spec=importlib.util.spec_from_file_location('probe_helpers',ROOT/'harness.py')
h=importlib.util.module_from_spec(spec);spec.loader.exec_module(h)
ids=h.validate_full_sources()
p=ROOT/'upstream/turn_tool_validation.py';data=p.read_bytes()
assert h.blob_hash(data)=='db3e89334ebb4302f55357e8063c28f5758becd5'
ids[p.name]={'git_blob':h.blob_hash(data),'sha256':hashlib.sha256(data).hexdigest(),'bytes':len(data)}
started=datetime.now(timezone.utc).isoformat()
for name in ('tools','agent','hermes_cli'):h.module(name,__path__=[])
h.module('tools.terminal_tool',_get_approval_callback=lambda:None,_get_sudo_password_callback=lambda:None,
         set_approval_callback=lambda x:None,set_sudo_password_callback=lambda x:None)
h.load('tools.thread_context',ROOT/'upstream/thread_context.py');h.load('tools.daemon_pool',ROOT/'upstream/daemon_pool.py')
policy=h.load('hermes_cli.plugins',ROOT/'excerpts/plugins.selected.py')
executor=h.load('agent.tool_executor',ROOT/'excerpts/tool_executor.selected.py')
h.module('agent.message_metadata',append_message=lambda messages,message:messages.append(message))
h.module('agent.message_sanitization',coalesce_tool_call_id=lambda tc:tc.id,
         close_interrupted_tool_sequence=lambda messages,final_response:None)
h.module('agent.conversation_loop',_invalid_tool_name_error_content=lambda name,valid:'fixture unknown tool: '+name)
validator=h.load('agent.turn_tool_validation',p)
ctx=contextvars.ContextVar('supplement_origin',default='unset')
events=[];mode={'lifecycle_block':False}
lock=threading.Lock()
def event(kind,**kw):
    with lock:events.append({'kind':kind,'thread':threading.get_ident(),'context':ctx.get(),**kw})
def lifecycle(name,**kw):
    event('lifecycle_fixture')
    return [{'action':'block','message':'independent fixture block'}] if mode['lifecycle_block'] else []
h.module('hermes_cli.lifecycle',invoke_hook=lifecycle)
h.module('tools.approval_context',get_current_session_key=lambda:'supplement')
h.module('tools.approval_human_wait',human_wait_seconds=lambda key:0.0)
h.module('agent.relay_tools',execute=lambda name,args,next_fn,**kw:(next_fn(args),args))
h.module('hermes_cli.middleware',apply_tool_request_middleware=lambda name,args,**kw:types.SimpleNamespace(payload=args,trace=[]),
         run_tool_execution_middleware=lambda name,args,next_fn,**kw:next_fn(args))
consumer=policy._get_pre_tool_call_directive_details
def observed_consumer(*args,**kwargs):
    allowed=getattr(policy._thread_tool_whitelist,'allowed',None)
    event('policy_consumer',allowed=None if allowed is None else sorted(allowed))
    return consumer(*args,**kwargs)
policy._get_pre_tool_call_directive_details=observed_consumer
executor.tool_hook_ids=lambda a,t,c:{'task_id':t,'session_id':a.session_id,'tool_call_id':c}
executor._emit_terminal_post_tool_call=lambda a,**kw:event('post_fixture',status=kw.get('status'))
executor._begin_tool_execution=lambda *a:event('begin_fixture')
executor._run_with_activity_heartbeat=lambda a,n,fn:fn()
executor._authorization_gate_lock_timeout=lambda:2.0
executor._resolve_sequential_tool_timeout=lambda:5.0
executor._NEVER_PARALLEL_TOOLS=frozenset({'clarify'})
executor._ra=lambda:types.SimpleNamespace(_set_interrupt=lambda *a:None)
executor._interrupt_worker_tids=lambda *a,**kw:None

def agent(valid):
    return types.SimpleNamespace(valid_tool_names=valid,log_prefix='',_invalid_tool_retries=0,_invalid_json_retries=0,
        _uniquify_tool_call_ids=lambda calls:None,_repair_tool_call=lambda name:None,
        _buffer_vprint=lambda *a,**kw:None,_flush_status_buffer=lambda:None,_vprint=lambda *a,**kw:None,
        _build_assistant_message=lambda message,reason:{'role':'assistant','fixture':'tool_calls'},
        _persist_session=lambda messages,history:event('persist_fixture'),
        _cleanup_task_resources=lambda task:event('cleanup_fixture'),
        session_id='supplement',_tool_worker_threads=set(),_tool_worker_threads_lock=threading.Lock(),
        _interrupt_requested=False,_tool_guardrails=types.SimpleNamespace(before_call=lambda *a:types.SimpleNamespace(allows_execution=True)),
        _guardrail_block_result=lambda d:'fixture guard block',_touch_activity=lambda *a:None)
def marker(args):
    event('handler',args=args)
    return json.dumps({'ok':True,'marker':args.get('marker','empty-args-control')})
rows=[]
cases=[('V01',{'memory','research_marker'},'{"marker":"benign"}',False,'ok',1),
       ('V02',{'memory'},'{"marker":"benign"}',False,'continue',0),
       ('V03',{'memory','research_marker'},'{"marker":',False,'return',0),
       ('V04',{'memory','research_marker'},'{"marker":"benign"}',True,'ok',0),
       ('V05',{'memory','research_marker'},'',False,'ok',1)]
for cid,valid,raw,block,expected_verdict,expected_count in cases:
    events.clear();mode['lifecycle_block']=block
    a=agent(valid);messages=[]
    call=types.SimpleNamespace(id=cid,function=types.SimpleNamespace(name='research_marker',arguments=raw))
    message=types.SimpleNamespace(tool_calls=[call])
    policy.set_thread_tool_whitelist({'memory'});token=ctx.set('background_review_marker')
    try:
        verdict=validator.validate_tool_calls(a,message,'tool_calls',messages=messages,conversation_history=[],api_call_count=1,effective_task_id='supplement')
        event('validation_verdict',action=verdict.action)
        result=None
        if verdict.action=='ok':
            result=executor._run_sequential_tool_execution_middleware(a,function_name=call.function.name,
                function_args=json.loads(call.function.arguments),effective_task_id='supplement',tool_call_id=cid,
                middleware_trace=[],execute=marker)
        count=sum(e['kind']=='handler' for e in events)
        checks={'verdict_matches':verdict.action==expected_verdict,'handler_count_matches':count==expected_count,
                'parent_policy_preserved':getattr(policy._thread_tool_whitelist,'allowed',None)=={'memory'},
                'worker_registration_clean':not a._tool_worker_threads}
        if cid=='V02':checks['error_message_recorded']=any(m.get('role')=='tool' for m in messages)
        if cid=='V03':checks['partial_exit_and_cleanup']=bool(verdict.result and verdict.result.get('partial')) and any(e['kind']=='cleanup_fixture' for e in events)
        if cid=='V04':checks['independent_block_survives']=result is not None and result.blocked
        if cid=='V05':checks['empty_arguments_normalized']=call.function.arguments=='{}'
        rows.append({'id':cid,'synthetic_valid_names':sorted(valid),'initial_raw_arguments':raw,'normalized_arguments':call.function.arguments,
            'verdict':verdict.action,'handler_count':count,'blocked':getattr(result,'blocked',None),'checks':checks,
            'expectations_matched':all(checks.values()),'messages':messages,'trace':list(events)})
    finally:policy.clear_thread_tool_whitelist();ctx.reset(token)
report={'kind':'COMPLETE_NAME_VALIDATOR_PLUS_SOURCE_SELECTED_WORKER_BRIDGE_NOT_PRODUCT_PASS',
        'started_at_utc':started,'finished_at_utc':datetime.now(timezone.utc).isoformat(),
        'upstream_pin':'c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a',
        'runtime':{'python':platform.python_version(),'platform':platform.platform()},'full_sources':ids,
        'cases':rows,'all_expectations_matched':all(r['expectations_matched'] for r in rows),
        'script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        'spec_sha256':hashlib.sha256((ROOT/'VALIDATION-SPEC.md').read_bytes()).hexdigest(),
        'limits':['valid_tool_names supplied by synthetic holder, not real review construction',
                  'message helpers are doubles; excerpts not complete-module verified',
                  'selected worker pipeline only, not full ordinary loop/PluginManager/alternate transport',
                  'no model/provider, install, credentials, real profile, network or dangerous handler']}
(ROOT/'VALIDATION-RESULT.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n')
print(json.dumps({'cases':len(rows),'matched':report['all_expectations_matched']}))
raise SystemExit(0 if report['all_expectations_matched'] else 1)
