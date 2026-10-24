"""Finite Selection/Exposure integration diagnostics; standard library only."""
from __future__ import annotations

import argparse
import itertools
import json
import platform
from pathlib import Path
from typing import Hashable, Sequence


def require(condition: bool, message: str) -> None:
    if not condition:
        raise AssertionError(message)


def cells(observations: Sequence[Hashable]) -> list[list[int]]:
    grouped: dict[Hashable, list[int]] = {}
    for index, observation in enumerate(observations):
        grouped.setdefault(observation, []).append(index)
    return list(grouped.values())


def intersection_criterion(observations: Sequence[Hashable], acceptable: Sequence[set[int]]) -> bool:
    if len(observations) != len(acceptable) or not observations:
        raise ValueError("Expected matching, nonempty world-indexed inputs")
    for cell in cells(observations):
        common = {0, 1}
        for world in cell:
            common &= acceptable[world]
        if not common:
            return False
    return True


def enumerate_policies(observations: Sequence[Hashable], acceptable: Sequence[set[int]]) -> bool:
    # A second computation route: enumerate all binary output functions.
    labels = list(dict.fromkeys(observations))
    for outputs in itertools.product((0, 1), repeat=len(labels)):
        policy = dict(zip(labels, outputs))
        if all(policy[label] in acceptable[w] for w, label in enumerate(observations)):
            return True
    return False


def partitions(n: int) -> list[tuple[int, ...]]:
    if n < 1:
        raise ValueError("n must be positive")
    result: list[tuple[int, ...]] = []

    def extend(prefix: tuple[int, ...]) -> None:
        if len(prefix) == n:
            result.append(prefix)
            return
        for label in range(max(prefix) + 2):
            extend(prefix + (label,))

    extend((0,))
    return result


def checked_adequacy(observations: Sequence[Hashable], acceptable: Sequence[set[int]]) -> bool:
    first = intersection_criterion(observations, acceptable)
    second = enumerate_policies(observations, acceptable)
    require(first == second, "Cell-intersection and policy enumeration disagree")
    return first


def run_checks() -> dict:
    mask_rows = []
    disagreements = []
    for adequate_mask, available_mask in itertools.product(range(4), repeat=2):
        adequate = {i for i in range(2) if adequate_mask & (1 << i)}
        available = {i for i in range(2) if available_mask & (1 << i)}
        intersection = bool(adequate & available)
        witness = any(i in adequate and i in available for i in range(2))
        require(intersection == witness, "Joint-witness algorithms disagree")
        shortcut = bool(adequate) and bool(available)
        row = {"adequate_mask": adequate_mask, "available_mask": available_mask,
               "joint_feasible": intersection, "separate_existence": shortcut}
        mask_rows.append(row)
        if intersection != shortcut:
            disagreements.append(row)
    require(len(mask_rows) == 16, "J1 domain incomplete")
    require(any(r["adequate_mask"] == 1 and r["available_mask"] == 2
                for r in disagreements), "J1 disjoint false rule not rejected")
    require(any(r["adequate_mask"] == r["available_mask"] == 1 and r["joint_feasible"]
                for r in mask_rows), "J1 genuine witness lost")

    worlds = list(itertools.product((0, 1), repeat=2))
    first_bit = [w[0] for w in worlds]
    second_bit = [w[1] for w in worlds]
    xor_target = [{a ^ b} for a, b in worlds]
    a_ok = checked_adequacy(first_bit, xor_target)
    b_ok = checked_adequacy(second_bit, xor_target)
    pooled_ok = checked_adequacy(worlds, xor_target)
    require(not a_ok and not b_ok and pooled_ok, "J2 recipient-scope distinction failed")

    all_partitions = partitions(4)
    require(len(all_partitions) == len(set(all_partitions)) == 15, "J3 partitions incomplete")
    comparisons = 0
    adequate_pairs = 0
    choices = ({0}, {1}, {0, 1})
    for partition in all_partitions:
        for specification in itertools.product(choices, repeat=4):
            adequate_pairs += checked_adequacy(partition, specification)
            comparisons += 1
    require(comparisons == 1215, "J3 comparison domain incomplete")
    parity_labels = [a ^ b for a, b in worlds]
    other_encoding = ["odd" if label else "even" for label in parity_labels]
    constant = ["present"] * 4
    original_ok = checked_adequacy(parity_labels, xor_target)
    relabelled_ok = checked_adequacy(other_encoding, xor_target)
    constant_ok = checked_adequacy(constant, xor_target)
    require(parity_labels != other_encoding and original_ok and relabelled_ok,
            "J3 nonidentical adequate representation lost")
    require(not constant_ok, "J3 content-presence shortcut not rejected")

    without_context = checked_adequacy(second_bit, xor_target)
    with_context = checked_adequacy(list(zip(first_bit, second_bit)), xor_target)
    require(not without_context and with_context, "J4 context-dependent adequacy failed")

    return {
        "suite": "selection-dynamics-integration-v1",
        "python": platform.python_version(),
        "all_required_checks_passed": True,
        "construction_count": 4,
        "false_rule_witness_count": 5,
        "J1": {"mask_combinations": 16, "joint_feasible": sum(r["joint_feasible"] for r in mask_rows),
               "separate_existence_false_positives": disagreements, "rows": mask_rows},
        "J2": {"worlds": worlds, "consumer_A_adequate": a_ok, "consumer_B_adequate": b_ok,
               "actually_pooled_observation_adequate": pooled_ok},
        "J3": {"partitions": len(all_partitions), "specifications_per_partition": 81,
               "oracle_comparisons": comparisons, "adequate_pairs": adequate_pairs,
               "algorithm_disagreements": 0, "original_encoding_adequate": original_ok,
               "nonidentical_encoding_adequate": relabelled_ok, "constant_content_adequate": constant_ok},
        "J4": {"new_item_alone_adequate": without_context, "with_established_side_information": with_context},
        "false_rules_rejected": ["separate_exists_implies_common_witness", "distributed_implies_each_consumer",
                                "exact_encoding_identity_is_necessary", "content_present_implies_adequate",
                                "item_adequacy_is_context_free"],
        "limits": ["finite_supplied_worlds_and_output_contracts", "shared_author_and_fixtures",
                   "no_live_actor_or_database_execution", "no_taxonomy_or_natural_language_oracle"]
    }


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    result = run_checks()
    args.output.write_text(json.dumps(result, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
    print(json.dumps({"all_required_checks_passed": True, "constructions": 4, "false_rule_witnesses": 5}))


if __name__ == "__main__":
    main()
