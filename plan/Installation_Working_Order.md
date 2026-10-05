# Installation working order (rules of the working session)

**What this file is.** The rules of the working session (the executor) that runs the DevOS installation from C00 to C12. The executor is the session whose first message is the installation `/goal` of Appendix F (`plan/Ek_F_Baslangic_Mesaji.md`); any other session follows the task in its first message and does not run the work loop (section 4). Source: Batu's decision D-010 (`plan/decisions/D-010.md`; the approved summary `briefs/conversation/KARAR_OZETI_2026-10-05_TR.md`, English rendering `briefs/conversation/DECISION_SUMMARY_2026-10-05_EN.md`; "summary n" below means its item n) and the plan change PC-06. The plan (`plan/DevOS_Kurulum_Plani.md` and its appendices) is binding; this file says how the installation work runs, not what it builds. Rules for every role: `CLAUDE.md`. Role rules: `.claude/agents/`.

## 1. Batu's principles

Summary section B, items 3–9, verbatim (all of them Batu's), each with its English rendering. The working session and every subagent follow them.

3. "Kendi kendine ilerlemek" = plana sadık kalarak son adıma kadar gelip DevOS'u kurmak; çalışırken "şu dosyaya yazayım mı, bunu okuyabilir miyim" diye sormadan çalışmak.
   *"Moving forward on its own" = staying faithful to the plan, getting all the way to the last step and setting up DevOS; working without asking "shall I write to this file, may I read this" while working.*
4. Kurulumun iki temeli: (a) işi planlanan adımlara göre ilerletmek; (b) plandan kopmadan, drift yaşamadan, nerede kaldığını unutmadan ilerlemek.
   *The two foundations of the installation: (a) moving the work forward by the planned steps; (b) moving forward without breaking away from the plan, without drift, without forgetting where it left off.*
5. Batu teknik karar vermez. Teknik kararları kurucu, araştırmaya ve kanıta dayanarak verir. Batu'nun sözleri teknik şartname değildir; örneğin "ayrı oturum" ya da "o işi yapmamış bir oturum" derken teknik olarak ayrı bir oturumu kastetmedi.
   *Batu does not make technical decisions. The builder makes them, based on research and evidence. Batu's words are not a technical specification; for example, by "a separate session" or "a session that has not done that work" he did not mean a technically separate session.*
6. Akıl yürütme ilkesi: anomaliler (ör. oturumun ölmesi; "olursa yapacak bir şey yok") standart akışla karıştırılmaz; ikisini karıştırmak kararları baltalar. Standart akışta düzenli yaşanacaklar (ör. kullanım limiti) ise standart akışın parçası olarak tasarlanır.
   *Reasoning principle: anomalies (e.g., the session dying; "if it happens, there is nothing to be done") are not mixed up with the standard flow; mixing the two undermines decisions. Things that happen regularly in the standard flow (e.g., the usage limit) are designed as part of it.*
7. Akıl yürütme ilkesi: her yan dal kapanır ve ana iş hattına dönülür (madde 2).
   *Reasoning principle: every side branch closes, and the work returns to the main line of work (summary 2).*
8. Batu ile iletişim: kısa cevaplar; adım adım birlikte; konuyu dağıtmamak; soru sorarak konuyu dağıtmamak.
   *Communication with Batu: short answers; step by step, together; not derailing the topic; not derailing it by asking questions.*
9. Önce çalışma oturumunun nasıl çalışacağı belirlenir ("kurulumun kurulması"), sonra kurulur; C00'a bundan önce dönülmez. "Kurmak"tan anlaşılan konuştukça netleşebilir; bu özet o yüzden değişebilir.
   *First, how the working session will work is decided ("setting up the installation"), then it is set up; there is no going back to C00 before that. What "setting up" means may become clearer as we talk; that is why the summary may change.*

## 2. Structure

- **One working session** runs the installation and gives the work to subagents and workflows (summary 10). It reads the plan itself, takes the next step in plan order, splits the work, writes the subagents' tasks, is the only one that commits, opens pull requests and merges into `main`, opens and closes side branches, and brings Batu only his own decisions (16). Where it left off is carried by the record (`main`, the plan, the ledger), not by the session.
- **Helpers** (`.claude/agents/`; 17–19). `producer` (Üretici) writes. `researcher` (Araştırmacı) reads and does not decide. `prober` (Sınayıcı) watches the platform and runs tests written in advance. `checker` (Denetçi) is fresh eyes: it evaluates and does not fix; it also asks "have we broken away from the plan?" when a side branch opens or closes and at the end of a stage. `counter-designer` (Karşı tasarımcı) designs without seeing the plan, for C00 step 5 only; its only tool is Write, so the task text the executor writes carries everything it may see (SOUL's goal, Batu's decisions and principles, the criteria and the platform facts; plan C00 step 5). The test designer (Test tasarımcısı) is written at C02. The executor sets the timing; a workflow is a helper. These are the builder's helpers, not Appendix A's DevOS roles: at C05, when DevOS's role set is set up, they are removed or handed over, and `CLAUDE.md` gives way to DevOS's common rules (plan Appendix D).
- **Limit** (11). The single session holds fully up to C03. Separate sessions or environments stay where the plan requires them: the session and routines observed in C01, the audit environment from C03, C04's secret search question set, and the exams (C05, C07, C10). A session in Accept edits cannot start sessions, so when one is needed it goes to Batu as one narrow question (the first time in C01).
- **Two layers** (20). (a) Running the plan, mechanically: sections 3 to 9. (b) Reasoning inside a step: splitting the work, choosing the role, interpreting the result, making the technical decision, noticing a gap in the plan, questioning the frame when stuck. For (b): Batu's principles (section 1), the thinking disciplines and the session opening and closing rules of plan Appendix D section 2, and Appendix G's G4, G8 and G10 (23). The plan's own principles (plan 0.3, [Batu kararı]) hold here too, among them: quality is not lowered for convenience or cost, and an unsolved problem is not presented as solved because "it will be tested later" (items 1 and 6); frame blindness is the greatest danger, so when a design hits a limit and starts producing new mechanisms as a fix, the frame is questioned first (item 11, plan 6.12). Appendices D and G were written for DevOS and are borrowed here, adapted (their records go to the ledger files until DevOS's database exists); they do not take the place of C05's setup. Appendix D's "do not trust a long session's summarization; move on by hand-over" is replaced by the single session with the re-read hook (section 3).

