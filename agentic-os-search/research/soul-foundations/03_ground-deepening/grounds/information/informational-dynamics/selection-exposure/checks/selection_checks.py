"""Seven finite Selection checks; no network or remote repository writes.
Run with Python 3.10+. Writes sibling RESULT.json, including failures.
E06 uses a temporary local directory for JSON serialization/readback.
"""
from __future__ import annotations

import hashlib
import itertools
import json
import platform
import tempfile
from fractions import Fraction as F
from pathlib import Path

TOPICS = {'a': {'test'}, 'b': {'test'}, 'c': {'risk'}}
PAYLOAD = {'a': 'test=pass', 'b': 'test=pass; source=copy', 'c': 'risk=blocked'}
NEED = {'test', 'risk'}


def require(ok: bool, message: str) -> None:
    if not ok:
        raise AssertionError(message)


def covered(ids: list[str] | tuple[str, ...]) -> set[str]:
    return set().union(*(TOPICS[i] for i in ids))


def adequate(ids: list[str] | tuple[str, ...]) -> bool:
    return NEED <= covered(ids)


def e01() -> dict:
    universe, index = {'a', 'b', 'c'}, {'a', 'b'}
    indexed = sorted(index & {'c'})
    exact = sorted(universe & {'c'})
    absent = sorted(universe & {'z'})
    require(indexed == [] and exact == ['c'] and absent == [], 'Search scope mismatch')
    return dict(indexed=indexed, full=exact, full_absent=absent, c_exists=True, z_exists=False)


def e02() -> dict:
    scores = {'a': F(90, 100), 'b': F(85, 100), 'c': F(60, 100)}
    sim = {frozenset(('a', 'b')): F(95, 100),
           frozenset(('a', 'c')): F(10, 100), frozenset(('b', 'c')): F(10, 100)}
    def rank(weight: F) -> list[str]:
        selected = [max(scores, key=scores.get)]
        while len(selected) < 2:
            remaining = sorted(set(scores) - set(selected))
            def marginal(i: str) -> F:
                return weight * scores[i] - (1 - weight) * max(sim[frozenset((i, j))] for j in selected)
            selected.append(max(remaining, key=marginal))
        return selected
    relevance, mmr = rank(F(1)), rank(F(1, 2))
    require(relevance == ['a', 'b'] and mmr == ['a', 'c'], 'Fixed ranking expectation failed')
    require(not adequate(relevance) and adequate(mmr), 'Coverage difference absent')
    return dict(relevance=relevance, mmr=mmr, both_item_precision=1,
                relevance_coverage=sorted(covered(relevance)), mmr_coverage=sorted(covered(mmr)))


def e03() -> dict:
    def feasible(budget: int, allowed: set[str]) -> list[list[str]]:
        return [list(s) for k in range(3) for s in itertools.combinations(('a', 'c'), k)
                if len(s) <= budget and set(s) <= allowed and adequate(s)]
    low, enough, restricted = feasible(1, {'a', 'c'}), feasible(2, {'a', 'c'}), feasible(2, {'a'})
    require(low == [] and enough == [['a', 'c']] and restricted == [], 'Feasible-family mismatch')
    require(not adequate(['a']), 'Best effort unexpectedly sufficient')
    return dict(budget_one=low, budget_two=enough, restricted=restricted, best_effort_adequate=False)


def e04() -> dict:
    versions = {'v1': 'mode=SAFE; allow=NO', 'v2': 'NOTE; mode=SAFE; allow=NO'}
    bound = versions['v1'][5:9]
    unbound = versions['v2'][5:9]
    text, quote = 'SAFE|SAFE', 'SAFE'
    matches = [i for i in range(len(text)) if text.startswith(quote, i)]
    require(bound == 'SAFE' and unbound == ' mod' and matches == [0, 5], 'Selector identity mismatch')
    return dict(bound=bound, unbound=unbound, quote_matches=matches)


def e05() -> dict:
    schemas = [('s1', 1, 1), ('s2', 2, 3)]  # id, version, recorded time
    reports = [('r1', 1, 4)]                # id, required schema, recorded time
    newest = (max(schemas, key=lambda x: x[2]), max(reports, key=lambda x: x[2]))
    compatible = [[s[0], r[0]] for s in schemas for r in reports if s[1] == r[1]]
    require([newest[0][0], newest[1][0]] == ['s2', 'r1'], 'Newest pair mismatch')
    require(newest[0][1] != newest[1][1] and compatible == [['s1', 'r1']], 'Coherence distinction absent')
    return dict(newest=['s2', 'r1'], newest_compatible=False, compatible=compatible)


