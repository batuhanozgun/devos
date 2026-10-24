# U06-A — Configuration protection and enforcement boundaries

**Date:** 2026-09-18. **Unchanged pin:** `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`. **Question:** Q07a. [Source scope](../evidence/U06-A-SOURCES.md), [E05](../evidence/u06-a-config-probe/README.md), [MR09](../ROUND-U06-A.md). Bounded mechanism research, not the deferred joint whole-study evaluation.

## 1. The actual protected object is narrower than the file's name suggests

S123 config-protection.js targets a fixed set of linter/formatter configuration basenames. It is not a universal guard for agent instructions, credentials, MCP configuration, all repository settings or every way of changing a file. Its stated purpose is preventing an agent from weakening checks instead of fixing the source. The predicate, however, examines path name and existence, not the proposed contents or whether a particular edit weakens a rule.

A recognized existing path yields exitCode 2, even for an identical rewrite or a stronger rule. An absent recognized path yields zero. pyproject.toml is deliberately outside the set because it also carries project metadata and legitimate dependency changes. First-time creation and mixed-purpose-file exclusions are explicit trade-offs, not automatically defects. A valid strengthening change can still be refused by this coarse guard. It does not decide whether the original configuration itself is correct.

Case-insensitive basename matching catches an existing case variant. lstat treats a dangling symlink at a protected name as present. Only ENOENT is classified as absence; other stat failures retain the blocking path. These are implemented controls, not just instructions to the model.

## 2. A chain of decisions, not one universal fail-closed property

The traced source chain is:

`PreToolUse Write/Edit/MultiEdit registration → plugin root/bootstrap → run-with-flags → effective profile/disable/dry-run policy → config-protection.run → runner exit → host decision`.

S129 registers this hook for standard/strict profiles with a five-second host timeout. S126's node-mode bootstrap spawns the runner and preserves an ordinary numeric blocking exit, while suppressing raw-input echo to avoid transcript bloat. Resolution errors and abnormal child execution have distinct non-blocking fallback paths. E05 begins at the runner: the inline root resolver, outer bootstrap and live host were not executed.

The retained S122 runner reads bounded input, checks activation before invoking the target, and forwards a normal exitCode 2 with no raw-input stdout. When the input exceeds its size cap, it still invokes an enabled security hook with truncated=true. S123 then refuses without relying on a partially parsed path. In contrast, ordinary malformed JSON becomes an empty object and produces no objection; a truthy non-string path throws in path.basename and the runner catches that exception, returning zero with a diagnostic. Missing scripts and other wrapper fallback paths likewise must not be described as a successful protection decision. No production incidence is inferred from malformed synthetic input.

W14's current host contract distinguishes PreToolUse exit 2 (block) from exit zero/no decision (normal permission flow continues); command-hook timeout also does not itself block. This describes the current documented interface, not a historical installation or measured ECC timeout. Other host policies and other hooks can still deny an operation. Neither zero nor skipping this hook is proof of user authorization.

## 3. Effective configuration is not authenticated authority

S124 resolves activation/profile from explicit ECC environment values, then plugin options, then the managed install's hooks settings, with defaults. Its managed fallback is ECC's ecc/setup.json or an explicitly selected config file; the word managed here must not be equated with an enterprise-enforced host policy. Invalid/missing fallback settings can fall back to enabled/standard behavior. An explicit disabled-hook ID and dry-run are additional selection paths.

E05 confirms that managed minimal skips this guard, while an explicit standard profile overrides managed minimal and invokes the block. The guard suggests temporary disabling for a legitimate configuration change. These are concrete operator controls, but the inspected code does not authenticate who chose the environment value, bind an exception to one approved diff, or prove that protection was restored afterward. A trusted operator can legitimately choose them; a claim about attacker control or enterprise-policy bypass needs an actual threat model and host evidence, neither supplied here.

## 4. E05 — Original runner and guard, synthetic filesystem

Four target modules matched their pinned Git blob identities before and after execution. No target dependency was stubbed. A single local Linux/Node run exercised fifteen predeclared cases. All proposed tool operations remained data: the probe never invoked a Write/Edit tool and did not apply proposed changes.

| Cases | Observed result |
|---|---|
| C00/C03 | Ordinary source path and absent protected file: zero, raw-input passthrough |
| C01/C02 | Existing protected file, unchanged or stronger proposed contents: exit 2 |
| C04/C06 | Protected dangling symlink and ENOTDIR stat failure: exit 2 |
| C05 | Unprotected alias symlink to the same protected file: zero; same realpath and inode recorded |
| C07/C08 | Malformed JSON: zero; non-string path: zero with wrapper run-error diagnostic |
| C09 | Oversized input: exit 2, empty stdout |
| C10–C12 | Minimal profile, explicit hooks-off, dry-run: zero; dry-run emits preview |
| C13/C14 | Managed minimal: zero; explicit standard over managed minimal: exit 2 |

The alias result is deliberately narrow. It shows the guard's basename predicate does not inspect the canonical identity for an unprotected input name. It does not show what a real host Write implementation would do with that alias, whether another gate would block, or that a protected file was modified. The original file remained byte-identical and no proposed files were created. Filesystem race resistance, hard links, case-insensitive platforms and real permission failures were not tested; ENOTDIR is the tested non-ENOENT error.

S127's upstream test source includes protected/ordinary/new-file, truncation, dangling-link, case-variant and legacy-runner controls. It was read fully but not run. A platform-dependent return inside its case-variant test is not evidence that this environment tested case-insensitive behavior. E05 is separate local evidence, not a rerun of E01–E04 or a whole-suite pass.

## 5. Explanation and limits

The immediate cause of the alias contrast is name-based selection before any canonical-target check. The reason malformed and truncated inputs differ is also explicit: truncation is a caller-supplied refusal condition, while parse failure is normalized to an empty object and an unexpected exception is caught by a non-blocking wrapper. These mechanisms explain this bounded result; no unsupported historical account of maintainer motives or universal root cause is needed.

A coarse local guard can reduce accidental rule weakening without being an adversarial filesystem boundary. Conversely, its valuable block does not become universal protection merely because a unit test or a code comment uses fail-closed language. The useful composition question is which input, selector, caller and final effect each control actually governs.

## 6. Disposition and next inquiry

Q07a1 is bounded-answered for this configuration guard's source chain and E05 decision surface. Q07a2 retains live host effect, alternate writer/alias/race behavior, authenticated exceptions, wrapper/bootstrap failures and cross-host coverage. P1 and previous installation/work/memory/learning residuals are not closed by this unit.

Next U06-B examines the distinct fact-forcing gate in gateguard-fact-force.js: what investigation it requests, what evidence/state actually releases a block, and whether a previous check remains bound to the current effect. S128 read only lines 1–240; the full gate and its dependencies must be recovered before a conclusion. Config protection and investigation gates may compose, but their equivalence or safety is not presumed. AgentShield/external scanning and wider security/evaluation remain unexamined here.

The candidate lesson for later SOUL/Development OS discussion is the separation of policy selection, input validity, object identity, justified exception, guard decision and actual enforcement. No Foundation taxonomy, architecture, upstream patch, deployment or adoption follows from this slice.
