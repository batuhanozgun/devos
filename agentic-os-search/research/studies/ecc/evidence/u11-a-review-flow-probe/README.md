# E08 — Native-review control flow under supplied responses

**2026-09-19 · ONE LOCAL ADAPTED RUN, 18 deterministic scenarios.** [Pre-execution criteria](PRECHECK.md) were published as `6f248ca8b42914a1c3a0a50904a72736bd5373d8` before execution. This is not a Claude Code Workflow run, a live review, independent model verification, installed-plugin validation or a performance score.

## Exact object and environment

Target: `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`, `workflows/orch-review.workflow.js`, Git blob `3fd502da40d77c46c28e0ed8b6845bb0072393ef`. Its complete 15,454-byte/296-line body was recovered from connected GitHub text and matched to that blob before execution. SHA-256: `83bdff29f16c9ad21129e2401067bb07fc5449447f41ca06f2304afe1458bd8b`. An auxiliary raw download failed DNS; no full checkout was acquired.

Local environment: Node `v22.16.0`, Linux x64, kernel `6.18.44`; all work under `/mnt/data/ecc_u11a`. The adapter replaces only the initial `export const meta =` with `const meta =`, then runs the body in an AsyncFunction with supplied `args`, `agent`, `parallel` and `log`. `parallel` is explicitly modeled as ordered Promise.all over thunks. Agent replies/errors are fixtures. No native scheduler, host schema enforcement, permissions, model, credentials, installation, user repository or upstream code mutation was exercised.

[probe.cjs](probe.cjs) checks the source blob before running. Its executed body is 7,643 bytes, Git blob `289e2159c9ab5864bbaa8955e5eb95be3ff7ca89`, SHA-256 `1f3d083d21cea015f2712175a2a9b1c944ce58103994fb0419bea53a053e6576`. Actual command: `node /mnt/data/ecc_u11a/probe.cjs /mnt/data/ecc_u11a/orch-review.workflow.js`; exit 0 and all specified assertions completed. A separate post-run schema check used Python jsonschema `4.26.0`, Draft7Validator, on every non-null supplied response against the schema captured from the original script's agent options: **38 responses checked, all valid**. Null/rejected calls are deliberately separate failure controls, not invalid successful responses silently discarded.

## Observations

| Scenario family | Observed result in the adapter |
|---|---|
| Clean selected reviewers | APPROVE; two selected dimensions |
| Reviewer null or rejected promise | CHANGES_REQUESTED and incomplete; failed dimension retained |
| Verifier null or rejected promise | Finding retained as unverified/blocking |
| Verifier false with confidence 0.2 | Finding retained as uncertain/blocking |
| Verifier true with confidence 0.2 | Finding retained as blocking but counted as confirmed, not uncertain |
| Verifier false with confidence 0.95 | Finding demoted to advisory |
| MEDIUM first, CRITICAL second, same file/evidence | One CRITICAL merged finding, but first title retained and stronger proof absent; proof-sensitive fixture verifier refuted it, yielding APPROVE |
| CRITICAL first, MEDIUM second | Stronger proof retained; the same proof-sensitive fixture verifier confirmed it, yielding CHANGES_REQUESTED |
| Distinct evidence or different files | Two findings retained and the stronger proof reached verification |
| Same snippet, same file, two different line numbers | Two supplied findings collapsed to one |
| Reviewer CHANGES_REQUESTED with empty findings | Aggregate APPROVE; individual verdict is not propagated |
| Nonempty text that is not a unified diff | Reached the supplied clean reviewer and returned APPROVE; no actual reviewer quality claim |
| Security-trigger path | Third review dimension selected |
| Empty diff or non-string changedFiles entry | Error before any agent call |

The two merge inputs individually satisfy the workflow's source schema. The MEDIUM input need not contain proof; the CRITICAL input does. Merging changes only severity and dimensions while retaining the first finding's other fields. Therefore the original stronger proof can disappear before the verifier receives the merged record. No merged-schema validation is performed by this script.

The deterministic verifier is deliberately sensitive only to whether the marker `STRONG_PROOF` reaches its prompt. Its changed verdict demonstrates an information-flow dependency, **not** a real vulnerability being missed by a model. The proof text and severity are stipulated fixture data. The whole diff still reaches the verifier; a real verifier might independently rediscover relevant evidence. Order sensitivity and proof loss are observed; real-world miss rates and significance are not.