def e06() -> dict:
    observations = []
    with tempfile.TemporaryDirectory(prefix='selection-fixture-') as directory:
        for ids, materialized in itertools.product((['a', 'c'], ['a', 'b']), (True, False)):
            message = {'recipient': 'worker', 'items': [
                {'id': i, **({'content': PAYLOAD[i]} if materialized else {'uri': 'local:' + i})} for i in ids]}
            path = Path(directory) / 'message.json'
            path.write_text(json.dumps(message), encoding='utf-8')
            received = json.loads(path.read_text(encoding='utf-8'))
            contents = {item['id']: item.get('content') for item in received['items']}
            exposed = received['recipient'] == 'worker' and contents == {i: PAYLOAD[i] for i in ids}
            observations.append(dict(ids=ids, selected_adequate=adequate(ids), exact_exposure=exposed,
                                     ids_present=[item['id'] for item in received['items']] == ids))
    pairs = {(r['selected_adequate'], r['exact_exposure']) for r in observations}
    require(pairs == {(True, True), (True, False), (False, True), (False, False)}, 'Independent predicates lost')
    require(all(r['ids_present'] for r in observations), 'Locator control did not preserve IDs')
    return dict(observations=observations)


def e07() -> dict:
    prior, enlarged = ['a', 'c'], ['a', 'b', 'c']
    actual_prior, actual_enlarged = prior[:2], enlarged[:2]
    require(adequate(prior) and adequate(enlarged), 'Planned coverage wrong')
    require(adequate(actual_prior) and not adequate(actual_enlarged), 'Budget effect absent')
    return dict(planned_prior=prior, planned_enlarged=enlarged,
                actual_prior=actual_prior, actual_enlarged=actual_enlarged,
                actual_adequacy=[True, False])


def run() -> dict:
    data, cases = {}, []
    for fn in (e01, e02, e03, e04, e05, e06, e07):
        key = fn.__name__.upper()
        try:
            data[key] = fn()
            cases.append(dict(id=key, passed=True, observed=data[key]))
        except Exception as exc:
            cases.append(dict(id=key, passed=False, error=f'{type(exc).__name__}: {exc}'))
    false_rules = [
        ('index_miss_proves_absence', lambda: not data['E01']['c_exists']),
        ('precision_proves_set_adequacy', lambda: data['E02']['relevance_coverage'] == sorted(NEED)),
        ('best_effort_is_sufficient', lambda: data['E03']['best_effort_adequate']),
        ('unbound_selector_is_unique', lambda: data['E04']['bound'] == data['E04']['unbound'] and len(data['E04']['quote_matches']) == 1),
        ('newest_is_coherent', lambda: data['E05']['newest_compatible']),
        ('ids_prove_exposure', lambda: all(r['exact_exposure'] for r in data['E06']['observations'] if r['ids_present'])),
        ('larger_bundle_preserves_coverage', lambda: data['E07']['actual_adequacy'][1]),
    ]
    controls = []
    for name, predicate in false_rules:
        try:
            controls.append(dict(id=name, rejected=not predicate()))
        except Exception as exc:
            controls.append(dict(id=name, rejected=False, error=str(exc)))
    here = Path(__file__).resolve()
    return dict(scope='Seven finite cases and seven same-fixture false rules; not independent or live validation',
                python=platform.python_version(), script_sha256=hashlib.sha256(here.read_bytes()).hexdigest(),
                spec_sha256=hashlib.sha256(here.with_name('SPEC.md').read_bytes()).hexdigest(),
                cases=cases, controls=controls,
                all_passed=all(c['passed'] for c in cases) and all(c['rejected'] for c in controls))


if __name__ == '__main__':
    result = run()
    dest = Path(__file__).with_name('RESULT.json')
    dest.write_text(json.dumps(result, sort_keys=True, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
    print(json.dumps({'all_passed': result['all_passed'], 'cases': len(result['cases']),
                      'controls': len(result['controls']), 'result_sha256': hashlib.sha256(dest.read_bytes()).hexdigest()}))
    raise SystemExit(0 if result['all_passed'] else 1)
