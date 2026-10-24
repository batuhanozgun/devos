> **29 Eylül 2026 — tarihsel Codex bootstrap köprüsü; güncel operasyon bağlamı değildir.** Aşağıdaki CURRENT etiketi, depo topolojisi, Stage 0–4, model/ortam tercihleri ve ChatGPT↔Codex sorumlulukları 6 Eylül'deki girişimin kaydıdır. Eski `soul-development-os` ve `soul-production` hedefleri bugünkü çalışma veya ürün otoritesi değildir.
>
> Güncel geçiş [D030](../../../explorations/EXP-006-development-os-calisma-duzeni/DECISIONS.md#d030--claude-code-cloud-kurulum-devri): DevOS Claude Code cloud'da kurulacak ve çalışacak; tek plan [devos/plan/](https://github.com/batuhanozgun/devos/tree/main/plan) (devir sürümü 2.1); yeni ürün `soul-system`. Claude Code ve DevOS bu depoyu yalnız okur. Özgün tarihçe, kaynak ve kanıt sınırları aşağıda aynen korunur; eski fresh-session rotası yeni görev açmaz. Bu bakımın devamı [REPOSITORY-TRANSITION](../../../REPOSITORY-TRANSITION.md)'dadır.

---

# Current SOUL Development OS Bootstrap Bridge

**Status:** CURRENT OPERATIONAL CONTEXT / BOOTSTRAP BRIDGE  
**Date:** 2026-09-06  
**Epistemic status:** user-authorised direction + qualified repository/environment observations + working hypotheses  
**Authority:** context/continuity only; **not Foundation truth, not SOUL architecture authority, not Development OS current-state authority, not agent-control**

> **For the latest bridge checkpoint and next action, read [../STATE.md](../STATE.md) first.** This file preserves purpose, rationale, historical observations and stage conditions. Historical blockers below must not override a later checkpoint in STATE. Prepared Codex assignments live under `briefs/`; a brief existing does not prove that it ran.

## Why this file exists

SOUL Research has entered a long-running arrangement in which research can continue while a new SOUL Development OS is bootstrapped with Codex.

This transition was established in conversation and could be lost across fresh sessions if it remained only in chat history. This file preserves why the new repositories exist, why the previous `soul` repository is not the active development surface, what kind of Codex actor is intended, why ChatGPT is temporarily helping, and what must become true before that bridge can end.

This file is deliberately **not** the canonical work state for `soul-development-os`. Once that repository has its own reliable canonical state/bootstrap surface, its current work must be recovered there rather than copied here.

---

# 1. Repository topology

```text
batuhanozgun/agentic-os-search
    = SOUL Research
    = Foundation + candidate studies + research context

batuhanozgun/soul-development-os
    = the working system used to research/design/build/verify/evolve SOUL
    = intended authority for its own current development state

batuhanozgun/soul-production
    = SOUL product repository
    = intended authority for product artefacts and their acceptance state
```

The previous `batuhanozgun/soul` repository is left intact as **historical predecessor / prior-art / failure and verification evidence**, not cleaned in place and continued as the active surface.

## Authority boundary

Do not create multiple authoritative copies of the same fact.

- Foundation/research finding authority remains in `agentic-os-search`.
- Current Development OS work/state should live canonically in `soul-development-os` once established.
- Product artefacts and their acceptance state belong in `soul-production` under its eventual development/release process.
- Old `soul` is predecessor evidence, not a privileged default.

Cross-repository references preserve provenance. A versioned snapshot/cache can be a derived view, but must not become a competing authority. A product candidate branch/PR, accepted main/release and actual running product behavior are distinct; merely placing a file in a repository named production does not accept or deploy it.

---

# 2. Why a clean development reboot was chosen

The decision is **not** that every idea in the previous SOUL repository is obsolete.

Predecessor principles such as repository-authoritative continuity, bounded authority, producer/self-verification separation, explicit failure states, evidence-before-closure, missing-capability governance and observability remain plausible inputs.

The concern is at another level: the previous Development OS and roadmap were produced before the current Foundation research and later candidate studies. Their decomposition, workflow and role model may encode historical assumptions that should not receive inheritance privilege.

This is a rationale for re-examination, **not causal proof that the previous system failed because of its age or that a restart must be superior**.

The chosen direction is a clean start without historical amnesia:

```text
preserve old repository/history
+
do not inherit its active structure by default
+
reuse mechanisms only when current problem reasoning/evidence justifies them
```

Old SOUL/KEEL structures remain usable as prior art, regression/falsification material and failure history. Their open WPs and phase gates do not automatically become the new repositories' current work.

---

# 3. Research → Development → Product boundary

The intended relationship is:

```text
SOUL Research
finding / evidence / falsifier / open question
        ↓
Development OS
problem framing / work selection / research if needed / candidate design
        ↓
appropriate challenge / verification / decision
        ↓
product candidate change and acceptance/release process
        ↓
observed runtime / evaluation evidence
        └──────────→ research or development re-evaluation
```

This is a responsibility/epistemic relationship, not a universal mandatory workflow for every task.

```text
research finding
!= requirement
!= architecture decision
!= implementation commitment

candidate change != accepted change != realized outcome
```

Candidate studies and Foundation work can inform or challenge decisions. They do not silently mutate development or product state. Separate Foundation research authorization is not changed by the bootstrap work.

---

# 4. What kind of Codex actor is intended

The target is **not a programmer that merely implements instructions**.

The Development Actor should be able to:

- recover canonical purpose/state before material work;
- distinguish the user's goal from a proposed method;
- challenge user framing, another assistant and existing structures when evidence requires it;
- identify decision-critical assumptions and uncertainty;
- decide when additional repository/web research is needed;
- use research inputs without treating them as accepted architecture;
- compare credible alternatives and take derivable technical decisions within authority;
- distinguish capability, authority, Work admission and actual Environment state;
- keep research/design/build/verification/integration distinct when material;
- avoid self-certification;
- preserve evidence, provenance, freshness and uncertainty;
- select or propose the correct next work rather than default every finding to repair/build;
- preserve continuation without permanent hidden human coordination;
- challenge and improve its own working system under governed conditions.

The goal is not identical reasoning or agreement between ChatGPT and Codex. It is effective, challengeable reasoning discipline appropriate to development.

---

# 5. Development OS is larger than Codex

Codex is an important Actor, not the entire Development OS.

A useful research-informed framing is:

```text
Development OS
= Actors + Information + Work + Environment
+ relations / qualification / authority-control / transition mechanisms
```

This is **not** an accepted software decomposition. The grounds must not become four folders, services, classes or databases merely because they are helpful research distinctions.

Likely concerns include actors with different decision rights, source/evidence/current-state surfaces, bounded and continuing work, local/cloud/GitHub capabilities, and the bindings/controls that make those parts work together.

---

# 6. Temporary ChatGPT ↔ Codex bridge

The user authorised this temporary arrangement:

```text
ChatGPT / SOUL Research
    - preserves the research line
    - helps prepare bounded Development OS bootstrap work
    - drafts relay prompts/briefs when useful
    - inspects published Codex outputs through GitHub
    - challenges weak or premature claims

Human owner
    - relays messages during bootstrap when necessary
    - retains vision/value/scope and designated approval decisions
    - should not remain the technical coordinator or verifier

Codex Development Actor
    - researches/designs/builds within the authorised phase
    - progressively owns canonical continuation and work selection
```

This does not establish a direct background communication channel. ChatGPT can inspect accessible GitHub artefacts, but it does not thereby see uncommitted local files or run the user's Mac. Relay reports and direct repository observations must remain distinguishable.

## Exit condition

The bridge can retire when fresh Codex work demonstrates that it can recover and use:

1. purpose and authorised end goal;
2. established, inferred, open and rejected state;
3. current/next work and work-selection discipline;
4. its own authority and non-authority;
5. research need and source/decision boundaries;
6. appropriate design/build/verification/acceptance separation;
7. evidence-based completion rather than producer self-certification;
8. exact state, uncertainty and durable handoff;
9. recovery after interruption or relevant failure;
10. governed revision of the Development OS without silently rewriting its own acceptance rules.

Evidence should include meaningful ordinary work and relevant negative cases, not only a fresh session reciting instructions. File existence is insufficient. Self-sustain does not mean unattended 7/24 execution; scheduling/automatic invocation is a separate capability to justify and verify.

After this transition, ChatGPT returns primarily to research and supplies evidence, falsifiers and direction rather than routine operational prompts.

---

# 7. Environment exploration — dated history, not current capability authority

## Cloud setup

On 2026-09-06 the user created a Codex Cloud environment for `soul-development-os`, referred to during setup as `SOUL Development OS` / `soul-development-os-cloud`.

Screenshots and user reports showed or described:

- `universal` container image;
- automatic setup;
- container caching enabled;
- agent internet access enabled with unrestricted domain access;
- no intentionally configured project secrets/environment variables.

Read-only HTTP methods were recommended during setup, but the final overview did not independently establish that setting. Do not silently treat the recommendation as an observed effective policy.

Cloud setup was followed by a move to desktop/local work because the user wanted to select the visible Astra/Ultra option. The Cloud UI did not expose a model picker in the observed setup; that does not establish a universal product limitation or identify its backend model.

Cloud settings do not configure the local desktop session. Broad domain access with read-only HTTP verbs is not proof against exfiltration or unwanted side effects. Any later network-policy reliance requires the actual settings and threat boundary to be checked.

## Initial desktop preflight — user-relayed Codex report

The desktop project was called `SOUL-Development-OS`. The first tested conversation reported this actual working directory:

`/Users/Batu/Documents/Codex/2026-09-06/bu-oturum-s-f-rdan-kurulacak`

It contained empty `work/` and `outputs/` directories and was not a Git repository. This was a historical binding failure; consult STATE for its subsequent disposition rather than assuming it remains current.

### Reported local tools

- zsh 5.9; Git 2.50.1;
- Python 3.14.2 in the default login shell;
- Node v22.22.3; npm 10.9.8; pnpm 11.19.0; uv 0.11.8;
- Make 3.81; Clang 21.0.0; Swift 6.3.3;
- `gh`, Docker, Go, Cargo/Rust and CMake were not found on the tested PATH;
- Java runtime test failed and `xcodebuild` did not run with the active CommandLineTools directory;
- `login:false` selected Python 3.9.6 and did not expose Node/npm.

These are task/shell-specific reports, not an independent machine inventory.

### Reported information access

- Web-tool reading/search succeeded against official Codex documentation.
- Terminal `curl` to `developers.openai.com` failed DNS resolution in that execution path.
- GitHub connector GET access succeeded to private `agentic-os-search` and `soul-production`.
- Root `AGENT.md`, `agent/` and `research/` were observed without applying the research repo's control instructions to Codex.

Web-tool success does not prove terminal-network success; read access does not prove write/push/PR access. The task did not independently qualify all future information-access needs.

### Reported model and mutation scope

Codex reported runtime metadata with model family `gpt-6-astra` and reasoning effort `ultra`; the exact backend snapshot remained unknown. The research assistant did not inspect those local runtime logs directly.

The task reported `Repository mutations performed: NONE` and `Development OS design started: NO`. A remote inspection alone cannot prove every local no-mutation statement.

## Remote initialization and provenance

Research-side GitHub reads established that `soul-development-os` had `main` at root commit `3776384a7789ccf1959b99bba92c8cf1b3131f81` (`Initialize repository`) and tree `d564d0bc3dd917926892c55e3706cc116d5b165e`, containing only `.gitkeep`.

Thus it was initialized but without substantive Development OS contents, not literally commit-less. Repository metadata `size=0` was not sufficient to determine that no commit existed.

The user later explained that the initial file came from an earlier Cloud task that was cancelled shortly after being submitted. The desktop preflight was a separate episode. This attribution is **user-reported**: the Cloud task log and exact task-to-commit binding were not independently inspected. File existence neither contradicts nor proves the desktop no-mutation report by itself.

This concerns the new `soul-development-os`, not a modification of predecessor `soul`. No deletion, rollback, reinitialization or permission expansion followed from the provenance clarification.

## Subsequent working-copy correction

The user supplied successful ordinary Terminal clone output for:

`/Users/Batu/Documents/Codex/SOUL-Development-OS-Repo`

A separate in-Codex read-only check was then requested to distinguish a clone existing from the active session actually using it. Its latest result and remote-HEAD comparison are preserved in **../STATE.md**, rather than duplicated as a second mutable checkpoint here.

## Model/runtime principle

The current model preference is an environment choice for experimentation, not a permanent architecture dependency. Capability and observed performance matter separately from the model label. Likewise, local model-assisted work does not mean the frontier model's inference is performed on the Mac; local tool/build execution and hosted inference are different concerns.

---

# 8. Bootstrap stages — conditions, not live status

Live stage status is in **../STATE.md**.

## Stage 0 — Environment capability preflight

Read-only establish actual working location, available tools, source access and observable limitations. Distinguish reported observation, inference and unknown. Do not turn setup inspection into product design.

## Stage 0B — Working-copy binding

For repository-based desktop work, check from the default session directory:

- `pwd` and Git root identify the intended working copy;
- sanitized origin identifies `batuhanozgun/soul-development-os`;
- branch, HEAD and working-tree state are known;
- local state is consistent with a directly read remote checkpoint, or any difference is explained.

Do not change directories to conceal a misbound project or re-clone unnecessarily. A successful binding gate supports bounded continuation; it is not blanket environment, write-permission or architecture certification.

## Stage 1 — Bootstrap research/design

Derive the **minimum sufficient working bootstrap**, not a complete Development OS and not a literal copy of predecessor structures.

Consider reasoning/authority, canonical state, selective research access, work selection, evidence/verification, GitHub/Codex mechanisms, session recovery and proportional complexity. Compare real alternatives and identify what is needed now versus deferred.

Prepared assignment: `briefs/CODEX-STAGE-1-BOOTSTRAP-DESIGN.md`.

This assignment uses project research and official platform sources. It does not import `agentic-os-search/AGENT.md` or `agent/**` as Codex instructions or substantive research evidence. Any later proposed control transfer requires a separately bounded decision; the Research R01–R09 set is not a template to copy automatically.

Stage 1 returns a design proposal and finite implementation/validation plan. It does not implement the design or certify its own correctness.

## Stage 2 — Minimum implementation

Once a bounded design is adequately justified and implementation is authorised, establish the minimum canonical structure in `soul-development-os`.

Real write/publication capabilities and appropriate safeguards must be established when needed. Exact filenames, topology, role count and GitHub mechanisms are not pre-decided by this context file. The process must not grow indefinitely merely to prepare for its first meaningful work.

## Stage 3 — Fresh-session validation

Test behavior on meaningful bounded work and relevant failures with a genuinely fresh Codex session. Recover state from the repository, not a long bespoke launch prompt. Declare what the tests do and do not verify.

Failures may call for repair, simplification, reframing or additional evidence; they do not automatically justify another permanent role, gate or document.

## Stage 4 — Bridge retirement

When the agreed self-sustain evidence is sufficient, record the transition and the canonical Development OS entrypoint. Retire routine research-side coordination while retaining research/evidence feedback.

---

# 9. Current next action

**Read [../STATE.md](../STATE.md).** It is the current research-side checkpoint and next-action authority. This section deliberately does not copy a mutable stage number or work item.

Prepared briefs are task specifications, not execution records. Once the target repository has canonical work state, follow its entrypoint for actual development status.

---

# 10. Explicit non-decisions

Discussion has not accepted any of the following:

- `AGENTS.md` plus a protocol router as the final Development OS architecture;
- copying Research R01–R09 unchanged;
- Core / Genesis / Runtime / Evolution as the new SOUL architecture;
- using every GitHub feature from day one;
- one fixed Research → Design → Build → Verify workflow for all work;
- permanent Astra, Cloud or local-runtime dependency;
- the four Foundation grounds as literal software modules;
- migrating old SOUL/KEEL mechanisms without fresh justification;
- self-sustain as unlimited authority or unattended continuous execution.

---

# 11. Update and retirement

Update this context for material changes in cross-project purpose, repository ownership, bootstrap responsibilities, research/development boundaries or the bridge's retirement. Put the live bridge checkpoint in STATE rather than both files.

Do not mirror routine Development OS state here once its own canonical surface exists. Preserve obsolete observations as explicitly dated history, not current instructions.

Fresh-session route:

`AGENT.md → research/INDEX.md → research/soul-context/INDEX.md → STATE.md → current/DEVELOPMENT-OS-BOOTSTRAP.md → prepared brief / target-repository state as needed`

This route should recover why the work exists, which task is current, what is merely proposed and where the next result must be checked without replaying the chat.
