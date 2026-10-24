"""Recompute descriptive comparisons, not experimental validation. Standard library only."""
from __future__ import annotations
import hashlib
import json
from decimal import Decimal, ROUND_HALF_UP
from pathlib import Path


def d(value: object) -> Decimal:
    return Decimal(str(value))


def rounded(value: Decimal) -> str:
    return str(value.quantize(Decimal("0.0001"), rounding=ROUND_HALF_UP))


def compare(table: dict, baseline: str) -> dict:
    rows = table["rows"]
    new, old = rows["Meta-Harness"], rows[baseline]
    deltas = [d(a) - d(b) for a, b in zip(new["scores"], old["scores"], strict=True)]
    result = {
        "reported_mean_difference_pp": rounded(d(new["reported_mean"]) - d(old["reported_mean"])),
        "mean_of_rounded_cell_differences_pp": rounded(sum(deltas) / len(deltas)),
        "dataset_differences_pp": {k: str(v) for k, v in zip(table["datasets"], deltas, strict=True)},
        "wins_ties_losses_on_rounded_cells": [sum(v > 0 for v in deltas), sum(v == 0 for v in deltas), sum(v < 0 for v in deltas)],
    }
    if old["context"] and new["context"]:
        result["baseline_context_divided_by_MH"] = rounded(d(old["context"]) / d(new["context"]))
        result["context_reduction_percent_vs_baseline"] = rounded((1 - d(new["context"]) / d(old["context"])) * 100)
    return result


def analyze(data: dict) -> dict:
    for name in ("table2", "table5"):
        t = data[name]
        for row in t["rows"].values():
            if len(row["scores"]) != len(t["datasets"]):
                raise ValueError(f"Mismatched dataset coverage in {name}")
            if not all(0 <= d(x) <= 100 for x in row["scores"]):
                raise ValueError(f"Out-of-range score in {name}")
    t = data["table5"]
    baselines = [v["scores"] for k, v in t["rows"].items() if k != "Meta-Harness"]
    groups = {"strict_wins": [], "tied_best": [], "below_best": []}
    for i, name in enumerate(t["datasets"]):
        score = d(t["rows"]["Meta-Harness"]["scores"][i])
        best = max(d(row[i]) for row in baselines)
        key = "strict_wins" if score > best else "tied_best" if score == best else "below_best"
        groups[key].append(name)
    return {
        "kind": "descriptive arithmetic on manually transcribed rounded publication cells",
        "table2_vs_ACE": compare(data["table2"], "ACE"),
        "table2_vs_Few_shot_all": compare(data["table2"], "Few-shot-all"),
        "table5_vs_ACE": compare(data["table5"], "ACE"),
        "table5_vs_best_listed_baseline": groups,
        "not_established": ["raw-data correctness", "statistical significance", "causal attribution", "historical reproduction", "live efficacy", "total cost"]
    }


if __name__ == "__main__":
    root = Path(__file__).resolve().parent
    source = root / "REPORTED-DATA.json"
    try:
        raw = source.read_bytes()
        result = analyze(json.loads(raw))
    except (OSError, ValueError, KeyError, TypeError) as exc:
        raise SystemExit(f"Arithmetic audit failed: {exc}") from exc
    result["input_sha256"] = hashlib.sha256(raw).hexdigest()
    result["script_sha256"] = hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
    print(json.dumps(result, ensure_ascii=False, indent=2))
