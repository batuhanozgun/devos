"""Bounded M5 checks. Python 3.10+, standard library, no network or remote repository writes.
Run directly; writes RESULT.json beside this file, including failures, and exits nonzero.
Sources and pre-execution expectations are in SPEC.md. Not a hierarchy oracle.
"""
from __future__ import annotations
import hashlib
import itertools
import json
import platform
from pathlib import Path
from typing import Callable

World = tuple[int, ...]
Predicate = Callable[[World, World], bool]
RANK_WORLDS = ('00', '01', '10', '11')


def require(ok: bool, message: str) -> None:
    if not ok:
        raise AssertionError(message)


def powerset(n: int) -> list[frozenset[int]]:
    return [frozenset(c) for k in range(n + 1)
            for c in itertools.combinations(range(n), k)]


def revise(ranks: tuple[int, ...], admitted: frozenset[int]) -> tuple[int, ...]:
    if len(ranks) != 4 or min(ranks) != 0 or any(x < 0 for x in ranks):
        raise ValueError('Expected four nonnegative ranks with minimum zero')
    if not admitted or not admitted <= set(range(4)):
        raise ValueError('Admitted set must be a nonempty subset of the four worlds')
    best = min(ranks[i] for i in admitted)
    return tuple((0 if rank == best else rank) if i in admitted else rank + 1
                 for i, rank in enumerate(ranks))


def beliefs(ranks: tuple[int, ...]) -> list[str]:
    return [RANK_WORLDS[i] for i, rank in enumerate(ranks) if rank == 0]


def extensions(n: int, old: Callable[[World], bool], u: Predicate,
               v: Predicate) -> dict[frozenset[int], frozenset[World]]:
    """Finite model projection of Definition 1. V filters consistency, not conclusions."""
    worlds = list(itertools.product((0, 1), repeat=n))
    pairs = [(o, new) for o in worlds for new in worlds if old(o) and u(o, new)]
    def agreeing(o: World, new: World, eq: frozenset[int]) -> bool:
        return all(o[i] == new[i] for i in eq)
    feasible = [eq for eq in powerset(n)
                if any(agreeing(o, new, eq) and v(o, new) for o, new in pairs)]
    maximal = [eq for eq in feasible if not any(eq < other for other in feasible)]
    return {eq: frozenset(new for o, new in pairs if agreeing(o, new, eq))
            for eq in maximal}


def view(result: dict[frozenset[int], frozenset[World]], atoms: str) -> list[dict]:
    return [dict(retained=[atoms[i] for i in sorted(eq)],
                 models=sorted(''.join(map(str, w)) for w in models))
            for eq, models in sorted(result.items(), key=lambda item: tuple(sorted(item[0])))]


def d01() -> dict:
    k, pi = (0, 1, 1, 2), (0, 1, 1, 4)
    inputs = [s for s in powerset(4) if s]
    require(len(inputs) == 15, 'Wrong one-step input scope')
    require(all(beliefs(revise(k, s)) == beliefs(revise(pi, s)) for s in inputs),
            'One-step belief profiles differ')
    p, q = frozenset((2, 3)), frozenset((1, 3))
    kp, pp = revise(k, p), revise(pi, p)
    kq, pq = revise(kp, q), revise(pp, q)
    require((kp, pp) == ((1, 2, 0, 2), (1, 2, 0, 4)), 'First ranks mismatch')
    require((kq, pq) == ((2, 0, 1, 0), (2, 0, 1, 4)), 'Second ranks mismatch')
    return dict(one_step_inputs=15, one_step_beliefs_equal=True,
                after_p=[kp, pp], after_p_q=[kq, pq],
                final_beliefs=[beliefs(kq), beliefs(pq)])


def d02() -> dict:
    ex = extensions(2, lambda o: all(o), lambda o, n: not all(n), lambda o, n: True)
    require(ex == {frozenset((0,)): frozenset(((1, 0),)),
                   frozenset((1,)): frozenset(((0, 1),))}, 'Choice extensions mismatch')
    union = frozenset.union(*ex.values())
    intersection = frozenset.intersection(*ex.values())
    require(union == frozenset(((0, 1), (1, 0))) and not intersection,
            'Skeptical/choice model distinction lost')
    return dict(extensions=view(ex, 'pq'), skeptical_models=['01', '10'],
                incorrect_model_intersection=[])


