#!/usr/bin/env python3
"""Verify extracted delivery bytes; no writes, imports of upstream code or network."""
from pathlib import Path
import hashlib, json, sys

def git_blob(data):
    return hashlib.sha1(b"blob " + str(len(data)).encode() + b"\0" + data).hexdigest()

def main():
    root = Path(__file__).resolve().parent
    manifest = json.loads((root / "DELIVERY-MANIFEST.json").read_text(encoding="utf-8"))
    expected = set()
    for row in manifest["files"]:
        rel = Path(row["path"])
        if rel.is_absolute() or ".." in rel.parts:
            raise ValueError("Unsafe manifest path")
        p = root / rel
        if p.is_symlink() or not p.is_file():
            raise ValueError(f"Missing or unsafe file: {rel}")
        data = p.read_bytes()
        if (len(data), hashlib.sha256(data).hexdigest(), git_blob(data)) != (row["bytes"], row["sha256"], row["git_blob"]):
            raise ValueError(f"Integrity mismatch: {rel}")
        expected.add(rel.as_posix())
    actual = {p.relative_to(root).as_posix() for p in root.rglob("*") if p.is_file()}
    extra = actual - expected - {"DELIVERY-MANIFEST.json"}
    if extra:
        raise ValueError(f"Unexpected files: {sorted(extra)}")
    print(json.dumps({"files_checked": len(expected), "integrity": "MATCH", "behavior_rerun": False}))

if __name__ == "__main__":
    try:
        main()
    except Exception as exc:
        print(str(exc), file=sys.stderr)
        sys.exit(1)
