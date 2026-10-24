#!/usr/bin/env python3
"""Bounded U01 probes; not a live-harness or model-behavior evaluation.

Usage: python probe_hook.py /path/to/pinned/hooks/session-start
The input must match the recorded upstream Git blob. Only temporary fixtures
are written. Network access, plugin installation and credentials are not used.
Criteria are defined below before execution. Missing/empty bootstrap cases are
health challenges: exit zero is recorded as a failed readiness criterion, not
as successful bootstrap. A deliberately broken event name checks the oracle.
"""
from __future__ import annotations
import hashlib
import json
import os
import pathlib
import platform
import shutil
import subprocess
import sys
import tempfile

PIN = 'b36e0829c6d0140e93cfef2ca599b1b07d4a7797'
BLOB = '93a6bc2c6b7269c704378cb6a61fce6aea7ff631'
MARKER = 'U01_SENTINEL_7f9a'
FIXTURE = MARKER + '\nquote="yes"; slash=\\; tab=\t; cr=\r; unicode=ğ' + '\n'


def extract(payload: dict, shape: str) -> str:
    if shape == 'nested':
        assert set(payload) == {'hookSpecificOutput'}, 'wrong top-level fields'
        nested = payload['hookSpecificOutput']
        assert nested['hookEventName'] == 'SessionStart', 'wrong event name'
        assert set(nested) == {'hookEventName', 'additionalContext'}
        context = nested['additionalContext']
    else:
        key = 'additional_context' if shape == 'cursor' else 'additionalContext'
        assert set(payload) == {key}, 'wrong or duplicate context fields'
        context = payload[key]
    assert isinstance(context, str) and context.strip(), 'empty context envelope'
    return context


def main() -> None:
    if len(sys.argv) != 2:
        raise SystemExit('Usage: probe_hook.py /path/to/pinned/hooks/session-start')
    data = pathlib.Path(sys.argv[1]).read_bytes()
    digest = hashlib.sha1(b'blob ' + str(len(data)).encode() + b'\0' + data).hexdigest()
    if digest != BLOB:
        raise SystemExit(f'Source identity mismatch: {digest} != {BLOB}')
    bash = shutil.which('bash')
    if not bash:
        raise SystemExit('bash is required')
    rows = []
    with tempfile.TemporaryDirectory(prefix='superpowers-u01-') as tmp:
        root = pathlib.Path(tmp)
        hook = root / 'hooks' / 'session-start'
        skill = root / 'skills' / 'using-superpowers' / 'SKILL.md'
        hook.parent.mkdir(parents=True)
        skill.parent.mkdir(parents=True)
        hook.write_bytes(data)
        home = root / 'home'
        home.mkdir()
        # A clean environment prevents platform-variable leakage from this host.
        base = {'PATH': os.defpath, 'HOME': str(home), 'LC_ALL': 'C.UTF-8'}
        cases = [
            ('claude', {'CLAUDE_PLUGIN_ROOT': str(root)}, 'nested'),
            ('cursor_precedence', {'CLAUDE_PLUGIN_ROOT': str(root), 'CURSOR_PLUGIN_ROOT': str(root)}, 'cursor'),
            ('copilot_override', {'CLAUDE_PLUGIN_ROOT': str(root), 'COPILOT_CLI': '1'}, 'sdk'),
            ('unknown_platform', {}, 'sdk'),
        ]
        for name, extra, shape in cases:
            skill.write_text(FIXTURE, encoding='utf-8')
            proc = subprocess.run([bash, str(hook)], env=base | extra, capture_output=True, text=True, timeout=10)
            assert proc.returncode == 0, (name, proc.stderr)
            payload = json.loads(proc.stdout)
            context = extract(payload, shape)
            assert FIXTURE.rstrip('\n') in context, (name, 'fixture fidelity failure')
            assert context.count(MARKER) == 1, (name, 'duplicate fixture')
            rows.append({'case': name, 'criterion': 'unique correct envelope and decoded fixture fidelity', 'result': 'PASS'})
        for name in ('missing_skill', 'empty_skill'):
            if name == 'missing_skill':
                skill.unlink()
            else:
                skill.write_bytes(b'')
            proc = subprocess.run([bash, str(hook)], env=base | {'CLAUDE_PLUGIN_ROOT': str(root)}, capture_output=True, text=True, timeout=10)
            payload = json.loads(proc.stdout)
            context = extract(payload, 'nested')
            # Study-defined readiness criterion, not an upstream requirement.
            health = proc.returncode != 0
            rows.append({'case': name, 'criterion': 'absent usable bootstrap must not signal successful exit', 'result': 'PASS' if health else 'FAIL', 'exit_code': proc.returncode, 'valid_nonempty_envelope': True, 'error_marker_present': 'Error reading using-superpowers skill' in context, 'fixture_marker_present': MARKER in context})
        # Negative control: this validator must reject a wrong event even though
        # the JSON is well formed and the context is nonempty.
        corrupt = {'hookSpecificOutput': {'hookEventName': 'WrongEvent', 'additionalContext': MARKER}}
        try:
            extract(corrupt, 'nested')
        except AssertionError:
            rows.append({'case': 'oracle_wrong_event', 'criterion': 'validator rejects syntactically valid wrong event', 'result': 'PASS'})
        else:
            raise AssertionError('Oracle did not reject wrong event')
    report = {'study_date': '2026-09-17', 'upstream_commit': PIN, 'upstream_hook_blob_sha1': digest, 'source_identity_verified': True, 'environment': {'os': platform.system(), 'python': platform.python_version(), 'bash': subprocess.run([bash, '--version'], capture_output=True, text=True, check=True).stdout.splitlines()[0]}, 'execution_scope': 'exact hook script in synthetic temporary filesystem; not actual harness startup; not upstream full test suite; not model obedience', 'cases': rows, 'summary': {'output_cases_passed': 4, 'bootstrap_health_challenges_failed': 2, 'oracle_negative_control_passed': 1}}
    print(json.dumps(report, ensure_ascii=False, indent=2))


if __name__ == '__main__':
    main()
