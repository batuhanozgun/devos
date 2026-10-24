# Note24 — Execution profiles and harness consumers

**2026-09-19 · U12-A / Q02a · bounded source answer.** Target: affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a. [Sources](../evidence/U12-A-SOURCES.md), [MR25](../ROUND-U12-A.md), [STATE](../STATE.md). This is pinned source analysis with dated primary host-contract checks. No target build/test, live host/model, installation or E09 occurred. Conditional examples are not observed exploits or deployment incidents.

## 1. The profile crosses several different boundaries

The implemented chain is:

`configured profile → effective selection → stored session/profile → chosen executable/adapter → argv and environment plus task text → host behavior and separately invoked ECC controls`.

A shared profile shape makes configuration reusable, but does not make the meaning or enforcement of every field portable. The actual consumers distinguish native command options, advisory task text, environment labels and ECC-side sampled limits. These mechanisms can all be useful; none should be credited with another mechanism's guarantee merely because the original field name is unchanged.

Normal creation resolves explicit, inherited-name or global-default profiles. The template path's different default rules are already explained in Note23. Profile scalar values can override parent values, list fields are merged without duplicates, and appended prompts are concatenated. An empty child list does not erase an inherited list. Those are composition rules, not a proof that conflicting allow/deny entries have the same precedence in every host.

The queue uses profile.agent, when present, to choose the effective session harness. That choice is stored in the session record. The profile table stores the other resolved fields; get_session_profile returns agent=None because the effective harness is already represented separately. It would be incorrect to call that alone a lost harness selection. Worker startup reads this stored profile, while program/adapter selection still uses the loaded Config. A stored profile is therefore not a frozen identity for the executable, host version, surrounding config, environment or installed plugins. Sources: U12A-M/S/T/CFG; Note23 retains caller-specific selection details.

## 2. What the built-in adapters actually send

The table describes the pinned ECC builder, not the result of running each host.

| Built-in path | Native command arguments generated from profile | Other profile delivery |
|---|---|---|
| Claude | Model, allowed/disallowed tool rules, permission mode, repeated additional directories, dollar budget and appended system prompt; print mode is selected | Task remains task text. Token budget is not added to argv or projected into the task in this branch; the separate ECC enforcer matters |
| Codex | Model and additional directories; fixed exec / workspace-write sandbox / working directory / no-color command recipe | Tool lists, permission mode, dollar/token budgets and appended prompt become sections of the task string |
| OpenCode | Model, with run / directory / title recipe | Additional directories, tool lists, permission mode, budgets and appended prompt become task text when present |
| Gemini | Model and comma-joined include-directories, with prompt-mode recipe | Tool lists, permission mode, budgets and appended prompt become task text when present |

The actual task renderer adds headings such as System instructions and ECC execution profile. For these fallback paths, those headings remain characters inside the task argument; the builder has not created a distinct host system-prompt channel or permission configuration. A model may follow the instructions and a separately configured host may impose stronger restrictions. Neither outcome was measured here.

The unsupported-field path deliberately preserves intent instead of discarding every unmapped field. That is a useful portability mechanism, but it is not equivalent to a native permission control. Conversely, native argv emission is not itself a guarantee that the installed binary accepts that exact spelling, version and value or that all policy layers have the desired combined effect. Sources: U12A-M/TEST.

## 3. The same-looking permission field can have a different meaning

Current Claude CLI documentation describes allowed-tools as permission preapproval, not as an exclusive list of all tools that may exist. Its separate tools option controls tool availability. The inspected ECC Claude branch emits allowed-tools but not tools. A profile listing only Read therefore does not, by that field alone, declare that every other tool has been removed. Disallowed-tools and permission-mode are separate native controls and should not be ignored when evaluating the effective policy. This is a semantic distinction in the documented consumer, not a claim that a particular action was permitted in a live session. Source: U12A-M, W-U12A-CLAUDE.

