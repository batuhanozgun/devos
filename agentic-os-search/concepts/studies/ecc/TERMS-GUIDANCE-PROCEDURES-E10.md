# ECC — Guidance adaptation, procedural handoff and E10 recovery uses

2026-09-23 · **C6 post-U12 transfer / U17-A extraction.** Bu dosya authored guidance, host adaptation, procedural handoff ve E10 recovery kullanımlarını bağlamıyla taşır. GH kimlikleri ortak agent/procedure ontology'si veya host capability guarantee değildir.

Source package:
- Note39, U17-A source ledger, MR40, original publication receipt and catalogue-alignment closure.
- E10 PRECHECK, recovery README, restore_e10.py and recovery-check.json.
Fixed target: `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`.
E10 is one historical seven-case local campaign; recovery is not a rerun.

## 0. Source locator and role map

| Usage range | Exact research sources | Source role / evidence class |
|---|---|---|
| ECC-GH01–GH34 | [Note39](../../../research/studies/ecc/notes/39-GUIDANCE-ADAPTATION-AND-PROCEDURAL-HANDOFFS.md) §§1–7/9 → [U17-A ledger](../../../research/studies/ecc/evidence/U17-A-SOURCES.md) → [MR40](../../../research/studies/ecc/ROUND-U17-A.md) | Fixed-pin SOURCE OBSERVATION, TARGET INSTRUCTION, TEST SOURCE INSPECTED and conditional interpretation; procedure text is not observed obedience. |
| ECC-GH35–GH41 | [E10 PRECHECK](../../../research/studies/ecc/evidence/u17-a-guidance-adapter-probe/PRECHECK.md) → [recovery README](../../../research/studies/ecc/evidence/u17-a-guidance-adapter-probe/README.md) plus Note39 §3 | One historical seven-case LOCAL EXECUTION with source-informed predeclared discriminators; not Gemini/model benchmark or independent replication. |
| ECC-GH42–GH50 | [E10 recovery README](../../../research/studies/ecc/evidence/u17-a-guidance-adapter-probe/README.md) §Canonical recovery → [restore helper](../../../research/studies/ecc/evidence/u17-a-guidance-adapter-probe/restore_e10.py) → [recovery check](../../../research/studies/ecc/evidence/u17-a-guidance-adapter-probe/recovery-check.json), summarized in Note39 §8 | ARCHIVE RECOVERY / integrity correspondence only; no target rerun. |
| ECC-GH51–GH55 | [MR40](../../../research/studies/ecc/ROUND-U17-A.md) → [original receipt](../../../research/studies/ecc/PUBLICATION-U17-A.md) → [alignment receipt](../../../research/studies/ecc/PUBLICATION-U17-A-ALIGNMENT.md) | Work/publication standing and recovery history; not product evidence. |

The corrupt carrier, restored archive and target campaign are three different evidence objects; their identities are not pooled.

## 1. Guidance and host adaptation

| ID / ifade | ECC araştırmasındaki kullanım | Sınır |
|---|---|---|
| ECC-GH01 — project-local baseline guidance | `.gemini/GEMINI.md` gibi host-local instruction surface. | Every ECC agent/skill/command adapted/installed or loaded by host değil. |
| ECC-GH02 — generic Gemini materialization target | Generic project adapter'ın `.gemini` native root'a selected config/source materialization'ı. | Standalone agent converter automatically invoked demek değil. |
| ECC-GH03 — standalone agent converter | Selected `.gemini/agents/*.md` frontmatter lines'ını in-place dönüştüren separate CLI. | Installer/provider selector/host loader veya all-agent generator değil. |
| ECC-GH04 — mapped tool label | Known built-in label'in Gemini-style tool name'e conversion'ı. | Mapped tool actually available/authorized/effective guarantee değil. |
| ECC-GH05 — retained unknown tool | Adapter map'te olmayan name'in unchanged bırakılması. | Host accepts it veya impossible tool demek değil. |
| ECC-GH06 — retained model field | Agent source model value'sunun adapter tarafından değiştirilmemesi. | Live remote request uses/accepts that model proof değil. |
| ECC-GH07 — unchanged/compatible count | Transformation bytes'i değiştirmediyse increment edilen counter. | Valid host agent definition veya behavioral conformance certificate değil. |
| ECC-GH08 — LF-specific frontmatter recognition | Converter delimiter regex'inin LF formuna bağlı recognition. | Logical equivalent CRLF host content recognized guarantee değil. |
| ECC-GH09 — block-list transformation mismatch | Scalar-line parser block-style tools list'inde `tools: []` yazıp old list lines'i bırakabilen condition. | Gemini loader actual rejection proof değil; E10 PyYAML only syntax cross-check. |
| ECC-GH10 — idempotent converted output | E10 C5'te C0 output second call'da same bytes. | Converter all inputs/platforms idempotent veya host-conformant değil. |
| ECC-GH11 — missing-directory refusal | Converter absent source directory'de nonzero/diagnostic. | Installer will create/fetch agents veya host configured correctly demek değil. |
| ECC-GH12 — host contract distinction | Gemini context file, agent definition and custom-command formats are distinct external contracts. | Dated current docs fixed-pin historical host or installed version identity değil. |

