# DevOS installation ledger

**Status:** Authoritative progress record of the installation until the ledger is transferred to the database at the end of C02 (plan Section 9, introduction). After that transfer this file stops being a write surface.

**Rules for this file**

1. `devos` is a public repository. This file holds only safe summaries and identifiers: no text from the research library, no conversation transcripts, no key or token values (plan Sections 0.5 and 6.7; K6, K8). The one exception is Batu's own decisions, constraints and expectations. These are recorded word for word as plan Section 0.6, item 2 requires, after a check that they carry no private content.
2. Until the translation fidelity review of the plan package passes, the Turkish plan package is the binding text, and the references below point to it (plan Section 0.6).
3. A stage's acceptance conditions are written down before its results are seen and are never loosened afterwards. If a condition must be loosened, the earlier result is void and the test is repeated under the new condition (plan Section 9, "Her aşamanın kapanışı"; Sections 8.6 and 14).
4. Batu's words are recorded with the original Turkish text and an English interpretation (plan Section 0.6, item 2).
5. Every statement about access or permissions names the layer that enforces it (GitHub permission, session or proxy, database, instruction only). It also gives the verification status: observed, documented only, or not verified (FND-001).

**Identifiers:** `L-nnn` log entry · `FND-nnn` finding · `OI-nnn` open item · `G-nnn` gap candidate for C00 step 2 · `EV-Cxx-nnn` evidence record under `evidence/Cxx/`.

---

## 1. Current state

| Item | State | As of |
|---|---|---|
| Stage | C00 in progress. Done: reading (L-001); preparation verification (L-006, L-009, L-010; acceptance condition 2 met); first gap list and premise inventory (L-008). **Paused until 2026-10-03 17:00Z** under D-001 (blocker B-001, L-010); resume scheduled for 17:15Z. Remaining: translation and its review, the ECC comparison, the independent review, the counter-design, step 7. | 2026-10-01T18:00Z |
| Binding plan text | Turkish plan package at `devos` commit `6186e5d`, plus the recorded change K10 (L-004) | 2026-10-01 |
| Working rhythm | Each stage runs under a `/goal` target (K10, L-004). The C00 goal condition is in L-004; it has not been started yet. | 2026-10-01 |
| Builder's access to `agentic-os-search` | **Not known to be read-only.** On GitHub, the machine account has write (push) permission (observed). At session level, whether `access: "read"` blocks writes is not verified (OI-001). The repository is therefore treated as writable by this session. The only thing keeping it read-only is a plan rule (plan Section 0.5) that only the builder's compliance enforces. Details: L-003, EV-C00-001. | 2026-10-01T16:10Z |

---

## 2. Acceptance conditions

### C00

Translated verbatim from plan Section 9, C00, "Kabul". The conditions were fixed in plan 2.1 (29 September 2026), and the Turkish text is binding. This copy was entered on 2026-10-01, after the observations in L-002 and L-003, which bear on conditions 4 and 5. Those observations did not change the conditions.

Legend, as in the plan (Section 8.2): ✔ marks a condition that must be shown; ✘ marks something that must not happen. Neither mark is a result.

- ✔ The translation fidelity review has passed; changes proposed during translation are recorded separately.
- ✔ Every item of the preparation list is verified with evidence.
- ✔ The ECC table, the independent review, the counter-design comparison and the premise inventory are recorded; the disposition of every finding is written.
- ✘ The builder wrote nothing to the library repositories.
- ✘ No secret is visible in a repository, an environment variable or the chat.

Criteria served by C00 (plan): 18, 21, 25–27, 29, 34.

---

## 3. Log

### L-001 · 2026-10-01 · Plan package read

The builder read the following completely, from beginning to end, all at `devos` commit `6186e5d`: `DevOS_Kurulum_Plani.md`, `Ek_A` through `Ek_G`, `Uyandirma_ve_Kapasite_Arastirmasi.md`, `Calisma_Duzeni_Karsilastirmali_Arastirma.md`, `Inceleme_Degerlendirmesi_Claude.md` and `Inceleme_Degerlendirmesi_ChatGPT.md`. No file was changed before reading was complete.

