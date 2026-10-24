"""Finite constructive checks for a Foundation research argument, not runtime code."""
from __future__ import annotations

import copy
import hashlib
import itertools
import json
from pathlib import Path
from typing import Any, Callable


def require(condition: bool, message: str) -> None:
    if not condition:
        raise AssertionError(message)


def decode_value(row: dict[str, Any]) -> tuple[str, Any]:
    if "value" not in row:
        return ("missing", None)
    value = row["value"]
    if value is None:
        return ("null", None)
    if value == "unknown":
        return ("unknown", None)
    return ("value", value)


def fibres_identify(worlds: list[tuple[int, int]], observe: Callable, target: Callable) -> bool:
    fibres: dict[Any, set[Any]] = {}
    for world in worlds:
        fibres.setdefault(observe(world), set()).add(target(world))
    return all(len(values) == 1 for values in fibres.values())


def exact_decoder_exists(worlds: list[tuple[int, int]], observe: Callable, target: Callable) -> bool:
    """Enumerate all decoders independently of the fibre implementation."""
    records = sorted({observe(w) for w in worlds})
    values = sorted({target(w) for w in worlds})
    for answers in itertools.product(values, repeat=len(records)):
        decoder = dict(zip(records, answers))
        if all(decoder[observe(w)] == target(w) for w in worlds):
            return True
    return False


