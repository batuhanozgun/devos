# Note39 — Guidance adaptation and procedural handoffs

**2026-09-22 · U17-A / G4 / MR40 · BOUNDED SOURCE AND LOCAL-EVIDENCE ANSWER.** Fixed ECC `8321021c54d670126ce3b2969d5deb880b4b0c2a`. [Exact sources](../evidence/U17-A-SOURCES.md), [round](../ROUND-U17-A.md), [E10 evidence and recovery](../evidence/u17-a-guidance-adapter-probe/README.md), [STATE](../STATE.md).

The interrupted turn left an opening, active STATE, a precheck and an encoded experiment archive, not a completed research note. This continuation recovers the original seven-case E10 campaign, fixes its publication route without rerunning the target, and completes the procedural source account. Source instructions, executed adapter behavior, current host documentation and actually followed/effective methods are distinct evidence classes.

## 1. Why this representative changes the system explanation

Earlier units explained installation, runtime and native review. They did not make every written method an executable scheduler or every host copy a behaviorally equivalent agent. U17 follows a concrete Gemini metadata transformer alongside the PRD→plan→TDD→PR method and the differently composed dev-team method. The historical U07/U15 frontier already identified these authored-guidance and host/generated-source responsibilities; this is not another file-maintenance audit.

| Object | Actual role at the inspected boundary |
|---|---|
| `.gemini/GEMINI.md` and Gemini target adapter | A project-local baseline instruction surface and a generic materialization target |
| `gemini-adapt-agents.js` | A separately invoked, in-place transformer of selected agent frontmatter lines |
| PRD/plan/TDD/PR documents | Procedures interpreted by an actor, with file/command handoffs and explicit human conditions |
| `agents/planner.md` | An optional specialist definition; it is not synonymous with the inline `/plan` command |
| `dev-team` | A prescribed four-role, parallel, analysis-only review with a parent-written synthesis |
| E10 | Local execution of the original adapter on synthetic files, not a host or procedural-obedience test |

The shared lesson is not that prose cannot work. Prose can direct real file reads, tests, Git operations and human interaction through a capable actor. The distinction is who interprets a condition and what enforces or records it. Sources: GEMINI, G-ADAPTER, HELPERS, MODULES, PATTERN, PRD, PLAN, TDD, PR, PLANNER, TEAM.

## 2. Gemini baseline installation and agent conversion are different paths

The pinned `.gemini` tree contains only GEMINI.md. Its own text describes support as focused on a project-local instruction layer, MCP catalogue and package-manager setup. The manifest's complete core entries list Gemini for platform-configs but not rules-core, agents-core, commands-core or hooks-runtime. Gemini's adapter uses the generic project adapter with `.gemini` as its native root. The helper emits copy/scaffold operations, remaps the native root's children and filters known foreign-platform paths; neither this adapter nor that helper invokes the agent transformer.

Therefore the presence of the converter does not establish that this declared baseline install automatically produces a fully adapted agent catalogue. Conversely, a deliberately narrower baseline is not proof that every optional Gemini use is broken. Custom installation or explicit conversion remains possible; no universal absence claim is based on the clipped installer directory search. Other module descendants and callers are not all certified by this observation.

The standalone converter accepts a directory (default cwd/.gemini/agents), requires it to exist and processes its immediate Markdown files. It does not fetch or install a missing agent source, choose a model provider, create native custom commands or demonstrate host loading. The real planner source supplies a concrete example: Read/Grep/Glob and model opus coexist with a substantial planning body. The transformer can rename those tool labels while leaving both model and body untouched.

The official Gemini contracts checked on 2026-09-22 distinguish context files, agent definitions and custom commands. Agents use Markdown/YAML metadata and a body that becomes their prompt; tools are an array and model selection is a separate field. The native custom-command path uses TOML with a prompt field. GEMINI.md loading is hierarchical/configuration-dependent. These are dated external contracts, not an installed-version test, a repin, or proof that copied Markdown cannot be used manually. Sources: GEMINI-TREE/GEMINI, G-ADAPTER/HELPERS/MODULES, ADAPT/TOOLS/PLANNER and D-GEMINI-AGENT/COMMAND/CONTEXT.

## 3. What the transformer really validates — and what E10 observed

The transformer recognizes frontmatter with an LF-specific delimiter expression. It processes each frontmatter line independently, normalizes a scalar/inline tool list, maps eight built-in labels, transforms MCP-like names and deduplicates mapped names. It removes color metadata. It preserves unknown names, model values and the body. It does not ask a live registry whether a mapped tool exists or validate the whole agent definition.

Its final `already compatible` count is the count of files for which this transformation returned unchanged. The condition includes correctly normalized files, but also files whose frontmatter was not recognized at all. E10 discriminated those cases rather than treating the counter as a host verdict.