## 2. Procedural artifacts and actor handoffs

| ID / ifade | ECC araştırmasındaki kullanım | Sınır |
|---|---|---|
| ECC-GH13 — authored procedure | PRD/plan/TDD/PR gibi actor-interpreted Markdown instructions. | Deterministic scheduler/state machine veya host enforcement değil. |
| ECC-GH14 — procedural handoff artifact | Stage outputs arasında persisted Markdown file/path/reference. | Immutable revision binding, accepted decision veya auto-resume guarantee değil. |
| ECC-GH15 — PRD artifact | Problem/evidence/hypothesis/outcome/scope/milestones/open questions structured requirements file. | Hypothesis truth or implementation design approval değil. |
| ECC-GH16 — assumption label | Evidence absent olduğunda explicit assumption notation. | Assumption validated demek değil; uncertainty preservation mechanism. |
| ECC-GH17 — plan mode selection | PRD artifact path, other Markdown reference veya free text'e göre plan behavior branch. | All plans use specialist planner veya same continuation semantics değil. |
| ECC-GH18 — inline plan default | Specialist not explicitly requested/exposed olduğunda actor's own planning route. | Planner agent unavailable globally veya no delegation ever değil. |
| ECC-GH19 — optional specialist delegation | Runtime-exposed planner + explicit user request condition. | Agent definition presence alone selection/authority değil. |
| ECC-GH20 — milestone in-progress write | Plan file created/linked and PRD milestone row changed to in-progress before coding confirmation. | Implementation started/authorized/completed demek değil. |
| ECC-GH21 — next-pending selection | Artifact mode reentry'de next pending milestone choice. | Already in-progress incomplete milestone reconciliation automatically occurs demek değil. |
| ECC-GH22 — path-based plan binding | Plan stores source PRD path/milestone. | Current semantic alignment veya immutable PRD revision binding değil. |
| ECC-GH23 — plan-as-data | TDD procedure plan file'ı untrusted data olarak parse/validate etmeyi instruct eder. | Actor actually sanitizes every command or host blocks harmful instruction guarantee değil. |
| ECC-GH24 — RED evidence | Intended defect'i exercising failing test/result requirement. | Any failure/syntax/setup error valid RED değil. |
| ECC-GH25 — GREEN evidence | Same relevant target after fix passing. | Whole product acceptance/deployment readiness değil. |
| ECC-GH26 — checkpoint evidence | Task/branch-specific pre-squash evidence/report preservation. | Independent review or immutable artifact receipt değil. |
| ECC-GH27 — PR artifact linkage | PR procedure nearby PRD/plan/evidence paths'i reference/report eder. | Artifact validated/accepted or milestone complete proof değil. |
| ECC-GH28 — post-rebase freshness obligation | Push/rebase/change sonrası earlier TDD/review evidence same revision'a otomatik bağlı değil. | Observed stale PR incident değil; procedural source boundary. |
| ECC-GH29 — dev-team parallel personas | Four analysis-only PM/Architect/Developer/QA dispatch with parent synthesis. | Independent evidence/agents, arbitrary team composer or code review substitute değil. |
| ECC-GH30 — bounded shared context | Coordinator topic/project context'i concise declarative prompt'a reduce eder. | Lossless context or decision-critical completeness guarantee değil. |
| ECC-GH31 — in-prompt trust label | Persona prompt içinde untrusted-data/directive warning. | Host-level policy enforcement or prompt-injection immunity değil. |
| ECC-GH32 — disagreement-preserving synthesis | Parent synthesis disagreement/repeated concern'i explicit preserve eder. | Correct adjudication, independent corroboration or work-admission decision değil. |
| ECC-GH33 — optional persistence | Dev-team output only user request'le save. | Discussion automatically durable/current project state değil. |
| ECC-GH34 — host-execution-position capability | Gemini subagent no-nesting contract nedeniyle same guidance main coordinator vs restricted subagent'te different executable capability. | Converter actually installs dev-team there veya live host limitation observed değil. |

## 3. E10 campaign and evidence integrity

