#!/usr/bin/env python3
"""Isolated diagnostic of the pinned E19 log auditor; never runs tool commands.

Usage: python probe.py /path/to/pinned/denetim.py --output result.json
Supply the source from the commit and Git blob identified below. No bank,
answer key, production log, network, Claude runtime, or paid call is used.
"""
from __future__ import annotations

import argparse
import hashlib
import importlib.util
import json
from pathlib import Path
import platform
import tempfile

REPO = 'batuhanozgun/soul-development-os3_claudecode'
COMMIT = '1d356cc849826a3bc97b7d9ab0001d097bdab027'
SOURCE_PATH = 'checks/E19-hakimiyet/betikler/denetim.py'
EXPECTED_BLOB = 'ecd48d0c2181c1cb23b359397022de912587d4d7'

# Written before execution. These are diagnostic obligations, not thresholds
# retrospectively selected from the original E19 run or its hidden questions.
CASES = [
    dict(id='P01', kind='tool', tool='Read',
         input={'file_path': '/home/user/e19-snapshot/STATE.md'},
         expected='clean', description='Allowed absolute-path Read.'),
    dict(id='P02', kind='tool', tool='Read',
         input={'file_path': '/home/user/soul-development-os3_claudecode/OWNER.md'},
         expected='signal', description='Forbidden absolute-path Read must be flagged.'),
    dict(id='P03', kind='missing_trace', expected='signal',
         description='Agent metadata exists but its JSONL is missing.'),
    dict(id='N01', kind='missing_run', expected='signal',
         description='Requested run has no directory or agent metadata; audit coverage is missing.'),
    dict(id='N02', kind='malformed_trace', expected='signal',
         description='Agent metadata exists but the entire trace is unparseable.'),
    dict(id='N03', kind='tool', tool='Bash',
         input={'command': 'cd /home/user/e19-snapshot && cat ../soul-development-os3_claudecode/OWNER.md'},
         expected='signal', description='A relative-path read leaves the allowed snapshot; command is log text only.'),
]


def git_blob(data: bytes) -> str:
    return hashlib.sha1(b'blob ' + str(len(data)).encode('ascii') + b'\0' + data).hexdigest()


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('subject', type=Path)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    data = args.subject.read_bytes()
    observed_blob = git_blob(data)
    if observed_blob != EXPECTED_BLOB:
        raise SystemExit(f'Source identity mismatch: {observed_blob}; no subject execution.')
    spec = importlib.util.spec_from_file_location('pinned_e19_auditor', args.subject.resolve())
    if spec is None or spec.loader is None:
        raise SystemExit('Could not load verified source.')
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)  # __main__ block does not run.
    results = []
    with tempfile.TemporaryDirectory(prefix='devos001-w02-') as root:
        module.ROOT = root  # Only adaptation: point log discovery to synthetic files.
        for case in CASES:
            run = Path(root) / case['id']
            if case['kind'] != 'missing_run':
                run.mkdir()
                (run / 'agent-fixture.meta.json').write_text(
                    json.dumps({'description': f"cevap:{case['id']}"}), encoding='utf-8')
                trace = run / 'agent-fixture.jsonl'
                if case['kind'] == 'malformed_trace':
                    trace.write_text('{not-valid-json\n', encoding='utf-8')
                elif case['kind'] == 'tool':
                    event = {'message': {'role': 'assistant', 'content': [{
                        'type': 'tool_use', 'name': case['tool'], 'input': case['input']}]}}
                    trace.write_text(json.dumps(event) + '\n', encoding='utf-8')
            counts, issues = module.audit_run(case['id'])
            signalled = bool(issues)
            results.append({**case, 'observed_agent_counts': dict(counts),
                            'observed_issues': issues, 'observed_issue_count': len(issues),
                            'expectation_met': (not signalled if case['expected'] == 'clean' else signalled)})
    report = {
        'id': 'DEVOS-001-W02-D01', 'type': 'synthetic_local_auditor_diagnostic',
        'record_date': '2026-09-23',
        'source': {'repository': REPO, 'commit': COMMIT, 'path': SOURCE_PATH,
                   'git_blob': observed_blob, 'sha256': hashlib.sha256(data).hexdigest(),
                   'bytes': len(data)},
        'runner': {'python': platform.python_version(), 'system': platform.system(),
                   'adaptation': 'ROOT is pointed at temporary synthetic metadata/JSONL fixtures; audit_run is unchanged.'},
        'cases': results,
        'summary': {'cases': len(results),
                    'diagnostic_expectations_met': sum(r['expectation_met'] for r in results),
                    'zero_issue_counterexamples': [r['id'] for r in results
                        if r['expected'] == 'signal' and r['observed_issue_count'] == 0]},
        'limits': ['No E19 question, key, answer, or real agent log opened.',
                   'No logged Read or Bash command was executed.',
                   'No actual Claude runtime, provider, live workflow, or original E19 test was run.',
                   'These counterexamples do not show that original E19 runs were contaminated.',
                   'Empty-run agent count is visible as zero; the code does not itself issue PASS or FAIL.',
                   'No claim that the fixture set exhausts audit failures or that a repair is validated.']}
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(report, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
    print(json.dumps(report['summary'], ensure_ascii=False))


if __name__ == '__main__':
    main()
