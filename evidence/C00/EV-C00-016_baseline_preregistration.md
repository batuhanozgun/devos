# EV-C00-016 · W-C00-15: pre-registration of the no-mechanism baseline

**What this is.** The protocol of the controlled discovery baseline that W-C00-15 requires before C02 starts (`plan/work/W-C00-15.md`; EV-C00-014 topic T-24; CHK-C00-023 condition C3). With it: the runner-facing texts `evidence/C00/baseline/task_gap.md` and `task_control.md`, the materials `evidence/C00/baseline/materials_gap/` and `materials_control/`, and the success criteria `evidence/C00/baseline/criteria.md`.

**Status.** Pre-registration. It, the texts, the materials and the criteria are merged into `main` before any run. Before the first run starts they change only through a merged revision; once a run has started they are never changed, and a change after that voids every result (plan 8 item 6; working order section 6).

**Who wrote it.** A Producer subagent of the working session, acting as task designer. It knows the gap, runs nothing and starts no subagent. It is the same model family as the runners, the scorer and the checker (plan 8 item 7; U-3).

**Synthetic data.** Brindle, its teams, hosts, names, numbers and dates are made up for this test. Every runner-facing file carries the label `SYNTHETIC TEST DATA` in its first line (plan 8 item 13; criterion 20). Nothing is drawn from the research library, Batu's accounts or any other repository.

---

## 1. Purpose and claims

**Purpose.** Plan 6.12 item 4 asks of every DevOS mechanism: "does the result get worse when the mechanism is removed?". The mechanisms are built in C02-C06 and first tested in C07; without a measurement taken before they exist, that question has nothing to compare against (CHK-C00-023 F2). This baseline is that measurement for discovery (K-1, U-1) and for not over-preparing (K02), taken with none of DevOS's planned mechanisms.

**What it measures.** In one controlled form, how often fresh general-purpose subagents of the installation session, with no DevOS role, database, context package or method:
- (K01) find, and handle in their design, a material requirement that the task text does not point to; and
- (K02) in the same task without that requirement, deliver the design without unnecessary preparation and stop.

**What it claims.** Counts out of the valid runs (section 4) for this form, this model and harness, at the independence level "same session, fresh-context subagent" (plan 8 item 7).

**What it does not claim.** A general discovery rate; anything about DevOS's mechanisms; discovery in real work; use of the library; a result at a higher independence level. It is **not C07's result**: C07's measure 1 needs its own controlled exam on an unseen form.

---

## 2. The two tasks

**The form (BR-212).** Brindle is a fictional AI-assisted development system. The work item asks for the design of a retention job that deletes session run records so that the run store stays below 70% of its volume, "without losing anything Brindle still needs", in four parts: what is deleted and kept, when and how the job runs, how it avoids deleting the wrong thing, and how it is tested before it is enabled. The materials (8 files, 188 lines) are the team's documentation: an overview, the run-record format, a storage report, operations, the replay suite, periodic triggers, a decision log and a configuration excerpt.

**Why it resembles DevOS's work.** It is an operations design item for an AI-assisted development system (records written by agent sessions, a dispatcher, periodic jobs, a deleting job with a dry run), of the kind C02-C09 write. It is self-contained: it needs no library, account, credential or external service.

**Gap condition (K01 form).** One sentence of one material makes the run store also the dispatcher's only record of which periodic work is done; the task text points to nothing of the kind. The requirement is material (missing it breaks the stated purpose) and the task's frame is wrong in this condition: no retention window that meets the 70% target avoids it. This is K01's "missing requirement without hints, and a wrong root frame" (Appendix C, C3). Details: criteria section 2.

**Control condition (K02 form).** The same text and the same materials, except that one sentence: there the dispatcher keeps its own table. The job then needs nothing outside itself. The materials still invite preparation (a deletion; "without losing anything"; several readers of the records to check; a decision that no obligation applies; a decision against new paid storage), and each invitation is settled in the materials. Unnecessary preparation and not stopping are the failures (Appendix C K02). Details: criteria section 3.

