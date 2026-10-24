# gstack — Host Adapters / Portability Fidelity

## Scope

This synthesis reconstructs how the pinned gstack revision adapts one skill system across multiple AI coding hosts, and separates **generated-surface portability** from **behavioral/runtime equivalence**.

Pinned target:

`garrytan/gstack@0d1bd5616c0ef096bb7ccee336f63c60ee408618`

The question is not merely whether a host appears in a support list. It is:

> which gstack contracts survive a host change, which are rewritten, suppressed or weakened, which require host-specific runtime installation, and what evidence exists that the rendered behavior actually works on that host?

This is a gstack-native subsystem synthesis. It does not yet project findings onto the SOUL Foundation four-ground frame.

---

## 1. Executive reconstruction

The portability system has four materially different layers:

```text
canonical skill / resolver sources
        ↓
typed host configuration
        ↓
host-specific compilation / generation
        ↓
installation + runtime assets + actual host capabilities
        ↓
behavioral execution on that host
```

The strongest result is:

> **gstack has a serious portability compiler, but portability is not one binary property.**

At the pinned revision, gstack is strong at producing structurally coherent host-specific skill surfaces. It does not establish semantic equivalence across all registered hosts.

A more faithful model is:

```text
source contract
  ├─ preserved
  ├─ rewritten
  ├─ suppressed
  ├─ compiled into another artifact shape
  ├─ weakened to advisory prose
  └─ unsupported / known-gap
```

The host adapter therefore acts partly as a compiler and partly as a capability negotiation layer, but the latter remains incomplete.

---

## 2. Host registry: ten registered hosts, not ten identical execution environments

`hosts/index.ts` registers ten host configs:

```text
claude
codex
factory
kiro
opencode
slate
cursor
openclaw
hermes
gbrain
```

The registry is typed and drives large parts of generation/tooling.

However, `setup` reveals that registry membership is not equivalent to first-class installation/runtime support.

### 2.1 Operational support tiers at the pinned revision

#### Tier A — first-class setup install arms

The setup script has actual install flags/branches for:

```text
Claude
Codex
Kiro
Factory
OpenCode
Cursor
```

These hosts receive generated skills plus host-specific runtime-root/sidecar installation behavior.

#### Tier B — registered but not first-class setup target

Slate has a host config and generated output, but setup explicitly says:

```text
Slate is not yet a first-class install target
```

and directs users to Claude compatibility behavior.

#### Tier C — methodology / instruction-tier integrations

OpenClaw and Hermes are intentionally different integrations. Setup exits through informational arms rather than performing the full skill install. It describes them as runtimes that spawn Claude Code sessions and exposes methodology artifacts / an instruction-only `AGENTS.md` digest.

#### Tier D — external mod integration

GBrain has a host render, but setup states that GBrain setup and brain skills ship from the separate GBrain repository. In gstack it is a brain-aware variant/mod surface rather than a self-contained first-class install path.

### 2.2 Correction to a flat “supported hosts” reading

The repository documentation calls all ten “supported hosts.” That is useful as a product-level catalog, but technically it spans different maturity/capability classes.

Therefore:

```text
registered host
≠ generated host surface
≠ installable host
≠ runtime-capable host
≠ behaviorally validated host
```

Any portability claim must name which level it means.

---

## 3. Declarative HostConfig architecture

The host abstraction is substantially more than a path table.

`HostConfig` carries:

```text
identity / CLI detection
model-generation default

global + local skill roots
host subdirectory
path mode

frontmatter transformation
metadata generation
skill include / skip policy

literal path rewrites
tool-name rewrites
resolver suppression

runtime-root assets
installation strategy
instruction-only fallback tier

co-author identity
learnings mode
cross-model boundary instruction
```

The shared `defineHost()` factory provides external-host defaults and minimizes copy/paste at the TypeScript config layer.

This is a real architectural strength: many host differences are declared as data and can be validated centrally.

### 3.1 Shared semantic switches

The factory exposes explicit reusable classes of differences:

- `CROSS_MODEL_RESOLVERS` — sections that invoke Codex or Review Army and therefore should disappear on hosts where that behavior is invalid or nonsensical;
- `GBRAIN_RESOLVERS` — brain-aware blocks normally suppressed except where capability is present;
- `EXEC_STYLE_TOOL_REWRITES` — mappings such as Claude's Bash/Read/Write/Agent wording to OpenClaw-style `exec`, `read`, `write`, `sessions_spawn`.