## 3. Opening, and re-reading

**Opening check** (once, when the session starts; summary 12):
1. `get_session` without `session_id`: the model is `claude-opus-5-5` and the permission mode is `acceptEdits` or `default` (the app's "Accept edits" choice registers as `default` for a session Batu opens, observed on 2026-10-05, L-118 CR-1; in both the guard decides every call). Effort, ultracode and the goal condition (`external_metadata.goal`) are recorded as shown; a setting that is not shown is recorded as not visible, not as absent (the repository pins effort at `xhigh`). The evidence of the goal is the session's own first message.
2. `python3 tools/guard_report.py`: this session's decision log exists and counts allowed calls, so the guard is live; note the effort the harness reports.
3. If the model, the mode or the guard is not as required, or the session's own first message is not the installation `/goal` of Appendix F, do no plan work: tell Batu in one short Turkish message what to change in the session, and record it.
4. Write what was found in a log entry, then continue.

**Where it left off** (at opening, and after every compaction): read this file, plan Appendix D section 2 and Appendix G's G4, G8 and G10 (the reasoning layer, section 2), `plan/ledger.md` sections 1 and 2, `DURUM.md`, the last entries of the current stage's log (`plan/ledger/<stage>-log.md`) and Batu's new answers (section 8); then read in full the plan sections that the next item names. At opening, also read the whole plan and all its appendices (plan 0.1). After a compaction the hook `.claude/hooks/reread_after_compact.py` prints a reminder to re-read this list; re-read before continuing, and do not trust the summary.

## 4. The work loop

1. **Next step in plan order.** Take an item from the startable frontier in `plan/ledger.md` section 2 (generated by `python3 tools/records.py render`), critical path first, with one logged sentence of reason.
2. **Acceptance before results.** An item's acceptance condition is in its file and merged into `main` before work on it starts, and it is never loosened afterwards; if it must be, the earlier result is void and the test is repeated (ledger rule 3; plan section 14).
3. **Split and delegate.** Give the parts to role subagents (`Agent` with the role as its type) or workflows, with no isolation option; long work runs in the background, and a finished background subagent or workflow starts the next turn by itself. Each task names its purpose and item, the expected output and where it goes, sources and tools, limits and budget, and whether the agent writes or only reads. One file has one writer at a time.
4. **Check.** A `checker` that did not produce the result judges it, at its full head SHA, against the acceptance condition and the plan text it serves. The executor writes its verdict verbatim to `evidence/<stage>/checks/CHK-<stage>-<nnn>.md` (section 9). On PASS, or PASS-WITH-CONDITIONS with every condition met, the item is accepted (`acceptance: accepted`, `accepted_by:` the verdict file). On FAIL: fix, and a fresh checker judges again.
5. **Merge.** Edit, render and commit in a scratch clone (`git -C <literal path>`), never in the live working tree, which stays at `main` (guard B4); after each merge bring it forward with `tools/sync_worktree.sh`. Commit on a `claude/` branch, push, open a pull request on `batuhanozgun/devos`, and merge with `merge_method: merge` and the full 40-character head SHA as `expectedHeadSha` (guard M6). The guard then runs `python3 tools/merge_gate.py --pr N --head SHA` (M7): a head whose diff from `main` touches a class-high path (listed in `tools/merge_gate.py`), deletes a `plan/work/*.md` file, or changes or removes an existing acceptance block in one, needs a verdict file that the pull request itself adds or changes, whose `reviewed_head` is that head or a commit X of this pull request (not one already on `main`) after which only class-normal paths changed; a verdict already on `main` covers no later pull request. So: commit the change, have it checked at that SHA, add the verdict file and the records, then merge.
6. **Record.** A log entry, the item's status, and `summary_tr` (Turkish, for Batu) in `plan/ledger.md` section 1; then `python3 tools/records.py render`, which regenerates the ledger's generated blocks and `DURUM.md`. Merge at every checkpoint (each finished item) and before every stop (PC-03).
7. **Go on** to the next step. A stage boundary is not a stop.

**Stage work list** (at stage start). The first item of a stage creates its work list. The executor reads the stage's plan text in full, writes the plan's "Kabul" conditions for the stage into the acceptance block of `plan/work/<stage>.md` (verbatim, translated while the Turkish plan is binding), and writes one item file per task (`plan/work/W-<stage>-nn.md`, section 9) with its acceptance condition and `depends_on`. They are merged before work on any of them starts, so git order shows that the conditions came first. Work found later becomes a new item the same way. From C02 the test designer writes the acceptance conditions and tests.

**Stage close.** A stage is accepted when every item is accepted and a `checker` verdict on the whole stage passes: the stage achieves its purpose in the plan, and the work did not break away from the plan; the stage file then records it (`acceptance: accepted`, `accepted_by:` that verdict). Until C03 this checker is a fresh-context subagent with its independence level stated (PC-06); from C03 the plan's audit environment gives the binding verdicts. The next stage then starts at once.

## 5. Side branches (summary 21)

Reasoning may propose a side branch: work that the current plan step does not name. Before it opens, the executor writes in the log the plan step it serves, its return point and its limit, and a `checker` asks "have we broken away from the plan?". The branch closes, with its result recorded or cancelled with a reason, before the next plan step starts; the checker asks the same question at closing. A branch that reaches its limit closes, and the work returns to the main line.

## 6. Plan changes (summary 22)

The plan changes only through its section 14: a plan-change record `plan/decisions/PC-<nn>.md` with the old text, the new text, the reason and the affected stages, then the change in the plan text. An acceptance condition is never loosened after its result has been seen. Text labelled [Batu kararı] changes only by Batu's decision. Until the translation fidelity review passes, the Turkish plan text is binding (plan 0.6).

## 7. The installation `/goal` and stops (addendum E1–E3)

- One `/goal` covers the whole installation; Batu pastes it once, as the first message (`plan/Ek_F_Baslangic_Mesaji.md`). It is met only when C12 is accepted and the final message carries the proof that the goal text names. PC-01's per-stage goal and stage stops do not apply.
- What moves the session: the turns that finished background subagents and workflows start by themselves, and `/goal` prompting again when a turn ends with nothing running before the work is done.
- Three temporary "not yet" states, never "impossible": (a) waiting for Batu's decision or action; (b) a usage limit; (c) a blocker the executor cannot pass. In each, first finish and merge all work that does not depend on it.
- The `/goal` evaluator sees only the conversation. So a message that ends a turn in one of these states, and the final message, carries the proof: the state named with its evidence, and the unedited output of `tools/stop_check.sh`, which must end in `STOP_CHECK PASS`. A met goal or a passing stop check never accepts anything; only acceptance records do.
- **Waiting for Batu:** his decisions are on issue #6 and in `DURUM.md` (section 8); the message names the decision awaited. His next message resumes the work.
- **Usage limit:** read the usage (`get_session`, `rate_limit_info`) before heavy work, record it in the ledger's Usage row, and follow D-002 (proceed while `allowed`; light work only at `allowed_warning`). Near the limit, finish, merge and record the current step. After a 5-hour or weekly reset, Batu's one "devam" message resumes the work, because cloud sessions do not resume by themselves (E3; the known cost of summary 38). `DURUM.md` shows the hold and the reset time.
- **Blocker:** record it and show it in `DURUM.md` as information. A needed call that the guard denies with no allowed route is a guard gap: that action waits for a checked guard change through the merge gate, never a local edit. A choice that a blocker forces on one of Batu's matters goes to him as his decision (section 8).

## 8. Batu's channel

- **Issue #6** ("Batu'dan beklenenler"): his decisions and tasks are batched there in the Appendix E §3 format, in Turkish, with any account action given step by step. Never wait on one of his items while other work is possible. Only comments by `batuhanozgun` count; read them from the ledger's "answers seen through" row on.
- **In the working session:** an answer he types there counts as well. His Turkish words are recorded verbatim in the decision record (`answer_original_tr`) with the English interpretation, `answered_by: batuhanozgun` and `answer_channel_ref` naming the working session and the time; the log entry names it.
- **`DURUM.md`** is his Turkish status page, current at every checkpoint (section 4, step 6).
- **Where he types** (E3): once, the first message; the answers to his own decisions; after a usage-limit reset, one "devam".
- **What is his** (summary 5; FR-02): purpose and direction, scope, acceptance of results (for example C07's value, C12's hand-over), money (paid features, usage beyond D-002), and access to or a change of his accounts, data or other work. Test: would a perfect engineer still need his preference? A platform refusal or limit, an operational step of the session, or a rule the builder introduced is never his; a choice that such a case forces on one of his matters goes to him with options, never as a permission or a step.

## 9. Record formats

**Log entry** (`plan/ledger/<stage>-log.md`, append-only; a correction is a new entry that names the old one):

```
### L-nnn · YYYY-MM-DD · <item or subject>: <what happened, in one line>

- **What happened.** <facts, with evidence IDs>
- **Guard:** <tools/guard_report.py: each denial with its number and rule, or none; the last record number>
- **Record changes:** <record ID or path> · <addition | correction | supersession | retirement | annotate> · <reason>; <next change>
```

**Work item** (`plan/work/W-<stage>-nn.md`): front matter `id`, `kind: item`, `parent: <stage>`, `title`, `admission: admitted`, `execution: planned | running | waiting | finished | cancelled`, `acceptance: proposed | accepted`, `accepted_by:` the checker verdict file (once accepted), `depends_on:` a list of IDs; body `## Acceptance` with the condition between `<!-- acceptance -->` and `<!-- /acceptance -->`. A cancelled item keeps its acceptance block unchanged and states its reason.

**Decision record** (`plan/decisions/D-<nnn>.md`): front matter `id`, `title`, `title_tr`, `class: batu | technical`, `owner_reason`, `status: open | answered | declined | withdrawn | superseded`; once answered, `answer_original_tr`, `answer_interpretation_en`, `answered_by`, `answer_channel_ref`, `answered_at` and `record:` the log entry; body: the question with its options (Appendix E §3). A plan change is `PC-<nn>` with `kind: plan-change` (section 6).

**Checker verdict** (`evidence/<stage>/checks/CHK-<stage>-<nnn>.md`, written verbatim from the checker's output):

```
---
id: CHK-<stage>-<nnn>
target: <what was checked>
reviewed_head: <full 40-character SHA of the commit judged>
verdict: PASS | PASS-WITH-CONDITIONS | FAIL
conditions: none | <list of conditions>
independence: "same session, fresh-context subagent (declared, Ek A 373)"
checker_run: <subagent or workflow run reference>
date: YYYY-MM-DD
---

## Findings
```

## 10. The guard (D-008) and what it does not protect

**What it does.** One hook, `.claude/hooks/tool_allowlist.py`, runs on `PreToolUse` and `PermissionRequest` for every tool (matcher `.*`). It allows or denies every call and never asks; only `AskUserQuestion` and `ExitPlanMode` go to the user. A guard that cannot run blocks. Every denial states the rule ID, what was attempted (redacted), what matched, why the rule exists, where it is written and what to do instead. Every decision is appended, hash-chained, to `/tmp/devos-guard/<session>.jsonl`; `tools/guard_report.py` prints the denials, the allowed calls by rule, the effort the harness reported and the last record number. The rules, by ID in the guard:
- **Tools** (T1–T3): an allow list; anything unnamed is denied, including tools that appear later. Subagents and workflows run in-process only, without isolation. Denied among others: `SendMessage`, `ListAgents`, artifact and design tools, MCP resource readers, connector and plugin suggestions, worktree switching, `ScheduleWakeup`, `CronCreate`.
- **MCP and GitHub** (M1–M7): only the GitHub tools, the session tools and the read-only Supabase connector. GitHub writes only to `batuhanozgun/devos`; no file writes onto `main`, no auto-merge, no approving reviews; a merge names the full head SHA, uses the merge method and passes `tools/merge_gate.py`.
- **Sessions and repositories** (S1–S5): session tools only on owned IDs (recorded by `.claude/hooks/record_owned_id.py` into `owned_ids.txt`), new sessions only on Opus 5.5 in Accept edits with the guard checked out, routines without connectors; only `devos` may be attached, and the library read-only.
- **Files** (F1–F5): no writes into the live `.claude/`, any `.git/`, Claude Code's own configuration, credential files, or the leak check's fingerprint store.
- **Shell** (B1–B11, G0): git through allow lists; no push to `main`, no push outside the `claude/` branches of `devos`, no force or delete pushes; no commit or revision change in the live tree; no writes into guarded locations (the live `.claude/`, `.git/` and `tools/`, the decision log, the fingerprint store, configuration); no uploads or raw network tools; no `gh`, `gcloud`, `gsutil`, `bq` or `claude` command lines; no credential reads or environment dumps; no removal of critical paths; the sandbox stays on. A command the guard cannot read is denied.
- **Leak check** (L1–L3; W-C00-14; plan 0.5 item 3, K-9 item 5, 6.7): before a push to `devos` (every commit the push would publish beyond `origin/main`: its message, its paths and the lines it adds, a merge against its first parent; and the pushed branch names) and before every GitHub write to `devos` (every string field, nested ones included), the text is compared with fingerprints of the research library. A long match, one run of 8 consecutive words after normalisation (case, punctuation, Markdown and line breaks, the Turkish i forms and other diacritics folded), is denied under L1, and so is a line naming one of the service names `tools/check_service_names.sh` derives (OI-012, D-013). `python3 tools/leak_fingerprints.py build` builds the fingerprints from the clone's HEAD into `/home/user/.devos-leak-store`, outside every repository (salted 64-bit hashes, never text; other writes there are denied, B5, F5); it drops, and counts, the runs already in the `origin/main` tree of the checkout it runs from (fetch first). Text already on `origin/main` (for a service name, a line already there) does not count. The library may be cloned only to `/home/user/agentic-os-search` (L3: a clone, copy, move, fetch, remote or worktree of it elsewhere is denied). While that clone exists, a missing, unreadable or stale store (built from another HEAD of the clone) denies every public write; a store whose clone is gone is still used; with neither, only the service names are checked. A push stands alone in its Bash call, beside only `cd`, `echo`, readers and read-only git (L2), so the commits checked are the commits pushed. Neither the matched text nor a fingerprint reaches the decision log or a denial: an L1 or L2 denial does not repeat the call, any other logged call text that matches is withheld, and `python3 tools/leak_fingerprints.py scan <file>` shows line numbers only.

**Residual risk Batu accepted.** D-003 (2026-10-02): the barrier is a hook the builder can edit; accepted until the audit environment exists (C02–C03), re-assessed at C03. D-008, costs stated before he decided: (1) the classifier's general protection is gone, and only dangers written as rules are stopped; (2) a missing rule stops work until a checked guard change merges. For what the guard misses, the barrier is the merge gate's checker verdict, the git history and the environment.

**Not protected:**
- A session that deliberately edits the guard or `.claude/**`. The plain routes are blocked (F1, B5); beyond them the guard is best-effort. Not caught: a guarded path that comes from data (an archive, a patch, a copied tree), is hidden in quoting or a variable, or is produced inside an interpreter's own language (`python3 -c`, `perl -e`, an `awk` redirection), a sourced file or a function body.
- A program that reads session credentials by itself (for example `python3 -c`); only the plain routes are denied (B7, B8).
- A hidden instruction in a document a session reads can use any allowed route: a GitHub write to the public `devos` is the main outbound channel left, and web reads can carry data in their URLs (D-008 cost 1). B6 to B8 narrow it; they do not close it.
- `git push` to the library repository from a clone already attached (N-028).
- A session whose checkout does not carry this `.claude/`, for example one opened with several repositories (N-048), runs without the guard. The opening check shows whether it is live.
- The decision log lives in the container and is self-reported: it is lost when the container is reclaimed, and records removed from its end do not show (the log entry states the last record number). The independent record is the session's transcript on the platform.
- A merged bug in the guard that denies every call, or in the merge gate that refuses every merge (the fixing revert too), locks out the working session once it syncs. There is no break-glass route: the only one left is a revert through GitHub's own interface, which only the account owner can make (a stated residual, not a step planned for Batu).
- A `PreToolUse` hook that times out lets the call continue. Both guard hooks carry an explicit 600-second timeout (W-C00-14), above the merge gate's own 300 seconds (it stops itself there and fails closed); the leak check's git calls have their own shorter limits. A `PermissionRequest` hook that cannot run leaves the prompt open.
- The leak check (W-C00-14) is the fingerprint layer only. Not caught: a paraphrase or translation of library text, or a verbatim run shorter than 8 words (the semantic layer is C04 task 5); a public write made inside an interpreter or a script (`python3 -c`, a script that runs `git push`), and a store written that way; outbound URLs (a web read whose address carries library text; D-008 cost 1); text inside compressed or encoded files (archives, PDFs, base64); library text that is not at the clone's HEAD, or that is read without a clone (the GitHub read tools reach the library); a local `origin/main` ref moved on purpose (the pushed range starts there); a clone the harness itself places elsewhere. The service names are derived from revision `3cd686a` of the guard's own checkout: a shallow checkout fails closed, a complete repository without that revision (a test fixture) checks none. The git pre-push hook of K-9 item 5 and the second-layer check on the pull request are not built.
- Agent definitions are not inspected; the hook sees only the `Agent` call. The role files in `.claude/agents/` are class high, so a change to them passes the merge gate.
- The Supabase connector is read-only by its database role, not by the hook.
- The merge gate checks a verdict file's form, not its origin: the executor writes the file itself, at the declared independence level (same session, fresh-context subagent; PC-06), and `checker_run` is free text.
- `main` has no required approval on GitHub (G-015): a session without this guard, or a person, can still merge.
- Known over-blocking, safe and not to be widened: `add_repo` for the old experiment repositories; `ScheduleWakeup` and `CronCreate`; subagents and workflow agents with isolation; a `case` statement, or a variable or glob as the command word; a non-reader command that names a guarded path; a copy-like command (`cp`, `tar`, `rsync` and similar) that names a `.claude` or `.git` component; a bare `env`.
