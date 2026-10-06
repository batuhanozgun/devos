<!-- N-060: the researcher subagent's comparison of the library's ECC study with EV-C00-011 (workflow wf_cd726e24-aa7), filed in redacted form like the pass-B verdicts; changes in evidence/C00/pass_b/redaction/n060.changes.md; equivalence judged by CHK-C00-052 (passed for this file); EV-C00-019 -->

N-060: the library's ECC study against EV-C00-011 (library 941f027d3a15497b90e60d752303c0463a9feab5; devos 4d569155e7e71493a890a83a06319a6b482dc2b5)

Path keys: F = research/soul-foundations/, S = research/studies/, X = explorations/, D = development-os/, A = archives/devos-pre-claude-2026-09-29/, M = maintenance/2026-09-29-research-installation-separation/, C = research/soul-context/, P = agent/protocols/

Every library path below is relative to `/home/user/agentic-os-search/research/studies/ecc/`. EV-C00-011 is `/home/user/devos/evidence/C00/EV-C00-011_ecc_comparison.md`. That file and the N-060 text are the same at devos HEAD `31074d1` as at `4d56915`. "Stated" means the study says it. "Inference" means my own reading. I cite sections by number and do not quote headings.

1. **Row: all rows (EV "Unit and source": ECC `ef648e0`, version 2.2.3, `affaan-m/everything-claude-code`).**
   - Study: `STATE.md` (header); `SOURCE-LEDGER.md` (Primary binding, rows S01 and S03); `notes/01-SURFACES-AND-CODEX-CACHE.md` §2; `CORE.md` §10.
   - Stated: the study is pinned to `affaan-m/ECC@8321021c…`, observed on 2026-09-17, package version 2.2.1. It says a current deployment decision needs the upstream checked again.
   - Effect: adds. Every point below describes an earlier ECC revision under a different repository path. I could not check, because there is no clone and no web access, whether `8321021` is an ancestor of `ef648e0` or whether the two paths are the same repository.
   - View: no row should change on the study alone. Any wording change below needs a re-read at `ef648e0`.

2. **Row: `baseline:agents (agents-core): the "no progress" trigger in loop-operator, also in commands/gan-build.md` (adopt, idea only).**
   - Study: no file mentions `loop-operator` or `gan-build` (I searched the whole study). Related material: `evidence/U14-C-SOURCES.md` (C-MONITOR row and closure item 8); `notes/32` §4 and §8; `notes/34` §4; `notes/19` §4.
   - Stated:
     - ECC's context monitor flags repeated tool calls inside a short window. The study treats that as a heuristic, not proof that work has stalled.
     - A missing cost measurement can be written as zero instead of unknown.
     - A retry memory lasts one process only; the next invocation starts empty.
     - Merging findings by file and normalized text can fold two findings into one.
   - Effect: adds, indirectly. Inference: for the C06 test, the count of open blocking findings needs:
     - a finding identity that stays stable across rounds, so that merging or rewording cannot look like progress;
     - "unknown" kept separate from zero;
     - the round counter held in durable live state, not in session memory;
     - a verbatim repeat treated as a reason to stop and check, not as proof by itself.
   - View: adopt unchanged; add these as adaptation conditions.

3. **Row: `baseline:hooks (hooks-runtime): the idea of scripts/hooks/block-no-verify.js` (adopt, idea only).**
   - Study: `evidence/U06-B-SOURCES.md` row S139 (lines 1–280 only; the decision body was not read); `notes/10` §4 and §5; `notes/52` §5; `notes/38` §7; `notes/09` §2 (dated hook documentation, W14).
   - Stated:
     - The study has no finding on the bypass checker's decision logic.
     - ECC's own pre-commit hook has environment and marker bypasses, and passes silently when its scanner tool is missing.
     - ECC's pre-push hook checks the working tree, not the refs and object IDs that git passes on stdin.
     - ECC's installer sets a global `core.hooksPath`.
     - ECC's bash dispatcher can drop a later sub-hook's zero-exit JSON deny.
     - A hook timeout does not block (documentation dated 2026-09-18).
   - Effect: confirms that a machine rule is needed, and widens it (inference):
     - Bypass routes also include a persistent `git config core.hooksPath` change and any bypass switch the leak-check script itself offers.
     - The pre-push check should read the pushed objects and fail closed when its tool is missing.
     - Writing the rule into the guard, rather than as a sibling hook, avoids the lost-deny path.
     - C03 should add a timeout case.
   - View: adopt unchanged; widen the C03 rule and its tests.

