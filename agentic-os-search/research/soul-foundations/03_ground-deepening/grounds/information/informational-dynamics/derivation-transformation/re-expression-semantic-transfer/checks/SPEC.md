# Semantic Transfer — Pre-execution Check Specification

Date: 2026-09-12
Written after primary reconnaissance and before executing the check script.

## Claim, oracle and scope
These are constructed counterexamples and native interchange checks, not tests of a live SOUL/LLM system, a human translator or a universal semantic verifier. Fixed finite meanings, purpose questions and expected answers are supplied by the researcher. Python standard-library behavior and, if available, Node.js JSON parsing are actually executed; the inputs are synthetic. No source data is sent to an external model.

## Required cases

| ID | Required discrimination |
|---|---|
| C01 | Eight source worlds projected to two bits preserve 16 of 256 Boolean questions. Fibre criterion and independently enumerated decoders agree. A newly required omitted-bit question is not preserved. |
| C02 | A source-compatible weakening can be truthful but insufficient for a blocker question; choosing one of two explicitly permitted interpretations is unsupported narrowing. |
| C03 | Swapping actor-role pairings preserves a bag of tokens but changes the required relation. |
| C04 | Reordering the same instruction tokens can change an explicitly modeled sequence outcome. |
| C05 | NFC merges canonically equivalent spellings. NFKC merges x-superscript-2 and x2; that loses the stipulated exponent-versus-identifier distinction. No general Unicode conformance claim. |
| C06 | Individually NFC strings need not yield NFC by concatenation; whole-result normalization repairs this particular closure property. |
| C07 | Python integer JSON decoding distinguishes 2^53 and 2^53+1; binary64 conversion collapses them. If Node is installed, its actual JSON.parse must exhibit the specified collapse. Record availability honestly. |
| C08 | Duplicate JSON names can parse while losing one value under the default Python mapping. A pairs-preserving hook exposes both occurrences. No all-parser claim. |
| C09 | Numeric error <= 0.5 can flip a >=50 decision near its boundary. Exhaustive rational-grid checks confirm stability under the explicit stronger margin >0.5 condition. |
| C10 | An unchanged code requires the right versioned codebook; successful decoding with one background does not certify another. |
| C11 | Two inverse but semantically wrong substitutions pass a round trip while the intermediate representation violates its fixed label meaning. |
| C12 | Each of two projections satisfies its own limited question contract, but their composition loses an original required question; an aligned chain preserves it. |
| C13 | Output-only questions all pass after a critical qualifier is dropped; a separately specified source/task question rejects the omission. |
| C14 | The same lossy redaction can satisfy one declared public-view purpose and fail an identity-dependent purpose. Neither result grants authority or proves privacy. |

## Known-bad controls
Reject six deliberately false rules against the cases: token-bag equality implies relation fidelity (C03); successful parsing implies source preservation (C08); small numeric error always preserves a threshold decision (C09); round-trip equality proves intermediate meaning (C11); individually valid steps guarantee end-to-end preservation (C12); checking only output-derived questions certifies required coverage (C13).

## Evidence interpretation
An exception or unexpected value is a failed check, not grounds to silently loosen criteria. Preserve any correction and rerun. Tests of stipulated semantics do not learn their correctness from data. Enumeration is a different calculation, not independent authorship. Success under the known-bad controls establishes sensitivity only to those faults. Runtime versions, script SHA-256 and reproducibility are recorded separately from research confidence.