| Predeclared case | Recovered original observation |
|---|---|
| C0 LF scalar tools | Mapped/deduplicated tools, removed color, retained model/body; exit0, updated1 |
| C1 equivalent CRLF input | Exact bytes unchanged; exit0 and one already-compatible file |
| C2 no frontmatter | Plain Markdown unchanged; the same successful compatible count |
| C3 unmapped tool | Unknown label retained, not resolved; exit0 |
| C4 host-style block list | Empty inline tools list inserted while old indented list lines remained; exit0/updated1. PyYAML parsed the input and rejected the output |
| C5 C0 output called again | Bytes unchanged; idempotence for that output, as predeclared |
| C6 absent directory | Nonzero exit and missing-directory diagnostic |

C4's relevant output is `tools: []` followed by the still-present `- read_file` and `- grep_search` lines. A scalar-line parser has not consumed the associated YAML block. This is stronger than only predicting a regex problem: the original local report preserves the changed bytes and the independent parser's before/after result. PyYAML6.0.3 is nevertheless not Gemini's loader. No actual Gemini rejection, unavailable remote model, unsafe tool call or portability failure rate was observed.

C0/C5 and C6 preserve useful positive behavior: recognized lists transform correctly, the selected output is stable on a second call, and a missing directory is not silently counted as compatible. An unknown name might be supplied by a custom host; retaining it is not evidence it can never work. Leaving model opus does not establish a live request to that model. The upstream four-test adapter suite uses real temporary files/subprocesses and checks transformations, help and default directory; it does not invoke Gemini. It was inspected, not run here. Sources: ADAPT/TOOLS/T-ADAPT and E10.

## 4. The staged method has real continuity value without being a deterministic state machine

The Plan-PRD document describes plain Markdown staging files as the links between requirements, design, implementation and PR creation. The actual command bodies preserve a meaningful division of responsibility.

PRD asks who has the problem, what observed evidence supports it, what hypothesis/outcome will be tested and what is out of scope. It explicitly records an assumption when evidence is absent, and stops before implementation design. Its generated file includes delivery milestones and open questions. This is useful discipline, not proof that the hypothesis is true because the template is filled.

`/plan` has distinct modes. A `.prd.md` path selects artifact mode; other Markdown is reference context; free text produces an inline plan. It asks the actor to inspect repository patterns, create tasks and validation intent, and wait for user confirmation before coding. It explicitly defaults to inline planning rather than invoking a planner subagent. Delegation requires both a runtime-exposed specialist and the user's explicit request; absent agents have an inline fallback. Consequently a planner description saying it is proactive is not the same selection rule as this command's explicit branch.

These documents can lead an actor to perform actual writes and tool calls. Their visible Markdown bodies are not themselves an implementation of the milestone parser or a persistent execution engine. PATTERN's programmatic-language claim must be read with the real command form, not promoted to evidence of an unexamined deterministic scheduler. File persistence makes a handoff possible, but the actor still has to select, interpret and validate the right file. Sources: PATTERN/PRD/PLAN/PLANNER; PLUGIN declares the skill/command entry surfaces without certifying actual host loading.

## 5. Planning state can advance before implementation permission or completion

In artifact mode PLAN says to select the next pending milestone, write the plan and change the selected PRD row to in-progress with its plan path. It then says to wait for confirmation before writing code. These are explicitly separate events: a plan exists; a milestone is labelled in-progress; implementation has or has not been authorized.

A conditional continuation question follows directly. Suppose the actor writes that row, the session ends before approval, and a later invocation follows only the stated next-pending selection rule. It can select a later milestone instead of resuming the already-in-progress one. These selected instructions do not prescribe a separate reconciliation of unfinished in-progress work before that choice. An actor can notice the situation, a user can select the existing plan, and another surrounding workflow can restore the missing context; no live misrouting was observed. The bounded result is that the file/status convention alone does not guarantee that recovery decision.

The plan template names a source PRD and selected milestone but does not bind that reference to an immutable PRD revision. If the requirement changes while a plan remains, the path still resolves without itself proving current semantic alignment. Re-reading and human review can address this; a path is a locator, not automatic change-impact validation. The examined TDD and PR procedures do not define a complete writer for the PRD's complete status. This is scoped to the selected chain, not proof that no other ECC method can update it. Sources: PRD/PLAN/TDD/PR.

## 6. TDD deliberately treats the plan as data and builds a separate evidence chain

TDD does not say that a plan file authorizes arbitrary commands. It directs the actor to read it as untrusted data, validate extracted tasks and acceptance intent, reject destructive or credential-handling directions and obtain review/approval for suitable validation commands. Task→test→RED→GREEN mapping is requested. The method distinguishes a test that actually exercises the intended defect from an unrelated syntax/setup failure; merely writing an unexecuted test is not RED.

It also binds checkpoint evidence to the current branch and task, requires the same relevant target to be rerun after the fix, and preserves a human-readable evidence report before squash destroys the easy checkpoint view. Package-manager selection is explicitly distinguished from test-runner selection. These are substantive authored safeguards, not a thin request to make tests green.

