#!/usr/bin/env python3
"""U03 source-informed probes, not a live reviewer/model evaluation.
Usage: python3 U03-review-probes.py /path/to/pinned/review-package
Only temporary local Git repositories are mutated. No credentials/network.
The helper uses explicit OUTFILE; default workspace naming is not retested.
Two literal test-7 predicate probes use synthetic replies, not model output.
Descriptive PASS confirms an observation. Oracle-health FAIL remains FAIL.
"""
from __future__ import annotations
import hashlib
import json
import os
from pathlib import Path
import platform
import subprocess
import sys
import tempfile

PIN = 'b36e0829c6d0140e93cfef2ca599b1b07d4a7797'
BLOB = '31852e2abbeb9a41084f67a9f2ef3cfc3378bce9'
PREDICATE = r'provide.*directly\|full.*text\|paste\|include.*prompt'


def main() -> None:
    if len(sys.argv) != 2:
        raise SystemExit('Usage: U03-review-probes.py REVIEW_PACKAGE')
    helper = Path(sys.argv[1]).resolve()
    data = helper.read_bytes()
    identity = hashlib.sha1(b'blob ' + str(len(data)).encode() + b'\0' + data).hexdigest()
    if identity != BLOB:
        raise SystemExit(f'Source identity mismatch: {identity}')
    cases: list[dict] = []

    def record(name: str, kind: str, criterion: str, ok: bool, observed: dict) -> None:
        cases.append(dict(id=name, kind=kind, criterion=criterion,
                          result='PASS' if ok else 'FAIL', observed=observed))

    with tempfile.TemporaryDirectory(prefix='superpowers-u03-') as tmp:
        root = Path(tmp)
        repo = root / 'repo'
        repo.mkdir()
        home = root / 'home'
        home.mkdir()
        env = dict(PATH=os.environ.get('PATH', '/usr/bin:/bin'), HOME=str(home),
                   LC_ALL='C', GIT_CONFIG_NOSYSTEM='1', GIT_CONFIG_GLOBAL='/dev/null',
                   GIT_AUTHOR_NAME='U03 Fixture', GIT_AUTHOR_EMAIL='fixture@example.invalid',
                   GIT_COMMITTER_NAME='U03 Fixture', GIT_COMMITTER_EMAIL='fixture@example.invalid',
                   GIT_AUTHOR_DATE='2026-09-17T00:00:00Z', GIT_COMMITTER_DATE='2026-09-17T00:00:00Z',
                   GIT_TERMINAL_PROMPT='0')

        def run(args: list[str], check: bool = True, stdin: str | None = None):
            p = subprocess.run(args, cwd=repo, env=env, input=stdin, text=True,
                               capture_output=True, timeout=15)
            if check and p.returncode != 0:
                raise RuntimeError(f'{args}: {p.returncode}\n{p.stderr}')
            return p

        def git(*args: str) -> str:
            return run(['git', '-c', 'commit.gpgsign=false', *args]).stdout.strip()

        def commit(subject: str) -> str:
            git('add', '-A')
            git('commit', '-qm', subject)
            return git('rev-parse', 'HEAD')

        def package(name: str, base: str, head: str, plan: str = 'plan.md'):
            out = root / f'{name}.diff'
            p = run(['bash', str(helper), plan, base, head, str(out)], check=False)
            return p, out.read_text() if out.exists() else ''

        def has_changes(text: str, names: tuple[str, ...]) -> bool:
            return all(f'diff --git a/{name} b/{name}' in text for name in names)

        git('init', '-q', '-b', 'main')
        git('config', 'core.hooksPath', str(root / 'no-hooks'))
        (repo / 'plan.md').write_text('# Synthetic plan\n\n## Task 1: two independent file changes\n')
        base = commit('fixture base')
        (repo / 'a.txt').write_text('FIRST_COMMIT_CONTENT\n')
        c1 = commit('first implementation commit')
        (repo / 'b.txt').write_text('SECOND_COMMIT_CONTENT\n')
        c2 = commit('second implementation commit')

        p, text = package('missing-plan', base, c2, 'absent.md')
        record('missing_plan', 'mechanism', 'Reject missing plan before producing a package',
               p.returncode == 2 and not text, dict(exit=p.returncode, output_exists=bool(text)))
        p, text = package('bad-base', 'not-a-ref', c2)
        record('bad_base', 'mechanism', 'Reject unresolved BASE before producing a package',
               p.returncode == 2 and not text, dict(exit=p.returncode, output_exists=bool(text)))

        p, full = package('full', base, c2)
        both = has_changes(full, ('a.txt', 'b.txt'))
        record('full_multicommit_range', 'mechanism', 'Recorded BASE retains both commits and both changed files',
               p.returncode == 0 and both and '2 commit(s)' in p.stdout,
               dict(exit=p.returncode, both_files=both, reports_two_commits='2 commit(s)' in p.stdout))

        p, narrow = package('narrow', c1, c2)
        record('narrow_range_is_accepted', 'scope-observation',
               'A valid but shortened BASE omits the first commit; helper does not infer task admission',
               p.returncode == 0 and has_changes(narrow, ('b.txt',)) and not has_changes(narrow, ('a.txt',)),
               dict(exit=p.returncode, first_file_present=has_changes(narrow, ('a.txt',)),
                    second_file_present=has_changes(narrow, ('b.txt',))))
        record('coverage_oracle_rejects_narrow', 'negative-control',
               'Fixture file-coverage oracle rejects omission of a known task file',
               not has_changes(narrow, ('a.txt', 'b.txt')),
               dict(accepts_incomplete_packet=has_changes(narrow, ('a.txt', 'b.txt'))))

        (repo / 'b.txt').write_text('SECOND_COMMIT_CONTENT_FIXED\n')
        c3 = commit('scoped fix')
        p, fix = package('fix', c2, c3)
        record('scoped_fix_range', 'mechanism', 'Previous reviewed HEAD bounds the fix-only packet',
               p.returncode == 0 and has_changes(fix, ('b.txt',)) and not has_changes(fix, ('a.txt',)),
               dict(exit=p.returncode, fix_file_present=has_changes(fix, ('b.txt',)),
                    earlier_file_present=has_changes(fix, ('a.txt',))))

        (repo / 'a.txt').write_text('UNCOMMITTED_WORKTREE_CONTENT\n')
        (repo / 'staged.txt').write_text('STAGED_ONLY_CONTENT\n')
        git('add', 'staged.txt')
        (repo / 'untracked.txt').write_text('UNTRACKED_ONLY_CONTENT\n')
        status_before = git('status', '--porcelain')
        p, after_dirty = package('after-dirty', base, c2)
        status_after = git('status', '--porcelain')
        record('committed_packet_not_working_state', 'scope-observation',
               'Same explicit commit endpoints give identical packet despite dirty/staged/untracked state; helper preserves that state',
               p.returncode == 0 and after_dirty == full and status_before == status_after,
               dict(packet_unchanged=after_dirty == full, checkout_preserved=status_before == status_after,
                    dirty_state_present=bool(status_after)))

        # These are the two allowed answer shapes for test 7, constructed by
        # the study; they are NOT outputs from Claude or any other model.
        current_reply = 'Controller provides: by file\nImplementer must read plan file: no\n'
        obsolete_reply = 'Controller provides: directly; paste the task into the prompt\nImplementer must read plan file: no\n'
        current_ok = run(['grep', '-qi', PREDICATE], check=False, stdin=current_reply).returncode == 0
        obsolete_ok = run(['grep', '-qi', PREDICATE], check=False, stdin=obsolete_reply).returncode == 0
        record('predicate_accepts_current_file_handoff', 'oracle-health-challenge',
               'Test-7 predicate should accept the current file-based handoff answer', current_ok,
               dict(synthetic_reply=current_reply, accepted=current_ok))
        record('predicate_rejects_obsolete_paste_handoff', 'oracle-health-challenge',
               'Test-7 predicate should reject the obsolete direct-paste handoff answer', not obsolete_ok,
               dict(synthetic_reply=obsolete_reply, accepted=obsolete_ok))
        result = dict(study_date='2026-09-17', upstream_commit=PIN,
                      source_identity=dict(path='skills/subagent-driven-development/scripts/review-package',
                                           blob=identity, bytes=len(data), verified=True),
                      predicate_source=dict(test_blob='151fc64d04668567c4980301dc28f323bd5424b5',
                                            helper_blob='9e187610d6a973c6db0aed91dfb8deadfcac3e78',
                                            literal=PREDICATE, scope='literal grep predicate only; no upstream suite/model call'),
                      environment=dict(os=platform.system(), python=platform.python_version(),
                                       git=git('--version'), bash=run(['bash', '--version']).stdout.splitlines()[0]),
                      scope='Exact review-package explicit-OUTFILE execution in synthetic Git repository; constructed verbal-oracle counterexamples. No reviewer/model, installation, network, or credentials.',
                      criteria='Source-informed exploratory; criteria fixed before this run. Descriptive PASS is not task acceptance or product efficacy.',
                      cases=cases,
                      summary=dict(total=len(cases), passed=sum(c['result'] == 'PASS' for c in cases),
                                   oracle_health_failures=sum(c['result'] == 'FAIL' and c['kind'] == 'oracle-health-challenge' for c in cases),
                                   other_failures=sum(c['result'] == 'FAIL' and c['kind'] != 'oracle-health-challenge' for c in cases)))
        print(json.dumps(result, ensure_ascii=False, indent=2))


if __name__ == '__main__':
    main()
