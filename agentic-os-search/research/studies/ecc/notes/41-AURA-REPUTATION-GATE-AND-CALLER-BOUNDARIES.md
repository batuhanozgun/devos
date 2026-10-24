# Note41 — AURA reputation gate and caller boundaries

**2026-09-23 · U18-B / G5 / Q02e / MR42 · BOUNDED SOURCE ANSWER.** Fixed ECC `8321021c54d670126ce3b2969d5deb880b4b0c2a`. [Exact sources](../evidence/U18-B-SOURCES.md), [round](../ROUND-U18-B.md), [STATE](../STATE.md). Source observations, inspected test definitions and explicitly conditional counterexamples. No target execution, E11, live AURA query, installation, payment, delegation or model trial.

## 1. A real local gate, but an explicitly caller-owned integration

ECC's `integrations/aura` supplies a small vendorable Python package with two materially different entry points. `aura_verdict(did)` returns a reputation object. `before_settle(did)` applies a caller-selectable class policy and either returns that object or raises `AuraUntrusted`; `require_trust` is the same function under another name. The package initializer exports these functions but does not invoke them or install a hook. The adapter uses only standard-library dependencies. This is more than descriptive guidance: the return/exception branch is implemented code. [ADAPTER, EXPORTS]

README expressly makes the integration opt-in: the caller imports it and wraps the chosen action. Its settlement example catches `AuraUntrusted` and returns before reaching `pay(counterparty_did, amount)`. In that authored arrangement a rejected lookup prevents that next call. However, `pay`, logging, identity authentication and manual review are placeholders for the host's own code, not implementations supplied by this package. The initializer and adapter also show illustrative callers, not a running settlement system. No action callback, amount, tool arguments, permission grant or transaction is passed into the adapter. It does not sign, hold keys or move funds. [README, EXPORTS, ADAPTER]

The concrete executable consumers recovered here are the package's offline tests. Symbol searches located the same API, examples and fixtures, not an additional production consumer. Those searches cover a newer default branch and are discovery evidence only; they do not prove a repository-wide absence at the fixed pin. All bodies used for findings were fetched at the fixed pin. The bounded finding is therefore the supplied API, its actual test consumers and its explicit external-caller contract, not a claim that every ECC runtime is gated or that no custom integration exists. [SEARCH, TESTS]

## 2. What passes through the interface

The actual chain is:

`caller-supplied DID → prefix check and query encoding → selected gateway /check → JSON object/class interpretation → caller-selected gate policy → caller's next action`.

The input check rejects a falsey DID or one whose string representation does not start with `did:`. It is not a DID-method parser, registration lookup or proof of key control. `urlencode` carries the input into the query rather than interpolating it as an unescaped query fragment. The configured timeout, default eight seconds, is forwarded to the fetch helper. The helper creates a GET request, reads and decodes the response and parses JSON. A returned dictionary is converted into `AuraVerdict`; an unrecognized class becomes `unknown`. [ADAPTER]

The adapter does not calculate the composite score, apply the README's numeric thresholds, inspect a ledger, validate a signature or evaluate the proposed action. It accepts the gateway's recognized verdict class as the local classification input. The service's on-chain history, eight dimensions and score thresholds are target claims in README/THREAT_MODEL, not independently verified service internals in this study. That delegation can be a deliberate useful boundary; it must not be described as local independent trust verification. [README, THREAT, ADAPTER]

## 3. Useful failure controls and the precise meaning of fail-closed

With the default allow-list, `trusted` and `caution` return; `high_risk`, `new` and `unknown` raise. Rejecting a history-free `new` class is deliberate rather than treating absence of history as positive reputation. The source exposes a reason and raw payload, and callers may inspect dimensions using their own policy. [ADAPTER, README]

The implementation preserves a useful distinction within `unknown`:

| Input or failure | Local representation | Default gate | With `fail_open=True` and default allow-list |
|---|---|---|---|
| Recognized trusted/caution response | Original class; reachable true | Return | Return |
| New/high-risk/genuine unknown | Original class; reachable true | Raise | Raise |
| HTTP error, JSON/handled parse error, non-dictionary response | Unknown; reachable true | Raise | Raise |
| Caught URL/timeout/OS transport error | Unknown; reachable false | Raise | Return |

