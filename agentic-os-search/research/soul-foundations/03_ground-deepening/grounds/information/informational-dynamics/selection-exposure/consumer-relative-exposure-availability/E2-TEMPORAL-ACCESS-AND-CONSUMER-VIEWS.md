# E2 — Temporal access and consumer-relative views

**Date:** 2026-09-15. **Status:** source-informed E0–E3 checkpoint; structural judgment unfinished.
**Sources:** P1–P5 in SOURCE-LEDGER. **Executed cases:** X01–X06, SPEC and E3.

## 1. The endpoint changes what success means

The accepted parent already separates adequate selection from availability. This pass sharpens the latter: an identifier, an executable read opportunity, a local copy, a supported representation and material in a particular invocation are different possible targets. They are not an obligatory success ladder. A reference-discovery task may be fulfilled by a locator; a task that requires the source passage already present cannot substitute the locator for that passage.

P1 makes a concrete host boundary visible: the Resources protocol distinguishes resource operations from the host's choice of context incorporation. A successful server read does not by itself report which content was included in a later model invocation. The candidate Note08 led to that primary check; it did not supply new runtime evidence. No MCP host was exercised here.

Our analytical qualification is consumer identity. Access held by a coordinator account, a tool process, a worker session and a particular request can differ. 'Our system has the information' is underspecified if it stands for a stronger claim about one of those endpoints. The required target and availability mode must be recovered before diagnosing a failure as poor selection, disobedience or reasoning error.

## 2. Pieces available at different times need not compose

P3 supplies the temporal-network counterframe. X01 tests a narrow consequence with three nodes and two contact slots. A can pass information to B only in slot 2; B could pass it to C only in slot 1. Ignoring time yields A→B→C. Respecting the permitted order yields no delivery to C by the deadline. Each edge exists, but the composite opportunity does not.

The converse also matters. If A→B occurs in slot 1 and B→C in slot 2, waiting/retained custody permits success even though neither instantaneous network contains a complete A→C route. Requiring every link to be simultaneously open would reject this valid case. Thus neither static union nor mandatory simultaneity is the general criterion.

Under our explicit slot model, forward reachable sets obey:

```
R0 = {A}
Rt = R(t-1) union {v : (u,v,t) is a permitted contact and u is in R(t-1)}
```

Taking only the previous slot's state prevents an unintended same-slot multi-hop transfer. The equivalent time-expanded graph has waiting edges and contact edges from slot t-1 to t. Induction on t establishes equivalence: waiting retains an already reached node, and every new node has a permitted predecessor. This is elementary finite reachability, not a new temporal-network theorem or a guarantee for an unknown real environment.

X01 compared the two implementations on all 4096 schedules. They agreed throughout. The static union gave 320 false-positive reachability claims on that finite population; 3328 schedules were actually reachable under the declared model. Those counts were observed outputs, not tuned acceptance thresholds or estimated rates for real systems.

The project-facing implication is conditional: a later SOUL access claim may need a time-respecting sequence of available credentials, tools, source versions and consumer opportunities rather than a collection of facts that were each once true. Our graph does not implement those real mechanisms or their permission semantics. Their transitions, waiting rights and resource costs would require an actual operating profile.

## 3. An existing path is weaker than an actionable access strategy

Even the correct graph can omit a further distinction. Knowing that a route exists in the actual world does not establish that this actor can identify and execute it within the budget from its available observations.

**Analytical countercase, not an executed seventh test:** in each of two worlds, exactly one of two locations contains a required report. The actor has one read and no signal distinguishing the worlds. Every world has a successful read path, but no deterministic one-read policy guarantees success in both. An informative locator, another read, or a weaker success requirement changes the problem. Formally, 'for every world there exists a successful path' does not imply 'there exists an observation-based policy successful in every world'.

This does not make every unknown route unavailable. Actual opportunity, demonstrated opportunity, and a guarantee under uncertainty are different claims. The distinction is a boundary question for E4: discovery may belong to finding/selection, while executable consumer-relative access must not be defined as a path that only an omniscient observer can use. The prior adequacy child's adaptive-policy result is relevant but not a substitute for settling this Exposure boundary.

## 4. A receipt is evidence about a particular event

P2a's 202 semantics do not certify completed processing. In X02, two actual loopback scenarios returned identical accepted status/body. One subsequent result read returned the designated content, the other returned 404. On the supplied two-world class, the acceptance observation alone cannot distinguish content availability and appropriately yields UNKNOWN.

