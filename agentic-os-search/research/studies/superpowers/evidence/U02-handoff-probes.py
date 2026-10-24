#!/usr/bin/env python3
"""Source-informed U02 probes. Not an agent, approval, or live-harness evaluation.
Usage: python3 U02-handoff-probes.py /path/to/pinned/SDD/scripts
Only local temporary repositories are changed; no network, install, or credentials.
A health FAIL remains a failed criterion. Exit 0 means collection completed.
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
EXPECTED = {
    'sdd-workspace': '4e2d16802ecaa23eb9a682663e4c356c4aa5a656',
    'task-brief': '612e14a1ee7ca9c0078d896325935759a1827c24',
}
# Exact command from using-git-worktrees/SKILL.md, not the entire skill.
IGNORE_CHECK = 'git check-ignore -q .worktrees 2>/dev/null || git check-ignore -q worktrees 2>/dev/null'
WORKTREE_SKILL_BLOB = '1381dacb3516b94382dd6ec736ede21ee8ede2b3'


def git_blob(data: bytes) -> str:
    return hashlib.sha1(b'blob ' + str(len(data)).encode() + b'\0' + data).hexdigest()


def plan(label: str) -> str:
    return f'''# {label} Plan

**Spec:** docs/spec.md

## Global Constraints

GLOBAL_SENTINEL: never change the shared configuration.

### Task 1: Main deliverable

TASK_SENTINEL_{label}

```text
## Task 99: This is fenced example text, not another task
```

### Task 2: Other deliverable

OTHER_TASK_SENTINEL
'''


def main() -> None:
    if len(sys.argv) != 2:
        raise SystemExit('Usage: python3 U02-handoff-probes.py PINNED_SDD_SCRIPTS')
    src = Path(sys.argv[1]).resolve()
    verified = {}
    for name, expected in EXPECTED.items():
        data = (src / name).read_bytes()
        actual = git_blob(data)
        if actual != expected:
            raise SystemExit(f'Source identity mismatch: {name}: {actual}')
        verified[name] = {'blob': actual, 'bytes': len(data)}
    cases = []
    with tempfile.TemporaryDirectory(prefix='superpowers-u02-') as td:
        base = Path(td)
        home = base / 'home'
        home.mkdir()
        env = {
            'PATH': os.environ.get('PATH', '/usr/bin:/bin'),
            'HOME': str(home), 'TMPDIR': str(base), 'LC_ALL': 'C.UTF-8',
            'GIT_CONFIG_NOSYSTEM': '1', 'GIT_CONFIG_GLOBAL': '/dev/null',
            'GIT_TERMINAL_PROMPT': '0',
            'GIT_AUTHOR_NAME': 'Synthetic U02', 'GIT_AUTHOR_EMAIL': 'u02@example.invalid',
            'GIT_COMMITTER_NAME': 'Synthetic U02', 'GIT_COMMITTER_EMAIL': 'u02@example.invalid',
            'GIT_AUTHOR_DATE': '2026-09-17T00:00:00Z',
            'GIT_COMMITTER_DATE': '2026-09-17T00:00:00Z',
        }

        def run(args: list[str], cwd: Path, check: bool = True) -> subprocess.CompletedProcess[str]:
            p = subprocess.run(args, cwd=cwd, env=env, text=True, capture_output=True, timeout=15)
            if check and p.returncode:
                raise RuntimeError(f'{args}: exit {p.returncode}: {p.stderr}')
            return p

        def record(case: str, kind: str, criterion: str, passed: bool, observed: dict) -> None:
            cases.append({'id': case, 'kind': kind, 'criterion': criterion,
                          'result': 'PASS' if passed else 'FAIL', 'observed': observed})

        def put(repo: Path, relative: str, text: str) -> Path:
            p = repo / relative
            p.parent.mkdir(parents=True, exist_ok=True)
            p.write_text(text, encoding='utf-8')
            return p

        repo = base / 'repo'
        repo.mkdir()
        run(['git', 'init', '-q', '-b', 'main'], repo)
        put(repo, 'docs/spec.md', '# Synthetic specification\n')
        run(['git', 'add', 'docs/spec.md'], repo)
        run(['git', '-c', 'commit.gpgsign=false', 'commit', '-qm', 'synthetic baseline'], repo)

        def workspace(relative: str, cwd: Path = repo) -> Path:
            return Path(run(['bash', str(src / 'sdd-workspace'), relative], cwd).stdout.strip())

        def brief(relative: str, n: str = '1', cwd: Path = repo, check: bool = True):
            return run(['bash', str(src / 'task-brief'), relative, n], cwd, check)

        missing = run(['bash', str(src / 'sdd-workspace'), 'missing.md'], repo, False)
        record('missing_plan', 'mechanism', 'Missing plan is rejected with exit 2',
               missing.returncode == 2, {'exit': missing.returncode})
        put(repo, 'plans/alpha.md', plan('ALPHA'))
        put(repo, 'plans/beta.md', plan('BETA'))
        alpha, beta = workspace('plans/alpha.md'), workspace('plans/beta.md')
        record('distinct_basenames', 'mechanism', 'Distinct basenames receive distinct directories',
               alpha != beta, {'distinct': alpha != beta})
        (alpha / 'artifact.md').write_text('scratch\n')
        ignored = run(['git', 'check-ignore', '-q', str(alpha / 'artifact.md')], repo, False)
        record('scratch_ignored', 'mechanism', 'Generated scratch artifact is ignored by Git',
               ignored.returncode == 0, {'ignored': ignored.returncode == 0})

        brief('plans/alpha.md')
        text = (alpha / 'task-1-brief.md').read_text()
        good = 'TASK_SENTINEL_ALPHA' in text and 'OTHER_TASK_SENTINEL' not in text
        record('task_extraction', 'mechanism', 'Requested task retained, adjacent task excluded, fenced heading retained',
               good and 'fenced example text' in text,
               {'task_present': 'TASK_SENTINEL_ALPHA' in text, 'adjacent_present': 'OTHER_TASK_SENTINEL' in text,
                'fenced_heading_present': 'fenced example text' in text})
        record('header_and_globals_not_in_brief', 'representation-observation',
               'Record that task-only extraction omits plan-level Spec and Global Constraints; not an efficacy pass',
               '**Spec:**' not in text and 'GLOBAL_SENTINEL' not in text,
               {'spec_pointer_present': '**Spec:**' in text, 'global_constraint_present': 'GLOBAL_SENTINEL' in text})
        missing_task = brief('plans/alpha.md', '404', check=False)
        record('missing_task', 'mechanism', 'Missing task heading is rejected with exit 3',
               missing_task.returncode == 3, {'exit': missing_task.returncode})

        put(repo, 'team-a/shared.md', plan('TEAM_A'))
        put(repo, 'team-b/shared.md', plan('TEAM_B'))
        a, b = workspace('team-a/shared.md'), workspace('team-b/shared.md')
        brief('team-a/shared.md')
        first = (a / 'task-1-brief.md').read_text()
        brief('team-b/shared.md')
        after = (a / 'task-1-brief.md').read_text()
        record('same_basename_different_paths', 'health-challenge',
               'Different plan paths in one worktree must not alias and overwrite each other under a per-plan isolation claim',
               a != b and first == after,
               {'same_workspace': a == b, 'first_brief_had_A': 'TASK_SENTINEL_TEAM_A' in first,
                'after_has_A': 'TASK_SENTINEL_TEAM_A' in after, 'after_has_B': 'TASK_SENTINEL_TEAM_B' in after})

        ledger = alpha / 'progress.md'
        ledger.write_text('# SDD ledger — plan: plans/alpha.md\nTask 1: complete (synthetic record, no real implementation)\n')
        old_ledger = ledger.read_bytes()
        put(repo, 'plans/alpha.md', plan('ALPHA_REVISED'))
        again = workspace('plans/alpha.md')
        brief('plans/alpha.md')
        revised = (again / 'task-1-brief.md').read_text()
        record('plan_revision_retains_ledger', 'identity-observation',
               'Record helper behavior after same-path plan revision; no simulated controller or completion verdict',
               again == alpha and ledger.read_bytes() == old_ledger and 'ALPHA_REVISED' in revised,
               {'same_workspace': again == alpha, 'completion_marker_preserved': ledger.read_bytes() == old_ledger,
                'brief_uses_revised_task': 'ALPHA_REVISED' in revised})

        relative = 'docs/uncommitted-plan.md'
        put(repo, relative, plan('UNCOMMITTED'))
        wt = base / 'linked-before-commit'
        run(['git', 'worktree', 'add', '-q', '--detach', str(wt), 'HEAD'], repo)
        absent = run(['bash', str(src / 'sdd-workspace'), relative], wt, False)
        record('saved_plan_not_in_new_worktree', 'handoff-observation',
               'A plan saved but not committed is absent from a new HEAD worktree and is rejected by the helper',
               not (wt / relative).exists() and absent.returncode == 2,
               {'plan_present': (wt / relative).exists(), 'helper_exit': absent.returncode})
        run(['git', 'add', relative], repo)
        run(['git', '-c', 'commit.gpgsign=false', 'commit', '-qm', 'commit synthetic plan'], repo)
        wt2 = base / 'linked-after-commit'
        run(['git', 'worktree', 'add', '-q', '--detach', str(wt2), 'HEAD'], repo)
        ws2 = workspace(relative, wt2)
        record('committed_plan_worktree_control', 'mechanism',
               'Committed plan is present in new worktree; scratch is worktree-local',
               (wt2 / relative).exists() and str(ws2).startswith(str(wt2) + '/'),
               {'plan_present': (wt2 / relative).exists(), 'scratch_local_to_worktree': str(ws2).startswith(str(wt2) + '/')})

        ir = base / 'ignore-repo'
        ir.mkdir()
        run(['git', 'init', '-q', '-b', 'main'], ir)
        (ir / '.worktrees').mkdir()
        (ir / 'worktrees').mkdir()
        for name, rules in [('both', '.worktrees/\nworktrees/\n'), ('neither', ''), ('other_only', 'worktrees/\n')]:
            put(ir, '.gitignore', rules)
            predicate = run(['bash', '-c', IGNORE_CHECK], ir, False).returncode == 0
            selected = run(['git', 'check-ignore', '-q', '.worktrees'], ir, False).returncode == 0
            record('ignore_check_' + name, 'health-challenge' if name == 'other_only' else 'mechanism',
                   'Documented predicate must agree with ignore status of selected .worktrees directory (both directories exist)',
                   predicate == selected,
                   {'snippet_accepts': predicate, 'selected_directory_ignored': selected})

        env_info = {'os': platform.system(), 'python': platform.python_version(),
                    'git': run(['git', '--version'], repo).stdout.strip(),
                    'bash': run(['bash', '--version'], repo).stdout.splitlines()[0]}
    result = {
        'study_date': '2026-09-17', 'upstream_commit': PIN, 'source_identities': verified,
        'documented_snippet': {'source_blob': WORKTREE_SKILL_BLOB, 'text': IGNORE_CHECK},
        'environment': env_info,
        'scope': 'Exact sdd-workspace/task-brief helpers plus one literal documented ignore command, in synthetic local repositories. No live agent/host, approval simulation, network, install, credentials or upstream suite.',
        'criteria': 'Source-informed exploratory; criteria fixed in runner before execution. Descriptive PASS confirms the named observation, not safety or effectiveness. Health FAILs remain failures.',
        'cases': cases,
        'summary': {'total': len(cases), 'passed': sum(c['result'] == 'PASS' for c in cases),
                    'health_failures': sum(c['result'] == 'FAIL' and c['kind'] == 'health-challenge' for c in cases),
                    'other_failures': sum(c['result'] == 'FAIL' and c['kind'] != 'health-challenge' for c in cases)}
    }
    print(json.dumps(result, ensure_ascii=False, indent=2))


if __name__ == '__main__':
    main()
