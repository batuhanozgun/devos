#!/usr/bin/env python3
"""Bounded full-memory-modules + selected prompt-functions probe. See SPEC.md.
Run in a fresh disposable process. No model/provider. Never overwrites output.
"""
from __future__ import annotations
import argparse
import hashlib
import importlib.util
import json
import logging
import platform
import socket
import sys
import tempfile
from datetime import datetime, timezone
from pathlib import Path
from types import SimpleNamespace as NS
from typing import Any, List
from unittest.mock import patch

ROOT = Path(__file__).resolve().parent
M2_PROBE = '874b1f5c7314464b5ea011bc4e4adfaf124a1fb0'
SELECTIONS = {
    'conversation_prompt.py': '38ef876383548ce6e905c99b1951a5e5d7fa6197df2bd2637e0a6faadab65591',
    'memory_prompt.py': 'c05bec56e92103836e7f4bb72bde24f57d5dffa71d3ff9ae50107d6f2274c07b',
}
OLD, NEW = 'M4_OLD_MEMORY', 'M4_NEW_MEMORY'
CWD = '/synthetic/work'
HISTORY = [{'role': 'user', 'content': 'Synthetic previous turn.'}]


def git_blob(data: bytes) -> str:
    return hashlib.sha1(b'blob ' + str(len(data)).encode() + b'\0' + data).hexdigest()


def verify_selection(name: str, data: bytes) -> None:
    if hashlib.sha256(data).hexdigest() != SELECTIONS[name]:
        raise ValueError('local selection identity mismatch; exec refused')


