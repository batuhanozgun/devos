# Information / Representation State — N5 External and Cross-Domain Falsifiers

**Status:** N5 COMPLETE; two-child split survives materially different external traditions  
**Date:** 2026-09-04  
**Dependency:** `N4-BOUNDARY-ANTI-COLLAPSE.md`

## 1. Purpose

N5 does not ask whether external sources contain the same words as the current project.

It asks whether materially different traditions expose cases that:

- require a missing first-order branch;
- collapse State and Dynamics;
- force Records back into a peer-child position;
- show that context/evidence/quality/accessibility should be separate branches;
- or undermine the parent boundary itself.

No external taxonomy is imported as the SOUL Foundation taxonomy.

---

# 2. Metrology — measurement process vs measurement result

## Sources

- JCGM / BIPM, VIM 3, 2.1 `measurement`: https://jcgm.bipm.org/vim/en/2.1.html
- JCGM / BIPM, VIM 3, 2.3 `measurand`: https://jcgm.bipm.org/vim/en/2.3.html
- JCGM / BIPM, VIM 3, 2.9 `measurement result`: https://jcgm.bipm.org/vim/en/2.9.html

## Structural observation

VIM distinguishes:

- the quantity intended to be measured (`measurand`);
- measurement as a process of obtaining values;
- the measurement result as values attributed to the measurand together with relevant information, commonly including uncertainty.

## Falsifier effect

This independently reproduces:

```text
referent / target reality
    ≠ acquisition process
    ≠ informational result
```

It also shows that uncertainty can be attached to/interpreted with a result rather than requiring `Uncertainty` as a separate object branch.

**Effect on current structure:** strengthens State vs Formation/Dynamics; does not produce a third child.

---

# 3. OGC / ISO Observations & Measurements — observation act/procedure vs result

## Source

- OGC Timeseries Profile of Observations and Measurements, based on ISO 19156: https://docs.ogc.org/is/15-043r3/15-043r3.html

## Structural observation

The model distinguishes:

- feature/property of interest;
- procedure/process used to observe;
- observation event/act;
- result estimating a property value.

The profile explicitly treats the result separately from the procedure that generated it.

## Falsifier effect

`Observation` cannot safely be one peer noun beside `belief`, `context` and `record`.

The external model instead supports the distinction between **informational formation** and **result/state**.

**Effect:** strengthens current two-child candidate.

---

# 4. W3C PROV — entities vs activities and typed derivation

## Sources

- W3C PROV-DM Recommendation: https://www.w3.org/TR/prov-dm/
- W3C PROV Constraints: https://www.w3.org/TR/prov-constraints/

## Structural observation

PROV distinguishes:

- entities;
- activities acting on/with entities;
- generation/use/invalidation;
- derivation;
- agents and responsibility relations.

Provenance itself is information about entities, activities and people involved in producing a thing/data item.

## Falsifier effect

This supports several current anti-collapse rules:

- a state/resource and the activity that produced it are not the same analytical kind;
- provenance is relational information spanning outputs, transformations and actors;
- attribution does not turn Actors into Information children;
- generation/derivation history cannot be recovered merely from output content.

PROV does **not** imply that `provenance` should be a peer Foundation child.

**Effect:** strengthens State/Dynamics and cross-cutting provenance treatment.

---

# 5. Database provenance — output data vs transformation lineage

## Source

- Buneman, Khanna & Tan (2001), *Why and Where: A Characterization of Data Provenance*, ICDT: https://doi.org/10.1007/3-540-44503-X_20

## Structural observation

Database provenance asks where output data came from and which source data/process contributed to its existence. The paper distinguishes different provenance questions even for a query-produced output.

## Falsifier effect

A database view/result can be a well-defined informational state while its lineage/derivation remains an additional problem. Conversely, provenance can be incomplete even when the output value is syntactically valid.

**Effect:** supports the distinction between current informational state and formation/transformation lineage.

---

# 6. Belief revision — belief state vs operations of change

## Source

- Stanford Encyclopedia of Philosophy, *Logic of Belief Revision*, substantively revised 2026-07-29: https://plato.stanford.edu/entries/logic-belief-revision/

