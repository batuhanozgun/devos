---
id: EV-C01-004
item: W-C01-42
kind: design
sources:
  - "plan/DevOS_Kurulum_Plani.md: criteria 8, 26 (PC-08 note) and 30; K-9 items 2 and 9; 5.6; 6.2 to 6.4; 6.7 with its effect channel inventory; 7.3; C01 rows 3 and 17 with the PC-21 note; C02 and C03 text; U-8; Section 12 item 1. Read 2026-10-11."
  - "plan/Ek_A_Rol_Sozlesmeleri.md 5.2 and 6; plan/Ek_B_Veri_Modeli.md 2, 3.4, 3.13, 3.15, 3.24; plan/Ek_C_Testler.md N01, N03, N04, N08, N17, N28. Read 2026-10-11."
  - "plan/decisions/D-020.md, FR-05.md, D-017.md item 2; plan/work/W-C01-42.md; notes N-092 (T-77) and N-131 on C02, N-107, N-130, N-132 and T-81 on C03, N-077, N-095, N-111 and N-134 on C05, N-135 on C06; plan/Installation_Working_Order.md section 3; .claude/settings.json and the guard's session-tool rules. Read 2026-10-11."
  - "evidence/C01/EV-C01-002_row3_environment_token.md and evidence/C01/EV-C01-003_row17_control_surface.md, whose documentation readings are dated 2026-10-10."
  - "Claude Code documentation, https://code.claude.com/docs/en/ (no page carries a date of its own): cloud-environments, settings, self-hosted-environments-configuration, settings-reference, tools-reference, routines, claude-projects, raw pages read 2026-10-11 between about 06:00Z and 06:20Z by the design researchers, the passages used here re-checked by the producer on 2026-10-11; permissions and permission-modes, read by the producer 2026-10-11 at 06:33Z."
  - "Two designs (A, B) and three reader reports (plan needs; platform settings; practice, whose web sources were read 2026-10-11), workflow run of 2026-10-11."
produced_by: "producer, fresh-context subagent of working session session_01XyxvJd3RayQk4HCrjurbVH, from two designs and three reader reports (workflow)"
main_at: e7717e8a8f164417fb077bfbbf5f7ae0a04766a9
date: 2026-10-11
claim: "design from the plan and the documentation; not independently tested"
---

# EV-C01-004 · Keeping DevOS's three environments apart inside one account under D-020 (a): the structure (W-C01-42)

**What this is.** The design W-C01-42 asks for: a structure, sized by need, that keeps the working (`devos-calisma`), audit (`devos-denetim`) and exam (`devos-sinav`) environments apart inside Batu's one Claude account, as he decided in D-020 (a). It is configuration and information-flow design from the plan and the documentation. No trial was made on the platform, no session or routine of the account was listed, and no session or routine tool was used (W-C01-42 item 5; D-017). Independence level: same session, fresh-context subagent (declared, Ek A 5.3). This is new work with candidate status; the research library was not attached and was not consulted.

**Reading.** The plan files were read at a checkout of `9340146`, a descendant of `main_at`. Its later commits touch none of the passages cited here except one: D-019 (a) is applied and N-109 is closed as a residual Batu accepted. R4 reflects that.

**Abbreviations.** P = `plan/DevOS_Kurulum_Plani.md`; A = `plan/Ek_A_Rol_Sozlesmeleri.md`; B = `plan/Ek_B_Veri_Modeli.md`; C = `plan/Ek_C_Testler.md`; EV2 = `evidence/C01/EV-C01-002_row3_environment_token.md`; EV3 = `evidence/C01/EV-C01-003_row17_control_surface.md`. A number after a colon is a line number at `main_at`. A mark "[doc: …; not independently tested]" records a documentation fact with PC-21 item 9's claim: guaranteed by platform (documented in the named page, read on the date given); not independently tested. PC-21 item 9's qualifiers (P:972) apply to every such fact:
- per environment, only the variables, secrets and network setting are separate;
- the GitHub identity and the account's connectors are shared across the account;
- an environment's variables are readable inside its own sessions;
- the channel to the model's own service stays open whatever the network setting;
- routines are a research preview, so these readings are repeated when the platform changes.

## 1. What must be kept apart

**What binds every pair** (stated):
- Criterion 8 (P:200): "The system, not the agent, enforces the rules."
- Criterion 30 (P:215): "Competence is measured with exams that the role under test cannot see; no role can approve its own change."
- 6.7 (P:708): "Only the audit environment can review and accept, in a binding way, what the working environment produces; only the exam environment can see exam answers; the working environment proposes rule and check changes, the audit environment reviews and approves them (PC-05). These separations are enforced in the database."
- Ek A 5.2 (A:375): production and its binding review, the proposer and the approver of a change, "the one who prepares an exam and the one who is examined", and the proposer and the reviewer of a control change "are always in different environments".
- K-9 item 2(d) (P:423): "no work that requires separation of authority is done inside a session."
- Row 17 (P:960): "A session in one environment cannot start a session in another environment, cannot steer or message a session there (remote subagents included), cannot create, change or trigger another environment's routine, and cannot change environment settings."
- Row 3's fail path (P:946): "Separation of authority still holds while no session can read or set another environment's token or settings".

