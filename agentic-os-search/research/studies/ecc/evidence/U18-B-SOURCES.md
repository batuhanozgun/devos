# U18-B — AURA interface and caller-boundary source ledger

**2026-09-23 · Q02e / MR42.** Fixed ECC `8321021c54d670126ce3b2969d5deb880b4b0c2a`. [Note41](../notes/41-AURA-REPUTATION-GATE-AND-CALLER-BOUNDARIES.md), [round](../ROUND-U18-B.md), [STATE](../STATE.md). Original SOURCE OBSERVATION, TARGET CLAIM/INSTRUCTION, TEST SOURCE INSPECTED and conditional INFERENCE. No target execution, live service query, E11, installation, model call, payment or delegation.

## Original source identities and coverage

All ECC paths below resolve under [the fixed target](https://github.com/affaan-m/ECC/tree/8321021c54d670126ce3b2969d5deb880b4b0c2a). FULL means the entire returned body was read, not all external dependencies or installed behavior.

| Handle | Exact ECC path | Git blob | Actual coverage / role |
|---|---|---|---|
| ADAPTER | integrations/aura/adapter.py | 075c028e954bb2072c8ee71a3f979dcc52831667 | FULL. Exports/constants, verdict/exception, payload conversion, HTTP helper, lookup, policy gate and alias. Pure stdlib; NOT RUN |
| EXPORTS | integrations/aura/__init__.py | 0b18ac64d1b03a7fcedd39107d09f5fc3198f65b | FULL. Actual package exports and illustrative before-action caller; no activation call |
| README | integrations/aura/README.md | 99000362def4e67ea01f86b94db3b687f9d1882c | FULL. Opt-in vendoring, caller example, class/display versus gate-policy distinction, error behavior, test invocation and external service claims |
| THREAT | integrations/aura/THREAT_MODEL.md | 32dd7866b493f74d927a40cd0434de680099fe46 | FULL. Backward-looking reputation; separate live identity, current action, endpoint, freshness, caller policy and data boundary |
| FIXTURES | integrations/aura/tests/fixtures.py | 0cc6b02a82a6ad090009f592f880f3db6174dace | FULL. Five canned bodies; DID-query lookup and raising fetch helpers; recorded-shape comments without a capture receipt. NOT RUN |
| TESTS | integrations/aura/tests/test_adapter.py | 9d4bf1d6228d0a94ef137c3e24fe280e3e16936f | FULL. Actual injected consumers, class/display/projection/default/custom gate, failure classification and prefix-invalid assertions. NOT RUN |
| EMPTY-TEST-INIT | integrations/aura/tests/__init__.py | e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 | Tree metadata: empty, size0. No nonempty body or behavioral content claimed |
| NEXT-CONSULT | scripts/consult.js | 4a9d6ba6de15093ba9a36a777b11b4fbdb1fc240 | SELECTED lines1–64 only. Exact-pin imports of install-manifest functions, target/limit/schema/tokens and beginning of aliases. Next-work qualification only; ranking/callers/installation not read or run |

Six nonempty AURA bodies were fully read. Initial AURA directory metadata contains README, THREAT_MODEL, initializer, adapter and tests. Its root identity is `969d1ab550fe972a8840293b01e5d9e28e4cfc3d`; the complete recursive tests tree is `4efa91001cd60ba3350fcb03e670a2ee3d364244`, with `truncated:false` and the three entries above. The outer integrations directory contains only aura at this pin. This is path accounting for that directory, not a finding that ECC has no integrations elsewhere.

## Search and consumer boundary

SEARCH comprises connected GitHub code searches for `before_settle`, `require_trust`, `aura_verdict` and `auraopenprotocol`, each scoped to affaan-m/ECC with topn30. Returned paths were in the AURA package. Search used default-branch `bf70150eb2df8070024e5bdf08e4aa08959e2735`, not the fixed research pin. Hits located paths only; every substantive body was independently fetched at the fixed pin. No exhaustive fixed-pin caller inventory or repository-wide absence follows from these searches.

Recovered executable consumers are TESTS. README/EXPORTS/ADAPTER examples place a call before an external action; payment, logging, abort and manual-review names there are illustrative host responsibilities. The complete adapter has no action callback or automatic hook installation. This establishes a caller-owned API/contract boundary without inventing a real production payment integration.

A broader consult search located scripts/consult.js, scripts/ecc.js and numerous unrelated prose hits on the newer default branch; the response was clipped. Only NEXT-CONSULT's fixed-pin prefix is source evidence. The next unit must recover the complete implementation and actual public/manifests/tests/installation consumers. No U18-C substantive answer is claimed here.

## Claim-to-chain bindings

1. **Executable optional gate:** EXPORTS exposes ADAPTER's two entry points; aura_verdict reports while before_settle returns/raises. README's catch-and-return example precedes its placeholder pay call. A local gate can be real without automatically governing every ECC execution route.
2. **Useful input/failure controls:** ADAPTER validates the did: prefix, encodes the query, forwards timeout, normalizes classes and rejects new/high_risk/unknown by default. HTTPError precedes URLError; TESTS explicitly challenge HTTP503 versus connection failure and malformed/list responses. PY-ERROR supports the subclass distinction. Inspected assertions are not results.
3. **Exact policy semantics:** allow membership is evaluated before fail_open. Default allow differs from deliberately allowing unknown/new. Reachability-based failure permission does not manufacture positive reputation. README expressly distinguishes class-derived ok from the actual policy return/raise.
4. **Identity and coherence countercase:** from_payload takes body.did without equality checking, directly retains score/dimensions, coerces history, and the gate uses the class. A stipulated trusted reply about B to a request for A therefore returns under default policy; the example caller still owns its A variable. This is conditional source reasoning, not a captured remote reply, executed bypass or demonstrated exploit.
5. **Authority and projection:** THREAT assigns live DID control and current action risk to the caller. ADAPTER accepts no amount/action/revision/authentication data, while as_dict omits reachable, history, dimensions, raw and policy. Minimal presentation is not a complete decision receipt. Neither matching identity nor good history alone proves current action authorization.
6. **Transport/freshness:** default HTTPS is not a local immutable host/certificate pin; base_url is caller-configurable and the adapter supplies no URL restriction/custom redirect policy. PY-REQUEST provides the narrow default-opener/proxy/timeout contract. No local cache does not authenticate backend freshness or validate an expiration/block/action revision. No live endpoint or installed Python behavior was tested.
7. **Test oracle limits:** fixtures are selected by decoded query DID and ordinary matching bodies, not adversarial identity/coherence/freshness cases. TESTS checks local classes/errors/projection with injected fetches, not the actual HTTP helper or protected effects. Claimed real recorded shapes have no independent capture/currentness record in these files.

## Narrow primary external documentation

Checked2026-09-23:

- PY-REQUEST: https://docs.python.org/3/library/urllib.request.html — urlopen/Request/build_opener contract. Default GET when no data; timeout applies to blocking operations; default opener includes redirects and can use proxies. Used only to qualify the adapter's delegated transport, not to certify its deployed destination or runtime.
- PY-ERROR: https://docs.python.org/3/library/urllib.error.html — HTTPError is a URLError subclass. Used only for the consequence of ADAPTER's exception ordering.

The fetched pages identify Python3.14.7 documentation. This is not an installed Python version or dependency identity for ECC. No current AURA availability, on-chain score quality, DID authentication, price, rate limit, protocol security or service effectiveness was independently established. The service itself was not queried.

## Acquisition, execution and method limits

An auxiliary working-container urllib download of the exact already-read raw adapter URL failed with `URLError: [Errno -3] Temporary failure in name resolution`. It produced no adapter file. That was source acquisition, not execution of the target helper, live trust lookup or failed E11. Connected GitHub full reads remained available; no source inference relies on a guessed or modified local copy. The created working directory contains no target execution evidence and is not a repository publication dependency.

No behavioral probe was opened and no target tests were run. The mechanism's source return condition did not require a live service or a branch-repetition experiment; stronger operational conclusions remain Q02e2. Source counterparts are not quantified failure rates, observed customer incidents or independent security validation. No previous experiment or E10 restoration was rerun.

## Work-recovery and publication provenance

Fresh AGENT and all nine routed protocols were fully read with clipped tails recovered. Root research/studies routers, package STATE/INDEX/META/WHY/METHOD/PLAN/QUESTIONS, Note40/U18-A ledger/MR41/receipt, Note33 and U15-A reconciliation were fully read. Initial CATALOG recovery checked only its ECC row. Recovery main was `2d9c5026085fd8b4dcc739f098e3dc9841a4a58e`; the resolved U17 catalogue and U18-A stale-STATE issues were not reopened.

MR42 opened at `20172113809100473811654e7ab8e099bf9c0ffe`; the opening was later fully reread as blob `680e815d1b6814342cdadcabfd590517775b69ee` before result replacement. Activation at `2ede26a607033be86cff841bce55bd6c549106cf` was fully read back as STATE blob `b8ce63938f3bc7e0d21b757ec697c74f2419a2fa` before source inquiry. Note41 creation was `daa2475a8c703aa5cbb0764b750013ed1c672ba0`. Source/entry/catalogue/readback/receipt/final-STATE checks remain subsequent publication work and are recorded in the actual publication receipt, not asserted by file creation alone.

Original Notes01–40, all experiments and E06 exclusion, E05 distinct histories, E10 bad-transfer/recovery history, METHOD/WHY, historical inventory, other studies/concepts/explorations/Foundation and agent-control remain outside mutation scope. No branch merge/deletion, upstream action, live environment or SOUL adoption follows.