More generally, let an observation identify a class of still-compatible situations. A strong success assertion is supported by that observation only if the claimed success holds throughout that class, or a further justified premise rules out the failures. This is an observation-relative reasoning criterion, not proof that all real alternatives were enumerated. A missing observation can likewise coexist with actual success; the present fixture did not test acknowledgment loss.

The endpoint read in X02 is stronger evidence for its exact local result, not universal assurance. It says nothing about another recipient, an omitted dependency, a future invocation or the consumer's interpretation. A richer receipt could legitimately encode a stronger endpoint claim, but then its production and binding need separate support. The word receipt itself has no fixed universal evidence strength.

## 5. Updating or restricting the source does not rewrite every consumer view

X03 retained exact v1 bytes, changed the source to v2, and successfully read v2. The old local value remained v1. It was suitable for an exact-v1 historical request and unsuitable for an exact-v2 current request. P2b supplies a real protocol/application boundary; our test is not a browser implementation or an eventual-convergence benchmark.

A read's validity therefore has a target and horizon. A correct result at one moment may be sufficient for that one use. Continuing access or currentness requires more conditions, but does not automatically require continuous polling, a particular consistency model or always reading the original source. A correctly bound maintained replica may meet the relevant use. What remains to prove is the applicable assurance path.

X04 then separated a source route from retained custody. A local handler initially allowed a read; after its permission flag changed, new requests returned 403, while the previously saved file remained readable. This establishes only the chosen handler/file behavior. It does not grant continued use rights, implement real authorization, demonstrate secure erasure or locate every copy.

The legitimate protected outcome may be stopping future acquisition, withdrawing a source as current authority, removing a specified published view, or destroying a specified copy. Those are not interchangeable. Records and Revision already protect these distinctions; Exposure contributes their consumer-relative endpoint question. Availability can also be unwanted, so increasing exposure is not an unconditional optimization objective.

## 6. Presence may omit the representation's required support

X05 wrote and read the same compressed payload. A direct UTF-8 JSON reader failed; the specified decompression/decoding path recovered the object. Byte identity remained intact. The missing condition was not another topical source but support for the designated representation.

P5 supplies an importantly different human-facing counterframe: content must be available through supported presentation means, not only stored as bytes. Its requirements are not adopted as a universal machine-availability definition, and no assistive-technology or comprehension test ran. X05 illustrates format decoding only.

An Exposure claim can consequently depend on codebooks, format versions, permitted tools or presentation alternatives when the declared endpoint requires them. But receiving all named dependencies does not prove the dependency inventory is complete, nor does successful decoding prove faithful meaning or understanding. Re-expression owns the meaning-preservation question; Exposure must avoid treating unavailable interpretation resources as already present. E4 still has to test that boundary without absorbing cognition or every Environment capability.

## 7. The object being found may be metadata, not the needed content

P4 explicitly distinguishes lasting metadata from disappearing data. X06 removed a temporary data file while retaining and reading its metadata. Finding that record succeeded; reading the object did not. This can be an intentional archival outcome rather than a broken index.

For our future research library, a source citation or inventory row can therefore preserve a useful discovery/history route without providing the source evidence needed to re-evaluate a claim. A retrieval hit should not silently change which object it certifies. Conversely, failure to retrieve the data does not erase the legitimately retained historical fact that a record describes it. No policy to retain everything or expose restricted data follows.

## 8. What is new versus inherited?

The source/receipt/use, historical/current, and route/copy distinctions already have accepted Foundation or candidate antecedents. This pass does not claim to discover them from scratch. Its added contribution is the explicit temporal composition counterexample and exhaustive finite comparison; actual local endpoint observations with controlled identical receipts; tested source-view and copy-removal distinctions; and pressure from preservation and human-supported representation alongside machine context.

The evidence remains heterogeneous. X01 is a complete small mathematical population, X02–X04 are scripted sequential loopback operations, X05 is actual format processing, and X06 is local file removal. They do not become independent samples of real agents merely by being different cases. E3 preserves actual execution and shared assumptions.

## 9. Exact unfinished comparison

E4 must compare one rich availability relation with access-opportunity/realized-presentation and qualification/realization alternatives. It must also attack reduction into Formation, Re-expression and Propagation. The central unresolved point is whether distinct access modes and evidence horizons expose first-order research regions or facets of one information-to-consumer relation.

Test the actionable-path objection, consumer-supported presentation, deliberate non-disclosure and continuing availability against those rivals. Do not infer a leaf from a conjunction or a split merely because two states can fail independently. E5 synthesis and E6 research closure are not complete at this checkpoint. No Exposure structure or exact new parent refinements are submitted for acceptance yet; prior U5 acceptance is not in question.
