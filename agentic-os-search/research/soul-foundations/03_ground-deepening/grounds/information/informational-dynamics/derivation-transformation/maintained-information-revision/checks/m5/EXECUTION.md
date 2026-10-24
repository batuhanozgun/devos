# M5 execution — final record

**Date:** 2026-09-14. **Result:** five cases pass; five same-fixture false rules rejected.

The original pre-execution SPEC was published at `c2987d88ca08f53323244ed8d7d3250ce5499510`. It was not changed. The first program version passed and repeated with identical result bytes; its exact artifacts remain at `23cb6e52103f27d59bafb066f1f6e80ffdde2e66`. M5-SOURCE-AND-EXECUTION-ADDENDUM section 4 records that first publication checkpoint, before the following wording correction.

During publication review, the header's claim of no repository writes was too broad: the program intentionally writes the local sibling RESULT.json. One word, remote, was inserted to clarify that it makes no remote repository writes. No code logic, fixture, oracle, expectation or criterion changed. The changed header alters the script identity and consequently RESULT's script_sha256 field.

The header-corrected program was freshly executed twice with Python 3.13.5. Both runs exited zero; all cases and controls matched the first version, and the two final RESULT files were byte-identical. Only script_sha256 differs between the old and final JSON. This is documentation repair followed by new execution, not a silently altered scientific acceptance criterion.

| Final artifact | Git blob | SHA256 |
|---|---|---|
| SPEC.md | `5464adec44bcd050e949eb0c87da9d51a2b68294` | `b8ae998a9795c31e020537943a85389791d0bb558381cb631ab5b561374da6ea` |
| m5_checks.py | `e8cba8c8a681b0d7327ad080989d350c9df4a851` | `c9dd9b0c164173b743a0f5ade71268919b58486f84b5dd3325107f2cc7807682` |
| RESULT.json | `cb263d1fddff85dc2c12e311e55e0a7b53f6e193` | `b7106b5ebb4396d30298978dec61b469d7c9effdc805dbbe2b4d59eb5cce633f` |

Old script/result blobs: `98112b81887afc2718048bcc8f0db9f101f894f6` / `819857d78e91e797a41de7244bca137e436f8c3f`. Those are preserved first-version identities, not expected hashes for today's script/result. No scientific run failed. A pre-execution container transport timeout is separately recorded in the source addendum.

The final script and result were published at `cf212e17b02dc9746539b069124753734228769e` and `cf0d900950fbd1716db643780795e7102f5eae2b`, with returned content identities matching local bytes. Repeatability and same-fixture false-rule rejection do not establish independent scientific validation, complete operator conformance, live agent efficacy or a correct leaf/split decision. The original twelve/eight suite was not rerun.
