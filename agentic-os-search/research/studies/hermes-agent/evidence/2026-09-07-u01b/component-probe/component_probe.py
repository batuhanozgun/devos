#!/usr/bin/env python3
"""Bounded component probe for Hermes c4a5dee; NOT an installed-Hermes test.

Runs only two hash-verified, inspected upstream modules against synthetic files.
The single-op skill mutator, profile resolver and guard are explicit stubs.
No provider/network calls, package installs, real Hermes config or user data.
Invoke: python component_probe.py [--output RESULT.json]
"""
from __future__ import annotations

import argparse
import contextvars
import hashlib
import importlib.util
import json
import platform
import sys
import tempfile
import types
from datetime import datetime, timezone
from pathlib import Path
from unittest.mock import patch

PIN = 'c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a'
EXPECTED = {
    'skill_manager_batch.py': '9f38adff284eede4234948f67e99a43752c0926e',
    'write_approval.py': 'f1e99b46e934595c002c2bc659143fcbc1f9fe8d',
    'LICENSE': '75410e73319c72cd3e991a501c5455eb78f38375',
}
HERE = Path(__file__).resolve().parent


def identify_sources() -> dict:
    out = {}
    for name, expected in EXPECTED.items():
        content = (HERE / 'upstream' / name).read_bytes()
        actual = hashlib.sha1(b'blob ' + str(len(content)).encode() + b'\0' + content).hexdigest()
        if actual != expected:
            raise RuntimeError(f'Source identity mismatch: {name}: {actual} != {expected}')
        out[name] = {'git_blob': actual, 'bytes': len(content),
                     'sha256': hashlib.sha256(content).hexdigest(), 'identity_matches': True}
    return out


def load_module(name: str, filename: str):
    spec = importlib.util.spec_from_file_location(name, HERE / 'upstream' / filename)
    if spec is None or spec.loader is None:
        raise RuntimeError(f'Could not load {filename}')
    module = importlib.util.module_from_spec(spec)
    sys.modules[name] = module  # dataclass resolution requires the registered module
    spec.loader.exec_module(module)
    return module


def module(name: str, **attrs):
    out = types.ModuleType(name)
    for key, value in attrs.items():
        setattr(out, key, value)
    return out


