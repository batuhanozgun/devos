"""Descriptive arithmetic only. No upstream imports, network, models or benchmark runs.

Run: python audit_reported_numbers.py --data REPORTED-DATA.json --output ARITHMETIC.json
Input values are rounded, manually transcribed source claims. Validation protects
this calculation's shape, not the truth, comparability or independence of experiments.
"""
from __future__ import annotations
import argparse
import copy
import hashlib
import json
from decimal import Decimal
from pathlib import Path


def pct(value: object) -> Decimal:
    if isinstance(value, bool):
        raise ValueError('boolean percentage')
    number = Decimal(str(value))
    if not number.is_finite() or not 0 <= number <= 100:
        raise ValueError('percentage must be finite and in [0, 100]')
    return number


def count(value: object) -> int:
    if type(value) is not int or value <= 0:
        raise ValueError('count must be a positive integer')
    return value


def text(value: Decimal) -> str:
    return str(value.quantize(Decimal('0.000001')))


def difference(a: dict, b: dict) -> Decimal:
    if (a['model'], a['scope']) != (b['model'], b['scope']):
        raise ValueError('cross-model or cross-scope subtraction rejected')
    return pct(a['rate']) - pct(b['rate'])


def audit(data: dict) -> dict:
    if data['schema'] != 'u03c-published-aggregate-audit-v1':
        raise ValueError('unexpected input schema')
    comparisons = []
    for group in data['table7']:
        winner = dict(model=group['model'], scope=group['scope'], rate=group['rates']['Meta-Harness'])
        for name, value in group['rates'].items():
            if name == 'Meta-Harness':
                continue
            other = dict(model=group['model'], scope=group['scope'], rate=value)
            comparisons.append({'model': group['model'], 'comparator': name,
                'difference_pp': text(difference(winner, other)),
                'status': 'Difference of reported percentages; not a causal effect or controlled rerun.'})
    artifact = data['artifact_readme']
    n = count(artifact['tasks'])
    r = count(artifact['attempts_per_task'])
    groups = artifact['groups']
    if sum(count(g['tasks']) for g in groups) != n:
        raise ValueError('subgroup counts do not match declared task count')
    weighted = sum(Decimal(g['tasks']) * pct(g['rate_pct']) for g in groups) / n
    demo = data['website_demo']
    count(demo['tasks'])
    return {
        'scope': 'Descriptive calculation over reported aggregates only.',
        'table7_comparisons': comparisons,
        'artifact_readme': {
            'declared_tasks': n, 'declared_attempts_per_task': r,
            'nominal_attempts_if_complete': n*r,
            'weighted_mean_from_rounded_groups_pct': text(weighted),
            'reported_overall_pct': str(pct(artifact['reported_overall_pct'])),
            'equal_group_mean_not_the_reported_task_weighted_metric_pct':
                text(sum(pct(g['rate_pct']) for g in groups) / len(groups)),
            'limit': '445 nominal attempts remain 89 task identities; raw outcomes and coverage not reconstructed.'},
        'separate_website_demo': {'declared_tasks': demo['tasks'],
            'within_demo_difference_pp': text(pct(demo['iteration7_pct']) - pct(demo['baseline_pct'])),
            'limit': 'Not a final full-benchmark gain. Do not join to Table 7 or Appendix A as one run.'},
        'experimental_reproduction': False,
        'statistical_significance_established': False
    }


def self_check(data: dict) -> dict:
    # Fixed elementary oracles; authored by the same researcher, not independent review.
    a = {'model': 'synthetic', 'scope': 'fixture', 'rate': '76.4'}
    b = {'model': 'synthetic', 'scope': 'fixture', 'rate': '74.7'}
    assert difference(a, b) == Decimal('1.7')
    assert Decimal(4)*100 + Decimal(55)*Decimal('81.1') + Decimal(30)*Decimal('64.7') == Decimal('6801.5')
    assert 89*5 == 445
    rejected = []
    bad = copy.deepcopy(data)
    bad['artifact_readme']['groups'][0]['tasks'] = 5
    checks = [
        ('different model', lambda: difference(a, dict(b, model='other'))),
        ('different scope', lambda: difference(a, dict(b, scope='other'))),
        ('nonfinite rate', lambda: pct('NaN')),
        ('incomplete group declaration', lambda: audit(bad)),
    ]
    for label, call in checks:
        try:
            call()
        except ValueError:
            rejected.append(label)
        else:
            raise AssertionError(f'negative input was not rejected: {label}')
    return {'fixed_arithmetic_checks': 3, 'rejected_inputs': rejected,
        'limit': 'Checks this script only; not agent, verifier or model tests.'}


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--data', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    raw = args.data.read_bytes()
    data = json.loads(raw)
    result = audit(data)
    result['input_sha256'] = hashlib.sha256(raw).hexdigest()
    result['self_checks'] = self_check(data)
    args.output.write_text(json.dumps(result, indent=2, ensure_ascii=False) + '\n', encoding='utf-8')


if __name__ == '__main__':
    main()