4. **Row: `baseline:workflow (workflow-quality): skills/loop-design-check` (adopt, idea adapted; a plan-named candidate).**
   - Study: `loop-design-check` is not covered. ECC-internal cases of its checklist's failure modes:
     - A verifier that is the defendant: `notes/17` §7 (the health check reads the same recorded evaluator); `notes/07` §3 (the completion marker comes from the analyzer itself); `notes/05` §5 (a worker is marked completed on exit 0 even when its own report says verification failed).
     - A weak pass signal: `notes/40` §3–§4 (the score counts files that are present; the audit exits 0 when checks fail).
     - Criteria not fixed beforehand: `notes/17` §4 (thresholds and seeds arrive with the scores, so storing them does not show they were fixed first).
     - Stale instructions or memory: `notes/07` §6, `notes/50` §5, `notes/12` §3.
     - Steps not gated on acceptance: `notes/23` §5.
   - Effect: adds worked examples and confirms the gap EV names. Inference: item (b) should require evidence that the done-criterion existed before the result, for example a commit dated earlier.
   - View: adopt unchanged; use these cases as checklist examples and tests in C05.

5. **Row: `agent:code-reviewer (agents-core, agents/code-reviewer.md): its "Pre-Report Gate"` (adopt, idea only).**
   - Study: `evidence/U11-A-SOURCES.md` row U11A-05 (the reviewer was read in full at the study pin, including its proof and filtering rules); `notes/19` §3, §4, §6.
   - Stated:
     - The finding schema requires a proof field for high and critical findings but does not require it to be non-empty. The request for concrete evidence is an instruction; nobody measured whether reviewers follow it.
     - The reviewer reads surrounding code in the working tree, while the verifier sees only the diff.
     - The merge keeps the stricter severity but can drop the later finding's proof. In the study's run E08, input order alone flipped the outcome between approve and changes-requested.
     - Individual reviewer verdicts are discarded, and low-confidence confirmations are counted as confirmed.
   - Effect: confirms and adds (inference):
     - The concrete-failure field should be mandatory, non-empty and checked by structure.
     - Any aggregation of findings must carry location and failure together with severity.
     - Surrounding context must be read at the reviewed revision.
     - Each reviewer's verdict should be kept.
   - View: adopt unchanged.

6. **Row: `skill:deep-research`, part: handling untrusted sources (adopt).**
   - Study: `deep-research` is not covered. Related: `notes/39` §6–§7; `notes/06` §7.
   - Stated:
     - ECC's TDD skill treats the plan file as untrusted data.
     - `dev-team` strips apparent directives from a shared summary and puts a warning into each persona prompt; the study notes this cleaning can lose content that matters to all four personas.
     - The memory server labels its results as context, but nobody showed that models obey the label.
   - Effect: adds. Inference: a label is not compliance, and stripping loses information, which favours DevOS's form (flag and keep). The C03 negative test should check that the agent did not act on the text, not only that a flag was written.
   - View: adopt unchanged.

7. **Rows: `baseline:commands (commands-core): santa-loop` (disable) and `baseline:workflow (workflow-quality): skills/santa-method` (disable).**
   - Study: neither is named anywhere. Related: `notes/19` §5–§6; `notes/39` §7.
   - Stated:
     - ECC's skeptical verifier is a separate call with no forced change of model, so it is not independent of the reviewers' assumptions.
     - An uncertain refutation keeps a finding blocking.
     - Four personas fed one reduced summary share its omissions.
   - Effect: confirms F6 and the conflict with DR13-G.
   - View: unchanged.

