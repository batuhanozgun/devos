"""E07: source-derived SQL/Git semantics; NOT an ECC Rust integration run."""
import hashlib
import json
import os
import pathlib
import platform
import sqlite3
import subprocess
import tempfile

ROOT = pathlib.Path(__file__).resolve().parent
OUT = ROOT / 'RESULTS.json'
INSERT = 'INSERT INTO session_output (session_id, stream, line, timestamp) VALUES (?1, ?2, ?3, ?4)'
PRUNE = '''DELETE FROM session_output WHERE session_id = ?1 AND id NOT IN (
SELECT id FROM session_output WHERE session_id = ?1 ORDER BY id DESC LIMIT ?2)'''
TOUCH = 'UPDATE sessions SET updated_at = ?1, last_heartbeat_at = ?1 WHERE id = ?2'
READ = '''SELECT stream, line, timestamp FROM (SELECT id, stream, line, timestamp
FROM session_output WHERE session_id = ?1 ORDER BY id DESC LIMIT ?2) ORDER BY id ASC'''
STATE_WRITE = 'UPDATE sessions SET state = ?1, updated_at = ?2, last_heartbeat_at = ?2 WHERE id = ?3'
SCHEMA = '''PRAGMA foreign_keys=ON;
CREATE TABLE sessions (id TEXT PRIMARY KEY, state TEXT NOT NULL, updated_at TEXT NOT NULL, last_heartbeat_at TEXT NOT NULL);
CREATE TABLE session_output (id INTEGER PRIMARY KEY AUTOINCREMENT, session_id TEXT NOT NULL REFERENCES sessions(id), stream TEXT NOT NULL, line TEXT NOT NULL, timestamp TEXT NOT NULL);
INSERT INTO sessions VALUES ('s', 'pending', 't0', 't0');'''


def connect(path):
    db = sqlite3.connect(path, isolation_level=None)
    db.execute('PRAGMA foreign_keys=ON')
    return db


def initialize(path):
    db = connect(path)
    db.executescript(SCHEMA)
    return db


def append(db, label, limit=1000):
    db.execute(INSERT, ('s', 'stdout', label, label))
    db.execute(PRUNE, ('s', limit))
    db.execute(TOUCH, (label, 's'))


