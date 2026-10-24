#!/usr/bin/env python3
"""Offline diagnostic of a full, pinned Hermes slash-access module."""
from __future__ import annotations
import hashlib
import importlib.util
import json
import platform
import sys
from datetime import datetime, timezone
from pathlib import Path
from types import SimpleNamespace as NS

ROOT = Path(__file__).resolve().parent
EXPECTED = '07204201e411f29f912bb9bba6beec0566acab9d'

def git_blob(data: bytes) -> str:
    return hashlib.sha1(b'blob ' + str(len(data)).encode() + b'\0' + data).hexdigest()

def verify(data: bytes) -> None:
    got = git_blob(data)
    if got != EXPECTED:
        raise ValueError(f'source identity mismatch: {got}')

def main() -> int:
    src = ROOT / 'upstream/slash_access.py'
    data = src.read_bytes()
    verify(data)
    rejected = False
    try:
        verify(data + b'\n# deliberate negative identity variant\n')
    except ValueError:
        rejected = True
    spec = importlib.util.spec_from_file_location('hermes_m3_slash_access', src)
    if spec is None or spec.loader is None:
        raise RuntimeError('unable to construct module spec')
    mod = importlib.util.module_from_spec(spec)
    sys.modules[spec.name] = mod
    spec.loader.exec_module(mod)
    def policy(extra, chat_type='dm'):
        return mod.policy_for_source(NS(platforms={'test': NS(extra=extra)}),
                                     NS(platform='test', chat_type=chat_type))
    results=[]
    def record(case_id, label, observed, expected):
        results.append({'id':case_id, 'label':label, 'observed':observed,
                        'expected':expected, 'matched':observed==expected})
    p=policy({'user_allowed_commands':['memory']})
    record('AP01','No admins disables slash gate',
           [p.enabled,p.can_run('member','memory'),p.can_run('member','skills')],
           [False,True,True])
    p=policy({'allow_admin_from':['owner']})
    record('AP02','Explicit administrator and discovery floor',
           [p.can_run('member','memory'),p.can_run('owner','memory'),
            p.can_run('member','help'),p.can_run('member','whoami')],
           [False,True,True,True])
    p=policy({'allow_admin_from':['owner'],'user_allowed_commands':['/MeMoRy']})
    literal=policy({'allow_admin_from':['owner'],'user_allowed_commands':['memory approve']})
    record('AP03','Canonical name grants, not verb permissions',
           [p.can_run('member','memory'),p.can_run('member','skills'),literal.can_run('member','memory')],
           [True,False,False])
    extra={'allow_admin_from':['dm-owner'],'group_allow_admin_from':['group-owner']}
    dm=policy(extra); group=policy(extra,'group')
    no_group_admin=policy({'allow_admin_from':['dm-owner']},'group')
    record('AP04','Separate administrator scopes',
           [dm.can_run('dm-owner','memory'),group.can_run('dm-owner','memory'),
            group.can_run('group-owner','memory'),no_group_admin.enabled],
           [True,False,True,False])
    p=policy({'allow_admin_from':['dm-owner'],'user_allowed_commands':[],
              'group_allow_admin_from':['group-owner'],'group_user_allowed_commands':['memory']})
    record('AP05','DM command fallback without admin fallback',
           [p.can_run('member','memory'),p.is_admin('group-owner'),p.can_run('member','skills')],
           [True,False,False])
    p=policy({'allow_admin_from':['owner']})
    record('AP06','Missing principal and missing policy are distinct',
           [p.can_run(None,'memory'),p.can_run(None,'help'),mod.policy_for_source(None,None).enabled],
           [False,True,False])
    output={'kind':'BOUNDED_FULL_MODULE_POLICY_DIAGNOSTIC_NOT_GATEWAY_VALIDATION',
            'checked_at_utc':datetime.now(timezone.utc).isoformat(),
            'python':platform.python_version(),'platform':platform.platform(),
            'source_pin':'c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a',
            'source_path':'gateway/slash_access.py','source_git_blob':git_blob(data),
            'source_sha256':hashlib.sha256(data).hexdigest(),'source_bytes':len(data),
            'negative_identity_rejected_before_import':rejected,
            'cases':results,'all_diagnostic_expectations_matched':all(x['matched'] for x in results),
            'synthetic':'Config, source and user-id values only; no application or external service',
            'not_executed':['actual gateway ingress and dispatch','CLI and gateway pending handlers',
                            'profile routing and credentials','MemoryStore writes','cache reload or model request'],
            'prior_probes_rerun':False}
    (ROOT/'ACCESS-RESULT.json').write_text(json.dumps(output,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    print(json.dumps({'diagnostic_cases':len(results),'matched':output['all_diagnostic_expectations_matched'],
                      'negative_identity_rejected':rejected}))
    return 0 if rejected and output['all_diagnostic_expectations_matched'] else 1

if __name__=='__main__':
    raise SystemExit(main())