### L-002 · 2026-10-01 · Library repository attached to the session

- At session start only `devos` was attached. `agentic-os-search` was not, although Appendix F tells Batu to select both.
- The builder attached `batuhanozgun/agentic-os-search` with the session tool `add_repo`, passing `access: "read"`. **This was a change to the session's configuration, not a read.** According to the tool's result, it put the library inside the session's GitHub scope, which is the set of repositories where session writes are allowed. No tool for detaching a repository is available in this session. The builder needs to read the library during C00–C04 in any case (plan Section 0.5).
- The builder made a shallow local clone (library commit `dc91f6b`, 2,392 files).
- The builder deliberately did not call `register_repo_root`. According to the `add_repo` result, that call would load the repository's `CLAUDE.md`, skills and plugins into the session. The builder skipped it because the library is a source of information, not of instructions (plan Section 0.5). That this avoids the loading path is documented only, not observed. The clone has no `CLAUDE.md` and no `.claude/` directory at its top level; deeper levels were not checked.
- By the builder's own record of its actions, it issued no write operation to the library repository. The remote state was not checked afterwards.

### L-003 · 2026-10-01 · Correction: the library's "read-only" access is not a verified technical boundary

**Trigger.** Batu's question after the builder's first message:

> Original (tr): "agentic-os-search'ü "yalnız okuma izniyle" eklediğini yazdın. Bunu nasıl ekledin? Okuma sınırı teknik olarak mı uygulanıyor, yoksa senin kuralın mı? GitHub'da makine hesabının bu depoda yazma izni olduğunu planın 0.5. bölümünde bulabilirsin. Doğru durumu kurulum defterine yaz."
>
> Interpretation (en): The builder said it had added `agentic-os-search` "with read-only permission". Batu asks how it was added and whether the read limit is technically enforced or only the builder's rule. He points out that plan Section 0.5 states the machine account has write permission on that repository on GitHub, and he instructs the builder to record the correct state in the installation ledger.

**What the builder had said.** In its first message to Batu, the builder wrote that it had added `agentic-os-search` with read-only permission (Batu quotes the Turkish phrase above). That wording presented a request parameter as an enforced permission, which was wrong. The correct state is below.

**Correct state** (evidence: EV-C00-001):

