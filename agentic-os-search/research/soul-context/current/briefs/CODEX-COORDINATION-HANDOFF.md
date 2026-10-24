> **29 Eylül 2026 — tarihsel Codex koordinasyon mandatı ve devir görevi.** Aşağıdaki sürekli devam, aday dalda yazma ve yeni Codex sohbeti açma hükümleri eski `soul-development-os` denemesine aittir. Eski READY ölçütü bugünkü DevOS'u kabul etmez; mandat yeni kurucuya devredilmez.
>
> Güncel geçiş [D030](../../../../explorations/EXP-006-development-os-calisma-duzeni/DECISIONS.md#d030--claude-code-cloud-kurulum-devri)'dadır: DevOS Claude Code cloud'da kurulacak ve çalışacak; tek plan [devos/plan/](https://github.com/batuhanozgun/devos/tree/main/plan) (devir sürümü 2.1); yeni ürün `soul-system`. Claude Code ve DevOS bu depoyu yalnız okur. Özgün görev aşağıda korunur; yeniden gönderilmez veya uygulanmaz.

---

# Codex Development Coordination Handoff

**Task ID:** DEVOS-COORD-HANDOFF-2026-09-07  
**Status:** prepared for explicit user adoption; not executed by file existence.

## Outcome

Turn the existing `soul-development-os` candidate into a practical **Codex development conversation home** so Batu no longer relays routine technical messages between browser ChatGPT and Codex.

This is a bounded transfer of development coordination, not full autonomous operation, not bridge retirement, not B0/general operating acceptance, and not SOUL product implementation.

At completion, Batu should be able to open a **new Codex chat in the same project/repository/branch** and say, in substance, `Development OS'ye devam et.` The Codex coordinator should then recover purpose/state/authority from the repository, select and organize the next appropriate Development OS work within the standing mandate below, use native helpers when useful, update canonical state, and ask Batu only for decisions that genuinely remain owner decisions.

The intended change is operational responsibility, not merely messaging capability: after a successful handoff, browser ChatGPT should not need to author or approve each ordinary Development OS task. The bounded coordination mandate should remain recoverable across later Codex chats from repository state until Batu changes or revokes it. A new owner decision is still required whenever the work crosses an owner boundary below.

Browser ChatGPT remains SOUL Research: Foundation/studies, research evidence, periodic challenge/audit, and major direction questions. It is not the required author, verifier, or sequencing hub for every normal Development OS step.

## Required starting state

Target repository: `batuhanozgun/soul-development-os`  
Expected local root: `/Users/Batu/Documents/Codex/SOUL-Development-OS-Repo`  
Expected branch: `bootstrap/coordination-entry`  
Expected published starting HEAD: `c1401f4b427886c92363aa553ba9c6a5abc310fb`

Observe the real state; do not substitute expectations for observations. Do not reset/stash/clean away unexplained differences.

Read in full before material design/write work:

1. target `AGENTS.md`, `STATE.md`, `work/COORD-03.md` at the actual candidate state;
2. research `research/soul-context/STATE.md` at the issued research ref;
3. research `research/soul-context/current/DEVELOPMENT-OS-BOOTSTRAP.md`;
4. research `research/soul-context/current/COORDINATION-TRANSFER-PLAN.md`;
5. research `research/soul-context/current/reviews/2026-09-06-direction/OPENING-VISION-SOURCE.md` and its `REVIEW.md`;
6. `research/studies/CATALOG.md` for selective future retrieval guidance.

Do not import research `AGENT.md` / `agent/**` as Codex control instructions. They govern the browser research assistant, not Development OS.

## Coordination mandate to establish

The user-facing Codex coordinator should be authorised, for **Development OS work only**, to do the following without Batu relaying routine technical steps through browser ChatGPT:

- recover current purpose, state, authority and unfinished work from canonical repository records;
- distinguish the user's desired outcome from a proposed method and challenge weak premises;
- choose the next bounded research/design/development/verification work when it is a direct continuation inside the current Development OS purpose and authority;
- decompose that work and make routine technical choices;
- selectively read relevant Foundation/candidate-study sources from `agentic-os-search`; treat research as evidence/input, not automatic architecture requirements;
- use Codex native helper/subagent delegation when it materially helps; receive and evaluate results directly rather than asking Batu to carry messages;
- use a single writer by default and read-only helpers unless a separately bounded writer is actually justified;
- update Development OS canonical state/work records and make normal commits/pushes on the designated private development branch when those effects are part of the authorised Development OS work;
- verify material effects/read back resulting repository state before claiming completion;
- preserve uncertainty, failures, rejected options and handoff state;
- continue through routine bounded Development OS work without requiring browser ChatGPT re-authorisation after every completed subtask;
- stop or escalate when an owner decision is actually required.

This mandate permits reversible candidate design/implementation decisions on the private Development OS branch when they are necessary to the current Development OS purpose and do not cross the owner boundaries below. It does not convert candidate work into accepted architecture, B0, product release, or authority expansion.

### Owner decisions that remain with Batu

Do not infer standing authority for:

- changing SOUL's fundamental product goal or materially expanding scope;
- material budget/risk changes or irreversible/high-impact external effects;
- product/release acceptance or writes to `soul-production` unless separately granted;
- merging/promoting the Development OS candidate to accepted `main`/B0;
- materially changing the coordinator's own authority, acceptance criteria or core control contract;
- adding a new provider or sending private project material to Claude/another provider without separate permission;
- credentials, account/security settings, persistent permission expansion, paid infrastructure or destructive operations.

When one of these is needed, ask Batu for the **decision**, not for routine technical sequencing.

## Design freedom

Do not assume the final topology must be two permanent peer chats. The required capability is a research-aware user-facing coordinator that can directly delegate focused work/review to native Codex actors and integrate their results. If the existing native coordinator + on-demand helper topology is sufficient, prefer it over new orchestration infrastructure.

Do not build a custom launcher, scheduler, agent framework, protocol forest, service or new repository merely to perform this handoff. Do not revive G1-R1. Do not install Claude. Do not implement DESIGN-01 or SOUL product code in this task.

Reuse the existing small surfaces when sufficient. The current `AGENTS.md` already contains useful reasoning/authority/evidence discipline; modify it only where the coordination mandate or user-facing continuation behavior is materially missing. Avoid rewriting working rules for style.

## Required repository result

You may modify only the minimum necessary files in `soul-development-os`. Expected maximum surface:

- `AGENTS.md` — only if needed to encode the ongoing bounded coordinator behavior;
- `STATE.md` — canonical current purpose/authority/entry route;
- one new work record, preferably `work/COORDINATION-HANDOFF.md`, containing the user grant, design decisions, validation, limits and handoff.

Do not rewrite historical work records. Do not change `main`, G0 history or old evidence.

Use the existing `bootstrap/coordination-entry` branch. Normal local commits and normal push to that same private branch are authorised for this task. No force push, PR, merge, issue, tag or branch proliferation.

## Validation before declaring handoff ready

Use the existing native Codex delegation path at least once on a **meaningful handoff review**, not a hello-world test. A helper should inspect the proposed coordinator entry/mandate against the stated goal and identify scope drift, missing owner boundaries or unnecessary machinery. The coordinator must evaluate the returned critique rather than automatically accept it.

This helper review is a challenge/cross-check, not independent operating acceptance. Shared context, tools, model family or assumptions may remain.

Then perform direct static/source checks on the final repository state and push/readback if available.

Do **not** claim that a native helper proves hostile isolation, independent model verification, memory-independent cold start, full self-sustain or general operating acceptance.

The task is successful when all of the following are true:

1. there is one clear canonical entry route for a new Codex conversation;
2. that route tells the coordinator what it owns, what Batu still owns, and where research authority lives;
3. routine Development OS work selection/decomposition/delegation no longer requires browser ChatGPT to author the next prompt;
4. the bounded coordination mandate is persistently recoverable across later Codex chats until explicitly changed/revoked;
5. native helper delegation is usable from the coordinator for focused work/review;
6. current state and handoff are committed and published on the private candidate branch, with remote readback where available;
7. old failed/not-run experiments remain historically accurate;
8. no product implementation, B0/general operating acceptance, new provider, or new orchestration infrastructure is smuggled into the handoff.

If a real platform limitation prevents this exact arrangement, do not start an open-ended workaround project. Preserve the useful repository result, identify the exact limitation, and propose the smallest viable alternative.

## Meaning of READY

A final verdict of **READY** means only:

> the repository and demonstrated native coordination path are sufficient to use Codex as the normal **bounded Development OS conversation/coordination home** under this mandate.

It does **not** mean:

- Development OS is generally validated or accepted as B0;
- the research-side bridge is fully retired;
- hostile isolation/self-modification guarantees are proven;
- unattended continuous autonomy is established;
- SOUL product implementation or release is authorised.

Use **PARTIAL** if useful handoff state is produced but one material condition for using Codex as the normal bounded conversation home remains unmet. Use **BLOCKED** only if the handoff cannot establish a usable bounded Codex coordination home without crossing prohibited scope.

## Final delivery

Return a concise Turkish report containing:

- whether the coordination handoff is **READY**, **PARTIAL**, or **BLOCKED** under the narrow meaning above;
- the final branch and HEAD;
- exact changed files and GitHub links;
- what a new Codex conversation can now do without Batu/browser relay;
- what still requires Batu;
- the native helper review result and coordinator disposition;
- any remaining limitation that materially affects using Codex as the normal Development OS conversation home.

If READY, finish with the exact **one short first message** Batu should send in a new Codex conversation. It should not contain a long bootstrap prompt; the repository should carry the context.

Stop after this handoff. Do not begin the next Development OS or SOUL design task.