# E10 — Recovered guidance-adapter evidence

**2026-09-22 / U17-A.** Recovering an interrupted publication is not rerunning or independently confirming the experiment. The previous turn left MR40, an activation STATE, PRECHECK and an encoded archive in main, but no Note39, source ledger or closure. Research input for recovery: `8e6f6547e0b600dba6015046097c459dbc2af16d`.

## Canonical recovery and integrity

The conversation attachment `ECC_U17_A_E10_Evidence.zip` was present and inspected: 8,821 bytes; SHA-256 `d16d24c6b04a17f98d8a62513342170921e05930b883470f123e6d3d4e16888d`; all six ZIP members passed CRC. The repository's `E10.zip.b64` has Git blob `3b92e3eb9111b10416de99fd88591607e6dea582`, 11,771 bytes. Its complete returned text was transferred locally and its Git blob recomputed identically. It differs from the original attachment's encoding and does not decode to a readable ZIP. This is a confirmed evidence-transfer defect, not evidence that the experiment failed or an explanation of the ChatGPT 'thinking failed' error.

**Do not decode E10.zip.b64 directly or treat it as valid execution evidence.** It remains unchanged as the identified bad transfer. The adjacent `restore_e10.py` accepts only that exact blob, replaces zero-based byte interval [259,356) with the documented original bytes, then verifies the corrected base64 Git blob `4d96ed1e788d7b91783b4d775c520f7639a99055`, archive length/SHA-256 and ZIP CRC. The result is byte-for-byte the original attachment, not a re-created result or new archive. This self-contained recovery route removes dependence on conversation storage or a user upload. It requires Python's standard library and the two repository files, no network or target execution.

```sh
python restore_e10.py
```

The output is `E10.recovered.zip`. The helper refuses to overwrite an unrelated output. Integrity recovery does not validate the scientific oracle or prove installed Gemini behavior.

## Original campaign and criterion

[PRECHECK](PRECHECK.md), commit `7217bce94845a71f07de8d98e066fffe91566def`, declares one seven-case campaign before the recorded run. The recovered report records UTC `2026-09-22T13:49:06.272742+00:00`, Python 3.13.5, Node v22.16.0, PyYAML 6.0.3 and Linux. These are recovered runtime records, not this recovery turn's current environment. No second target campaign was run during recovery.

The original adapter and normalizer were run against synthetic temporary files. C0: mapped/deduplicated scalar tools, removed color, preserved model/body. C1/C2: CRLF/no-frontmatter bytes unchanged but reported already compatible. C3: unknown tool name retained. C4: block-list tools rewritten to an empty inline list while old list lines remain; PyYAML parsed the input and rejected the output. C5: the C0 output was deliberately called again and remained unchanged. C6: nonexistent directory returned an error. C5 was a predeclared within-campaign repeat, not a hidden rerun. Criterion observations are source-informed discriminators, not product-safety PASS labels.

## Original members

| Member | Bytes | SHA-256 |
|---|---:|---|
| README.md | 910 | 7afabcfe4ad391727b22a36197ec99d6ebca60d414fb3388dcb8c59aa6783d10 |
| run_e10.py | 7625 | e2f9cffdf68b95901cc54b3632d956a7933bf11aa373cc48ade6b0e0b551071e |
| E10-results.json | 7939 | b457223328fdf983a2503a58481baa3b750d9d7a9064ed4f33e434629ced82a4 |
| source-identity.json | 459 | bbbbdaa1aaa7b01909de186329897ad1c7a5fc7f676f64f31aa89c83d3c01fe9 |
| source/scripts/gemini-adapt-agents.js | 4026 | 01fbaacc128d1396e06115a372a726803eee5cc576373d8d17f1f5a9507e0a8d |
| source/scripts/lib/agent-tools.js | 2211 | a6294088a8b539f3529db6253170734983a4b8e7247adfd176b2066a39249b2e |

The two target Git blobs are `bea91cb10f5e3cf078f171e9c3ba4d69d172d37c` and `8b810c8855676da906c9be2e0c07bdf677dba584`. They match the archived identity record and are checked against fresh connected-GitHub fixed-pin reads during recovery. The harness, every raw case, input/output base64 and stdout/stderr are in the original archive. Reading/CRC/hash checking them is not executing the target again.

## Limits

No Gemini/Claude host, remote model, live tool registry, installation, credential or user data was exercised. PyYAML is an independent syntax cross-check, not Gemini's loader. Unknown/model labels retained by the adapter do not prove a remote request was made or rejected. Unchanged counters are not host conformance. Procedural guidance needs its own source/consumer analysis; E10 does not measure instruction obedience. Earlier E01–E09 histories and E06 exclusion remain unchanged. U17 publication and later work are owned by STATE, not this evidence file.