Their execution and judgment still belong to the actor and available tools. No TDD task, model compliance, command sanitization or semantic test quality was exercised by E10. The target description's word enforces does not turn these instructions into a host admission control. A real project-specific test result would also remain narrower than all product acceptance. Source: TDD, with its linked examples read through EOF; no examples executed.

PR creation is a further, distinct effect. PR validates a non-base branch, commits and existing PRs, discovers templates and nearby planning artifacts, pushes and creates the PR, then reports checks. It permits Needs testing in the body and pending/no checks in the output; it points to later review and merging when ready. Linking an artifact and opening a PR are not the same as validating that artifact or accepting the milestone. The push path can fetch/rebase after divergence; the described later steps do not automatically repeat the earlier TDD evidence on the rebased revision. This is a procedural freshness obligation, not an observed bad merge. Source: PR; Note19 remains the separate native-review account.

## 7. A second procedural form changes who does the reasoning

`dev-team` prescribes four simultaneous analysis-only personas: PM, Architect, Developer and QA. Unlike inline PLAN, it asks for actual parallel subagent dispatch and a parent synthesis. It also disclaims being an arbitrary team composer or code-review substitute; these personas do not inspect diffs by default.

The coordinator reduces the topic and optional PROJECT-CONTEXT.md to a bounded declarative summary, strips apparent secrets/directives, and puts an untrusted-data warning inside every persona prompt. This is a thoughtful attempt to carry the boundary to an actor that may not see the skill itself. The synthesis must preserve disagreements rather than average them away; a repeated concern is labelled blocking. Output is not saved by default, only on request. A discussion concern is not thereby an authenticated or persistent work-admission decision.

All four personas can share the same lossy summary and upstream assumptions. Role/context separation can broaden perspectives but does not establish independent evidence or error-free sanitization. A decision-critical omission in the shared summary can affect all four. This is a reasoning limit, not a measured failure of this skill.

The host execution location matters as well. The dated Gemini subagent contract prohibits nested subagent calls. Placing a method that must launch four subagents inside such a restricted subagent would not have the same capabilities as invoking it in a suitable main coordinator context. This conditional comparison does not assert that ECC's agent converter automatically installs dev-team in that role. Changing tool names alone does not supply missing delegation authority or restructure the workflow. Sources: TEAM/T-TEAM and D-GEMINI-AGENT. T-TEAM checks the textual contract, referenced files and registration, including that the trust label is inside the prompt; it does not launch the four agents or test their outputs.

## 8. E10 interruption recovery is a separate evidence result

The original archive survived locally and passed member CRC; its SHA-256 is d16d24c6b04a17f98d8a62513342170921e05930b883470f123e6d3d4e16888d. The complete GitHub-returned base64 text was transferred locally and matched remote Git blob3b92e3eb9111b10416de99fd88591607e6dea582, yet decoded to an unreadable ZIP. The defect therefore existed in the committed transfer, not only a clipped view.

The bad file is preserved and explicitly disqualified as directly decodable evidence. A hash-guarded byte repair recreates the exact original archive, verified by corrected-base64 identity, ZIP SHA-256/length and all member CRCs. The repository helper was read back, matched locally and executed only as an archive-recovery check; changed input was rejected. The repository now carries the bad input plus the complete deterministic recovery recipe and hashes, so recovery does not depend on a user upload or this conversation's filesystem.

No experiment result, source, fixture or criterion was changed. There is one recovered seven-case target campaign; C5 is its predeclared repeat-call control. There was no second target campaign in this continuation. Hash/CRC correspondence is not independent scientific replication. The cause of the ChatGPT thinking failure is not established by this transfer defect. See the E10 README, original PRECHECK, restore_e10.py and recovery-check.json.

## 9. Bounded closure and remaining frontier

U17-A meets the chosen G4 representative criterion: one real host transformation and its positive/negative local cases, actual declared installation/host boundaries, and two materially different authored procedural arrangements with their next consumers. This extends Note33 with actor-interpreted handoff and host-conditioned composition, not a new universal control plane.

It does not finish all recursive body/mirror accounting. Q01a2 retains the G6 reverse-inventory and broad-document challenge. Other host generators, contextual rules, translated/legacy variants, registration paths and domain methods re-enter when they change a load-bearing claim. No requirement to semantically evaluate every skill or certify every installed host has been added. Known source variants cannot be hidden as merely unrun runtime tests.

The next selected existing responsibility is G5 / U18-A: `scripts/harness-audit.js` and its actual command/optimizer consumers. Determine whether the score represents configuration presence, observed operation or outcomes; follow recommendations to the real next actor/effect. This is not the already explained Rust evaluation registry or Node capsule executor. Exact caller discovery and the new investigation remain NOT STARTED. Optional interfaces and the final omission/CORE/joint-evaluation work remain open. Earlier studies, experiments, E06 exclusion and EXP-004 status are unchanged; STATE owns verified publication.
