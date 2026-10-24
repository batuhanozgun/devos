#!/usr/bin/env python3
"""Source-excerpt diagnostics, not a live Harbor or model benchmark.

Accepts pinned full source files (preferred) or recorded local excerpts. Only
named function AST nodes are compiled; upstream module imports are never run.
The shell is byte-checked and invoked only with a fake uv in a temporary root.
"""
from __future__ import annotations
import argparse
import ast
import asyncio
import contextlib
import hashlib
import io
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile
from types import SimpleNamespace
from typing import Any

OPT_NAMES = (
    'parse_job_results', 'compute_pass_rates', 'parse_trial_metrics',
    'summarize_trial_metrics', 'update_frontier', 'update_evolution_summary',
)
ART_NAMES = ('_gather_env_snapshot',)
OPT_BLOB = '1ccae3e66da7f8e9266edada24faaa53fa5bdbe0'
ART_BLOB = '8b460a3e9e41d77b757b2e651d9d7cb8d129d82b'
SH_BLOB = '54b511590818b4cc703288ccbca0f78036792d5f'


def sha(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def blob(data: bytes) -> str:
    return hashlib.sha1(b'blob ' + str(len(data)).encode() + b'\0' + data).hexdigest()


def nodes_for(text: str, names: tuple[str, ...]) -> dict[str, Any]:
    tree = ast.parse(text)
    candidates = list(tree.body)
    for node in tree.body:
        if isinstance(node, ast.ClassDef) and node.name == 'AgentHarness':
            candidates.extend(node.body)
    found = {n.name: n for n in candidates
             if isinstance(n, (ast.FunctionDef, ast.AsyncFunctionDef)) and n.name in names}
    if set(found) != set(names):
        raise ValueError(f'Missing required functions: {set(names) - set(found)}')
    return found


def compile_functions(text: str, names: tuple[str, ...]) -> dict[str, Any]:
    # Only definitions are evaluated. Namespace dependencies are explicit stubs
    # or standard-library objects; no upstream import or global initialization.
    nodes = nodes_for(text, names)
    namespace = {'json': json, 'asyncio': asyncio, '_yellow': str}
    module = ast.Module(body=[nodes[name] for name in names], type_ignores=[])
    exec(compile(ast.fix_missing_locations(module), '<pinned-source-functions>', 'exec'), namespace)
    return namespace


def validate_source(path: Path, names: tuple[str, ...], expected: dict, full_blob: str) -> dict:
    raw = path.read_bytes()
    actual = {k: sha(ast.dump(n, include_attributes=False).encode())
              for k, n in nodes_for(raw.decode(), names).items()}
    if actual != expected['ast']:
        raise ValueError(f'Function AST identity mismatch: {path.name}')
    if blob(raw) == full_blob:
        mode = 'full-file Git blob verified; selected functions executed'
    elif sha(raw) == expected['sha256']:
        mode = 'recorded source excerpt; parent full-file identity NOT locally verified'
    else:
        raise ValueError(f'Unrecognized source container: {path.name}')
    return {'sha256': sha(raw), 'git_blob': blob(raw), 'mode': mode, 'functions': actual}


def parse(ns: dict, root: Path, n: int = 2) -> tuple[dict, str]:
    out = io.StringIO()
    with contextlib.redirect_stdout(out):
        result = ns['parse_job_results'](root, expected_trials=n)
    return result, out.getvalue()


def write_trial(root: Path, name: str, value: Any = None, *, text: str | None = None) -> Path:
    target = root / name
    target.mkdir(parents=True, exist_ok=True)
    if text is not None:
        (target / 'result.json').write_text(text)
    elif value is not None:
        (target / 'result.json').write_text(json.dumps(value))
    return target


def reward(value: float, *, cost: float | None = None) -> dict:
    return {'verifier_result': {'rewards': {'reward': value}},
            'agent_result': {'cost_usd': cost, 'metadata': {'n_episodes': 3}}}


async def snapshot(ns: dict, stdout: str = '', code: int = 0,
                   error: bool = False, no_session: bool = False) -> tuple[str, list]:
    calls = []
    class Env:
        async def exec(self, **kwargs):
            calls.append(kwargs)
            if error:
                raise RuntimeError('synthetic environment failure')
            return SimpleNamespace(stdout=stdout, stderr='synthetic', return_code=code)
    obj = SimpleNamespace(_session=None if no_session else SimpleNamespace(environment=Env()))
    return await ns['_gather_env_snapshot'](obj), calls


def run_shell(raw: bytes, *, dot_env: bool = False, invalid: bool = False) -> dict:
    with tempfile.TemporaryDirectory(prefix='u01b-shell-') as tmp:
        root = Path(tmp)
        scripts = root / 'scripts'; scripts.mkdir()
        path = scripts / 'run_eval.sh'; path.write_bytes(raw)
        fake = root / 'bin'; fake.mkdir()
        capture = root / 'capture.jsonl'
        uv = fake / 'uv'
        uv.write_text(f'#!{sys.executable}\nimport os,sys,json\n'
                      'with open(os.environ["CAPTURE"],"a") as f:\n'
                      ' f.write(json.dumps({"argv":sys.argv[1:],'
                      '"model":os.environ.get("HARBOR_MODEL")})+"\\n")\n')
        uv.chmod(0o755)
        if dot_env:
            (root / '.env').write_text("export HARBOR_MODEL='synthetic/override'\n")
        env = {'PATH': str(fake) + ':/usr/bin:/bin', 'CAPTURE': str(capture),
               'HARBOR_MODEL': 'synthetic/parent', 'HARBOR_EXTERNAL_TIMEOUT': '1',
               'HARBOR_ENVIRONMENT': 'invalid' if invalid else 'runloop',
               'HOME': str(root)}
        cp = subprocess.run(['/bin/bash', str(path), 'agents.synthetic:AgentHarness',
                             'full', '2', '3'], cwd=root, env=env,
                            capture_output=True, text=True, timeout=5)
        calls = [json.loads(line) for line in capture.read_text().splitlines()] if capture.exists() else []
        # Temporary paths are not evidence identities. Preserve only stable argv tail.
        for call in calls:
            if call['argv'][:2] == ['run', 'python']:
                call['argv'][2] = '<isolated-root>/meta_harness.py'
        return {'exit_code': cp.returncode, 'calls': calls,
                'invalid_environment_message': 'Unknown HARBOR_ENVIRONMENT' in cp.stderr}


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument('--optimizer-source', type=Path, required=True)
    ap.add_argument('--artifact-source', type=Path, required=True)
    ap.add_argument('--shell-source', type=Path, required=True)
    ap.add_argument('--identities', type=Path, required=True)
    ap.add_argument('--output', type=Path, required=True)
    args = ap.parse_args()
    ids = json.loads(args.identities.read_text())
    identity = {
        'optimizer': validate_source(args.optimizer_source, OPT_NAMES, ids['optimizer_excerpt.py'], OPT_BLOB),
        'artifact': validate_source(args.artifact_source, ART_NAMES, ids['artifact_excerpt.py'], ART_BLOB),
    }
    opt = args.optimizer_source.read_text(); art = args.artifact_source.read_text()
    shell = args.shell_source.read_bytes()
    if blob(shell) != SH_BLOB:
        raise ValueError('Shell blob mismatch')
    identity['shell'] = {'git_blob': blob(shell), 'sha256': sha(shell), 'full_file_verified': True}
    ns = compile_functions(opt, OPT_NAMES)
    ans = compile_functions(art, ART_NAMES)
    cases = {}; mutants = {}
    with tempfile.TemporaryDirectory(prefix='u01b-probes-') as tmp:
        root = Path(tmp)
        job = root / 'job'; job.mkdir()
        write_trial(job, 'taskA__one', reward(1.0, cost=2.0))
        write_trial(job, 'taskA__two')
        write_trial(job, 'taskB__one', text='{invalid')
        write_trial(job, 'taskB__two', {})
        (job / 'result.json').write_text('{"score": 0.999}')
        rewards, warning = parse(ns, job)
        per_task, avg = ns['compute_pass_rates'](rewards)
        assert rewards == {'taskA': [1.0, 0.0], 'taskB': [0.0, 0.0]}
        assert avg == 0.25 and not warning
        metrics = ns['summarize_trial_metrics'](ns['parse_trial_metrics'](job))
        cases['B01'] = {'expected_attempts': 4, 'observed_rewards': rewards,
                        'flat_pass_rate': avg, 'metric_trial_population': metrics['n_trials'],
                        'reported_cost': metrics['total_cost_usd']}
        mut = compile_functions(opt.replace('append(0.0)', 'append(1.0)'), OPT_NAMES)
        mr, _ = parse(mut, job)
        mutants['N01_missing_default'] = mr != rewards
        mut = compile_functions(opt.replace('r > 0', 'r >= 0'), OPT_NAMES)
        mutants['N02_reward_threshold'] = mut['compute_pass_rates'](rewards)[1] != avg

        shutil.rmtree(job / 'taskA__two')
        r1, w1 = parse(ns, job)
        a1 = ns['compute_pass_rates'](r1)[1]
        shutil.rmtree(job / 'taskB__one'); shutil.rmtree(job / 'taskB__two')
        r2, w2 = parse(ns, job)
        a2 = ns['compute_pass_rates'](r2)[1]
        assert a1 == 1/3 and a2 == 1.0 and 'taskA has 1/2 trials' in w1
        assert 'taskB' not in w2
        ns['FRONTIER_VAL'] = root / 'frontier.json'
        ns['update_frontier']({'complete_baseline': ({'taskA': .75, 'taskB': .75}, .75)})
        ns['update_frontier']({'incomplete_candidate': (ns['compute_pass_rates'](r2)[0], a2)})
        cases['B02'] = {'expected_attempts': 4, 'after_one_missing_average': a1,
                        'after_task_missing_average': a2,
                        'missing_task_warned': 'taskB' in w2,
                        'selected_agent': json.loads(ns['FRONTIER_VAL'].read_text())['_best']['agent']}

        extra = root / 'extra'; extra.mkdir()
        for suffix in ['one','two','three']:
            write_trial(extra, f'taskA__{suffix}', reward(.01))
        er, ew = parse(ns, extra)
        assert ns['compute_pass_rates'](er)[1] == 1.0 and '3/2' in ew
        bad = root / 'bad'; bad.mkdir(); write_trial(bad, 'taskA__one', text='[]')
        try:
            parse(ns, bad)
        except Exception as exc:
            shape_error = type(exc).__name__
        else:
            shape_error = None
        assert shape_error == 'AttributeError'
        cases['B03'] = {'extra_trials_counted': len(er['taskA']), 'expected_trials': 2,
                        'fractional_reward': .01, 'derived_success_rate': 1.0,
                        'valid_json_wrong_shape_error': shape_error,
                        'stale_top_level_ignored': True}

        ns['FRONTIER_VAL'].write_text(json.dumps({'_best': {'agent':'baseline', 'avg_pass_rate': .60}}))
        ns['EVOLUTION_SUMMARY'] = root / 'summary.jsonl'
        ns['update_frontier']({'new': ({'taskA':.75},.75)})
        ns['update_evolution_summary'](1, [{'name':'new','import_path':'agents.new:AgentHarness'}],
                                        {'new': ({'taskA':.75},.75)})
        row = json.loads(ns['EVOLUTION_SUMMARY'].read_text().strip())
        ns['update_frontier']({'new': ({'taskA':.10},.10)})
        retained = json.loads(ns['FRONTIER_VAL'].read_text())['_best']
        assert row['delta'] == 0 and retained['avg_pass_rate'] == .75
        mns = compile_functions(opt.replace('best_avg = frontier.get("_best", {}).get("avg_pass_rate", 0)', 'best_avg = 0.60'), OPT_NAMES)
        mns['FRONTIER_VAL'] = ns['FRONTIER_VAL']; mns['EVOLUTION_SUMMARY'] = root / 'mut-summary.jsonl'
        mns['update_evolution_summary'](1, [{'name':'new'}], {'new': ({'taskA':.75},.75)})
        mrow = json.loads(mns['EVOLUTION_SUMMARY'].read_text().strip())
        mutants['N03_comparator'] = mrow['delta'] != row['delta']
        cases['B04'] = {'prior_best':.60,'new_score':.75,'actual_old_to_new_delta':.15,
                        'stored_delta':row['delta'],'after_same_name_worse_score':retained,
                        'frontier_identity_fields':sorted(retained)}

    partial = '@@PWD@@\n/work\n@@LS@@\n'
    text, calls = asyncio.run(snapshot(ans, partial, code=2))
    assert '(empty directory)' in text and 'Available languages' not in text
    assert calls[0]['timeout_sec'] == 15
    cases['B05'] = {'exec_return_code':2,'output':text,'exec_timeout_sec':15,
                    'outer_wait_timeout_sec':20,'later_sections_present':False}
    mutated_art = art.replace('if "LS" in sections:', 'if "LS" in sections and sections["LS"].strip():')
    mtext, _ = asyncio.run(snapshot(compile_functions(mutated_art, ART_NAMES),partial,code=2))
    mutants['N04_incomplete_listing'] = '(empty directory)' not in mtext

    no_s, _ = asyncio.run(snapshot(ans,no_session=True))
    error_s, _ = asyncio.run(snapshot(ans,error=True))
    full='@@PWD@@\n/app\n@@LS@@\ntotal 1\nfile\n@@LANG@@\nPython 3.x\n@@PKG@@\npip synthetic\n@@MEM@@\nMem: synthetic\n'
    good,_=asyncio.run(snapshot(ans,full))
    long='@@PWD@@\n/app\n@@LS@@\n'+'\n'.join(f'file{i:02d}' for i in range(30))
    long_s,_=asyncio.run(snapshot(ans,long))
    assert no_s == error_s == '' and 'Python 3.x' in good and '(10 more files)' in long_s
    assert 'file19' in long_s and 'file20' not in long_s
    cases['B06']={'no_session_fallback':no_s,'exception_fallback':error_s,
                  'normal_snapshot':good,'listing_rows':30,'retained_rows':20,
                  'omission_label':'10 more files'}

    default = run_shell(shell); override = run_shell(shell,dot_env=True); invalid = run_shell(shell,invalid=True)
    actual=default['calls'][-1]['argv']; oactual=override['calls'][-1]['argv']
    assert actual[actual.index('-m')+1]=='synthetic/parent'
    assert oactual[oactual.index('-m')+1]=='synthetic/override'
    assert invalid['exit_code']==1 and invalid['calls']==[]
    cases['B07']={'default':default,'dotenv_override':override,'invalid_environment':invalid}
    mshell=shell.replace(b'source "$REPO_DIR/.env"',b': # local mutation: no dotenv load')
    mactual=run_shell(mshell,dot_env=True)['calls'][-1]['argv']
    mutants['N05_dotenv_precedence'] = mactual[mactual.index('-m')+1] != 'synthetic/override'

    with tempfile.TemporaryDirectory(prefix='u01b-compound-') as tmp:
        root=Path(tmp); fake=root/'bin'; fake.mkdir()
        (fake/'ls').write_text('#!/bin/sh\nexit 2\n'); (fake/'ls').chmod(0o755)
        cp=subprocess.run(['/bin/bash','--noprofile','--norc','-c',calls[0]['command']],
                          cwd=root,env={'PATH':str(fake)},capture_output=True,text=True,timeout=5)
        assert cp.returncode==0 and '@@PWD@@' in cp.stdout and '@@LS@@' in cp.stdout
        assert '@@LANG@@' not in cp.stdout and '@@PKG@@' not in cp.stdout
        stable=cp.stdout.replace(str(root),'<isolated-cwd>')
        linked,_=asyncio.run(snapshot(ans,stable,code=cp.returncode))
        assert '(empty directory)' in linked
        cases['B08']={'fake_ls_exit_code':2,'compound_exit_code':cp.returncode,
                      'stdout':stable,'parsed_snapshot':linked,
                      'later_sections_executed':False}

    assert all(mutants.values()), mutants
    result={'scope':'source-informed local mechanical diagnostics, not live system verification',
            'identity':identity,'cases':cases,'negative_controls':mutants,
            'groups_completed':len(cases),'negative_controls_discriminated':sum(mutants.values()),
            'limits':['Python functions are copied source excerpts, not a full upstream import',
                      'Only shell wrapper full-file Git blob identity verified locally',
                      'Synthetic fixtures; no LLM, Harbor installation, remote sandbox, credentials or benchmark',
                      'First-model-request consumption and caller timeout handling remain source-only',
                      'No historical incidence, general efficacy or independent replication inferred']}
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(result,ensure_ascii=False,indent=2,sort_keys=True)+'\n')
    print(json.dumps({'groups':len(cases),'negative_controls':sum(mutants.values()),'sha256':sha(args.output.read_bytes())}))

if __name__=='__main__':
    main()
