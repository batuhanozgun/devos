"""Six finite adequacy checks, standard library, Python 3.10+.
No network or remote writes. Writes sibling RESULT.json, including failures.
The specification preceded execution. This is not a taxonomy or live-agent oracle.
"""
from __future__ import annotations

import hashlib
import itertools
import json
import platform
from collections import defaultdict
from fractions import Fraction as F
from functools import lru_cache
from pathlib import Path


def require(ok: bool, message: str) -> None:
    if not ok:
        raise AssertionError(message)


def partitions(n: int) -> list[tuple[int, ...]]:
    """Canonical restricted-growth labels; one per set partition."""
    if n < 1:
        raise ValueError('n must be positive')
    labels = [(0,)]
    for _ in range(n - 1):
        labels = [prefix + (j,) for prefix in labels for j in range(max(prefix) + 2)]
    return labels


def cells(labels: tuple) -> list[list[int]]:
    grouped = defaultdict(list)
    for state, label in enumerate(labels):
        grouped[label].append(state)
    return list(grouped.values())


def common_optimal(losses: tuple, labels: tuple) -> bool:
    for cell in cells(labels):
        common = set(range(len(losses[0])))
        for w in cell:
            common &= {a for a, value in enumerate(losses[w]) if value == min(losses[w])}
        if not common:
            return False
    return True


def policy_exists(losses: tuple, labels: tuple) -> bool:
    # Different calculation: enumerate all view-to-action functions.
    for policy in itertools.product(range(len(losses[0])), repeat=max(labels) + 1):
        if all(losses[w][policy[label]] <= value
               for w, label in enumerate(labels) for value in losses[w]):
            return True
    return False


def worst_regret(losses: tuple, labels: tuple) -> F:
    return max(min(max(F(losses[w][a]) - min(losses[w]) for w in cell)
                   for a in range(len(losses[0]))) for cell in cells(labels))


def k01() -> dict:
    views, count, disagreements = partitions(4), 0, 0
    require(len(views) == len(set(views)) == 15, 'Partition enumeration mismatch')
    for bits in itertools.product((0, 1), repeat=8):
        losses = tuple(tuple(bits[2*w:2*w+2]) for w in range(4))
        for view in views:
            count += 1
            disagreements += common_optimal(losses, view) != policy_exists(losses, view)
    tied = ((0, 0, 1), (1, 0, 0))
    winners = [{a for a, loss in enumerate(row) if loss == min(row)} for row in tied]
    require(count == 3840 and disagreements == 0, 'Finite criterion comparison failed')
    require(common_optimal(tied, (0, 0)) and winners[0] != winners[1], 'Tie case lost')
    return dict(comparisons=count, disagreements=disagreements, partitions=len(views),
                tie_common=sorted(set.intersection(*winners)), tie_sets_equal=winners[0] == winners[1])


def k02() -> dict:
    view, full = (0, 0, 1, 1), (0, 1, 2, 3)
    class_loss = tuple(tuple(int(a != int(w >= 2)) for a in (0, 1)) for w in range(4))
    parity_loss = tuple(tuple(int(a != w % 2) for a in (0, 1)) for w in range(4))
    values = (worst_regret(class_loss, view), worst_regret(parity_loss, view),
              worst_regret(parity_loss, full))
    require(values == (0, 1, 0), 'Use-change regret mismatch')
    return dict(regrets=values, cell_sizes=[len(c) for c in cells(view)],
                exact_state_identified=False, first_use_adequate=True, second_use_adequate=False)


def k03() -> dict:
    prior, losses = (F(99, 100), F(1, 100)), ((0, 2), (10, 0))
    expected = tuple(sum(prior[w] * losses[w][a] for w in range(2)) for a in range(2))
    worst = tuple(max(losses[w][a] - min(losses[w]) for w in range(2)) for a in range(2))
    require(expected == (F(1, 10), F(99, 50)) and worst == (10, 2), 'Risk comparison mismatch')
    require(worst_regret(losses, (0, 0)) == 2 and worst_regret(losses, (0, 1)) == 0,
            'Regret tolerance mismatch')
    return dict(expected=expected, worst_regrets=worst, expected_winner='A',
                deterministic_minimax_winner='B', feasible_at_two=True, feasible_at_one=False)


def k04() -> dict:
    worlds = list(itertools.product((0, 1), repeat=2))
    def utility(indices: tuple[int, ...]) -> F:
        groups = defaultdict(list)
        for w in worlds:
            groups[tuple(w[i] for i in indices)].append(w[0] ^ w[1])
        return sum(F(max(values.count(0), values.count(1)), len(worlds)) for values in groups.values())
    choices = ((), (0,), (1,), (0, 1))
    gross = tuple(utility(choice) for choice in choices)
    net = tuple(value - F(len(choice), 10) for choice, value in zip(choices, gross))
    require(gross == (F(1, 2), F(1, 2), F(1, 2), F(1)), 'XOR utility mismatch')
    require(net == (F(1, 2), F(2, 5), F(2, 5), F(4, 5)), 'XOR cost mismatch')
    return dict(gross=gross, net=net, myopic_stops=net[0] > max(net[1:3]), joint_gain=net[3]-net[0])