def main():
    report = {'experiment': 'E07', 'plan_commit': 'b61879501ed5124acf4487b27c6a1916773b858b',
              'scope': 'source-derived SQL/Git fixture; no ECC Rust, model or live host',
              'python': platform.python_version(), 'sqlite': sqlite3.sqlite_version,
              'platform': platform.system(), 'cases': {}, 'commands': []}
    with tempfile.TemporaryDirectory(prefix='E07-', dir=ROOT) as temporary:
        root = pathlib.Path(temporary)
        p = root / 'retention.db'
        db = initialize(p)
        for i in range(1, 1003):
            append(db, f'line-{i:04d}')
        db.close()
        db = connect(p)
        labels = [row[1] for row in db.execute(READ, ('s', 1000)).fetchall()]
        db.close()
        report['cases']['C01'] = {'count': len(labels), 'first': labels[0], 'last': labels[-1],
                                 'match': labels == [f'line-{i:04d}' for i in range(3, 1003)]}
        faults = {}
        for explicit in (False, True):
            p = root / f'fault-{explicit}.db'
            db = initialize(p)
            append(db, 'seed')
            db.execute("CREATE TRIGGER injected_prune_fault BEFORE DELETE ON session_output BEGIN SELECT RAISE(ABORT, 'E07 injected prune failure'); END")
            error = None
            if explicit:
                db.execute('BEGIN')
            try:
                append(db, 'new', limit=1)
            except sqlite3.DatabaseError as exc:
                error = str(exc)
                if explicit:
                    db.execute('ROLLBACK')
            db.close()
            db = connect(p)
            rows = [row[0] for row in db.execute('SELECT line FROM session_output ORDER BY id')]
            db.close()
            faults['transaction' if explicit else 'autocommit'] = {'error': error, 'rows_after_reopen': rows}
        report['cases']['C02'] = faults
        p = root / 'interleave.db'
        a = initialize(p)
        b = connect(p)
        admitted = a.execute("SELECT state FROM sessions WHERE id='s'").fetchone()[0]
        b.execute(STATE_WRITE, ('stopped', 't1', 's'))
        count = a.execute(STATE_WRITE, ('running', 't2', 's')).rowcount
        unguarded = b.execute("SELECT state FROM sessions WHERE id='s'").fetchone()[0]
        a.execute(STATE_WRITE, ('pending', 't3', 's'))
        admitted_control = a.execute("SELECT state FROM sessions WHERE id='s'").fetchone()[0]
        b.execute(STATE_WRITE, ('stopped', 't4', 's'))
        control_count = a.execute(STATE_WRITE + ' AND state = ?4', ('running', 't5', 's', admitted_control)).rowcount
        control = b.execute("SELECT state FROM sessions WHERE id='s'").fetchone()[0]
        a.close()
        b.close()
        report['cases']['C03'] = {'earlier_state': admitted, 'id_only_rows': count, 'id_only_final': unguarded,
                                 'expected_state_rows': control_count, 'expected_state_final': control}
        home = root / 'home'
        home.mkdir()
        env = {k: v for k, v in os.environ.items() if not k.startswith('GIT_')}
        env.update(HOME=str(home), XDG_CONFIG_HOME=str(home / 'config'), GIT_CONFIG_NOSYSTEM='1',
                   GIT_CONFIG_GLOBAL='/dev/null', GIT_TERMINAL_PROMPT='0')
        def git(cwd, *args, check=True):
            argv = ['git', '-c', 'core.hooksPath=/dev/null', '-C', str(cwd), *args]
            process = subprocess.run(argv, env=env, text=True, capture_output=True, timeout=15)
            record = {'argv': [x.replace(str(root), '$TMP') for x in argv], 'code': process.returncode,
                      'stdout': process.stdout.replace(str(root), '$TMP'), 'stderr': process.stderr.replace(str(root), '$TMP')}
            report['commands'].append(record)
            if check and process.returncode:
                raise RuntimeError(record)
            return process
        repo = root / 'repo'
        repo.mkdir()
        report['git'] = git(repo, '--version').stdout.strip()
        git(repo, 'init', '--template=', '-b', 'main')
        git(repo, 'config', 'user.name', 'E07 Fixture')
        git(repo, 'config', 'user.email', 'fixture@example.invalid')
        (repo / 'tracked.txt').write_text('base\n')
        git(repo, 'add', 'tracked.txt')
        git(repo, 'commit', '-m', 'synthetic base')
        keep, cleaned = root / 'keep', root / 'cleaned'
        for path in (keep, cleaned):
            git(repo, 'worktree', 'add', '-b', f'ecc/{path.name}', str(path), 'HEAD')
            (path / 'uncommitted.txt').write_text('synthetic retained-work marker\n')
        before = git(repo, 'worktree', 'list', '--porcelain').stdout
        git(repo, 'worktree', 'remove', '--force', str(cleaned))
        git(repo, 'branch', '-D', 'ecc/cleaned')
        absent_before_log = not cleaned.exists()
        logfile = cleaned / '.claude/ecc2/logs/s.runner-stderr.log'
        logfile.parent.mkdir(parents=True)
        logfile.touch()
        after = git(repo, 'worktree', 'list', '--porcelain').stdout
        identity = git(cleaned, 'rev-parse', '--show-toplevel', check=False)
        keep_identity = git(keep, 'rev-parse', '--show-toplevel')
        report['cases']['C04'] = {
            'registered_before': f'worktree {cleaned}\n' in before,
            'absent_after_cleanup_before_log': absent_before_log,
            'path_recreated': cleaned.exists(), 'registered_after': f'worktree {cleaned}\n' in after,
            'git_identity_exit': identity.returncode, 'removed_marker_exists': (cleaned / 'uncommitted.txt').exists(),
            'retained_control_registered': f'worktree {keep}\n' in after,
            'retained_control_marker': (keep / 'uncommitted.txt').read_text().strip(),
            'retained_control_git_identity': keep_identity.stdout.strip() == str(keep)}
    checks = [report['cases']['C01']['match'],
              all(v['error'] == 'E07 injected prune failure' for v in faults.values()),
              faults['autocommit']['rows_after_reopen'] == ['seed', 'new'],
              faults['transaction']['rows_after_reopen'] == ['seed'],
              report['cases']['C03']['id_only_final'] == 'running',
              report['cases']['C03']['expected_state_rows'] == 0,
              report['cases']['C03']['expected_state_final'] == 'stopped',
              report['cases']['C04']['registered_before'],
              report['cases']['C04']['absent_after_cleanup_before_log'],
              report['cases']['C04']['path_recreated'],
              not report['cases']['C04']['registered_after'],
              report['cases']['C04']['git_identity_exit'] != 0,
              not report['cases']['C04']['removed_marker_exists'],
              report['cases']['C04']['retained_control_registered'],
              report['cases']['C04']['retained_control_git_identity']]
    report['all_planned_discriminators_observed'] = all(checks)
    report['runner_sha256'] = hashlib.sha256(pathlib.Path(__file__).read_bytes()).hexdigest()
    OUT.write_text(json.dumps(report, indent=2, ensure_ascii=False) + '\n')
    print(json.dumps({k: v for k, v in report.items() if k != 'commands'}, indent=2))
    if not all(checks):
        raise SystemExit('A planned discriminator was not observed; inspect RESULTS.json')


if __name__ == '__main__':
    main()