That means host adaptation is not merely cosmetic; it can remove whole behavior blocks and alter invocation primitives.

---

## 4. Host and model are independent dimensions

`scripts/models.ts` explicitly states:

```text
host ≠ model
```

This matters because model behavior is another source of portability variation.

Examples:

- Codex host defaults to the generic `gpt` overlay but setup may detect a more specific configured model;
- `gpt-5.6-sol` is exact-match only rather than a generic GPT-5.6 family inheritance;
- Cursor/OpenCode can front multiple providers;
- Claude host can run different Claude-family models.

The generation model is therefore:

```text
host adapter
×
model behavioral overlay
```

not one combined “agent type.”

This prevents a major conceptual error: a behavior that is correct on the Codex host under one model profile is not automatically a property of the host itself.

---

## 5. Generator as portability compiler

`scripts/gen-skill-docs.ts` is the central compiler-like layer.

For an external host it approximately performs:

```text
SKILL.md.tmpl / section source
        ↓
resolve host-aware placeholders
        ↓
remove suppressed resolvers
        ↓
transform frontmatter
        ↓
convert hook semantics to safety prose where necessary
        ↓
rewrite paths / tool names
        ↓
apply model overlay
        ↓
optionally emit host metadata
        ↓
generated host-specific SKILL.md
```

Unresolved placeholders fail generation rather than leaking silently.

`--host all` also fails the build if any host generation fails. This is useful structural containment: a newly broken external render cannot remain silently green simply because Claude generated successfully.

### 5.1 Host-specific artifact topology

Claude and external hosts do not even receive identical file topology.

For carved skills, Claude keeps on-demand `sections/*.md` files. External hosts inline those sections into a monolithic generated skill instead of emitting section files.

This is intentional: it avoids requiring host-portable section-read plumbing.

So portability may preserve content while changing its loading/exposure model:

```text
Claude:
small skeleton → explicit section read

external host:
monolithic inlined skill
```

That can change context cost and runtime interaction even when the logical instructions are similar.

---

## 6. Representative host adaptations

### 6.1 Claude — primary semantic host

Claude is the reference execution environment:

- fuller frontmatter survives;
- lifecycle and safety hooks are meaningful runtime mechanisms;
- literal Claude paths are used;
- real-directory skill installation is supported;
- learnings mode is full.

Many gstack contracts originate here and are later translated outward.

### 6.2 Codex — strongest external-host adaptation, but not parity

Codex gets substantial specialized treatment:

- default model family `gpt`;
- minimal frontmatter;
- generated `agents/openai.yaml` metadata;
- `$GSTACK_ROOT`-based paths and `.agents/skills` layout;
- `CLAUDE.md → AGENTS.md` rewrite;
- Codex-wrapper skill excluded;
- cross-model resolvers suppressed so Codex does not call itself as its own “outside voice”;
- GBrain blocks suppressed by default;
- anti-prompt-injection boundary instruction for cross-model execution.

Codex also has a dedicated session runner and real CLI E2Es, unlike most other external hosts.

But a known counterexample proves that this is not semantic parity: the Codex-host ship render can still contain Step-18 Agent-tool dispatch instructions that Codex cannot perform (`Agent`, `run_in_background`). The repository has a TODO to audit all such non-Claude dispatch sites and choose per host between native delegation, inline execution or suppression.

Thus even the best-supported external host has unresolved semantic leakage.

### 6.3 Factory — declarative safety metadata + prose/tool translation

Factory adds:

- `user-invocable: true`;
- `disable-model-invocation: true` for sensitive skills;
- tool-language rewrites such as `use the Bash tool → run this command` and `use the Agent tool → dispatch a subagent`;
- full learnings mode.

Static tests verify generated structure and sensitive-skill metadata.

But generic prose such as “dispatch a subagent” does not by itself prove that the exact orchestration/liveness/authority semantics of Claude's Agent tool are reproduced.

### 6.4 OpenCode — wider runtime asset profile

OpenCode expands the shared external runtime-root assets to include design tooling, review specialists, QA templates/references and DevEx reference material.

This is evidence that runtime portability is not just instruction translation: each host needs the files/binaries its generated instructions will later dereference.

### 6.5 Cursor and Kiro — generated/install surfaces, weaker semantic evidence

Cursor and Kiro have first-class setup installation branches and path adaptations.

Cursor additionally uses IDE-footprint detection (`~/.cursor`) because a CLI binary may not be present.

