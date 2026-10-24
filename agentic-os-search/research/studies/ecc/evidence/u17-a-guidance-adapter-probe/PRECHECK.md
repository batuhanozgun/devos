# E10 — Pre-execution criteria: Gemini guidance adapter

**2026-09-22 · U17-A/MR40.** This is a small local source-informed discriminator, not a host/model or portability benchmark. The fixed ECC source is `8321021c54d670126ce3b2969d5deb880b4b0c2a`.

## Sources and admissibility

The complete bodies were read through connected GitHub. After raw-network acquisition failed DNS, the returned original UTF-8 text was transferred into an isolated local directory. Before any target execution, Git blob hashes were computed with the Git `blob <length>\0<bytes>` envelope and matched on the first comparison:

- `scripts/gemini-adapt-agents.js`: 4026 bytes; `bea91cb10f5e3cf078f171e9c3ba4d69d172d37c`.
- `scripts/lib/agent-tools.js`: 2211 bytes; `8b810c8855676da906c9be2e0c07bdf677dba584`.

No edited fragment or pseudocode may stand in for either source. The harness must repeat identity checks before execution. It may run only these originals against newly created temporary fixture files. No real `.gemini` directory, user repository, credential, installation, network, model or provider is involved. Existing ECC tests are inspected evidence, not part of this execution.

## Question and controls, fixed before the run

Does the public command's updated/unchanged count validate host compatibility, or only record whether its narrow transformation changed a file? Does it preserve an existing host-native list form? Distinguish a useful positive transformation and idempotence from uninterpreted/untranslated inputs.

| Case | Input and expected discriminating observation |
|---|---|
| C0 LF scalar | Recognized frontmatter with Read/Grep/duplicate Read, model opus, color and body text. Expect mapped/deduplicated JSON tool list, color removed, model and body unchanged, updated1 |
| C1 CRLF | Same logical input using CRLF. Expect current regex to leave bytes unchanged yet count one already-compatible file; do not infer actual host acceptance |
| C2 no frontmatter | Plain Markdown lacking required name/description/frontmatter. Expect unchanged/compatible count despite no host validation |
| C3 unknown tool | LF input with a name not in the adapter map. Expect name retained, not resolved against a live registry; no claim it can never exist in a custom host |
| C4 native block list | LF frontmatter with `tools:` followed by indented `- read_file` and `- grep_search`. Expect tools line rewritten to `[]` while old list lines remain. Record the exact output. If an already installed safe YAML parser is available, record its version and before/after parse results separately; it is not Gemini's parser |
| C5 idempotent output | Run the C0-produced file a second time unchanged. Expect identical bytes and unchanged1; this is a deliberate repeated-call control, not a hidden rerun |
| C6 absent directory | Invoke with a nonexistent fixture directory. Expect nonzero exit and clear missing-directory diagnostic |

Capture input/output bytes (base64 permitted), argv, exit code, stdout/stderr, identity hashes, platform/runtime versions and per-case criterion observations. Never silently discard a failure or alter a criterion after seeing it. A mismatch is an observed result to investigate, not permission to change the expected result. One harness campaign containing these seven cases is planned; any additional campaign must be disclosed separately.

## Interpretation boundary

A successful local transformation is not an accepted agent definition, available tool, valid remote model, active host instruction, secure policy or effective task result. Retained `model: opus` is not a live wrong-model call. CRLF/no-frontmatter unchanged counters do not establish how any installed Gemini version loads those files. A separate YAML parser, if present, is only a syntax cross-check. The original Gemini adapter test file uses real temporary files/subprocesses but does not invoke Gemini; no upstream-test pass is claimed here.

This check supplements the authored PRD/plan/TDD/PR and dev-team source account. It does not measure whether a model follows those procedures. Source-derived procedural countercases remain source/instruction analysis. Prior E01–E09 histories, corrections and E06 exclusion remain unchanged. Publication and actual execution results belong to the later evidence record and STATE, not this precheck.
