# U01-B — Host Delivery, Invocation and Continuity

Date: 2026-09-17. Primary target: `obra/superpowers@b36e0829c6d0140e93cfef2ca599b1b07d4a7797` (manifest context 6.3.0).

**Status: BOUNDED SOURCE INVESTIGATION COMPLETE for the selected materially distinct delivery mechanisms; not all-host qualification.** This extends, rather than replaces, [U01-A](U01-entry-routing-and-bootstrap.md). The whole study remains ACTIVE / PARTIAL. U02's approval/artifact handoff is next.

Source IDs resolve through [SOURCE-LEDGER.md](../SOURCE-LEDGER.md). Method remains [v0.1](../METHOD.md). This round adds source inspection and one exact-module local experiment, not a live coding-agent session.

## 1. Question and coverage

How do shared instructions reach an agent, become actionable in its host, and return after context loss? Which claims are supported by configuration, executable adapter code, local callbacks, and actual host/model behavior?

The remainder of the porting guide was read through EOF, completing S08. Seventeen additional files (S11–S27) were read fully: wrapper, OpenCode and Pi adapters, root package manifest, Gemini context declaration/includes/mapping, Codex/Pi tool references, Hermes adapter/manifest/mapping, Kimi manifest, Cursor manifest/hooks, and two first-party test files. Non-recursive Hermes-plugin/tests/OpenCode-test trees were also read for navigation. This is not recursive repository coverage.

## 2. F07 — Delivery, discovery, invocation and execution are separable

**OBSERVATION — S07/S08/S12–S25.** The source implements several delivery arrangements. The guide itself qualifies its strong opening statement about automatic full bootstrap with a softer skill-description fallback later in the document. Read the qualification rather than turning the opening invariant into a universal implementation fact.

| Host / source | Discovery and bootstrap source | Full-body invocation / mapping | Re-entry and evidence boundary |
|---|---|---|---|
| Claude-oriented shell path — S04–S06/S11 | SessionStart configuration registers a wrapper; script reads using-superpowers and emits a nested context envelope. Matcher includes startup, clear and compact. | Bootstrap requests relevant skill invocation; actual host skill loader is outside this source slice. | Event registration is observed, not actual event delivery. U01-A ran only the exact script. Windows wrapper was read, not executed. |
| Cursor — S06/S11/S24/S25 | Manifest declares skills and a Cursor-specific hook file; lowercase sessionStart, relative wrapper command, snake_case context output. | Shared skill contract; guide describes a compatible native tool surface. | No explicit compaction registration appears in this hook file. Do not infer whether the host preserves/reloads context elsewhere. |
| Codex — S07/S08/S18 | Manifest declares skills and an empty hooks object. Guide describes native discovery and description-triggered bootstrap, not this shell hook. | Separate tool-reference instructions include version/allowlist-dependent delegation and environment handling. | No Superpowers injector/dedup/compaction callback is established by this manifest. Native-host behavior and current tool compatibility were not verified. |
| OpenCode — S12/S14 | Root package entry loads the adapter. Its config callback adds the skills directory once. A message-transform callback prepends bootstrap to the first eligible user message. | Adapter injects an inline mapping including native skill loading and task dispatch. | Callback inspects eligible message arrays and a marker; content is cached at ES-module scope. Exact module locally exercised; host callback timing/consumption not exercised. |
| Pi — S13/S14/S19 | Package declares skills/extension; resources_discover also supplies skills path. Context callback returns a separate user message containing body and inline mapping. | Inline mapping defines file-read-based skill loading and optional subagent/task-tool fallbacks. Reference file separately covers those optional capabilities. | session_start/session_compact enable injection; agent_end disables it. Existing marker suppresses insertion; insertion follows leading compaction summaries. Code and mocked tests inspected, not run here. |
| Gemini — S15–S17 | Extension manifest names GEMINI.md; that file includes bootstrap and mapping by relative references. | Mapping names activate_skill and host action equivalents. | These are manifest/include declarations; real include expansion, discovery and compaction behavior are not observed. |
| Kimi — S23 | Manifest declares skills plus sessionStart.skill = using-superpowers. | skillInstructions includes Skill, question, task and role-specific Agent mappings. | Manifest-defined startup request, not a Superpowers JS callback or observed Kimi run. Compaction behavior remains outside inspected evidence. |
| Hermes — S20–S22 | Registration resolves one of two install layouts, builds bootstrap, and registers each skill through Path objects. | Bootstrap proposes namespaced skill_view plus a resolved-path fallback; included tool reference also shows bare skill names and a fixed-location fallback. | pre_llm_call returns context only when is_first_turn is truthy. No separate compaction callback is registered in this adapter. Actual host namespace/event semantics remain unverified. |

**INFERENCE.** Portability here is shared procedure content plus host-conditioned delivery and action mapping. It is not identical bootstrap guarantees or identical operational behavior across hosts. A source-level matrix must retain an unknown cell rather than fill it from another host's implementation.

## 3. F08 — Re-injection and refresh have different lifetimes