However, targeted searches did not identify a dedicated production-behavior session runner/E2E comparable to the Codex harness for these hosts. Their strongest inspected evidence is generation/setup/static correctness.

### 6.6 OpenClaw / Hermes — translation through delegation architecture

OpenClaw and Hermes are not treated as “Claude with renamed directories.”

Their tool vocabulary is rewritten toward native primitives (`sessions_spawn`, `delegate_task`, terminal/read/patch tools), cross-model sections are suppressed, and setup exposes methodology/instruction-tier integration rather than the same full install.

This is arguably more honest than pretending parity, but it means “supports gstack” represents a different product contract.

### 6.7 GBrain — capability-specialized host

GBrain keeps brain-aware resolvers while suppressing cross-model resolvers. It therefore demonstrates that host adaptation can *add/preserve specialized capabilities*, not only degrade Claude features.

---

## 7. Safety control strength is host-relative

The guarded-action synthesis already established the clearest portability counterexample.

On Claude:

```text
/careful
/freeze
/guard
→ real PreToolUse hooks
→ deterministic interception of selected tool calls
```

For external generated hosts, hook frontmatter is removed and the generator inserts an inline **Safety Advisory** explaining that the agent should pause and verify.

Therefore:

```text
runtime enforcement
≠ behavioral instruction
```

The external skill can preserve safety *intent* without preserving safety *control strength*.

This is not merely wording drift. It changes where correctness lives:

```text
Claude: platform hook + script behavior
External: model compliance with generated prose
```

Any security or authority standing derived from the skill must therefore include the host capability surface.

---

## 8. Setup is only partially config-driven

This is the strongest source-fidelity correction in the subsystem.

`docs/ADDING_A_HOST.md` states that the generator, setup, platform detection, uninstall, health, worktree copy and tests all read from configs, and says adding a host requires zero generator/setup/tooling code changes.

That is not true for the pinned implementation.

`scripts/host-config-export.ts` explicitly says:

```text
NOT yet wired into ./setup
setup still hand-rolls its host lists
known drift source
```

The actual `setup` script confirms this with explicit per-host install flags and near-duplicated functions such as:

```text
create_codex_runtime_root
create_factory_runtime_root
create_opencode_runtime_root
create_cursor_runtime_root

link_codex_skill_dirs
... corresponding host variants
```

`TODOS.md` records this as known debt: four near-verbatim runtime-root/link function families can drift independently, and the #2142 ownership fix had to be patched at every site.

### 8.1 Source/view conclusion

For the pinned revision:

```text
docs/ADDING_A_HOST.md
= aspirational / stale derived view on this point

host-config-export.ts + setup + TODO
= current implementation truth
```

This is a concrete repository self-description drift, not merely an interpretive disagreement.

---

## 9. Runtime assets are part of portability

Setup builds host-specific runtime roots/sidecars, not just skill text.

Examples include selective installation of:

```text
bin + lib
browse binaries
review checklists
review specialists
QA templates/references
design binary
ETHOS.md
office-hours rendered skill
upgrade assets
```

The exact set differs by host.

This means a valid generated path is not enough. A host can render correctly and still fail later if a referenced runtime asset is absent or stale.

The setup code contains historical fixes precisely for this class — e.g. bin scripts needing `../lib`, skill runtime assets not being installed, or sidecar layouts causing duplicate discovery.

Portability therefore has at least three coupled artifacts:

```text
instruction surface
runtime dependency surface
installation topology
```

---

## 10. Generated-surface health is not runtime portability health

`scripts/skill-check.ts` checks external hosts for things such as:

- generated skill presence;
- `.claude/skills` leakage;
- generation freshness.

`test/gen-skill-docs.test.ts` adds extensive structural/golden checks:

- YAML validity;
- frontmatter shape;
- path rewrite correctness;
- resolver suppression;
- sensitive metadata;
- model overlay selection;
- all-host render determinism.

These are valuable and catch a large class of packaging/compiler regressions.

But they prove mainly:

```text
generated artifact is internally coherent
```

not:

```text
host runtime executes the intended workflow with equivalent semantics
```

A host such as Slate can have a valid/fresh generated tree while setup itself says it is not first-class.

Therefore a green host-generation dashboard cannot be interpreted as a green portability dashboard.

---

## 11. Behavioral verification coverage is asymmetric

### 11.1 Claude

Claude is the primary host and dominates the real skill E2E infrastructure.

