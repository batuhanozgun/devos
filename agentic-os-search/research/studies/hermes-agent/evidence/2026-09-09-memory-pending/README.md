# U01-M2 — Memory and pending-write lifecycle diagnostics

**Status:** EXECUTED / BOUNDED FIVE-FULL-MODULE EVIDENCE. **Research date:** 2026-09-09. **Product conformance:** NOT ASSESSED.

Source pin: `NousResearch/hermes-agent@c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`. This is neither a Hermes installation nor a current-release evaluation. The research began from `batuhanozgun/agentic-os-search@9a95b2cf1f8a0460ac6128e1409bf54aa3191022`.

## Evidence route

[SPEC](SPEC.md) was written after source inspection and before the first run. [probe.py](probe.py) loads five complete modules only after checking their expected Git blob IDs. [SOURCE-IDENTITY](SOURCE-IDENTITY.json) binds those copies and the MIT license. [RESULT](RESULT.json), [stdout](stdout.txt) and [stderr](stderr.txt) preserve the actual run. [SOURCES](SOURCES.md) separates full sources from selected static navigation. [RESEARCH](RESEARCH.md) interprets the observations. [REVIEW-ADMISSION](REVIEW-ADMISSION.md) contains a separate, source-only review/constructor observation, not another experiment.

Run UTC `2026-09-09T08:10:46.824877+00:00`, Python 3.13.5/Linux: twelve diagnostic cases. The recorded conditions matched all twelve expectations; this is not a score or twelve product PASS tests. The actual pre-import identity-check function also rejected an altered source copy. No previous U01B/U01B2/transport/U01-D2 experiment was rerun.

## What is real, and what is substituted?

Complete and byte-verified upstream modules: `memory_tool_store.py`, `memory_tool.py`, `write_approval.py`, `write_approval_commands.py`, `skill_provenance.py`. Their function bodies are not rewritten or selected for this experiment. The shared pending command, payload replay and store mutation paths are real.

Substituted boundaries: temporary fixture home, boolean-only config/parser, registry registration sink and error formatter, missing terminal approval channel, harmless-sentinel scanner, and a standard-library temp/replace helper in place of `utils.atomic_write_text`. That helper deliberately fails before any target-file effect in failure cases. Its behavior does not validate the upstream utility or crash durability. Source imports occur in an isolated Python process; no user profile, credentials, provider, model request, network, installation, full AIAgent, CLI or gateway entrypoint is used.

The store uses the actual Linux `fcntl` branch. N06 is an ordered stale-two-store scenario, not parallel stress or a production locking guarantee. N07 uses the harmless string `HERMES_HARMLESS_TEST_SENTINEL`; neither a malicious prompt nor the actual Hermes threat scanner is used. Load-time masking is tested with that same deterministic scanner substitute.

N10 changes the supplied live store's enabled flag; it does not demonstrate that an actual UI refreshes flags after a configuration edit. N11 injects unlink failure only for one pending fixture file; the command's success text and remaining record are both observed.

## Reproduction

Use a fresh disposable process and a new output path:

```sh
python probe.py --output NEW-RESULT.json > NEW-STDOUT.txt 2> NEW-STDERR.txt
```

The harness refuses an existing output path. It uses Python `assert`; do not run with `-O`. Only the recorded Python 3.13.5/Linux run is claimed. Expected warning logs from sentinel masking and pending unlink failure are in stderr; they are experiment inputs/results, not unexplained harness errors. The script cleans temporary fixtures after collecting observations.

The D2 original-file AST check and full review/worker integration remain open. The new memory evidence neither repairs nor retrospectively validates the previous manual executor/plugins excerpts. Source hashes, static observations, fixture execution, publication integrity and real-product behavior are separate claims.
