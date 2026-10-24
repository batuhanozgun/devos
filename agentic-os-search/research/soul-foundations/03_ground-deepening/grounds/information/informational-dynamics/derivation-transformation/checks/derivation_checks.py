"""Finite semantic counterexamples. Not a production verifier or a model benchmark."""
from __future__ import annotations

import hashlib
import itertools
import json
from pathlib import Path
import platform
import sqlite3
from fractions import Fraction
from typing import Callable, Iterable

World = tuple[bool, bool]
WORLDS: tuple[World, ...] = tuple(itertools.product((False, True), repeat=2))


def entails(premise: Callable[[World], bool], conclusion: Callable[[World], bool]) -> bool:
    return all(not premise(w) or conclusion(w) for w in WORLDS)


def answer_from_projection_exists(target: tuple[bool, ...]) -> bool:
    """Exhaustively try every Boolean decoder of a one-bit projected record."""
    return any(all(decoder[int(w[0])] == y for w, y in zip(WORLDS, target))
               for decoder in itertools.product((False, True), repeat=2))


def constant_on_fibres(target: tuple[bool, ...]) -> bool:
    return all(w[0] != v[0] or target[i] == target[j]
               for i, w in enumerate(WORLDS) for j, v in enumerate(WORLDS))


def variance(values: Iterable[Fraction]) -> Fraction:
    xs = tuple(values)
    if not xs:
        raise ValueError("Variance fixture must be nonempty.")
    mean = sum(xs, Fraction(0)) / len(xs)
    return sum(((v - mean) ** 2 for v in xs), Fraction(0)) / len(xs)


