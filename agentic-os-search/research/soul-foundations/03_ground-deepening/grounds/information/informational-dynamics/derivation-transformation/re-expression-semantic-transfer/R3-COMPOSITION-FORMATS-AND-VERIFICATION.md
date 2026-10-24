# R3 — Composition, Formats and Verification

**Date:** 2026-09-12  
**Status:** bounded analysis with native library counterexamples.

## 1. Local adequacy does not automatically compose

In C12 the first projection retains a and b; the second keeps only a. The first step meets the original b obligation, and the second meets its own a obligation. The chain loses b. An alternative second step retaining b preserves the original question. This is a finite example of contract mismatch, not empirical evidence that all summary chains degrade.

For exact question preservation, the second step must preserve an intermediate question that decodes the original protected answer, with compatible interpretation and domain. Merely calling each step correct establishes no such bridge. For intended semantic transfer, the actual source and target interpretation conventions must also agree with the bridge. Conditional guarantees can compose when their premises align; composition is not inherently impossible.

A source-backed summary can defer details to a linked source rather than contain them. The resulting support claim then concerns summary plus recoverable source, not summary alone. A chain that silently removes the link, context or version binding can lose the condition that made an earlier derivative adequate. This is a prospective failure case; no live link or retrieval pipeline was tested.

## 2. Normalization can preserve one equivalence and erase another distinction

Unicode distinguishes canonical from compatibility equivalence and warns against indiscriminate application of compatibility normalization [S1]. C05 executes Python normalization: composed and decomposed accented e converge under NFC; x-superscript-2 and x2 converge under NFKC. The latter loses a distinction under the fixture's explicit exponent-versus-identifier interpretation. It can be legitimate when an application deliberately treats the forms as equivalent.

This does not make normalization generally wrong or establish arbitrary textual semantics from Unicode properties. The chosen equivalence must match the protected use. C06 also executes the documented non-closure case: a and combining acute are individually NFC, but their concatenation is not NFC until normalized as a whole. Repairing normalization at that boundary establishes this property only; it does not certify meaning or source truth.

The native runtime uses Unicode database 15.1.0; the primary page read is UAX15 revision 57 for Unicode 17.0.0. The examples concern established characters and operations, not a full conformance comparison or an assumption that the local runtime implements the newer version.

## 3. Valid interchange syntax can hide changed values

C07 parses [9007199254740992,9007199254740993]. Python's default integer decoding preserves the difference. Explicit binary64 conversion collapses the values. Actual Node v22.16.0 JSON.parse also collapses them and JSON.stringify emits two copies of the first number. The expected value difference is known from the synthetic integer literals; it is not guessed from a model response.

RFC8259 explains numerical interoperability limits [S2]. The finding is not that JSON cannot carry those character strings, or that every parser loses the distinction. It is that representable syntax and a receiving implementation's numerical interpretation are different claims. Using a different encoding or decoder can preserve the needed identifier, but this research selects no universal storage type.

C08 supplies a second native contrast. Duplicate names in a JSON object parse under Python's default mapping while the earlier value is lost. A pairs-preserving hook exposes both member occurrences. RFC8259 says names should be unique and describes divergent receiver behavior when they are not. Neither successful parse nor a universal duplicate-key interpretation is an adequate source-preservation guarantee. The pairs hook is diagnostic evidence, not a recommendation to accept all malformed or conflicting domain input.

## 4. Semantic order and relational binding cross formats

Order is not always material, but it can be constitutive of a meaning. W3C's informative explanation of Meaningful Sequence explicitly makes that distinction [S4]. Our C04 demonstrates an order-sensitive fixture; it does not establish WCAG conformance or real publication safety.

A table-to-prose conversion can retain all words yet detach a value from its row or header. A chart-to-text conversion can retain labels but omit the baseline or series association. These are unexecuted cross-format probes, not tested visual parsers. They keep the inquiry wider than natural-language paraphrase without inventing a separate branch for every format.

## 5. Round-trip and agreement checks have limited oracles

C11's inverse label substitutions pass a round trip while the intermediate representation violates fixed target meanings. The test would be legitimate for invertibility and insufficient for intermediate fidelity. Independent target interpretation evidence is needed for the stronger claim. Two models or translators agreeing can likewise share an error, but no multi-model experiment was run here.

SummEval distinguishes content relevance/consistency and language fluency/coherence; its annotation discussion exposes evaluation dependencies [S5]. MQM distinguishes source-relative translation errors, with context and task-specific annotation instructions [S7]. QuestEval supplies one explicit bidirectional question-based method [S6]. They do not furnish a universally complete oracle for this project.

A sensible bounded verification claim therefore states source and target, protected use, material error classes, actual comparison method, tested coverage and remaining uncertainty. This is a research implication, not an installed agent-control procedure or an adopted runtime evaluation stack.

## 6. Horizon and changed dependencies

A transfer judgment can stay valid for the original task while becoming insufficient for a different task, codebook, version or recipient. A context link that was part of the interpretation can also become unavailable. Re-evaluation should target the changed dependency rather than assume either all old verdicts remain valid or every old representation has become false.

Records retains persistence and historical reconstructability; Selection retains actual exposure; Standing retains claim-relative qualification; Propagation retains what became effective where. None is completed anew by these transfer examples.

**Evidence:** C05–C08/C10–C12; SOURCE-LEDGER S1–S7 at their recorded extents. No universal serializer, decoder, semantic evaluator or system architecture is selected.