8. **Rows:**
   - `baseline:agents (agents-core): gan-planner, gan-generator, gan-evaluator` (disable)
   - `baseline:commands (commands-core): gan-build, gan-design, loop-start, loop-status` (disable)
   - `capability:agentic (agentic-patterns): skills/gan-style-harness` (disable)

   - Study: the gan files are not covered. ECC-internal analogues: `notes/08` §5; `notes/17` §4; `notes/40` §6.
   - Stated:
     - ECC promotes an amendment on any positive difference in rates, with as few as two rows per arm.
     - Thresholds are supplied together with the scores, with no significance test.
     - Repeating a deterministic check does not make independent trials.
   - Effect: indirectly confirms EV's reasons: a score threshold is not tied to a claim, and the criterion must be fixed before the result. The study has nothing on the plateau stop.
   - View: unchanged.

9. **Row: `baseline:hooks (module hooks-runtime): the hook runtime as a whole` (disable).**
   - Study: `notes/09` §1–§3; `notes/10` §1, §3, §5; `notes/11` §1–§3; `notes/07` §6; `notes/50` §3, §4, §6; `notes/32` §1–§2; `notes/38` §2–§3; `notes/01` §4; `evidence/U06-B-SOURCES.md` W16.
   - Stated:
     - **config-protection:** it guards only a fixed list of lint and format config file names. It refuses even edits that make a rule stricter, lets an alias under another name through, lets malformed input pass, and takes its on/off and profile settings first from environment values without authenticating them. It even suggests turning itself off for a legitimate change.
     - **GateGuard:** it records the target before denying, so a plain retry passes without the facts it asked for.
     - **Governance capture:** it writes only to stderr, and nothing reads it in.
     - **SessionStart:** it adds instincts and an earlier session summary without review.
     - **Failures:** some internal failures exit 0 silently.
     - **Cost:** the cost figures are estimates.
     - **Installer:** it merges hook entries into the user's settings.
     - **Sibling hooks:** per W16, when sibling hooks disagree, the host applies the most restrictive decision.
   - Effect: confirms all four of EV's points. It also strengthens "config protection is no exception": ECC's protection would not cover DevOS criteria, tests or instructions at all. W16 supports EV's guard check that a sibling's allow cannot override a guard deny. This matches the direction N-060 reports for L-088 and L-096.
   - View: unchanged.

10. **Rows: the same hooks-runtime row and `capability:security (module security)`, in their basis "a hook cannot tell subagents apart within one session (K-9 item 2d)".**
    - Study: `notes/10` §3; `evidence/U06-B-SOURCES.md` W15.
    - Stated: GateGuard exempts subagent edit events using identifying fields in the hook input, without verifying them. The dated official hooks reference documents subagent hook input.
    - Effect: partly contradicts the wording. Inference: the fields exist but the same process reports them about itself, so K-9 2d's point (no authoritative separation) stands. The wording should become "cannot authoritatively tell". Whether the fields name the subagent's role should be checked against the dated documentation in C01 or C03.
    - View: decisions unchanged; fix the wording.

11. **Row: `capability:security (module security)` (disable).**
    - Study: `notes/10` §1 and §6; `notes/54` §2; `notes/11` §7.
    - Stated:
      - GateGuard's benefit figures are reported by ECC and were not checked independently.
      - AgentShield needs a separately installed binary, and the README gives no audited release pin.
      - `safety-guard` and `security-scan` are not covered.
    - Effect: confirms.
    - View: unchanged.

