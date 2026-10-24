# Environment Finding — Actionability Is Relational

**Status:** current bounded Environment-local finding  
**Scope:** Actor capability / environmental affordance-resource boundary; not a SOUL schema or relation-model decision

## Question

Can whether an action is possible or usable be represented as an Actor capability alone, or does the Environment candidate expose an independently varying condition?

## Current finding

**Actor capability is not sufficient to determine situated actionability.**

The evidence supports at least three separable questions:

1. what the bearer can technically/causally do in an appropriate setting;
2. what the surrounding world/system currently makes available or prevents;
3. whether the relevant action possibility exists for that bearer in that situation.

The third is relational. It should not be silently collapsed into either a stable Actor property or an intrinsic Environment-object property.

## Evidence discrimination

### Actors-local baseline

The completed Actors vertical already established that operational capability is distinct from permission/authority/obligation. NIST ABAC additionally shows that authorization may depend on environment conditions rather than subject attributes alone.

This does not answer the present question: even an authorized and generally capable Actor may be unable to perform the Work because required resources, interfaces or physical/runtime conditions are absent.

### Ecological / affordance evidence

Gibson's affordance account and Greeno's interactionist reconstruction treat affordance and ability as complementary ideas. Greeno explicitly frames affordances for an agent as conditions in the environment relative to constraints to which the agent is attuned.

The discriminating lesson is narrower than adopting ecological psychology as ontology:

> the possibility of action can change while the Actor remains the same, because relevant environmental conditions change.

### Digital/interface counterexample

W3C Web of Things Thing Description represents `InteractionAffordance` as metadata exposing possible interaction choices to consumers through Properties, Actions and Events. The consumer's own capability is therefore not the whole usable interaction surface.

### Runtime counterexample

OCI/NIST container material shows that execution depends on runtime-level conditions such as isolation, namespaces, mounts, resource access and host/runtime support. The same application/work description and software bearer can become executable or non-executable under different runtime conditions.

## Counter-tests

### Reduce to Actor capability

Fails. Hold Actor identity, competence and authorization fixed while changing network availability, mounted resources, physical clearance, temperature limits or external service availability. Feasible actions can change without an Actor change.

### Reduce to Work readiness/state

Insufficient as a foundation explanation. Work may truthfully be `blocked` or `not ready`, but that status is an effect/assessment. It does not preserve *which current condition* makes execution possible or impossible, and the same condition can affect several Work units at once.

### Reduce to an intrinsic Environment property

Also fails. A stair, API, tool, network, doorway or resource is not uniformly an affordance to every Actor/Work combination. Actionability depends on the bearer, goal/activity, interface and current condition.

## Decision-critical implication

The Environment candidate gains a real problem surface here, but not a standalone `Affordance` object family.

A later synthesis must preserve the possibility that:

- Actor capability/competence is one input;
- external/world condition or resource/interface availability is another input;
- situated actionability is a typed relation or derived condition between them and the relevant Work/situation.

This is evidence **against** both `capability = everything the Actor can currently do` and `Environment = bag of affordances`.

## Sources / recovery

- E05 Gibson affordance source in `../evidence/SOURCE-LEDGER.md`.
- Greeno, J. G. (1994), `Gibson's affordances`, Psychological Review 101(2):336–342, DOI 10.1037/0033-295X.101.2.336; PubMed record: https://pubmed.ncbi.nlm.nih.gov/8022965/
- E07 OCI Runtime Specification.
- NIST SP 800-190 container-runtime material: https://csrc.nist.gov/pubs/sp/800/190/final
- W3C WoT Thing Description 1.1: https://www.w3.org/TR/wot-thing-description11/
- Existing Actors finding: `../../actors/findings/CAPABILITY-AUTHORITY-OBLIGATION.md`.

## What this does not prove

- that Environment is a fourth SOUL component;
- that affordance is the right universal vocabulary;
- that resource/tool/interface roles belong inside Environment rather than a later relation/control model;
- that every actionability question requires explicit environmental state.