**OBSERVATION — S12.** OpenCode's cache is outside the plugin factory. Undefined means not loaded; null represents a missing file; a string holds the assembled bootstrap. A later factory call in the same imported module shares that cache. Eligible fresh message arrays can receive the cached string repeatedly without rereading the file.

**OBSERVATION — S13.** Pi also has a module-scoped bootstrap cache, but its injectBootstrap flag belongs to each extension registration. Session events change the flag, not the cached source. Any message containing its named bootstrap marker can suppress insertion. The code places a new bootstrap after leading compactionSummary messages, preserving those messages rather than reconstructing them.

**OBSERVATION — S20.** Hermes reads and assembles bootstrap at register time and closes over it. The hook adds that string only on first-turn calls. It neither reloads the files per turn nor independently reconstructs lost work history.

**INFERENCE.** Four lifetimes need distinguishing: source-file revision; imported/registered adapter; host session/event; and the specific message array. Restarting a conversation, replaying a callback, refreshing a file, and reloading an ES module are not interchangeable operations. Whether a real host recreates the module on a new session is a host-lifecycle question, not established by this repository's factory signature.

Caching can be a deliberate efficiency trade-off. The bounded finding is its invalidation boundary, not a claim that caching is inherently defective.

## 4. F09 — Failure behavior differs by adapter

**OBSERVATION — S11/S12/S13/S20.**

- The Windows wrapper's no-Bash branch explicitly exits successfully without startup injection. This is a source observation only, not a Windows execution result.
- OpenCode caches an absent bootstrap file as null and returns without insertion. Its file read after the existence check is not enclosed in a catch here; absence and a subsequent read error are different paths.
- Pi catches bootstrap read errors, caches null, and omits insertion.
- Hermes raises if neither supported layout contains a bootstrap file; building the bootstrap also reads the tool-reference file before skill/hook registration. Those errors are not swallowed in this module.

Empty readable content is distinct from a missing file. The OpenCode local challenge below shows that an empty body can still yield a nonempty wrapper declaring the skill already loaded. This does not prove how any host reports or handles the condition.

There is no single observed Superpowers-wide fail-open/fail-closed rule at this layer. An availability-preserving fallback and a readiness-preserving failure have different consequences; deployment frequency and user impact remain unknown.

## 5. F10 — Tool mapping carries workflow semantics, not just names

**OBSERVATION — S13/S17–S19/S22/S23.** Pi's fallback substitutes current-session work when an optional subagent tool is unavailable and files when a task tool is missing. Kimi's mapping selects coder/explore/plan roles and routes user questions through a tool with specified exceptions. Codex's reference distinguishes delegation versions, context inheritance, continuation, effort settings and managed-worktree limitations. Gemini maps filled role templates into its named agent mechanism.

These are target instructions, not verified contemporary contracts of the host products and not instructions activated for this research agent.

**INFERENCE.** A missing tool can change who performs work, what context is isolated and how progress is represented. Calling all mappings simple API renaming would omit consequential behavior. Whether fallback preserves review independence, task authority and acceptance is an U03/U04 question.

**OPEN DOCUMENT-SEAM.** Hermes' assembled bootstrap uses superpowers:skill-name and a dynamically resolved fallback, while its included reference demonstrates unqualified names and a conventional fixed path. Both may work with host aliases; source wording alone cannot establish a lookup failure or equivalence. Preserve the seam for host/delegation re-entry rather than silently normalizing it.

## 6. E03/E04 — Exact OpenCode module experiment

Runner: [U01B-opencode-probes.mjs](../evidence/U01B-opencode-probes.mjs). Actual output: [U01B-opencode-probes-results.json](../evidence/U01B-opencode-probes-results.json).

The complete S12 source was transferred from the GitHub connector to a local file. Its Git blob identity was recomputed before import: `423e5ed513261485c657ba166b0372a5293639c7`, 5,464 bytes, exact match. It was not rewritten into a model of the adapter.

Execution: Node v22.16.0, Linux x64, temporary synthetic package/skills filesystem. The real exported factory and callbacks were invoked with minimal mock objects. The runner used synthetic skill-body sentinels, not the real bootstrap's entire behavior. No installation, network, credential, host process, model invocation or upstream suite was run.

```bash
node evidence/U01B-opencode-probes.mjs /path/to/pinned/.opencode/plugins/superpowers.js
```

Criteria were fixed in the runner before this execution, after source inspection. These are source-informed exploratory checks, not a preregistered independent experiment.

| Check | Observed result | Meaning |
|---|---|---|
| Config registration | Existing path preserved; selected skills path inserted only once after two calls. | Positive local config-mutation behavior. |
| Initial delivery | Unique synthetic body inserted before original user text; original part preserved. | Positive local payload behavior. |
| Repeated same array | No second insertion. | Positive local duplicate suppression. |
| Fresh eligible array | Cached body inserted again. | Positive local re-entry, not real compaction verification. |
| Generic-marker mention only | First user text merely discussing EXTREMELY_IMPORTANT prevented insertion; no synthetic body present. | FAIL against study-defined criterion that marker mention must not stand in for actual bootstrap. |
| Source changed V1 to V2 | Same loaded module continued to deliver V1. | Observed cache lifetime, not a product-wide freshness verdict. |
| Fresh module identity after edit | Delivered V2. | Positive file-refresh control; host session restart is not assumed equivalent. |
| Missing file, then repair and second factory | Both calls omitted body within the same module. | Null cache shared across factories. |
| Fresh module identity after repair | Delivered repaired body. | Positive repair/read control. |
| Empty file | Nonempty wrapper declared ALREADY LOADED without a usable skill body. | FAIL against study-defined semantic-readiness criterion. |
| Marker-only output given to body oracle | Rejected. | One narrow negative control, not complete oracle qualification. |