def run() -> dict:
    cases: list[dict] = []
    negatives: list[dict] = []

    def record(case: str, observed: dict, condition: bool) -> None:
        if not condition:
            raise AssertionError(f"Counterexample failed: {case}: {observed}")
        cases.append({"id": case, "observed": observed, "passed": True})

    def reject(name: str, bad_prediction: object, reference: object) -> None:
        if bad_prediction == reference:
            raise AssertionError(f"Specified negative control escaped: {name}")
        negatives.append({"fault": name, "faulty_result": bad_prediction,
                          "reference_result": reference, "rejected": True})

    source = {"speaker_claim": "deployment_complete", "mode": "assertion"}
    capture = dict(source)
    record("C01_fidelity_vs_truth", {"faithful": capture == source, "actual_complete": False},
           capture == source)

    all_targets = tuple(itertools.product((False, True), repeat=4))
    checks = [constant_on_fibres(t) == answer_from_projection_exists(t) for t in all_targets]
    q_target = tuple(w[1] for w in WORLDS)
    record("C02_entailment_vs_purpose", {
        "p_and_q_entails_p": entails(lambda w: w[0] and w[1], lambda w: w[0]),
        "projected_p_retains_q_question": answer_from_projection_exists(q_target),
        "target_functions_crosschecked": len(checks), "identifiable_functions":
        sum(answer_from_projection_exists(t) for t in all_targets)},
        all(checks) and not answer_from_projection_exists(q_target))
    reject("entailed_partial_summary_is_universally_sufficient", True,
           answer_from_projection_exists(q_target))

    valid = entails(lambda w: w[0] or w[1], lambda w: w[0])
    record("C03_accidental_correctness", {"realized_world": [True, False],
        "conclusion_true_here": True, "inference_valid": valid}, not valid)
    reject("infer_p_from_p_or_q", True, valid)

    c = Fraction(20)
    f = c * Fraction(9, 5) + 32
    recovered = (f - 32) * Fraction(5, 9)
    seconds = Fraction(2)
    milliseconds = seconds * 1000
    record("C04_reexpression_and_composition", {"celsius": str(c), "fahrenheit": str(f),
        "recovered_celsius": str(recovered), "intended_seconds": str(seconds),
        "milliseconds_misread_as_seconds": str(milliseconds)},
        recovered == c and milliseconds != seconds and milliseconds / 1000 == seconds)

    conditional_only = entails(lambda w: (not w[0]) or w[1], lambda w: w[1])
    with_assumption = entails(lambda w: ((not w[0]) or w[1]) and w[0], lambda w: w[1])
    record("C05_assumption_discharge", {"conditional_only_entails_q": conditional_only,
        "with_p_entails_q": with_assumption}, not conditional_only and with_assumption)

    with sqlite3.connect(":memory:") as db:
        db.execute("CREATE TABLE readings(value REAL)")
        db.executemany("INSERT INTO readings VALUES (?)", [(2,), (4,), (None,)])
        avg, n, rows, total = db.execute(
            "SELECT AVG(value),COUNT(value),COUNT(*),SUM(value) FROM readings").fetchone()
        zero_imputed = db.execute("SELECT AVG(COALESCE(value,0)) FROM readings").fetchone()[0]
        record("C06_sql_missingness", {"avg_observed": avg, "observed_count": n,
            "row_count": rows, "zero_imputed_avg": zero_imputed, "sum_over_rows": total / rows},
            (avg, n, rows, zero_imputed) == (3.0, 2, 3, 2.0))
        reject("null_as_measured_zero", zero_imputed, avg)

        db.executescript("CREATE TABLE tasks(id TEXT PRIMARY KEY,cost INTEGER);"
                         "CREATE TABLE logs(task_id TEXT);")
        db.executemany("INSERT INTO tasks VALUES (?,?)", [("a", 10), ("b", 10)])
        db.executemany("INSERT INTO logs VALUES (?)", [("a",), ("a",), ("b",)])
        actual_total = db.execute("SELECT SUM(cost) FROM tasks").fetchone()[0]
        joined, distinct = db.execute("SELECT SUM(cost),SUM(DISTINCT cost) "
            "FROM tasks JOIN logs ON tasks.id=logs.task_id").fetchone()
        record("C07_sql_multiplicity", {"task_total": actual_total,
            "joined_total": joined, "distinct_value_total": distinct},
            (actual_total, joined, distinct) == (20, 30, 10))
        reject("distinct_value_repairs_join_multiplicity", distinct, actual_total)

        def supports(a: bool, b: bool, c_: bool) -> bool:
            return (a and b) or c_
        support_table = [{"inputs": list(x), "supported": supports(*x)}
                         for x in itertools.product((False, True), repeat=3)]
        record("C08_alternative_joint_support", {"table": support_table,
            "after_a_removed_c_survives": supports(False, True, True),
            "after_c_also_removed": supports(False, True, False)},
            supports(False, True, True) and not supports(False, True, False))
        reject("remove_any_support_invalidates_all", False, supports(False, True, True))

        db.execute("CREATE TABLE blockers(task_id TEXT)")
        sql = ("SELECT id FROM tasks WHERE NOT EXISTS "
               "(SELECT 1 FROM blockers WHERE task_id=tasks.id) ORDER BY id")
        before = [x[0] for x in db.execute(sql)]
        original_tasks = list(db.execute("SELECT * FROM tasks ORDER BY id"))
        db.execute("INSERT INTO blockers VALUES ('a')")
        after = [x[0] for x in db.execute(sql)]
        same_tasks = original_tasks == list(db.execute("SELECT * FROM tasks ORDER BY id"))
        record("C09_negative_dependency", {"before": before, "after": after,
            "positive_task_rows_unchanged": same_tasks},
            before == ["a", "b"] and after == ["b"] and same_tasks)
        reject("positive_inputs_unchanged_means_answer_current", before, after)

    signs = (Fraction(-1), Fraction(1))
    copied_variance = variance((z + z) / 2 for z in signs)
    independent_variance = variance((a + b) / 2 for a, b in itertools.product(signs, repeat=2))
    record("C10_correlated_evidence", {"copied_mean_variance": str(copied_variance),
        "independent_mean_variance": str(independent_variance)},
        copied_variance == 1 and independent_variance == Fraction(1, 2))
    reject("copies_are_independent_observations", str(independent_variance), str(copied_variance))

    permitted = [w for w in WORLDS if not (w[0] and w[1])]
    best_score = max(sum(w) for w in permitted)
    revisions = [w for w in permitted if sum(w) == best_score]
    record("C11_revision_alternatives", {"maximal_preserved_literal_count": best_score,
        "tied_revised_worlds": [list(w) for w in revisions],
        "p_in_every_revision": all(w[0] for w in revisions),
        "q_in_every_revision": all(w[1] for w in revisions)},
        set(revisions) == {(True, False), (False, True)} and not all(w[0] for w in revisions))

    contracted_models = [w for w in WORLDS if w[0]]
    record("C12_withdrawal_not_negation", {"remaining_models": [list(w) for w in contracted_models],
        "q_entailed": all(w[1] for w in contracted_models),
        "not_q_entailed": all(not w[1] for w in contracted_models)},
        {w[1] for w in contracted_models} == {False, True})

    p_times, q_times = {0, 1}, {2, 3}
    record("C13_temporal_composition", {"p_true_at": sorted(p_times), "q_true_at": sorted(q_times),
        "simultaneous_support_times": sorted(p_times & q_times)}, not p_times & q_times)

    current = {"p": True, "q": True}
    proposal = {"p": True, "q": False}
    before_commit = dict(current)
    current = dict(proposal)
    record("C14_proposal_vs_commit", {"proposal": proposal,
        "current_before_application": before_commit, "current_after_application": current},
        before_commit != proposal and current == proposal)

    here = Path(__file__).resolve()
    return {"schema": "derivation-counterexamples-v1", "python": platform.python_version(),
            "sqlite": sqlite3.sqlite_version, "script_sha256": hashlib.sha256(here.read_bytes()).hexdigest(),
            "spec_sha256": hashlib.sha256(here.with_name("SPEC.md").read_bytes()).hexdigest(),
            "case_count": len(cases), "negative_control_count": len(negatives), "cases": cases,
            "negative_controls": negatives, "limits": "Same-author finite fixtures and native in-memory SQL; "
            "not independent research, a live LLM/SOUL pipeline, or validation of a taxonomy."}


if __name__ == "__main__":
    result = run()
    output = Path(__file__).resolve().with_name("RESULT.json")
    output.write_text(json.dumps(result, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({"cases_passed": result["case_count"],
                      "negative_controls_rejected": result["negative_control_count"],
                      "output": str(output)}, ensure_ascii=False))
