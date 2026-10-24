#!/usr/bin/env python3
"""Run the existing identity verifier against a deliberately changed disposable copy."""
from pathlib import Path
from datetime import datetime, timezone
import hashlib, importlib.util, json, shutil, sys, tempfile
ROOT=Path(__file__).resolve().parent
spec=importlib.util.spec_from_file_location('worker_harness_for_identity',ROOT/'harness.py')
h=importlib.util.module_from_spec(spec);spec.loader.exec_module(h)
original=h.validate_full_sources()
before=set(sys.modules)
with tempfile.TemporaryDirectory(prefix='hermes_identity_') as td:
    tmp=Path(td);shutil.copytree(ROOT/'upstream',tmp/'upstream')
    target=tmp/'upstream/thread_context.py';target.write_bytes(target.read_bytes()+b'\n')
    h.ROOT=tmp
    error=None
    try: h.validate_full_sources()
    except ValueError as exc:error={'type':type(exc).__name__,'message':str(exc)}
    else:raise AssertionError('Changed source was not rejected')
    after=set(sys.modules)
    source_imports=sorted(n for n in after-before if n.startswith(('tools.','agent.','hermes_cli.')))
    assert not source_imports
result={'kind':'PRE_IMPORT_IDENTITY_GUARD_NEGATIVE_CONTROL',
        'executed_at_utc':datetime.now(timezone.utc).isoformat(),
        'original_sources_validated':original,'mutation':'one appended newline in disposable thread_context.py',
        'observed_error':error,'upstream_imports_after_check':source_imports,
        'guard_rejected_before_upstream_import':True,
        'limitation':'Source binding only, not behavior or excerpt equivalence.',
        'script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
(ROOT/'IDENTITY-CHECK.json').write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps({'negative_identity_control':'rejected before import'}))