class DB:
    """Synthetic session-row store. Not SQLite or a production persistence layer."""
    def __init__(self, text):
        self.text = text
        self.fail_read = self.fail_write = False
        self.reads = self.writes = 0

    def get_session(self, _session_id):
        self.reads += 1
        if self.fail_read:
            raise OSError('synthetic DB read failure')
        return {'system_prompt': self.text}

    def update_system_prompt(self, _session_id, text):
        self.writes += 1
        if self.fail_write:
            raise OSError('synthetic DB write failure')
        self.text = text

    def get_session_title(self, _session_id):
        return ''


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--m2-root', type=Path, default=ROOT.parent / '2026-09-09-memory-pending')
    parser.add_argument('--output', required=True, type=Path)
    args = parser.parse_args()
    if args.output.exists():
        raise FileExistsError(f'output exists: {args.output}')
    data = (args.m2_root / 'probe.py').read_bytes()
    if git_blob(data) != M2_PROBE:
        raise ValueError('M2 setup artifact identity mismatch; import refused')
    spec = importlib.util.spec_from_file_location('m4_reused_m2', args.m2_root / 'probe.py')
    if spec is None or spec.loader is None:
        raise RuntimeError('cannot create M2 import spec')
    m2 = importlib.util.module_from_spec(spec)
    sys.modules[spec.name] = m2
    spec.loader.exec_module(m2)  # main()/N cases are not called.
    m2.PROV, m2.WA, m2.SM, m2.MT, m2.CMD = m2.setup()
    events, cases = [], []
    capability = {'stale': False, 'raise': False}

    def observe(name, *a, **kw):
        events.append(name)

    def stale(*a):
        if capability['raise']:
            raise RuntimeError('synthetic capability probe failure')
        return capability['stale']

    m2.module('agent', __path__=[])
    m2.module('agent.system_prompt',
              _agent_home=lambda a: m2.ENV['home'],
              restore_plugin_prompt_sections=lambda *a, **kw: observe('restore_plugin_sections'),
              reconstruct_static_prefix=lambda *a, **kw: observe('reconstruct_static_prefix'))
    m2.module('agent.prompt_builder', clear_skills_system_prompt_cache=lambda **kw: observe('clear_skills_cache'))
    m2.module('agent.credits_tracker', seed_credits_at_session_start=lambda a: observe('seed_credits'))
    m2.module('hermes_cli.lifecycle', invoke_hook=lambda *a, **kw: observe('lifecycle', *a, **kw))
    m2.module('tools.mcp_tool_agent', persist_agent_tool_names=lambda a: observe('persist_tool_names'),
              restore_agent_tool_prefix=lambda *a: observe('restore_tool_prefix'))
    m2.module('tools.bot_mode_probe', BOT_CHAT_TITLE='Bot Chat',
              stored_prompt_capability_stale=stale,
              stored_bot_chat_prompt_needs_upgrade=lambda *a: False)
    ns = {'Any': Any, 'List': List, 'json': json,
          'logger': logging.getLogger('m4-selected'), 'resolve_agent_cwd': lambda: CWD}
    for name in SELECTIONS:
        code = (ROOT / 'selected' / name).read_bytes()
        verify_selection(name, code)
        exec(compile(code, name, 'exec'), ns)
    restore = ns['_restore_or_build_system_prompt']
    invalidate = ns['invalidate_system_prompt']
    memory_parts = ns['_memory_parts']
    persist = ns['_persist_system_prompt']

    def render(a):
        # Intentionally REDUCED builder, not Hermes build_system_prompt.
        return '\n\n'.join([
            'HARNESS REDUCED PROMPT\nUser home directory: /synthetic/home\nCurrent working directory: ' + CWD,
            *memory_parts(a),
            f'Model: {a.model}\nProvider: {a.provider}\nPlatform: {a.platform}',
        ])

    def agent(store, db):
        a = NS(_memory_store=store, _memory_enabled=True, _user_profile_enabled=False,
               _memory_manager=None, _session_db=db, session_id='m4-synthetic-session',
               model='model-A', provider='offline', platform='cli',
               _cached_system_prompt=None, _cached_system_prompt_static=None,
               _use_prompt_caching=False, _bot_mode_protocol=False, build_calls=0)
        def build(_system_message):
            a.build_calls += 1
            return render(a)
        a._build_system_prompt = build
        return a

    def setup_case(home):
        m2.ENV.update(home=home, config={'memory': {'write_approval': False}}, fail_write=False, events=[])
        capability.update(stale=False, **{'raise': False})
        events.clear()
        folder = home / 'memories'
        folder.mkdir()
        (folder / 'MEMORY.md').write_text(OLD, encoding='utf-8')
        s = m2.fresh()
        a = agent(s, None)
        old_prompt = render(a)
        db = DB(old_prompt)
        return s, a, db, old_prompt

    def apply(s, action='replace', fail=False):
        kwargs = {'action': action, 'old_text': OLD}
        if action == 'replace':
            kwargs['content'] = NEW
        rec = m2.stage(s, **kwargs)
        m2.ENV['fail_write'] = fail
        try:
            return m2.approve(s, rec)
        finally:
            m2.ENV['fail_write'] = False

    def compact(s):
        snap = m2.snapshot(s)
        return {k: snap[k] for k in ('disk_utf8', 'live_entries', 'snapshot', 'pending_count')}

    def selected(a, old_prompt):
        text = a._cached_system_prompt or ''
        return {'contains_old': OLD in text, 'contains_new': NEW in text,
                'same_as_stored_old': text == old_prompt, 'builder_calls': a.build_calls}

    def v01(s, _, db, old):
        approval = apply(s)
        original = compact(s)
        fresh = m2.fresh()
        a = agent(fresh, db)
        restore(a, None, HISTORY)
        return ({'approval': approval, 'original_store': original,
                 'fresh_store': compact(fresh), 'selected': selected(a, old)},
                original['disk_utf8'] == NEW and original['live_entries'] == [NEW]
                and OLD in original['snapshot'] and NEW in compact(fresh)['snapshot']
                and a._cached_system_prompt == old and a.build_calls == 0)

    def v02(s, _, db, old):
        apply(s)
        variants = []
        for mode in ('empty_history', 'null_prompt', 'read_failure'):
            d = DB(None if mode == 'null_prompt' else old)
            d.fail_read = mode == 'read_failure'
            a = agent(m2.fresh(), d)
            restore(a, None, [] if mode == 'empty_history' else HISTORY)
            variants.append({'mode': mode, **selected(a, old)})
        return ({'variants': variants}, all(x['contains_new'] and not x['contains_old'] and x['builder_calls'] == 1 for x in variants))

    def v03(s, _, db, old):
        apply(s)
        variants = []
        for field in ('model', 'provider', 'platform', 'cwd'):
            text = old.replace(CWD, '/other/work') if field == 'cwd' else old
            a = agent(m2.fresh(), DB(text))
            if field != 'cwd':
                setattr(a, field, 'different-' + field)
            restore(a, None, HISTORY)
            variants.append({'mismatch': field, **selected(a, old)})
        return ({'variants': variants}, all(x['contains_new'] and not x['contains_old'] and x['builder_calls'] == 1 for x in variants))

    def v04(s, _, db, old):
        a = agent(s, db)
        a._cached_system_prompt = old
        apply(s)
        s.load_from_disk()
        reload_only = selected(a, old)
        a._plugin_system_prompt_sections_snapshot = {'test': 'old plugin bytes'}
        invalidate(a)
        invalidated = {'cache_none': a._cached_system_prompt is None,
                       'snapshot_new': NEW in s.format_for_system_prompt('memory'),
                       'db_unchanged': db.text == old,
                       'plugin_previous_saved': a._plugin_system_prompt_sections_previous == {'test': 'old plugin bytes'}}
        restore(a, None, HISTORY)  # Harness-controlled composition, not actual compression caller.
        restored = selected(a, old)
        a._cached_system_prompt = a._build_system_prompt(None)
        persist(a, 'synthetic explicit persist failure %s: %s')
        later = agent(m2.fresh(), db)
        restore(later, None, HISTORY)
        return ({'reload_only': reload_only, 'after_invalidation': invalidated,
                 'then_restore': restored, 'after_explicit_build_persist': selected(later, old)},
                reload_only['contains_old'] and all(invalidated.values()) and restored['same_as_stored_old']
                and NEW in later._cached_system_prompt and OLD not in later._cached_system_prompt and later.build_calls == 0)

    def v05(s, _, db, old):
        approval = apply(s, action='remove')
        fresh = m2.fresh()
        a = agent(fresh, db)
        restore(a, None, HISTORY)
        kept = selected(a, old)
        fresh_without_row = agent(m2.fresh(), DB(None))
        restore(fresh_without_row, None, HISTORY)
        return ({'approval': approval, 'fresh_store': compact(fresh),
                 'restored': kept, 'built_without_stored_prompt': selected(fresh_without_row, old)},
                compact(fresh)['disk_utf8'] == '' and not memory_parts(a) and kept['contains_old']
                and OLD not in fresh_without_row._cached_system_prompt)

    def v06(s, _, db, old):
        approval = apply(s, fail=True)
        failed = compact(s)
        a = agent(s, db)
        a._cached_system_prompt = old
        invalidate(a)
        after_reload = compact(s)
        restore(a, None, HISTORY)
        return ({'approval': approval, 'failed_store': failed, 'reloaded_store': after_reload,
                 'selected': selected(a, old)},
                failed['disk_utf8'] == OLD and failed['live_entries'] == [NEW]
                and failed['pending_count'] == 1 and after_reload['live_entries'] == [OLD]
                and a._cached_system_prompt == old and 'Failed' in approval)

    def v07(s, _, db, old):
        apply(s)
        db.fail_read = db.fail_write = True
        a = agent(m2.fresh(), db)
        restore(a, None, HISTORY)
        first = selected(a, old)
        db_kept = db.text == old
        db.fail_read = db.fail_write = False
        later = agent(m2.fresh(), db)
        restore(later, None, HISTORY)
        return ({'first_under_fake_db_faults': first, 'db_kept_old': db_kept,
                 'later_after_faults_removed': selected(later, old)},
                first['contains_new'] and not first['contains_old'] and db_kept and later._cached_system_prompt == old)

    def v08(s, _, db, old):
        apply(s)
        capability['stale'] = True
        a = agent(m2.fresh(), DB(old))
        restore(a, None, HISTORY)
        refreshed = selected(a, old)
        cache_clear_observed = 'clear_skills_cache' in events
        capability.update(stale=False, **{'raise': True})
        b = agent(m2.fresh(), DB(old))
        restore(b, None, HISTORY)
        return ({'controlled_capability_change': refreshed, 'cache_clear_callback': cache_clear_observed,
                 'probe_exception': selected(b, old)},
                refreshed['contains_new'] and cache_clear_observed and b._cached_system_prompt == old)

    def no_network(*a, **kw):
        raise RuntimeError('network forbidden in offline probe')

    negative = {}
    with patch.object(socket, 'socket', no_network), patch.object(socket, 'create_connection', no_network):
        for i, fn in enumerate((v01, v02, v03, v04, v05, v06, v07, v08), 1):
            with tempfile.TemporaryDirectory(prefix='hermes-m4-') as td:
                state = setup_case(Path(td))
                try:
                    observed, matched = fn(*state)
                    cases.append({'id': f'V{i:02}', 'observed': observed, 'matched': bool(matched)})
                except Exception as exc:
                    cases.append({'id': f'V{i:02}', 'exception': repr(exc), 'matched': False})
        with tempfile.TemporaryDirectory(prefix='hermes-m4-negative-') as td:
            p = Path(td) / 'bad.py'
            p.write_bytes((args.m2_root / 'upstream/memory_tool.py').read_bytes() + b'\n# deliberate mutation\n')
            try:
                m2.check_source(p, m2.EXPECTED['memory_tool.py'])
                negative['full_source_rejected_before_import'] = False
            except ValueError:
                negative['full_source_rejected_before_import'] = True
            code = (ROOT / 'selected/conversation_prompt.py').read_bytes()
            try:
                verify_selection('conversation_prompt.py', code + b'\n')
                negative['local_selection_change_rejected'] = False
            except ValueError:
                negative['local_selection_change_rejected'] = True
        original_check = ns['_stored_prompt_matches_runtime']
        for name, value in (('always_true', True), ('always_false', False)):
            with tempfile.TemporaryDirectory(prefix='hermes-m4-mutant-') as td:
                s, _, db, old = setup_case(Path(td))
                apply(s)
                a = agent(m2.fresh(), db)
                if value:
                    a.model = 'different-model'
                ns['_stored_prompt_matches_runtime'] = lambda *a, value=value: value
                restore(a, None, HISTORY)
                expected = NEW in a._cached_system_prompt if value else a._cached_system_prompt == old and a.build_calls == 0
                negative[name + '_detected_by_' + ('V03' if value else 'V01')] = not expected
        ns['_stored_prompt_matches_runtime'] = original_check
    out = {
        'kind': 'BOUNDED_MEMORY_APPLY_AND_SELECTED_PROMPT_RESTORE_NOT_PREPARED_REQUEST',
        'executed_at_utc': datetime.now(timezone.utc).isoformat(),
        'python': platform.python_version(), 'platform': platform.platform(),
        'upstream_pin': 'c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a',
        'five_full_M2_module_git_identities': m2.EXPECTED,
        'reused_M2_setup_git_blob': M2_PROBE,
        'selected_definition_sha256': SELECTIONS,
        'selected_parent_full_byte_fidelity': 'NOT_VERIFIED; manual source selections',
        'spec_sha256': hashlib.sha256((ROOT / 'SPEC.md').read_bytes()).hexdigest(),
        'probe_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        'cases': cases, 'negative_controls': negative,
        'all_expectations_matched': all(c['matched'] for c in cases) and all(negative.values()),
        'endpoint': 'selected cached prompt, disk/live/frozen memory and synthetic DB state',
        'not_executed': ['real CLI/gateway', 'actual compression caller', 'full prompt builder',
                         'turn_context/request assembly', 'provider/model', 'real Bot Chat probe', 'actual SQLite'],
        'previous_N_A_SA_AP_suites_rerun': False,
        'semantic_mutants_are_separate': True,
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    with args.output.open('x', encoding='utf-8') as f:
        json.dump(out, f, ensure_ascii=False, indent=2)
        f.write('\n')
    print(json.dumps({'diagnostic_groups': len(cases), 'matched': out['all_expectations_matched'],
                      'endpoint': out['endpoint']}))
    return 0 if out['all_expectations_matched'] else 1


if __name__ == '__main__':
    raise SystemExit(main())
