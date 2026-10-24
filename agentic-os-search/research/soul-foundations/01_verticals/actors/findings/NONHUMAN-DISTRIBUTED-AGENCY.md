# Actors Finding — Non-Human and Distributed Agency

**Status:** current topic finding  
**Scope:** Actors-local distinctions; not an AI personhood decision

## Current finding

`Is this system an Actor?` does not have one context-free yes/no answer that preserves all relevant semantics.

Different disciplines use `agent` or system-level agency for different purposes: operational action, computational messaging, provenance responsibility, legal attribution, cognitive system analysis, or moral/legal personhood. These senses must not be silently merged.

## Distinctions to preserve

### 1. Operational agency ≠ legal personhood

An automated system may select or carry out actions without the legal framework treating the system as the legal bearer of those actions.

UNCITRAL's Model Law on Automated Contracting is a strong example: automated systems carry out actions, while Article 7 provides rules for attributing those actions to persons.

### 2. Provenance agent ≠ moral/legal agent

W3C PROV includes software agents among common agent categories because its task is provenance and responsibility for activities/entities. This does not turn the technical `SoftwareAgent` category into a claim about moral agency or legal personality.

### 3. Joint system performance can be a legitimate analysis level

Cognitive Systems Engineering argues that some human-machine systems are better analysed as adaptive or joint cognitive systems than as isolated human and machine components. This is evidence that the useful system boundary can sometimes be a coupled arrangement.

### 4. Distributed operational contribution ≠ diffuse accountability

A system-level operational analysis does not determine who is authorized, obligated, legally responsible or accountable. Those relations can still attach to particular people, organizations, roles or forums.

### 5. Computational `Actor` is a separate technical abstraction

The Actor Model in computing uses `actor` as a message-passing/concurrency abstraction. Its terminology demonstrates domain-specific semantic overload: calling a software component an actor in that model does not answer the normative questions studied in this vertical.

## Decision-critical implication

The human-default assumption and the opposite `all autonomous systems are Actors in the same sense` assumption are both rejected.

A later synthesis must preserve the possibility that the same non-human system is:

- an operational participant or action source;
- a software/provenance agent;
- part of a larger joint socio-technical system;
- not the legal bearer to whom an action is attributed;
- not automatically the party that holds authority, obligation or accountability.

The correct abstraction depends on the semantic question, not on a universal Actor status bit.

## Evidence used

### UNCITRAL Model Law on Automated Contracting

Inspected view:
- official UNCITRAL web/publication surfaces for the 2024 Model Law and Article 7 attribution text.
- Direct PDF re-open was blocked by a 403 response during the later source-fidelity check; claims are restricted to official exposed text.

Source:
- https://uncitral.un.org/en/mlac

Supports:
- operational automated action can be distinguished from legal attribution to a person.

### W3C PROV-DM

Inspected view:
- W3C Recommendation, section 5.3.1 Agent, including common Person, Organization and SoftwareAgent categories.

Source:
- https://www.w3.org/TR/prov-dm/

Supports:
- software can be treated as an agent for provenance purposes.

Use limitation:
- PROV's agent concept is purpose-specific and is not evidence of moral/legal personhood.

### Hollnagel & Woods — Cognitive Systems Engineering / Joint Cognitive Systems

Inspected views:
- publisher abstract for `Cognitive Systems Engineering: New wine in new bottles`.
- accessible text for Woods' discussion of joint human-machine cognitive systems.

Supports:
- in some operational analyses the coupled human-machine system is a meaningful unit;
- decomposition into isolated components can miss adaptive system behaviour.

View limitation:
- the full publisher text of every cited historical paper was not inspected; claims are limited to the analysis-unit proposition visible in the abstract/accessed text.

### Computational Actor Model

Inspected views:
- ACM/secondary scholarly descriptions identifying the Actor Model as a message-passing concurrency model originating in the 1970s.

Use limitation:
- the original 1973 paper was not recovered directly in this pass, so this example is used only to demonstrate terminology overload and carries no load-bearing conceptual conclusion.

## Residual uncertainty

- Criteria for autonomous agency, intentional agency, moral agency and legal personhood remain discipline-specific and contested.
- The foundation does not need to resolve AI personhood to preserve the more basic distinction between operational participation and normative attribution.