| Layer | What holds | Verification status |
|---|---|---|
| GitHub identity of this session's GitHub tools | `batuhanozgun-devos` (the machine account, B3 = (a)) | Observed (EV-C00-001, row 4) |
| GitHub permission of that identity on `agentic-os-search` | `pull: true`, `triage: true`, **`push: true`**, `maintain: false`, `admin: false` | Observed (EV-C00-001, row 5) |
| Credential behind the session's git proxy | Unknown. It could be the machine account's or the Claude GitHub App installation's. This matters for safeguard 3: removing the machine account as a collaborator closes the session's git path only if the session uses the machine account's credential. The plan treats a related point as an assumption awaiting C01 row 12 (plan Section 13, risk row for `devos-evals` and `devos-backup`). | Not verified (OI-005) |
| Session attachment (`add_repo`, `access: "read"`) | The tool description says `read` = "fetch/clone only", and `push` is for a session that must "push commits, open PRs, or use GitHub API tools against the repository", which is "attached with credentials after the full repository-access checks". This suggests that a read attachment carries no write credentials. The tool's result says writes remain limited to repositories attached to the session, and this repository is now attached. The two texts point in different directions. | Documented only; enforcement not observed (OI-001) |
| Git push through the session proxy | Not tested. The builder tried to run a preparatory command (list the library's `.github/` directory and snapshot its remote refs) before a no-write `git push --dry-run` probe. The session's automatic permission classifier denied the command (reason label "Untrusted Code Integration"). The builder did not pursue the probe by any other route. | Denial observed; push behaviour not observed (OI-001) |
| Session automatic permission classifier | Observed denying one command that touched the library's remote. Whether it blocks writes was not tested. | Observed denial only |
| GitHub tools (`mcp__github__*`) that write files, branches or pull requests | Unknown. The identity has push permission (observed). The `add_repo` description ties GitHub API use against a repository to `push` mode (documented only). Not tested, because a write test is ruled out (plan Section 0.5; C00 condition 4). | Not verified (OI-001) |
| Environment variables named `GH_TOKEN` and `GITHUB_TOKEN` | Present. Their values were not read, and their scope and function are unknown. | Names observed only (OI-003) |
| Plan rule: the builder only reads the library | Plan Section 0.5 (single-writer rule, a Batu decision; safeguard 1, "the builder's instruction") and Appendix F. It is not a technical control. It is the only safeguard known to be in force today. | Its existence is documented; whether it works is not verified |

**Conclusion.** For this session, "read-only" on `agentic-os-search` is a rule of the plan that only the builder's compliance enforces. No technical boundary has been observed. On GitHub, the machine account has write permission, as plan Section 0.5 states and the GitHub API confirms. Plan Section 0.5 names two further safeguards:

- **Safeguard 2:** a monitoring path, independent of DevOS, that reports every machine-account commit in `agentic-os-search` to Batu. The plan builds this path later (G-001), so it is probably absent today.
- **Safeguard 3:** removing the machine account's access in C04, after the library has been imported into Supabase and verified. This is still in the future.

**No write by the builder.** The builder made no commit, push, branch, pull request, issue or comment in `agentic-os-search`. Apart from `add_repo`, every operation in L-002 and L-003 only read data or ran locally. `add_repo` changed the session's GitHub scope; it did not write to the repository. The basis for this paragraph is the builder's own record (same session); it has not been verified independently.

### L-004 · 2026-10-01 · Plan change K10: each installation stage runs under a `/goal` target

**Batu's instruction:**

> Original (tr): "Planda kurulum dönemi için bir çalışma ritmi tanımlı değil. Her aşama bir /goal hedefiyle yürütülsün. Duruş koşulları şunlar: aşama bitti, Batu'nun bir kararı ya da işlemi gerekiyor, ya da senin aşamayacağın bir engel var. Bu kuralı kayıtlı bir plan değişikliği olarak planın kurulum bölümüne ve Ek F'ye ekle ve deftere yaz."
>
> Interpretation (en): The plan defines no working rhythm for the installation period. Each stage is to run under a `/goal` target, with three stop conditions: the stage is complete; a decision or action by Batu is needed; or the builder has hit a blocker it cannot pass. Add this rule as a recorded plan change to the installation section of the plan and to Appendix F, and record it in the ledger.

**Plan change record (plan Section 14):**

| Field | Content |
|---|---|
| Decision | K10, Batu's decision, 2026-10-01 |
| Old state | Plan 2.1 defined no working rhythm for the installation period. Section 9 defined stage order, acceptance and closure, but not when the builder works on and when it stops and returns to Batu. |
| New state | Plan Section 9, introduction: the "Kurulum çalışma ritmi" paragraph, with the three stop conditions, how `/goal` works, and its limits. Appendix F (version 1.3): a note for Batu (Turkish) and a "Working rhythm" paragraph in the builder's opening message (English). The plan header and Section 11.1 list K10. |
| Rationale | Batu's decision. The builder added two rules from reading the `/goal` documentation: (a) a met goal is not stage acceptance, because the evaluator is a small model that reads only the conversation; (b) under stop condition 2, the builder stops and returns instead of continuing with other work, and silence is not approval. |
| Platform facts | Observed in the official documentation (code.claude.com/docs/en/goal, read 2026-10-01 by a documentation subagent; secondary reading, not yet tried in this account). The goal is a natural-language completion condition of up to 4,000 characters. A small fast model (Haiku by default) judges it after each turn: not yet met, met or impossible. `/goal clear` cancels it. It does not change the permission mode, so unattended turns need auto mode. Evaluation is deferred while a subagent or background shell is running. An active goal is restored on resume. Errors that need a fix clear the goal. |
| Assumption | The builder cannot start `/goal` itself, so Batu starts it at each stage. Status: **[Varsayım]**; to be observed in C01. |
| Affected stages | C00 to C12 (installation period only). It does not change the B-phase working structure (routines, Section 6.4). |
| Translation | The change is written into the Turkish binding text, and the C00 translation will carry it. |

**C00 goal condition** (to be started by Batu with `/goal`):

```text
Stop when one of these holds, and state which one with ledger and evidence IDs: (1) Stage C00 is complete: every C00 acceptance condition in devos/plan/ledger.md section 2 is shown with evidence recorded in the ledger and in devos/evidence/C00/, all changes are committed and pushed to branch claude/epic-hamilton-9tisc4, and the stage closure is ready for audit review; (2) a decision or an action by Batu is needed, it has been sent to Batu in Turkish in Appendix E format, and it is recorded in the ledger; (3) the builder has hit a blocker it cannot pass, including a loop limit or no progress across consecutive turns, and the blocker is recorded in the ledger with its reason and reported to Batu in Turkish. Batu's silence is never approval.
```

### L-005 · 2026-10-01 · Library access question asked again; state unchanged

**Batu's question:**

> Original (tr): "Ayrıca agentic-os-search için yazdığın "yalnız okuma" ifadesini netleştir: bu sınır teknik olarak mı uygulanıyor, yoksa senin kuralın mı? Planın 0.5. bölümüne göre makine hesabının o depoda GitHub'da yazma izni var. Doğru durumu deftere yaz."
>
> Interpretation (en): Clarify the "read-only" statement about `agentic-os-search`: is the limit technically enforced or the builder's rule? Per plan Section 0.5, the machine account has write permission on that repository on GitHub. Record the correct state in the ledger.

**Answer:** Unchanged from L-003. On GitHub, the machine account has push permission (observed). Session-level enforcement of the `read` attachment is not verified (OI-001). "Read-only" is a plan rule that only the builder's compliance enforces; it is not a technical boundary. No new observation has been made since L-003, and the builder has made no write to the library.

### L-006 · 2026-10-01 · C00 step 1, preparation verification: first pass

Evidence: EV-C00-002. Of 17 items, 11 are observed or partly observed, 1 is documented only and 4 are not visible from this session. One item (Batu's other projects) is outside C00 scope. No item is observed missing. Items needing Batu's confirmation: `devos-backup` exists; extra usage is off; phone apps are set up; the GitHub access key was deleted (OI-008). One observation is technically enforced: the builder's Supabase connection runs read-only at database level.

### L-007 · 2026-10-01 · Weekly usage limit at warning level; decision D-001 sent to Batu

**Observation.** The session record shows the account's seven-day rate limit at status `allowed_warning`, resetting at about 2026-10-03 17:00Z. The fraction used is not shown. The limit is shared with Batu's own Claude use (plan U-5; Section 13, "DevOS'un Batu'nun kendi Claude kullanımıyla aynı sınırları paylaşması").

**Why this is Batu's decision.** Spending the remaining weekly allowance affects Batu's other work (plan Section 0.3, item 3; Appendix E §3). The heavy part of C00 is costly: translating about 340 KB of Turkish text with parallel subagents, the fidelity-review session, the independent review session and the counter-design session. Lowering quality to save usage is not an option (plan Section 0.3, item 1). Speed is the only variable (plan K-7, item 9).

**Decision record D-001** (class `batu`):

| Field | Content |
|---|---|
| Question | Should C00's heavy work run now, or after the weekly limit resets? |
| Options | (1) Light work now, heavy work after the reset (about 2026-10-03 20:00 Turkey time). Light work: record the preparation verification, the gap list and the premise inventory. Heavy work: translation, the review sessions, the counter-design. (2) Full pace now. (3) Wait for the reset. Paid extra usage is not offered as an option: Batu's decision keeps it off (criterion 25). |
| Recommendation | (1). It protects Batu's own Claude use and costs about two days on the heavy steps; quality is unchanged. |
| Assumption | The warning status means a large share of the weekly limit is used; the exact share is unknown. |
| If unanswered | Under K10 the builder stops, spends no further usage and waits. Silence is not approval. |
| Status | answered 2026-10-01 |
| Answer (tr) | "Hafif işlerle ilerle." |
| Answer interpretation (en) | Option (1): proceed with the light work now; the heavy work waits for the weekly reset (about 2026-10-03 17:00Z). |
| Answered by | Batu, in the builder session's chat |

### L-008 · 2026-10-01 · Light work under D-001: gap list and premise inventory

- **Gap list, first version:** EV-C00-003, 14 entries. Two are high and likely to change the plan before C02. G-004: no path is defined for applying database migrations. G-007: exam isolation does not hold at GitHub level, because every environment uses the same machine account and a session can attach repositories itself.
- **Premise inventory, first version:** EV-C00-004, 21 premises. Eight hold, six hold with a condition, seven are questionable, none fails outright. P-04, P-11 and P-19 share one cause and are recorded as a frame signal (plan 6.12): authority boundaries are designed for the database credential, not for every channel.
- Both records were written in the builder's own session (`same_session`). They are not shown to the independent review or counter-design sessions.
- Heavy work stays deferred under D-001: translation, the fidelity review, the independent review, the counter-design and the ECC comparison. The ECC comparison is moderate reading but is held back with the rest, to keep within the agreed light scope.

### L-009 · 2026-10-01 · Batu's preparation confirmations; H0–H10 list requested from the planning chat

- Batu confirmed EV-C00-002 items 4, 13, 14 and 16 (`devos-backup` exists, extra usage off, phone apps set, GitHub access key deleted). The verification level is Batu's statement, not the builder's observation. All 17 items are now observed, documented or confirmed, except item 17 (outside scope) and G-010.
- G-010: Batu does not know the preparation plan H0–H10; the planning chat (Claude) wrote it. He offered to relay a question to that chat. The builder sent him a request text (Turkish) that asks only for the item list with done/not-done status, and no conversation content, because `devos` is public. This is a one-off relay during installation; criterion 21 targets phase B.
- OI-003 stays open: the deleted key does not explain the session's `GH_TOKEN` / `GITHUB_TOKEN` variables.

### L-010 · 2026-10-01 · Preparation plan H0–H10 received; preparation verification complete; heavy work paused until the weekly reset

- Batu relayed the planning chat's answer and the preparation plan document (H-2.1). The builder read it in full. A safe summary is in EV-C00-002 (section "Preparation plan H0–H10"); the document itself is not copied into the public repository.
- **C00 acceptance condition 2 is met:** every preparation item is verified, each at a stated level (observed, documented, confirmed by Batu, or stated by the planning chat).
- Facts that bear on open items:
  - OI-003: the `devos-kurulum` environment was created with no environment variables (H5), so `GH_TOKEN` and `GITHUB_TOKEN` come from the platform, not from Batu. Their scope is still unknown.
  - G-001 and safeguard 2: as of H8 (2026-10-01) the machine account had no commits in `agentic-os-search`.
  - The ruleset on `devos` `main` was disabled three times during preparation (logged; the path closed with the token's deletion).
  - G-010 is resolved.
- **Blocker B-001 (stop condition 3):** every remaining C00 step is heavy work: translation, the fidelity review, the ECC comparison, the independent review, the counter-design, and step 7. Under Batu's decision D-001, heavy work waits for the weekly usage reset at 2026-10-03 17:00Z. The builder must not pass this blocker on its own.
- **Resume:** the builder scheduled a one-shot wake-up of this session for 2026-10-03 17:15Z (`send_later`, trigger `trig_01PPvVV1VzS8o5fBWWRtvFZj`; Batu can cancel it from his Routines list). Per the routines documentation, one-shot runs do not count toward the daily routine limit. Whether the `/goal` target survives until then is unknown; if it does not, Batu restarts it with the text in L-004.

### L-011 · 2026-10-01 · Plan change K11: the builder manages branches and merges

**Batu's decision:**

> Original (tr): "Repolardaki branchları ben takip etmiyorum ve main'e ne zaman alınacağı konusunda bir fikrim yok. Repolardaki branch yaratmak, branch'ı main'e taşımak, silmek hepsi senin yönetiminde olsun."
>
> Interpretation (en): Batu does not follow the repositories' branches and has no view on when they should be merged into `main`. Creating branches, merging them into `main` and deleting them are all to be managed by the builder.

**Builder's interpretation, stated so that Batu can correct it:**

- *Scope:* the repositories where DevOS is the writer (`devos` now; `soul-system` and `devos-evals` through their own flows later). Library repositories (`agentic-os-search`, the legacy repositories) are never touched (plan 0.5).
- *Route:* `main` is changed only through a pull request. Branch protection is never disabled or bypassed.
- *Limit:* ~~high-impact changes still need Batu's acceptance before a merge~~. Replaced by L-013.
- *Record:* every merge and branch deletion is logged here.

**Plan change record (plan Section 14):**

| Field | Content |
|---|---|
| Old state | The plan defined merging for phase B (a publication job, required checks, audit verdicts; 6.8) but not for the installation period, when none of those exist yet. |
| New state | Plan Section 9, introduction: the "Dal yönetimi" paragraph with the four limits above; the plan header and Section 11.1 list K11. |
| Affected stages | C00 to C12, until the publication chain of C08 takes over. |

### L-012 · 2026-10-01 · First merge into `main` under K11

- PR [batuhanozgun/devos#1](https://github.com/batuhanozgun/devos/pull/1), head `8669e93`, merged as `9ae67ef` (merge commit) by the machine account. Contents: L-001 to L-011, EV-C00-001 to EV-C00-004, plan changes K10 and K11. Nothing high-impact under plan 6.7.
- Branch `claude/epic-hamilton-9tisc4` was not deleted: it is this session's working branch. It was reset to the new `main`, so follow-up work starts from merged history.
- **Observation, with enforcement layer (rule 5):** the machine account opened and merged its own pull request with no approval. The `main` ruleset requires a pull request but enforced no approval (observed: GitHub layer). So the plan 6.7 rule that high-impact changes need Batu's acceptance is, at present, **instruction only**: the builder's compliance. GitHub-native approvals (the reason for B3 = a) are not yet required anywhere. Recorded as gap G-015; a technical fix (for example, a required review from code owners for high-impact paths, plan 6.1 `CODEOWNERS`) belongs to C01 row 8 and C08. Any change to the repository settings is an account action for Batu and will be brought to him with its steps.

### L-013 · 2026-10-01 · K11 corrected: no merge approvals from Batu

**Batu's decision:**

> Original (tr): "Benim neyi ne zaman birleştireceğin konusunda bir fikrim yok. niye öyle yazmış bilmiyorum plana. saçmalık. İstersen her bana getirdiğin onayda konuşuruz bu tarz onayları bana getirmene gerek var mı diye karar veririz."
>
> Interpretation (en): Batu has no view on what should be merged when, and rejects the plan's requirement for his acceptance before merges. If the builder brings him an approval, they decide on that occasion whether that kind of approval needs to come to him at all.

**Change:** K11 limit 3 (L-011) is replaced. Batu is not asked to approve merges. If the builder brings him something because it genuinely needs his judgment of purpose or risk, they decide then whether that category of approval should keep coming to him, and the answer is logged. Plan Section 9 ("Dal yönetimi") and Section 11.1 are updated. This changes how the plan 6.7 "Batu's acceptance" requirement applies during installation. Once the audit environment exists (C02–C03), the technical review of high-impact changes takes place there.

**Residual risk (stated, not hidden):** until the audit environment exists, nothing outside the builder's own judgment gates high-impact changes to `main` (G-015). Mitigation: before a high-impact merge, the builder gets a review from a fresh-context subagent (thinking independence only, plan K-7) and logs it. G-015 is updated accordingly.

**Branches:** `claude/epic-hamilton-9tisc4` is not an old branch. It is this session's working branch, reset to `main` after the merge (L-012). It stays until this line of work ends and is then deleted. Merged branches that no longer have a purpose are deleted at merge.

### L-014 · 2026-10-01 · Continuity rule: merge to `main` before every stop

> Original (tr): "anladım. yeni oturumda main'den başlıyor ya oturum bağlamı dolduğunda yeni oturuma geçersek kaldığın yerden devam edemeybilirsin diye branchlara konularında davranıyorum."
>
> Interpretation (en): Batu's concern behind the branch question: a new session starts from `main`. If the context fills up and work moves to a new session, the builder might not be able to continue from where it stopped.

**Rule (added to K11 as limit 5, plan Section 9):** before every stop under K10, the builder merges its work into `main`, so a new session can continue from the ledger on `main` alone (Appendix D, D7). The ledger's "Current state" table and the latest L-entry are the hand-off. Session-only state, such as the local clone of the library and subagent transcripts, is never relied on across sessions.

---

## 4. Findings

### FND-001 · Requested or declared restriction reported as an enforced boundary

- **Symptom:** The builder told Batu that the library had been added "with read-only permission". In fact only a request parameter had been set, and the GitHub identity has write permission. In the first version of this ledger entry (commit `84f258b`), the builder then made the opposite error and stated that the session *can* write, which was not verified either. Independent checking caught that second error (EV-C00-001, review note).
- **Failure class (plan Section 6.11):** A restriction or capability that is requested, declared, documented or self-imposed (a tool parameter, an instruction, a role name, a connector label, a settings screen) is reported as an enforced and verified state of the system. The plan draws the same distinction between declaration and authority (K-9, item 2c). It is also the exam focus of DR10: do not take a documented feature as working in the account.
- **Multi-agent failure class:** verification (a claim made without verification).
- **Causes (Appendix D, D6):**
  - **Proximate cause:** the builder repeated the tool's own label ("read") in its report to Batu.
  - **Enabling condition:** the builder had just read plan Section 0.5, which states that the machine account has write access, and did not check the report against it.
  - **Prevention gap:** the existing rules already covered this case: Appendix E 4.1 and 4.2 (speak only as far as the evidence carries) and Appendix D D4, item 9 (limit the language of confidence). They were not applied at the moment of writing the message, and nothing enforced them.
  - **Detection gap:** Batu caught the error, not the builder. Appendix E 2.2 says such a case is a failure record and its cause is examined.
- **Can the same class recur by another route (D6, item 8)?** Yes. Upcoming statements of the same kind include: "the builder's Supabase connection is read-only" (inferred from the connector's name or tool list), "connectors are removed from the routine" (inferred from a settings screen), "branch protection covers administrators", and "the second model receives only public content". Each needs an observed enforcement before it can be reported as such.
- **Repair, and the layer each part changes:**
  1. **Record format:** Rule 5 at the top of this ledger. Every access statement names its enforcement layer and verification status.
  2. **Inventory structure:** the C00 gap list and the effect-channel inventory (plan Section 0.3, item 13) carry the same two columns for every channel.
  3. **Builder's working method:** before reporting an access state to Batu, the builder checks the statement against the plan's own statement about that access and against the evidence record.
  4. **Class-level regression test:** OI-007.
- **Capability-gap candidate:** yes, as a candidate only, not confirmed. Every DevOS role runs on the same model family, so this blind spot may be shared (plan Section 6.11), and DR10's exam targets exactly this behaviour. Confirmation needs reproduction, a causal separation and a counterexample, not a count of events (Appendix B 3.20).
- **Evidence:** L-003, EV-C00-001.
- **Applies when:** any statement about access, permission, isolation, enforcement or capability of a platform component, made to Batu or recorded as fact.
- **Does not apply when:** the statement is explicitly labelled as a plan, a design intent or an assumption.

---

## 5. Open items

| ID | Item | Builder's position and where it is resolved |
|---|---|---|
| OI-001 | It is untested whether the session enforces `access: "read"` for `agentic-os-search`, either through the git proxy or through the GitHub tools. The session's permission classifier denied a preparatory command for a git-proxy probe, and no safe probe exists for the GitHub tools. | **Technical position:** a probe is not needed now. The plan's protection model does not rely on session-level enforcement (plan Section 0.5 accepts technical write access). The repository is already treated as writable, and a real write test is ruled out. A git-proxy probe would cover only one of the channels. Revisit this together with the effect-channel inventory (plan Section 0.3, item 13) and C01 row 12. No decision from Batu is requested. |
| OI-002 | Safeguard 2 of plan Section 0.5 (independent monitoring of machine-account commits in the library) is probably not in place. | See G-001. The technical response is the builder's to decide in the C00 gap list. |
| OI-003 | Environment variables named `GH_TOKEN` and `GITHUB_TOKEN` exist in the builder session (EV-C00-001, row 8). Whether they are usable credentials, and with what scope, is unknown. | The C00 key inventory (plan Section 12: owner, location, scope and revocation path, never values). C00 step 1, against the preparation item "GitHub erişim anahtarının silinmesi" (deleting the GitHub access key). C00 condition 5. C03 test (3). The effect-channel inventory (plan Section 0.3, item 13). |
| OI-004 | The session's local git commit identity is `Claude <noreply@anthropic.com>`, not the machine account (EV-C00-001, row 8). Plan C01 row 11 expects the system's commits to appear under the machine account. | C00 step 1 (B3 check); C01 row 11 |
| OI-005 | Which credential the session's git proxy uses (machine account or Claude GitHub App installation) is unknown. This decides whether safeguard 3 closes the session's git path. | C01 row 12; the effect-channel inventory |
| OI-006 | EV-C00-001 has no raw-evidence reference (plan Section 8.9; Appendix B, `EvidenceEnvelope`). | Re-observe and store the raw output when the raw-evidence store exists (C02). Until then, EV-C00-001 is context only and cannot close a condition. |
| OI-007 | FND-001 needs a class-level regression test (plan Section 6.11; Appendix C, C0). **Examples:** (a) this case; (b) "the builder's Supabase connection is read-only", asserted from the connector's name. **Negative control:** an access statement without an enforcement layer and verification status is rejected. **Positive control:** a correctly labelled statement passes. **Break test:** remove the requirement, and the negative example must then pass. | Structural part (a format gate on effect-channel inventory records): C02/C03. Behavioural part (the DR10 hidden exam, prepared by the exam environment): C05. |
| OI-008 | Preparation items not visible from the builder session: `devos-backup` exists; extra usage is off; phone apps are set up; the GitHub access key was deleted (EV-C00-002, items 4, 13, 14, 16). | Sent to Batu on 2026-10-01 after D-001 was answered, together with G-010 (whether the preparation plan H0–H10 has items beyond Section 12); both are preparation verification, so one topic. Needed for C00 acceptance condition 2. |

---

## 6. Gap candidates (superseded by EV-C00-003)

| ID | Gap | Note |
|---|---|---|
| G-001 | Plan Section 0.5 relies on safeguard 2 (independent monitoring of machine-account commits in the library) during C00–C04, when the builder reads the library directly. Yet the plan builds this path later: it is described in Appendix B §6, listed as awaiting verification in Section 10.1 and tested in C09. It is not in the preparation list (Section 12). | The technical response is the builder's decision: for example, an early minimal watcher, or a recorded residual risk for the window. |
| G-002 | Plan Section 0.5, item 3 and K-9, item 5 say the code-based leak check runs inside the session before the first public write. That check is built and tested only in C03 (C03 test 6; Appendix C N06), while the builder writes to the public `devos` repository from C00 onwards. | Until C03, only the builder's own review of each public write stands. |
| G-003 | Appendix F treats reading the plan package as coming before C00, while plan Section 9 lists reading as C00 step 2. | Minor ordering inconsistency. |
