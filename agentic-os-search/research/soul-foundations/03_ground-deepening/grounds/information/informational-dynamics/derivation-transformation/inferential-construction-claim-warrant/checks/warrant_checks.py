#!/usr/bin/env python3
"""Exact finite examples, not a general inference or warrant validator.

Run: python warrant_checks.py > RESULT.json
Every source world, distribution and acceptance rule is synthetic and explicit.
"""
from __future__ import annotations

import hashlib
import itertools
import json
import platform
from fractions import Fraction as F
from pathlib import Path
from typing import Callable, Iterable

World = dict[str, bool]


def worlds(*names: str) -> list[World]:
    return [dict(zip(names, values)) for values in itertools.product((False, True), repeat=len(names))]


def entails(models: list[World], claim: Callable[[World], bool]) -> bool:
    """Classical model entailment, intentionally including its vacuous case."""
    return all(claim(w) for w in models)


def horn(seed: set[str], rules: list[tuple[str, str]], rounds: int) -> set[str]:
    result = set(seed)
    for _ in range(rounds):
        # Synchronous application makes the search budget unambiguous.
        new = {conclusion for premise, conclusion in rules if premise in result}
        result |= new
    return result


def posterior(prior: F, likelihood: F, false_positive: F) -> F:
    denominator = prior * likelihood + (1 - prior) * false_positive
    if denominator == 0:
        raise ValueError('Conditioning event has zero probability')
    return prior * likelihood / denominator


def support_status(alert: bool, defeater: bool, alternative: bool, contrary: bool) -> str:
    """One stipulated four-status default example; not a universal semantics."""
    positive = (alert and not defeater) or alternative
    if positive and contrary:
        return 'contested'
    if positive:
        return 'supported'
    return 'contrary-supported' if contrary else 'unsettled'


def probability_of(dist: dict[tuple[bool, ...], F], predicate: Callable[[tuple[bool, ...]], bool]) -> F:
    assert sum(dist.values(), F(0)) == 1
    assert all(p >= 0 for p in dist.values())
    return sum((p for state, p in dist.items() if predicate(state)), F(0))


