# DevOS installation ledger

**Status:** Authoritative progress record of the installation until the ledger is transferred to the database at the end of C02 (plan Section 9, introduction). After that transfer this file stops being a write surface.

**Rules for this file**

1. `devos` is a public repository. This file holds only safe summaries and identifiers: no text from the research library, no conversation transcripts, no key or token values (plan Sections 0.5 and 6.7; K6, K8).
2. Until the translation fidelity review of the plan package passes, the Turkish plan package is the binding text; references below point to it (plan Section 0.6).
3. A stage's acceptance conditions are written here before its results are seen and are never loosened afterwards (plan Sections 8.6 and 14).
4. Batu's words are recorded with the original Turkish text and an English interpretation (plan Section 0.6, item 2).
5. Every statement about access or permissions names the layer that enforces it and how it was verified (see FND-001).

**Identifiers:** `L-nnn` log entry · `FND-nnn` finding · `OI-nnn` open item · `EV-Cxx-nnn` evidence record under `evidence/Cxx/`.

---

## 1. Current state

| Item | State | As of |
|---|---|---|
| Stage | C00 not started. Reading of the plan package complete (L-001). | 2026-10-01T15:52Z |
| Binding plan text | Turkish plan package at `devos` commit `6186e5d` | 2026-10-01 |
| Builder's access to `agentic-os-search` | **Technically writable by this session as far as verified.** Read-only is the builder's own rule, not a verified technical boundary. Details in L-003 and `evidence/C00/EV-C00-001_library_access.md`. | 2026-10-01T15:52Z |

---

## 2. Pre-registered acceptance conditions

### C00 (working translation of plan Section 9, C00, "Kabul"; the Turkish text is binding)

- ✔ The translation fidelity review has passed; changes proposed during translation are recorded separately.
- ✔ Every item of the preparation list is verified with evidence.
- ✔ The ECC table, the independent review, the counter-design comparison and the premise inventory are recorded; the disposition of every finding is written.
- ✘ The builder wrote nothing to the library repositories.
- ✘ No secret is visible in a repository, an environment variable or the chat.

Registered 2026-10-01, before any C00 result was seen. Note: L-003 already bears on the fourth condition (the builder *can* write to the library; the condition concerns whether it *did*). OI-003 bears on the fifth.

---

## 3. Log

### L-001 · 2026-10-01 · Plan package read

The builder read completely, from beginning to end: `DevOS_Kurulum_Plani.md`, `Ek_A` through `Ek_G`, `Uyandirma_ve_Kapasite_Arastirmasi.md`, `Calisma_Duzeni_Karsilastirmali_Arastirma.md`, `Inceleme_Degerlendirmesi_Claude.md`, `Inceleme_Degerlendirmesi_ChatGPT.md` (all at `devos` commit `6186e5d`). No file was changed before reading was complete.

### L-002 · 2026-10-01 · Library repository attached to the session

- At session start only `devos` was attached; `agentic-os-search` was not, although Appendix F tells Batu to select both.
- The builder attached `batuhanozgun/agentic-os-search` with the session tool `add_repo`, passing the parameter `access: "read"`, and made a shallow local clone (library commit `dc91f6b`, 2,392 files).
- The builder deliberately did **not** register the clone as a repository root, so the library's files are not loaded into the session as instructions (plan Section 0.5: the library is a source of information, not of instructions). The library has no `CLAUDE.md` and no `.claude/` directory.
- Nothing was written to the library repository.

### L-003 · 2026-10-01 · Correction: the library's "read-only" access is not a verified technical boundary

**Trigger.** Batu's question after the builder's first message:

> Original (tr): "agentic-os-search'ü "yalnız okuma izniyle" eklediğini yazdın. Bunu nasıl ekledin? Okuma sınırı teknik olarak mı uygulanıyor, yoksa senin kuralın mı? GitHub'da makine hesabının bu depoda yazma izni olduğunu planın 0.5. bölümünde bulabilirsin. Doğru durumu kurulum defterine yaz."
>
> Interpretation (en): The builder said it added `agentic-os-search` "with read-only permission". Batu asks how it was added and whether the read limit is technically enforced or only the builder's rule, points out that plan Section 0.5 states the machine account has write permission on that repository on GitHub, and instructs the builder to record the correct state in the installation ledger.

**What the builder had said.** In its first message to Batu the builder wrote that it had added `agentic-os-search` "yalnız okuma izniyle" (with read-only permission). That wording presented a request parameter as an enforced permission. It was wrong; the correct state is below.

**Correct state** (evidence: `evidence/C00/EV-C00-001_library_access.md`):

