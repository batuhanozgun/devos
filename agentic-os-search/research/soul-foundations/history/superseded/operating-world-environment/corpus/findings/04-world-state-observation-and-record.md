# Environment Finding — World State, Observation and Record Must Not Collapse

**Status:** current bounded Environment-local finding  
**Scope:** live world/effect state versus observation/belief/persistent Records; not a SOUL state-model decision

## Question

Can relevant world/environment state be represented without loss as what an Actor observes or what Records persist?

## Current finding

**No. Actual/current world state, observations of that state, an Actor/system's belief or knowledge about it, and persistent Records of observations/assertions are separable when uncertainty, delay, hidden state or change matters.**

The distinction survives across decision theory, control and the completed Records/Work findings.

## Evidence discrimination

### POMDP / decision-process evidence

Poole & Mackworth's POMDP formulation explicitly separates:

- `S`: states of the world;
- `O`: possible observations;
- environment dynamics `P(S' | S,A)`;
- the Actor's belief state, updated from observations/actions and carrying remembered history.

A partially observable environment exists precisely because the current world state need not be directly available to the Actor. Observation can therefore be incomplete or noisy, and belief can diverge from state.

### Control evidence

Åström & Murray's feedback-system treatment separately models process dynamics, measured signals, sensing noise and external disturbances. The controlled process can be perturbed by conditions that are not identical to the measurement presented to the controller.

This independently rejects a `measured state = actual state` shortcut.

### Records boundary

The completed Records vertical already distinguishes effective/applicable domain time from system-known/recorded time and explicitly warns that correct persistence establishes what was recorded/known, not the underlying factual truth.

Therefore a persisted observation or assertion can be accurate, stale, partial, disputed or simply a historical statement about what was believed.

### Work boundary

The completed Work vertical found that execution can have externally visible partial effects and that failure/compensation does not necessarily restore the prior world. A Work lifecycle state cannot therefore be assumed to encode the full external effect state.

## Counter-tests

### Reduce world state to Records

Fails under hidden/unobserved change. Example: the network fails, room temperature rises, a third-party API changes, stock is consumed elsewhere, or a physical object moves before the system records it. The external state changed even if no new Record exists.

### Reduce world state to Actor belief/context

Fails under mistaken or delayed belief. The Actor can believe a resource is available while the world state says otherwise, or vice versa.

### Reduce world state to Work state

Fails when the same external condition affects multiple Work units or exists before/after a particular Work item. `blocked`, `failed` or `complete` may be consequences of world state, not substitutes for it.

## Decision-critical implication

A future coherent system account must preserve, when material, a causal/informational chain more like:

> **world state/dynamics → observation/sensing → belief/interpretation → persistence/evidence**

with Work actions able to affect the world and exogenous/environmental processes able to change it independently.

The exact implementation and whether `world state` becomes an architecture component remain later decisions.

This is the strongest current evidence that the candidate Environment region contains a problem that cannot be eliminated merely by saying `everything relevant is a Record`.

## Sources / recovery

- Poole, D. L. & Mackworth, A. K., *Artificial Intelligence: Foundations of Computational Agents*, 3rd ed., §12.5.5 POMDPs: https://www.cs.ubc.ca/~poole/aibook/3e/html/ArtInt3e.Ch12.S5.html
- Åström, K. J. & Murray, R. M., *Feedback Systems*, Ch. 1: https://www.cds.caltech.edu/~murray/books/AM08/pdf/am08-intro_09Aug12.pdf
- Records `../../records-artifacts/synthesis/current/CHANGE-TIME-STANDING.md`.
- Work `../../work/findings/CONTROL-STATE-CLOSURE-AND-RECOVERY.md`.

## What this does not prove

- that the whole external world must be modeled or persisted;
- that a particular probabilistic/POMDP representation is required;
- that the Environment region is a fourth module;
- that every observation needs a separate Record;
- that factual truth is always knowable.