`HTTPError` is caught before the broader URL-error branch. This matters because Python defines it as a `URLError` subclass: a 503 response is not accidentally treated as an unavailable transport that fail-open excuses. Tests explicitly cover that distinction, malformed JSON, list-shaped responses, reachable unknown and connection refusal. These definitions were inspected, not executed. [ADAPTER, TESTS, PY-ERROR]

The policy qualification is important. `before_settle` checks `v.verdict in allow` before its fail-open branch. A caller explicitly including `unknown` can therefore accept a reachable invalid response even with `fail_open=False`; including `new` enables the documented onboarding case. This is an explicit policy override, not evidence that the default policy silently fails open. Conversely, `fail_open=True` alone does not waive every bad response. The method returns an ordinary verdict on an allowed transport failure; it does not create positive reputation evidence. [ADAPTER]

## 4. Consequential counter-reading: the requested identity and returned identity are not bound

`AuraVerdict.from_payload` assigns `did=body.get("did", did)`. It does not compare a supplied response DID with the requested one. Thus the request may be about A while the returned object names B. The same converter accepts the score and dimensions without type/range/coherence validation, and coerces `has_history` to a boolean. The gate then uses only the recognized class, not consistency among those fields. [ADAPTER]

For example, consider the following **stipulated response**, not a response fetched from AURA or a locally executed test:

```json
{"did":"did:aura:B","verdict":"trusted","score":0.1,"has_history":false}
```

If supplied to a request for `did:aura:A`, the inspected branches produce a trusted verdict naming B and the default gate returns. The README-style caller would still use its original A variable for the following action. Likewise a dictionary containing only `{"verdict":"trusted"}` does not become invalid merely because score/history evidence is absent. These are source-derived conditional predictions. They do not establish that the real gateway emits such replies, that an attacker can replace them or that a payment has occurred. [ADAPTER, README]

There are two separate identity obligations here. First, the response must apply to the identity requested. Second, the live counterparty must control that identity. THREAT_MODEL explicitly assigns the second obligation to the caller through authentication/signature challenge. Satisfying it would not by itself repair a mismatched gateway reply. Conversely, a perfectly matching response would not authenticate the live counterparty. The adapter's prefix check establishes neither. [THREAT, ADAPTER]

The useful fixed verdict vocabulary and failure normalization remain real. Their narrower guarantee is that selected classes and error categories are recognized, not that every dictionary carrying an allowed class has been validated as a coherent, identity-bound reputation assertion. A correct trusted gateway could satisfy the missing conditions; that is an external dependency rather than a local check demonstrated by this code.

## 5. Reputation class, caller policy and action authorization are different outputs

The `ok` property is fixed to trusted/caution, independent of `allow` and `fail_open`. A caller can permit `new` or an unreachable unknown while receiving `ok=False`. README explicitly warns to use the gate's return/raise for policy and `ok` for display. This distinction is intentional documentation, not a newly discovered undocumented contradiction. [ADAPTER, README]

`as_dict()` retains DID, class, reason, score and `ok`; it omits reachable, history, dimensions, raw payload and the policy used. It is a compact presentation contract, not a complete policy-decision receipt. Downstream code retaining only this projection cannot infer from `ok` alone whether this particular gate call returned, was rejected under a stricter allow-list, or was permitted by a deliberate exception. The original full object and actual control flow contain more information, but the adapter does not persist an authorization record. [ADAPTER, TESTS]

THREAT_MODEL also explicitly distinguishes backward-looking reputation from current action safety and execution quality. It asks the caller to combine separate action-risk checks, authentication and, for consequential use, other review/settlement controls. Those recommendations are not implemented action-policy machinery in this package. A correct reputation result does not authorize a particular amount, tool invocation, recipient change or later retry. The connection from this returned object to an actual effect must still be supplied and maintained by the caller. [THREAT, README, ADAPTER]

