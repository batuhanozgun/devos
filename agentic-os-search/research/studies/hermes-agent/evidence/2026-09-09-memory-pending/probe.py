#!/usr/bin/env python3
"""Offline, bounded MemoryStore/pending-command diagnostics; see SPEC.md.
No Hermes installation. Run in a fresh disposable process. Outputs never overwrite.
"""
from __future__ import annotations
import argparse
import hashlib
import importlib.util
import json
import os
import platform
import sys
import tempfile
import types
from datetime import datetime, timezone
from pathlib import Path
from unittest.mock import patch

ROOT = Path(__file__).resolve().parent
EXPECTED = {
    'memory_tool_store.py': '457594444311af31c837dcdd74cd1c55f2b47b3c',
    'memory_tool.py': '8028ffd88a91b1625e1f1cebe500c37c6e6842a7',
    'write_approval_commands.py': '150b72dfd17696ab7a64f97057b7405128f5b352',
    'skill_provenance.py': '3df9cf143045644310fa7d27a65666c8c23caf95',
    'write_approval.py': 'f1e99b46e934595c002c2bc659143fcbc1f9fe8d',
}
ENV = {'home': None, 'config': {}, 'fail_write': False, 'events': []}
SENTINEL = 'HERMES_HARMLESS_TEST_SENTINEL'
IMPORTED = []

def blob(b):
    return hashlib.sha1(b'blob ' + str(len(b)).encode() + b'\0' + b).hexdigest()

def check_source(path, expected):
    data = Path(path).read_bytes()
    actual = blob(data)
    if actual != expected:
        raise ValueError(f'Source identity mismatch: {Path(path).name}: {actual} != {expected}')
    return data

def module(name, **attrs):
    m = types.ModuleType(name)
    for k, v in attrs.items():
        setattr(m, k, v)
    sys.modules[name] = m
    return m

def load(name, filename):
    path = ROOT / 'upstream' / filename
    check_source(path, EXPECTED[filename])
    spec = importlib.util.spec_from_file_location(name, path)
    m = importlib.util.module_from_spec(spec)
    sys.modules[name] = m
    parent, _, leaf = name.rpartition('.')
    if parent:
        setattr(sys.modules[parent], leaf, m)
    spec.loader.exec_module(m)
    IMPORTED.append(name)
    return m

def event(kind, **kw):
    ENV['events'].append({'kind': kind, **kw})

def synthetic_writer(path, text, *, tmp_prefix):
    event('write_attempt', file=path.name, text=text,
          origin=sys.modules['tools.skill_provenance'].get_current_write_origin(),
          failure_injected=ENV['fail_write'])
    if ENV['fail_write']:
        raise OSError('synthetic pre-commit failure')
    fd, temp = tempfile.mkstemp(dir=path.parent, prefix=tmp_prefix)
    try:
        with os.fdopen(fd, 'w', encoding='utf-8') as f:
            f.write(text)
        os.replace(temp, path)
    finally:
        if os.path.exists(temp):
            os.unlink(temp)
    event('write_committed', file=path.name, text=text)

def scan_first(text, *, scope):
    event('pre_scan', text=text, scope=scope)
    return 'Synthetic sentinel rejection' if SENTINEL in text else None

def scan_load(text, *, scope):
    event('load_scan', text=text, scope=scope)
    return ['synthetic-sentinel'] if SENTINEL in text else []

def cfg_get(config, *keys, default=None):
    for key in keys:
        if not isinstance(config, dict) or key not in config:
            return default
        config = config[key]
    return config

def truthy(value, default=True):
    if value is None:
        return default
    if not isinstance(value, bool):
        raise TypeError('This fixture config parser accepts booleans only')
    return value

def setup():
    module('tools', __path__=[])
    module('hermes_cli', __path__=[])
    module('hermes_constants', get_hermes_home=lambda: ENV['home'])
    module('utils', atomic_write_text=synthetic_writer, is_truthy_value=truthy)
    module('tools.threat_patterns', first_threat_message=scan_first, scan_for_threats=scan_load)
    module('tools.registry', no_cache_check_fn=lambda f: f,
           registry=types.SimpleNamespace(register=lambda **kw: None),
           tool_error=lambda message, **kw: json.dumps({'error': message, **kw}),
           _bound_error_text=lambda text: text)
    module('hermes_cli.config', load_config=lambda: ENV['config'],
           load_config_readonly=lambda: ENV['config'], cfg_get=cfg_get)
    tt = module('tools.terminal_tool', _get_approval_callback=lambda: None)
    sys.modules['tools'].terminal_tool = tt
    provenance = load('tools.skill_provenance', 'skill_provenance.py')
    wa = load('tools.write_approval', 'write_approval.py')
    storemod = load('tools.memory_tool_store', 'memory_tool_store.py')
    memory = load('tools.memory_tool', 'memory_tool.py')
    command = load('hermes_cli.write_approval_commands', 'write_approval_commands.py')
    return provenance, wa, storemod, memory, command

