"""Check declared frontier bookkeeping against an immutable input-state snapshot.

This is not a semantic oracle, a live-agent test, or independent replication.
Run from any directory: python checks/frontier_audit.py
"""
from __future__ import annotations
from copy import deepcopy
from pathlib import Path
import hashlib
import json

PACKAGE = Path(__file__).resolve().parents[1]
EXPECTED = {
    "Informational Formation / Acquisition",
    "Informational Derivation / Transformation",
    "Informational Selection / Exposure",
}

def git_blob(data: bytes) -> str:
    return hashlib.sha1(b"blob " + str(len(data)).encode() + b"\0" + data).hexdigest()

def audit(data: dict) -> None:
    source = data["source_snapshot"]
    raw = (PACKAGE / source["path"]).read_bytes()
    if git_blob(raw) != source["git_blob_sha"]:
        raise ValueError("input snapshot identity mismatch")
    text = raw.decode("utf-8")
    if "not** yet been separately researched as child passes" not in text:
        raise ValueError("explicit unresearched-child source statement missing")
    children = data["separate_child_passes"]
    if len(children) != 3 or {c["name"] for c in children} != EXPECTED:
        raise ValueError("frontier membership changed")
    if not data["parent_result_accepted"]:
        raise ValueError("parent acceptance lost")
    for child in children:
        if child["name"] not in text or not child["structurally_accepted"]:
            raise ValueError("accepted structural child lost")
        if child["separately_researched"]:
            raise ValueError("parent acceptance incorrectly inherited as child research")
    if not data["persistent_adaptation"]["accepted"]:
        raise ValueError("current accepted D result reverted to pending")
    if data["review_state"] != "user_evaluation_pending" or data["next_active"]:
        raise ValueError("review evaluation gate or successor authority corrupted")

def main() -> None:
    data = json.loads((PACKAGE / "FRONTIER.json").read_text())
    audit(data)
    variants = []
    d = deepcopy(data); d["separate_child_passes"][0]["separately_researched"] = True
    variants.append(("inherited_completion", d))
    d = deepcopy(data); d["persistent_adaptation"]["accepted"] = False
    variants.append(("acceptance_regression", d))
    d = deepcopy(data); d["separate_child_passes"][0]["name"] = "Invented fourth inquiry"
    variants.append(("wrong_frontier_member", d))
    d = deepcopy(data); d["next_active"] = True
    variants.append(("unauthorized_activation", d))
    outcomes = []
    for name, variant in variants:
        try:
            audit(variant)
        except ValueError as exc:
            outcomes.append({"case": name, "rejected": True, "reason": str(exc)})
        else:
            raise AssertionError(f"Known-bad variant escaped: {name}")
    result = {
        "baseline": "PASS",
        "source_blob_verified": data["source_snapshot"]["git_blob_sha"],
        "explicit_unresearched_children": len(data["separate_child_passes"]),
        "negative_controls": outcomes,
        "limits": "Declared source/ledger invariants only; no proof of taxonomy, literature coverage or live behavior.",
    }
    output = PACKAGE / "checks" / "RESULT.json"
    output.write_text(json.dumps(result, ensure_ascii=False, indent=2) + "\n")
    print(json.dumps(result, ensure_ascii=False, indent=2))

if __name__ == "__main__":
    main()