A concrete cross-host contrast appears with permission_mode=plan. ECC's Claude branch passes it through permission-mode. The Codex branch instead keeps the literal sandbox option workspace-write and includes Permission mode: plan in the task string. Its disallowed-tools list likewise becomes text rather than a corresponding Codex policy rule. Current official Codex documentation distinguishes read-only from workspace-write sandbox policies. Thus this adapter does not transform the ECC plan field into a read-only sandbox selection. Actual writes might still be prevented by independent policy or avoided by the model; that stronger behavior was not tested. Source: U12A-M, W-U12A-CODEX.

Directory fields also need consumer-specific meaning. The Codex add-dir option is documented as extending writable directories alongside the main workspace. It is not merely the sentence Additional context dirs used by a fallback renderer. Passing the same path as metadata, natural language or a native access option is not one operation.

OpenCode's permission configuration and Gemini's approval-mode/policy surfaces show that those hosts have their own native controls. Their absence from the corresponding ECC profile translation is a boundary of this adapter, not evidence that the host has no security mechanism. All external contracts here were checked on2026-09-19 and are not matched to a locally installed version. Sources: W-U12A-OPENCODE/GEMINI/CODEX.

## 4. A configured runner replaces the native recipe

Both executable selection and command construction check configured harness_runners before the built-in branches. A configured entry can extend execution to an unknown harness, which is a real capability. However, even an entry under a known key such as codex takes the configured path completely; it is not merely a replacement executable inserted into the old native recipe.

For example, an entry using program=codex and base_args=[exec], without separately specified sandbox arguments, no longer receives the built-in builder's fixed workspace-write flag. ECC still sets the operating-system working directory, and the host may use its own defaults/configuration, but the old command recipe has not been inherited. Keeping the same harness label therefore does not establish the same execution policy.

The configured builder emits optional field-specific flag/value pairs and projects unsupported fields into task text. Support is inferred from whether a flag setting is present, not from interrogating the executable. An absent flag can produce a transparent text fallback; an incorrect or empty-but-present flag can both suppress that fallback and produce invalid or differently interpreted argv. The host might reject such a command. No silent acceptance or privilege escalation is assumed.

Appended prompts have an additional combination rule. When append_system_prompt_flag exists, the builder sends the flag. With the default inline_system_prompt_for_task=true, the same prompt is also included in task text. Setting inline=false avoids this duplicate only when a native append flag is configured; without one, the text fallback still carries the prompt. This is not a universal disable-inline switch.

Command arguments are supplied separately rather than interpolated into a shell command by these builders. That avoids one class of shell-string interpretation at this boundary, but an operator can configure a program that itself interprets commands. Configured mapping is a trusted adapter boundary, not a sandbox or capability-negotiation service. Sources: U12A-M/CFG/TEST.

## 5. Budget controls are not one portable field

The Claude branch sends profile.max_budget_usd to its native print-mode budget option. Other built-in paths express that field in task text; a configured runner can supply a native mapping. Separately, ECC's enforce_budget_hard_limits checks the aggregate global token/USD limits and a stored per-session profile.token_budget. It does not compare usage with profile.max_budget_usd. The global cost ceiling is not a replacement for each individual profile's dollar ceiling.

This distinction prevents two opposite errors: token_budget is not universally unenforced just because a command lacks a token flag, and every dollar-budget sentence is not enforced by the ECC global monitor. Claude's token field remains stored even though its task is not normalized through the generic text renderer.

The real ECC token-control consumer is present. The TUI event loop calls dashboard.tick; tick reaches sync_from_store, which calls sync_runtime_metrics. That imports changed metric files and invokes the budget enforcer. A selected CLI metric-refresh helper also imports metrics before invoking the same enforcer. When recorded usage reaches an enabled threshold, the function selects Pending/Running/Idle sessions and calls the worktree-preserving stop path. These are concrete code-level controls, not merely documentation.

Their guarantee is bounded by invocation, usable/current recorded usage, selected state and actual termination. A threshold is checked after usage is represented; this is not an atomic provider-side pre-spend authorization. The native process-output loop itself captures output, heartbeat and exit status, not this complete budget-monitor path. The TUI also has interaction modes that skip the tick, so its event-poll interval is not a guaranteed enforcement deadline. Global totals include the sessions returned by the store rather than a newly defined billing window. Zero thresholds disable their relevant check, and Stale is outside this enforcer's selected pause states.