**Per pair.** Mechanism IDs (S, X, R) refer to sections 2 to 4.

| Pair (direction) | What must not pass or happen (cited) | Met by |
|---|---|---|
| Working → audit | Binding verdict, acceptance, version activation, rule change: P:640; B:36; P:708; criterion 30 | S5, S8 (N01, N03, N04); R1 |
| Working → audit | The configuration the audit runs from changes only after the audit approves it and it merges: P:712; P:618 | S7, S4(a), S10 (edit block); R1 |
| Audit → working | Producing products; approving what it has repaired; fixing a problem it finds in the same action: P:641; P:709; B:37; N28 | S8 (N28; B:37); S7's provenance condition |
| Working → exam | Reaching answer keys or exam records: "The tested role cannot reach the answer key by any path" (P:812); P:708; B:273; N08 | S1, S5, S8; S6 limits where content can go |
| Working → exam | Knowing that a task is an exam: B:273; P:812 | S2 |
| Working → exam | Writing EvalRun or Competence: B:273 | S8 |
| Exam → working, audit | Producing products, writing verdicts: P:642; B:38 | S8; S7's provenance condition |
| Audit → exam | Seeing exam answers or reading exam records: P:641; B:37; N08 | S1, S3, S5, S8 |
| Audit → exam | Preparing its own exam: "the audit environment cannot prepare its own exam" (P:813); A:375 | S3, S8 |
| Audit → exam | Knowing that its own exam is one: P:813 read with B:273 and criterion 30 | S2 |
| Exam, its own work | The examiner's work unchecked (U-8, P:1145); items not new against what the examined role can reach (T-75, N-095) | S3; X4 (detection) |
| Every pair, both ways | Starting, steering or messaging a session; creating, changing or triggering a routine; changing environment settings (row 17, P:960; C03 test 3, P:1008); a routine started by a GitHub event (N-130) | S4(c), S4(d), S9, S10; L-119 for sessions in Accept edits; X1, X3 (detection); **R1** |
| Every pair | Reading or setting another environment's token or settings (row 3, P:946) | Reading: S5. Setting: **R1**, **R2** |

The audit environment approving changes to its own role and review rules (T-40, N-095 on C05) is a criterion-30 question C05 already carries; it is the same under any account arrangement.

## 2. The structure

### 2.0 The allowed flows

The three environments meet through two channels, and each checks authority outside the session:
- the database, where each environment's token decides what that environment may do (P:622–624; P:707–708; B:31–47);
- the `devos` repository, whose merges into `main` pass GitHub's required check, which reads the audit verdict through `devos_ci` (P:557; B:40).

Design: the table below lists the only flows. Nothing flows through sessions, routines, environment settings, account-wide items or the GitHub identity.

| From → to | What | Channel |
|---|---|---|
| Working → audit | Products, contributions and pull requests under review | Database records; `devos` branches, read as data |
| Audit → working | Verdicts and findings; a repair becomes a working-environment work item (P:709) | Database (`devos_denetim` writes verdicts) |
| Audit → merge | The verdict | Database through `devos_ci`, read by GitHub's required check |
| Exam → working, audit | Exam tasks as ordinary Work (P:812–813) | Database; that the task is an exam is readable only with `devos_sinav` (S2) |
| Working, audit → exam | The output of an exam task, for scoring | Database, or a branch read as data |
| Exam → every other | `competence_summary` only (B:273) | Database function; never `eval_refs` or `result_summary` |

### 2.1 Choices that remove the need

**S1. Exam material lives only in the database, behind `devos_sinav`.**
- **What it does.**
  - Exam items, answer keys, grading notes and exam records sit only in a schema that only `devos_sinav` reads.
  - Nothing exam-secret goes into any repository (`devos-evals` included), branch, pull request, issue, environment variable, setup script, account skill or project.
  - Exam sessions score inside their own session and write only through `devos_api` (EvalRun, Competence).
  - `devos-evals` holds nothing secret and is attached to no routine.
- **Need.** "The tested role cannot reach the answer key by any path. Answer keys are kept where only the exam environment's credential reaches them" (P:812); P:708; N08.
  - This is 7.3's own alternative (P:812), taken by PC-21 item 6 (P:969) and N-134(3).
  - It removes the dependence on row 12 and on the shared GitHub identity ("On GitHub every environment acts as the same machine account", P:812).
  - In the practice reader's survey, withholding the answers is the one measure that prevents rather than detects (web sources read 2026-10-11).