### 11.2 Codex

Codex has dedicated real-CLI E2Es and a hermetic session runner. This is materially stronger evidence than static generation tests.

However, a serious verification-validity defect exists in periodic CI: `TODOS.md` records that the periodic Codex shards run in an image without the Codex CLI, so the shards can skip everything and report green.

That means the *existence of a Codex E2E file and CI matrix entry does not establish that the test actually executed*.

The repository itself names this correctly:

```text
A green all-skip shard reads as coverage that does not exist.
```

### 11.3 Other hosts

Targeted searches for Factory/Droid, Kiro, OpenCode and Cursor found setup/generation/static tests but did not find a dedicated real-host behavioral runner comparable to Codex's.

OpenClaw/Hermes are intentionally different integration tiers, and Slate documentation even describes a future session-runner design.

This is a bounded negative result: absence was established through targeted repository search, not an exhaustive proof that no external/custom test exists anywhere outside the repository.

### 11.4 Evidence ladder

A useful host-specific confidence ladder is therefore:

```text
config validates
< generated output parses
< paths/assets are structurally pinned
< setup installs coherent runtime
< actual host loads skill
< actual host completes workflow
< failure/recovery semantics exercised
< external independent validation
```

The ten hosts occupy different points on this ladder.

---

## 12. Known semantic leakage: subagent dispatch

Multi-agent research supplies a direct portability falsifier.

Claude-specific dispatch semantics include:

```text
Agent tool
subagent_type
run_in_background:false
fresh-context behavior
foreground completion result
```

Literal tool-name rewriting cannot automatically preserve this interface.

The pinned TODO explicitly calls for an audit of every subagent-dispatch site on non-Claude hosts and a per-host decision:

```text
rewrite to native delegation
OR inline execute
OR skip
```

That is the right abstraction: **capability adaptation**, not textual substitution.

The unresolved state shows that the current compiler still has places where syntax adaptation outruns semantic adaptation.

---

## 13. Portability failure classes

The inspected system exposes several distinct failure classes.

### P1 — path leakage

Generated host instruction references a Claude-specific location.

Strong static coverage exists for this class.

### P2 — frontmatter/schema incompatibility

Host rejects unsupported metadata or invalid YAML.

Strong structural coverage exists, especially for Codex and Factory.

### P3 — missing runtime asset

Instruction references a file/binary not installed into host runtime root.

Setup contains many historical fixes and structural pins for this class.

### P4 — unsupported tool primitive

Generated prose references a tool/argument unavailable on the host.

The Codex Step-18 Agent dispatch is a concrete current example.

### P5 — control-strength downgrade

A deterministic hook becomes advisory prose.

`careful/freeze/guard` on external hosts are the clearest current example.

### P6 — resolver/capability mismatch

A section that requires an unavailable outside model, memory engine or delegation primitive is rendered anyway, or a valid feature is suppressed unnecessarily.

The suppression system mitigates this but depends on accurate host capability declarations/detection.

### P7 — install-registry drift

Host exists in typed registry but setup's hand-coded list/arm does not implement it.

Slate's historical silent-noop class and current informational-only status demonstrate this risk.

### P8 — false-green validation

Tests/config generation are green but the actual runtime path was skipped or never executed.

Codex periodic all-skip CI is a concrete example.

### P9 — model/host conflation

Host-level behavior is inferred without accounting for the selected model overlay.

The explicit host/model split prevents this conceptually, but consumers must preserve the distinction.

---

## 14. What gstack does well

### 14.1 It has a genuine compiler boundary

One canonical template/resolver source can generate multiple host surfaces with explicit transforms rather than duplicated hand-maintained prompt packs.

### 14.2 Differences are often explicit

Resolver suppression, tool rewrites, model overlays, frontmatter rules and runtime asset sets make many capability differences visible in code.

### 14.3 It prefers suppression over fake diversity in some important places

Codex self-invocation blocks are removed under Codex. OpenClaw/Hermes suppress cross-model orchestration rather than automatically claiming equivalence.

### 14.4 It has structural drift tripwires

All-host generation, strict YAML parsing, path leakage checks, config validation and golden fixtures catch substantial portability regressions cheaply.

### 14.5 Setup recognizes ownership and stale-install hazards

The installer includes protections against wiping user-owned host skill directories, duplicate discovery and stale Windows copies. These are operational portability problems, not merely prompt concerns.

---

## 15. What remains weak or incomplete