## Structural observation

Belief-revision theory represents a belief state/base and separately studies operations such as expansion, contraction, revision, replacement, merge and iterated change.

## Falsifier effect

This is important because it is not a measurement/provenance tradition. Yet it independently requires:

```text
epistemic/informational state
    ≠ operations that change that state
```

Conflict/consistency does not become a separate universal child; it is a condition that drives/qualifies state and change operations.

**Effect:** strong independent support for the two-child structural split; standing/conflict remain cross-cutting/specialised.

---

# 7. Web Annotation — aboutness, role and purpose as relations

## Source

- W3C Web Annotation Data Model: https://www.w3.org/TR/annotation-model/

## Structural observation

The model treats an annotation as a graph relating Body and Target. It preserves:

- body/target;
- source/specific-resource constraints;
- role/purpose/motivation;
- lifecycle/agent information.

The same resource can play a particular purpose/role in an annotation without that role becoming its intrinsic type.

## Falsifier effect

This directly pressures P1/P5/P7/P9:

- aboutness/referent is relational;
- purpose/motivation is relational/use-specific;
- source state can be separately constrained;
- roles do not need peer object categories.

**Effect:** strengthens the decision not to promote `evidence`, `context`, `source` or `purpose` as immediate children merely because they are named roles.

---

# 8. Data quality — intrinsic/contextual/representational/accessibility dimensions

## Sources

- Wang & Strong (1996), *Beyond Accuracy: What Data Quality Means to Data Consumers*, JMIS 12(4): https://www.jmis-web.org/articles/1002
- W3C Data Quality Vocabulary: https://www.w3.org/TR/vocab-dqv/
- W3C Data on the Web Best Practices: https://www.w3.org/TR/dwbp/

## Structural observation

Wang & Strong organise data-quality concerns around intrinsic, contextual, representational and accessibility categories. W3C DQV deliberately supports quality dimensions/measurements/annotations without defining one universal objective quality taxonomy and emphasises fitness-for-purpose judgments.

## Falsifier effect

At first glance these categories resemble possible Information children. Under structural analysis they are better read as **quality/use dimensions over information resources and their use**.

For example:

- timeliness affects many content types;
- accessibility applies across representations;
- contextual quality is task/use-relative;
- believability/reputation depends on source/standing.

**Effect:** rejects importing quality categories as Information children; strengthens cross-cutting-dimension treatment.

---

# 9. FAIR data stewardship — goals for digital resources, not ontology branches

## Source

- Wilkinson et al. (2016), *The FAIR Guiding Principles for scientific data management and stewardship*, Scientific Data: https://doi.org/10.1038/sdata.2016.18

## Structural observation

FAIR defines Findable, Accessible, Interoperable and Reusable principles for digital research objects/data stewardship.

These are implementation-neutral stewardship goals applying across different resource types and workflows.

## Falsifier effect

Findability/accessibility/interoperability/reusability are valuable Information failure/requirement surfaces but do not identify disjoint first-order informational kinds.

**Effect:** supports exposure/access/representation-form as recurrent dimensions, not immediate children.

---

# 10. Context-aware computing — context is relative and potentially unbounded

## Sources

- Dey (2001), *Understanding and Using Context*, Personal and Ubiquitous Computing: https://kilthub.cmu.edu/articles/journal_contribution/Understanding_and_Using_Context/6470603
- widely cited definition and subsequent discussions: context is information used to characterize the situation of an entity relevant to interaction/use.

## Structural observation

The classic context framing is intentionally broad and application/entity-relative. Later context work repeatedly has to constrain which information is relevant to the interaction/task.

## Falsifier effect

If `Context` were promoted as a peer child, it could swallow almost any informational state whenever used in a task.

The stronger structural reading is:

```text
available informational states
    -- selection / projection / filtering -->
contextual working view/state
```

relative to Work/Actor/query/purpose.

**Effect:** strengthens context/view as State + Dynamics + use relation, not a peer child.

---

# 11. Situation awareness — domain pipeline, not universal child taxonomy

## Source

