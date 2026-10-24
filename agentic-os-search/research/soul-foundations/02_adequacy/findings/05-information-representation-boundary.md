# Finding 05 — Information / Representation Boundary

**Status:** current focused adequacy finding  
**Question:** Is Records / Persistent Information adequate as the top-level information ground, or is it a narrower branch of a broader first-order problem region?

## Starting tension

The Records vertical was deliberately scoped to **persistent information-bearing resources** and the semantics needed for future identification, interpretation, retrieval, reconstruction, history, standing, retention and disposition.

SOUL and Development OS, however, explicitly distinguish and use additional information-like phenomena:
- current state;
- memory;
- selectively assembled context;
- knowledge;
- evidence;
- observations;
- assumptions/inferences;
- transient work/session information.

The question is not whether these should all become one store. The question is whether the top-level research ground must cover the semantics of **representation/information state** before persistence-specific Records questions are selected.

---

# 1. External traditions repeatedly separate reality from information about reality

## POMDP / agent–environment tradition

A hidden environment/world state can generate an observation that only partially reveals it. Agent action affects environment transition, while observation is an information channel about the resulting state.

Therefore:

> actual state ≠ observation

and observation can be incomplete/noisy without the world itself being incomplete/noisy.

## STAMP / control tradition

STAMP distinguishes the controlled process from the controller's process model and feedback about the controlled process.

A controller can act consistently with its internal model while that model is wrong about the true process state.

Therefore:

> controlled reality ≠ feedback ≠ controller model

## Situation Awareness tradition

Situation-awareness models distinguish:
1. perception of environmental elements;
2. comprehension/meaning of the perceived information relative to goals;
3. projection of likely future state.

This again makes representation and interpretation of dynamic reality a first-order problem rather than merely a persistence problem.

## BDI / agent programming tradition

Beliefs represent an agent's information/model about its environment and itself. They may be incomplete, uncertain, outdated or false and are updated through perception/reasoning.

Goals/desires and intentions are then related to but distinct from that informational state.

Therefore:

> belief/informational state ≠ world truth  
> belief ≠ goal  
> belief ≠ chosen course of action

## Work System Theory

Work System Theory places `information` alongside processes/activities, participants and technologies as a central work-system element. It does not restrict information to durable records.

### Cross-tradition result

Materially different traditions repeatedly require a first-order distinction between:
- reality/state of affairs;
- signals/observations/data received about it;
- interpreted or believed/modelled information state;
- selected context relevant to a current purpose;
- persistent records retained across time.

---

# 2. Why Records cannot simply be stretched to cover all of this

The Records corpus's strongest semantics arise specifically because information must survive and remain usable over time:
- persistent identity and version/representation binding;
- provenance/history/standing;
- preservation closure;
- retrieval contracts;
- retention/disposition;
- reconstructability.

A transient sensor observation, temporary role context or short-lived belief may never require these obligations.

Calling every such representation a `Record` would erase the very appraisal distinction established by Records research: persistence obligations are purpose- and horizon-dependent, not universal.

Therefore:

> **nonpersistent representation ≠ Record merely because it carries information**

---

# 3. Why representation/information cannot be fully reduced to Actors or Work

## Not merely Actor state

Some information is shared/system-level rather than privately held by one Actor:
- shared current-state model;
- common observation stream;
- collaboratively maintained situational picture;
- externally supplied source data;
- intermediate derived representation used by several roles.

Attaching all representation to an Actor would obscure shared/system-level information and provenance.

## Not merely Work state

A representation can:
- predate the current Work;
- be relevant to multiple Work contexts;
- describe domain reality rather than Work itself;
- remain available after Work ends;
- be acquired without immediately becoming committed Work.

Work-relative `context` is one selection/use relation over information, not the whole information phenomenon.

## Not merely relation without relata

Observation, belief, derivation, evidence and context are relational, but relations still connect things with information-bearing content/state whose identity, scope, provenance, confidence, freshness or persistence can matter.

As with Actors and Technical Work Environment, relational representability does not eliminate the underlying analytical problem.

---

# 4. Candidate broader ground

Current working label:

> **Information / Representation State**

Alternative labels to research later:
- Representation / Information;
- Information State;
- Representations / Knowledge State;
- Epistemic / Information State.

No label is accepted yet.

## Candidate questions this ground must support

When material:

1. **referent / subject:** what does the representation claim to be about?
2. **form/content:** what information is represented and in what form?
3. **source/provenance:** how was it observed, asserted, inferred, derived or generated?
4. **epistemic status:** observation, assertion, belief/model, inference, assumption, hypothesis, evidence, decision, etc.;
5. **confidence/uncertainty/coverage:** what is known, unknown, partial or disputed?
6. **temporal scope/freshness:** when is the information about / as-of?
7. **perspective/holder:** whose or which system's representation is it, when that matters?
8. **context selection:** which subset is assembled/exposed for current Work/Actor responsibility?
9. **transformation/derivation:** how do observations become interpretations, summaries, models or claims?
10. **persistence decision:** what must survive, for how long and with what obligations?

The tenth question is where the existing Records research becomes a deep specialised branch.

---

# 5. Relationship to current Records research

The current Records corpus is not invalidated.

A cleaner level alignment is:

```text
Information / Representation State  [candidate broader ground]
    |
    +-- transient observations/signals/context
    +-- beliefs/models/claims/inferences
    +-- evidence/decision-relevant representations
    +-- persistent information / Records  [already deeply researched]
            |
            +-- identity/version/representation
            +-- preservation closure
            +-- history/standing/time
            +-- retrieval/organisation
            +-- retention/disposition
```

This hierarchy is an analytical research hypothesis, not a schema or module tree.

Records' current findings become **strong retained evidence for the persistence branch** rather than a mistaken corpus.

---

# 6. Does this create a sixth peer ground?

Not under the strongest current correction.

If `Information / Representation State` is accepted as the top-level ground, **Records is nested within it rather than remaining a separate peer**.

Combined with the strong Operating World candidate, the current minimum top-level hypothesis becomes five problem grounds:

1. Operating World / Work Domain / Domain Reality;
2. Information / Representation State — with Records as its persistence branch;
3. Work;
4. Actors;
5. Technical Work Environment.

Typed relation/control/transition semantics compose these grounds.

This is not yet accepted as final; it is the strongest level-aligned rival produced so far.

---

# 7. Falsifiers / reopen conditions

This broader-ground hypothesis weakens if later challenge shows that:

- nonpersistent observations/beliefs/context can be represented fully and non-lossily as local properties/relations of Work, Actors and World without independent representation semantics;
- the proposed ground becomes an undifferentiated `all information` residual bucket with no stable failure families;
- persistent Records semantics cannot be cleanly nested without losing their independent requirement-derivation logic;
- materially different domains do not need distinctions among observation, belief/model, context and record.

Current external evidence points in the opposite direction, but the claim remains research-level.

---

# Focused verdict

**Records / Persistent Information is a strong first-order problem region, but it is probably one level too narrow to serve as the complete top-level information ground for general-purpose SOUL.**

The stronger current hypothesis is:

> **Information / Representation State is the broader first-order problem ground; Records is its already-researched persistent-information branch.**

Confidence:
- strong that `world state ≠ observation/representation`;
- strong that `representation ≠ persistent Record`;
- moderate-to-strong that a broader representation/information ground is analytically useful and productive;
- not yet a final naming, ontology or architecture decision.