def main() -> dict:
    cases: list[dict] = []
    controls: list[dict] = []

    def record(cid: str, **observed: object) -> None:
        cases.append({'id': cid, 'status': 'PASS', 'observed': observed})

    def reject(cid: str, false_value: object, expected: object, witness: object) -> None:
        if false_value == expected:
            raise AssertionError(f'{cid}: declared false rule was not discriminated')
        controls.append({'id': cid, 'status': 'REJECTED', 'false_rule_value': false_value,
                         'fixture_correct_value': expected, 'witness': witness})

    pq = worlds('p', 'q')
    conditional = [w for w in pq if not w['p'] or w['q']]
    with_p = [w for w in conditional if w['p']]
    assert entails(with_p, lambda w: w['q'])
    assert not entails(conditional, lambda w: w['q'])
    witness = next(w for w in conditional if not w['q'])
    record('C01', conditional_only_entails_q=False, with_p_entails_q=True, countermodel=witness)
    reject('N01_missing_premise', True, False, witness)

    inconsistent = [w for w in pq if w['p'] and not w['p']]
    assert not inconsistent
    assert entails(inconsistent, lambda w: w['q']) and entails(inconsistent, lambda w: not w['q'])
    record('C02', compatible_model_count=0, classical_entails_q=True,
           classical_entails_not_q=True, factual_warrant='not established: inconsistent basis')

    chain = [('a', 'b'), ('b', 'c')]
    one = horn({'a'}, chain, 1)
    two = horn({'a'}, chain, 2)
    assert 'c' not in one and 'c' in two
    record('C03', one_round=sorted(one), two_rounds=sorted(two), after_one_round='search incomplete, not negation')
    reject('N02_failed_search_as_negation', 'not-c established', 'search incomplete', {'two_round_derivation': sorted(two)})

    prior, hit, false_positive = F(1, 100), F(9, 10), F(1, 10)
    post = posterior(prior, hit, false_positive)
    changed_prior = posterior(F(1, 2), hit, false_positive)
    true_alerts, false_alerts = 90, 990
    count_check = F(true_alerts, true_alerts + false_alerts)
    assert post == F(1, 12) == count_check and changed_prior == F(9, 10)
    record('C04', likelihood=hit, posterior=post, changed_prior_posterior=changed_prior,
           count_population=10000, true_alerts=true_alerts, false_alerts=false_alerts)
    reject('N03_probability_reversal', hit, post, {'count_check': count_check})

    duplicate = posterior(prior, hit, false_positive)  # E and the very same E
    independent = posterior(prior, hit**2, false_positive**2)
    assert duplicate == F(1, 12) and independent == F(9, 20)
    record('C05', duplicate_alert_posterior=duplicate, conditionally_independent_pair_posterior=independent)
    reject('N04_duplicates_as_independence', independent, duplicate, 'The second report repeats the same event E')

    observed_direct = [(u, u) for u in (0, 1)]  # X=U; Y=X
    observed_confound = [(u, u) for u in (0, 1)]  # X=U; Y=U
    direct_do = {x: F(sum(x for u in (0, 1)), 2) for x in (0, 1)}
    confound_do = {x: F(sum(u for u in (0, 1)), 2) for x in (0, 1)}
    effects = [direct_do[1] - direct_do[0], confound_do[1] - confound_do[0]]
    assert observed_direct == observed_confound and effects == [1, 0]
    record('C06', shared_observational_support=observed_direct, perfect_prediction='Y=X in both observational models',
           direct_do_means=direct_do, confounded_do_means=confound_do, intervention_effects=effects)
    reject('N05_prediction_as_causal_identification', 'unique effect 1', 'effect not identified: {0,1}',
           {'same_observation': observed_direct, 'effects': effects})

    compatible_h = [w['h'] for w in worlds('h')]
    before = support_status(True, False, False, False)
    defeated = support_status(True, True, False, False)
    alternate = support_status(True, True, True, False)
    contrary = support_status(True, True, False, True)
    conflict = support_status(True, False, False, True)
    assert [before, defeated, alternate, contrary, conflict] == ['supported', 'unsettled', 'supported', 'contrary-supported', 'contested']
    assert set(compatible_h) == {False, True}
    record('C07', original=before, undercut=defeated, alternative_route=alternate,
           contrary_route=contrary, conflict=conflict, h_values_after_undercut=compatible_h)
    reject('N06_undercut_as_negation', [False], compatible_h, 'No supplied statement settles H or not-H after this support route fails')

    cycle = [('a', 'b'), ('b', 'a')]
    unseeded, seeded = horn(set(), cycle, 10), horn({'a'}, cycle, 10)
    assert not unseeded and seeded == {'a', 'b'}
    record('C08', unseeded_closure=sorted(unseeded), seeded_closure=sorted(seeded), seed_truth='not tested')

    grid = range(1, 21)
    crossings = sum(any(value == 1 for value in sample) for sample in itertools.product(grid, repeat=4))
    selected_prob = F(crossings, 20**4)
    formula = 1 - F(19, 20)**4
    assert selected_prob == formula == F(29679, 160000)
    record('C09', single_test_probability=F(1, 20), exhaustive_population=20**4,
           selected_crossings=crossings, family_probability=selected_prob, formula=formula)
    reject('N07_per_test_as_family', F(1, 20), selected_prob, {'independent_null_tests': 4})

    group_a = [True] * 5
    group_b = [True] * 3 + [False] * 2
    overall = F(sum(group_a + group_b), 10)
    accuracies = [F(sum(group_a), 5), F(sum(group_b), 5)]
    assert overall == F(4, 5) and accuracies == [F(1), F(3, 5)]
    record('C10', reported_confidence=F(4, 5), population_accuracy=overall,
           group_accuracies=accuracies, meaning='exact uniform finite-population example')
    reject('N08_global_as_subgroup_calibration', [F(4, 5), F(4, 5)], accuracies, {'group_correct_counts': [5, 3], 'group_sizes': [5, 5]})

    lower = {(True, True, True): F(7, 10), (False, True, True): F(1, 10),
             (True, False, True): F(1, 10), (True, True, False): F(1, 10)}
    upper = {(True, True, True): F(9, 10), (False, False, False): F(1, 10)}
    independent_dist = {bits: (F(9, 10)**sum(bits)) * (F(1, 10)**(3-sum(bits)))
                        for bits in itertools.product((False, True), repeat=3)}
    for dist in (lower, upper, independent_dist):
        assert [probability_of(dist, lambda bits, i=i: bits[i]) for i in range(3)] == [F(9, 10)] * 3
    joints = [probability_of(dist, all) for dist in (lower, upper, independent_dist)]
    assert joints == [F(7, 10), F(9, 10), F(729, 1000)]
    record('C11', shared_marginals=[F(9, 10)] * 3, joint_lower_upper_independent=joints)

    belief = F(4, 5)
    def expected_actions(false_positive_cost: int, false_negative_cost: int) -> dict[str, F]:
        return {'act': (1-belief)*false_positive_cost, 'wait': belief*false_negative_cost}
    costs_a, costs_b = expected_actions(1, 1), expected_actions(10, 1)
    decisions = [min(costs_a, key=costs_a.get), min(costs_b, key=costs_b.get)]
    assert decisions == ['act', 'wait']
    record('C12', same_posterior=belief, first_losses=costs_a, second_losses=costs_b,
           different_decisions=decisions, operational_authority='not conferred by this calculation')

    assert len(cases) == 12 and len(controls) == 8
    here = Path(__file__).resolve()
    return {'schema': 'soul-warrant-finite-checks-v1', 'runtime': {'python': platform.python_version()},
            'script_sha256': hashlib.sha256(here.read_bytes()).hexdigest(),
            'spec_sha256': hashlib.sha256(here.with_name('SPEC.md').read_bytes()).hexdigest(),
            'scope': 'same-author synthetic finite checks; no live SOUL/LLM/empirical or independent taxonomy validation',
            'cases_passed': len(cases), 'false_rules_rejected': len(controls),
            'cases': cases, 'false_rule_controls': controls}


if __name__ == '__main__':
    def encode(value: object) -> str:
        if isinstance(value, F):
            return str(value)
        raise TypeError(f'Unexpected value {type(value)!r}')
    print(json.dumps(main(), ensure_ascii=False, indent=2, sort_keys=True, default=encode))