PROV = WA = SM = MT = CMD = None

def snapshot(store):
    p = MT.get_memory_dir() / 'MEMORY.md'
    data = p.read_bytes() if p.exists() else None
    return {'disk_hex': data.hex() if data is not None else None,
            'disk_utf8': data.decode('utf-8', errors='backslashreplace') if data is not None else None,
            'live_entries': list(store.memory_entries),
            'snapshot': store.format_for_system_prompt('memory'),
            'pending_count': WA.pending_count('memory')}

def fresh(limit=2200):
    s = SM.MemoryStore(memory_char_limit=limit)
    s.load_from_disk()
    return s

def tool(store, **args):
    return json.loads(MT.memory_tool(store=store, **args))

def stage(store, **args):
    ENV['config']['memory']['write_approval'] = True
    t = PROV.set_current_write_origin('background_review')
    try:
        result = tool(store, **args)
    finally:
        PROV.reset_current_write_origin(t)
    assert result.get('staged') is True, result
    return WA.get_pending('memory', result['pending_id'])

def approve(store, rec):
    return CMD.handle_pending_subcommand('memory', ['approve', rec['id']], memory_store=store)

def N01(s):
    before = snapshot(s)
    r = tool(s, action='replace', old_text='Alpha', content='Beta')
    after = snapshot(s)
    s.load_from_disk(); reloaded = snapshot(s)
    assert r['success'] and after['disk_utf8'] == 'Beta' and after['live_entries'] == ['Beta']
    assert after['snapshot'] == before['snapshot'] and 'Beta' in reloaded['snapshot']
    return dict(before=before, result=r, after=after, reloaded=reloaded)

def N02(s):
    ENV['fail_write'] = True
    try:
        tool(s, action='replace', old_text='Alpha', content='Beta')
        raise AssertionError('Expected write error')
    except RuntimeError as e:
        error = str(e).replace(str(ENV['home']), '<fixture>')
    failed = snapshot(s)
    assert failed['disk_utf8'] == 'Alpha' and failed['live_entries'] == ['Beta'] and 'Alpha' in failed['snapshot']
    s.load_from_disk(); repaired = snapshot(s)
    assert repaired['live_entries'] == ['Alpha']
    ENV['fail_write'] = False
    retry = tool(s, action='replace', old_text='Alpha', content='Beta')
    assert retry['success'] and snapshot(s)['disk_utf8'] == 'Beta'
    return dict(error=error, failed=failed, repaired=repaired, retry=retry, final=snapshot(s))

def N03(s):
    s.memory_char_limit = 8
    r = tool(s, operations=[{'action': 'add', 'content': 'Beta'}, {'action': 'remove', 'old_text': 'Alpha'}])
    good = snapshot(s)
    before_writes = sum(e['kind'] == 'write_committed' for e in ENV['events'])
    bad = tool(s, operations=[{'action': 'add', 'content': 'C'}, {'action': 'remove', 'old_text': 'absent'}])
    after = snapshot(s)
    assert r['success'] and good['disk_utf8'] == 'Beta'
    assert not bad['success'] and after['disk_utf8'] == 'Beta' and after['live_entries'] == ['Beta']
    assert before_writes == sum(e['kind'] == 'write_committed' for e in ENV['events'])
    return dict(final_budget=r, after_success=good, unmatched=bad, after_failure=after)

def N04(s):
    batch = tool(s, operations=[{'action': 'remove', 'old_text': 'Alpha'}]); after_batch = snapshot(s)
    single = tool(s, action='remove', old_text='Alpha'); after_single = snapshot(s)
    assert not batch['success'] and after_batch['disk_utf8'] == 'Alpha'
    assert single['success'] and after_single['disk_utf8'] == '' and after_single['live_entries'] == []
    assert after_single['snapshot'] == after_batch['snapshot']
    return dict(batch=batch, after_batch=after_batch, single=single, after_single=after_single)