def run() -> dict[str, Any]:
    cases: list[dict[str, Any]] = []
    mutations: list[dict[str, Any]] = []

    def record(name: str, observed: dict[str, Any]) -> None:
        cases.append({"name": name, "status": "pass", "observed": observed})

    actual = {"deployment_complete": False}
    source = {"speaker": "actor_A", "text": "deployment complete", "mode": "assertion"}
    captured = json.loads(json.dumps(source))
    require(captured == source and not actual["deployment_complete"], "capture/truth conflation")
    record("faithful_false_assertion", {"source_faithful": True, "world_claim_true": False})

    target_ids = {"A", "B", "C", "D"}
    emitted = [{"id": "A", "ok": True}, {"id": "B", "ok": True}]
    processed = copy.deepcopy(emitted)
    processing_coverage = len(processed) / len(emitted)
    target_coverage = len({r["id"] for r in processed} & target_ids) / len(target_ids)
    require(processing_coverage == 1 and target_coverage == 0.5, "wrong coverage denominator")
    record("processing_not_target_coverage", {"processing": processing_coverage, "target": target_coverage})

    worlds = list(itertools.product([0, 1], repeat=2))
    observe = lambda w: w[0]
    hidden_target = lambda w: w[1]
    visible_target = lambda w: w[0]
    require(not fibres_identify(worlds, observe, hidden_target), "hidden target should not identify")
    require(not exact_decoder_exists(worlds, observe, hidden_target), "no exact decoder exists")
    require(fibres_identify(worlds, observe, visible_target), "visible target should identify")
    require(exact_decoder_exists(worlds, observe, visible_target), "visible decoder must exist")
    # Check the equivalence for every Boolean target on the four source worlds.
    for answers in itertools.product([0, 1], repeat=len(worlds)):
        table = dict(zip(worlds, answers))
        target = lambda w, t=table: t[w]
        require(fibres_identify(worlds, observe, target) == exact_decoder_exists(worlds, observe, target),
                "finite equivalence failed")
    record("record_only_identification", {"worlds": 4, "boolean_targets_checked": 16,
                                           "hidden_identifiable": False, "visible_identifiable": True})

    rows = [{}, {"value": None}, {"value": "unknown"}, {"value": 0}]
    decoded = [decode_value(r) for r in rows]
    require([v[0] for v in decoded] == ["missing", "null", "unknown", "value"], "missingness collapsed")
    record("missingness_not_zero", {"decoded": decoded})

    deliveries = [{"delivery": 1, "origin": "o1", "payload": "ready"},
                  {"delivery": 2, "origin": "o1", "payload": "ready"}]
    repeat_observations = [{"origin": "o1", "payload": "ready"},
                           {"origin": "o2", "payload": "ready"}]
    origin_count = lambda rs: len({r["origin"] for r in rs})
    require(origin_count(deliveries) == 1 and origin_count(repeat_observations) == 2,
            "origin/delivery identity collapsed")
    record("origin_not_delivery_or_payload", {"deliveries": 2, "delivery_origins": 1,
                                              "same_payload_observation_origins": 2})

    events = [{"reference": 20, "receipt": 21, "state": "new"},
              {"reference": 10, "receipt": 22, "state": "old"}]
    latest_reference = max(events, key=lambda r: r["reference"])["state"]
    latest_receipt = max(events, key=lambda r: r["receipt"])["state"]
    require(latest_reference == "new" and latest_receipt == "old", "time roles collapsed")
    record("reference_not_receipt_order", {"reference_latest": latest_reference, "receipt_latest": latest_receipt})

    source_text = "approved for testing; not approved for production"
    good_capture = json.loads(json.dumps({"text": source_text}))
    bad_capture = json.loads(json.dumps({"text": source_text.replace("not ", "")}))
    require(good_capture["text"] == source_text and bad_capture["text"] != source_text,
            "syntax mistaken for source fidelity")
    record("parse_success_not_fidelity", {"both_parse": True, "good_faithful": True, "bad_faithful": False})

    state = {"count": 0}
    before = state["count"]
    state["count"] += 1  # stipulated observer effect
    probe_result = state["count"]
    require(before == 0 and probe_result == 1, "probe target boundary ignored")
    record("probe_changes_source", {"before": before, "under_probe": probe_result})

    combinations = []
    for faithful, select_right in itertools.product([False, True], repeat=2):
        sources = {"A": "relevant", "B": "irrelevant"}
        formed = {k: (v if faithful else "corrupt") for k, v in sources.items()}
        selected_id = "A" if select_right else "B"
        combinations.append([formed == sources, selected_id == "A"])
    require({tuple(c) for c in combinations} == set(itertools.product([False, True], repeat=2)),
            "capture and selection are not separated in fixture")
    record("capture_selection_four_combinations", {"combinations": combinations})

    forecast = {"origin": "model_run", "mode": "forecast", "result_time": 10,
                "reference_time": 20, "value": 7}
    acquired_forecast = json.loads(json.dumps(forecast))
    observed_world_times = {9, 10}
    require(acquired_forecast == forecast and forecast["reference_time"] not in observed_world_times,
            "forecast mistaken for future-world observation")
    record("forecast_acquired_not_observed_future", {"faithful_copy": True, "future_observed": False})

    indication = 10
    stipulated_scale = 2
    calibrated = indication * stipulated_scale
    incorrect_unit_interpretation = indication
    require(calibrated == 20 and incorrect_unit_interpretation == 10, "model interpretation ignored")
    record("model_mediated_value", {"indication": indication, "calibrated": calibrated,
                                   "wrong_interpretation": incorrect_unit_interpretation})

    # Negative evidence is conditional, not forbidden: compare explicit possible-world sets.
    world_events = [False, True]
    perfect = lambda event: bool(event)
    compatible_perfect = [e for e in world_events if perfect(e) is False]
    incomplete = lambda event: False
    compatible_incomplete = [e for e in world_events if incomplete(e) is False]
    require(compatible_perfect == [False] and compatible_incomplete == [False, True],
            "negative evidence scope wrong")
    record("conditional_negative_evidence", {"perfect_compatible": compatible_perfect,
                                              "incomplete_compatible": compatible_incomplete})

    def reject(name: str, action: Callable[[], None]) -> None:
        try:
            action()
        except AssertionError as exc:
            mutations.append({"name": name, "status": "rejected", "reason": str(exc)})
        else:
            raise AssertionError("mutation survived: " + name)

    reject("missing_to_zero", lambda: require([("value", 0)] * 4 == decoded, "missingness collapsed"))
    reject("drop_negation", lambda: require(bad_capture["text"] == source_text, "source qualifier lost"))
    reject("deliveries_as_origins", lambda: require(len(deliveries) == 1, "delivery count is not origin count"))
    reject("processed_as_target_coverage", lambda: require(processing_coverage == target_coverage, "wrong denominator"))
    reject("receipt_as_reference", lambda: require(latest_receipt == latest_reference, "wrong temporal role"))

    return {"kind": "constructed_finite_checks", "cases_passed": len(cases),
            "mutations_rejected": len(mutations), "cases": cases, "mutations": mutations,
            "scope": "Same-author fixtures and code; no live-system, statistical or independent taxonomy validation."}


if __name__ == "__main__":
    result = run()
    result["script_sha256"] = hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
    output = Path(__file__).with_name("RESULT.json")
    output.write_text(json.dumps(result, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({"cases_passed": result["cases_passed"],
                      "mutations_rejected": result["mutations_rejected"],
                      "result_file": str(output)}))
