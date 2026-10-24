#!/usr/bin/env python3
"""Finite semantic-transfer constructions; no natural-language quality oracle."""
from __future__ import annotations

import hashlib
import itertools
import json
import platform
import shutil
import subprocess
import sys
import unicodedata
from collections import Counter
from fractions import Fraction
from pathlib import Path
from typing import Hashable, Sequence


def preserves(keys: Sequence[Hashable], answers: Sequence[object]) -> bool:
    if len(keys) != len(answers):
        raise ValueError("Keys and answers must have equal lengths")
    seen: dict[Hashable, object] = {}
    for key, answer in zip(keys, answers, strict=True):
        if key in seen and seen[key] != answer:
            return False
        seen[key] = answer
    return True


def decoder_exists(keys: Sequence[Hashable], answers: Sequence[int]) -> bool:
    """Separately enumerate all Boolean decoders, without invoking preserves."""
    images = list(dict.fromkeys(keys))
    positions = [images.index(k) for k in keys]
    for candidate in itertools.product((0, 1), repeat=len(images)):
        if all(candidate[j] == a for j, a in zip(positions, answers, strict=True)):
            return True
    return False


def require(condition: bool, message: str) -> None:
    if not condition:
        raise AssertionError(message)


def run() -> dict[str, object]:
    cases: dict[str, object] = {}
    controls: dict[str, object] = {}
    worlds = list(itertools.product((0, 1), repeat=3))
    projected = [w[:2] for w in worlds]
    count = 0
    for q in itertools.product((0, 1), repeat=len(worlds)):
        a, b = preserves(projected, q), decoder_exists(projected, q)
        require(a == b, "C01 calculation paths disagree")
        count += int(a)
    require(count == 16, "C01 wrong preservation count")
    require(not preserves(projected, [w[2] for w in worlds]), "C01 lost bit recovered")
    cases['C01'] = {'worlds': 8, 'questions_checked': 256, 'preserved': count,
                    'lost_bit_preserved': False, 'two_calculation_paths_agree': True}

    source = {(1, 1)}  # completed and blocked, under a stipulated two-bit language
    weak = {(1, 0), (1, 1)}
    ambiguous = {'v1', 'v2'}
    narrowed = {'v1'}
    require(source <= weak and len({x[1] for x in weak}) == 2, "C02 weakening")
    require(not ambiguous <= narrowed, "C02 narrowing")
    cases['C02'] = {'weakening_source_supported': True, 'blocker_answer_unique': False,
                    'narrowing_preserves_permitted_alternatives': False}

    source_roles = [('agent-A', 'reviewer'), ('agent-B', 'approver')]
    swapped_roles = [('agent-A', 'approver'), ('agent-B', 'reviewer')]
    bag_same = Counter(itertools.chain.from_iterable(source_roles)) == Counter(itertools.chain.from_iterable(swapped_roles))
    require(bag_same and dict(source_roles) != dict(swapped_roles), "C03 relation contrast")
    cases['C03'] = {'token_multiset_equal': bag_same, 'role_binding_equal': False}
    controls['token_bag_implies_fidelity'] = {'rejected': bag_same and dict(source_roles) != dict(swapped_roles), 'case': 'C03'}

    def execute_sequence(sequence: list[str]) -> str:
        checked = False
        result = 'not_published'
        for op in sequence:
            if op == 'check':
                checked = True
            elif op == 'publish':
                result = 'checked_publication' if checked else 'unchecked_publication'
            else:
                raise ValueError(op)
        return result
    first, second = ['check', 'publish'], ['publish', 'check']
    require(sorted(first) == sorted(second) and execute_sequence(first) != execute_sequence(second), 'C04 sequence')
    cases['C04'] = {'same_operations': True, 'first_result': execute_sequence(first),
                    'reordered_result': execute_sequence(second)}

    composed, decomposed = '\u00e9', 'e\u0301'
    require(composed != decomposed and unicodedata.normalize('NFC', composed) == unicodedata.normalize('NFC', decomposed), 'C05 NFC')
    superscript, identifier = 'x\u00b2', 'x2'
    require(unicodedata.normalize('NFKC', superscript) == unicodedata.normalize('NFKC', identifier), 'C05 NFKC')
    cases['C05'] = {'canonical_equivalents_NFC_equal': True,
                    'compatibility_inputs': [superscript, identifier], 'NFKC_output': 'x2',
                    'stipulated_exponent_identifier_distinction_lost': True}

    left, right = 'a', '\u0301'
    require(unicodedata.is_normalized('NFC', left) and unicodedata.is_normalized('NFC', right), 'C06 components')
    combined = left + right
    require(not unicodedata.is_normalized('NFC', combined), 'C06 concatenation unexpectedly NFC')
    cases['C06'] = {'components_NFC': True, 'concatenation_NFC': False,
                    'whole_normalized': unicodedata.normalize('NFC', combined)}

    raw_numbers = '[9007199254740992,9007199254740993]'
    integers = json.loads(raw_numbers)
    floats = json.loads(raw_numbers, parse_int=float)
    require(integers[0] != integers[1] and floats[0] == floats[1], 'C07 precision')
    node = shutil.which('node')
    node_result: dict[str, object] = {'available': bool(node)}
    if node:
        expression = "const a=JSON.parse('[9007199254740992,9007199254740993]'); console.log(JSON.stringify({version:process.version,equal:a[0]===a[1],roundtrip:JSON.stringify(a)}));"
        proc = subprocess.run([node, '-e', expression], check=True, capture_output=True, text=True, timeout=15)
        node_result.update(json.loads(proc.stdout))
        require(node_result['equal'] is True, 'C07 native Node did not collapse the pair')
    cases['C07'] = {'source': raw_numbers, 'python_integer_values_distinct': True,
                    'binary64_values_equal': True, 'node': node_result}

    duplicate = '{"status":"blocked","status":"ready"}'
    default = json.loads(duplicate)
    pairs = json.loads(duplicate, object_pairs_hook=list)
    require(default == {'status': 'ready'} and pairs == [('status', 'blocked'), ('status', 'ready')], 'C08 duplicate names')
    cases['C08'] = {'default_mapping': default, 'pair_preserving_output': pairs,
                    'parsed': True, 'default_preserves_both_members': False}
    controls['parsing_implies_preservation'] = {'rejected': len(default) < len(pairs), 'case': 'C08'}

    x, y, t, eps = Fraction(248, 5), Fraction(50), Fraction(50), Fraction(1, 2)
    require(abs(x-y) <= eps and (x >= t) != (y >= t), 'C09 near threshold')
    stable_checks = 0
    for i in range(450, 551):
        a = Fraction(i, 10)
        for j in range(450, 551):
            b = Fraction(j, 10)
            if abs(a-b) <= eps and abs(a-t) > eps:
                require((a >= t) == (b >= t), 'C09 margin theorem failure')
                stable_checks += 1
    cases['C09'] = {'source_value': str(x), 'approximation': str(y), 'tolerance': str(eps),
                    'source_decision': x >= t, 'approximate_decision': y >= t,
                    'margin_condition_cases': stable_checks, 'all_margin_cases_stable': True}
    controls['small_error_preserves_decisions'] = {'rejected': (x >= t) != (y >= t), 'case': 'C09'}

    code = 'A7'
    book_v1, book_v2 = {'A7': 'blocked'}, {'A7': 'ready'}
    require(book_v1[code] != book_v2[code], 'C10 background')
    cases['C10'] = {'code': code, 'intended_v1_meaning': book_v1[code],
                    'wrong_v2_meaning': book_v2[code], 'same_code_bytes': True}

    forward = {'blocked': 'ready', 'ready': 'blocked'}
    backward = {v:k for k,v in forward.items()}
    mid = forward['blocked']
    require(backward[mid] == 'blocked' and mid != 'blocked', 'C11 roundtrip')
    cases['C11'] = {'original': 'blocked', 'intermediate_under_fixed_labels': mid,
                    'roundtrip': backward[mid], 'roundtrip_equal': True, 'intermediate_meaning_correct': False}
    controls['roundtrip_proves_meaning'] = {'rejected': backward[mid] == 'blocked' and mid != 'blocked', 'case': 'C11'}

    first_keys = [w[:2] for w in worlds]
    final_keys = [w[0] for w in worlds]
    q_a, q_b = [w[0] for w in worlds], [w[1] for w in worlds]
    require(preserves(first_keys, q_b) and preserves(final_keys, q_a) and not preserves(final_keys, q_b), 'C12 incompatible chain')
    aligned = [key[1] for key in first_keys]
    require(preserves(aligned, q_b), 'C12 aligned chain')
    cases['C12'] = {'first_preserves_original_b': True, 'second_preserves_own_a': True,
                    'composed_preserves_original_b': False, 'aligned_composition_preserves_b': True}
    controls['local_success_implies_global'] = {'rejected': not preserves(final_keys, q_b), 'case': 'C12'}

    source_record = {'completed': True, 'blocker': True}
    summary_record = {'completed': True}
    output_checks = {k: source_record.get(k) == value for k, value in summary_record.items()}
    task_checks = {k: k in summary_record and summary_record[k] == source_record[k]
                   for k in ('completed', 'blocker')}
    require(all(output_checks.values()) and not all(task_checks.values()), 'C13 verification blind spot')
    cases['C13'] = {'output_generated_checks': output_checks, 'source_task_checks': task_checks}
    controls['output_only_checks_certify_coverage'] = {'rejected': all(output_checks.values()) and not all(task_checks.values()), 'case': 'C13'}

    records = list(itertools.product(('actor-A', 'actor-B'), (0, 1)))
    public = [r[1] for r in records]
    require(preserves(public, [r[1] for r in records]) and not preserves(public, [r[0] for r in records]), 'C14 purpose')
    cases['C14'] = {'public_count_question_preserved': True, 'identity_question_preserved': False,
                    'authority_and_privacy_not_tested': True}

    require(len(cases) == 14 and len(controls) == 6 and all(c['rejected'] for c in controls.values()), 'Control inventory mismatch')
    return {'scope': 'constructed semantic-transfer relations plus native Unicode/JSON checks',
            'environment': {'python': platform.python_version(), 'unicode_database': unicodedata.unidata_version},
            'script_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
            'case_count': len(cases), 'known_bad_count': len(controls), 'cases': cases,
            'known_bad_controls': controls,
            'limits': ['same-author fixtures and semantics', 'no live SOUL or LLM',
                       'no human translation evaluation', 'no universal semantic or privacy verifier',
                       'no independent taxonomy replication']}


if __name__ == '__main__':
    try:
        data = run()
        target = Path(sys.argv[1]) if len(sys.argv) > 1 else Path(__file__).with_name('RESULT.json')
        target.write_text(json.dumps(data, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
        print(json.dumps({'cases': data['case_count'], 'rejected_known_bad': data['known_bad_count'],
                          'result': str(target), 'environment': data['environment']}))
    except (AssertionError, ValueError, OSError, subprocess.SubprocessError) as exc:
        print(f'CHECK FAILED: {exc}', file=sys.stderr)
        raise SystemExit(1) from exc