### 15.1 End-to-end declarative host configuration is unfinished

The TypeScript host registry is ahead of setup. Setup remains a second, partially duplicated host model.

### 15.2 Capability semantics are under-modeled

`HostConfig` can express rewrites and suppression, but it does not yet fully encode a capability matrix such as:

```text
supports deterministic PreToolUse hooks?
supports blocking human question tool?
supports foreground child dispatch?
supports worktree isolation?
supports native subagent result contract?
supports runtime metadata field X?
```

As a result, some adaptations still rely on literal-string rewriting or manually curated resolver suppression.

### 15.3 Behavioral host coverage is sparse outside Claude/Codex

Static/generation tests are much stronger than real-host workflow execution evidence.

### 15.4 Even Codex behavioral coverage can become false-green

The periodic all-skip issue demonstrates that a test lane needs proof-of-execution, not merely a green job status.

### 15.5 Documentation overstates current declarative maturity

`ADDING_A_HOST.md` currently describes the intended architecture as if setup had already reached it.

---

## 16. System-level synthesis

Portability in gstack is best modeled as a **qualified translation**:

```text
canonical workflow intent
        ↓
host capability profile
        ↓
translation decision
   ├─ preserve
   ├─ rewrite
   ├─ suppress
   ├─ inline
   ├─ replace with native primitive
   ├─ weaken to advisory
   └─ declare unsupported
        ↓
installation/runtime materialization
        ↓
actual host execution
        ↓
host-specific verification evidence
```

The current implementation is strongest through the translation/materialization stages and weaker at systematic capability typing and behavioral equivalence testing.

### 16.1 The core correction

Do not ask only:

> “Does gstack support host X?”

Ask:

> “Which gstack contracts have what standing on host X, under which model, runtime assets and host capabilities, with what level of behavioral verification?”

This is the portability fidelity question.

---

## 17. Cross-subsystem implications

### 17.1 Authority is host-relative

A safety rule enforced by a Claude hook but expressed as prose on another host does not have the same authority/effect power.

### 17.2 Isolation is host-relative

The existence of a host-native delegation word (`sessions_spawn`, `delegate_task`) does not establish the same fresh-context/worktree/result/liveness semantics as Claude's Agent call.

### 17.3 Verification standing is host-relative

A workflow can be behaviorally verified on Claude, structurally rendered for Factory, and merely registered for Slate. One global “tested” label destroys this distinction.

### 17.4 Source→view fidelity includes compilation target

A generated host skill is a derived view of the canonical template/resolver system. Load-bearing conclusions about its behavior sometimes require descending through:

```text
host-generated SKILL
→ HostConfig
→ resolver/template source
→ setup/runtime assets
→ actual host capability
```

### 17.5 Portability itself is a qualification problem

The recurring system pattern strengthens:

```text
host present
→ NOT ENOUGH

generated output valid
→ NOT ENOUGH

installed runtime coherent
→ stronger

behavior exercised on actual host
→ stronger

failure semantics exercised
→ stronger still
```

---

## 18. Evidence / verification limits

This synthesis does **not** claim:

- that every non-Claude host is broken;
- that structurally translated skills cannot work without dedicated E2Es;
- that OpenClaw/Hermes instruction-tier integrations are inferior — they are different contracts;
- that the Codex all-skip issue invalidates local Codex E2E evidence;
- that targeted search proves no external-host behavior testing exists outside the repository;
- that host/model profiles are stable beyond the pinned revision.

No independent third-party portability validation was established.

---

## 19. Bounded conclusion

**Status: BOUNDED subsystem synthesis.**

The inspected evidence is sufficient for the current native gstack model.

Protected conclusion:

> gstack has evolved a meaningful typed host-adaptation and generation architecture, but “support” is multi-level. The pinned system reliably expresses many syntax, path, metadata, resolver and runtime-asset differences; it does not establish uniform behavioral equivalence across its ten registered hosts. Some Claude controls degrade into advisory prose, some multi-agent semantics leak into hosts that cannot execute them, setup remains partly hand-coded despite a declarative registry, and behavioral E2E evidence is heavily concentrated in Claude/Codex—with even Codex periodic CI carrying a known all-skip false-green. Therefore portability standing must be qualified per host, model, capability, installation topology and verification evidence rather than inferred from registry membership or a successful generated build.

The next native subsystem can move to production/deploy/canary/retrospective feedback without reopening host portability unless a later finding materially contradicts this model.
