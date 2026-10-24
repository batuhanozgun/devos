# U4 non-decision-use checks — pre-execution specification

**Date:** 2026-09-15. Recorded before first execution of nondecision_checks.py.
**Scope:** three researcher-constructed finite cases; Python standard library and local in-memory SQLite. No live actor, retrieval service or empirical explanation study.

## Fixed cases and expected observations

**N01 — Action versus reason.** Two stipulated release records both require HOLD, one because tests are incomplete and the other because a dependency is incompatible. A view retaining only HOLD supports the stipulated action in both states. It cannot identify the exact recorded reason in both states: the allowed-reason sets have empty intersection, and independent enumeration of the two constant reason policies finds none correct throughout. A full state-to-reason view succeeds. This tests exact recorded rationale, not real causal explanation, introspective faithfulness or natural-language understanding. Halpern/Pearl's selected explanation definitions are separate conceptual pressure, not the code's oracle.

**N02 — Output, one witness, all minimal witnesses.** Table facts has rows (a, module, 1), (b, module, 1), (c, other, 0). Query SELECT DISTINCT artifact FROM facts WHERE eligible=1 returns module. Execute the query for all eight subsets and find inclusion-minimal subsets that retain module: exactly {a} and {b}. Subset {a} retains the output and one sufficient witness but not all minimal witnesses. Deleting a inside the local full database leaves module via b; deleting it from the selected subset leaves no output. Witness families are relative to this supplied query/data. No source truth, source independence, general data-provenance implementation or paper-theorem replication follows.

**N03 — Refutation versus bounded certification.** Enumerate all sixteen Boolean functions on the declared domain {0,1,2,3}, and all sixteen test subsets (256 pairs). For the requirement 'output is zero throughout the declared domain', compare a direct three-valued checker with an oracle enumerating every Boolean function compatible with the observed input/output pairs. They must agree on every pair: TRUE 1, FALSE 175, UNKNOWN 80. An observed 1 refutes; all observed zeros certify only when coverage is sufficient under this unconstrained function class. Naively certifying every all-observed-zero result wrongly certifies 65 pairs whose actual full function has a 1. For f=(0,0,0,1), tests {0,1,2} give UNKNOWN and adding 3 gives FALSE. A genuinely all-zero function tested throughout the domain gives TRUE. These are finite-domain claims, not production-test completeness or a prohibition on proof from other assumptions.

## Controls and reporting

Reject three named false rules on these same fixtures: retaining the action always retains its exact rationale; preserving output/one witness preserves the full witness family; and every green selected test set certifies the universal claim. The negative controls share fixtures and authorship; they are not three independent experiments or a broad mutation campaign.

Retain the first RESULT and log. Include failures and input hashes in RESULT.json; exit nonzero if any case or control fails. Run unchanged twice for repeatability. Do not change expected counts or accepted semantics after seeing results without preserving the failed run and labeling a correction. The 256 pairs are one bounded enumeration, not independent real-world samples.

## Evidence and limits

N01/N03 are our own finite constructions. N02 is an original SQL illustration motivated by Buneman, Khanna and Tan, Why and Where: A Characterization of Data Provenance (2001), selected witness definitions; it does not reproduce their full query language or invariance results. Source-reading extent belongs in U4-SOURCE-AND-EXECUTION-ADDENDUM.md. Original K01–K06 and parent suites are preserved and are not rerun here. None of these checks decides whether this Foundation node should be a leaf, establishes complete exploration of unknown questions, or measures actor reasoning efficacy.