| ID / ifade | ECC araştırmasındaki kullanım | Sınır |
|---|---|---|
| ECC-GH35 — E10 campaign | Exact ADAPT/TOOLS originals on synthetic temporary agent files, one seven-case source-informed local campaign. | Gemini/model/installation/procedure-obedience benchmark değil. |
| ECC-GH36 — pre-execution criterion | PRECHECK'te seven cases/expected observations run öncesi fixed. | Blind preregistration or independent oracle değil. |
| ECC-GH37 — source identity admission | ADAPT/TOOLS bytes Git blob framing ile fixed identities'e match before run. | Whole dependency closure or host identity değil. |
| ECC-GH38 — CRLF unchanged case | Logical equivalent CRLF input bytes unchanged + compatible count. | Gemini accepts file or converter intended no-op proof değil. |
| ECC-GH39 — no-frontmatter unchanged case | Plain Markdown unchanged + compatible count. | Valid native agent definition proof değil. |
| ECC-GH40 — independent YAML syntax cross-check | E10 block-list transformed output PyYAML rejection. | Gemini parser behavior or all YAML dialect conformance değil. |
| ECC-GH41 — within-campaign repeat control | C5 C0-produced file second invocation. | Separate independent campaign/replication değil. |
| ECC-GH42 — bad encoded transfer | Repository `E10.zip.b64` full text exact Git blob but direct decode unreadable ZIP. | Original experiment archive corrupt/failing demek değil. |
| ECC-GH43 — original archive identity | Historical attachment ZIP 8821 bytes + fixed SHA-256 + member CRCs. | Scientific result truth or current environment proof değil. |
| ECC-GH44 — guarded repair recipe | Only exact bad blob accepted; fixed splice→corrected base64 identity→ZIP length/SHA/CRC checks. | New target execution veya result mutation değil. |
| ECC-GH45 — byte-for-byte recovery | Restored archive original historical bytes'e exact equality. | Independent replication/reperformance değil. |
| ECC-GH46 — changed-input rejection | Recovery helper wrong input identity'yi refuse eder. | General corruption correction algorithm değil. |
| ECC-GH47 — archive recovery check | recovery-check.json target rerun olmadığını, one campaign/seven cases'i record eder. | Same-assistant recovery independent verifier değil. |
| ECC-GH48 — publication-transfer defect | Committed encoded carrier original archive'i faithfully encode etmiyor. | ChatGPT thinking failure cause established demek değil. |
| ECC-GH49 — preserved bad object | Bad carrier traceability için unchanged retained. | Directly admissible decoded execution evidence değil. |
| ECC-GH50 — recovered member source snapshots | Original ADAPT/TOOLS source bytes and harness/results inside original archive. | Current upstream or installed host conformance değil. |

## 4. Publication and recovery standing

| ID / ifade | ECC araştırmasındaki kullanım | Sınır |
|---|---|---|
| ECC-GH51 — interrupted publication state | Opening/activation/precheck/bad carrier present, Note/ledger/closure absent standing. | Source result complete/published demek değil. |
| ECC-GH52 — recovery continuation | Existing campaign/evidence integrity restore + source account completion without rerun. | New experimental confirmation veya changed criteria değil. |
| ECC-GH53 — blocked catalogue alignment | Research-local result present while shared discovery row could not be updated due tool safety block. | Source result invalid or user manual upload required demek değil. |
| ECC-GH54 — alignment closure | Later same permitted route with fresh full catalogue/diff/nonforce update closes discovery publication gap. | Research rerun/stronger evidence or independent review değil. |
| ECC-GH55 — source completion vs publication alignment | Note/ledger/source criterion complete can precede catalogue/receipt/state full alignment. | Publication metadata scientific claim strength'i artırmaz. |

## 5. U17 non-collapse

- source guidance ≠ host loading;
- tool-name conversion ≠ host capability;
- unchanged converter output ≠ compatible agent;
- authored procedure ≠ executable scheduler;
- artifact path ≠ immutable semantic binding;
- milestone in-progress ≠ implementation approval;
- test failure ≠ valid RED;
- GREEN ≠ accepted deliverable;
- PR created ≠ plan/task accepted;
- persona diversity ≠ independent evidence;
- trust label ≠ host enforcement;
- E10 campaign ≠ host benchmark;
- archive recovery ≠ experiment rerun;
- valid archive ≠ valid scientific oracle;
- publication transfer failure ≠ target failure;
- catalogue alignment ≠ research result strengthening.

U17 answers one representative G4 source/local-evidence slice. Other consequential variants remain reverse-inventory/CORE obligations; no all-guidance efficacy or host certification is implied.