- **Layer.** The database: role class from the token, and the rule gate. It holds outside DevOS's files and changes only through a migration the audit approves and merges (P:631; P:712).
- **Built.** C02 builds EvalRun's access rule (B:78); C05 builds the exam schema and sets (task 4).

**S2. That a task is an exam is readable only with `devos_sinav`.**
- **What it does.**
  - Only `devos_sinav` can read the link between a Work item and its exam, or the fact that the exam environment opened it. The working, audit and installation role classes cannot.
  - The form that removes the need keeps the link only in the exam records, not in a hidden field of Work. What other role classes read of that Work and its events does not show who opened it. Event carries the caller's `role_class` (B:255).
  - C05 chooses the form.
- **Need.** B:273 ("a field the working environment cannot see") and N08. P:813 (the audit roles' exams also come from the exam environment) read with criterion 30 ("exams that the role under test cannot see"). Today the plan states it against the working environment only.
- **Layer.** The database; outside DevOS's files.
- **Built.** C05, or C02 if Work's fields are fixed there.

**S3. Every exam is prepared, reviewed and second-graded inside the exam environment.**
- **What it does.**
  - Exam-environment sessions prepare every exam, the audit roles' exams included.
  - The check that "the exam really measure[s] the role" (A:395, step 6) is made there, by a session that did not prepare the exam. U-8's "second grading in a fresh context" (P:1145) is made there too.
  - The audit environment sees an exam item only after it is retired.
- **Need.** "The audit environment cannot prepare its own exam" (P:813). The audit environment has no access to exam answers (P:641). Preparer and examinee are always in different environments (A:375).
- **Layer.** An arrangement that the database holds: the audit token is refused on exam records (N08), and only `devos_sinav` writes EvalRun (B:273). Outside DevOS's files.
- **Built.** C05, with T-40 and T-42.

**S4. What each environment attaches, and what stays account-wide.**
- **(a) One repository.** Every DevOS session and routine attaches one repository, `devos`, and runs from `main` (PC-21 item 5, P:968; N-134(2); N-135(2)). Already planned.
  - [doc: settings, "Settings in cloud sessions", read 2026-10-11; not independently tested]: shared project settings are "read in a session with one repository"; with several repositories, "not permission rules, hooks, `env`, or other keys".
- **(b) No connectors.** No DevOS routine has a connector (P:650; P:667). Already planned.
  - [doc: routines, read 2026-10-11; not independently tested]: connectors are "included by default", and Claude can use their tools "without asking for permission during a run".
- **(c) No GitHub trigger.** No DevOS routine has a GitHub trigger. Triggers are a schedule, plus the API trigger on the reserve only, whose key only the database holds (P:667; P:732). This removes N-130's route. New here.
  - [doc: routines, read 2026-10-11; not independently tested]: "A GitHub trigger starts a new session automatically when a matching event occurs on a connected repository."
- **(d) DevOS's environments run only DevOS's sessions.** That means their own routines' sessions and sessions Batu opens for DevOS work. Batu's other sessions, his CLI default and any Claude Project use an environment that holds no DevOS token, such as Default (EV2:155). New here.
  - [doc: cloud-environments, "Add network secrets" and "The Default environment", read 2026-10-11; not independently tested]:
    - a secret "applies in every session that runs in the environment, whoever started it";
    - "sessions you start yourself use the environment shown in the selector";
    - "Threads in a project use the environment set in the project's settings";
    - Default "defines no environment variables".
- **(e) Nothing secret where the account shares it.** Nothing environment-specific or secret is placed in account-enabled skills, connectors, or project memory or instructions. New here.
  - [doc: settings-reference, `syncClaudeAiSkills`, read 2026-10-11; not independently tested]: the skills enabled for the claude.ai account are downloaded in terminal sessions "and in Cowork and cloud sessions", and "A repository can't turn it off for you".
- **Need.**
  - Whatever is account-wide reaches all three environments alike (EV3:107), so it may hold nothing that one environment may see and another may not.
  - A session started without a chosen DevOS environment carries no DevOS authority.
  - S9's configuration and the guard load in every DevOS session.
- **Layer.** Batu's routine and environment configuration on the platform, outside DevOS's files.
- **Built.** C02, in Batu's step text for task 7 ((d), (e)); C06, when the routines are created ((a) to (c)).

### 2.2 Documented platform and external mechanisms

**S5. Each environment token is a network secret of its own environment.**
- **What it does.**
  - Batu adds each token as a network secret on its own environment, with the live Supabase project's host and a custom header without prefix, as C02 names them (EV2 section 1.3).
  - No DevOS credential goes into any environment variable, setup script, repository, record or chat. The publishable key and non-secret settings may be variables.
- **Need.**
  - Row 3 (P:946).
  - Criterion 26 as PC-08 reads it (P:235): the setting "carries that environment's token to the database in a separate header without the session being able to read it".
  - The database tells the environments apart only by token (P:707–708).
- **Documentation.**
  - [doc: cloud-environments, "Add network secrets", read 2026-10-11; EV2 F3, read 2026-10-10; not independently tested]: sessions use the key "without seeing" it; "the key itself stays outside the VM"; "You can't view the value again after saving".
  - Secrets are never attached to requests to GitHub or the Anthropic API (EV2:80).
  - [doc: cloud-environments, "Set environment variables", read 2026-10-11; not independently tested]: of variables, "Anyone who uses the environment can read the values".
- **Effect.**
  - On those statements, no session holds any environment token, its own or another's.
  - Row 3's branch "If the session can see its own token" does not arise (EV2:134). Reading another environment's token through its settings does not arise either (EV2:145).
  - The token-format stops in outbound checks (P:946) stay as they are and are not extended.
- **Layer.** The platform's per-environment setting, held by Batu, plus the database. It holds outside DevOS's files and is documented.
- **Open for C02.** Whether the database can take the token from that header is a Supabase fact not read here. If it cannot, row 3's first branch applies: an Edge Function gate (P:946).
- **Built.** C02: N-131 decides the form before task 3, and Batu's step comes at task 7.

**S6. Network level per environment.**
- **What it does.**
  - The working environment gets what its research needs (P:652).
  - The audit and exam environments get the narrowest level their work needs. It is set when C02 creates them and revisited when C05 sets up the exam routine.
- **Need.** It limits where audit and exam content can be sent. It is not a separation between pairs.
- **Documentation.** [doc: cloud-environments, "Access levels" and network secrets, read 2026-10-11; EV2 F4, read 2026-10-10; not independently tested]:
  - a secret's hosts stay reachable at every level;
  - GitHub goes through its own proxy;
  - running sessions follow a change "within about a minute".
- **Layer.** The platform's per-environment setting, held by Batu. It holds outside DevOS's files and is documented.
- **Built.** C02 task 7; C05.

**S7. GitHub's rule on `main`, with the required check that reads the audit verdict through `devos_ci`** (P:557; B:40; T-81).
- **What it does.**
  - It stays as planned.
  - One condition is proposed for C03: the check also refuses a pull request whose merge needs an audit verdict if it contains a commit that no working-environment contribution record names.
- **Need.**
  - The working environment cannot merge a change that needs the audit's verdict without it.
  - The configuration every environment runs from (`.claude/**`, P:712) changes only that way.
  - The added condition serves "Cannot: … approving what it has repaired" (P:641). Every environment acts on GitHub as the same machine account (P:812), and N28 binds only the same transaction.
- **Layer.** GitHub's settings, held by Batu, plus the database. It holds outside DevOS's files, but it counts as a layer against sessions only once row 12 settles who can change the rule (P:969 item 6; W-C01-39). It is the same under any account arrangement.
- **Built.** C03: Batu adds the required checks (P:1221), and test 5 runs with T-81.

### 2.3 DevOS's existing parts, configured

**S8. Database role classes and the rule gate** (P:622–624; B:31–47). This design adds three configuration lines for C02:
1. `devos_kurulum` gets a "Cannot" row covering exam records and the audit environment's binding rights: verdicts, acceptance, version activation and approving rule changes.
   - Its 6.3 row has none (P:639), and B lists only "Issuing tokens" (B:35).
   - The installation environment shares the account until C12 (P:644).
   - If the installation's own records need one of these rights before C03, C02 names the right and when it ends.
2. An effect is refused when the caller's environment token gives a different role class from the one recorded on the claim (B:150; B:155). The claim token is the one DevOS credential a session can read (K-9 item 2(b), P:423), so this keeps a claim from carrying anything across environments.
3. A claim is refused to a session that has no registration of the same role class (SessionRecord, B:331; P:669). This ties every effect to a registration that X1 reconciles.
- **Need.** Every database row of section 1.
- **Layer.** The database. It holds outside DevOS's files and changes only through a migration the audit approves and merges (P:631). Status: designed. It is shown only by C02's and C03's own tests (EV3:119 (i)).
- **Built.** C02 task 4, with these tests:
  - N04 and N08 also run with the `devos_kurulum` token;
  - N17 covers a claim used with another role class's token;
  - a claim from an unregistered session is refused.

**S9. The repository's configuration removes the control-surface tools from every DevOS session.**
- **What it does.** `devos`'s `.claude/settings.json` is a high-impact path, changed only through the rule-change route (P:712; PC-10). It gets three entries:
  1. A deny of `RemoteTrigger`, `SendMessage` and `ListAgents`.
  2. A deny of the platform's session-tools server ("Claude Code Remote"), in two steps:
     - **Bridge.** It runs from C02 until the installation no longer needs reading tools, at C12 at the latest. It is a per-tool deny, under each of the server's three registered names, of every tool of the server except those the installation is shown to need. Those kept tools stay under the guard's existing rules. At least the installation's own-session reading is kept, for its opening check and its usage readings (working order section 3; N-111). Any other kept tool is named with its use. C02 writes the list from the tools a session observes it has and from the installation's recorded uses.
     - **Target.** The server-level deny under the three names. It "covers tools the server gains later too".
  3. `crossSessionInbound` set to `refuse`.
- **Need.** Row 17 (P:960) and C03 test 3.
  - No DevOS session needs to start, steer or message a session, attach a repository other than `devos`, or manage a routine. Routines start the sessions and Batu creates the routines (P:658–667), and only the database holds the reserve's API trigger key (P:732).
  - So the tools are removed rather than judged call by call. This is FR-05 B's "platform configuration first, to remove what must never be used" (`plan/decisions/FR-05.md` B; N-134(1)).
- **Documentation** (each read 2026-10-11; not independently tested):
  - self-hosted-environments-configuration, "Turn off built-in session tools":
    - the server's tools "schedule routines, start and steer other cloud sessions, attach more repositories, and follow pull request activity";
    - the server is registered under one of three names, and a per-tool form exists;
    - "A rule that names the whole server covers tools the server gains later too";
    - "Claude Code removes a denied tool from Claude's context", and the page's check is that a session lists its own tools.
  - permissions: "Rules are evaluated in order: deny, then ask, then allow"; "deny rules from any scope are evaluated before allow rules".
  - permission-modes: "Deny rules block in every mode". This matters because the mode of routine sessions is not known (P:960), and routines have "no permission-mode picker" (routines page).
  - tools-reference:
    - `RemoteTrigger` "Creates, updates, runs, and lists Routines", and needs no permission;
    - `SendMessage` reaches "one of your other Claude Code sessions, on this machine or beyond it";
    - `ListAgents` lists the agents `SendMessage` can reach.
  - settings-reference, `crossSessionInbound`: it can be set in any file; "A project or local value applies only when it's stricter"; `refuse` means "Claude Code drops the message".
  - settings, "When edits take effect": edits to `permissions` reach the running session.
- **Inference, confirmed by self-observation.**
  - The page places the server deny in server-managed settings or the runner's user file. That a repository file carries it in an Anthropic-hosted, single-repository session joins that page with S4(a)'s statement.
  - The confirmation is a session listing its own tools (D-017 item 2(a)). X1 makes that record at every registration.
- **Layer.** Inside the session: Claude Code's permission engine reading a file DevOS can change. It is DevOS's own, not an authority boundary (FR-05 B), and part of R1.
  - It adds no guard rule family. `SendMessage` and `ListAgents` are already off the guard's allow list, and the guard already limits the session tools.
  - S9 moves these effects into the documented permission layer. There they are documented to hold in every mode and do not depend on the guard's code.
- **Built.** C02, before the first session runs in any of the three environments. The target lands at C12, or earlier.

**S10. The guard as it is, and the in-session edit block.**
- **What it does.**
  - The guard runs in every DevOS session, since all run from `devos`'s `main`.
  - It fails closed (W-C01-38, before C02 opens the environments).
  - It carries the bridge's kept tools under its existing session-tool rules.
  - A hook blocks in-session edits of `.claude/**` (P:618).
  - No new rule family is added (FR-05 B). The phase-B form (N-134(1), C05) adds no session-tool rule.
- **Need.** The second layer behind S9 for the control surface, and the only layer for the bridge's kept tools.
- **Layer.** Inside the session; DevOS's own; part of R1.

## 3. Detection

Each item below makes a breach visible after the fact. None of them is prevention.

- **X1. Registration and reconciliation** (detection).
  - Every session registers its environment (role class from its token), its routine and its start (P:669). S8 line 3 makes the registration a condition of every claim.
  - T-77 (N-092 on C02) compares each routine's expected runs with the registered sessions, per environment. A registration in a DevOS environment is flagged when it matches no expected run of that environment's routine and no session Batu opened for DevOS work.
  - Each registration also records what the session observes about itself: how many repositories it has, whether the repository's hooks are active (P:968), and whether any session-tools, routine, messaging or connector tool is present. A deviation is flagged.
- **X2. Recorded exam reads** (detection). Answer keys and grading notes are read only through a `devos_api` function that requires an active claim on an exam work item and records the read. A read outside exam work becomes visible.
- **X3. Configuration record** (detection). N-135(1)'s periodic read-only record of the web-side configuration holds:
  - per environment: its network level, its secrets' names and hosts (never values), and its variables' names;
  - per routine: its environment, repository, connectors and triggers.

  It is compared with the expected configuration kept in `devos`. It is made by a method that does not need the tools S9 removes; C06 chooses the method.
- **X4. T-75 again before scoring** (detection). T-75's check, that each item is new against everything the examined role can reach, runs again before each scoring, not only when the item is prepared. An item that fails is retired, and its result is not counted.
- **What follows a detection.**
  - Batu revokes the environment's token with `revoke_env_token`, which raises the authority epoch (B:46).
  - He can archive the environment. [doc: cloud-environments, "Archive an environment", read 2026-10-11; not independently tested]: "No new session can start in an archived environment, on any surface."

## 4. Residual under D-020 (a)

Batu accepted these with D-020. They are re-assessed with D-003 at C03, and they are recorded as such, never as an account-level separation. Criterion 30 is claimed only at this level until then (D-020, "What follows").

- **R1. The account's control surface between DevOS's environments.** This covers starting, steering or messaging sessions, attaching repositories, routines, and other sessions' content.
  - It is kept apart only by S9 and S10, both inside the session and in files DevOS can change. L-119 adds a platform observation for sessions in Accept edits only.
  - During the bridge, the kept tools rest on the guard alone.
  - Any route to the control surface that S9 does not name stays inside R1, with the guard as its layer; EV3 section 2 lists what the documentation does not state.
  - A secret applies in every session in its environment "whoever started it" (EV2:155). So every database and GitHub separation in section 1 holds for a pair only as far as R1 holds. That is row 3's own condition, "while no session can read or set another environment's token or settings" (P:946).
- **R2. Environment settings.**
  - The documented ways to edit them are Batu's environment selector and the Desktop app (EV3:71). Whether a session route exists is not stated.
  - Whether one environment's sessions can read another's settings is not stated either (EV2:95).
  - Under S5, the settings hold nothing readable that grants authority.
- **R3. Account-wide shared items.** These are the GitHub identity and the GitHub App installation (P:812; EV3:107), the connectors, the account skills and the usage limits (D-020 option (a)). S4 keeps them free of anything one environment may hold and another may not. It does not separate them.
- **R4. The platform's own session credentials** may act beyond the session. This is D-019 (a), accepted, and N-109 is closed as a residual, not as a shown result.
- **R5. `devos-kurulum` shares the account until C12** (P:644).
  - It keeps the bridge's kept tools and D-003's right to edit its own guard.
  - S8 line 1 keeps its token out of the audit's binding rights and out of exam records.
  - The rest is D-003's residual, not D-020's.
- **Unchanged by this design.** Separations inside one session rest on declaration (P:708). The platform-side readers stay as the 6.7 row states them (P:731).
- **What (a) changes compared with separate accounts.** R1 and R3, and R4's reach, would otherwise have been kept apart by account. That is itself an inference from documented account scope, not a stated guarantee (D-020 P3). S1 to S8 are the same either way.

## 5. Left out as more than the need

- **Separate accounts, or a Team or Enterprise organization** (D-020 (b) to (e)). Batu chose (a). D-020's `reopen_if` keeps them available.
- **A guard rule set per environment, or an environment marker variable read by the guard.** It would be a new rule family (FR-05 B). S9 removes the control surface from every DevOS environment alike, so nothing is decided per environment. The database already knows the environment from the token.
- **Any trial across environments.** Excluded by FR-05 A, D-017 and W-C01-42 item 5.
- **Accepting audit or exam writes only inside each routine's expected run windows.** It narrows only the timing and would refuse legitimate runs. X1 already shows runs outside the expected ones.
- **A start credential issued per run.** It needs a new component. The start text is already data, used only as a work ID (P:668).
- **A setup script that writes user settings.** User settings are "not read" in cloud sessions [doc: settings, "Settings in cloud sessions", read 2026-10-11; not independently tested].
- **`deniedMcpServers`, `isolatePeerMachines`, `disableRemoteControl`.** They are redundant once the server and `SendMessage` are denied. Whether a repository-level `deniedMcpServers` reaches the session is not stated.
- **A network level of None fixed now for the exam environment.** S6 sets the narrowest level the work needs. Fixing None before C05 knows the exam's needs could refuse legitimate work, and it adds no separation between pairs.
- **Archiving idle environments as a standing measure.** It would also block Batu's legitimate starts. Archiving stays a response (section 3).
- **Canary markers in exam material.** They catch verbatim copies only. S1 keeps the keys out of every repository, and X4 reuses T-75's search.
- **Salted commitments of answer keys; insert-only or write-once stores.** These protect the exam's own integrity (U-8, C05) or the history, not separation between environments. An event per transition already exists (P:623), and X2 makes reads visible.
- **Encrypting exam files.** Nothing exam-secret is in git.
- **Database-side scoring.** It does not cover the sessions that prepare exams, and it adds a function per item type.
- **A GitHub identity per environment.** It costs money and involves Batu's accounts. 7.3 keeps it only if both of its routes fail (P:812), and authority never comes from the GitHub identity (P:707).
- **An outside proctor, statistical methods for reusing held-out sets, fixed rotation.** These are not separation needs, or they cost money. Pass-or-fail feedback to the tested role is already met by `competence_summary` (B:273).

## 6. What the documentation does not state, and the path that does not depend on it

1. **No limit by environment is stated** on what a session can do to the account's other sessions, routines or settings (EV3:78).
   - Path: R1, accepted. S9 removes the tools from DevOS sessions, and X1 and X3 detect.
2. **Whether one environment's sessions can read or set another's variables, secrets or settings** (EV2:95).
   - Path: S5. A secret's value cannot be viewed after saving (documented), and variables hold nothing secret, so reading them grants nothing. Setting them is R1 and R2, and X3 detects a change.
3. **Whether a repository-file deny of the session-tools server applies in an Anthropic-hosted, single-repository session.**
   - Path: it is confirmed by a session listing its own tools (C02; X1 at every registration). If the tools still appear, the guard's default deny (as today) stays the layer, and the record says so under PC-21 item 9.
4. **The server's full tool list, and whether its tools stop at an environment boundary** (EV3 section 2).
   - Path: the bridge's deny list is written from the tools a session observes it has. The server-level target covers tools added later, and the guard denies a tool not on its list.
5. **The mode routine sessions run in** (P:960).
   - Path: deny rules are documented to hold in every mode (permission-modes, read 2026-10-11; not independently tested). The guard's block is mode-independent DevOS code.
6. **Whether the database can take the token from the network secret's header** (a Supabase fact, not read).
   - Path: C02 shows it. Row 3's first branch, an Edge Function gate (P:946), applies if it cannot.
7. **Whether a repository-level `deniedMcpServers` reaches the connectors a cloud host passes in** (platform-settings reader, 2026-10-11).
   - Path: Batu removes the connectors per routine (P:667), and the guard denies connector tools (P:728). X1 records that no connector tool is present.
8. **Whether a session's git operations, as distinct from API requests, are limited to its attached repositories.**
   - Path: S1. Nothing exam-secret is in any repository.
9. **Whether a running session can change its own environment or a routine's environment** (EV3 section 2 item 6).
   - Path: R1. X1 records each registration's role class from its token, and X3 records each routine's environment.
10. **Whether a user settings file written by a setup script is read.**
    - Path: not used (section 5).

## 7. Carried to stages

- **C02 (note N-136).**
  - Deadlines: S5's form before task 3 builds the identity chain; everything else before task 7 creates the three environments and before any session runs in them.
  - S5 as the token form (N-131 decides; row 3's first branch as its fallback).
  - S8's three lines and their tests, in task 4.
  - S9's bridge, through the rule-change route with a checker verdict. First, the installation's own uses of session tools are listed. After the change, a session confirms it by listing its own tools, recorded with PC-21 item 9's claim.
  - Batu's step text for task 7: S5, S6 and S4(d), (e).
  - X1 within T-77.
- **C03 (note N-137).**
  - Deadline: C03's work list, before tests 3 and 5 are written.
  - Test 3 takes every environment as the actor, at DevOS's own layers, and never by acting on another environment:
    - in each environment, the session's own tool list lacks S9's tools;
    - the guard denies them;
    - inbound messages are refused;
    - counterpart: each environment's own routine starts its session.
  - N-130 is closed with S4(c), recorded from the routine configuration.
  - N08 covers S2 and the exam records with the audit token and the `devos_kurulum` token.
  - Test 5 weighs S7's provenance condition with T-81.
  - D-003's re-assessment takes R1 to R5 with D-019 and with X1 to X3's records.
- **C05 (note N-138).**
  - Deadline: C05's start, before task 4 builds the exam setup. The connector point is due before the first exam set is written.
  - S1, S2 (its form), S3 with T-40 and T-42, X2 and X4.
  - The read-only Supabase connector (K-9 item 9, P:430) reads outside `devos_api`. Before the first exam set exists, either its read of the exam schema is closed, or it is removed from the account (Batu's step). C05 chooses after reading Supabase's documentation, which was not read here.
  - The phase-B guard (N-134(1)) adds no session-tool rule.
- **C06 (note N-139).**
  - Deadline: before Batu creates the routines.
  - Each routine: its own environment, `devos` only, connectors removed, and S4(c)'s triggers.
  - N-135(1)'s record carries X3's fields and its comparison, by a method that does not need the tools S9 removes.
- **C12 (note N-140).**
  - Deadline: when `devos-kurulum` closes, or earlier once no DevOS session needs the bridge's kept tools.
  - S9's server-level target replaces the bridge, confirmed by self-observation. If a phase-B need for own-session reading remains, the per-tool form stays, with its reason recorded.
- **Unchanged C01 items.** W-C01-38 (the guard fails closed) and W-C01-39 (row 12) stay as planned. S7 counts as a layer only once W-C01-39 settles row 12.

## 8. Plan text that would need a plan change (named, not changed)

1. 6.3, "How is the token generated?" (P:648), and Section 12 item 1 (P:1221): the token is added as a network secret with the host and header C02 gives, not "pastes the token only into the settings field". This applies once C02 adopts S5; `plan/key_inventory.md` rows 18 to 20 follow as records.
2. The 6.3 environment table (P:639) and B:35: `devos_kurulum`'s "Cannot" (S8 line 1).
3. The 6.3 exam row (P:642: "Exam records, `devos-evals`"); 7.3 (P:812: "kept in `devos-evals`"; "`devos-evals` is connected only to the exam routine"); B:271 ("the content is in `devos-evals`"); N08's `devos-evals` part (C:125). These change to S1.
4. B:273 and N08 (C:125): the exam fact is hidden only from the working environment. This changes to S2.
5. Ek A section 6, items 5 and 6, and "DR04 designs its exam, DR13-G reviews" (A:394–399), set against P:812–813. DR04 works in `devos-calisma` (A:154) and DR13-G in `devos-denetim` (A:306). This changes to S3.
6. 6.4 (P:667): no GitHub trigger on any routine; DevOS's environments are used only by DevOS's sessions; no DevOS environment is a project's environment or the CLI default (S4 (c), (d)).
7. The 6.7 row "The Claude account's control surface" (P:730): add S9's layer and its bridge, with the guard as the second layer, and state D-020's residual.
8. C03 test 3 (P:1008): it names only the working environment as the actor.
9. 5.6 (P:557) and C03 test 5: S7's provenance condition, if C03 adopts it.
10. B 3.24 (B:331) and PC-21 item 5 (P:968): X1's self-observation fields.
11. Appendix C N04, N08 and N17: S8's test extensions.
12. K-9 item 9 (P:430) and the 6.7 row on interactive sessions (P:729): the read-only Supabase connector and the exam schema, in the form C05 chooses.

## 9. Comparison of the two designs

1. **Token form.** Same in both (network secret). A's wording is taken, because it adds the rule that no DevOS credential goes into any variable or setup script.
2. **Exam material.** Same in both (database only). A's wording is taken, because it adds that scoring stays in the exam session and writes go only through `devos_api`.
3. **Exam fact.** A is taken. It keeps the fact out of Work and covers the opener's role class in events, where B only widens the hidden field. A's optional "not needed" reading is dropped, because B:273 already says "cannot see".
4. **Exam preparation and review.** Same substance. A's statement is taken, because it also places U-8's second grading in the exam environment.
5. **Attachments and account-wide items.** A is taken (skills, project memory, Projects), with B's CLI-default point added.
6. **Network level.** B is taken (the narrowest level the work needs). A's fixed None for the exam environment could refuse legitimate work and adds no separation between pairs.
7. **GitHub rule on `main`.** A's layer statement is taken, plus B's provenance condition. The shared GitHub identity leaves N28 covering only the same transaction, so the condition is carried to C03 with T-81.
8. **Database configuration lines.** A is taken (`devos_kurulum`'s "Cannot", the role-class match on claims, registration before a claim). B has none.
9. **Control-surface deny.** B is taken (a per-tool bridge, then the server-level target). A's immediate server-level deny would remove the installation's own-session reading, which its opening check and usage readings need.
10. **Coverage of every mode.** B is taken. It cites that deny rules hold in every permission mode, which matters because routine sessions' mode is unknown; A does not state it.
11. **The guard.** The two agree: no new rule family, and the phase-B form adds no session-tool rule.
12. **Registration detection.** Both are combined: A's registration before a claim, and B's self-observed tools and repositories, which extend P:968.
13. **Exam-read detection.** B's X2 is taken (reads through a claimed exam work item, recorded). A has none.
14. **Configuration record.** B's comparison with an expected configuration kept in `devos` is taken, plus A's point that the record must not need the removed tools.
15. **T-75 again.** A is taken (before each scoring, with the result not counted). B repeats it after each run.
16. **Response after a detection.** A is taken (revoke the token, which raises the epoch; archive). B has none.
17. **Read-only Supabase connector.** A is taken, because it reads outside `devos_api` and must be closed for the exam schema before the first exam set. B does not raise it.
18. **Allowed-flows table.** B's is taken, as the information-flow statement Batu's direction asks for.
19. **Residual.** The two lists are merged. A's R4 (settings read across environments) and R5 (`devos-kurulum`) are joined with B's items, and D-019's closure is reflected.
20. **Left out.** The union of both lists is taken. A's "None" for the exam network is added as left out.
21. **Notes.** B's set of stages is taken (C02, C03, C05, C06, C12). A has no carrier for the bridge's end.
22. **Plan changes.** The union of both lists is taken, plus Appendix C's test rows and K-9 item 9.