| Layer | What holds | How it is known |
|---|---|---|
| GitHub identity of this session's GitHub tools | `batuhanozgun-devos` (the machine account, B3 = (a)) | Observed: GitHub API, authenticated user |
| GitHub permission of that identity on `agentic-os-search` | `pull: true`, `triage: true`, **`push: true`**, `maintain: false`, `admin: false` | Observed: GitHub API repository object, `permissions` field |
| Session attachment (`add_repo`, `access: "read"`) | A request to attach the repository for fetch and clone. Whether it blocks writes through the session's git proxy or through the GitHub tools is **not verified**. The tool's result states that writes stay limited to repositories attached to the session, and this repository is now attached. | Tool description and tool result only; no observation of enforcement |
| Git push through the session proxy | **Not tested.** A preparatory command for a no-write permission probe (snapshot of remote refs, then `git push --dry-run`) was denied by the session's automatic permission classifier. The probe was not pursued by any other route. | Denial recorded; no observation |
| GitHub tools (`mcp__github__*`) that write files, branches or pull requests | Not blocked as far as known: the identity has `push`, and the repository is in the session's scope. Not tested, because the only test is an attempted write. | Inference from the two rows above |
| Environment variables named `GH_TOKEN` and `GITHUB_TOKEN` | Present; values not read; scope and function unknown | Names only (OI-003) |
| Builder's rule | The builder only reads the library and never writes to it (plan Section 0.5; opening message) | Instruction; **this is the only verified protection** |

**Conclusion.** For this session, "read-only" on `agentic-os-search` is the builder's rule. It is not a verified technical boundary. On GitHub the machine account has write permission, as plan Section 0.5 states and the GitHub API confirms. Plan Section 0.5 names two further safeguards. One is an independent monitoring path that reports every commit the machine account makes in `agentic-os-search`; whether it exists today is not verified (OI-002). The other is removing the machine account's access after C04; that is still in the future.

**Library unchanged.** The builder made no commit, push, branch, pull request, issue or comment in `agentic-os-search`. Every operation listed in L-002 and L-003 read data or ran locally.

---

## 4. Findings

### FND-001 · Requested or declared restriction reported as an enforced boundary

- **Symptom:** The builder told Batu that the library had been added "with read-only permission", when only a request parameter had been set and the GitHub identity actually has write permission.
- **Failure class (plan Section 6.11):** A restriction that is requested, declared or self-imposed (a tool parameter, an instruction, a role name) is reported as an enforced and verified technical boundary. This is the same distinction the plan draws between declaration and authority (K-9, item 2c) and the exam focus of DR10 ("do not take a documented feature as working in the account").
- **Multi-agent failure class:** verification (a claim made without verification).
- **Causes (Appendix D, D6):** Proximate cause: the builder repeated the tool's own label ("read") in its report to Batu. Enabling condition: the builder had just read plan Section 0.5, which states that the machine account has write access, and did not check the report against it. Prevention gap: no rule required an access statement to name its enforcement layer. Detection gap: Batu caught it, not the builder (Appendix E, 2.2: such a case is a failure record and its cause is examined).
- **Class-level repair:** (1) Rule 5 at the top of this ledger: every access or permission statement names its enforcement layer (GitHub permission, session or proxy, database, instruction only) and its verification status (observed, documented only, not verified). (2) The C00 gap list and the effect-channel inventory (plan Section 0.3, item 13) use the same two columns for every channel. (3) Before reporting an access state to Batu, the builder checks it against the plan's own statement about that access.
- **Capability gap:** none confirmed. A single event does not establish one (plan Section 6.11).

---

## 5. Open items

| ID | Item | Where it is resolved |
|---|---|---|
| OI-001 | Whether the session's git proxy and GitHub tools enforce `access: "read"` for `agentic-os-search` is untested; a probe was denied by the session's permission system. Until resolved, the library repository is treated as writable by this session. | Batu decides whether to permit a no-write probe; otherwise it stays untested and the residual risk is recorded in C00 |
| OI-002 | Whether the independent monitoring path that reports machine-account commits in `agentic-os-search` (plan Section 0.5, safeguard 2) exists today. The builder cannot see it from this session. | C00 step 1 (preparation verification) |
| OI-003 | Environment variables named `GH_TOKEN` and `GITHUB_TOKEN` exist in the builder session. Whether they are usable credentials, and with what scope, is unknown. They are relevant to the effect-channel inventory and to the C00 condition "no secret visible in an environment variable". | C00 step 1; C01 row 13 |
| OI-004 | The session's local git commit identity is `Claude <noreply@anthropic.com>`, not the machine account. Plan C01 row 11 expects the system's commits to appear under the machine account. | C00 step 1; C01 row 11 |