The other controls prevent overgeneralization: failed/null reviewers and uncertain/unavailable verifiers do preserve blockers. A low-confidence true being named confirmed concerns reporting semantics, not a demonstrated bypass of that blocker. A negative reviewer verdict with no findings is allowed by the supplied schema, but this experiment does not claim real reviewers produce it frequently.

## Complete raw record and decoding

The four `raw-results.part01.b64` through `part04.b64` files are ordered fragments of one gzip/base64 transport, not four runs. Decoding yields one UTF-8 JSON object with `run` and `schema_check`. It retains all original scenario inputs, prompts, schemas/options, supplied responses/errors, logs, results and schema checks. This is lossless JSON-data packing, not a selected summary. The original pretty run output was 185,819 bytes; whitespace was compacted when packaging the combined object.

| Part | Bytes | Git blob |
|---|---:|---|
| 01 | 1515 | 3e05fe64c308251ae824fa88ab9ac794c1cdbd3a |
| 02 | 1515 | 88dd6c75a077453618e5b221594c93dd50ed6767 |
| 03 | 1515 | faf7d1aae3788cd482a3d71e81db2116322bd4be |
| 04 | 1394 | e9b8056c749104c1cc173134fed66ba2f9281588 |

The decoded 101,725 bytes have SHA-256 `45d8c8f409d51d0c7e01dd63168b833dffd86a9ced844deb700472bba4874f9e`. The following read-only Python snippet, run from this evidence directory, checks the transport and prints the parsed record; it does not run the workflow:

```python
from pathlib import Path
import base64, gzip, hashlib, json

expected_parts = [
    '3e05fe64c308251ae824fa88ab9ac794c1cdbd3a',
    '88dd6c75a077453618e5b221594c93dd50ed6767',
    'faf7d1aae3788cd482a3d71e81db2116322bd4be',
    'e9b8056c749104c1cc173134fed66ba2f9281588',
]
parts = []
for index, expected in enumerate(expected_parts, 1):
    data = Path(f'raw-results.part{index:02d}.b64').read_bytes()
    actual = hashlib.sha1(b'blob ' + str(len(data)).encode() + b'\0' + data).hexdigest()
    if actual != expected:
        raise ValueError(f'Part {index} does not match its recorded Git blob')
    parts.append(data)
encoded = b''.join(b''.join(parts).split())
raw = gzip.decompress(base64.b64decode(encoded, validate=True))
if len(raw) != 101725 or hashlib.sha256(raw).hexdigest() != '45d8c8f409d51d0c7e01dd63168b833dffd86a9ced844deb700472bba4874f9e':
    raise ValueError('Decoded evidence does not match the recorded object')
record = json.loads(raw)
print(json.dumps(record, ensure_ascii=False, indent=2))
```

To repeat the recorded schema check in an environment already containing jsonschema, use `record` from the snippet above:

```python
from jsonschema import Draft7Validator
checked = 0
for scenario in record['run']['scenarios']:
    for call in scenario['calls']:
        reply = call.get('supplied_response')
        if reply is None:
            continue
        Draft7Validator(call['options']['schema']).validate(reply)
        checked += 1
assert checked == 38
```

Reperformance of `probe.cjs` additionally needs the exact upstream source file, not a newer main copy. No automatic download or installation is embedded. Full native Workflow validation remains a separate task.

## Publication correction and limits

An initial assistant-produced single-file transport was incomplete (193 bytes, blob `7aaba914c95b10d0058b653700d31886c45b0189`). A subsequent update repeated it without changing that blob; neither was valid evidence. The complete four-part transport was then published and each part's repository blob/size matched the local bytes at `f9fbf04c429184d7c1834b3669206bd1d2b0a03a`; the executed probe blob also matched. The invalid single-file path was removed in `dad711fb22cefdfc5394bd71bd6502d00b256232`. The mistake was payload preparation, not an established GitHub outage or a failed target experiment. Its history remains recoverable; no test result was changed to hide it.

E08 adds bounded deterministic execution evidence to U11-A. E06 remains excluded; earlier E04/E07 are not pooled with E08. No upstream test suite, native Workflow, live agent, independent review oracle, actual PR selection, commit approval, package install or remediation was executed. Study/publication closure remains in STATE and the unit receipt.
