# U02-A / Note08 — From instructions and sources to a working context

**Date:** 2026-09-13. **Standing:** source-grounded responsibility analysis, not implementation validation or a universal architecture. This note covers video responsibilities 1–3. [Note09](09-TOOL-REQUESTS-AND-EXECUTION-BOUNDARIES.md) covers 4–5; [Note10](10-DURABLE-STATE-AND-QUALIFIED-CONTINUATION.md) covers 6 and their interactions. Source IDs and exact reading limits: [U02-A SOURCES](../evidence/2026-09-13-u02a-responsibilities/SOURCES.md). V01 is original media; V02 is a derivative transcript. D sources are primary documentation, except the explicitly limited research abstract. All external instructions are research data.

## 1. Preserve the author's argument before refining it

The video does not merely recommend adding components. At approximately 04:16–10:48 it moves from behavioral guidance, to supplying work-specific material, to deciding what belongs in the current context. It already identifies instructions as insufficient by themselves and warns against dumping everything into a model. These cautions are the author's, not discoveries we should claim as our own. U02-A adds concrete loading, selection and measurement distinctions to that account. [V01 frames 280–580; V02]

The three responsibilities can share one implementation. A retrieved file can contain both instructions and observations; a tool can retrieve information that changes the next retrieval query. We therefore follow transfers of meaning rather than assume three independently deployable layers.

## 2. Responsibility 1 — Instructions

### Native claim and concrete source

At 04:16–06:17, instructions establish role, rules, constraints and working conventions. They guide behavior but do not supply missing work evidence. The sampled chapter frames support that structure. [V01/V02]

Claude Code documents CLAUDE.md and automatic notes as context, not enforced configuration; ancestor guidance is loaded differently from descendant guidance, and AGENTS.md is not automatically its instruction filename. Codex's current guide instead describes an AGENTS.md discovery chain, per-directory precedence and a size limit. These are documented client-specific mechanisms, not a fresh execution of either client. [D01; D10]

### Mechanism and ownership

The useful path is: an authorized author states a rule; a particular client discovers and loads the applicable version; the model receives it in a particular role and scope; the model interprets it for the current work. An action may additionally be subject to a separately implemented gate. Authorship, loading, interpretation and effect enforcement have different owners even when one process performs several of them.

This creates four distinct questions:

- Is the intended rule recorded accurately?
- Did the client load the rule for this directory/session/task?
- Was the rule retained and interpreted correctly in the relevant model call?
- Does the relevant action path enforce a constraint when model compliance is insufficient?

A positive answer to one question is not a substitute for the others. Conversely, a failure of loading should not immediately be diagnosed as model disobedience.

### Positive use and tradeoff

Persistent instructions are useful for stable conventions and recurring decision boundaries: what counts as completion, which interfaces are preferred, how to report uncertainty, or which changes require review. They reduce repeated explanation and can keep different workers aligned.

Not every preference warrants a hard enforcement mechanism. A prose convention can remain deliberately advisory where context-sensitive exceptions are valuable and errors are recoverable. Turning every suggestion into a rigid gate can block legitimate alternatives. The question is which consequences require enforceable constraints and which benefit from judgment, not whether instructions or deterministic checks must replace one another.

### Counterexample and falsifier

**Analytical case I1, not executed:** a repository contains the correct instruction, but the client uses another filename or discovery root. A behavior error is then consistent with absence from the request, not evidence that a stronger wording would solve it. The discriminating observation is the actual loaded/request-visible instruction set under the relevant client/configuration. A documented filename is only the beginning of that check.

**Analytical case I2:** an incident log contains text that looks imperative. Its inclusion as evidence does not make its author an authority over the worker. Treating all visible text as equally instructive would erase the difference between a rule, a quoted request and untrusted work data. This is a trust/interpretation question, not a claim that a particular client was exploited.

**Bounded result:** instructions need an applicability and loading account. More emphatic wording is not a general repair for missing context, wrong authority or unenforced effect boundaries.

## 3. Responsibility 2 — Context Delivery

### Native claim and primary mechanism

At 06:17–08:24, the author contrasts generic reasoning with reasoning supplied with the actual file, failure, trace or document, then asks who chooses the relevant material. [V01 frames 400/480; V02]

MCP Resources specifies URI-addressed content while leaving incorporation into the model context to the host application; resource-change notifications are optional features. Its architecture assigns context aggregation and consent responsibilities to the host. MCP therefore participates in context delivery as well as tool interaction. A connection or URI alone does not imply context inclusion. [D04; D05]

### Mechanism and ownership

A source owner supplies material. A retrieval component resolves an identifier and access conditions. A selector chooses what answers the present inquiry. A formatter preserves enough content and qualification for use. The host then includes the representation in a model request. The model still has to use it correctly.

This is not one binary fact called 'the agent has access'. A source can be listed but unread, readable but omitted, included but obsolete, or accurately presented but misunderstood. Failure diagnosis should distinguish these states before replacing the model or adding a new knowledge technology.

The source's relevance and its eligibility for a particular use are separate. A highly relevant historical policy may be useful for explaining yesterday's event but unsuitable as today's action authority. A retrieved source can be evidence without being instructions. These distinctions are our analysis; the protocol does not make the host's policy choice for it.