No metric completeness, real overshoot, provider billing, termination latency or end-to-end budget effectiveness was measured. The previous lifecycle limits on process ownership remain applicable rather than being silently closed by a function named hard_limits. Sources: U12A-M/UI/C/R, W-U12A-CLAUDE.

## 6. A readable profile row need not retain all of its restrictions

The normal writer serializes allow/deny/directory vectors to valid JSON. The reader instead applies unwrap_or_default when decoding each of those JSON columns. A malformed stored deny-list string can therefore become an empty vector while valid scalar fields and the rest of the row are returned normally. The subsequent builder omits the deny flag or text directive because the vector is empty.

This is a concrete conditional counterpart: malformed stored JSON → successful profile object with empty restrictions → omitted restriction at command construction. It does not require a hypothetical hidden fallback, but it does require malformed stored data; the normal serialization path does not produce it. No corruption, migrated database, malicious writer or real unauthorized action was executed. An invalid profile name and a malformed serialized list are different failure classes and must not inherit each other's refusal behavior. Source: U12A-S/M.

## 7. Environment labels and detected roots do not authenticate execution

Shared environment variables align session, harness, directory, package-manager and plugin-root labels for cooperating components. Configured runner.env entries are applied afterward and can replace those values. The runtime's database writer still uses its separate explicit session_id argument. Consequently, a configured label and the record receiving runtime writes can diverge; agreement is not protected as an identity invariant in this builder.

This is an operator-controlled extension, not evidence of an attacker or a measured telemetry mix-up. Rust's process contract also distinguishes explicit environment mappings from inherited variables: inspecting get_envs does not show a fully sanitized child environment. These builders do not clear the inherited environment. Parent configuration and credentials were not inspected or used in this study.

Auto harness selection checks repository marker paths and configured-runner presence, not installation/version/capability readiness. Program selection later rejects an empty configured program or unsupported native type, and process creation can still fail. A directory named for a harness does not prove that it can run.

Plugin-root discovery searches executable/compile-time-path ancestors for two marker files and exports a path when found. It does not by itself activate a plugin, verify its content/version, or establish that the worker consumes every hook at that location. Exported CLAUDE-prefixed compatibility variables likewise do not turn a non-Claude executable into the Claude host. Sources: U12A-M/T/R and W-U12A-PROCESS.

## 8. Evidence standing, reuse and next work

The inspected command tests use Command argument/environment accessors. Their expected strings match the declared adaptations, including plan text alongside Codex workspace-write and unsupported custom fields inside the task. These tests can catch representation regressions; they do not ask the real host to parse those arguments, exercise denied tools, verify selected models or measure spend. They were not run in this study. A missing real-host result is an open validation boundary, not proof that the intended native mapping never works.

Q02a1 meets the original bounded source criterion through actual selection/store/builder/runtime and budget-consumer paths, native/configured variants, and unsupported/corrupted-input counterparts. Q02a2 retains installed version/API/config correspondence, effective host policy, arbitrary aliases/flags, inherited environment and plugin activation, malformed/migrated state, metric freshness and termination, actual prompt obedience and task acceptance. No remediation, adoption or security certification follows.

Reusable distinctions: portable representation versus portable enforcement; preapproval versus tool availability; policy text versus permission configuration; configured replacement versus additive customization; stored profile versus execution identity; sampled usage control versus pre-spend admission; decoded-empty versus explicitly empty; correlation labels versus authoritative identity; marker discovery versus active capability.

After publication, U12-B/Q02b is selected for the separate generated OpenCode source/build/discovery/runtime family. Start at scripts/build-opencode.js (S169), inspect .opencode package/TypeScript/configuration entries and follow generated output into the actual plugin/event/tool consumer. The family map retains this unclosed obligation; an opencode argv recipe does not answer it. Python/provider, release/audit, representative omissions, native syntheses/CORE and joint whole-study evaluation remain unfinished.
