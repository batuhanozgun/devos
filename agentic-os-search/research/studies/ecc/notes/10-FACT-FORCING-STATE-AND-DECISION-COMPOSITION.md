# U06-B — Fact-forcing, retained checks and decision composition

**Date:** 2026-09-18. **Unchanged pin:** `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`. **Question:** Q07b. [Exact source coverage](../evidence/U06-B-SOURCES.md); [round/MR10](../ROUND-U06-B.md). SOURCE OBSERVATION, selected TEST SOURCE INSPECTION and qualified INFERENCE only. No new execution, E06, installation or live-agent effectiveness claim.

## 1. What this mechanism actually does

ECC's included GateGuard is a pre-action interruption and context-request mechanism. Its messages ask for importers/callers, affected public interfaces, data schemas and the user's instruction before editing or creating files. Destructive-command messages request affected targets and a rollback procedure; routine shell messages request the current purpose and the command's role. Those are more concrete questions than an undifferentiated request to reconsider.

The included skill describes DENY → FORCE → ALLOW and presents two task scores as evidence of benefit. The implementation establishes a narrower technical contract:

`selected tool event → operation/key classification → first-touch marker persisted → refusal with investigation request → a later matching key receives no further objection`.

The decisive detail is ordering. For a first Edit/Write, `markCheckedAndCountDenial(filePath)` records the path before `denyResult` constructs the message. A later `isChecked(filePath)` returns the original input. The command paths likewise call `markChecked` before returning their refusal. The code does not read an investigation response, transcript contents, retrieved importers, actual data schema, a verbatim-instruction match, reviewer decision or user approval as the release condition. A transcript path may help identify a session; its contents are not inspected for evidence here.

Consequently a retained `checked` entry means, operationally, that this key was marked by the gate; it does not prove that the requested investigation occurred. Under successful persistence and an unexpired retained key, immediately repeating the request without supplying facts takes the non-denial path. This is a source-derived trace, not a newly executed incident. It does not require assuming that a real model will ignore the request.

S132's selected test source corroborates the intended retry contract: the first Edit test denies and the second invokes the same input without submitting facts. The destructive-command test also invokes the same input twice; its comment says facts have been presented, but the fixture supplies no such intervening evidence. These assertions were read, not run. They can test first/refollowing invocation behavior, not whether an agent genuinely investigated.

This need not make the mechanism useless. A cooperative model may follow the request and produce better work. The established distinction is enforced interruption versus instruction-mediated investigation versus independently checked investigation versus improved task outcome. The first is implemented; the others need their own evidence.

## 2. Different operations retain different scopes

| Operation | Key and first-touch effect | What is not bound by that key |
|---|---|---|
| Edit / Write | Raw `tool_input.file_path`; first eligible request marks then denies | Proposed edit contents, file digest, user instruction and Edit-versus-Write identity |
| MultiEdit | Iterate `tool_input.edits`; mark and deny the first unseen eligible per-edit path | Atomic whole-batch qualification; target schemas not matching this assumed input shape |
| Classified destructive Bash / PowerShell | Prefix plus truncated SHA-256 of the command text; first occurrence marks then denies | Current working directory, current target contents, changed rollback feasibility, user approval or source evidence |
| Routine shell | One shared `__bash_session__` key for Bash and PowerShell | Every subsequent command's purpose or a new user task |
| Selected read-only Git introspection | Allowlisted syntax returns without a first-touch challenge | Universal harmlessness of arbitrary Git/shell expressions |

The key scopes explain why a new edit to the same file is not a new investigation gate, and why destructive wording described as "every command" must be qualified as first touch of a command-text key in retained state. A different spelling may get a different key; identical text may operate on a changed world. A cryptographic digest of command text is not a digest of its targets or an authorization token.

For MultiEdit, successive identical batches can challenge successive unseen paths until all are marked. This is per-path prompting, not an all-or-nothing evidence admission transaction. Actual host input shape and behavior require separate conformance evidence; reading this branch does not establish that every current host uses it.

## 3. Session continuity, expiry and exemptions

Session routing prefers several supplied session identifiers, then a hash of a transcript path, then a project-derived fallback. Short identifiers are sanitized by character replacement. The absence of an explicit session ID can therefore change isolation semantics; a project fallback is not a fresh-session identity. This unit did not test real host identifiers or collision prevalence.

State contains checked keys, last activity and a denial counter. Thirty-minute expiration is based on session inactivity, not the age or truth of each investigation. A successful lookup older than the one-minute heartbeat threshold can refresh the shared timestamp; new marks also update it. Thus ordinary continued use can retain an older key even after the file, instruction or task changed. Size pruning and stale-file cleanup bound storage and repetition, not semantic validity. No per-key source/instruction revalidation is present in this read path.

The writer merges existing keys, writes a temporary file and renames it. This is useful protection against partial reads, but the surrounding read/check/merge/write sequence is not a locked compare-and-swap transaction. Its Windows fallback can unlink before renaming. No concurrent execution, crash recovery or comprehensive platform guarantee was established here.

Exemptions also have distinct reasons and scopes. Claude settings paths, configured path globs and recognized subagent Edit/Write/MultiEdit events can pass without the first-touch file challenge. The subagent branch comments that the parent has already passed; the actual predicate checks identifying fields and does not verify a parent marker or evidence for this file. Destructive shell checks remain before the routine-shell opt-out and are not skipped merely by the file-subagent branch. Settings/path exemptions and graduated controls can legitimately support setup or low-value prompting; they are not proof of equivalent prior investigation.