- Endsley (1995), *Toward a Theory of Situation Awareness in Dynamic Systems*, Human Factors 37(1): https://doi.org/10.1518/001872095779049543

## Structural observation

Situation awareness is formed through acquisition/interpretation of information from the environment and supports dynamic decision making; the classic model distinguishes perception, comprehension and projection.

## Falsifier effect

This appears to offer a three-stage taxonomy. But those stages are a **domain model of situated human/operator awareness**, not universal categories of all informational resources.

Structurally they map to:

- information acquisition/formation dynamics;
- formed/interpreted informational state;
- predictive transformation/modeling dynamics.

**Effect:** no missing universal child; supports State/Dynamics while warning against importing cognition-specific stages.

---

# 12. Dataset usage / feedback — use is relational

## Source

- W3C Dataset Usage Vocabulary: https://www.w3.org/TR/vocab-duv/

## Structural observation

DUV represents usage, feedback, citation and consumer experience around datasets. Usage/feedback is associated with datasets and consumer contexts rather than treated as an intrinsic dataset type.

## Falsifier effect

Use, feedback and purpose can generate new informational states and dynamics, but do not require a universal `Use` Information child.

**Effect:** strengthens the Work-relative/cross-ground treatment of context/use.

---

# 13. Persistent information / memory holdout

## Inputs

- completed internal Records corpus;
- `research/studies/context-memory-harness-engineering/04-CROSS-LAYER-SYNTHESIS.md`;
- FAIR long-term stewardship principles as external contrast.

## Structural observation

The internal technical study explicitly separates:

```text
persistence → information survives
memory      → persistent/evolving information has managed recall/update/forget lifecycle
context     → information is model-visible now
```

Records research independently shows persistence activates deep obligations around identity, preservation, history, retrieval and disposition.

## Falsifier effect

This is the strongest possible case for a third child, but it still does not partition the parent cleanly:

- persistent information has State semantics;
- memory/record lifecycle has Dynamics semantics;
- context may be transient or persistent-derived;
- provenance/standing may themselves need persistence.

**Effect:** preserve Records as a high-value persistence specialization/profile, but do not promote it as an immediate peer child at this level.

---

# 14. Cross-domain comparison

| Tradition | State/result distinction | Formation/change distinction | Cross-cutting roles/dimensions | New child forced? |
|---|---:|---:|---:|---:|
| Metrology | yes | yes | uncertainty, traceability | no |
| OGC O&M | yes | yes | procedure/time/property/source | no |
| W3C PROV | entity | activity/derivation | attribution/responsibility/time | no |
| DB provenance | output | query/lineage | source influence/location | no |
| Belief revision | belief state/base | change operations | consistency/priority/strength | no |
| Web Annotation | body/target/state | annotation creation/lifecycle | purpose/role/source | no |
| Data quality | resource/data | quality assessment/change | quality dimensions/use | no |
| FAIR | digital resource | stewardship processes | F/A/I/R requirements | no |
| Context-aware computing | contextual state/view | sensing/selection/adaptation | relevance/entity/use | no |
| Situation awareness | awareness representation | perception/comprehension/projection | goals/attention/working memory | no |
| Records/memory | persistent state/resources | write/update/retrieve/dispose | persistence horizon/authority | no peer child forced |

The comparison does **not** prove universality. It shows declining structural information gain from materially different holdouts.

---

# 15. N5 verdict

No examined external tradition forces a third immediate first-order child or collapses the leading two-child split.

The strongest cross-domain convergence is not on vocabulary but on structure:

> **Informational products/states/results must often be kept distinct from the processes/operations that acquire, generate, transform, select or revise them.**

At the same time, source/provenance, uncertainty, confidence, freshness, evidence role, context relevance, accessibility, quality and persistence repeatedly behave as **relations, dimensions, conditions or specializations crossing those two regions**.

N5 therefore strengthens:

```text
Information / Representation [proposed parent refinement]
    ├─ Informational State / Representational Constitution
    └─ Informational Dynamics / Formation–Transformation
```

Proceed to N6 omission/reduction/rival-decomposition audit.