**Why the texts are identical.** `task_gap.md` and `task_control.md` are byte-identical, so the text cannot tell a runner its condition and cannot carry a hint that only one condition has. The only difference between the conditions is one line of `scheduler.md` (criteria section 1), so a difference between the conditions' results has that line as its only cause.

---

## 3. Runner setup

**Agent.** The `Agent` tool with `subagent_type: general-purpose`, no isolation option (guard rule T2), `run_in_background: true`, no model override. No DevOS role file. Model and effort are those of the session (D-008) and are recorded from the guard log (its `effort` field) and the transcript.

**What still reaches it.** Not controlled by this protocol, and recorded from the opening of each transcript (not published): the general-purpose agent type's own system prompt and tool set; the harness's environment notes (working directory `/home/user/devos`, date, platform); `CLAUDE.md`, which reaches every subagent (EV-C00-014 T-12); and the guard, which judges every call and logs it with the subagent's `agent_id` (observed in the guard log on 2026-10-06). `CLAUDE.md` and the guard are installation scaffolding, not DevOS's planned mechanisms; they cannot be removed for a subagent of this session and are part of the baseline's configuration (their blobs are recorded, section 9).

**What it receives, exactly.**
1. The prompt: the content of the merged `task_<condition>.md`, with every `{{WORKSPACE}}` replaced by the workspace's absolute path. Nothing is added or removed. The `description` field is `BR-212 <id>`.
2. The workspace `<scratchpad>/bl/<id>/`, where `<scratchpad>` is the executor's scratchpad directory (written as a literal absolute path) and `<id>` is `r` followed by 4 random hexadecimal digits, unique, never derived from the condition. It contains only `materials/`, a copy of the merged `materials_<condition>/`.

**Where the executor's files are** (CHK-C00-041 finding 11). Only workspaces are under `<scratchpad>/bl/`. The executor's own files (the ID-to-condition mapping, the decisions on the checks, the check outputs and the run log) are kept in `<scratchpad>/blx/`, outside `<scratchpad>/bl/`, the parent of the workspaces.

**Tools.** The general-purpose type has the session's tools. The text limits the runner to Read, Glob and Grep inside its workspace; that limit is an instruction, enforced after the run by the isolation audit (section 7). The guard does not limit read paths.

**Sources.** Only the files in its workspace, and its own general knowledge. Not allowed: the research library (except as the next paragraph allows), the web, GitHub, the `devos` repository in any copy, other workspaces.

