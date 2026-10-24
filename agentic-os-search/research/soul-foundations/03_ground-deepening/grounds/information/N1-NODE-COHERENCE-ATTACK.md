# Information / Representation State — N1 Node Coherence Attack

**Status:** N1 substantive pass COMPLETE; parent survives provisionally, label remains open  
**Date:** 2026-09-04  
**Scope:** test whether a coherent first-order research ground exists before discovering children

## 1. Decision under test

The inherited working hypothesis is:

> There is a first-order `Information / Representation State` research ground distinct from Environment / actual reality, Work and Actors, and Records / Persistent Information is a specialised region within it.

N1 did not ask what its children are. It attacked four rival possibilities:

1. **reduction** — everything here is only a property/relation of Environment, Work or Actors;
2. **residual bucket** — `Information` means anything describable and therefore has no useful boundary;
3. **mixed levels** — observation, representation, belief, evidence, context and persistence are not comparable kinds;
4. **label error** — `Information`, `Representation` and `State` carry materially different scopes.

## 2. Cross-domain structural probes

### 2.1 Partially observable decision/control models

POMDP work sharply distinguishes:

- underlying environment/world state;
- observations received by an agent;
- a belief state estimating the underlying state from observation/action history.

The important point for this research is not the probabilistic formalism. It is the independent need to represent **actual state, informational access to that state, and an internal estimate/model of that state as non-identical**.

This supports the Environment-local anti-collapse rule already recovered internally.

Sources:

- Kaelbling, Littman & Cassandra, *Planning and acting in partially observable stochastic domains*, Artificial Intelligence 101 (1998), DOI 10.1016/S0004-3702(98)00023-X.
- Kaelbling, *POMDP Approach* / state-estimator discussion: https://www.cs.cmu.edu/afs/cs/project/jair/pub/volume4/kaelbling96a-html/node56.html
- Cassandra et al. retrospective/tutorial material: https://cassandra.org/arc/talks/aaai2013/index.html

### 2.2 Observation and measurement models

ISO/OGC Observations & Measurements distinguishes:

- the feature/property of interest;
- the **act/procedure of observation**;
- the observation result, which estimates a property value;
- temporal/procedural metadata needed to interpret that result.

This matters because `observation` is not simply another informational object type. It can be a process/relation that produces a result representation about a referent.

Source:

- OGC Timeseries Profile of Observations and Measurements, based on ISO 19156: https://docs.ogc.org/is/15-043r3/15-043r3.html

### 2.3 Provenance models

W3C PROV models provenance through entities, activities, agents and typed relations such as generation, use, derivation, attribution and delegation.

The structural lesson is that provenance is not naturally a standalone sibling type of information. It is often **relational information about how an informational or other entity came to be, through what activity and under whose responsibility**.

Source:

- W3C PROV-DM: https://www.w3.org/TR/prov-dm/
- W3C PROV Constraints: https://www.w3.org/TR/prov-constraints/

### 2.4 Evidence / epistemic support

Epistemology treats evidence as something that bears on or supports/challenges a target belief, proposition or hypothesis. Competing evidence can alter the support relation.

The structural lesson is that `evidence` should not automatically be modeled as a content subtype. **Evidential standing is at least partly a role/relation between informational content and a target claim/question under a body of other evidence.**

Source:

- Stanford Encyclopedia of Philosophy, *Evidence*: https://plato.stanford.edu/entries/evidence/

### 2.5 Mental representation

The mental-representation literature supplies two useful falsifiers to simplistic Information framing:

1. the same representational content may participate in different attitudes/relations such as belief, desire or fear;
2. causal/informational correlation is not sufficient for representation — many physical indicators can carry information without representing in the relevant semantic sense.

Therefore:

- `belief` is not necessarily an information-object subtype;
- `information` and `representation` are not synonyms.

Source:

- Stanford Encyclopedia of Philosophy, *Mental Representation*: https://plato.stanford.edu/entries/mental-representation/

### 2.6 Semantic vs engineering information

Shannon's communication theory deliberately abstracts away semantic meaning to solve a different engineering problem: selection/transmission of messages under uncertainty.

Modern philosophy-of-information work likewise treats semantic information as one region among several uses of `information`.

Structural consequence:

> A parent named simply `Information` is dangerously polysemous for this project.

It may include syntactic/statistical distinctions that are technically important but do not by themselves define the semantic/epistemic representation problem under study.

