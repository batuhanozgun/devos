# Returned Influence — G7 Adversarial Closure

**Status:** COMPLETE / BOUNDED LEAF FOR USER EVALUATION  
**Date:** 2026-09-11  
**Review type:** same-model adversarial review plus executed synthetic checks; not independent replication.

## 1. What was challenged

The G6 candidate was a single reference-relative returned-influence grammar with separate topology, operative use, episode-contribution and downstream-effect claims. The closure question was whether that retained real distinctions or merely concealed a missing child.

## 2. Strongest attacks and outcomes

| Attack | Resolution | Outcome |
|---|---|---|
| 'Feedback must visibly change behavior' | Operating feedback can produce hold; S3 is a primary counterexample | Original shorthand corrected, not defended |
| 'Then every unchanged output proves feedback' | Blind and coupled functions can share the same output | Rejected; evidence of operative use remains necessary |
| 'Single-signal deletion is the definitive test' | Redundant/joint inputs defeat universal individual necessity | Rejected; accepted actual-cause configuration semantics retained |
| 'Any information that changes anything is feedback' | Require a relevant bounded system/pursuit and return relation | Grammar narrowed |
| 'A new requested goal is always feedforward; any forecast is never feedback' | Role depends on functional binding and boundary, not tense or message label | Universal lexical routing rejected |
| 'Receiving and rejecting a signal is always a feedback failure' | Filtering may be an informed response at a triage locus; it is not automatically influence on the protected operational decision | Exact response locus retained |
| 'Informed decision means loop succeeded' | Actuation or target realization can fail independently | End-to-end claim separated |
| 'False or spoofed input means no real causal influence' | Influence may be real while claimed source condition or authority is false | Signal, source claim and influence kept separate |
| 'A same-model critique cannot be feedback' | It can affect revision; that does not make it independent evidence or beneficial | Source identity separated from causal role and efficacy |
| 'More internally consistent reports make the original claim truer' | Shared-origin repetition can preserve the same error | Corroboration inference rejected |
| 'Physical control proves every feedback instance belongs here' | Ground-local dynamics remain local unless cross-ground semantics are constitutive | No Environment takeover |
| 'Distinct claim levels require four children' | These are existence/activation/instance/effect scopes of the same relation; standalone causal proof routes to existing research | No promotion |
| 'The parent proved complete logical independence of feedback and adaptation' | One-time adaptation can still depend on historical feedback; the protected questions are distinct and non-coextensive | Overstrong independence wording qualified |

The review did not produce a clean 'nothing changed' verdict. Parent wording was materially improved. It did not produce a further first-order research region at this depth.

## 3. Executed synthetic counterexamples

Seven local Python checks were executed on explicitly supplied toy functions. They are constructive logical examples, not empirical observations of an agent or deployed control system.

### Functions and cases

A coupled controller selects `increase` below 95, `decrease` above 105 and `hold` otherwise. A blind controller always selects `hold` and ignores the input. An independent toy alarm uses `a OR b`.

| Check | Observed output | What it establishes in this construction |
|---|---|---|
| Coupled and blind at 100 | Both output hold | Output alone does not discriminate use |
| Perturb input to 110 | Coupled decreases; blind holds | This perturbation distinguishes these specified functions |
| Coupled inputs 99 and 102 | Both hold | Different operative readings need not change output |
| OR alarms (1,1), (0,1), (1,0), (0,0) | true, true, true, false | Single ablations can miss configuration relevance |
| Sample occurrence20 arrives21 with value110; occurrence10 arrives22 with value90 | Arrival-latest increases; condition-latest decreases | Arrival order need not preserve condition order |
| Two reports derived from origin probe_1 | 2 reports, 1 origin | Message count is not independent-origin count |
| Coupled decision decreases; actuator failure flag false | Decision decrease, realized change none | Decision-side feedback does not establish actuation |

All seven asserted relationships passed. The synthetic controller's `sample_used` marker was defined by construction, not measured from a real opaque system. Its availability here must not be assumed in SOUL.

### Minimal reproduction of the executed relationships

```python
from itertools import product

def coupled(y):
    return 'increase' if y < 95 else 'decrease' if y > 105 else 'hold'

def blind(y):
    return 'hold'

assert coupled(100) == blind(100) == 'hold'
assert coupled(110) != blind(110)
assert coupled(99) == coupled(102) == 'hold'
assert [bool(a or b) for a, b in product([0, 1], repeat=2)] == [False, True, True, True]
samples = [(20, 21, 110), (10, 22, 90)]  # occurrence, arrival, value
assert coupled(max(samples, key=lambda s: s[1])[2]) != coupled(max(samples, key=lambda s: s[0])[2])
reports = [('summary_A', 'probe_1'), ('summary_B', 'probe_1')]
assert len(reports) == 2 and len({origin for _, origin in reports}) == 1
actuator_ok = False
realized_change = coupled(110) if actuator_ok else 'none'
assert coupled(110) == 'decrease' and realized_change == 'none'
```

This reproduction is not a proposed controller implementation. The checks cannot establish how often these failures occur, how a live LLM uses feedback, or whether the Foundation taxonomy is uniquely correct.

## 4. Why remaining questions are not hidden completion debt

No current load-bearing source gap remains for the hold, return-reference, decision-versus-actuation or observation-frame distinctions. Accessible primary material supplied each required pressure. Optional educational full texts and a visually inaccessible lecture PDF were not used as decisive evidence.

Remaining questions concern evidence for opaque consumers, latent rare-case response, densely coupled loops and what makes history-dependent change persistent. The first two retain uncertainty in this leaf; persistent change belongs to the separately authorized future sibling pass. These do not imply that this pass solved all mechanisms or every domain.

## 5. Final structural judgment

```text
Cross-Ground Feedback / Returned Influence
    ← BOUNDED LEAF
    ← reference-relative operative-return grammar
    ← no immediate child promoted
    ← parent wording refinements disclosed
    ← USER EVALUATION PENDING
```

The two-child Feedback/Adaptation parent remains supported. No ground, composition-sibling or causal-parent structural reopen is currently required. The narrow parent refinements are proposed by this child result, not silently treated as already user-accepted new research.

## 6. Next responsibility and stop

Finish current state/router/manifest synchronization and readback, then return the result to the user. Recommend Persistent Adaptation / Future-Response Change only after evaluation. Do not start it automatically.

This document's research completion does not certify repository closure by itself. `CURRENT-SURFACES.md` and ancestor readback bind that separate claim.

## 7. Verification boundary

External evidence is independently authored component-level pressure. G7 is not a second researcher/model's replication. The toy checks establish their specified relationships only. User acceptance would close the evaluation gate, not transform these evidence limits.
