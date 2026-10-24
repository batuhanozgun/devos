# U01-D3 — bounded controls and pre-run criteria

Date: 2026-09-09. Scope: immutable Hermes `c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`; no installation, provider call, credentials, real profile, registry discovery or unsafe tool.

## A. Range-transcription fidelity

This is an exploratory cross-check, not the full-original `verify_excerpts.py` check. An ad-hoc comparison already observed 22 equal selected definitions before this specification was written. The recorded checker must disclose that order. It must match every retained definition except logger/import scaffolding (15 executor + 7 plugins), retain docstrings in AST, and reject a deliberate AST change. Comparison inputs are newly manually transcribed immutable GitHub source ranges and the old immutable excerpts. Both paths share the assistant/transcription failure risk. Neither large complete local original is claimed hash-verified.

## B. Actual complete middleware module — written before first run

Require the complete module's Git blob `897e4afc07ba0d78ba928baf39a8573422b648be` before import. Plugin-manager storage is a small explicit fake registry. Callbacks and terminal handler are synthetic; handler effects are in-memory markers only. Exercise real `run_tool_execution_middleware` / `_run_execution_chain`.

| Case | Input | Expected distinction |
|---|---|---|
| MW01 | No registered middleware | Handler once, unchanged args/result. |
| MW02 | Middleware raises before `next_call` | Warning; handler once; callback's own exception does not stop downstream. |
| MW03 | Middleware returns without calling next | Handler zero; short-circuit result returned. |
| MW04 | Downstream handler raises | Original exception propagated; handler exactly once, no retry. |
| MW05 | Middleware raises after successful next | First handler result returned; one effect; warning. |
| MW06 | Middleware calls next twice after first success | Second next is rejected internally; first result returned by middleware wrapper; exactly one effect and a duplicate-call warning. |
| MW07 | Outer argument rewrite + inner pre-next failure | Inner failure skipped; handler once sees rewritten args; ordered entry trace retained. |
| MW08 | Middleware raises a custom BaseException before next | Abort propagates; handler zero; this branch is not converted to skip-and-continue. |

An additional integrity challenge changes a disposable copy's bytes and calls the actual import guard: it must refuse before registering/executing that module. These are diagnostic expectations, not product conformance. A failed assertion stays in RESULT and exits nonzero; expectations are not weakened after the run. Prior C/V experiments are not rerun by this script.

## Publication boundary

Static review/admission/round/Relay observations remain static. These middleware probes do not import full AIAgent, PluginManager, executor, review loop or Relay runtime, and do not close Q26's whole-runtime reachability question. Full-original fidelity stays OPEN even when the bounded range comparison matches.
