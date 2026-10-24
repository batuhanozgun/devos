# Note23 — Template resolution and launch composition

**2026-09-19 · U11-E / Q04e4 · bounded source answer.** Fixed target: affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a. [Sources](../evidence/U11-E-SOURCES.md), [MR24](../ROUND-U11-E.md), [STATE](../STATE.md). Source observations and conditional counterparts below are not executed incidents, native tests, model observations or architecture decisions. No E09 ran.

## 1. Native purpose and actual chain

The implemented template is a reusable description for admitting several new sessions with resolved task text, profile/harness choices, grouping and worktree preferences:

`CLI/source/variables → complete template resolution → session-capacity check → ordered per-step admission → anchor/handoff relations → returned launch summary`.

This is useful for repeatable multi-session setup. It is not itself a completion-aware workflow engine, and the source does not justify treating every step as a dependency-DAG node. The ECC2 README describes an alpha control-plane scaffold, not a finished universal orchestration system. That target framing is preserved rather than turning every stronger missing guarantee into a failed promise. Sources: U11E-C/M/CFG/README.

A concrete useful source example is the config test's feature_development template: planner and reviewer task strings share task/project variables, inherit a named reviewer profile, and make different worktree choices. The test verifies resolution of those choices. It does not assert that planning completes before review or that either task succeeds.

## 2. Parameters, context and validation are different objects

The CLI parses --var entries at the first equals sign, trims key/value text and rejects missing delimiters or empty sides. Repeated keys overwrite earlier map values. build_template_variables then fills only absent keys. Explicit task, project, cwd or source_* map entries can therefore replace the automatically supplied text. This is parameterization, not an authenticated assertion about the source session or environment.

The source session supplies fallback task/grouping and source_* strings. Actual launch uses the invoking process's current directory for every step, not the source session's directory. Changing the cwd variable changes substituted text; it does not change that launch directory. Likewise, the task variable can override the text supplied through --task while other fallback grouping still derives from the separate task argument/source. Labels and text should not be read as proof of the actual repository, revision or origin.

The resolver rejects an unknown template, an empty step list, recognized placeholders whose keys are absent, and invalid named profiles. It resolves all steps before any of this template's new session admissions. Thus a missing variable in the last step can prevent the first step from being created. Profile inheritance has a cycle check; these are real pre-effect protections.

The helper named interpolate_required_string does not reject an empty resulting task. It recognizes a particular placeholder grammar, not every string resembling braces; unknown syntax outside that grammar can remain literal. Optional strings are trimmed and blank results become None. Therefore successful substitution is neither semantic task validation nor a generic template-language guarantee.

There is also a source-level double-processing distinction: top-level project/task_group values are rendered first, then rendered again when inherited by a step, while an explicit step value is rendered at that step. For variables project='{{area}}', area='billing', an inherited project='{{project}}' can reach billing while the same explicit step expression reaches the literal {{area}} after its one pass. This follows the helper-call composition and the regex replacement contract; it was not run here. Literal/nested interpolation intent and arbitrary inputs remain a stronger residual. Sources: U11E-C/M/CFG, W-U11E-REGEX.

## 3. Explicit agent presence changes default-profile selection

The launch loop chooses a resolved profile using the following precedence:

| Resolved step fields | Profile passed into session creation |
|---|---|
| A profile name is present | That named profile |
| No profile, but an agent is present | None; the global default profile is skipped |
| Neither profile nor agent is present | The resolved global default profile, when configured |

An agent inherited from the template-level default counts as present. This is a presence test, not a check that the agent differs from cfg.default_agent. Explicitly writing the same agent name can therefore change profile application relative to omitting the field. The resolved-profile queue does not silently reapply the global default.

For example, with a valid global restricted profile and default agent claude, a step omitting both fields receives that profile. A step specifying only agent='claude' receives no profile through this branch. A step explicitly naming the restricted profile still receives it. This is a source countercase to assuming an explicit default value is always equivalent to omission. It is not a live privilege-escalation observation, and a host may impose independent restrictions.

Two further boundaries matter. A profile's own agent value overrides the separate agent argument in the lower queue helper. And --from-session does not cause this template path to fetch and inherit the source session's stored profile; its anchor/grouping relationship is not policy inheritance. The global default profile is resolved before the loop even if all steps select explicit alternatives, so an invalid configured default can stop launch before any new session.

These rules explain what is selected and persisted, not whether the selected host enforces every profile field. That downstream question is deliberately handed to U12-A rather than closed from a field's existence. Sources: U11E-M/CFG; original profile persistence and runtime evidence retain their scope.

## 4. The capacity check is real but is not a reservation

Unlike the scheduler's batch-only use of max_parallel_sessions, template launch counts existing Pending, Running, Idle and Stale rows, subtracts them from the configured limit and rejects a template whose total step count exceeds the remaining slots. A source anchor already present in the database is part of that population. This protects the normal sequential caller from knowingly admitting the whole template above the observed session budget.

The read/check does not reserve those slots, however. Another caller can observe the same available capacity before either finishes its later inserts. The lower per-step queue does not make the original template-level check into a multi-caller claim. This is a conditional concurrency boundary, not a performed oversubscription test.