**The library clause** (W-C00-15's acceptance; CHK-C00-041 finding 4). The clause makes library access depend on D-011, which is superseded by D-014. It is read by its intent (CHK-C00-023 C3: direct read-only access to the library), not only by its letter. If D-014 is answered allowing direct library reading, and the library is attached to the session before the first run, the runners get read-only access to the library clone, as the clause's intent asks, through a revision of this protocol, the texts and the criteria merged before the runs. Otherwise the runs have no library access, and the result record says so and why (D-014 unanswered or answered against direct reading, or the library not attached). Today D-014 is unanswered and no library is attached. The task needs none: everything about Brindle is in the materials.

**Budget.** At most 40 tool calls (stated in the text) and 30 minutes from launch (this protocol's limit, not stated to the runner). Expected: 10-20 calls and 5-15 minutes [estimate]. A run that has not returned at 30 minutes scores S = no; if it returns later, its output is still scored.

**Stopping rule** (as the text gives it): return the design as the final message; at most 40 tool calls; at the limit, return the best design so far.

**Output.** The runner's final message, returned to the executor as text: a Markdown design of at most about 1,500 words. The executor saves it verbatim. The runner writes no files.

---

## 4. Runs

**Number.** 5 runs per condition, 10 in all, plus replacements.

**Why 5.** The result is a count, and its use is a later comparison with an arm run under the mechanisms. With 3 runs per arm, only 3 of 3 against 0 of 3 could show a difference (one-sided Fisher exact test, p = 0.05). With 5, a difference of 4 runs (5 against 1, or 4 against 0) reaches p of about 0.024. The cost is small: the materials are 188 lines, so the 10 runs together cost about as much as two or three of the installation's checker runs [estimate]. The 5 runs measure run-to-run variation on one form, not variation across forms (section 10).

**Launch.** All 10 runs in one batch, in a random order generated and recorded before launch, each with its own workspace and ID. The mapping from ID to condition is kept only in a file in `<scratchpad>/blx/`, outside every workspace and outside their parent `<scratchpad>/bl/` (section 3).

**Replacement.** A run voided by the audit (section 7), or ended by a harness error (no final message for a reason that is not the runner's own choice), is replaced by a fresh run of the same condition with a new ID and a new workspace; at most 3 replacements per condition. If fewer than 5 valid runs remain in a condition, the result is reported on the valid runs with the shortfall stated.

---

## 5. Hint check (before any run)

**Who.** A fresh general-purpose subagent that has seen neither the criteria nor the materials.

**What it gets.** The task text exactly as a runner gets it: the texts are byte-identical, so it gets it once, with `{{WORKSPACE}}` replaced by a path of the same form whose ID no run uses. It gets no materials and no criteria, and it uses no tools.

**Prompt (exact).** "Below, between the lines `=== TEXT ===` and `=== END ===`, is a work-item text exactly as a worker would receive it. Use no tools; answer from the text alone. List: (1) every requirement the text states; (2) every further requirement, constraint, risk or concern that the text implies or hints at; (3) the frame the text sets for the problem, and any way the text hints that this frame might be wrong. For every item in (2) and (3), quote the words of the text it rests on. Be thorough: include anything a careful reader might infer. Return the three lists as your final message." The text follows between the two marker lines.

**Decision.** The executor applies criteria section 6 to the items of lists (2) and (3) and records the matching item, if any. A check in which the hint checker made any tool call is void and is repeated by a new subagent.

**Loop.** If a hint is found, the text is rewritten to remove what the matching item quotes, identically in both files (written by a producer subagent acting as task designer that runs nothing and starts no subagent, never by the executor; the guard log's `agent_id` on every Write or Edit to these files shows it, and the result record names the subagent (CHK-C00-041 C3, added 2026-10-06 before any rewrite or revision was written)), and a **new** hint checker checks the new text. At most 3 checks (2 rewrites). If the third still finds a hint, this form is dropped: a new form is written by the recipe (section 10), and the revised pre-registration is merged before any run. If the two texts ever stop being byte-identical, each is checked by its own hint checker.

## 6. Materials check (before any run)

**Why.** It shows that the gap is present and readable in the gap set and absent in the control set, so that a miss in the gap condition is the runner's, and a "finding" in the control is a false claim.

**Who and what.** Two fresh general-purpose subagents, one per material set, each with its own workspace holding only `materials/`; no task text, no criteria.

**Prompt (exact).** "The folder `{{WORKSPACE}}/materials` holds a system's documentation. (1) List every component, process or person that reads run records or any part of them, under any name the documents use, with what each reads and when; cite the file and the sentence. (2) List every point where the documents leave unclear whether, or when, something reads run records or needs them kept. Use only the Read, Glob and Grep tools, only on files inside `{{WORKSPACE}}`, with absolute paths (for Glob and Grep, set `path` to `{{WORKSPACE}}/materials`); at most 30 tool calls; do not write files. Return the two lists as your final message."

**Decision and loop.** The pass rules are criteria section 7. On a failure, the materials are revised (written by a producer subagent acting as task designer that runs nothing and starts no subagent, never by the executor; the guard log's `agent_id` on every Write or Edit to these files shows it, and the result record names the subagent (CHK-C00-041 C3, added 2026-10-06 before any rewrite or revision was written); identically in both sets, except the one line of criteria section 1), the criteria's citations are updated, and two new subagents check again; at most 2 revisions, then the form is dropped as in section 5. Both checkers are audited as runners are (section 7).

**Order.** The hint and materials checks may run before or after the pre-registration merges. The runs use only files that are on `main` and have passed both checks.

---

## 7. Isolation audit

**Workspaces.** Every workspace is under the executor's scratchpad, never inside a repository, and holds only what section 3 (runners), section 6 (materials checkers) or section 8 (the scorer) lists. No runner's or checker's workspace holds the criteria. Before launch the executor records the SHA-256 of every workspace file; each must equal the merged file of the right condition.

**Method** (CHK-C00-041 C4). After the runs, and before any scoring, the executor audits every runner and check subagent with `python3 tools/subagent_audit.py audit <agent-id> <workspace>`, a read-only tool in `tools/`, added by a parallel change that is checked before any run. It reads both sources:
1. the transcript, `/root/.claude/projects/-home-user-devos/<local-session-id>/subagents/agent-<agent-id>.jsonl`, which holds each tool call with its full input; the matching `.meta.json` names the `toolUseId` of the `Agent` call that started it (layout observed on 2026-10-06);
2. the guard's decision log `/tmp/devos-guard/<session>.jsonl`, its records with that `agent_id` (tool, logged path, decision).

It applies the rules below to every call, compares the two sources' call counts, and prints the transcript's SHA-256, which the executor records at audit time. `python3 tools/subagent_audit.py last <agent-id>` gives a subagent's final message. No other interpreter reads these locations: the guard denies an ad-hoc one that names them (rule B5; the designer's own attempt was denied, guard record #2849). The tool's blob goes in the result envelope (section 9).

**Audits already done.** The audits of hint check 1 and materials check 1 were made with a scratchpad script that covered only the transcript (CHK-C00-041 finding 12). They are redone with the tool before the first run; an audit that cannot be redone (for example because its transcript is gone) is recorded in the result record as a deviation, with the reason.

**Raw evidence for the final check.** The step-10 checker reads the raw transcripts and the guard log in the same container, right after the audit, before the container can be reclaimed, and compares them with the audit table and the recorded SHA-256 sums; steps 6 to 10 therefore run in one stretch (section 12). If it cannot, its verdict says that it judged the audit from the audit table alone.

**Rules, for every tool call.**
- The tool is Read, Glob or Grep. TodoWrite and ToolSearch reach no file and no network and are allowed. Any other tool voids the run.
- Every path argument (Read `file_path`; Glob `path` and `pattern`; Grep `path` and `glob`) resolves inside the workspace. A Glob or Grep without `path` searches the session's working directory, `/home/user/devos`, and voids the run; so does a `..` that leaves the workspace.
- Any access to the criteria in any copy, to the `devos` repository (the live tree, a scratch clone, GitHub, its web pages), to the library, to another workspace, to the mapping file or to anything else outside the workspace voids the run, whether the guard allowed or denied the call and whether or not it succeeded.
- The guard log's count of calls for the `agent_id` is compared with the transcript's; a difference is recorded, and a breaking call found in either source voids the run.

**After a void.** The run is not scored; its output is kept with the reason; it is replaced (section 4). The hint checker's audit is simpler: any tool call voids the check.

**Recorded per run (public).** Agent ID; launch and end times; number of tool calls in the transcript and in the guard log, and any difference; for each call the tool and its path arguments (no file content); inside or outside; which material files were read; the transcript's SHA-256 at audit time; valid or void, with the reason. The transcripts themselves are not published (`CLAUDE.md`). They are container-local and are lost when the container is reclaimed (working order section 10), so the audit runs right after the runs.

---

## 8. Scoring

**Scorer.** One fresh general-purpose subagent, after the audit. Its workspace `<scratchpad>/bl/<scorer-id>/` holds only `criteria.md` (the merged copy), `materials_gap/`, `materials_control/` and `outputs/<run-id>.md` (the verbatim final message of each valid run). It gets no mapping, no audit data, no times and no tool counts.

**Blindness.** The run IDs do not encode the condition, and the outputs are given to the scorer in a random order, generated and recorded before scoring. The scorer is not told which output belongs to which condition; it scores every observable for every output. It is blind to run order and to the condition labels, but not to content: an output may show its condition by what it says (for example by quoting the line that differs). That cannot be prevented and is stated in the result.

**Prompt (exact).** "Your workspace is `{{WORKSPACE}}`. Read `{{WORKSPACE}}/criteria.md` in full. Then score each output in `{{WORKSPACE}}/outputs/`, in this order: {{ORDER}}. Apply section 5, 'Observed per output', to every output. You are not told which materials any output was written from: score every observable for every output, and do not guess the condition. For each output return: D (yes or no, with a quote), Hh (yes or no, with a quote), V1-V6 (met, not met or not addressed, with the window or rule the output states and a quote), C (parts 1-4, each present or absent), and every R item with its class and a quote. Check facts against the materials where needed. Use only the Read, Glob and Grep tools, only on files inside `{{WORKSPACE}}`, with absolute paths (for Glob and Grep, set `path`); at most 80 tool calls; do not write files. Return one block per output as your final message."

**Scorer audit.** As section 7, with the scorer's workspace. Reading the mapping, the audit records, a transcript or anything outside its workspace voids the scoring, and a new scorer scores.

**Derivation.** The executor applies the mapping and criteria section 5 ("Derived after unblinding") mechanically; S comes from the audit. The scorer's output is recorded verbatim. One scorer is used: every score carries a quote, and the checker verifies each score against its quote and the output.

**How results are read (fixed now).** Each primary outcome is reported as k of n valid runs. For this form only: 0-1 of 5 is "rarely", 2-3 "sometimes", 4-5 "usually". Between this baseline and a later arm of 5 runs, a difference of fewer than 4 runs is not read as evidence of a difference (section 4). No rate is claimed beyond this form.

---

## 9. What is recorded, where, and how it is used

**Result record.** `evidence/C00/EV-C00-<nnn>_baseline_results.md`, with the next free number at the time of writing. It carries the common evidence envelope (plan 8 item 9):
- source commit: the merge commit of this pre-registration on `main`, and the commit whose files were copied into the workspaces;
- configuration: the agent type, the model and effort observed, the blobs of `.claude/hooks/tool_allowlist.py`, `CLAUDE.md` and `tools/subagent_audit.py` at that commit, the tools the runners used;
- criterion version: the blob of `criteria.md`;
- input: the SHA-256 of each task text and of each material file per condition; the workspace IDs, the launch order and the scoring order;
- observation: the hint-check and materials-check outputs verbatim, the audit table, the scorer's output verbatim, the derived outcomes and their reading (section 8);
- raw evidence ID: the agent IDs, the local transcript paths and each transcript's SHA-256 recorded at audit time (container-local, not published, lost when the container is reclaimed);
- independence level: runners, check subagents and scorer are fresh-context subagents in the same session; the designer knew the gap and ran nothing; the executor knew the gap and launched, audited and derived; one model family throughout (U-3).

**Runner outputs.** `evidence/C00/baseline/runs/<run-id>.md`, each verbatim under a short header (condition after unblinding; valid or void). Void runs are kept, marked void, and not scored.

**Order of time.** The merge time of this pre-registration (its merge commit on `main`) and the launch time of the first run (its first guard-log record) are both recorded; the first must come before the second.

**Public safety.** Before the records are committed: `bash tools/check_service_names.sh` is clean, and the guard's leak check runs on the push. No transcript is published.

**Ledger.** A log entry; the result record named in W-C00-15's `evidence:` field; acceptance by the checker's verdict file.

**Evidence on U-1.** The result record states: "In form BR-212 (class: hidden second use of the artefact being changed), with no DevOS mechanism, fresh general-purpose subagents of the installation session found and handled the hidden requirement in k of n runs; in the no-gap control they stopped correctly without unnecessary preparation in j of m runs, with f false gap claims." It does not close U-1 (plan 10.2: no list or mechanism guarantees discovery).

**Baseline for plan 6.12 item 4.** The executor adds stage notes to `plan/work/C07.md` and `plan/work/C10.md` that name the result record as the no-mechanism reference for the removal test of the discovery and preparation mechanisms, with the limits of section 10.

**Checker.** A fresh `checker` subagent judges that the run followed this pre-registration: the steps of section 12 were done in order; the criteria and texts were on `main` before the first run; the files the runners got match the merged files; the hint and materials checks passed under their rules; the audit used section 7's method, the audits of hint check 1 and materials check 1 were redone or recorded as deviations, the audit was complete (judged from the raw transcripts and guard log, or from the audit table alone, as its verdict states) and voids were handled by its rule; the scorer was blind as stated; the derived outcomes follow criteria section 5; nothing in the criteria changed after the first run. Its verdict goes to `evidence/C00/checks/`.

---

## 10. Task family recipe and comparability

**Contamination.** Once this is merged, the form and its gap are public, and any later DevOS session can read them. BR-212 is retired as a blind task: it is not used in any exam of C05, C07 or C10.

**The class.** Hidden second use of the artefact being changed. A work item asks to change, limit or remove an artefact for a stated purpose that includes not losing or breaking what the system still needs. A second use of the artefact, documented only in a material about another component, depends on it in a way the change breaks. No value of the obvious parameter meets both, so the frame must change. The fix is cheap once the second use is seen.

**Who writes a new form.** A new form that replaces BR-212 in this baseline (sections 5 and 6) is written by a producer subagent acting as task designer that runs nothing and starts no subagent, never by the executor; the guard log's `agent_id` on every Write or Edit to these files shows it, and the result record names the subagent (CHK-C00-041 C3, added 2026-10-06 before any rewrite or revision was written).

**Recipe for a parallel form.** Written by the exam environment and kept there, not in public `devos`, until it has run (plan 7.3):
1. A new fictional system, with new names and vocabulary, in DevOS's domain (the operation or design of an AI-assisted development system). Not Brindle; no real product or service.
2. An artefact and a change (delete, truncate, compact, rename, move, rate-limit or reformat) not used by an earlier form.
3. The task text follows `task_gap.md`: the label; a context paragraph naming only the artefact and at most its obvious producer, which it may leave out (BR-212's has not named the dispatcher since hint check 1, section 13); a purpose sentence with the target and the "without losing anything ... still needs" clause; four asked parts adapted to the change; the same materials sentence; the "How to work" block, budget and output limit word for word. 250 to 400 words, byte-identical in both conditions.
4. Materials: 7 to 9 files, 150 to 250 lines, 1,500 to 2,300 words, with these roles: an overview with a document table; the artefact's specification, which defines the term the hidden user employs (one terminology hop); it may say that the item exists only there only if that holds in both conditions; the discovery line may name the store instead (BR-212 since materials revision 1, section 13); a quantitative report from which the feasible range of the obvious parameter follows; an operations page with two or three visible users, each settled (one with a time window, one that copies what it needs at the end); a component page that keeps its own copy (the visible decoy); the component page that carries the hidden use in one sentence, with a table of its effects and no incident report; a decision log in which one decision settles a stock concern of the change type (for example "no obligation applies", "no new paid resources", the dry-run rule); a configuration excerpt identical in both conditions.
5. The gap: exactly one discovery sentence plus one definition sentence; no feasible value of the obvious parameter avoids it; its consequence is a repeated or lost effect, material to the stated purpose; the specific use is not a stock concern of the change type (the hint check of section 5 tests this); the text names nothing of the hidden component's function.
6. The control: the same files, with only the discovery sentence replaced by one of about the same length (within 15%) saying that the component keeps its own state; everything else byte-identical, checked with `diff`.
7. Criteria with the same sections, observables (D, Hh, V-list, C, R classes, G, F, UP, P, S) and primary outcomes, fixed before the form runs.
8. The hint check and materials check of sections 5 and 6, unchanged.
9. The same agent type, budget, n and audit, or each difference stated.

**Comparability limits.**
- Parallel forms are matched on how they are built, not on measured difficulty. Two forms of the same class can differ in difficulty by more than the effect a removal test looks for, and with 5 runs per form, form and arm are confounded when compared across forms.
- So this baseline alone cannot carry a removal test. A removal test in C07 or C10 should run both arms, with and without the mechanism, on the same unseen form at the same time. This baseline then checks that the no-mechanism arm's level on the new form is in line with BR-212's; a large difference shows a difference of form, not of mechanism.
- In C07 and C10 the runners are DevOS roles under C05's common rules, with the database, possibly the library and the context package, and the task arrives as ordinary work in the hidden-exam setting. Here a general-purpose subagent knows it got a task text, and the label tells it the data are made up. Each difference can change behaviour.
- A different model or harness version invalidates this baseline as a level (plan 6.12 item 4 retests on such changes); it is then re-run on a new form.
- This record publishes the class. A DevOS session that has read it may look for hidden second uses because it knows the exam class: learning to the exam (plan 7.3). C07 and C10 should also use other gap classes (not comparable with this baseline) and record whether the class was knowable to the team.
- One model family writes, runs and scores (U-3).

---

## 11. Known risks to validity, and what this design does about them

| Risk | Mitigation |
|---|---|
| The gap is too easy (every run finds it) | The discovery sentence is in a page about another component (`scheduler.md:20`); it uses the term "session header", defined only in `run_records.md:13`, though since materials revision 1 it also names the run store, so the second step is weaker (section 13); four visible readers that are settled and can make a runner stop looking; a decision that "no obligation" applies. If 5 of 5 find it, that is the result; it is not re-run with a harder task. Later forms tune difficulty with the recipe's levers. |
| The gap is too hard or unfair | The materials check (section 6) shows it can be read; the criteria cite where; the audit records whether a runner read `scheduler.md`, so a search failure is told apart from an inference failure. |
| The text hints at the gap | Byte-identical texts; the text names no periodic work, trigger, scheduler or dispatcher (the dispatcher since hint check 1); the hint check with a strict matching rule and a bounded rewrite loop. |
| The control invites preparation, or is trivially easy | It invites it (a deletion, "without losing anything", several readers to check), and every invitation is settled in the materials; unnecessary preparation is defined by observable classes (criteria sections 3 and 5). |
| The synthetic label signals a test | The same in both conditions and required by criterion 20; stated as a difference from C07/C10's hidden-exam setting. |
| `CLAUDE.md` primes the runner | It says nothing about scheduling or about records reused as state; its presence is recorded. |
| Isolation rests on an instruction | The criteria are never in a runner's workspace; the audit voids any access outside it; the scorer is blind to condition and order. |
| Scoring error | Every score carries a quote; the checker verifies them; one scorer, stated. |
| Small n | Counts with fixed bands; no rate claimed; section 4's threshold for reading a difference. |
| The executor knows the gap and runs everything | Every step after the design is mechanical and recorded; the checker verifies the order and the derivation. |

---

## 12. Steps, in order

1. Merge this pre-registration (protocol, texts, materials, criteria) into `main`; record the merge commit and its time.
2. Hint check (section 5); a rewrite is merged before step 4.
3. Materials check (section 6); a revision is merged before step 4.
4. Build the 10 workspaces from `main`'s files; record the IDs, the mapping (in `<scratchpad>/blx/` only), the SHA-256 sums and the random launch order.
5. Launch the 10 runners in one batch (section 3).
6. Audit every run with section 7's tool, recording each transcript's SHA-256; replace void runs (section 4) and audit the replacements. Steps 6 to 10 run in one stretch in the same container.
7. Save the valid outputs; build the scorer's workspace; record the random scoring order; run the scorer; audit it.
8. Unblind; derive the outcomes (criteria section 5); read them as section 8 fixes.
9. Write the result record, the runner outputs and the ledger entry; add the C07 and C10 stage notes.
10. A fresh checker's verdict on whether the run followed this pre-registration; it reads the raw transcripts and the guard log before the container can be reclaimed (section 7).

---

## 13. Revisions

The git history keeps the text before each revision; nothing is removed from this record's history.

**Revision 1, before any run.** Written by a producer subagent acting as task designer, which ran nothing and started no subagent (CHK-C00-041 C3).
- **Task text** (hint check 1; section 5). Hint check 1 (agent `a7ea1900134f334f3`, no tool calls, valid) listed as implied, in its list (2) item A4, that the dispatcher may itself read past runs, among other things to avoid duplicates, resting on the words "Its dispatcher starts agent sessions". That matches criteria section 6's first rule. The phrase is removed from both texts, identically; "every session" becomes "Every session", and nothing else changes. Check 2 of at most 3 checks the new text.
- **Materials** (materials check 1; section 6; revision 1 of at most 2). Both checkers met their reader rules (gap set: agent `a89f6d1b05666cab7`; control set: agent `a22a94eaa6826da28`) and failed criteria section 7's "Both" rule. The gap checker found unclear which records the done check scans, whether it reads the run store, what it does with a missing or unreadable record, and how `brindle periodic retry` gets past it. The control checker found `run_records.md`'s "not stored anywhere else" at odds with `periodic_runs`, and found unclear who reads the header fields, what a restore of `dispatcher.db` does, and whether retry needs the header. Both listed further points that could change what may be deleted: the on-call window, the promote window, the usage copy, fixture repair, the periodic sessions' data, agent sessions' access to earlier records, the fixtures path and security use. Each is settled in the materials, identically in both sets except `scheduler.md:20`, which each set revises (criteria section 1). `run_records.md:17` no longer says that the header is stored nowhere else, which was false in the control; it says what the `sessions` table holds. Still 8 files and 188 lines; about 2,160 words.
- **Effect on difficulty, stated, not tuned.** The discovery sentence now names the run store, so a careful reader of `scheduler.md:20` no longer needs `run_records.md` to see that deleting a record removes what the check looks for: the gap is easier to read than before. More readers are now settled in plain words, which gives a runner more places to stop looking. Neither change was made to move the result; the net effect is unknown, and the results are read with it.
- **Criteria** (CHK-C00-041 C1, C2). One definition of the correct stop, the same in sections 3 and 5; rules for an exemption inside the job, a trash or quarantine step inside it, and human steps before enabling; rules for deciding Hh (how age is counted, a fixed retention of at least 92 days, partial protection, a choice left open). Facts F1-F13 and their citations follow the revised materials; the feasible window (7 to 47 days) is unchanged.
- **Protocol** (CHK-C00-041). Section 7 names the audit tool, has the audits of the first checks redone, records each transcript's SHA-256 and has the step-10 checker read the raw evidence (C4); sections 9 and 12 follow. Section 3 states how the library clause is read (finding 4) and where the executor's files are kept (finding 11); sections 4 and 12 follow.
- **Materials-check rule and recipe** (added to revision 1 before materials check 2 runs; written by a second producer subagent acting as task designer, which ran nothing and started no subagent). Criteria section 7 adds a dated revised rule for materials checks 2 and 3 only, adopted by the executor as a technical decision. Reason: under the old "Both" rule's letter the gap set fails even when the gap is present, readable and unambiguous, because a careful checker notes that no document lists the dispatcher as a consumer that needs records kept, even after deriving that need in its list (1); stating the need in the materials would break section 10 item 5. The revised rule fails the gap set only for an unclear point that leaves the done check's mechanism open or conflicts with the checker's list (1); the control rule and the rest of the "Both" rule are unchanged. Materials check 1 stays failed under either rule (gap points 1 and 3 left the mechanism open; control points 5 to 7 named the done check and the session header), so no failed check becomes a pass (Appendix G, G8 item 3); the new rule is tested only on checks 2 and 3, whose outputs had not been seen. Section 10 items 3 and 4 follow BR-212 as revised: the context paragraph may leave out the artefact's obvious producer (hint check 1 read "Its dispatcher starts agent sessions" as a hint, and the phrase was removed), and the specification need not say that the item exists only there when that is false in the control (materials check 1 found `run_records.md`'s "not stored anywhere else" at odds with the control's `periodic_runs`); the discovery line may name the store instead.
