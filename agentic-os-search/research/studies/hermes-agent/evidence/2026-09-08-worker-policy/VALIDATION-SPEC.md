# Name-validation bridge — supplemental pre-execution criteria

2026-09-08. Written after the 14-case selected worker-policy experiment, before this separate validation probe. Exploratory follow-up, not an independent holdout. No old result will be overwritten.

The COMPLETE `agent/turn_tool_validation.py` must match upstream Git blob `db3e89334ebb4302f55357e8063c28f5758becd5` before import. Its `validate_tool_calls` runs with a synthetic agent holder, harmless tool call, message helper doubles and the already-declared selected executor/policy functions plus complete pool/context modules. This is not the complete AIAgent/review construction/ordinary loop or complete PluginManager.

V01: tool name is in the synthetic broader advertised valid-name set but absent from the thread-local policy. Observe actual name-validator verdict, then call the selected sequential pipeline only for an OK verdict. Record actual policy at precheck and marker count.
V02: remove marker from valid-name set and disable repair. Expect a non-OK verdict and no downstream dispatch/marker.
V03: keep known marker but truncate its JSON. Expect terminal partial verdict, cleanup hook, and no dispatch/marker.
V04: keep known marker and let lifecycle emit an independent block. Observe name acceptance followed by policy-stage denial. Broader name acceptance is not absence of every protection.
V05: known marker with no required parameters and empty argument text: check actual normalization to `{}`; no production schema validation is claimed. Supply a harmless default marker if dispatched.

Controls assert handler counts and stage-specific outcomes. Model sampling, tool-schema discovery, real profile resolver, registry membership construction, plugin discovery and actual transport reachability remain unexecuted.

Separate source-integrity control: call the actual harness pre-import verifier on a disposable copied source tree with one byte changed, require ValueError and no source import. This closes the distinction between merely computing unequal hashes in the first report and actually observing guard rejection. It does not validate large-module excerpt fidelity.
