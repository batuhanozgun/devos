#!/usr/bin/env python3
"""Exercise an exact pinned version helper on disposable JSON-only fixtures.

Usage: python3 U07B-version-probes.py /path/to/bump-version.sh output.json
No network, installations, live agent, real checkout or upstream suite is used.
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
BLOB = '14ead00291407c584f58a437f3acf5be1e772e78'

def blob_hash(data: bytes) -> str:
    return hashlib.sha1(f'blob {len(data)}\0'.encode() + data).hexdigest()

def main(source: pathlib.Path, output: pathlib.Path) -> None:
    data = source.read_bytes()
    if blob_hash(data) != BLOB:
        raise ValueError('Source identity mismatch; refusing execution')
    for tool in ('bash', 'jq', 'grep', 'sed', 'sort', 'uniq', 'wc', 'awk'):
        if not shutil.which(tool):
            raise RuntimeError(f'Required existing tool absent: {tool}')
    results: list[dict] = []
    with tempfile.TemporaryDirectory(prefix='superpowers-u07b-') as directory:
        root = pathlib.Path(directory)
        home = root / 'home'
        home.mkdir()
        env = {'PATH': os.environ['PATH'], 'HOME': str(home), 'LC_ALL': 'C.UTF-8',
               'GIT_CONFIG_NOSYSTEM': '1', 'GIT_CONFIG_GLOBAL': '/dev/null'}
        def fixture(name: str, versions: list[str | None]) -> tuple[pathlib.Path, list[str]]:
            repo = root / name
            (repo / 'scripts').mkdir(parents=True)
            (repo / 'scripts/bump-version.sh').write_bytes(data)
            paths = [f'manifest-{i}.json' for i in range(len(versions))]
            config = {'files': [{'path': p, 'field': 'version'} for p in paths],
                      'audit': {'exclude': ['.version-bump.json', 'bump-version.sh']}}
            (repo / '.version-bump.json').write_text(json.dumps(config) + '\n')
            for p, v in zip(paths, versions):
                if v is not None:
                    (repo / p).write_text(json.dumps({'version': v}) + '\n')
            return repo, paths
        def run(repo: pathlib.Path, arg: str) -> dict:
            p = subprocess.run(['bash', str(repo / 'scripts/bump-version.sh'), arg],
                               env=env, cwd=repo, capture_output=True, text=True, timeout=12)
            return {'argument': arg, 'exit': p.returncode,
                    'stdout': p.stdout.replace(str(root), '<TMP>'),
                    'stderr': p.stderr.replace(str(root), '<TMP>')}
        def versions(repo: pathlib.Path, paths: list[str]) -> dict:
            return {p: json.loads((repo / p).read_text()).get('version') if (repo / p).exists() else None
                    for p in paths}
        # Source-informed observation expectations fixed before these invocations.
        repo, paths = fixture('normal', ['1.0.0', '1.0.0'])
        before = run(repo, '--check'); bump = run(repo, '1.1.0'); after = run(repo, '--check')
        assert before['exit'] == bump['exit'] == after['exit'] == 0
        assert all(v == '1.1.0' for v in versions(repo, paths).values())
        results.append({'id': 'C01', 'kind': 'positive_control', 'name': 'Complete JSON update',
                        'runs': [before, bump, after], 'files': versions(repo, paths)})

        repo, paths = fixture('drift', ['2.0.0', '2.0.0', '1.0.0'])
        check = run(repo, '--check'); audit = run(repo, '--audit')
        assert check['exit'] == 1 and audit['exit'] == 0
        assert 'DRIFT DETECTED' in check['stdout'] and 'DRIFT DETECTED' in audit['stdout']
        assert versions(repo, paths)[paths[2]] == '1.0.0'
        results.append({'id': 'C02', 'kind': 'mode_boundary', 'name': 'Audit does not preserve check failure',
                        'runs': [check, audit], 'files': versions(repo, paths),
                        'limit': 'Audit prints drift; its zero exit is not a clean version gate.'})

        repo, paths = fixture('missing-middle', ['1.0.0', None, '1.0.0'])
        bump = run(repo, '1.1.0'); check = run(repo, '--check')
        assert bump['exit'] == 0 and check['exit'] == 1
        assert 'SKIP (missing)' in bump['stdout'] and 'MISSING' in bump['stdout']
        assert versions(repo, paths) == {paths[0]: '1.1.0', paths[1]: None, paths[2]: '1.1.0'}
        results.append({'id': 'C03', 'kind': 'scope_challenge', 'name': 'Successful bump with missing declared middle file',
                        'runs': [bump, check], 'files': versions(repo, paths),
                        'criterion': 'A zero bump exit entails every declared manifest exists at the requested version.',
                        'criterion_met': False,
                        'limit': 'Missing path is printed; no claim that the full transcript conceals it.'})

        repo, paths = fixture('missing-last', ['1.0.0', '1.0.0', None])
        bump = run(repo, '1.1.0'); check = run(repo, '--check')
        assert bump['exit'] != 0 and check['exit'] == 1
        assert versions(repo, paths) == {paths[0]: '1.1.0', paths[1]: '1.1.0', paths[2]: None}
        results.append({'id': 'C04', 'kind': 'ordering_and_partial_effect', 'name': 'Missing final path fails after writes',
                        'runs': [bump, check], 'files': versions(repo, paths),
                        'limit': 'Bash loop/pipeline status differs when missing entry is last; a nonzero result is not rollback.'})

        repo, paths = fixture('malformed', ['1.0.0', '1.0.0'])
        (repo / paths[1]).write_text('{bad json\n')
        original = (repo / paths[0]).read_bytes()
        bump = run(repo, '1.1.0')
        assert bump['exit'] != 0 and (repo / paths[0]).read_bytes() == original
        assert 'cannot read declared manifest' in bump['stderr']
        results.append({'id': 'C05', 'kind': 'negative_control', 'name': 'Unreadable manifest blocks before prior file update',
                        'runs': [bump], 'first_file_unchanged': True})

        repo, paths = fixture('undeclared-old', ['1.0.0', '1.0.0'])
        extra = repo / 'unregistered-manifest.json'
        extra.write_text(json.dumps({'version': '1.0.0'}) + '\n')
        bump = run(repo, '1.1.0')
        assert bump['exit'] == 0 and 'All clear.' in bump['stdout']
        assert 'UNDECLARED files' not in bump['stdout']
        assert json.loads(extra.read_text())['version'] == '1.0.0'
        results.append({'id': 'C06', 'kind': 'scope_challenge', 'name': 'Post-bump audit misses undeclared old-version file',
                        'runs': [bump], 'extra_file_version': '1.0.0',
                        'criterion': 'The post-bump all-clear establishes no unregistered old-version manifest remains.',
                        'criterion_met': False,
                        'limit': 'Literal scan searches the now-current version; it is not a general manifest inventory.'})

        repo, paths = fixture('undeclared-current', ['1.0.0', '1.0.0'])
        (repo / 'unregistered-manifest.json').write_text('{"version":"1.0.0"}\n')
        audit = run(repo, '--audit')
        assert audit['exit'] == 0 and 'UNDECLARED files' in audit['stdout']
        results.append({'id': 'C07', 'kind': 'positive_sensitivity_control',
                        'name': 'Same-version undeclared file is reported, still advisory', 'runs': [audit]})
        # Independent fixture inventory contradicts the deliberately overstrong zero-exit oracle.
        c3 = results[2]
        strong = c3['runs'][0]['exit'] == 0
        inventory_complete = all(v == '1.1.0' for v in c3['files'].values())
        assert strong and not inventory_complete
        results.append({'id': 'C08', 'kind': 'oracle_negative_control',
                        'name': 'Zero-exit-only completeness oracle is falsified',
                        'incorrect_oracle_rejected': True})
    report = {'experiment': 'U07B / E15 runner / E16 output', 'source_commit': PIN,
              'source': {'path': 'scripts/bump-version.sh', 'git_blob': BLOB, 'bytes': len(data)},
              'evidence_class': 'source-informed exploratory exact-helper execution',
              'environment': {'python': platform.python_version(), 'platform': platform.system(),
                              'bash': subprocess.check_output(['bash','--version'], text=True).splitlines()[0],
                              'jq': subprocess.check_output(['jq','--version'], text=True).strip()},
              'limitations': ['JSON-only synthetic config; production nine-manifest/YAML path not run',
                              'No release, packaging/sync, host/model, installation, network or upstream suite',
                              'Criteria fixed after source reading, before this execution; not independent replication',
                              'Earlier E01-E14 unchanged and not rerun'],
              'counts': {'cases': len(results), 'unexpected_observation_failures': 0,
                         'unmet_explicit_stronger_criteria': sum(r.get('criterion_met') is False for r in results)},
              'cases': results}
    output.parent.mkdir(parents=True, exist_ok=True)
    output.write_text(json.dumps(report, indent=2, ensure_ascii=False) + '\n')
    print(json.dumps(report['counts']))

if __name__ == '__main__':
    if len(sys.argv) != 3:
        raise SystemExit('Usage: U07B-version-probes.py PINNED_BUMP_SCRIPT OUTPUT_JSON')
    main(pathlib.Path(sys.argv[1]), pathlib.Path(sys.argv[2]))
