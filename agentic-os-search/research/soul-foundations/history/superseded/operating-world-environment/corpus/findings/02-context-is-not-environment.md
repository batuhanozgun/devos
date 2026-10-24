# Environment Finding 02 — Context is not safely reducible to `the environment`

**Status:** current Environment-local bounded finding  
**Date:** 2026-09-01  
**Scope:** context/environment distinction; not a fourth-leg or architecture decision.

## Question

Can Environment research use `context`, `situation` and `environment` as interchangeable labels for a stable set of facts surrounding Work or Actors?

## Finding

No. Current evidence supports at least two materially different context framings, and both reject a simple `context = environment` shortcut.

1. An operational context-aware-computing frame treats context as **information relevant to characterising the situation of entities involved in an interaction**. Relevance to the application/interaction is load-bearing; not every environmental fact is context.
2. An interactional frame argues that contextual relevance cannot always be fixed in advance as a stable bag of external attributes. What counts as context can be relational, occasion-specific and produced or changed through the activity itself.

Therefore Environment research must keep separate:

- the world/settings/resources/conditions that exist;
- information representing some of those conditions;
- the subset currently relevant to an Actor/Work/interaction;
- and the activity-dependent process by which something becomes contextually relevant.

This distinction matters directly to the fourth-leg test. If `Environment` survives as a foundation region, `context` should not simply become its generic metadata field. Conversely, the dynamic/relevance-dependent nature of context may indicate that some Environment semantics belong in typed relations with Work/Actors rather than in an independent object region.

## Evidence

### Dey — Understanding and Using Context

Dey explicitly notes that definitions using `environment` or `situation` merely as synonyms for context are difficult to apply. The paper instead defines context operationally through information that characterises the situation of an entity relevant to interaction between a user and an application. It also notes that which situational aspects matter changes across situations.

The same paper later treats context history as information that can be stored, which is useful for another boundary: current context/world conditions and persistent Records about those conditions are not automatically the same thing.

Primary source:
- Anind K. Dey, `Understanding and Using Context` (2001)
- https://sites.cc.gatech.edu/fce/ctk/pubs/PeTe5-1.pdf

### Dourish — What We Talk About When We Talk About Context

Dourish critiques a common representational stance in which context is assumed to be stable, separable from activity and specifiable in advance as features of an environment surrounding generic activities. The interactional alternative treats contextuality as relational and dynamically scoped; what becomes relevant can emerge during activity, and context can be produced and maintained in interaction.

Primary source:
- Paul Dourish, `What We Talk About When We Talk About Context` (2004)
- https://www.dourish.com/publications/2004/PUC2004-context.pdf

## What this changes in the research frame

### Weakened / rejected

- `context = environment` as a synonym rule;
- one static `context` record containing all relevant environmental facts;
- assuming contextual relevance is independent of Work, Actor, interaction or time;
- equating the persisted representation of context with the live conditions being represented.

### Strengthened

- distinction between world/environmental state and contextual relevance;
- context as relation- or activity-dependent;
- explicit current-state versus recorded-history distinction;
- need to test whether context belongs partly to relation/control semantics even if a substantive Environment region exists.

### Still open

- which environmental facts require first-order current state independent of Records;
- which context can be pre-modelled and which must emerge during execution;
- how relevance should be bounded for machine agents and automated Work rather than human-computer interaction alone;
- whether interactional context generalises beyond HCI/social practice sufficiently to constrain SOUL foundation design.

## Falsification / challenge note

The two sources are intentionally not collapsed into one theory. Dey provides an operational representational definition; Dourish challenges the completeness of that stance. The bounded finding is the overlap: neither supports treating Environment and context as one stable undifferentiated category.