def N05(s):
    p = MT.get_memory_dir() / 'MEMORY.md'; p.write_bytes(b'Alpha\xff')
    r = tool(s, action='add', content='Beta'); after = snapshot(s)
    assert not r['success'] and p.read_bytes() == b'Alpha\xff'
    assert not any(e['kind'] == 'write_attempt' for e in ENV['events'])
    return dict(result=r, after=after)

def N06(s):
    other = fresh(); initial_other = snapshot(other)
    a = tool(s, action='add', content='Beta')
    b = tool(other, action='add', content='Gamma'); final = snapshot(other)
    assert a['success'] and b['success'] and final['live_entries'] == ['Alpha', 'Beta', 'Gamma']
    assert final['disk_utf8'] == 'Alpha\n§\nBeta\n§\nGamma'
    assert final['snapshot'] == initial_other['snapshot']
    return dict(other_before=initial_other, first_result=a, second_result=b, other_after=final)

def N07(s):
    single = tool(s, action='add', new_text=SENTINEL)
    content = tool(s, operations=[{'action': 'add', 'content': SENTINEL}])
    prior_scans = sum(e['kind'] == 'pre_scan' for e in ENV['events'])
    alias = tool(s, operations=[{'action': 'add', 'new_text': SENTINEL}]); before_reload = snapshot(s)
    assert not single['success'] and not content['success'] and alias['success']
    assert sum(e['kind'] == 'pre_scan' for e in ENV['events']) == prior_scans
    assert SENTINEL in before_reload['disk_utf8'] and SENTINEL not in before_reload['snapshot']
    s.load_from_disk(); after_reload = snapshot(s)
    assert SENTINEL in after_reload['live_entries'] and '[BLOCKED:' in after_reload['snapshot']
    assert SENTINEL not in after_reload['snapshot']
    return dict(single_alias=single, batch_content=content, batch_alias=alias,
                before_reload=before_reload, after_reload=after_reload)

def N08(s):
    rec = stage(s, action='add', content='Beta'); staged = snapshot(s)
    listing = CMD.handle_pending_subcommand('memory', ['pending'], memory_store=s)
    result = approve(s, rec); after = snapshot(s)
    writes = [e for e in ENV['events'] if e['kind'] == 'write_attempt']
    assert rec['origin'] == 'background_review' and staged['disk_utf8'] == 'Alpha' and staged['pending_count'] == 1
    assert '[auto]' in listing and result == 'Approved 1 memory write(s).'
    assert after['live_entries'] == ['Alpha', 'Beta'] and after['pending_count'] == 0 and after['snapshot'] == staged['snapshot']
    assert writes[-1]['origin'] == 'foreground'
    return dict(record=rec, staged=staged, listing=listing, command=result, after=after, apply_origin=writes[-1]['origin'])

def N09(s):
    rec = stage(s, action='replace', old_text='Alpha', content='Beta')
    ENV['fail_write'] = True
    failed = approve(s, rec); failed_state = snapshot(s)
    assert failed.startswith('Approved 0') and 'Failed:' in failed
    assert failed_state['disk_utf8'] == 'Alpha' and failed_state['live_entries'] == ['Beta'] and failed_state['pending_count'] == 1
    ENV['fail_write'] = False
    retried = approve(s, rec); final = snapshot(s)
    assert retried == 'Approved 1 memory write(s).' and final['disk_utf8'] == 'Beta' and final['pending_count'] == 0
    return dict(command_failure=failed.replace(str(ENV['home']), '<fixture>'), failed=failed_state, command_retry=retried, final=final)

def N10(s):
    rec = stage(s, action='add', content='Beta')
    s.memory_enabled = False
    result = approve(s, rec); after = snapshot(s)
    assert result.startswith('Approved 0') and 'disabled' in result and after['pending_count'] == 1
    assert after['disk_utf8'] == 'Alpha' and not any(e['kind'] == 'write_attempt' for e in ENV['events'])
    return dict(command=result, after=after)