Totals: **8 mechanism checks passed; 2 semantic-health challenges failed; 1 oracle negative control passed.** A mechanism PASS means the stated narrow observation was reproduced; it does not mean the product passed a health/effectiveness evaluation. In particular, reproducing persistent stale/null caching is not certifying it as safe. Runner exit 0 indicates successful collection, not all criteria passed.

**CAUSAL INTERPRETATION.** The marker-only result follows from a generic substring in any text part of the first user message being used as the dedup predicate. The predicate does not check for a real bootstrap body or its version. Empty-source success follows from the wrapper's unconditional already-loaded declaration after a readable but empty file. These observations are localized to this function and fixture; real-host prevalence and mitigation are untested.

## 7. F11 — Test coverage must be read at its actual layer

**OBSERVATION — S26.** The first-party OpenCode caching test counts reads/existence checks, requires cached behavior, checks mapping strings, and tests present/missing cases. Its definition of a bootstrap part also uses the generic marker string. It explicitly expects missing results to remain cached. This supports interpreting caching as an intended tested property, not an accidental conclusion of our probe.

**OBSERVATION — S27.** Pi's tests build a fake event-registration interface, import the actual extension, call its callbacks, and assert resource paths, repeated initial delivery, duplicate suppression, agent_end suppression and post-summary compaction insertion. The tool-reference check is a table-text assertion. The mocked callback tests are stronger wiring evidence than the text check, but neither is an actual Pi/model session.

Both files were fully read, **not executed in this round**. The local experiment above is separate. No observed CI status, all-suite pass, behavioral acceptance rate or independent reviewer result is claimed. Whether other tests cover marker collisions, health and model compliance remains open for U06.

## 8. F12 — Procedure re-entry is not work recovery

**OBSERVATION — selected adapters.** These entry mechanisms provide shared procedure content, tool mappings and discovery paths. They do not, within the inspected functions, validate a task's accepted design, recover its current plan position, resolve the status of prior reviews or rebind a pending approval to changed files. Pi preserves incoming summary messages; it does not establish their fidelity.

**INFERENCE, bounded to this layer.** Restoring instructions answers how an agent is supposed to work. Recovering the ongoing task requires additional artifacts and state. This is a reason to move to U02/U03, not evidence that Superpowers has no work-continuity mechanism elsewhere.

Provisional reusable questions for SOUL/Development OS: what is available; what reached the actor; which revision is active; which procedure was selected; which current task/authority does it apply to; what was actually done? These are candidate comparison questions, not an adopted architecture or a modification of Foundation.

## 9. Documentation and coverage residuals

The porting guide's later fallback discussion qualifies its opening full-injection language. Other examples are not silently elevated to current implementation: the guide references `.antigravity-plugin/install.sh`, while the fully observed pinned root tree S02 has no `.antigravity-plugin` entry. Whether the current installation route is a different mechanism belongs to U07. This is a bounded path inconsistency, not a conclusion that Antigravity is unsupported.

Devin, remaining installation/distribution paths, every platform's tests, external host internals and evaluation dependencies are not investigated here. The mechanisms selected above are enough for the bounded entry model, not a claim of exhaustive supported-host coverage.

## 10. Question transitions and next work

- Q01–Q03: answered at source level for the selected mechanism families; runtime/event/namespace and current-host guarantees remain explicitly unresolved.
- Q04/Q05: still open. Inspect worktree/planning/SDD handoffs next; a bootstrap exception does not define the whole child-agent contract.
- Q06: partial progress through S26/S27 plus E03/E04. Whole evaluation coverage and efficacy remain U04/U06 work.
- Q07/Q08: remain U07/closure work; progressive inventory expanded but not completed.
- Q09 (new): what real host lifecycle reloads cached procedure content, and can a session restart leave a module generation unchanged?
- Q10 (new): do other guard/test surfaces also confuse a delivery marker with valid, current procedure content?
- Q11 (new): do host name/path aliases reconcile the Hermes bootstrap/reference seam? Revalidate host source only if load-bearing.
- Q12 (new): which porting/distribution references no longer match the pinned installed artifact route?

**Next authorised bounded work: U02.** Re-enter the already fully read brainstorming contract; fully read writing-plans and using-git-worktrees plus the relevant plan-review and execution-entry surfaces. Trace approval → spec/plan identity → workspace → task admission. Keep spike/bounded/architectural paths separate, and test what happens when scope, files or approvals change. Do not start installation/adoption or an unlimited host-qualification campaign to close a source unit.