Sources:

- Claude Shannon, *A Mathematical Theory of Communication* (1948).
- Stanford Encyclopedia of Philosophy, *Semantic Conceptions of Information*: https://plato.stanford.edu/entries/information-semantic/

### 2.7 Context

Context-aware computing provides deliberately broad operational definitions of context as information used to characterize an entity's situation. Related work also treats context as relational/interactional rather than an intrinsic object category.

This is useful mainly as a warning:

> `Context` can expand to almost any relevant information unless the **relative-to-what / used-for-what** relation is explicit.

Source:

- Anind K. Dey, *Understanding and Using Context* (2001): https://kilthub.cmu.edu/articles/journal_contribution/Understanding_and_Using_Context/6470603

## 3. Rival judgments

### Rival A — independent broader ground

**Status: survives / strengthened, but only as a research problem region.**

Across control/decision theory, measurement, provenance, epistemology and cognitive representation, recurring problems appear around informational access, representation, interpretation, derivation and standing that are not identical to the actual referent/domain state.

The commonality is not that all these things are one ontology class.

The commonality is:

> **a mediated informational state/process/relation can diverge from what it is about and therefore requires its own semantics for what is represented, how it arose, whose/which view it is, how strongly it is supported, when it applies, and how it is transformed or preserved.**

This is coherent enough to continue as a foundation **research ground**.

### Rival B — reduce everything to Environment / Work / Actors relations

**Status: not supported as a complete reduction; remains a useful ontology-level caution.**

Many Information semantics are relational and should indeed connect Environment, Work and Actors. But reduction loses a recurring intermediate problem surface:

- observation/result can be wrong or partial while Environment is unchanged;
- a belief/model can change while its referent is unchanged;
- a derived view can differ in coverage/freshness from its source;
- a shared assertion/proposition can exist independently of one Actor's current participation;
- persistence can preserve an informational state whose truth/authority later changes.

These differences require research even if a later ontology implements them largely through relations.

### Rival C — current parent mixes unlike levels

**Status: CONFIRMED as a risk.**

The inherited candidate list mixes:

- processes (`observation`, `inference`, transformation);
- representational results/states (`measurement result`, model, claim);
- epistemic roles/relations (`evidence`, authority/support);
- use-relative views (`context`);
- lifecycle conditions (`persistence`).

Therefore the adequacy-stage child sketch must **not** be promoted as a hierarchy.

### Rival D — parent label/framing error

**Status: materially live.**

- `Information` is too polysemous unless bounded.
- `Representation` excludes some causal/signal/data senses of information and may imply semantic aboutness too early.
- `State` underplays formation, observation, inference, derivation and transformation processes.
- `Epistemic State` may be too narrow because some representations are operational/descriptive without a knowledge/justification role.

N1 therefore retains `Information / Representation State` only as the **current repository routing label**, not as a settled conceptual name.

## 4. Parent coherence criterion after N1

The parent survives if its scope is understood provisionally as:

> **the problem region of mediated informational access to and representation of referents/subjects, including the informational products and transformations whose content, source, derivation, perspective, uncertainty/standing, temporal applicability, selective exposure and persistence can vary independently of the referent itself.**

This is intentionally a research-scope description, not an ontology definition.

## 5. Anti-residual boundary

The ground is **not** `anything that can be described`.

A phenomenon belongs here for current research purposes only when the load-bearing question concerns the informational mediation itself, for example:

- what is being represented / about what;
- what signal/observation/result is available;
- what content/assertion/model is formed;
- where it came from or how it was derived;
- what holder/perspective/view it belongs to;
- what confidence/support/standing/freshness applies;
- what selection/compression/context boundary exposes it;
- what persistence changes its lifecycle obligations.

If the load-bearing question is instead the actual condition, the Work phenomenon, or Actor identity/authority/participation itself, route to that neighbouring ground.

## 6. N1 verdict

**PROVISIONAL PASS.**

A coherent first-order research problem region exists strongly enough to continue.

But N1 falsified any assumption that:

- the current label is final;
- observation/belief/evidence/context/Records are already comparable immediate children;
- a later ontology must contain one `Information` primitive/class;
- every information relation needs a separate informational object.

## 7. Next phase

Proceed to N2 first-principles problem inventory under the revised parent coherence criterion.

N2 must derive problem families from failure/semantic questions first and only later ask which of them cluster into stable immediate children.
