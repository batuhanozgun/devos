# U01-M3 — UI/profile caller evidence

2026-09-10, primary upstream pin `c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`. [RESEARCH](RESEARCH.md) is the detailed source-backed explanation; [SOURCES](SOURCES.md) records exact paths, blobs and read depth. The real CLI/gateway command callers are SOURCE INSPECTED, not executed as full applications.

New execution is limited to the complete stdlib-only `gateway/slash_access.py`: [SPEC](SPEC.md), [policy_probe.py](policy_probe.py), [RESULT](RESULT.json), stdout/stderr. Reproduce offline with `python policy_probe.py` from a copy of this folder. It verifies the source Git blob before import; no installation or provider required. Reproduction overwrites RESULT/stdout when redirected, so preserve original evidence first.

Synthetic boundary: config/platform/user/source namespace holders. The probe does not run GatewayRunner, ingress authorization, profile resolution, slash handlers, memory writes or model requests. Eight matched expectations are diagnostic observations, not a product PASS score. Source-informed exploratory specification, not independent verification.

The deliberate always-allow mutant is explicitly a test object, never presented as upstream. It demonstrates that the rejection oracle can fail. A separate changed file is refused before import. [MANIFEST](MANIFEST.json) covers original evidence bytes; publication verification is an artifact-transfer check, not a new behavior test.

Previous [M2](../2026-09-09-memory-pending/README.md) and [D3](../2026-09-09-review-middleware/README.md) remain separate, not rerun. Five previous full modules are linked/reused as source context rather than copied into this package. Upstream LICENSE is retained with the one newly copied source module.

Current continuation authority: [STATE](../../STATE.md) and [RESEARCH-PLAN](../../RESEARCH-PLAN.md), v0.10; package entry [12](../../notes/12-UI-PROFILE-AND-APPROVAL-CALLERS.md). First next: actual approval-to-prompt/request visibility, not another repetition of M2 or these policy cases.
