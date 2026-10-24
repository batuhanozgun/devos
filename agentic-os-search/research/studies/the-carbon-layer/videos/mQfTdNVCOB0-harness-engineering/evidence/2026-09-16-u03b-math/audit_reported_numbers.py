"""Recompute descriptive comparisons from published, rounded cells.

This is not a benchmark, grader, significance test or historical reproduction.
Only the standard library is used. All paths default to this script's directory.
"""
from __future__ import annotations
import argparse
import copy
import hashlib
import json
from decimal import Decimal
from pathlib import Path

METHODS = ('no_retriever', 'dense_k1', 'dense_k5', 'random_fewshot', 'bm25', 'meta_harness')
EXPECTED_MODELS = ('gpt-5.4-nano', 'gpt-5.4-mini', 'gemini-3.1-flash-lite', 'gemini-3-flash', 'gpt-oss-20b')

def validate(data: dict) -> None:
    models = data['models']
    if tuple(m['id'] for m in models) != EXPECTED_MODELS:
        raise ValueError('Model identities or ordering changed; revisit the source.')
    if [m['used_for_search'] for m in models] != [False, False, False, False, True]:
        raise ValueError('Search-model/transfer grouping differs from paper section 4.2.')
    if set(data['table6']) != set(METHODS):
        raise ValueError('Incomplete or unexpected comparator coverage.')
    for row in data['table6'].values():
        if len(row['cells']) != len(models):
            raise ValueError('Incomplete model cells.')
        for value in row['cells'] + [row['reported_mean']]:
            d = Decimal(value)
            if not d.is_finite() or not Decimal(0) <= d <= Decimal(100):
                raise ValueError('Invalid percentage.')
    for table in ('table10', 'table11'):
        counts = data[table + '_counts']
        if any(type(v) is not int or v < 0 for v in counts.values()):
            raise ValueError('Invalid source counts.')
        if sum(counts.values()) != data[table + '_reported_total']:
            raise ValueError('Source count total mismatch.')

def text(value: Decimal) -> str:
    return format(value.normalize(), 'f')

def mean(values: list[Decimal]) -> Decimal:
    return sum(values, Decimal(0)) / len(values)

def calculate(data: dict) -> dict:
    validate(data)
    rows = {name: list(map(Decimal, data['table6'][name]['cells'])) for name in METHODS}
    selected = rows['meta_harness']
    groups = {'all_five_evaluated': list(range(5)), 'four_not_used_for_search': list(range(4)), 'search_model_only': [4]}
    comparisons = {}
    for name in METHODS[:-1]:
        delta = [a-b for a, b in zip(selected, rows[name])]
        comparisons[name] = {
            'per_model_delta_pp': dict(zip(EXPECTED_MODELS, map(text, delta))),
            'group_mean_delta_pp_from_rounded_cells': {g: text(mean([delta[i] for i in ids])) for g, ids in groups.items()},
            'wins_ties_losses_over_models': [sum(d>0 for d in delta), sum(d==0 for d in delta), sum(d<0 for d in delta)],
            'difference_of_reported_all_model_means_pp': text(Decimal(data['table6']['meta_harness']['reported_mean']) - Decimal(data['table6'][name]['reported_mean']))
        }
    return {
        'kind': 'descriptive arithmetic on author-reported rounded cells',
        'method_means_from_rounded_cells': {n: {g: text(mean([v[i] for i in ids])) for g, ids in groups.items()} for n,v in rows.items()},
        'meta_harness_minus_comparator': comparisons,
        'table10_count_sum': sum(data['table10_counts'].values()),
        'table11_count_sum': sum(data['table11_counts'].values()),
        'table11_task_count_shares_not_verified_score_weights': {k: text(Decimal(v)/Decimal(data['table11_reported_total'])) for k,v in data['table11_counts'].items()},
        'interpretation_limits': ['Displayed cells are rounded; small differences are not statistically established.', 'Model-wise wins are not problem-wise wins.', 'Three responses to a problem are not three independent tasks or pass@3.', 'A four-model subset calculation is descriptive, not a new experiment.', 'Counts do not establish effective corpus eligibility, score weights, decontamination or proof correctness.']
    }

def self_check(data: dict) -> dict:
    out = calculate(data)
    # Independently specified expected arithmetic, fixed before this execution.
    c = out['meta_harness_minus_comparator']
    assert c['no_retriever']['group_mean_delta_pp_from_rounded_cells']['all_five_evaluated'] == '4.66'
    assert c['dense_k5']['group_mean_delta_pp_from_rounded_cells']['four_not_used_for_search'] == '-0.1'
    assert c['dense_k5']['group_mean_delta_pp_from_rounded_cells']['search_model_only'] == '3.9'
    bad_cases = []
    bad = copy.deepcopy(data); bad['table6']['bm25']['cells'].pop(); bad_cases.append(('missing_cell', bad))
    bad = copy.deepcopy(data); bad['models'][-1]['used_for_search'] = False; bad_cases.append(('wrong_transfer_group', bad))
    bad = copy.deepcopy(data); bad['table11_counts']['IMO-ProofBench'] = 59; bad_cases.append(('wrong_population_total', bad))
    rejected = []
    for label, bad in bad_cases:
        try:
            calculate(bad)
        except ValueError:
            rejected.append(label)
        else:
            raise AssertionError(f'Negative fixture accepted: {label}')
    return {'fixed_arithmetic_assertions': 3, 'invalid_inputs_rejected': rejected, 'scope': 'Only this local arithmetic/validation program; not research efficacy.'}

def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    root = Path(__file__).resolve().parent
    parser.add_argument('--input', type=Path, default=root/'REPORTED-DATA.json')
    parser.add_argument('--output', type=Path, default=root/'ARITHMETIC.json')
    args = parser.parse_args()
    source_bytes = args.input.read_bytes()
    data = json.loads(source_bytes)
    result = calculate(data)
    result['self_check'] = self_check(data)
    result['input_sha256'] = hashlib.sha256(source_bytes).hexdigest()
    result['script_sha256'] = hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
    args.output.write_text(json.dumps(result, ensure_ascii=False, indent=2)+'\n', encoding='utf-8')
    print(json.dumps(result, ensure_ascii=False, indent=2))

if __name__ == '__main__':
    main()
