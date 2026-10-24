#!/usr/bin/env python3
"""Publication/transfer checks only. This does not run HERMES behavior tests."""
from __future__ import annotations
import ast,copy,hashlib,importlib.util,json,tempfile
from pathlib import Path
R=Path(__file__).resolve().parent
spec=importlib.util.spec_from_file_location('u04_prepare',R/'prepare_repository.py')
p=importlib.util.module_from_spec(spec);spec.loader.exec_module(p)
m=json.loads((R/'publication_manifest.json').read_text())
checks={}
checks['payload_hashes_match']=all(hashlib.sha256((R/f).read_bytes()).hexdigest()==h for f,h in m['payload_sha256'].items())
for f in R.rglob('*.py'):ast.parse(f.read_text())
checks['python_files_parse']=True
raw=json.loads((R/'evidence/RESULT.json').read_text())
checks['recorded_probe_matches']=raw['probe_sha256']==hashlib.sha256((R/'evidence/probe.py').read_bytes()).hexdigest()
checks['recorded_spec_matches']=raw['spec_sha256']==hashlib.sha256((R/'evidence/SPEC.md').read_bytes()).hexdigest()
checks['recorded_sources_match']=all(hashlib.sha256((R/f).read_bytes()).hexdigest()==v['sha256'] for f,v in raw['source_identity']['files'].items())
checks['full_heartbeat_upstream_blob_matches']=p.blob((R/'source/heartbeat.py').read_bytes())=='d3f440d9ed2035505b0bdfbe7d6d57dec926317f'
checks['cases_recorded']=len(raw['cases'])
checks['case_expectations_recorded_matched']=raw['all_case_expectations_matched']
checks['negative_controls_recorded_detected']=raw['all_negative_controls_detected']

# Synthetic clone-shaped fixture: validates file-preparation mechanics, NOT
# application to a real clone or GitHub, and NOT an HERMES behavior experiment.
def fixture(root):
    (root/'.git').mkdir(); expected={}
    for rel in m['expected_existing_blobs']:
        content='# prior fixture content\n'
        if rel.endswith('/INDEX.md'):
            content='''# INDEX fixture
[v0.15](RESEARCH-PLAN.md)
| Question | First route |
|---|---|
actual Kanban goal-loop/worker continuation, then goal/loop/heartbeat distinctions
| Scope rebalance and source inventory |
No third completed synthesis, native CORE, four-area projection or architecture/adoption is asserted.
'''
        elif rel.endswith('/CATALOG.md'):
            content='before-untouched\n| `hermes-agent` | prior fixture row |\nafter-untouched\n'
        elif rel.endswith('/SOURCE-LEDGER.md'):
            content='# Ledger fixture\n**2026-09-11 / plan v0.15.**\nold history\n## Açık bağımlılıklar\nremain open\n'
        dest=root/rel;dest.parent.mkdir(parents=True,exist_ok=True);dest.write_text(content)
        expected[rel]=p.blob(dest.read_bytes())
    sentinel=root/'research/soul-foundations/untouched.txt';sentinel.parent.mkdir(parents=True,exist_ok=True);sentinel.write_bytes(b'preserve-foundation')
    mm=copy.deepcopy(m);mm['expected_existing_blobs']=expected
    return mm

with tempfile.TemporaryDirectory(prefix='u04-publication-check-') as td:
    root=Path(td);mm=fixture(root)
    plan=p.make_plan(root,mm)
    checks['synthetic_preparation_target_count']=len(plan)
    p.apply(root,plan)
    checks['synthetic_applied_files_match']=all((root/f).read_bytes()==b for f,b in plan.items())
    checks['synthetic_unrelated_file_preserved']=(root/'research/soul-foundations/untouched.txt').read_bytes()==b'preserve-foundation'
    catalog=(root/'research/studies/CATALOG.md').read_text()
    checks['synthetic_only_catalog_row_changed']=catalog.startswith('before-untouched\n') and catalog.endswith('\nafter-untouched\n')
with tempfile.TemporaryDirectory(prefix='u04-publication-change-') as td:
    root=Path(td);mm=fixture(root)
    path=root/'research/studies/hermes-agent/STATE.md';path.write_text('changed by someone else')
    try:p.make_plan(root,mm)
    except ValueError:checks['changed_existing_target_rejected']=True
    else:checks['changed_existing_target_rejected']=False
with tempfile.TemporaryDirectory(prefix='u04-publication-collision-') as td:
    root=Path(td);mm=fixture(root)
    target=next(v for v in mm['copies'].values() if v not in mm['expected_existing_blobs'])
    dest=root/target;dest.parent.mkdir(parents=True,exist_ok=True);dest.write_text('pre-existing new target')
    try:p.make_plan(root,mm)
    except ValueError:checks['existing_new_target_rejected']=True
    else:checks['existing_new_target_rejected']=False

out={'kind':'PUBLICATION_PACKAGE_CHECK_NOT_HERMES_EXECUTION','checks':checks,
     'actual_repository_mutated':False,'git_commit_or_push_performed':False,
     'limitation':'prepare_repository mechanics checked using synthetic clone-shaped data; current GitHub application/readback not performed'}
(R/'PACKAGE-CHECK.json').write_text(json.dumps(out,ensure_ascii=False,indent=2)+'\n')
print(json.dumps(out,ensure_ascii=False,indent=2))
assert all(v for v in checks.values()),'package validation failed'