def run() -> dict:
    identities = identify_sources()  # mandatory BEFORE any upstream module executes
    cases = []
    with tempfile.TemporaryDirectory(prefix='hermes_component_probe_') as raw_root:
        root = Path(raw_root)
        sandbox = {'home': root}
        constants = module('hermes_constants', get_hermes_home=lambda: sandbox['home'])
        tools = module('tools', __path__=[])
        smt = module('tools.skill_manager_tool')
        registry = module('tools.registry', tool_error=lambda error, **kw: json.dumps({'error': error, **kw}))
        guards = module('tools.skill_manager_guards', _background_review_preflight=lambda action, name: None)
        modules = {
            'hermes_constants': constants, 'tools': tools,
            'tools.skill_manager_tool': smt, 'tools.registry': registry,
            'tools.skill_manager_guards': guards,
        }
        with patch.dict(sys.modules, modules):
            batch = load_module('_hermes_research_batch', 'skill_manager_batch.py')
            approval = load_module('_hermes_research_approval', 'write_approval.py')
            tools.skill_manager_tool = smt
            smt._skill_gate_bypass = contextvars.ContextVar('synthetic_gate', default=False)
            smt._run_write_gate = lambda build: None  # open gate, not an approval-system test

            for mode in ('success', 'error_result', 'malformed_result', 'exception', 'restore_error'):
                home = root / mode
                skill = home / 'skills' / 'probe'
                skill.mkdir(parents=True)
                target = skill / 'SKILL.md'
                target.write_text('ORIGINAL\n', encoding='utf-8')
                snap_parent = home / 'snapshots'
                snap_parent.mkdir()
                smt._find_skill = lambda name, p=skill: {'path': p} if name == 'probe' and p.is_dir() else None
                events = []  # synthetic non-directory side effects; NOT the real ledger or network
                calls = {'n': 0}

                def fake_single_op(payload, **kw):
                    calls['n'] += 1
                    if calls['n'] == 1:
                        target.write_text('FIRST-APPLIED\n', encoding='utf-8')
                        events.append('synthetic-side-effect-1')
                        return json.dumps({'success': True})
                    if mode in ('error_result', 'restore_error'):
                        return json.dumps({'success': False, 'error': 'synthetic returned failure'})
                    if mode == 'malformed_result':
                        return 'not-json'
                    if mode == 'exception':
                        raise OSError('synthetic mutator exception')
                    target.write_text('SECOND-APPLIED\n', encoding='utf-8')
                    events.append('synthetic-side-effect-2')
                    return json.dumps({'success': True})

                smt._skill_manage_from = fake_single_op
                real_mkdtemp = tempfile.mkdtemp
                def confined_mkdtemp(*a, **kw):
                    kw['dir'] = snap_parent
                    return real_mkdtemp(*a, **kw)
                real_copytree = batch.shutil.copytree
                copy_calls = {'n': 0}
                def copytree_with_fault(src, dst, *a, **kw):
                    copy_calls['n'] += 1
                    if mode == 'restore_error' and copy_calls['n'] == 2:
                        raise OSError('synthetic restore failure')
                    return real_copytree(src, dst, *a, **kw)

                result = None
                exception = None
                ops = [{'name': 'probe', 'action': 'patch', 'old_string': 'ORIGINAL', 'new_string': 'FIRST'},
                       {'name': 'probe', 'action': 'patch', 'old_string': 'FIRST', 'new_string': 'SECOND'}]
                with patch.object(batch.tempfile, 'mkdtemp', confined_mkdtemp), \
                     patch.object(batch.shutil, 'copytree', copytree_with_fault):
                    try:
                        result = json.loads(batch._skill_manage_batch(ops))
                    except OSError as exc:
                        exception = str(exc)
                live = target.read_text(encoding='utf-8')
                snapshots = list(snap_parent.glob('skill_batch_*'))
                if mode == 'success':
                    assert result['success'] and live == 'SECOND-APPLIED\n' and not snapshots
                elif mode in ('error_result', 'malformed_result'):
                    assert not result['success'] and live == 'ORIGINAL\n' and not snapshots
                    assert events == ['synthetic-side-effect-1']
                elif mode == 'exception':
                    assert exception == 'synthetic mutator exception'
                    assert live == 'FIRST-APPLIED\n' and not snapshots
                else:
                    assert not result['success'] and 'ROLLBACK FAILED' in result['error']
                    assert live == 'FIRST-APPLIED\n' and len(snapshots) == 1
                    assert (snapshots[0] / 'probe' / 'SKILL.md').read_text() == 'ORIGINAL\n'
                cases.append({
                    'id': f'B{len(cases)+1:02d}', 'case': mode,
                    'result': result, 'exception': exception, 'live_file': live,
                    'rollback_snapshot_dirs_remaining': len(snapshots),
                    'synthetic_side_effects_remaining': list(events),
                    'gate_context_restored': not smt._skill_gate_bypass.get(),
                    'expected_diagnostic_outcome_observed': True,
                })

            # Exact preview implementation; skill-directory resolution is the only stub.
            home = root / 'preview'
            skill = home / 'skills' / 'probe'
            skill.mkdir(parents=True)
            original = '---\nname: probe\ndescription: Example.\n---\nORIGINAL\n'
            replacement = original.replace('ORIGINAL', 'REPLACED')
            (skill / 'SKILL.md').write_text(original, encoding='utf-8')
            smt._find_skill = lambda name: {'path': skill} if name == 'probe' else None
            plain = {'action': 'patch', 'name': 'probe', 'old_string': 'ORIGINAL', 'new_string': 'REPLACED'}
            text = approval.skill_pending_diff({'payload': plain})
            assert '-ORIGINAL' in text and '+REPLACED' in text
            cases.append({'id': 'D01', 'case': 'flat_targeted_patch_preview_control', 'rendered': text,
                          'expected_diagnostic_outcome_observed': True})
            batch_payload = {'action': 'batch', 'operations': [plain]}
            text = approval.skill_pending_diff({'payload': batch_payload})
            assert text == "(batch on '')" and 'REPLACED' not in text
            cases.append({'id': 'D02', 'case': 'advertised_batch_shape_preview', 'rendered': text,
                          'proposed_change_visible_in_diff': False,
                          'expected_diagnostic_outcome_observed': True})
            text = approval.skill_pending_diff({'payload': {'action': 'patch', 'name': 'probe',
                                                            'content': replacement}})
            assert replacement != original and text == '(no textual change)'
            cases.append({'id': 'D03', 'case': 'flat_content_rewrite_preview', 'rendered': text,
                          'payload_differs_from_current_file': True,
                          'expected_diagnostic_outcome_observed': True})

            for failing in (False, True):
                sandbox['home'] = root / ('stage_failure' if failing else 'stage_success')
                sandbox['home'].mkdir()
                if failing:
                    with patch.object(approval.os, 'replace', side_effect=OSError('synthetic rename failure')):
                        rec = approval.stage_write(approval.SKILLS, batch_payload,
                                                  summary='synthetic pending batch', origin='background_review')
                else:
                    rec = approval.stage_write(approval.SKILLS, batch_payload,
                                              summary='synthetic pending batch', origin='background_review')
                retrievable = approval.get_pending(approval.SKILLS, rec['id']) is not None
                listed = len(approval.list_pending(approval.SKILLS))
                tmp_count = len(list((sandbox['home'] / 'pending' / 'skills').glob('*.json.tmp')))
                assert retrievable is (not failing) and listed == int(not failing)
                assert tmp_count == int(failing)
                cases.append({'id': 'D05' if failing else 'D04',
                              'case': 'stage_rename_failure' if failing else 'stage_success_control',
                              'record_returned': bool(rec['id']), 'retrievable_by_id': retrievable,
                              'listed_pending_records': listed, 'orphan_temporary_records': tmp_count,
                              'expected_diagnostic_outcome_observed': True})

    # Scrub temporary paths so the report is reproducible and does not imply a live user location.
    encoded = json.dumps(cases, ensure_ascii=False).replace(raw_root, '<synthetic-root>')
    return {
        'research_pin': PIN, 'utc_run_timestamp': datetime.now(timezone.utc).isoformat(),
        'python': platform.python_version(), 'platform': platform.system(),
        'source_identities': identities,
        'scope': 'Two exact pinned modules; dependency stubs; synthetic files only.',
        'not_performed': ['Hermes installation', 'whole application test', 'upstream test-suite run',
                          'provider/network call', 'real Hermes config/user-data access',
                          'independent researcher replication', 'remote repository mutation'],
        'interpretation': ('Diagnostic assertions confirm the listed observations. They are not a Hermes '
                           'conformance PASS. Exception rollback and preview/pending limitations are '
                           'bounded component findings, not measured production incident rates.'),
        'cases': json.loads(encoded), 'diagnostic_cases': len(cases),
        'all_expected_diagnostic_outcomes_observed': all(c['expected_diagnostic_outcome_observed'] for c in cases),
    }


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, default=HERE / 'RESULT.json')
    args = parser.parse_args()
    result = run()
    args.output.write_text(json.dumps(result, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
    print(json.dumps({'output': str(args.output), 'diagnostic_cases': result['diagnostic_cases'],
                      'expected_outcomes_observed': result['all_expected_diagnostic_outcomes_observed'],
                      'is_upstream_suite_pass': False}, indent=2))


if __name__ == '__main__':
    main()
