# E3 — Executed exposure checks and verification limits

**Date:** 2026-09-15
**Result:** six cases passed; six same-fixture false rules rejected.
**Scope:** first execution and unchanged repeat; not independent or live-actor validation.

## Provenance and actual execution

The specification was committed at `5c9a514d91acad12c82cdd97b2e9ae746f3d38eb` before the first execution. It was fetched from that exact commit. The copied local specification matched Git blob `343d023c71f358eacb69c5f161c93b9bc097a18b` before the program ran.

Python 3.13.5 / standard library / zlib 1.3.1 ran the first program with exit code zero. The first result, stdout and stderr were retained. The unchanged second run also exited zero and produced a byte-identical RESULT. Both captured stderr files are empty. The shell printed a TERM environment warning outside those captured program streams; it did not alter either program result. No expected outcome, fixture, program logic or pass criterion was changed after seeing a result, and no failed scientific run was discarded.

Script publication: `a314cab6d13fd3bcaba3ce0bda5fded6724f94e2`.
Result publication: `c200c3475963a247433b6a69d6b0e7d32c607917`.
A separate GitHub checks-tree read at the result commit matched all three local identities and sizes.

| Artifact | Bytes | Git blob SHA | SHA256 |
|---|---:|---|---|
| SPEC.md | 5598 | `343d023c71f358eacb69c5f161c93b9bc097a18b` | `d099223d621b301fe6d96dc7c30da3722a8fe5e3757ebb3ca164ea3b23d7606b` |
| exposure_checks.py | 12158 | `cf136b9186d7c42218b5a82097013beb5af39a2a` | `c7f3b8698bbd3e9a366558f1e3df6bfe0a339e84cd1b19cd0da708c5a2cb5be3` |
| RESULT.json | 3139 | `b2a09162bf461010605f7f6926b42a81d43a281b` | `38794d55eaf40d164cde6f44a8361168367fa2b9c23f84865cbea72dab1cc51e` |

The identical stdout logs report six cases, six controls and all_passed=true. Ports, Date headers and wall-clock timing were excluded from output as specified before execution; the program still made actual loopback requests. Runtime metadata and zlib output can differ on another environment without changing the bounded semantic observation.

## Observations

X01: all 4096 schedules agreed between forward reachability and time-expanded BFS. There were 3328 reachable schedules and 320 static-union false positives. The reversed-contact witness failed despite its static path; the ordered-contact witness succeeded without an instantaneous full route, but failed a shorter deadline. Counts beyond zero disagreement are descriptive outputs, not pre-tuned thresholds.

X02: two actual POST responses had identical 202 status and controlled body; the GET result statuses were 200 and 404. The acknowledgment-only verdict was UNKNOWN on this supplied class.

X03: initial v1 and refreshed v2 reads succeeded while the previously retained bytes remained v1. That retained view matched the historical target but not the new target.

X04: source-route restriction caused a fresh 403; the previously saved file remained readable with its exact prior content. The flag is part of our handler, not a real account-permission mechanism.

X05: the copied compressed bytes matched exactly, a plain reader raised UnicodeDecodeError, and the supported decoding path recovered the declared JSON object.

X06: after removing the temporary data file, its metadata remained readable and identified the same object, while the data read raised FileNotFoundError.

## What the suite does not establish

X01's full enumeration covers only three nodes, two slots and the stated strict-time/waiting convention. Both calculations share that semantic model, cases and authorship. It is not 4096 independent samples or an access-completeness theorem for a real system.

X02–X04 share a scripted local HTTP handler and sequential scenario changes. No adversarial scheduling, response loss, distributed failure, genuine credentials, enforcement propagation or protocol conformance suite was tested. A thread serves requests, but this is not a concurrency correctness experiment. The handler is bound only to loopback, and the program does not contact an external service.

X05 is a byte/format test, not semantic fidelity, accessibility conformance or human/model comprehension. X06 removes a file only inside a temporary fixture, not a remote archive; nothing is concluded about unknown copies. The six controls reject named false rules on these same fixtures, not six further experiments or broad mutation testing.

No live MCP host, SOUL/LLM invocation, human study, actual consumer benefit, calibrated real-world oracle or independent researcher/model replication occurred. Original parent and sibling suites were not rerun or modified. The actionable-path countercase in E2 §3 is analytical and is not counted as an executed case.

## Research continuation

At this evidence checkpoint E4 still owes structural/reduction and omitted-domain comparison. The tests discriminate specific claims; they do not decide whether opportunity, presentation or assurance deserve separate Foundation children. Any later E5/E6 decision must state its own argument and preserve these limits rather than infer hierarchy correctness from green cases.