## 6. Endpoint identity and freshness remain dependencies

The default URL is HTTPS and the helper uses the standard-library client. But `base_url` is configurable, with no local scheme or host allow-list check. The package does not supply certificate pinning or a custom redirect policy. THREAT_MODEL's phrase about a pinned host should therefore be read as the named default, not proof of an immutable authenticated destination enforced by the adapter. README intentionally allows self-hosted/staging mirrors and THREAT_MODEL warns against untrusted ones. [ADAPTER, README, THREAT]

Python's documented default opener includes redirect handling and can use configured proxies. Thus one helper invocation is not by itself proof of one physical request to one immutable origin in every environment. Its timeout concerns blocking operations, not an experimentally established end-to-end deadline. These are narrow library-contract qualifications, not an observed redirect, MITM or installed-runtime audit. No gateway was contacted. [PY-REQUEST]

There is no local result cache or persistent storage in the adapter. Calling it again performs another lookup through the selected fetch path. This avoids a built-in indefinitely reused local verdict, but does not establish that the gateway's underlying history is current. No response age, block identity, expiration or action revision is validated. THREAT_MODEL itself leaves caller caching/TTL and cross-session reuse discipline to the host. A returned `reachable=True` is principally the adapter's error-path discriminator, not certification that all data is current or complete. [ADAPTER, THREAT]

## 7. What the tests establish at source scope

The complete test file and fixture helper were read, together with the package exports. The fixtures choose canned JSON by the DID decoded from the query and can raise selected exceptions. All API calls in the inspected tests inject that seam; they do not exercise the actual HTTP helper, TLS, redirects, a ledger or the real service. Comments describe recorded response shapes, but provide no capture timestamp or independent provenance record establishing current gateway conformance. [FIXTURES, TESTS]

Positive and negative cases genuinely target implemented behavior: five verdict classes, default rejection and custom onboarding, dimensions, the minimal dictionary contract, unreachable versus reachable unknown, HTTP/parse/shape failures and prefix-invalid inputs. These are useful tests of the local contract. The ordinary DID assertions use fixtures already carrying the matching DID; they do not challenge a contradictory response DID. No assertion in this file checks score/class/history coherence, live DID control, response age or an actual protected action. A green result, were it obtained, would not establish those properties.

No tests were run in this unit. An auxiliary attempt to download the already read original adapter into the working container failed DNS resolution and obtained no source file; it was not an adapter test, a live trust lookup or an E11. The source answer does not depend on that acquisition. Conditional branch examples above remain source reasoning, not experiments. Additional offline execution could check local branch correspondence but could not establish service authenticity, freshness or protected real-world outcomes.

## 8. System contribution and bounded return

Note41 adds an optional external-reputation edge to Note33's provisional system account. The local classifier gate is executable, its installation and invocation are caller-owned, and its external trust assertion, identity binding, action authorization and final effect are distinct responsibilities. The unit does not reduce all ECC controls to advice, nor turn this optional package into a universal security layer. Notes09–11's guards/governance, Note19's review and Note40's scorecard remain different mechanisms with their original scopes.

Q02e's selected source question is answered through Q02e1; Q02e2 retains actual gateway/transport/schema/identity/freshness, installed-caller composition, error variants, policy/audit fidelity and useful outcome claims. Reopen for a material production consumer or changed adapter/service contract; do not infer that no such consumer can exist from search results. This is not a whole AURA product assessment or a safety/effectiveness certification.

Next selected G5 responsibility is **U18-C: the consult entry's query-to-component/profile recommendation and actual installation boundary**. The fixed-pin prefix of `scripts/consult.js` imports install-manifest loaders and contains target/limit/alias definitions; it was read only to qualify a next source lead, not to finish its ranking or consumer behavior. Recover the complete script, real public caller and referenced manifest/installation/test chain. Determine whether a suggestion, target-compatibility label and generated command are validated capability or only catalog-guided advice. Other ito/nasiko/claw/MCP interfaces, alternate dashboard roles and G6/CORE/joint evaluation remain. U18-C has not been opened or executed.