def N11(s):
    rec = stage(s, action='add', content='Beta')
    pending_path = ENV['home'] / 'pending' / 'memory' / (rec['id'] + '.json')
    original_unlink = Path.unlink
    def fail_pending_unlink(self, *args, **kw):
        if self == pending_path:
            raise OSError('synthetic pending unlink failure')
        return original_unlink(self, *args, **kw)
    with patch.object(Path, 'unlink', fail_pending_unlink):
        result = approve(s, rec)
    uncleared = snapshot(s)
    assert result == 'Approved 1 memory write(s).' and uncleared['pending_count'] == 1
    again = approve(s, rec); final = snapshot(s)
    assert again == 'Approved 1 memory write(s).' and final['pending_count'] == 0 and final['live_entries'] == ['Alpha', 'Beta']
    return dict(command=result, uncleared=uncleared, retry_command=again, final=final)

def N12(s):
    rec = stage(s, operations=[{'action': 'not-an-operation'}]); staged = snapshot(s)
    result = approve(s, rec); after = snapshot(s)
    assert staged['pending_count'] == 1 and result.startswith('Approved 0') and 'unknown action' in result
    assert after['disk_utf8'] == 'Alpha' and after['pending_count'] == 1
    assert not any(e['kind'] == 'write_attempt' for e in ENV['events'])
    return dict(record=rec, staged=staged, command=result, after=after)

def main():
    global PROV, WA, SM, MT, CMD
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--output', type=Path, required=True)
    args = p.parse_args()
    if args.output.exists():
        raise FileExistsError(f'Refusing to overwrite evidence: {args.output}')
    started = datetime.now(timezone.utc).isoformat()
    PROV, WA, SM, MT, CMD = setup()
    results = []
    for case in [N01, N02, N03, N04, N05, N06, N07, N08, N09, N10, N11, N12]:
        with tempfile.TemporaryDirectory(prefix='hermes_memory_probe_') as d:
            ENV.update(home=Path(d), config={'memory': {'write_approval': False}}, fail_write=False, events=[])
            memdir = Path(d) / 'memories'; memdir.mkdir()
            (memdir / 'MEMORY.md').write_text('Alpha', encoding='utf-8')
            s = fresh(); ENV['events'].clear()
            try:
                observations = case(s); matched = True
            except Exception as exc:
                observations = {'unexpected_exception': type(exc).__name__, 'message': str(exc).replace(d, '<fixture>'), 'state': snapshot(s)}
                matched = False
            results.append({'id': case.__name__, 'expectations_matched': matched,
                            'observation': observations, 'trace': list(ENV['events'])})
    with tempfile.TemporaryDirectory(prefix='hermes_identity_') as d:
        altered = Path(d) / 'memory_tool_store.py'
        altered.write_bytes((ROOT / 'upstream' / 'memory_tool_store.py').read_bytes() + b'\n# altered fixture\n')
        before_imports = list(IMPORTED)
        try:
            check_source(altered, EXPECTED['memory_tool_store.py'])
            rejected = False
        except ValueError:
            rejected = True
        negative = {'modified_copy_rejected_by_actual_guard': rejected, 'no_import_performed': before_imports == IMPORTED}
    report = {'kind': 'BOUNDED_FIVE_FULL_MODULE_MEMORY_PENDING_DIAGNOSTICS_NOT_PRODUCT_PASS',
              'started_at_utc': started, 'finished_at_utc': datetime.now(timezone.utc).isoformat(),
              'python': sys.version, 'platform': platform.platform(),
              'upstream_pin': 'c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a',
              'source_identities': json.loads((ROOT / 'SOURCE-IDENTITY.json').read_text()),
              'harness_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
              'spec_sha256': hashlib.sha256((ROOT / 'SPEC.md').read_bytes()).hexdigest(),
              'imported_complete_modules': IMPORTED, 'cases': results,
              'identity_negative_control': negative,
              'all_diagnostic_expectations_matched': all(r['expectations_matched'] for r in results) and rejected,
              'limits': ['synthetic home/config/registry/terminal callback', 'synthetic sentinel scanner, NOT actual threat detection',
                         'synthetic stdlib temp/replace helper with pre-commit fault injection', 'real Linux fcntl lock branch; no concurrency stress test',
                         'no actual CLI/gateway/AIAgent/provider/credentials/network', 'not D2 original-file AST or full worker integration']}
    args.output.write_text(json.dumps(report, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
    print(json.dumps({'output': args.output.name, 'cases': len(results), 'all_diagnostic_expectations_matched': report['all_diagnostic_expectations_matched']}, ensure_ascii=False))
    return 0 if report['all_diagnostic_expectations_matched'] else 1

if __name__ == '__main__':
    raise SystemExit(main())
