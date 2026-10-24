#!/usr/bin/env python3
"""Bounded AST cross-check against manually transcribed pinned source ranges.

NOT the full-original verify_excerpts.py check. Both sides involve assistant
transcription. No research-target code is executed by this checker.
"""
from __future__ import annotations
import argparse
import ast
import copy
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import platform
import sys

ROOT = Path(__file__).resolve().parent
SOURCES = {
    'executor': {
        'excerpt': 'excerpts/tool_executor.selected.py',
        'excerpt_blob': '027023684d477e9919613492e991d0ec706a3a0f',
        'upstream_path': 'agent/tool_executor.py',
        'upstream_blob': '799199c10f9930da77c01da2324373614b27cb78',
        'ranges': ['executor-types.py','executor-policy.py','executor-sequential.py'],
    },
    'plugins': {
        'excerpt': 'excerpts/plugins.selected.py',
        'excerpt_blob': '980c7edb1d9a0f402b3d58302c6844c32f392c36',
        'upstream_path': 'hermes_cli/plugins.py',
        'upstream_blob': 'da8d7e2c68b2346e6ecc15567d755d96085ef767',
        'ranges': ['plugins.py'],
    },
}

def blob(data: bytes) -> str:
    return hashlib.sha1(b'blob '+str(len(data)).encode()+b'\0'+data).hexdigest()

def definitions(data: bytes) -> dict[str, ast.AST]:
    out = {}
    for node in ast.parse(data.decode('utf-8')).body:
        if isinstance(node,(ast.FunctionDef,ast.AsyncFunctionDef,ast.ClassDef)):
            out[node.name] = node
        elif isinstance(node,ast.Assign):
            for target in node.targets:
                if isinstance(target,ast.Name): out[target.id] = node
        elif isinstance(node,ast.AnnAssign) and isinstance(node.target,ast.Name):
            out[node.target.id] = node
    return {k:v for k,v in out.items() if k!='logger'}

def equal(a: ast.AST, b: ast.AST | None) -> bool:
    return b is not None and ast.dump(a,include_attributes=False)==ast.dump(b,include_attributes=False)

def main() -> int:
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--prior',type=Path,default=ROOT.parent/'2026-09-08-worker-policy')
    ap.add_argument('--output',type=Path,default=ROOT/'RANGE-FIDELITY.json')
    args=ap.parse_args(); rows=[]; identities={}; challenge=None
    for group,spec in SOURCES.items():
        data=(args.prior/spec['excerpt']).read_bytes()
        if blob(data)!=spec['excerpt_blob']:
            raise ValueError(f'Old evidence identity mismatch: {spec["excerpt"]}')
        old=definitions(data); new={}; identities[group]={}
        for filename in spec['ranges']:
            raw=(ROOT/'canonical-ranges'/filename).read_bytes()
            identities[group][filename]={'bytes':len(raw),'sha256':hashlib.sha256(raw).hexdigest()}
            for name,node in definitions(raw).items():
                if name in new: raise ValueError(f'Duplicate comparison definition: {name}')
                new[name]=node
        for name,node in old.items():
            rows.append({'source':spec['upstream_path'],'claimed_upstream_blob':spec['upstream_blob'],
                         'symbol':name,'equal':equal(node,new.get(name))})
        if group=='plugins':
            name='_get_pre_tool_call_directive_details'
            altered=copy.deepcopy(new[name]); changed=False
            for node in ast.walk(altered):
                if isinstance(node,ast.Constant) and node.value=='block':
                    node.value='deliberately_changed'; changed=True; break
            challenge={'symbol':name,'synthetic_change_applied':changed,
                       'comparison_detected_change':not equal(old[name],altered),
                       'target_code_executed':False}
    passed=len(rows)==22 and all(r['equal'] for r in rows) and bool(challenge and challenge['comparison_detected_change'])
    out={'kind':'MANUAL_PINNED_RANGE_TRANSCRIPTION_AST_CROSSCHECK',
         'checked_at_utc':datetime.now(timezone.utc).isoformat(),
         'runtime':{'python':sys.version,'platform':platform.platform()},
         'prior_research_ref':'9a95b2cf1f8a0460ac6128e1409bf54aa3191022',
         'upstream_pin':'c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a',
         'definition_count':len(rows),'all_equal':all(r['equal'] for r in rows),'checks_satisfied':passed,
         'symbols':rows,'comparison_inputs':identities,'negative_control':challenge,
         'comparison_policy':'AST includes docstrings and decorators; excludes source positions, imports and logger scaffolding',
         'complete_large_originals_locally_hash_verified':False,'original_verify_excerpts_script_run':False,
         'preliminary_ad_hoc_equality_observed_before_spec':True,
         'limitation':'Both old excerpt and fresh range inputs are assistant transcriptions. This reduces selection-error uncertainty only; no independent whole-file fidelity or whole-runtime verdict.',
         'checker_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
    args.output.write_text(json.dumps(out,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    print(json.dumps({'definition_count':len(rows),'all_equal':out['all_equal'],'negative_control':challenge['comparison_detected_change']}))
    return 0 if passed else 1
if __name__=='__main__': raise SystemExit(main())