def d03() -> dict:
    output = {}
    for label, condition in [('static', lambda o, n: n[1] == 1),
                              ('mixed_time', lambda o, n: not o[0] or n[1] == 1)]:
        soft = extensions(2, lambda o: o[0] == 1, lambda o, n: True, condition)
        hard = extensions(2, lambda o: o[0] == 1, condition, lambda o, n: True)
        eq = frozenset((0, 1))
        require(soft == {eq: frozenset(((1, 0), (1, 1)))}, 'Consistency projection mismatch')
        require(hard == {eq: frozenset(((1, 1),))}, 'Entailment projection mismatch')
        output[label] = dict(consistency_only=view(soft, 'ab'), required=view(hard, 'ab'))
    return output


def d04() -> dict:
    allowed = {(1, 0, 0), (0, 1, 1)}
    ex = extensions(3, lambda o: all(o), lambda o, n: n in allowed, lambda o, n: True)
    expected = {frozenset((0,)): frozenset(((1, 0, 0),)),
                frozenset((1, 2)): frozenset(((0, 1, 1),))}
    require(ex == expected, 'Inclusion maximal sets mismatch')
    biggest = {eq: models for eq, models in ex.items() if len(eq) == max(map(len, ex))}
    require(set(biggest) == {frozenset((1, 2))}, 'Cardinality selection mismatch')
    return dict(inclusion_maximal=view(ex, 'abc'), maximum_cardinality=view(biggest, 'abc'))


def d05() -> dict:
    pi, p, q = (0, 1, 1, 4), frozenset((2, 3)), frozenset((1, 3))
    once = revise(pi, p)
    three = revise(revise(once, p), p)
    require(once == (1, 2, 0, 4) and three == (3, 4, 0, 4), 'Repeated ranks mismatch')
    require(beliefs(once) == beliefs(three) == ['10'], 'Current beliefs unexpectedly changed')
    require(beliefs(revise(once, q)) == ['01'] and beliefs(revise(three, q)) == ['01', '11'],
            'Expected future divergence absent')
    seen: set[str] = set()
    dedup = pi
    for event in ['e', 'e', 'e']:
        if event not in seen:
            dedup = revise(dedup, p)
            seen.add(event)
    require(dedup == once, 'Declared duplicate admission failed')
    return dict(after_one=once, after_three=three, current_beliefs=['10'],
                next_q_beliefs=[beliefs(revise(once, q)), beliefs(revise(three, q))],
                duplicate_event_admitted_once=dedup)


def run() -> dict:
    cases, data = [], {}
    for fn in (d01, d02, d03, d04, d05):
        name = fn.__name__.upper()
        try:
            data[name] = fn()
            cases.append(dict(id=name, passed=True, observed=data[name]))
        except Exception as exc:
            cases.append(dict(id=name, passed=False, error=f'{type(exc).__name__}: {exc}'))
    rules = [
        ('one_step_profile_suffices', lambda: data['D01']['final_beliefs'][0] == data['D01']['final_beliefs'][1]),
        ('skeptical_intersects_models', lambda: data['D02']['skeptical_models'] == data['D02']['incorrect_model_intersection']),
        ('consistent_means_required', lambda: data['D03']['static']['consistency_only'] == data['D03']['static']['required']),
        ('inclusion_means_cardinality', lambda: data['D04']['inclusion_maximal'] == data['D04']['maximum_cardinality']),
        ('same_answer_inert_repetition', lambda: data['D05']['next_q_beliefs'][0] == data['D05']['next_q_beliefs'][1]),
    ]
    controls = []
    for name, rule in rules:
        try:
            controls.append(dict(id=name, rejected=not rule()))
        except Exception as exc:
            controls.append(dict(id=name, rejected=False, error=str(exc)))
    here = Path(__file__).resolve().parent
    return dict(scope='Five finite M5 checks and same-fixture false-rule controls; not live or independent taxonomy validation',
                python=platform.python_version(),
                spec_sha256=hashlib.sha256((here / 'SPEC.md').read_bytes()).hexdigest(),
                script_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
                cases=cases, negative_controls=controls,
                all_passed=all(c['passed'] for c in cases) and all(c['rejected'] for c in controls))


if __name__ == '__main__':
    result = run()
    dest = Path(__file__).with_name('RESULT.json')
    dest.write_text(json.dumps(result, ensure_ascii=False, sort_keys=True, indent=2) + '\n', encoding='utf-8')
    print(json.dumps(dict(cases=len(result['cases']), negative_controls=len(result['negative_controls']),
                         all_passed=result['all_passed'],
                         result_sha256=hashlib.sha256(dest.read_bytes()).hexdigest())))
    raise SystemExit(0 if result['all_passed'] else 1)