def k05() -> dict:
    outcomes = ((F(-3, 2), F(3, 2)), (F(1, 4), F(7, 4)))
    def initial_values(outside: F) -> tuple[F, F, F]:
        def stop(known: tuple) -> F:
            return max(outside, *(known[i] if known[i] is not None else sum(outcomes[i])/2
                                  for i in range(2)))
        def observe(known: tuple, i: int) -> F:
            return -F(1, 5) + sum(value(known[:i]+(x,)+known[i+1:]) for x in outcomes[i])/2
        @lru_cache(None)
        def value(known: tuple) -> F:
            return max([stop(known)] + [observe(known, i) for i in range(2) if known[i] is None])
        initial = (None, None)
        return stop(initial), observe(initial, 0), observe(initial, 1)
    low, mid = initial_values(F(0)), initial_values(F(1))
    require(low == (1, F(21, 20), F(81, 80)), 'Published-model low-context values mismatch')
    require(mid == (1, F(91, 80), F(6, 5)), 'Published-model middle-context values mismatch')
    require(low[1] > low[2] and mid[2] > mid[1], 'Context inversion missing')
    return dict(lambda_zero=low, lambda_one=mid, preferred_observations=[1, 2])


def k06() -> dict:
    worlds = list(itertools.product((0, 1), repeat=3))
    target = lambda w: w[1] if w[0] == 0 else w[2]
    def exact(indices: tuple[int, ...]) -> bool:
        return all(target(w) == target(v) for w in worlds for v in worlds
                   if all(w[i] == v[i] for i in indices))
    fixed = [choice for n in range(3) for choice in itertools.combinations(range(3), n)]
    adequate = [choice for choice in fixed if exact(choice)]
    paths = []
    for w in worlds:
        indices = (0, 1 if w[0] == 0 else 2)
        inferred = w[indices[1]]
        paths.append(dict(world=w, read=indices, inferred=inferred, correct=inferred == target(w)))
    require(len(fixed) == 7 and adequate == [] and exact((0, 1, 2)), 'Fixed-bundle expectation failed')
    require(all(p['correct'] and len(p['read']) == 2 for p in paths), 'Adaptive policy failed')
    return dict(fixed_subsets_checked=len(fixed), adequate_fixed=adequate,
                all_three_adequate=True, adaptive_paths=paths, adaptive_all_correct=True)


def run() -> dict:
    cases, data = [], {}
    for fn in (k01, k02, k03, k04, k05, k06):
        name = fn.__name__.upper()
        try:
            data[name] = fn()
            cases.append(dict(id=name, passed=True, observed=data[name]))
        except Exception as exc:
            cases.append(dict(id=name, passed=False, error=f'{type(exc).__name__}: {exc}'))
    rules = [
        ('equal_argmin_sets_required', lambda: data['K01']['tie_sets_equal']),
        ('adequacy_survives_every_use_change', lambda: data['K02']['second_use_adequate']),
        ('expected_loss_meets_worst_tolerance', lambda: data['K03']['worst_regrets'][0] <= 2),
        ('zero_single_gain_means_zero_joint_gain', lambda: data['K04']['joint_gain'] <= 0),
        ('context_independent_information_order', lambda: len(set(data['K05']['preferred_observations'])) == 1),
        ('fixed_infeasibility_proves_adaptive_infeasibility', lambda: not data['K06']['adaptive_all_correct']),
    ]
    controls = []
    for name, predicate in rules:
        try:
            controls.append(dict(id=name, rejected=not predicate()))
        except Exception as exc:
            controls.append(dict(id=name, rejected=False, error=str(exc)))
    here = Path(__file__).resolve()
    return dict(scope='Six finite same-author cases; no live or independent taxonomy verification',
                python=platform.python_version(), script_sha256=hashlib.sha256(here.read_bytes()).hexdigest(),
                spec_sha256=hashlib.sha256(here.with_name('SPEC.md').read_bytes()).hexdigest(),
                cases=cases, controls=controls,
                all_passed=all(c['passed'] for c in cases) and all(c['rejected'] for c in controls))


if __name__ == '__main__':
    result = run()
    dest = Path(__file__).with_name('RESULT.json')
    dest.write_text(json.dumps(result, sort_keys=True, ensure_ascii=False, indent=2,
                               default=lambda value: str(value) if isinstance(value, F) else value) + '\n',
                    encoding='utf-8')
    print(json.dumps(dict(all_passed=result['all_passed'], cases=len(result['cases']),
                         controls=len(result['controls']), result_sha256=hashlib.sha256(dest.read_bytes()).hexdigest())))
    raise SystemExit(0 if result['all_passed'] else 1)
