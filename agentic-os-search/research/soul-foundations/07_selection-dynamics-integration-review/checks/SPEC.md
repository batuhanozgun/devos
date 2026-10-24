# Integration diagnostic checks — pre-execution specification

**Date:** 2026-09-16. This specification and the complete program are to be committed and read back before the first execution. PLAN fixes the four questions. No prior S/U/E suite is rerun.

## Domain and criterion

J1 uses exactly two named candidate views and all 4 adequacy masks crossed with all 4 availability masks: 16 cases. For fixed compatible use/consumer/time/mode qualifications, the feasibility oracle is existence of a candidate belonging to both sets. Set intersection is checked against direct per-candidate enumeration. The separate-existence shortcut must disagree on a disjoint nonempty witness and never be substituted for the oracle. A real common witness must pass. This is feasibility of a joint witness, not proof of materialization or actor use.

J2 uses worlds (0,0),(0,1),(1,0),(1,1) and a stipulated XOR output. Consumer A sees the first coordinate; B sees the second. Neither observation admits a correct deterministic view-only output over all worlds. The jointly available pair does. This rejects treating distributed information as already pooled at each consumer. The pooled case assumes the information has legitimately become available; it grants no sharing permission.

J3 generates every canonical restricted-growth partition of four worlds: exactly 15. For each partition it tries all 81 assignments of nonempty acceptable-output sets from {0}, {1}, {0,1} to those worlds: 1215 comparisons. Criterion: every observation cell has a common acceptable output. A separate enumerator tries all deterministic binary functions on that partition's cells. They must agree on every comparison. A parity-labelled representation and a relabelled nonidentical representation both preserve the XOR target; a constant representation does not. Neither exact representation identity nor merely having some content is a universal adequacy test.

J4 uses the same XOR domain but asks whether the second coordinate newly supplied to a consumer is enough by itself or together with an already-available first coordinate. The first must fail and the second pass. The established side information is an explicit input, not assumed latent model knowledge. This is deliberately dependent on J2/J3's fixture and is not independent empirical evidence.

## Execution and failure behavior

Run `python integration_checks.py --output RESULT.json`. The only write is the requested result file; no network or external service is used. Runtime version is included. A failed required proposition raises an assertion and exits nonzero. The first successful or failed run, stdout and stderr must be retained. Run the unchanged program a second time and compare results; repetition is reproducibility evidence, not another sample. No outcome is inspected before this program/specification publication.

Required outcomes are fixed above. The numbers of feasible combinations/partitions and false-shortcut disagreements are descriptive outputs, not tuned thresholds. Four constructions test explicit claims; the five named false-rule witnesses share their fixtures and do not constitute five further experiments. The two finite oracle routes share the supplied model and authorship. Tests cannot validate source truth, a real use contract, unknown candidates, natural-language sufficiency, comprehension, independence, permission enforcement, a universal taxonomy or actual SOUL/LLM effectiveness. This is not a PostgreSQL or Web Annotation conformance test.