If a required new marker cannot be persisted, the gate emits a warning and does not deny, deliberately avoiding an endless retry loop. If state is absent, expired or unreadable but new state can be written, it instead behaves as fresh first touch. Malformed JSON returns the original input. These are different failure decisions, not one universal fail-closed property. The selected tests include the unpersistable-state behavior; no test ran in this unit.

After a default three full Edit/Write denials, later new targets receive condensed messages carrying the denial ordinal. This changes prompt volume and repetition, not the release criterion. The source's claim about avoiding model repetition is a target explanation, not an effect measured by this study.

## 4. Classification is real machinery, not a complete shell interpreter

The gate distinguishes ordinary introspection, routine commands and selected destructive patterns. The Bash path combines tokenization, quote-aware checks, executable-subexpression extraction and a heredoc filter. S136/S137 were fully read: the latter strips only a narrowly recognized passive heredoc form, keeps executable substitutions where applicable, and retains original text on ambiguous forms. These mechanisms reduce both naive text false positives and some concealed-command false negatives. No broad adversarial parser certification follows.

PowerShell additionally delegates to its own policy classifier. S138 was read only through line 300; its full decision body and interpreter equivalence remain unexamined. Claims here about shared keys and the caller's release logic do not depend on asserting full PowerShell classification correctness. S139's unrelated Git hook-bypass checker was also only partially inspected and is not declared audited.

## 5. A denial is not always a nonzero exit

Unlike config-protection's exit 2, GateGuard's `denyResult` deliberately returns exitCode 0 plus a JSON `hookSpecificOutput.permissionDecision: deny`. The current official host contract recognizes that as a tool refusal and sends the reason to the model. Zero alone therefore cannot classify this hook's result. When the hook makes no decision, other host permission rules or sibling hooks can still refuse the action (W15).

The registered delivery routes differ. Edit/Write/MultiEdit and PowerShell use the retained `run-with-flags` wrapper, whose `stdout` handling preserves this ordinary JSON decision. Bash goes through `pre-bash-dispatcher` → `bash-hook-dispatcher` → ordered sub-hooks. S133 is not the host's own independent-hook result merger. Its output policy must be inspected separately.

### Source-derived composition counter-path

In S133, each sub-hook result is normalized; only a nonzero exit causes an early return. GateGuard is last in the current pre-Bash array, and its denial is a zero-exit JSON value. The normal final return chooses accumulated `additionalContext` ahead of modified raw output. If an earlier enabled sub-hook has produced context, the final payload can therefore contain that context but omit GateGuard's `permissionDecision` and reason.

There is an actual context producer, not merely a hypothetical return type: S135 emits push-review context when its command pattern matches, and S133 enables that reminder in strict profile before GateGuard. On a path that reaches both hooks without an earlier stop or relevant rewrite, an initial command classified as destructive can generate and persist GateGuard's first-touch refusal while the dispatcher returns only the earlier reminder. The state can then suppress GateGuard's challenge on a later identical request even though the first challenge was not delivered through this output.

This is a conditional source trace, NOT a live push, executed bypass or measured production incident. Other pre-hooks, sibling hooks, host policies and different profiles can change the final outcome. Their whole bodies and the host were not executed. The claim is specifically the loss of a structured decision in this combiner under the stated inputs, not that ECC universally permits destructive actions.

The selected GateGuard tests invoke the direct wrapper for Bash; they do not use the registered Bash dispatcher. They therefore cannot, merely by their assertions, close this production-composition question. Likewise the host's documented most-restrictive merge rule cannot restore a decision that one internal dispatcher never emits (W16).

## 6. Effectiveness and evidence boundaries

S131 reports two task scores and a mean improvement, and makes broad statements about self-evaluation and competitors. This unit did not recover underlying artifacts, blinded scoring, independent judgments, task distribution, model configuration or a replication for those claims. Treat the numbers as target-reported screening evidence, not an independently established improvement or a universal comparison.

There was no new probe, E06, upstream test execution, real agent, installation, configuration change, command execution or upstream report. Source counter-paths preserve their conditional status. Previous E01–E05 were not rerun; the two historical E05 identities and their reconciliation remain untouched.

## 7. Disposition and next question

Q07b1 is bounded-answered for the included gate's first-touch request, marker, retry, expiry, exemption and delivery contracts. Q07b2 retains live evidence-taking/benefit, current target/instruction binding, complete classifier/platform/input conformance, concurrent state behavior and actual composed-host effects. Neither the external GateGuard package nor all ECC governance has been evaluated by this slice.

Next U06-C begins the actually discovered `governance-capture.js` producer: what does an approval-requested or policy event mean, where is it consumed, and does a consumer enforce an admission decision or merely report it? S140 only discovers its prefix and classifier dependency. Reconnect that bounded trace to the wider scanner/control inventory before further parser edge-case work. P1, older residuals, native synthesis and the reverse-inventory challenge remain required.

Candidate reuse: a control can enforce a pause without verifying the requested work, a cache can retain encounter history without retaining justification, and a composed representation can lose a valid refusal. These are research cases for later SOUL/Development OS discussion, not adopted architecture or Foundation taxonomy. The comprehensive joint evaluation remains deferred until completed research.