Worktree capacity is separate. A step requesting a worktree can be inserted as Pending and placed in the worktree queue without a runner. That still returns successful admission to the template loop. A later step with worktree=false can proceed to launch while the earlier step is waiting. Session-budget availability is thus not proof of immediate worktree availability, harness readiness or step-completion ordering. Sources: U11E-M and retained lifecycle consumers.

## 5. Anchor relationships are not predecessor dependencies

With --from-session, all newly created steps receive a handoff from that source session. Without a source, the first created step becomes the anchor and later steps receive handoffs from it. The resulting relation is a common-anchor pattern, not an automatically constructed step1→step2→step3 execution chain.

The loop awaits each queue/admission call, but does not wait for the preceding process to finish, inspect its output, apply an acceptance test, or use an output-dependent variable before admitting the next step. All task substitution already occurred before launch. A step named reviewer is therefore not mechanically held until a step named planner has produced an accepted plan.

The new child's task is provided through its launch path; its additional handoff is a separate record. Note22 explains how such an unread record interacts with the optional backlog controller. That prior conditional repetition result remains scoped to enabled automation and actual consumer behavior; it is not a new experiment or a claim that every template repeats work.

Templates also use new-session creation directly, not the delegate reuse/assignment selector. Consequently, an anchor and its handoff labels must not be assumed to import all of the assignment mechanism's selection or ownership properties. Sources: U11E-M/CFG; Note22 and its original sources.

## 6. A later admission error can leave an earlier step running or queued

Validation-before-effect and failure-after-effect are different. Missing variables, invalid resolved profiles and insufficient observed session slots stop the template before its new session loop. Once that loop starts, each session admission and subsequent handoff is a separate operation. Errors propagate before the final TemplateLaunchOutcome is returned; the function has no template-wide rollback or partial-result return.

A concrete conditional countercase uses the actual prefix validator rather than an invented database failure:

1. The template has two valid task strings and enough observed session slots; worktree capacity is available.
2. Step1 has worktree=false and its record/runner admission succeeds.
3. Step2 has worktree=true, while worktree_branch_prefix is empty after normalization.
4. Step2's build path calls branch_name_for_session, which rejects the empty prefix.
5. Template launch returns an error, while Step1's earlier session remains.

If worktree capacity is already full, Step2 can instead enter the Pending worktree queue and avoid that immediate branch, so the available-worktree condition is load-bearing. If Step1 itself cannot be admitted, there is no successful prefix to preserve. This countercase was not executed.

Individual queue cleanup is not absent: a wrapper-start error attempts to mark that session Failed and remove its worktree. That does not compensate prior template steps. Other failures, such as resolving an anchor after a child was already queued or writing the handoff/projection, can also occur after an admission effect. A returned error is therefore not evidence that no child exists.

The CLI prints its template summary only after the whole call succeeds. Underlying session/profile/message/log records remain available, so failure does not imply total invisibility. But the followed path does not persist an immutable template-run id, the complete resolved inputs, a per-step acceptance history or a next-step resume checkpoint. In a standalone launch, the first anchor does not even receive a template-generated inbound handoff. Its survival can be visible as a session without that stronger template-execution provenance.

Retry invokes resolution, capacity checking and fresh session creation again. It can reproduce already-admitted early steps if capacity and environment permit; it does not resume from a recorded failed step. Conversely, surviving Pending/Running/Idle/Stale records can make the next whole-template capacity check fail. A later harness failure is yet another case: accepted wrapper creation need not return the eventual agent error synchronously to the template command. Sources: U11E-M/C/W and retained runtime/comm consumers.

## 7. Evidence and bounded conclusion

The source answer joins the real caller/parser, variables, resolver, profile precedence, session/worktree admission, anchor/handoff and outcome boundary. Config tests verify a normal planner/reviewer resolution and missing-variable refusal; CLI tests verify argument/map handling. Profile inheritance/cycle tests are relevant supporting definitions. They were inspected, not run, and do not test real planning/review effectiveness or partial-launch recovery.

Related command-builder tests were incidentally read; one expects unsupported profile fields to appear as task text for a configured runner. That expectation identifies a next consumer to investigate, not a completed host-enforcement finding. No template-suite-wide test-absence claim is made. No Rust build, model/provider, worker, installation, live service, SQL probe or E09 occurred. E06 remains excluded and prior experiments remain separate.

Q04e4a has the bounded source answer. Q04e4b retains actual host/process readiness, concurrent reservations, crash/retry/idempotency, complete template-run provenance, arbitrary/migrated configuration and interpolation intent, repository/revision/policy correspondence and accepted multi-step outcomes. Bounded source closure does not require pretending those guarantees were empirically established.

## 8. Reuse and next responsibility

Candidate reuse distinctions: textual variable versus environment fact; explicit value versus omitted default; anchor/source relationship versus policy/revision inheritance; all-step resolution versus all-or-nothing execution; observed capacity versus reserved capacity; ordered admission versus predecessor completion; per-session records versus resumable template execution; host-facing instruction versus enforced restriction.

After publication, the selected next unit is U12-A / Q02a: execution-profile and harness-runner composition. Trace stored profile and selected harness through actual command construction, native flags/text fallback, custom runner settings and the runtime/host consumer. Recover original evidence before any stronger enforcement claim. Generated host/provider surfaces, release/scanner/audit, native syntheses/CORE and the final omission challenge remain unfinished. No upstream patch or SOUL architecture is authorized by this note.