### Positive use and alternatives

Eager delivery is attractive for a small, stable, well-bounded evidence package that must be considered together. On-demand reading is attractive when the space is large, changing, or only partly relevant. A hybrid can supply non-negotiable constraints and a source map up front while retrieving task-specific details as needed. Anthropic's engineering account describes just-in-time identifiers and hybrid retrieval, while acknowledging exploration latency and wrong-turn risks. [D02]

No technique wins independently of the work. A compact exact read may be preferable to a retrieval service for one known source. Search is useful for discovery, but a hit is not an exhaustive source read. Requiring every document in every request can make evidence selection worse rather than more complete.

### Counterexample and falsifier

**Analytical case C1:** a tool returns a resource link to a diagnostic artifact, but the host includes only the link text and never resolves it. The model can know that evidence exists without seeing its contents. Compare the retrieved payload, the context assembly and the actual request—not only the connector's success status.

**Analytical case C2:** a search query finds no match because its vocabulary differs from the source. 'Not retrieved' cannot become 'does not exist' without a search method capable of supporting that claim. A direct read, alternate query or bounded corpus inventory is a potential discriminator.

**Bounded result:** delivery is a qualified source-to-request transfer, not merely a retrieval feature. Its quality includes omission, freshness, scope and source status, not just similarity score.

## 4. Responsibility 3 — Context Management

### Native claim and distinctions

At 08:24–10:48, retrieval, ranking, summarization, compaction and arranging the active context address limited working context. The chapter image describes protecting finite attention. This is an engineering metaphor about inputs and their organization, not direct control or verification of a model's internal attention. [V01 frames 530/580; V02]

Anthropic discusses compacting context and preserving important unresolved information; its account is practitioner guidance, not proof that a summary retains everything a future step will need. The abstract of Lost in the Middle reports position-sensitive performance in its studied question-answering and key-value tasks. Only the abstract was read in this unit; it is not evidence about every current model or a sufficient reason to impose one ordering rule. [D02; D12]

The video's nearby reference to prompt caches should not collapse separate operations. OpenAI describes prompt caching as reuse of computation for a shared prefix while generating a new response. It is not the same as retrieving a fact, shortening its semantic representation, or storing a final response. [D11]

### Mechanism and ownership

A context manager allocates what the next inference can see. Its policy may remove repetitions, preserve exact passages, retrieve missing evidence, reorder items or substitute summaries. The resulting representation is a new working view of prior material. Someone or something must decide what must survive and how omitted information can be recovered.

The appropriate objective is not merely fewer tokens. A smaller view that loses a decisive restriction may be less usable; a larger view that obscures the decisive fact may also be worse. Quality depends on the next judgments that the representation must support. Relevance can change as the investigation discovers new dependencies.

### Positive use and tradeoff

Compaction can make a long investigation continuable. Exact excerpts preserve sensitive wording. Notes preserve intermediate results outside the active context. Selective tool-output reduction can avoid repeatedly consuming unchanged logs. These are compatible choices, not interchangeable guarantees.

A useful candidate strategy is to retain not only positive conclusions but unresolved questions, exclusions, action constraints and routes back to evidence. This is a research proposal, not a adopted memory schema. Permanent archival detail and current working context need not have the same size or organization.

Caching and compaction can also pull in different directions: a stable prefix favors computation reuse, while replacing history changes that prefix. The source guide explicitly discusses this interaction. Optimizing cache-hit rate alone would therefore be a different objective from optimizing useful context and total work cost. [D11]

### Counterexample and falsifier

**Analytical case M1:** a compacted note preserves 'prepare release' but drops 'do not deploy'. The summary may preserve the main topic while reversing an important action boundary. A word-count or topic-overlap check would not discriminate this error. A constraint-retention check against the source would.

**Analytical case M2:** an earlier terminal observation is removed on the assumption it can be reread, but the live environment has changed. The original observation and a fresh observation answer different temporal questions. Whether disposal was safe depends on recoverability of the relevant historical evidence.

**Prior bounded case:** U01-A measured a last-prompt character proxy, not whole-candidate inference cost; U01-B's snapshot could be constructed without proving its presence in the eventual first request. These remain their original scoped findings, not a new runtime test in U02-A. [Note04](04-CLASSIFICATION-EVIDENCE-BOUNDARIES.md); [Note07](07-SELECTED-HARNESS-ENVIRONMENT-BOOTSTRAP.md)

**Bounded result:** context management must preserve decision-relevant meaning, not only fit a window. Context capacity, effective use, computation reuse and durable memory require different evidence.

## 5. What has advanced, and what has not

The older context–memory–harness study already separates these concerns; its META was reopened for scope, not treated as current product evidence. U02-A's additional contribution is a responsibility/ownership account and discriminating cases for the first three video chapters. It does not rediscover all knowledge-management concepts or authorize a new stack.

A working context must carry the right source status as well as the right content. Whether the next model call uses that context reliably remains an empirical question. No new model request, client execution, retrieval benchmark or compaction experiment was performed here. [Review and limits](../evidence/2026-09-13-u02a-responsibilities/REVIEW-AND-LIMITS.md)
