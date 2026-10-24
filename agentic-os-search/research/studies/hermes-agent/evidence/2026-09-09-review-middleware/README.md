# U01-D3 — review admission, range fidelity and middleware

Date: 2026-09-09. Two different new evidence types; neither is whole-product validation.

**Range fidelity:** 22 retained definitions match newly transcribed pinned GitHub ranges. This is a manual-range AST cross-check with shared transcription risk, NOT the original full-file `verify_excerpts.py` check. That stronger check is still NOT RUN. The new range files are comparison data, not complete importable upstream modules.

**Middleware execution:** eight exploratory diagnostics on the exact complete `hermes_cli/middleware.py` module, Git blob `897e4afc07ba0d78ba928baf39a8573422b648be`. Registry storage, callbacks and effect handler are explicit fakes. No HERMES installation, real profile, provider/credential/network, real unsafe tool or complete AIAgent/PluginManager run.

## Read / reproduce

Start at [RESEARCH.md](RESEARCH.md) and [SOURCES.md](SOURCES.md). [SPEC.md](SPEC.md) distinguishes the retrospective/ad-hoc range observation from the pre-run middleware criteria. [MIDDLEWARE-RESULT.json](MIDDLEWARE-RESULT.json) and [RANGE-FIDELITY.json](RANGE-FIDELITY.json) are the recorded observations. stdout/stderr files are preserved separately.

From a disposable copy of this evidence directory with the older `../2026-09-08-worker-policy/` evidence still beside it:

```sh
python middleware_probe.py --output NEW-MIDDLEWARE-RESULT.json
python range_fidelity.py --output NEW-RANGE-FIDELITY.json
```

Use `range_fidelity.py --prior /path/to/2026-09-08-worker-policy` for a different layout. Both scripts require Python 3.10+ syntax; recorded runtime is Python 3.13.5/Linux. Neither downloads dependencies. Do not overwrite the recorded results on reproduction. The exact middleware import guard also receives a corrupted disposable file and must reject it before module import. The AST negative control mutates only an in-memory AST; target code is not executed.

Prior U01B, transport, U01B2 and U01-D2 C/V experiments are not rerun. The complete middleware bytes plus original MIT LICENSE are retained under `upstream/`. Manual range transcriptions carry their own identities, never the complete originals' hashes. Source-file hash validation, AST selection fidelity, callback behavior and complete runtime reachability are separate assertions.

New source-only work traces review constructor arguments, schema-derived valid names, real tool-round persistence and Relay branch behavior. It narrows a competing explanation but does not prove a universal authorization bypass. See research conclusions and current package STATE for the disposition and next authorized pending/profile/store work.