12. **Rows: `baseline:workflow (workflow-quality): skills/eval-harness` (undecided) and `skill:eval-harness, part: the pass@k and pass^k reliability metrics` (undecided).**
    - Study: `notes/40` §6 (the skill was read in full at the study pin); `notes/17` §4; `notes/08` §5.
    - Stated:
      - ECC's optimizer asks for three recorded trials before any pass^3 claim, with every critical regression trial passing.
      - An instruction to run trials is not a record that they ran.
      - Distinct seed labels are lookup keys, not proof of independent runs.
      - Rate comparisons can count duplicate rows.
    - Effect: adds conditions if pass^k is used (inference): k must be real separate executions with recorded input, model and revision; k and the threshold must be fixed before results; duplicates must be detected; and pass^k is only meaningful for checks that are not deterministic. None of this answers the open question.
    - View: stays undecided (C05).

13. **Row: `capability:operator-desk-patterns (operator-desk-patterns): skills/operator-approval-loop` (undecided; C02, tested in C06).**
    - Study: the skill is not covered. Related: `notes/12` §3–§6; `notes/19` §7; `notes/39` §5; `notes/54` §3; `CORE.md` §7.3.
    - Stated:
      - Plan Canvas ties feedback to a file path, with no revision or digest and no verified reviewer.
      - Its queue is cleared before the consumer has received it, and ended sessions disappear from pending lists.
      - ECC's plan and commit gates are instructions only.
      - Plans cite their source document by path.
      - A manual adaptation of `/plan` drops the approval pause.
    - Effect: adds. ECC's other approval channels show exactly the failure the open question is about. This supports adopting the binding if Appendix B lacks it. It also gives C06 test cases: an answer to edited decision text, an answer drained but never applied, and an answer after the decision closed. Inference: decision text that can be edited after an answer has the same exposure.
    - View: stays undecided (C02), leaning toward adopt if the binding is missing.

14. **Row: `skill:tdd-workflow`, part: the RED-before-GREEN discipline and its evidence report (undecided).**
    - Study: `evidence/U17-A-SOURCES.md` row TDD (read in full); `notes/39` §6; `notes/02-INSTALLATION-CHANNELS-AND-MATERIALIZATION.md` §4.
    - Stated:
      - At the study pin, RED must fail because of the intended defect, not because of a setup or syntax error.
      - The same test is rerun after the fix.
      - Evidence is bound to the branch and the task, and the plan is treated as untrusted data.
      - The PR step can rebase without repeating the evidence.
    - Effect: partly contradicts EV's basis that RED-first only fails when the code is absent; this RED is closer to a negative control tied to a claim. Inference: it is still weaker than plan 8's break test. It adds a freshness condition: evidence must match the revision that is merged.
    - View: stays undecided (C05); the comparison should use the fuller reading, checked at `ef648e0`.

15. **Rows: the `contract-first` module-item row and the 26 SOUL-stack rows (undecided).**
    - Study: `contract-first` is not covered. `notes/56` §6 and `inventory/U19-A` §2 say domain skills were not evaluated for meaning. `notes/02` §4 says language and framework selectors resolve through `framework-language`.
    - Effect: confirms EV's FL mapping; no evidence on the open questions.
    - View: unchanged.

16. **Row: `skill:plan-canvas` (disable).**
    - Study: `notes/12` §2–§6.
    - Effect: confirms. It adds reasons: there is no revision binding or reviewer identity, and the Stop hook backstop has a bounded message size.
    - View: unchanged.

17. **Row: `skill:unified-memory` (disable).**
    - Study: `notes/06` §2 and §7; `notes/02` §7.
    - Stated: every record is created active and unreviewed, acceptance happens outside the vault, and the skill does not bring the runtime it needs.
    - Effect: confirms the decision but qualifies EV's wording "two authoritative copies". The vault is deliberately not authoritative. Inference: the conflict is a second, unreviewed store of hand-over context outside the rule gate, plus the MCP and runtime conflicts.
    - View: unchanged; fix the reason wording.

