# Superpowers — Source Ledger Supplement U04

Observation date: 2026-09-17. Additive continuation of [SOURCE-LEDGER.md](SOURCE-LEDGER.md) (S00–S36/E01–E06) and [SOURCE-LEDGER-U03.md](SOURCE-LEDGER-U03.md) (S37–S43/E07–E08). Earlier identities, full reads and results are preserved. STATE remains work/completion authority.

Target remains `obra/superpowers@b36e0829c6d0140e93cfef2ca599b1b07d4a7797`; manifest context 6.3.0. U04 did not repin or issue a new current-HEAD/installed-version verdict.

## Eleven new full reads

All paths are relative to the pinned [source root](https://github.com/obra/superpowers/tree/b36e0829c6d0140e93cfef2ca599b1b07d4a7797). GitHub returned full bodies without truncation for these files.

| ID | Path | Git blob | Coverage / role |
|---|---|---|---|
| S44 | `skills/test-driven-development/SKILL.md` | `4320d8879a639d0536c2239bb80c9d7257ad8947` | FULL; expected RED, GREEN, refactor, exceptions, test chronology and supporting-reference route. No agent execution. |
| S45 | `skills/verification-before-completion/SKILL.md` | `7d45333cc4a49c57a80df6c1fe2fa777a207afbc` | FULL; claim-specific commands/output, same-message freshness, requirement versus test and delegation checks. No workflow execution. |
| S46 | `skills/receiving-code-review/SKILL.md` | `950da7b74bf6dbed6b8726d12ddadd65a9f5fda7` | FULL; technical validation, clarification, human/external feedback, compatibility, YAGNI and escalation. No real review response performed. |
| S47 | `skills/test-driven-development/writing-good-tests.md` | `d3c4482fd30b4f9084bb61545fe73939a7502c28` | FULL; named break, independently derived expectation, doubles/real effects, trivial-code qualification and mental mutation check. Not an automated mutation engine. |
| S48 | `skills/systematic-debugging/SKILL.md` | `095d194ac041502905f15b01d22d294fb94db8b2` | FULL; reproduce/trace/compare/hypothesize/fix/verify; escalation and environmental handling. Numerical/efficiency claims remain target claims. |
| S49 | `skills/systematic-debugging/root-cause-tracing.md` | `12ef5222e24e19ab92172b82b69ef1b0c30d9bfa` | FULL; backward data/call tracing, instrumentation, helper reference, fallback diagram and historical example. Historical outcomes not reproduced. |
| S50 | `skills/systematic-debugging/defense-in-depth.md` | `e2483354dc2b62478a2624e34ca18bc0efe887b2` | FULL; entry/business/environment checks and diagnostic logging; illustrative code, not a proven sandbox or impossibility result. Not executed. |
| S51 | `skills/systematic-debugging/condition-based-waiting.md` | `70994f777c586f7d4c43033aac34c7cf0da6688b` | FULL; condition polling, timeout, fresh reads, justified timed waits; historical pass-rate/speed claims unvalidated. |
| S52 | `skills/systematic-debugging/condition-based-waiting-example.ts` | `703a06b653160d060bbf46ab5c6e0cd7446bd592` | FULL; Lace-specific event/count/predicate helpers; custom call-ID example. Source-only, no TypeScript build or event test. |
| S53 | `skills/systematic-debugging/find-polluter.sh` | `985f5d08ccf8a3f2d40739cfcaf4413bb24bf1cb` | FULL; exact 1,986-byte helper hash-verified and executed with controlled npm stubs in E09/E10. Sequential target-side-effect search; not binary bisection or general test verification. |
| S54 | `tests/systematic-debugging/test-find-polluter.sh` | `0902e7d9d606a94916a098f92312977397a7860b` | FULL; exact 2,609-byte first-party fixture file hash-verified and actually run: exit 0, five passing assertion lines. It uses stub npm; not real project tests or full repository suite. |

S44–S46/S48 add four SKILL bodies to the previous eight: **12 of the observed 14 SKILL bodies have now been read fully**. This is file coverage only; it does not imply 12 completed independent subsystems or whole-system understanding. `finishing-a-development-branch` and `writing-skills` remain for U05/U06, together with their actual dependencies. Whole-repository runtime/distribution coverage remains incomplete.

## Bounded tree reads

- Debugging tree `ab83fc82f82582e047d96fc516bac9bc03095ee0`, recursive within that subtree: eleven entries. CREATION-LOG and academic/pressure scenario files were listed, not read; defer their evaluation meaning to U06. Six active skill/support/helper files were read here (S48–S53); five historical/evaluation files remain unread. This corrects the initial per-subtree count of seven; the eleven-file S44–S54 register is unchanged.
- Debugging test tree `a3c96b50d5786b1d51d746eaadac058df0b11eef`: one file, S54.

A directory listing is navigation, not content reading or evidence of passing behavior.

## Earlier evidence and current recovery

- Current package STATE, META, PLAN, INDEX and U03 source supplement were re-fetched in U04. Their current status agrees: U01–U03 bounded complete; U04 next; research only.
- METHOD, the original source ledger and U03 mechanism note had already been read in full in this same conversation and their actual contents remain available; they were not replaced by the previous conversational summary. The current package listing confirmed unchanged METHOD and original-ledger blob identities. No new full-file read is claimed for a partial resource-view request.
- U03 S30/S37/S38 task/re-review contracts are compared against S45/S46 using their already fully recovered pinned text. No past experiment is claimed as rerun.
- The new note preserves source observations, interpretation and unresolved live-agent questions separately. A direct public-web open of the pinned verification file failed. A web search returned mirrors/forks rather than the required pinned source; none was used as evidence or silently substituted. Connected GitHub supplied the authoritative target files.
- Agent-control files are not research evidence and were not modified.

## E09/E10 — local diagnostic experiment and selected first-party execution

- E09 runner: [evidence/U04-diagnostic-probes.py](evidence/U04-diagnostic-probes.py).
- E10 actual output: [evidence/U04-diagnostic-probes-results.json](evidence/U04-diagnostic-probes-results.json).
- Expected published/local runner Git blob: `37ca1fe7d2ee6c0390e51f9eb56b281a26138eee`, 8,740 bytes.
- Expected published/local output Git blob: `875f03b27e53b8a6013f2facbace833fd7478cb9`, 7,543 bytes.
- Before execution, transferred S53/S54 bytes matched their canonical Git blobs. The runner independently checks both identities again and copies them into a temporary fixture tree.
- Environment actually observed: Linux, Python 3.13.5, GNU Bash 5.2.37. Isolated HOME, bounded subprocess timeouts and temporary directories; built-in Python/Bash utilities only.
- The first-party test uses its own stub npm. The study cases use a stub whose invocation log and target-file effects are inspected independently of the diagnostic helper's prose. No real npm/project test, dependency install, remote, credential or model call occurred.
- Reproduction: `python3 evidence/U04-diagnostic-probes.py /path/to/pinned/source-root`, with only S53 and S54 required at their listed relative paths.

### Outcomes, not a product score

Selected first-party fixture file: **exit 0; five assertion lines PASS**. This newly executed file is not one of the earlier source-only suites, and does not change their recorded unexecuted status.

Study cases: **seven total; four expected mechanism/scope observations; three failed study-defined claim-scope criteria**.

- Positive controls: missing-argument rejection; both fixture levels invoked without target creation; controlled target creation detected with stop after one invocation.
- Descriptive observation: nonzero simulated test status is suppressed if the target artifact does not appear; this is not a passing-test result.
- Claim-scope challenges: no matches/no execution; preexisting target/all tests skipped; launcher returning 127/no real test execution. Each still reaches the blanket final all-tests-clean wording.

Earlier stdout exposes zero counts and skip messages in the first two challenged cases. The entire output is therefore not claimed to conceal those conditions. A careful consumer could qualify the final wording. The failures concern the declared claim-scope criteria, not a claim that the helper promised a fail-closed API.

Criteria were written after source inspection and before the run. This is source-informed exploratory evidence. It is neither preregistered independent replication nor live-agent evaluation. Temporary fixtures were removed; raw outputs preserve what actually appeared, including ephemeral fixture paths.

## Coverage limits and next retrieval

U04 adds [F28–F35](notes/U04-testing-diagnosis-and-verification.md): test/oracle distinctions, evidence-driven diagnosis, event-target binding, feedback validation, claim-specific verification, fresh/reused evidence composition and diagnostic result scope.

No general TDD superiority, debugging success rate, real model compliance, pressure-test efficacy, end-to-end evidence provenance or security boundary is verified. Historical anecdotes and statistics remain target claims. S50/S52 illustrative code was not executed.

Next: U05 final delivery/retention. U06 retains skill-authoring/pressure/drill evaluation; U07 retains supporting runtime and distribution; U08 retains whole-system synthesis and project-facing projection. Earlier source and experiment volumes remain unchanged.
