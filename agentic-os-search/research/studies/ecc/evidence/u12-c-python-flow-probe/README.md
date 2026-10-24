# E09 — Python tool-loop and message-boundary probe

**2026-09-20 · ONE local run, eight controlled cases.** [Precheck](PRECHECK.md) was committed as97ab9354fb30f0b3ac2b5c09a34301a1fcd417ee before execution. [MR28](../../ROUND-U12-C.md) and [U12-C sources](../U12-C-SOURCES.md) own the surrounding inquiry. This is original-source local execution with a scripted provider, not an SDK/API, live model, installed package, security penetration or effectiveness experiment.

## What actually ran

Unmodified ECC8321021 source modules `src/llm/core/types.py` and `src/llm/tools/executor.py` were recovered from connected GitHub text and matched to their Git blob hashes before loading. Minimal package containers bypassed `llm/__init__.py` and provider SDK imports. Real ReActAgent/ToolExecutor bodies received scripted synchronous LLMOutput objects; tool effects were appends to an in-memory list only. Every provider input was deep-copied when received, avoiding later list mutation changing an earlier observation. No network, credentials, live provider/model, shell tool, installation or user-home mutation occurred.

Actual command: `python /mnt/data/ecc_u12c/evidence/probe.py /mnt/data/ecc_u12c/source`, stdout captured as results.json, stderr as stderr.txt, exit status as exit-code.txt. One execution at2026-09-20T00:34:55.313830+00:00; Python3.13.5/GCC14.2.0, Linux6.18.44 x86_64/glibc2.41. Exit0; captured stderr empty. The fresh-retry case intentionally invokes the loop twice within this one run; these are not independent experiment repetitions.

## Predetermined observations

| Case | Observation and narrow meaning |
|---|---|
| 1 No-tool response | Scripted content and length stop reason returned; no tool effect. A no-tool response is returned without separate task acceptance |
| 2 Known tool / positive control | Advertised registered record function appended7; next request contained the result and call ID; a second no-tool output completed the loop |
| 3 Advertised vs registered | With no advertised tools, a scripted call to registered record still appended7. An unknown name produced an error and no extra effect. Registry membership is the execution lookup, not the advertised list |
| 4 Schema vs invocation | A string supplied to a schema-declared integer reached the accepting Python callable. Missing its required argument instead produced a Python invocation error result |
| 5 Last allowed iteration | With max_iterations=1, record appended7, then the function returned only content='Max iterations reached'/stop_reason='max_iterations', without the tool result or transcript |
| 6 Provider failure / fresh retry | After an effect, the next scripted provider call raised; the exception propagated and effect remained. A fresh run from original input repeated it, producing [7,7] |
| 7 Error projection | Direct ToolResult.is_error was true; the next provider history retained diagnostic text and ID but no structural is_error field. Not all error information disappeared |
| 8 Message-shape checker | Actual serialized assistant tool call omitted type:function and retained dictionary arguments. A narrow checker rejected that shape; a separately corrected fixture passed. No real API was called or observed rejecting it |

All recorded comparisons matched the preregistered source predictions. This is NOT eight independent successes, proof that ECC is correct, calibrated security evidence or a measured model failure rate. The scripted provider deliberately makes the relevant branches reachable; it does not measure their frequency in real use. The wire checker covers two explicit OpenAI contract fields, not the complete API schema. Anthropic-specific follow-up representation is a separate source/document comparison, not an E09 API experiment.

## Lossless bundle and hashes

[E09.zip.b64](E09.zip.b64) encodes a ZIP containing `probe.py`, complete `results.json`, `stderr.txt`, `exit-code.txt`, and `MANIFEST.json`. The archive contains no upstream source snapshots. Recover those two modules from the fixed ECC pin for reproduction; the probe refuses different Git blob hashes.

| Object | Bytes | SHA256 / Git identity |
|---|---:|---|
| Original types.py | 4521 | Git84eb7cf8ca0bc024a282ff03661cf7247b244efa; SHA256200a0b153f053be047a30cf7e605d07d4a2062ee65d6325f20762e05a64f1d60 |
| Original executor.py | 3583 | Gite4a859b344338a479b43b42f0ac3c8f5b3b9444e; SHA25675436aef8a374e483bf9a745d0cf8163465ecb339a0a573236ad4e389bf721b7 |
| probe.py | 10305 | 0808157f0756bf039f0bfcd7d783dbcbdf13b4017ccd780e74a6b0c6f9cd0744 |
| results.json | 16373 | d7900dddbca2e682644b3693a22e8b9a447d494509f8fe94f8217451934be285 |
| Decoded ZIP | 6598 | f70acdf4df1fd04e1c446f2813d704f3bff5428945e9684acf4fff620e31e08b |
| E09.zip.b64 including final newline | 8801 | Git02441842546271f10050f0f5d4257235b972f113 |

Decode in an isolated directory with Python's base64 module, verify the ZIP hash above, then inspect/extract its five known entries. `MANIFEST.json` records individual output hashes and the original command. Reproduce with `python probe.py /path/to/pinned/ECC/src`; this does not require installing provider SDKs because the import adaptation is explicit.

The first encoded upload at9fb9bd0b7f77ac33457419f4bc9b28f18d2435e3 had a transcription error; its remote Git blob did not match the locally computed expected blob. It was corrected in571a9824dc0339dc827d4447899b56091c115611; the returned content SHA and a subsequent remote blob read both match02441842546271f10050f0f5d4257235b972f113 exactly. No experiment was rerun or raw result modified to repair this publication error. Byte correspondence is not independent scientific validation. Earlier E06 exclusion and all prior experiment identities remain unchanged.