18. **Rows: `baseline:workflow (workflow-quality): learning and self-assessment group` (disable) and `skill:continuous-learning` (disable).**
    - Study: `notes/07` §2–§6; `notes/08` §1–§6. Version 1 is not covered.
    - Stated:
      - A model analyzes observations through the `claude` CLI with read and write tools pre-approved.
      - Instincts enter SessionStart context without review.
      - A single failure is enough to produce a proposal, and promotion goes by rate difference.
    - Effect: confirms the self-approval, hidden-exam and F4 reasons.
    - View: unchanged.

19. **Row: `skill:eval-harness`, part: the skill file, evals, model grader, commands and local utilities (disable).**
    - Study: `notes/18` §1 and §9; `notes/40` §3.
    - Stated: the candidate-execution gate refuses every run, and a receipt is a record, not containment evidence.
    - Effect: confirms.
    - View: unchanged.

20. **Row: `baseline:commands (commands-core): the other 88 commands, plus scripts/harness-audit.js and scripts/skills-health.js` (disable).**
    - Study:
      - `notes/40` §1–§5: the audit scores whether files are present, exits 0 regardless, and depends on the contents of the home directory.
      - `notes/08` §3: skills with no evidence count as healthy.
      - `notes/37` §5–§6: auto-update runs fetch and pull, and one position of the dry-run flag is ignored.
      - `notes/39` §4–§5: `/plan` waits for confirmation but marks a milestone in progress first.
      - `notes/54` §5: `multi-*` depends on an external wrapper whose no-write claim was not verified.
      - `notes/19` §2 and §7: `orch-review` passes only a PR number, and its gates are instructions.
    - Effect: confirms.
    - View: unchanged.

21. **Row: `baseline:agents (agents-core): review and analysis agents …` (disable, including `harness-optimizer`).**
    - Study: `notes/40` §6–§7.
    - Stated: the optimizer edits harness configuration. A host-specific copy (the Kiro variant) drops its trial and approval safeguards.
    - Effect: confirms.
    - View: unchanged.

22. **Row: `agent:planner (agents-core)` (disable).**
    - Study: `notes/39` §4; `notes/56` §5.
    - Stated: `/plan` plans inline by default and calls the planner agent only on explicit request.
    - Effect: contradicts the row's phrase "The `/plan` command that uses it" (a factual detail, at the study pin).
    - View: decision unchanged; fix the wording after checking `ef648e0`.

23. **Row: `baseline:workflow (workflow-quality): ECC self-management and miscellaneous` (disable; describes `dev-team` as personas in one session).**
    - Study: `notes/39` §7.
    - Stated: `dev-team` dispatches four parallel subagents that are analysis-only and fed one shared reduced summary.
    - Effect: contradicts "one session/one context" and confirms that it adds no independence.
    - View: unchanged; correct the description.

24. **Row: `capability:orchestration (module orchestration)` (disable).**
    - Study: `notes/05` §4–§5; `notes/34` §5.
    - Stated: a worker is marked completed on exit 0, rollback can remove output, and a later cleanup can delete work that the merge step kept.
    - Effect: confirms.
    - View: unchanged.

25. **Row: `capability:agentic (agentic-patterns): autonomous loop and orchestration skills` (disable).**
    - Study: `notes/45` §1, §3, §6 (`claw.js` is a REPL over repeated `claude -p` calls); `evidence/U18-F-SOURCES.md` row COMPAT (`autonomous-loops`, partly read); `notes/23` §5 and `notes/20` §1, §5 (steps are admitted without waiting for acceptance).
    - Effect: confirms.
    - View: unchanged.

26. **Rows: `capability:ito-compute` and `capability:nasiko-control-plane` (disable).**
    - Study: `notes/43` §1; `notes/44` §1.
    - Effect: confirms both descriptions.
    - View: unchanged.

27. **Row: `baseline:platform (module platform-configs)` (disable).**
    - Study: `notes/37` §1 and §6 (auto-update); `notes/48` §1 (one default server plus optional templates, which are not runtimes); `notes/02` §2.
    - Effect: confirms.
    - View: unchanged.

