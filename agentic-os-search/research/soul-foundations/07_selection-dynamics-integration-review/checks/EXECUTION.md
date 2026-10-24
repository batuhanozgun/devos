# Actual execution and evidence scope

**Date:** 2026-09-16. **Runtime:** Python 3.13.5, standard library.
**Pre-execution canonical commit:** `45b69520da364f194afea9c448b9beabbb3c7cf6`.

SPEC and the complete program were published and fetched from that exact commit before execution. The local copied program was compared with a separately returned GitHub identity and matched before either run. SPEC was read back in full; it was not downloaded as a locally hashed source artifact. Failed raw downloads obtained no usable bytes and did not change the specification or code.

Commands were `python integration_checks.py --output RESULT-first.json` and the same unchanged program with `--output RESULT-repeat.json`. Both exits were zero. Both captured stderr streams are empty. `cmp` found the two result files byte-identical; the first was copied as RESULT.json. No failed scientific run was discarded, outcome criterion changed or program revised after observing execution.

| Artifact | Bytes | Git blob SHA | SHA256 |
|---|---:|---|---|
| integration_checks.py | 7081 | `9d1f8078f0233600f195f0aa92a36b4ec61c3178` | `5413cd651ee09c1d9962b1e257cb00acaf16ed0dffab3f02ab99ffddf9303c9f` |
| Each result | 3995 | `c98d30d6fabcde14383a083de011a3d7a9f4f7b7` | `44346b3edc7d7809fc83feab6466bd315dddca732afac71e68aab3213f3046bd` |
| Each stdout | 84 | `b94d803b636a405c6ea710c89d779563451de958` | `4f25fa22c764c426424bfbfa143b804ff7a234e92efb05b3dfd93bd28d63527a` |
| Each stderr | 0 | `e69de29bb2d1d6434b8b29ae775ad8c2e48c5391` | `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855` |

The pre-execution SPEC has Git blob `62b098090b24d810bc82b910bae37b5eafbe78c5`, 3524 bytes. The stdout text, including its newline, is:

```json
{"all_required_checks_passed": true, "constructions": 4, "false_rule_witnesses": 5}
```

## Observed outcomes

J1: sixteen mask combinations, seven with common witnesses and two false positives for the separate-existence shortcut. The common-witness algorithms agreed on all sixteen. J2: neither individual consumer's bit determines XOR, while the supplied pooled observation does. J3: fifteen partitions times eighty-one acceptable-output assignments gave 1215 agreements; 817 combinations were adequate. Different parity labels remained adequate; constant content failed. J4: the newly supplied bit failed alone and passed with the explicitly established complementary side information.

Four constructions and five false-rule witnesses share supplied domains. J2/J4 reuse the same XOR setup; the fixed comparison counts are not independently sampled tasks. The numeric success totals are descriptive, not tuned thresholds. Alternative computations share authorship and assumptions. The unchanged repeat is reproducibility evidence, not independent replication.

No network, database, model, human comprehension, actual credential, source-discovery or production system was exercised. The program writes only the requested result file. No old S/U/E or predecessor test suite was rerun. The tests discriminate named finite mistakes; they do not validate the research hierarchy, natural-language sufficiency, actual authority or user benefit. PUBLICATION separately records the actual repository readback; this execution record does not certify its own upload.
