# T2 — Semantic Transfer, Warrant and Composition

**Date:** 2026-09-12  
**Status:** bounded analysis with exact finite checks

## 1. A true summary can be unusable

Suppose a source contains p and q. The output p is entailed by it. But a use that must decide q cannot recover that answer from p across the declared possible inputs. The defect is not necessarily fabrication or falsehood; it is loss of a protected distinction. A summary can therefore pass a truth-preservation check and fail the task's information-preservation requirement.

Conversely, demanding complete preservation of every source distinction would prohibit useful abstraction, redaction and summarization. The inquiry must specify what is retained, intentionally omitted, approximated or no longer supported. A statement that an output is lossless without a meaningful comparison criterion is too broad.

## 2. Question-relative sufficiency

Reuse, rather than rediscover, the accepted Formation F2 fibre/decoder proposition. Let X be allowed source informational states, f:X→Y a transformation and Q a family of protected questions. The output preserves their exact answers when each q in Q has a decoder r on the image of f such that r(f(x))=q(x) for every x in X. Equivalently, each q is constant on every fibre of f.

Necessity follows because equal outputs give the decoder the same argument. For sufficiency define the answer on each output from the common answer of its fibre. This specializes the inherited record-only criterion to a derivative representation and a declared question family; it is not a new empirical discovery or a universal semantic-equivalence solver.

C02 projects four two-bit states to one bit and compares the criterion with all possible Boolean decoders for each of sixteen target questions. Four questions remain exactly recoverable; twelve do not. This verifies the finite construction only. Natural-language task questions, permitted background evidence and approximation tolerances may be unknown or change over time.

A lossy transformation can still improve usability. A lossless encoding can still be inaccessible to a consumer. Exact answer preservation, operational availability, readability and authority are separate judgments.

## 3. Warrant is not transfer completeness

C03's actual world satisfies p, but the available premise p-or-q also permits a world with not-p and q. The conclusion happens to be correct and is not entailed. C05 makes an additional assumption sufficient; removing that assumption changes the warranted conclusion. This separates valid conditional inference from unsupported strengthening.

Logical consequence does not add a new observation by identity. It can nevertheless expose a previously unrecognized consequence and improve a decision. We reject both extremes: that derivation necessarily produces fresh empirical evidence, and that reasoning from existing information never adds epistemic value.

When a source set is inconsistent, a classical proof test may become vacuous. That is a reason to establish the intended logic and treatment of inconsistency, not to use arbitrary consequences as operational facts. This pass does not select a universal logic, belief revision policy or confidence threshold.

## 4. Local validity needs compatible composition

C04 converts 20 Celsius exactly to 68 Fahrenheit and back. Different numbers preserve the declared quantity. In the second construction a correct seconds-to-milliseconds conversion is followed by a consumer that interprets its input as seconds: each function can meet its own local contract, while the composed interpretation is wrong by a factor of 1000.

For f:X→Y followed by g:Y→Z, preservation composes only if g preserves the intermediate questions that witness f's preservation of the original required questions, under aligned domains and assumptions. Independently saying both steps are correct is not such a bridge. Units, entity identity, temporal interval, population and mode can all be part of it.

The same issue arises in a chain of summaries: local source-relative adequacy may successively discard a qualifier the end use needed unless the relevant obligation is carried across steps. This is a constructed risk argument, not an observed degradation rate for LLMs.

## 5. Native query counterexamples

C06 runs SQLite AVG, COUNT and SUM on values 2, 4 and NULL. The observed-value mean is 3 over two observations; using three rows as the denominator or replacing NULL with zero yields 2. SQLite's documented aggregate semantics [S6] explain the query output. Whether the desired question is the observed mean or a model-imputed population estimate is a separate contract. A correct execution is not evidence that the analyst chose the correct estimand.

C07 starts with two distinct tasks costing 10 each. Their total is 20. Joining against two logs for task a and one for task b produces 30 when values are summed. SUM(DISTINCT cost) produces 10 and is not the right repair: equal values are not duplicate entities. The error is in multiplicity and unit-of-analysis binding, not SQL syntax or arithmetic.

Fixing that one join does not fix missing source units, invalid cost definitions or unauthorized decisions downstream. These bounded cases separate a proximate computational defect from wider framing and control questions.

## 6. Uncertainty is part of the transformation obligation

A derived estimate must not silently discard material dependence or model uncertainty. NIST's measurement-uncertainty treatment explicitly includes covariance and states approximation conditions [S3]. C10 independently enumerates ±1 fixtures: two copied values averaged retain variance 1; two independent equiprobable values averaged have variance 1/2. The new output and two source labels do not create independence.

This does not prohibit averaging, combining evidence or reducing uncertainty. It requires the reduction claim to depend on a justified relation, not artifact count. There is no universal numerical confidence calculus for all text transformations in this result.

## 7. Structural pressure

Transfer completeness asks what survives into a representation. Warrant asks what conclusions are licensed by premises and assumptions. C02 and C03 expose failures that cannot be substituted for one another. A common function notation can describe both, but does not erase their different success criteria. T4 compares the cost of treating them as separate child inquiries versus only contract dimensions.

**Sources:** S2/S3/S6; inherited Formation F2; C02–C07/C10. No new source-to-world validity or deployment guarantee is inferred from these constructions.