28. **Row: `locale:tr` (disable).**
    - Study: `notes/56` §5; `notes/54` §2.
    - Stated: the Turkish README makes claims that differ from the main README and from how `/plan` actually behaves.
    - Effect: confirms, and adds that the translation is unreliable.
    - View: unchanged.

29. **Basis of the part E2 rows (the paragraph on how a component installs).**
    - Study: `notes/02` §4.
    - Stated: it confirms the coarse mapping (`skill:tdd-workflow` installs the whole `workflow-quality` module). It also notes per-skill synthetic components, and that target, dependency and adapter checks can narrow what is installed.
    - Effect: "nothing filters by skill" is too broad as a general statement. No decision depends on it.
    - View: optional wording fix.

30. **Scope of EV (85 install components; "components I could not assess: none").**
    - Study: `inventory/U07-A-FAMILY-MAP.md` §2; `CORE.md` §2, §5, §7.2; `notes/01` §2.
    - Stated: ECC also contains a Rust session runtime (`ecc2/`), a native review workflow (`workflows/`) and a Python provider package (`src/`). At the study pin, `workflows/` and `ecc2/` are outside the npm files list.
    - Effect: adds. These parts have no EV row. Inference: rows for them would likely be disable under N-005 and F4, but none was judged.
    - View: the executor decides whether to add rows at `ef648e0` or to state the limit.

## Coverage

- **Read in full:**
  - `INDEX.md`, `00-WHY-THIS-RESEARCH.md`, `STATE.md`, `SOURCE-LEDGER.md`, `CORE.md`
  - `inventory/U07-A-FAMILY-MAP.md`, `inventory/U19-A-OMISSION-REVIEW.md`
  - notes 02, 06, 07, 08, 09, 10, 11, 12, 17, 18, 19, 32, 37, 39, 40, 50, 52, 54, 56
  - `evidence/U11-A-SOURCES.md`
- **Skimmed** (openings, headings or searched rows only):
  - notes 01, 05, 16, 20, 21, 22, 23, 24, 27, 29, 30, 31, 34, 38 (§1–§3), 41, 43, 44, 45, 48, 49, 55
  - rows of `evidence/U06-B-`, `U06-C-`, `U10-B-`, `U14-C-`, `U16-A2-`, `U17-A-`, `U18-A-`, `U18-F-`, `U19-D-`, `U19-E-`, `U19-F-` and `U19-H-SOURCES.md`
  - `ROUND-U11-A.md`, `ROUND-U19-E.md`, the README of the U11-A probe folder under `evidence/`
  - lines of `QUESTIONS.md`, `META.md`, `PLAN.md`
  - A whole-study text search confirmed no mention of `santa`, `gan-`, `loop-design-check`, `loop-operator`, `deep-research`, `operator-approval-loop`, `contract-first`, `safety-guard`, `council`, `verification-loop` or the Pre-Report Gate by name.
- **Not opened:**
  - notes 03, 04, 13, 14, 15, 25, 26, 28, 33, 35, 36, 42, 46, 47, 51, 53
  - `METHOD*.md`, `RESEARCH-LOG.md`, `QUESTIONS-THROUGH-U19-C.md`, all `PUBLICATION-*` files and the other `ROUND-*` files, `RECOVERY-U08-A-20260918.md`
  - in `inventory/`: the structure file, the frontier TSV, and the U01-B and U15-A files
  - the remaining evidence ledgers and all probe scripts and results
- **Limits:**
  - ECC itself was not read at either pin; there was no clone and no web access.
  - The DevOS notes L-088 and L-096 were not read, per the task rule.
  - Study findings describe ECC 2.2.1 at `8321021`, not EV's `ef648e0`.
- **For the decision:** no row decision should change on this study. Five wording corrections are proposed (entries 10, 17, 22, 23, 29), plus adaptation conditions for adopt rows 1, 2, 3 and 4 (entries 2–5) and C05/C06 conditions for three undecided rows (entries 12–14).
- **Guard denials:** none.