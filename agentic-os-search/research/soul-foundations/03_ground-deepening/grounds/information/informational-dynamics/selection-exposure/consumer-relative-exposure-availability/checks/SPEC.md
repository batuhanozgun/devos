# Exposure checks — pre-execution specification

**Date:** 2026-09-15. Fixed before the first execution of exposure_checks.py.
**Scope:** six bounded researcher-built cases; Python standard library, temporary files and an HTTP server bound only to 127.0.0.1. No external network, live model, production credentials or repository mutation by the program.

## Cases and fixed expectations

**X01 — Time-respecting access.** Three nodes A/B/C and two contact slots 1/2. Enumerate every subset of the twelve possible directed non-self contacts: 4096 schedules. Start at A at time zero. A contact (u,v,t) permits traversal from u at t-1 to v at t; waiting/custody is allowed and each traversal advances one slot. Compare forward reachability using the previous slot's state with a separately constructed time-expanded graph searched by breadth-first search. They must agree on reachability of C by slot 2 for every schedule, with zero disagreement. Also require: A→B at 2 followed by B→C at 1 has a static union path but no temporal path; A→B at 1 and B→C at 2 succeeds, although neither individual slot has a complete static A→C path; the latter fails a deadline of slot 1. Counts of reachable schedules are exploratory output, not a preselected success threshold.

**X02 — Receipt versus endpoint.** In two separate local HTTP scenarios, POST /jobs returns the same status 202 and the same controlled body with a result locator. GET /result returns 200 with the specified bytes in one scenario and 404 in the other. Compare only controlled status/body, not Date headers, ports or wall-clock timing. Identical acceptance observations must coexist with distinct endpoint-content observations. Under the supplied two-world class, the acceptance observation alone leaves availability UNKNOWN; the direct result observation distinguishes these worlds. This does not establish universal distributed-system impossibility or exhaustive HTTP conformance.

**X03 — Source update versus retained view.** GET /document yields v1 bytes retained locally. Change the server's source to v2, then GET yields v2, while the previously retained byte value stays v1. The old view meets an exact-v1 historical request and fails an exact-v2 current request. A prior successful read is not a guarantee for a later target. No browser cache or live host context is exercised.

**X04 — Revocation versus copy removal.** GET /document first succeeds and its bytes are saved in a temporary local consumer file. Disable this handler's permission flag; a fresh GET returns 403, while reading the saved file still returns the original bytes. This tests the declared source-route restriction and retained copy only, not real account authorization, secure erasure, propagation to every copy or permission to continue using retained data.

**X05 — Bytes versus representation dependency.** Compress the exact UTF-8 JSON payload {"decision":"HOLD","reason":"dependency"} with zlib and write/read those bytes through a temporary file. Byte identity must match. A direct UTF-8 JSON reader must fail; the zlib→UTF-8→JSON reader must recover the declared object. Same bytes do not guarantee the same consumer-supported representation. This is format decoding, not natural-language comprehension, assistive-technology testing or WCAG conformance.

**X06 — Metadata versus data.** Write metadata identifying a local data file and write the data. Remove only the data file. Metadata must remain readable with the same object identifier; the data read must raise FileNotFoundError. The narrower record-discovery observation succeeds while content access fails. No real archive or remote resource is deleted; this does not prove anything about copies outside the declared temporary directory.

## Source and oracle scope

X01 is an original finite illustration informed by Holme and Saramäki, Temporal Networks, section IV's time-respecting paths and waiting conditions. Its strict slot convention is stated above, not imposed on every temporal-network model. X02 uses RFC 9110 section 15.3.3 as semantic pressure; X03 uses RFC 9111 section 6 as a boundary analogy, not a browser replication. X04 is our scoped file/route construction. X05 is an original decoding example; WCAG 2.2 accessibility-supported and non-text-content sections provide a separate human-facing counterframe, not its oracle. X06 is informed by FAIR A2, not a FAIR implementation assessment. SOURCE-LEDGER records exact reading extent; MCP resource documentation separately distinguishes host context incorporation from resource availability.

## Reporting and failure sensitivity

Reject six named false rules on the same fixtures: static union reachability guarantees timely access; acceptance guarantees result availability; changing the source refreshes retained views; revocation removes existing copies; equal bytes guarantee the required decoded representation; and readable metadata guarantees readable data. These controls are counterexamples, not six independent experiments or a broad mutation campaign.

Write every case/control failure to RESULT.json and exit nonzero on failure. Preserve the first result and stdout/stderr, including setup errors. Run the unchanged program a second time; normalized outputs should be byte-identical. Do not relax expected outcomes after a failed run without recording that correction. Test inputs and output include SHA256 bindings; runtime versions may alter metadata. No test decides the leaf/child structure, real consumer understanding, complete access scope or independent research validity.
