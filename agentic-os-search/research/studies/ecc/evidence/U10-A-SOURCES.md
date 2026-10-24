# U10-A — Rust evaluation/admission/use source ledger

**2026-09-19 · Q06d1.** Target remains [affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a](https://github.com/affaan-m/ECC/tree/8321021c54d670126ce3b2969d5deb880b4b0c2a). Result: [Note17](../notes/17-RUST-EVALUATION-REGISTRY-AND-USE.md). Method: [MR18](../ROUND-U10-A.md). STATE owns current work/publication. No new experiment/E08, original Rust execution, target test run, provider/model or deployment occurred.

## Reading and identity

FULL means the named file through EOF, not dependency/runtime closure. SELECTED gives inclusive requested source ranges; incidental material is identified rather than promoted into whole-mechanism coverage. All ECC bodies below came from the unchanged pin through the connected GitHub tool. Earlier source IDs are reused, not renumbered.

| ID | Object | Git identity | Actual additional coverage |
|---|---|---|---|
| S218 | ecc2/src/harness_eval.rs | 641275970ba925a398bf2ed1441ca949b6ab5a1e | FULL, 1–300 and 301–650 through EOF. Candidate construction/integrity/legacy ID, recorded evaluator, health snapshot, paired samples/policy and module tests. Tests inspected, NOT RUN |
| S186 re-entry | ecc2/src/main.rs | 7c516684c178d050bc36d96d0481f812e9c48c07 | SELECTED 1436–1545, complete HarnessEval dispatcher plus incidental Start opening. Prior complete main/config initialization, bounded-file helper, HarnessEval declaration, RunSession arm and final Ok remain at U09-A/U09-B recorded scope |
| S190 re-entry | ecc2/src/session/store.rs | f71bb3640991f9d471e2ab98dad54dff4d346721 | SELECTED 434–555, 900–1100, 1800–2180, 2350–2770, 2900–3300, 3400–3760, 4200–4460, 4800–4830, 5200–5775, 7000–7030, 7600–8266 EOF. Complete second registry implementation is within 5200–5775; complete evaluation-specific tests within 7600–EOF. Earlier schema/session/profile coverage is retained. Several other ranges were source-location overhead, not complete research into their incidental mechanisms |
| S187 re-entry | ecc2/src/session/manager.rs | 515235760adb242fe3b4bd1e8481c8b78aee5cc4 | SELECTED 2320–2440, 3000–3360, 3380–3555. Complete agent_program, run_session, built-in/configured command builders, shared environment and task/profile projection. Includes incidental boundaries; not the entire manager or every launcher |
| S10 re-entry | ecc2/README.md | 71aad6da80ba490a3705587aa31a15c36625b9fc | FULL. Bounded Harness Evaluation is the relevant author contract; broad alpha/missing-feature prose is not a current whole-product finding |
| S200 re-entry | ecc2/Cargo.toml | 1995913c78282b08ccc7b4940b22e522c6e9cb41 | FULL; rusqlite 0.40 with bundled feature, not a built-artifact receipt |
| S201 continued | ecc2/Cargo.lock | ab4d168cc80acfda87595572883bef04f0290194 | SELECTED 1800–1950 and 2040–2140. Exact rusqlite 0.40.2 entry/checksum; later range incidental neighbors. Not a complete lock audit |

S190 acquisition detail: one full-file response was acquired for symbol discovery but display-truncated; it is NOT a full read. A response-resource search found evaluate_promote_and_health_check and its tests. Requested 9000–9270 and 10000–10040 returned empty content, establishing no additional body coverage. The final 8251–8550 request reached EOF at 8266. The registry is a second impl after graph helpers, not adjacent to its schema. Preserve the useful 5200–5775/7600–EOF coordinates to avoid repeating this location cost.

S195 config loading/runner lookup, S188 runtime capture and S190 session-profile retrieval retain their earlier exact scopes; no whole-file expansion is asserted. Actual same-conversation source recovery is distinguished from prior ledger metadata. The U09-A and U07-A ledgers were fully reread for old source IDs, caller depth and the next Node framework entry; they are not new target behavior evidence.

## Dependency binding

The lock declares rusqlite **0.40.2**, registry checksum `23f2a97da3e3873c73cb2a2e71b35c40ff95e0b1eefa8d72d8499a6928c3b5b3`. Connected GitHub resolved its tag to a concrete source commit:

| ID | Object | Identity | Coverage |
|---|---|---|---|
| S219 | rusqlite/rusqlite refs/tags/v0.40.2 | commit e88f112bef7899234a497baed5cc3c3d553deeb8 | Complete ref response; object type commit |
| S220 | rusqlite/rusqlite src/transaction.rs | 30b8afdba755b436d2df43383ee2bdbf464a1d9f | SELECTED 1–155 and 430–482. Transaction/drop contract, constructor/default rollback, unchecked_transaction and deferred-default description |

[Version-tag transaction source](https://github.com/rusqlite/rusqlite/blob/e88f112bef7899234a497baed5cc3c3d553deeb8/src/transaction.rs). The registry crate bytes were not downloaded/checksum-matched to the tag and no locked ECC binary was built. This is declared-version/source-contract evidence, not installed-binary or crash-consistency certification. No new rusqlite study is created.

Primary external checks, observed 2026-09-19:

- **W-U10A-SQL:** [SQLite isolation](https://www.sqlite.org/isolation.html), selected separate-connection visibility, same-connection visibility and serialization descriptions. An uncommitted pointer change is not normally visible to another connection. Shared-cache/read_uncommitted is the explicit exception; no such runtime configuration was observed here.
- **W-U10A-RSQL:** [rusqlite transaction source manual](https://docs.rs/rusqlite/latest/src/rusqlite/transaction.rs.html) and [Transaction](https://docs.rs/rusqlite/latest/rusqlite/struct.Transaction.html), selected default rollback/unchecked transaction descriptions, displayed 0.40.2. Direct versioned docs opens failed; S219/S220 provide the stronger fixed source binding. Forked crates and unrelated search hits were not used as evidence.

## Claim-to-source closure

**Candidate:** S186 Record → bounded JSON read → S218 CandidateSpec::new/verify → S190 record_harness_candidate, resolve/register aliases and immutable tables/triggers. Canonical config and normalized reference strings enter the v2 digest. References are not fetched or authenticated; arbitrary JSON value acceptance is not a live Config schema guarantee. Legacy v1 config-only identity and its v2 alias are preserved without rewriting prior rows.

**Evaluation:** S186 Run → RecordedEvidence/from_evidence → health_evidence_snapshot → evaluate_paired → PromotionPolicy::compare → S190 evaluate_promote_and_health_check. Requested distinct seeds index supplied candidate/baseline scores; they are not newly sampled trials. CLI policy thresholds accompany the evidence in the request, not a preregistered rule enforced by this path. Health callback and stored snapshot derive from the same input health map.

**Admission:** S190 resolves physical IDs, checks the active baseline within the transaction, persists policy rejection without changing it, or conditionally updates the slot before invoking the health callback. True/false/error-or-disagreement lead to different structured outcomes and audit events; unhealthy/error restores the prior pointer before commit. Evaluation and audit insertion share the transaction. S220 supplies default rollback on an uncommitted return; W-U10A-SQL bounds external visibility. This is not a live rollout/rollback or proof of effectful callback compensation.

**Audit:** S190 harness_audit_entries → verify_harness_audit_entry checks health canonical JSON/digest/candidate/assertion/status, event consistency and matching health columns in the linked evaluation. Initial activation, policy rejection and legacy-unverifiable rows have explicit no-health exceptions. The getter does not rerun the experiment, fetch references or recompute every saved comparison. Database triggers block covered UPDATE/DELETE operations, not all privileged database/schema/file tampering.

**Use boundary:** S190's convenience active_harness_id getter is cfg(test). Actual S186 main initializes Config::load; S187 run_session reads the session profile and builds from cfg/agent/task/profile; its command and projection helpers do not consume the candidate JSON or active slot. S10 explicitly documents registry-only activation and no running-session changes. This supports the bounded built-in-path conclusion, not an exhaustive repository-wide or custom-executable absence claim. Default-branch search for active_harness_config returned store.rs at ref 9e06a2792bb3a5c1bc3ca272b853bac7998485d8; it is discovery only, not pinned negative evidence.

## Inspected tests and what they do not establish

S218 tests cover stable/reference-sensitive IDs, integrity rejection, legacy/v2 identity checking, unique seeds/minimum samples, deterministic thresholds and evaluator call order. The evaluation-specific S190 tests use temporary SQLite stores, include a real two-connection/barrier registration test, persistence after reopen, trigger rejection, health false/error, policy rejection, legacy aliases/collision rejection and a deliberately removed-trigger/missing-health-metadata check. This is stronger test source than only a fake command recorder, but NO test was run by this study.

The two-connection test concerns idempotent candidate registration, not concurrent promotion or every failure point. Constant health callbacks test the registry branch, not a deployed candidate. The CLI's recorded callback cannot independently test the same assertion it just read. Missing/stale/invalid input paths were interpreted from source; no synthetic failure was reported as an observed ECC incident. No exhaustive test inventory or universal absence of integration tests is claimed.

## Access and scope limits

A direct auxiliary raw download failed at DNS. Three explicit versioned docs opens were unavailable; an attempted GitHub tags-collection fetch was rejected by the wrapper before retrieval. The allowed Git-ref endpoint and pinned source reads succeeded. These are scoped access facts, not a GitHub outage diagnosis. One STATE update included an unsupported ref argument and failed argument binding before mutation; the corrected schema-conforming request succeeded.

No local target checkout, dependency installation, source test, provider/model, actual deployment, process signal or new fixture was produced. Earlier E04/E07 remain separate; E06 is still excluded. Administrative text/hash/diff work is publication checking, not new behavioral evidence. The result closes a bounded recorded-evidence-to-registry source question; actual score provenance, preregistration, empirical efficacy, privileged tamper, concurrent promotion/crash behavior and runtime deployment require stronger, separately scoped evidence.
