"""Three bounded U4 checks. Python 3.10+; standard library only.
Writes sibling RESULT.json; N02 uses only temporary in-memory SQLite.
No network, repository mutation, real actor or production service is exercised.
"""
from __future__ import annotations

import hashlib
import itertools
import json
import platform
import sqlite3
from collections import Counter
from pathlib import Path


def require(condition: bool, message: str) -> None:
    if not condition:
        raise AssertionError(message)


def subsets(values: tuple) -> list[tuple]:
    return [s for size in range(len(values) + 1)
            for s in itertools.combinations(values, size)]


def n01() -> dict:
    records = [('HOLD', 'tests-incomplete'), ('HOLD', 'dependency-incompatible')]
    actions = {record[0] for record in records}
    reasons = {record[1] for record in records}
    common = set.intersection(*({r[1]} for r in records))
    valid_constant_policies = [candidate for candidate in sorted(reasons)
                              if all(candidate == r[1] for r in records)]
    full_reason_policy = {i: record[1] for i, record in enumerate(records)}
    require(actions == {'HOLD'} and not common and not valid_constant_policies,
            'Action and exact reason were not separated')
    require(all(full_reason_policy[i] == r[1] for i, r in enumerate(records)),
            'Full-view reason recovery failed')
    return dict(action_preserved=True, exact_reason_preserved=False,
                common_reasons=sorted(common), constant_policies=valid_constant_policies,
                full_reasons=[full_reason_policy[i] for i in range(len(records))])


def n02() -> dict:
    rows = [('a', 'module', 1), ('b', 'module', 1), ('c', 'other', 0)]
    query = 'SELECT DISTINCT artifact FROM facts WHERE eligible=1 ORDER BY artifact'
    conn = sqlite3.connect(':memory:')
    try:
        conn.execute('CREATE TABLE facts(id TEXT PRIMARY KEY, artifact TEXT, eligible INTEGER)')

        def evaluate(chosen: tuple[str, ...], delete_a: bool = False) -> list[str]:
            conn.execute('DELETE FROM facts')
            conn.executemany('INSERT INTO facts VALUES (?,?,?)',
                             [row for row in rows if row[0] in chosen])
            if delete_a:
                conn.execute("DELETE FROM facts WHERE id='a'")
            return [row[0] for row in conn.execute(query)]

        universe = tuple(r[0] for r in rows)
        witnesses = [s for s in subsets(universe) if 'module' in evaluate(s)]
        minimal = [s for s in witnesses if not any(set(t) < set(s) for t in witnesses)]
        full, selected = evaluate(universe), evaluate(('a',))
        remaining_full = evaluate(universe, delete_a=True)
        remaining_selected = evaluate(('a',), delete_a=True)
        require(minimal == [('a',), ('b',)] and full == selected == ['module'],
                'Fixed witness/output expectation failed')
        require(remaining_full == ['module'] and remaining_selected == [],
                'Alternative support was not preserved in the full database')
        return dict(subsets_executed=8, minimal_witnesses=[list(s) for s in minimal],
                    full_output=full, selected_output=selected,
                    selected_has_one_witness=True, selected_has_all_witnesses=False,
                    after_delete_full=remaining_full, after_delete_selected=remaining_selected)
    finally:
        conn.close()


def n03() -> dict:
    domain = (0, 1, 2, 3)
    functions = list(itertools.product((0, 1), repeat=4))

    def direct(values: tuple[int, ...], observed: tuple[int, ...]) -> str:
        if any(values[i] == 1 for i in observed):
            return 'FALSE'
        return 'TRUE' if set(observed) == set(domain) else 'UNKNOWN'

    def oracle(values: tuple[int, ...], observed: tuple[int, ...]) -> str:
        completions = [g for g in functions if all(g[i] == values[i] for i in observed)]
        propositions = {all(v == 0 for v in g) for g in completions}
        if propositions == {True}:
            return 'TRUE'
        if propositions == {False}:
            return 'FALSE'
        return 'UNKNOWN'

    counts: Counter = Counter()
    disagreements, false_certifications, total = [], 0, 0
    for f, tested in itertools.product(functions, subsets(domain)):
        total += 1
        got, expected = direct(f, tested), oracle(f, tested)
        counts[got] += 1
        if got != expected:
            disagreements.append([f, tested, got, expected])
        if all(f[i] == 0 for i in tested) and any(f):
            false_certifications += 1
    require(total == 256 and not disagreements, 'Oracle disagreement')
    require(dict(counts) == {'TRUE': 1, 'FALSE': 175, 'UNKNOWN': 80}, 'Verdict counts differ')
    require(false_certifications == 65, 'False green-certification count differs')
    probe = (0, 0, 0, 1)
    require(direct(probe, (0, 1, 2)) == 'UNKNOWN' and direct(probe, domain) == 'FALSE',
            'Selected tests were confused with complete coverage')
    require(direct((0, 0, 0, 0), domain) == 'TRUE', 'Bounded valid certification lost')
    return dict(comparisons=total, disagreements=disagreements, verdict_counts=dict(counts),
                naive_false_certifications=false_certifications,
                probe_before='UNKNOWN', probe_after='FALSE', full_zero_certified=True)


def run() -> dict:
    observations, cases = {}, []
    for fn in (n01, n02, n03):
        key = fn.__name__.upper()
        try:
            observations[key] = fn()
            cases.append(dict(id=key, passed=True, observed=observations[key]))
        except Exception as exc:
            cases.append(dict(id=key, passed=False, error=f'{type(exc).__name__}: {exc}'))
    controls = []
    predicates = [
        ('action_implies_reason', lambda: observations['N01']['exact_reason_preserved']),
        ('one_witness_implies_all', lambda: observations['N02']['selected_has_all_witnesses']),
        ('all_green_certifies', lambda: observations['N03']['naive_false_certifications'] == 0),
    ]
    for name, false_rule in predicates:
        try:
            controls.append(dict(id=name, rejected=not false_rule()))
        except Exception as exc:
            controls.append(dict(id=name, rejected=False, error=str(exc)))
    here = Path(__file__).resolve()
    return dict(scope='Three finite same-author cases, not live or independent validation',
                python=platform.python_version(), sqlite=sqlite3.sqlite_version,
                script_sha256=hashlib.sha256(here.read_bytes()).hexdigest(),
                spec_sha256=hashlib.sha256(here.with_name('SPEC.md').read_bytes()).hexdigest(),
                cases=cases, controls=controls,
                all_passed=all(c['passed'] for c in cases) and all(c['rejected'] for c in controls))


if __name__ == '__main__':
    result = run()
    output = Path(__file__).with_name('RESULT.json')
    output.write_text(json.dumps(result, sort_keys=True, indent=2) + '\n', encoding='utf-8')
    print(json.dumps({'all_passed': result['all_passed'], 'cases': len(result['cases']),
                      'controls': len(result['controls']),
                      'result_sha256': hashlib.sha256(output.read_bytes()).hexdigest()}))
    raise SystemExit(0 if result['all_passed'] else 1)
