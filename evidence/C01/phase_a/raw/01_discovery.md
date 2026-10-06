# Phase-A probe: discovery

*Filed for EV-C01-003 with one kind of edit: each library file path is replaced by its source key (`lib:<code>/<stem>`, expanded in EV-C01-003, "Source keys"), because the full paths match the research library's fingerprints. Nothing else is changed.*

## Disciplines (D1–D9)
D1: yes: I tested the strongest alternative frame (choose SOUL's first concrete target use instead of a mechanism) and six other candidates on different layers, and I list the chosen question's load-bearing assumptions so the researchers test them instead of inheriting them.
D2: yes: Two non-evidential pulls pointed toward a convenient question: the task wants one that exercises the measures, and the library proposes a "next narrow question" of its own (DQ01 L113). I based the choice on SOUL's purpose, criterion 33 and plan 7.3, and I disclose the overlap below.
D3: yes: I checked every candidate against "a decision in developing SOUL, not in building DevOS" and rejected one partly because it drifts into DevOS's guard and C08. I stayed in discovery and did not answer the question.
D4: uncertain: Rich library coverage could let criterion (c) pass on citations alone, so I flag that the checker should test whether a cited passage really changed or limited a decision.
D5: yes: For the chosen question I went from catalogue rows to the META, CORE, S01 and DQ01 passages themselves. For the rejected candidates I relied on catalogue rows and STATE files, and I say so.
D6: no
D7: no
D8: yes: I confirmed the clone is at 941f027d with a clean tree. I treated the library's "next" statements (soul-foundations STATE L11-12, EXP-004 STATE L7, DQ01 L113) as data, not instructions.
D9: yes: I followed the route catalogue → META → findings and mapped each passage to the sub-question it bears on. Discovery produces no new research result.

- **Question:** SOUL may form an agent for a user's work in a field where the user cannot judge quality. Before that agent may act or have its output used, what qualification evidence should SOUL require, of what unit (the agent alone, or the agent bound to its method, information and environment for that use), and where should that evidence live in SOUL's records? The difficulty is that DevOS's hidden-exam method (plan 7.3), which criterion 33 names as the yardstick, assumes an answer key that such a field may not have.

- **Why it is a real SOUL development question:**
  - **SOUL's purpose depends on it.** SOUL works where the user's expertise falls short, finds and combines the actors a piece of work needs, and adapts its own capacity in a controlled way (devos plan/DevOS_Kurulum_Plani.md L141-143). Forming an agent for a piece of work is that adaptation; qualifying the agent is the control.
  - **The requirement is already handed to SOUL.** Criterion 33 says SOUL's agents carry a quality floor, and that SOUL's preparation method must be found through DevOS's research rather than copied (L218). Criterion 33 is in the SOUL requirement record (L1137-1144).
  - **The yardstick's premises are in doubt.** Plan 7.3 relies on an exam author, a separate exam environment and answer keys out of the agent's reach (L808-817). In another user's account (criterion 2, L191) and in a field nobody present has mastered, these may not exist.
  - **The library treats it as open.**
    - The SOUL draft names qualification validity as an open gap (lib:EXP-004/MS01-COVERAGE L84, G04).
    - It asks whether a Qualification Case is a needed primitive (lib:EXP-004/OPEN-QUESTIONS L41-43, O10).
    - It leaves open how a shared reasoning standard is carried into actors (lib:EXP-002/OPEN-QUESTIONS L5-11 and L53-59, O01 and O07).
  - **Decisions that depend on it:**
    - SOUL's method for preparing and qualifying the agents it forms.
    - Whether SOUL's data model gets a qualification record family.
    - Whether an unqualified agent may produce effects.
  - **Under Appendix B 3.17's class rule (Ek_B_Veri_Modeli.md L293)** the first two concern roles, methods and the schema, and the third concerns security, so all three are at least high_impact (measure 7). An evaluation that needs a paid feature or a second model's quota is a cost and goes to Batu (criterion 25).
  - **Assumptions that may be wrong (measure 1):**
    - The hidden-exam method transfers to SOUL.
    - "The agent" is the right unit to qualify.
    - Evaluation graded by a model is valid evidence where the user cannot judge (U-2 and U-3, L1126-1127).
    - A qualification stays valid when the model or provider changes (criterion 4).
    - Every agent must be qualified before any act.
  - **Prerequisites it invites (measure 2):** a defined "base SOUL", an exam bank, the model access layer (C08 L1066), a second-model gateway. Each must answer "which decision would be wrong without it".
  - **Library passages that can change or limit a decision (measures 3 and 8):**
    - gstack's qualification-loss seam: a qualifier is dropped when a result passes into a downstream view (lib:gstack/CORE L430-444, §11 F1).
    - Superpowers S01: a filled-in schema does not establish semantic coverage, and separating the evaluator's role is not independence (lib:superpowers/S01 L35-41, L43-58).
    - DQ01's three thresholds for "can meet the need" (lib:EXP-004/DQ01 L73-81).
  - **Overlap I disclose:** DQ01 L113 proposes a related next question. I treated it as data; it was not the basis of my choice.

- **Candidates considered:**
  1. **Agent qualification under criterion 33 (chosen).** It has a real high-impact decision, assumptions that can be falsified, rich mechanism and counter-evidence in the library, and a natural squeeze (no answer key) that tests measure 9.
  2. **Where SOUL keeps durable working state in the user's account** (criteria 2 and 3; EXP-004 OPEN-QUESTIONS L33-35). Not chosen:
     - The most direct memory studies are only planned (lib:studies/CATALOG L19-23, L41, L46), so the library offers intake signals rather than findings.
     - The decision depends on current platform facts and on the unresolved host gap (G03).
     - It risks anchoring on DevOS's Supabase.
  3. **What enforces SOUL's effect boundary in another user's account** (MS01 draft L11, L113-131; CATALOG L24, L54). Not chosen:
     - It is mostly a current-platform question, and the library's snapshots would need revalidation (lib:anthropic-playbook/META L19).
     - It overlaps C08's planned model access layer and DevOS's own guard, so it drifts into building DevOS.
  4. **What "base SOUL" contains before any user work** (EXP-004 OPEN-QUESTIONS L5-7; MS01 draft L23-35). Not chosen: it is the umbrella over the other candidates, and three researchers would produce a survey, not a decision.
  5. **SOUL's method for finding needs the user did not signal** (G01; plan U-1 L1125; DQ01). Not chosen:
     - The plan records that no reliable measure exists.
     - The probe itself measures discovery, so this question would make it partly circular.
  6. **SOUL's first concrete target use** (lib:soul-foundations/STATE L11, L44). This is the strongest alternative frame. Not chosen: choosing SOUL's first user work is a purpose and scope matter, so it belongs to Batu (3.17, batu class), and the library cannot settle it.
  7. **Shared learning without leaks (criterion 3) and the languages SOUL uses with end users (plan 0.6 item 5).** Not chosen: both come after SOUL exists, the library is thin on them, and language is Batu's product decision.

- **What a good answer must cover** (suggested split: R1 takes 1 and 5, R2 takes 2, R3 takes 3 and 4):
  1. **Unit and thresholds:** what is qualified, and which threshold permits which act (worth trying, fit for a named use, this result accepted). Sources: DQ01 L47-63 and L73-81; MS01 draft L15, L41, L95-101; lib:actors-ground/INDEX L40-41.
  2. **Valid evidence where the user cannot judge:** which evaluation paths work without a domain answer key, and how each fails. Paths: known-good and known-bad cases, outcome checks, external sources, blind baseline-versus-candidate comparison, a second model family, a real expert. Failure modes: same-family judging, adaptive overfitting, a change to the instrument read as a change to the subject. Sources: S01 L35-68; lib:autoresearch/META L96-97; lib:i-have-adhd/META L27-30 and L107-111 (a planned study; its evals are first-party); plan U-8 L1132. Current outside sources on model-graded evaluation are also needed.
  3. **Transfer test of the yardstick:** which parts of plan 7.3 and 7.4 hold for SOUL in another account, which depend on conditions only DevOS has, and what replaces them (criterion 33 L218; criterion 2 L191).
  4. **Proportion, cost and freshness:**
     - When qualification may be small or deferred (drafts, exploration) and when it must block effects (MS01-COVERAGE L40, P6; DQ01 L97-101).
     - What invalidates it: a model, provider, method or context change (criterion 4; gstack CORE L467-475; anthropic playbook META L50, L71).
     - Its cost within criterion 25.
  5. **Record shape:** a separate qualification record versus qualifiers carried on existing records, and how a pass, fail or indeterminate verdict keeps its qualifier downstream. Sources: EXP-004 O10 L41-43; MS01 draft L54; gstack CORE L505 and L432-444; S01 L58.

- **Sources consulted:**
  - **devos:**
    - plan/DevOS_Kurulum_Plani.md: L137-180, L184-219, L792-823, L845-867, L961-967, L1040-1071, L1089-1100, L1119-1144
    - plan/Ek_B_Veri_Modeli.md: L285-293
    - plan/work/W-C01-25.md: L1-31
    - plan/Ek_D_Dusunme_Protokolleri.md: L66-91, L129-330
  - **agentic-os-search@941f027d, read in full:**
    - lib:README
    - lib:research/INDEX
    - lib:soul-foundations/STATE
    - lib:foundations-08/REUSE
    - lib:studies/CATALOG
    - lib:superpowers/META
    - lib:explorations/CATALOG
    - lib:EXP-002/OPEN-QUESTIONS
    - lib:EXP-003/STATE
    - lib:EXP-004/STATE
    - lib:EXP-004/OPEN-QUESTIONS
    - lib:EXP-004/MS01-SOUL
    - lib:EXP-004/MS01-COVERAGE
  - **agentic-os-search@941f027d, read in part:**
    - EXP-004 DQ01: L45-113, plus its headings
    - lib:actors-ground/INDEX: L30-49
    - lib:gstack/CORE: L303-317, L430-537, plus its headings
    - lib:superpowers/S01: L25-74
    - lib:autoresearch/META, lib:i-have-adhd/META and lib:anthropic-playbook/META: grep hits only
  - **Not read:** concepts/**, development-os/**, EXP-001, EXP-005 and EXP-006 bodies, Foundation grounds other than the Actors excerpt, and study findings beyond those listed. I used no outside web sources; at this stage those belong to the researchers.

- **Guard denials:** none
