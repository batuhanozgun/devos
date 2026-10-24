# Source Ledger — Digital Preservation, Authenticity and Trust

**Research role:** determine what must survive for information to remain understandable, trustworthy and usable over time; distinguish bit persistence from preservation of meaning and record identity.

## 1. OAIS Reference Model — CCSDS 650.0-M-3, December 2024

Source:
- https://ccsds.org/Pubs/650x0m3.pdf

Observed:
- OAIS distinguishes a Data Object from the Representation Information needed to interpret/use it.
- Structure information alone may be insufficient; semantic information, standards, software, algorithms, encryption information or instructions can be required.
- Representation Information can itself require additional Representation Information, forming a network that terminates only when the designated community can understand/use the information.
- OAIS explicitly states that preserving the meaning of an Information Object requires preserving its Representation Information.
- Preservation Description Information includes at least Reference, Provenance, Context, Fixity and Access Rights information.
- Fixity is used to detect undocumented alteration of a particular Content Data Object; it is not the whole of preservation or authenticity.
- OAIS warns that community knowledge changes over time, so information that is interpretable today can become effectively lost even when bits survive.

Research implication:
- `bytes survived` and `information survived` are different claims.
- Long-term persistence has an interpretation dependency closure: format/structure, semantics, relevant software/algorithms/instructions and community knowledge may matter.
- Preservation objective matters. There is no evidence here for one universal list of metadata that every record must carry.

## 2. PREMIS Data Dictionary for Preservation Metadata, Version 3.0

Source:
- https://www.loc.gov/standards/premis/v3/

Observed:
- PREMIS is an implementation-oriented preservation metadata model built around four entities: Objects, Events, Rights and Agents.
- This reinforces that preservation metadata is not merely descriptive metadata about an object; preservation actions/events, responsible agents and rights are also recorded.

Research implication:
- Long-term management often needs a history of what happened to an object, not only its current representation.
- Preservation actions themselves can become records about records.

Caveat:
- PREMIS is a digital-preservation data dictionary, not a universal ontology of persistent information.

## 3. InterPARES authenticity research

Source hub:
- https://www.interpares.org/ip1/ip1_atf

Relevant official project materials linked from that hub examine authenticity requirements for electronic records.

Observed from InterPARES authenticity work:
- Identity and integrity are treated as distinct dimensions of authenticity.
- Identity can depend on attributes such as author/originator/addressee, action or matter, dates, archival bond and attachments.
- Integrity concerns whether a record remains complete and unaltered in relevant respects and may depend on procedural controls, annotations and documented technical modifications.
- In digital environments, authenticity can depend on an unbroken and documented chain of custody/management and controlled reproduction or migration rather than on preservation of one supposedly untouched physical original.

Research implication:
- `same bits`, `same record`, `authentic record`, and `trustworthy record` are not equivalent claims.
- Migration/conversion should not automatically be classified as corruption. It can be a preservation operation if identity, relevant properties and provenance are controlled.

Caveat:
- Exact InterPARES requirements are rooted in archival/diplomatic theory. We use them as strong evidence for identity/integrity distinctions, not as direct SOUL requirements.

## 4. NARA records-management and continuity principles

Source:
- https://www.archives.gov/records-mgmt/faqs/general.html

Observed:
- NARA defines records management as systematic control across creation, maintenance/use and disposition.
- Maintaining records includes organisation and retrieval tools such as file plans, indexes, controlled vocabularies, taxonomies and data dictionaries, plus access/security controls.
- Records must be protected from inappropriate loss/removal and remain findable when needed.

Research implication:
- Preservation has operational dimensions: not losing the object, retaining enough organisation to find it, and controlling access.

## Working decomposition of persistence goals

This is a synthesis from the sources above, not a standard taxonomy:

1. **Bit/object persistence** — some representation continues to exist.
2. **Fixity/integrity evidence** — undocumented alteration can be detected or bounded.
3. **Interpretability** — structure/semantics/dependencies needed to understand/use the representation remain available.
4. **Identity/provenance continuity** — it remains possible to establish what the object is, where it came from, and how it changed.
5. **Context/relationship continuity** — relevant connections needed for meaning/evidence survive.
6. **Access/usability continuity** — authorised future users can locate and practically use it.

The relative importance of these dimensions depends on the preservation objective, risk, and record type. The research should not turn this into a mandatory schema prematurely.