# Reproduce the bounded diagnostic

Use Python 3.11 or newer and the standard library. No package installation,
API key, provider, network connection or HERMES installation is required.

Preserve the original archive/RESULT. Extract or copy this entire package into a
fresh directory, then run from that copy:

```sh
PYTHONDONTWRITEBYTECODE=1 python evidence/probe.py
```

The probe first checks INPUTS.json and the full heartbeat upstream Git identity.
It uses temporary SQLite databases and fixture clocks, judges, model turns, task
writers and a reduced SessionDB-shaped adapter. It runs no real worker, shell gate,
network request, process signal or external-system action. An audit hook rejects
socket-connect/name-resolution and process-launch calls that reach it; this is a
bounded diagnostic guard, not a proof of OS sandbox containment.

The new run overwrites RESULT.json in the copied directory. Preserve its stdout,
stderr and timestamp separately from this original run. Different timestamps and
Python/SQLite versions are expected. Verify source/input hashes before comparing
behaviors. Do not reclassify a repeat as independent external replication.

For exact claims, read SPEC, the raw callback trace and the fixture code together.
Only heartbeat.py is a full original module with upstream-byte identity. The two
manual selections remain subject to full-parent byte/AST recovery before stronger
reuse/security claims. LoopManager/GoalManager/CLI/gateway source descriptions in
RESEARCH were not executed by this probe.
