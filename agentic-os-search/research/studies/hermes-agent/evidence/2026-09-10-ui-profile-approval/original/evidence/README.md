# U01-M3 — CLI/gateway approval, profiles and store binding

Research: 2026-09-10. Read [RESEARCH](RESEARCH.md) then [SOURCES](SOURCES.md).

This package adds a selected pinned-source trace of actual UI entry points, admission, routed profile and live/fresh store choices. It does not execute a full gateway or CLI. Only one full upstream module, `gateway/slash_access.py`, is executed in six offline policy cases.

Reproduce with Python 3.10+ and the standard library, from this directory:

```sh
python access_probe.py
```

The script verifies the full upstream Git blob before import. A successful run means the six diagnostic expectations matched; it is not a product security, identity, profile-isolation or learning-quality verdict. Running again overwrites ACCESS-RESULT.json; preserve the original result first when comparing runs. Original [SPEC](SPEC.md), [ACCESS-RESULT](ACCESS-RESULT.json), stdout/stderr and source license are retained.

No earlier M2/MW/C/V experiments were rerun. Source-selection, full-file identity, source-informed check and production behavior remain distinct. Current publication outcome is recorded separately in the delivery handoff; this README alone does not assert main publication.
