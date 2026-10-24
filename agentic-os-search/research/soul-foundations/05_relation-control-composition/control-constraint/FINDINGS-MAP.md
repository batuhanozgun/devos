# Control / Constraint — FINDINGS MAP

**Status:** current result router  
**Date:** 2026-09-05

## Read this first

Shortest accepted-under-evaluation result: `KEY.md`.

Integrated explanation: `synthesis/CONTROL-CONSTRAINT-SYNTHESIS.md`.

Final adversarial result: `K7-ADVERSARIAL-CLOSURE.md`.

## Main finding map

| Question | Current answer | Best surface |
|---|---|---|
| Is Control a coherent composition region? | Yes, boundedly | `K6`, `K7`, synthesis |
| Is Control just Actors authority? | No | `K2`, `K7 Attack A` |
| Is Control just Standing? | No | `K2`, `K7 Attack B` |
| Is Control just Environment enforcement? | No | `K1`, `K7 Attack C` |
| Is Control just Work gate/review? | No | `K3`, `K7 Attack D` |
| Is Control just policy/config Information? | No | `K2`, `K5`, `K7 Attack E` |
| What is the minimum semantic core? | governed focus + governing basis/objective + mode + applicability + current validity | `K1`, `K6` |
| Is authority universal? | No; required where legitimacy is constitutive/material | `K1`, `K2`, `K7 F/L` |
| Are policy, decision, enforcement, monitoring the same? | No | `K2`, `K5` |
| Are they immediate children? | No | `K4`, `K7 G` |
| What is the major new scope distinction? | governed-effect scope != enforcement-point scope | `K3`, `K6`, `K7 J/K` |
| Is path/bypass only architecture detail? | No when it changes truth of protected control claim | `K3`, `K7 J` |
| Does Effective Power require a fifth child/ground? | No | `K3`, `K4`, `K7 K/R` |
| Are preventive/detective/corrective children? | No; profiles relative to event/effect chain | `K4`, `K7 H` |
| Are permission/prohibition/obligation children? | No; control modes/standings, incomplete universal split | `K3`, `K4`, `K7 I` |
| Does currentness belong entirely to Transition? | No; current applicability stays here, propagation/history deferred | `K3`, `K7 O` |
| Is Control a bounded leaf? | Yes at current Foundation depth | `K6`, `K7` |
| What is next if accepted? | Transition / Effect / Feedback | `K6 §14`, `K7 §26` |

## Strong external holdouts

### Access / cybersecurity
- NIST SP 800-162 ABAC;
- NIST SP 800-207 Zero Trust Architecture;
- NIST SP 800-53 Rev. 5.1;
- OASIS XACML 3.0.

Pressure:
```text
policy != decision != enforcement
request authorization is scope/context-specific
least privilege can fail indirectly through higher-privilege processes
combining/default semantics can change decisions
```

### Governance / systems engineering
- NASA Technical Authority;
- NASA systems-engineering review/decision gates.

Pressure:
```text
project responsibility != formal authority
review Work != go/no-go decision
approval artifact != legitimate scoped approval
```

### Physical / safety control
- OSHA machine guarding/interlocks;
- FAA Safety Risk Management guidance.

Pressure:
```text
Control != authority-only
mechanical controls can govern unsafe transitions
mechanism present != effective if bypassable
preventive/mitigating is an event-chain profile, not universal child
```

### Agentic holdouts
- Anthropic AI-native SDLC/security study;
- multi-agent patterns;
- context/memory/harness engineering.

Pressure:
```text
advisory instruction != deterministic enforcement
direct agent restriction != effective system boundary
role label != authority / independence
one tool/network control != all alternate paths closed
```

## Reusable diagnostic questions

For a future case, ask:
1. What exact behavior/effect is being governed?
2. Under what basis/objective/invariant?
3. What governing mode applies?
4. Does the control apply to this exact subject/action/object/context/time?
5. Is authority/legitimacy material, and is it scoped correctly?
6. Is there a separate decision/gate result?
7. What mechanism, if any, enforces/intervenes?
8. What effect/path universe is the control objective claiming to cover?
9. Does the enforcement point cover that same universe?
10. What evidence/monitoring supports compliance/effectiveness claims?
11. Are exceptions, precedence, conflict/default semantics material?
12. Is the claim current, or did rule/authority/environment state change?

These are research diagnostics, not a schema or runtime algorithm.