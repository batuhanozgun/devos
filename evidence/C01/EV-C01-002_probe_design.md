# EV-C01-002 · C01 probe design: the setup P1 to P3, each probe, N-109's check and Batu's steps

**What this is.** The written design of C01's temporary probe setup, of every
probe named in plan C01, of N-109's credential-reach check, and of the text of
Batu's C01 steps (W-C01-03). It is a design record, not a result: it fixes how
each probe is read before any probe runs and before Batu is asked for anything
(plan C01; working order section 4; plan Section 8 item 6). A fresh-context
checker that did not write it judges it against `plan/work/W-C01-03.md` items 1
to 8, plan C01's "Probe setup", "Platform and guard apart", each named row,
W-C01-15 and N-109.

**Files this record governs** (all under `evidence/C01/`):
- `probe/P3_probe_schema.sql` — the one-off P3 text (synthetic; not the migration path).
- `probe/routine_a_instruction.md`, `probe/routine_b_instruction.md` — the starting instructions.
- `probe/batu_steps_tr.md` — Batu's steps, Turkish, one action each.

**Sources.** The platform facts come from two researchers' reads of the current
official documentation on 2026-10-06, filed by the executor as evidence: the
**setup-facts report** (environments, routines, GitHub access, version, costs)
and the **row 4 documentation report** (subagents and hook input), filed at
`evidence/C01/raw/W-C01-03_setup_facts_report.md` (researcher agent
`a76e19253d3c521a2`) and `evidence/C01/raw/W-C01-09_researcher_report.md`
(agent `a42e1b2b6506713b8`; EV-C01-001). They are
documentation, not observation; every C01 row observes the fact itself. Plan
sources: `plan/DevOS_Kurulum_Plani.md` C01 (rows 1–18, "Probe setup", "Platform
and guard apart"), 5.6, 6.2, 6.3, 6.4, 6.7, 5.6; Section 8 items 9, 13, 14;
Section 12 item 0 and "Key inventory". Records: `plan/work/C01.md` and its notes
N-105/N-109; `plan/work/W-C01-04/05/06/07/08/10/11/12/15/16/19/20/26/29/30.md`;
`plan/decisions/PC-18.md`; `evidence/C00/EV-C00-022_closure_conditions.md`
sections 1 and 1b with `evidence/C00/closure/`; the guard
`.claude/hooks/tool_allowlist.py` (read only); `plan/Installation_Working_Order.md`
section 10; `plan/Ek_E_Iletisim.md` sections 3, 7, 8.

## Disciplines (D1–D9)

D1: yes: I named the load-bearing assumptions (the API credential hides the token; PostgREST forwards a custom request header to a function; the proxy attaches the credential outside the session; a `public`-prefixed schema is fully removable by C02; the daily run limit) and made each a thing a row observes, not a thing the design asserts.
D2: yes: the plan marks the 15-a-day limit and `claude/`-only pushes as checked; I report the documentation's contradiction as a finding instead of reconciling the design toward the plan.
D3: yes: I checked the whole chain for each probe (token issued → attached → database derives the class → the probe records the class, never the token → C02's migration removes it) and that the design serves C01's purpose without narrowing any row.
D4: yes: the design fixes "met / failed / could not check" for every row and the controls (N-109's in-session control; the format-scan positive control at the stage close) before any result exists, so no result adapts the criterion.
D5: yes: I read the plan rows, the guard, PC-18 and EV-C00-022 at the source, and I keep the two research reports marked as documentation views, separate from the observation each row still owes.
D6: yes: I traced why a shallow probe checkout would silently block every push (shallow → the service-name revision 3cd686a is absent → the guard's derivation fails closed), and designed the unshallow-first step to close that cause, not the symptom.
D7: yes: I wrote the design and its files so that W-C01-04, W-C01-05, W-C01-26, W-C01-29 and the checker can act from the records alone, before the probes run.
D8: yes: I read the acceptance block, the plan C01 text, the cited rows and notes, PC-18, EV-C00-022 and the guard before designing, and confirmed the clone is at `main` 4113915.
D9: yes: the task directed that no row needs the library, so I did not open it; the platform facts rest on the two documentation reports (new outside research by others), cited as documentation to be re-checked with their date.

---

## Item 1 — P1: the two probe environments

`devos-probe-a` (stands in for the working environment) and `devos-probe-b`
(stands in for another environment). Each is created by Batu (batu_steps_tr.md
steps 1–2) with:

- **Network access = Full** — the broad internet access the working environment
  will have (plan 6.3; setup-facts report, the documentation page
  `cloud-environments`: the four levels None/Trusted/Full/Custom; Supabase is not
  on the Trusted allow-list, so Full is needed and also lets row 3 test "broad
  network and the token together", plan 6.3's awaiting-verification mark).
- **Its own probe token, in its settings field, and no other secret** (acceptance
  item 1). The token is stored as an **API credential** on the environment —
  Bearer type, a custom header `X-Probe-Token` with the prefix cleared, allowed
  website `cqbzxexxwrrbrlszoseg.supabase.co` (the `devos-test` host) — not as an
  environment variable (executor decision 1; setup-facts report,
  `cloud-environments`: "The key never reaches Claude, the commands it runs, or
  the session's environment variables"; "Anyone who uses the environment can read
  the [environment-variable] values"). The API credential exists only when an
  existing environment is *edited*, so creating the environment and adding the
  token are two actions (steps 1–2 then 6–7). Row 3 still observes whether the
  session can see the token by any route.
- **Non-secret environment variables** `DEVOS_PROBE_C01=1` (the probe-session
  marker, item 7), `PROBE_SUPABASE_URL` and `PROBE_SUPABASE_ANON_KEY` (the
  publishable key is not secret, plan 6.2). These are the only environment
  variables; no secret is placed in an environment variable (PC-18; C00's sixth
  condition).

The project URL is derivable from the ref in plan 6.2
(`https://cqbzxexxwrrbrlszoseg.supabase.co`). The publishable (anon) key: the
read-only Supabase connector returned only the **live** `devos` project
(`evidence/C00/EV-C00-002` row 8), so it is taken as unable to read `devos-test`;
therefore Batu copies the `devos-test` publishable key from the dashboard into
`PROBE_SUPABASE_ANON_KEY` himself (not secret; he handles the value, the builder
never writes it, Appendix E section 6). **Open point:** whether the connector can
select `devos-test` is untested; if it can, the executor reads the key and URL
and need not ask Batu for them.

## Item 2 — P3: the one-off probe text for `devos-test`

In `probe/P3_probe_schema.sql`, synthetic and labelled so, marked not the
migration path (plan 6.2), with the removal statements listed for C02's first
migration (which removes the schema and the token hashes with it).

- **A token check that derives one of two probe role classes from a token's
  hash:** `probe_c01_tokens(token_hash, role_class)` and
  `probe_c01_whoami()`/`probe_c01_role_from_request()`, which hash the incoming
  `X-Probe-Token` header and return `probe_a` or `probe_b`, never the token.
- **A small queue of synthetic work items** (`probe_c01_queue`, 6 rows, every row
  labelled SYNTHETIC per plan Section 8 item 13), with items 5 and 6 reserved
  (`reserved_for = 'combined_scenario'`) and left for C01's combined scenario
  (W-C01-29 item 1); `probe_c01_next_item()`/`probe_c01_complete_item()` hand out
  the rest, so row 1 can run more than one item.
- **The single line per probe environment that shows its token once** (6.3):
  `select public.probe_c01_issue_token('probe_a');` (and `'probe_b'`), run by
  Batu in the SQL editor. It generates the token, stores its hash, returns the
  token this one time. It is not granted to `anon`, so no probe session can mint a
  token.
- **A recognisable token format for scanning** (row 3's fail path): `dvs_probe_`
  + 32 lowercase hex characters, i.e. the regular expression
  `dvs_probe_[0-9a-f]{32}` (equivalently `^dvs_probe_[0-9a-f]{32}$` for a whole
  value). A scan, the public-write leak check and the guard can match it; the
  stage close scans every probe branch and C01 record for it (W-C01-30 point 1).
- **Not the migration path:** C02's first migration removes everything (header and
  foot comments in the SQL).
- **Revoking a probe token before C02** (note N-124 on `plan/work/C01.md`; plan C01
  row 3's fail path, "a token found outside its settings field is revoked and
  renewed"): `select public.probe_c01_revoke_tokens('probe_a');` (or `'probe_b'`),
  run by Batu in the SQL editor only if a token is found outside its settings
  field. It deletes every stored hash of that role class, so the leaked token no
  longer derives a class (`probe_c01_whoami` returns `unknown`), and returns only
  a count. Renewal is the issue line again plus replacing the environment's API
  credential. Not granted to `anon`, so no probe session can revoke or renew; the
  builder cannot either (its Supabase access is read only). A step of Batu's
  beyond Section 12 item 0's wording, taken only on that event: finding F-4
  (`probe/batu_steps_tr.md`, section 4).

**Placement (executor decision 3): `public` with the prefix `probe_c01_`, not a
own schema.** A own schema would need an extra Batu step (exposing it through the
project's API settings for PostgREST); `public` is exposed by default, so the
option with fewer Batu steps. Trade-off: `public` is shared, so access is locked
down: **RLS enabled on every table**, **no RLS policy for `anon`/`authenticated`
and the table grants revoked** (direct reads return nothing), **access only
through SECURITY DEFINER functions with a fixed `search_path = ''`** and
fully-qualified names, and **`execute` granted to `anon` only on the four
functions the probe needs** (`whoami`, `echo_headers`, `next_item`,
`complete_item`), never on `issue_token` or the internal `role_from_request`.
C02 builds DevOS in `devos_private`/`devos_api` (6.2), so nothing of DevOS is in
`public`; a prefixed drop removes the probe schema cleanly.

**Where the URL and publishable key come from:** item 1 and its open point.

## Item 3 — P2: the two probe routines

- **`devos-probe-a`: repository `devos` only;** its instruction
  `routine_a_instruction.md`. **`devos-probe-b`: repositories `devos` and
  `devos-evals`,** as an exam session would have; its instruction
  `routine_b_instruction.md`. `devos-evals` already exists (EV-C00-002 row 3), so
  P2 is built as the plan states; no substitute is needed.
- **Without connectors:** Batu removes every MCP connector from each routine
  (setup-facts report, `routines`: all connected connectors are included by
  default and are removed one by one). **Open point / finding F-1:** whether the
  GitHub connection appears in that list, and what removing it does, is not
  documented; since cloning needs GitHub, the step removes the MCP connectors and
  keeps GitHub. Row 2 records what is listed.
- **Model:** `claude-opus-5-5`, set in the routine's model selector (executor
  decision 4; setup-facts report, `routines`).
- **How each run starts:** by **Run now**, which Batu presses when the executor
  asks (the builder does not open or steer probe sessions), or by a far-future
  schedule as a fallback. **Open point:** whether a routine can be saved with no
  trigger at all is not documented; the fallback is a schedule far in the future
  (setup-facts report, `routines`: minimum interval one hour; a one-off timestamp
  is allowed).
- **Runs planned (kept small; the limit is not used up on purpose, row 5):**
  routine A about 4 runs, routine B about 2 runs, plus 2 more A runs for the
  combined scenario (W-C01-29) — about 8 across C01. Counted against the daily
  routine limit that Batu's own routines share: **finding — the documentation
  gives only hourly caps (30 per routine per hour for Run now, 100/hour per
  account scheduled) and no daily cap, while plan 6.4 assumes 15 a day** (see
  Findings). Row 5 reads the real value; the small plan is safe under either.
- **How each probe session's checkout holds the service-name revision (working
  order section 10).** The guard derives its service-name check from revision
  `3cd686a` and **fails closed on a shallow checkout**; a shallow checkout would
  block every push to the probe branch. A routine clones `devos` fresh from the
  default branch each run (setup-facts report, `routines`); the Anthropic-hosted
  clone depth is not documented, and a shallow or shallow-ish clone would omit
  `3cd686a` (far more than 50 commits behind `main`). So each probe-a run's first
  action is: if `git rev-parse --is-shallow-repository` is `true`, run
  `git fetch --unshallow origin` (a fetch, not a push; the guard allows it and
  runs no leak check on it) before any push. `devos-probe-b` needs no unshallow,
  because a multi-repository session loads no guard (item 6 residual); it records
  the shallow fact as row-9 evidence. Row 9 observes whether the guard runs and
  whether the checkout was shallow.

## Item 4 — each probe row, N-109: target, attempt, record, reading

The row-by-row design is the table below. Common reading rule (plan Section 8
items 2 and 14, fixed here before any result): a part fully observed and recorded
is **met**; a part whose observation matches the fail path is **failed** and takes
that path's plan-change route; a part that cannot be observed is **could not
check**, never met. Where a row asks what the platform itself allows, the attempt
is made only on the named probe target, under the probe-only guard rule
(W-C01-04, item 7 below), and the guard's own answer is recorded apart from the
platform's.

| Row | Probe target | The exact attempt | What the probe records | How it is read |
|---|---|---|---|---|
| 1 Session duration & chunked work | P2 `devos-probe-a`, P3 queue; two runs in a row | Run 1 claims & completes ≥2 queue items; run 2 continues from run 1's hand-over, taking the next item without redoing one | How long each session ran; whether the sandbox paused; that run 2 took up the hand-over's next item; the start/resume/compaction hook events (N-063 D18/U2) | met when all parts recorded; "could not check" for an unobserved part; fail path = raise working-session count from reserve (W-C01-06) |
| 2 Connector barrier | P2 both routines (connectors removed); probe-a under the probe-only rule, probe-b has no guard | One read-only connector tool call (a `list`/`get`/`read`; no service named) | The routine-layer answer (connectors removed → platform refuses) apart from the guard's (rule M1 in probe-a; no guard in probe-b) | met when no connector tool can be called at the routine layer; fail → account-level options to Batu (W-C01-07) |
| 3 Environment token | P1/P3 `devos-probe-a`/`-b` | GET `probe_c01_whoami` (expect the env's class) and `probe_c01_echo_headers` (token present, value never returned); then each route to see the token: read own env vars; `curl -v` of the outbound request; a credential-file read | The class the database derived; for each route, whether the token was visible and the route; the guard's answer on the credential-file route (F4/B8) apart; nothing that is the token or derived | met when the class is right and "cannot see the token by the routes tried" with the routes listed; a route the guard's B7/B8/F4 name but the probe did not try is a gap the checker names; fail paths per row 3 (see W-C01-08) |
| 4 Subagents | P2 (both); documentation part is W-C01-09 | A subagent call via a `.claude/agents/` definition, with a synthetic package loaded at opening | Whether the definitions load; whether the call returns before the subagent finishes and how completion is signalled; what the hook input shows about the subagent and its role; the built-in helpers that do not load `CLAUDE.md`; the Claude Code version | met when all parts recorded; the row 4 documentation report expects a background launch to return before completion — the probe confirms it (W-C01-10) |
| 5 Daily routine limit | P2; read where the platform shows it, with its date | No attempt; read the limit, how runs are counted (incl. whether an API-fire counts), the reset time | The value, counting and reset, each with where read and the date; the probe-run count per day | met when all recorded; if it differs from plan 6.4's "15 a day", update 6.4 (W-C01-12). Documentation already shows hourly caps, no daily cap (finding) |
| 7 Embedding model (session part) | P2 session | Load the candidate multilingual model (named below) and embed one synthetic Turkish + one synthetic English sentence | The model with its revision; the time taken against the limit fixed below | met when it runs within the limit; the Actions part is recorded as moved to C04 task 0 (W-C01-14) |
| 8 Release chain | P2 `devos-probe-a` under the probe-only rule | (a) push a probe commit to a new `devos` branch **outside** `claude/` (`probe-c01-outside-a`; never `main`/an existing branch); (b) enable auto-merge on a probe PR whose merge cannot change `main` or a non-`claude/probe-c01-…` branch | For each: the platform's answer and the guard's answer (B3 for the push, M4 for auto-merge) apart; whether the push created the branch; the documentation of 5.6 and 6.8 with its date | met when both attempts and the documentation are recorded; a default-settings push outside `claude/` that succeeds, or auto-merge blocked for a reason other than a C03 prerequisite, applies the fail path (W-C01-15) |
| 9 Single/multi-repo; the guard | P2: `devos-probe-a` single-repo; `devos-probe-b` = `devos`+`devos-evals` | In probe-a: observe hooks/permission rules apply and the pre-write check runs; the guard denies an unlisted tool, never "ask", and fails closed on a fault (an unreadable command → G0). In probe-b: which repos load and whether `devos`'s hooks/rules load (N-048) | The single-repo guard decisions; the fault result; in probe-b, that no hooks/permission rules load; whether a checkout without `.claude/` runs without the guard (6.7 mark) | met when all recorded; fail paths per row 9 (W-C01-16). Documentation (setup-facts, `settings`) already says a multi-repo session loads no hooks/rules |
| 12 Repository access; git credential | P1/P2 `devos-probe-a` (stands in for working/audit); `devos-evals` attach under the probe-only rule | Attempt to read/attach `devos-evals` by git, the GitHub tools, and `add_repo` (the attach under the probe-only rule, S5 apart); reach `devos-backup` and Batu's other repositories (access only, no names/content); read `devos`'s branch protection without changing it | For each route, reachable or not (platform apart from guard); which credential the git proxy uses (from whether `devos-backup` is reachable); the permission on `devos` and whether the rule of `main` can be changed | met when all recorded; fail paths per row 12 (W-C01-19) |
| 13 Plugin & skill inventory | P2 with a probe skill under `.claude/skills/` (added by W-C01-20, removed by W-C01-29) | List every plugin/skill/subagent/hook loaded; try to trigger the probe skill unprompted, when named, and observe non-loading — each way 3 times | The inventory (no service named; such a name counted not written); whether account-level plugins/skills reach a routine session; whether repo skills load and how they trigger, read from the 3 tries per way | met when all recorded; "reliably" is read from the 3 tries per way; fail paths per row 13 (W-C01-20) |
| 17 Control surface across environments | P1/P2; `devos-probe-a` acts on `devos-probe-b`'s targets only, under the probe-only rule | On `devos-probe-b`'s given ids only: start a session in its env (S2/S3); send/steer a message to its session (S1); create/change/fire its routine (S4/S1); change its environment settings (record "no tool offered" if none) | For each: the platform's answer and the guard's answer apart; this routine session's mode and effort as shown, or "not visible" (answers N-047) | met when all recorded; if the platform allows any, the fail path (frame review before C02; option to Batu) applies (W-C01-11) |
| N-109 Session-credential reach | P1; `devos-probe-a` into the same env and into `devos-probe-b`'s given session, under the probe-only rule | See the N-109 section below | Per credential and reach: the attempt, platform and guard answers apart, the in-session control; outcome only (reached/not/could-not-check), never a value | red/green/neither per N-109 (W-C01-26) |

**The candidate embedding model (row 7), fixed here before the run:** the
multilingual model of plan 5.4; its exact revision is named in W-C01-14's record
from 5.4. **Time limit fixed before the run:** the model loads and embeds the two
synthetic sentences within **120 seconds** in the probe session; a longer time is
a failed part (row 7's fail path: make the model smaller or ingest less often).

**Row 3 needs no new probe-only allowance.** Under the API-credential design the
token is in no environment variable and no file the session can read, and the
proxy attaches the header outside the session, so the guard's standing denials
(B7/B8/F4) on credential reads *are* the guard-layer answer to record, and the
platform-layer answer comes from allowed reads (the env listing, `curl -v`, the
RPC response that returns only the class). So W-C01-04 adds nothing for row 3
beyond the devos-test POST allowance below (shared with row 1).

## Item 5 — N-109: the credential-reach check, written down before it runs

N-109 asks whether the credentials the platform places in every session for its
own channels act **beyond** the session (PC-18; `plan/work/C01.md` N-109). Fixed
here; run by W-C01-26 under the probe-only rule; it does not act on Batu's other
work, and its result is recorded either way.

- **The credentials** (from EV-C00-022 section 1, the probe's output): (i) the
  **messaging token** `CLAUDE_CODE_MESSAGING_TOKEN` with its socket
  `CLAUDE_CODE_MESSAGING_SOCKET`; (ii) the **session token file** named by
  `CLAUDE_SESSION_INGRESS_TOKEN_FILE` with its `SESSION_INGRESS_URL`.
- **Each reach tried, from `devos-probe-a`:** (a) **another session in the same
  environment** — a second `devos-probe-a` session whose id its own branch
  records; (b) **a session in the other probe environment** — the given
  `devos-probe-b` session id (read from `claude/probe-c01-b`, never listed); (c)
  **the account's settings or services** — an attempt whose success changes
  nothing of Batu's: a read-only reach (a list/read, or a self-addressed no-op
  message) through each credential's own channel.
- **For each credential, a control:** the probe's use of that credential in its
  **own** session, by the same route, works — so that "cannot reach" means the
  reach failed, not that the route was dead.
- **The reading, as N-109 fixes it:** **red** = either credential can act beyond
  its session (C00's sixth condition not met under PC-18; C00's acceptance on it
  void; frame review; never settled by a later reading). **Green** = it cannot,
  and every reach is conclusive with its control (input to N-107 on
  `plan/work/C03.md`). **Neither** = a reach that could not be checked, or a
  control that does not show the route works in-session — not green; N-109 stays
  open and goes to a frame review before C02 (never closed as green).
- **No value or content is recorded**, only outcomes; the stage-close scan checks
  the branches (W-C01-30 point 1).

The attempts use the messaging channel and the ingress URL/token, which the guard
denies today (T1 for `SendMessage`/`ListAgents`; B8 for naming the token file or
socket; B6 for a raw socket tool). The probe-only rule lets exactly these named
attempts through, in a probe session, on these targets only (item 7). This is a
new check, not row 17's observation (PC-18 place 5).

## Item 6 — the bounds every probe session keeps

Written into both instructions (routine_a/b_instruction.md). A probe session:
writes only to its `claude/probe-c01-…` branch of `devos` (row 8's two named
attempts excepted — the push to a new branch outside `claude/`, and enabling
auto-merge on the probe PR, a GitHub write but no branch write); never writes a
token, a secret or anything derived from one; never lists, reads or messages the
account's other sessions or routines (it acts on another session or routine only
on an id this design hands it, for rows 17 and N-109, never by listing); reads no
content from Batu's other repositories (row 12 records only reachability, no name
or content); names no service connected to Batu's account; records the model, the
permission mode, the effort and the Claude Code version as shown, and "not
visible" for what is not shown. The builder does not open or steer probe sessions
and reads only their branches.

**Residual (plan C01, P2; executor decision 5).** `devos-probe-b` is a
multi-repository session, which loads no hooks or permission rules (setup-facts
report, `settings`), so neither the guard nor the probe-only rule runs there:
only its instruction and the platform bound it. Its instruction is kept to the
fewest actions the rows need (row 9/N-048, row 2's no-guard counterpart, row 3's
second environment, row 4 in a routine session, and a row-1 continuation
cross-check) and enforces the bounds itself.

## Item 7 — no step enables a paid feature

No step of the setup or any probe turns on a paid feature. The paid switch is
"usage credits" (and fast mode, which needs credits); every step leaves them off
(setup-facts report, the documentation pages `costs`, `fast-mode`, `routines`:
cloud VMs carry no separate compute charge; Full network, API credentials, setup
scripts, Run now and routines carry no stated cost; API credentials are a Pro/Max
plan feature, not a metered one). batu_steps_tr.md states this; the stage close
re-checks every instruction and every `get_session` reading's `isUsingOverage`
(W-C01-30 point 1).

## Item 8 — Batu's steps

In `probe/batu_steps_tr.md`, Turkish, each a single action with what he should
see at its end (Appendix E section 7), asking no value in the chat (section 6),
in three sections: the **setup batch** (W-C01-05: steps 1–9), **row 6's question**
(W-C01-13, asked when it opens its probe issue, with any other pending task, per
Appendix E section 8), and the **removal steps** (W-C01-29). Steps beyond the
wording of plan Section 12 item 0 are marked in the file and listed as findings
F-1 to F-3 (removing only MCP connectors and keeping GitHub; archiving instead of
deleting an environment; deleting on GitHub a branch outside `claude/`) and F-4
(revoking and renewing a probe token, only if one is found outside its settings
field; N-124), routed by working order section 8 before Batu is asked.

---

## The probe-only guard rule (for W-C01-04)

Plan C01, "Platform and guard apart": where a row asks what the platform allows,
the attempt is made on the named target under a probe-only guard rule, and the
guard's own answer is recorded apart. The installation guard denies these
attempts today, so without the rule a probe would see only the guard's answer.

**How the guard tells a probe session apart.** The environment variable
`DEVOS_PROBE_C01=1`, set in both probe environments' settings (item 1), which the
hook reads from its own process environment (`os.environ`). Only an environment's
settings reach the hook's environment, and only Batu edits those; a session
cannot set the hook's environment (that is `.claude/settings.json`, guard rule
F1). A Bash command's inline `DEVOS_PROBE_C01=1` prefix reaches only that
command's subprocess, not the hook, which the platform spawns per tool call. The
rule is scoped to C01 and removed when C01 ends (W-C01-29); no DevOS environment
ever sets the variable. **What could imitate it:** only an environment whose
settings carried the variable — which only Batu sets, which no DevOS environment
has, and which is gone at C01's end. The rule has force only in `devos-probe-a`,
because `devos-probe-b` loads no guard at all (item 6 residual).

**Exactly the attempts it lets through, in a probe session only, on these targets
only (W-C01-04 implements only these):**

1. (rows 1, 3) an outbound POST (curl/WebFetch) to the `devos-test` host
   `cqbzxexxwrrbrlszoseg.supabase.co`, path `/rest/v1/rpc/probe_c01_*` only, so
   the probe can call `probe_c01_next_item`/`probe_c01_complete_item` (VOLATILE →
   POST); guard answer today: B6.
2. (row 2) one connector MCP tool call of a read-only kind (an unlisted `mcp__`
   server); guard answer: M1.
3. (row 8) a `git push` of a commit already on `claude/probe-c01-a` to one named
   new branch of `devos` outside `claude/` (never `main`, never an existing
   branch); guard answer: B3. And `enable_pr_auto_merge` on a probe PR whose merge
   cannot change `main` or a non-`claude/probe-c01-…` branch; guard answer: M4.
4. (row 12) `add_repo` for `batuhanozgun/devos-evals` (the attach route); guard
   answer: S5.
5. (row 17) on `devos-probe-b`'s given ids only: `create_session` in its
   environment (S2/S3); `send_message`/`interrupt_session` to its session (S1);
   `create_trigger`/`update_trigger`/`fire_trigger` on its routine (S4/S1).
6. (N-109) on the same-environment and given `devos-probe-b` session ids only, and
   on the account's settings/services by a no-op/read-only reach: the use of the
   messaging token (its socket) and of the session token file / ingress URL —
   i.e. the specific `SendMessage`/socket and ingress reaches that B8/B6/T1 deny.
7. (decision 8) `claude --version` — a bare version query that uses no account
   credentials; guard answer today: B7. (In `devos-probe-b` the version is read
   with no guard; `get_session` in the working session reports
   `external_metadata.container_cc_version` too.)

**It lets through nothing else**, and keeps denying, even in a probe session:
listing the account's sessions or routines (`ListAgents`, a session-list), any
target other than those named, any credential read other than N-109's named
reaches, and every write outside `claude/probe-c01-…` other than row 8's one named
branch. It logs, for each call it lets through, the guard's own answer without the
rule, apart from the platform's. **Negative controls** (W-C01-04): the same
attempt outside a probe session, or on any other target, is denied; any listing,
reading or messaging of the account's other sessions or routines is denied.
**Break test:** with the rule's code removed, the probe-session cases are denied
again. `plan/Installation_Working_Order.md` section 10 names the rule, that it is
removed when C01 ends, and the residual that a session cannot set the hook's
environment so the marker is not session-forgeable.

**Row 9's fault injection** needs no probe-only allowance: the guard is made to
fail by feeding it an unreadable command (→ G0, fail closed) in the live probe
session, and by its unit tests in `tools/test_tool_allowlist.sh` (a forced
timeout via `DEVOS_CALL_BUDGET`, malformed input); if a live timeout needs the
rule, it is added then under W-C01-04.

## Removal design (executor decision 6; W-C01-29)

The platform cannot delete an environment, only archive it after its API
credentials are deleted (setup-facts report, `cloud-environments`); the git proxy
rejects branch deletions and the guard denies delete pushes (B2). So removal is
written as the platform allows: **delete each probe environment's API credential,
then archive each environment; delete each routine** (batu_steps_tr.md steps
10–12); **the probe-only guard rule and the probe skill are removed by a checked
guard change** (W-C01-29 item 2); **a branch outside `claude/` that row 8's push
created is deleted by Batu on GitHub** (step 13), since no route from the probe
session can delete it. The P3 schema and the token hashes are removed by C02's
first migration, not here.

**Findings routed before W-C01-29 (Section 14; proposed, not made):**
- Plan Section 12 item 0 "deleting the probe environments" and C01's acceptance
  "the probe environments … are removed" → proposed new wording: *"deleting each
  probe environment's API credential, then archiving each probe environment
  (the platform does not delete environments); deleting the two probe routines."*
  C01's "removed" reads as "archived after its credentials are deleted". Its
  meaning and whether it loosens the condition are judged before W-C01-29 runs.
- Row 8's branch outside `claude/`: proposed addition to Section 12 item 0 /
  W-C01-29 — *"if row 8's push created a branch of `devos` outside `claude/`,
  Batu deletes that branch on GitHub"* (the proxy and the guard cannot delete it).

## Findings (plan text the platform facts contradict)

1. **The daily routine limit.** Plan 6.4 ("within the limit of 15 runs a day";
   also Section 13's risk row and row 5) assumes 15/day. The setup-facts report
   (the documentation page `routines`) states only hourly caps (30 per routine per
   hour for Run now, 100/hour per account scheduled, 100/hour API, no overage on
   these) and **no daily cap**, with routine usage drawn from subscription usage.
   The plan's "15 a day" source was a blog post, not a primary doc. *Proposed:*
   the design plans against the hourly caps and shared usage, keeps the run count
   small, and leaves the number to row 5 (W-C01-12), whose fail path updates plan
   6.4 through Section 14; this design asserts no daily number.
2. **`claude/`-only pushes.** Plan 6.3 lists "pushing to `claude/` branches" as an
   authority and plan 5.6 says routines "can push only to branches starting with
   `claude/` [Awaiting verification: C01 #8]". The setup-facts report
   (`cloud-environments`) says the proxy "doesn't limit which branches a push can
   update", and (`routines`) makes `claude/` a *default behaviour*, not an
   enforcement, and "a rule that access can bypass doesn't block a run's push".
   *Proposed:* row 8 observes the default-settings push outside `claude/`
   (W-C01-15); if it succeeds, 5.6's claim is wrong and the missing link is
   redesigned (row 8's fail path) before automatic merging is relied on after C03.
3. **Deleting environments.** As in the removal design above — a plan-change
   finding, proposed not made, judged before W-C01-29.
4. **Branch deletion.** As above — a Batu step on GitHub, a finding beyond Section
   12 item 0.
5. **The guard in two-repository sessions.** The setup-facts report (`settings`)
   says a multi-repository session reads only `enabledPlugins` and
   `extraKnownMarketplaces`, not hooks or permission rules. So `devos-probe-b`
   runs with no guard and no probe-only rule (item 6 residual). This matches the
   plan's own N-048 expectation; the design keeps P2 as the plan states and row 9
   observes exactly it. Residual stated, no plan change.

A smaller conflict: the guard's B7 denies `claude …`, so `claude --version`
(executor decision 8) is denied in `devos-probe-a`; the design adds it to the
probe-only allowance (version query only, no credentials) and also reads the
version from `devos-probe-b` (no guard) and from the working session's
`get_session`.

6. **Revoking a probe token.** Plan C01 row 3's fail path has a token found outside
   its settings field "revoked and renewed", but the plan names no step or means
   for it before C02's first migration (N-124). *Proposed:* the P3 text's
   `probe_c01_revoke_tokens` (item 2) and Batu's conditional steps (finding F-4),
   asked only if a token leaks.

## Open points

- The read-only Supabase connector returned the live `devos` project only
  (EV-C00-002 row 8), so the `devos-test` publishable key and URL are a Batu step
  (not secret, plan 6.2). If the connector can select `devos-test`, the executor
  supplies them instead.
- Whether the GitHub connection appears in a routine's connector list, and what
  removing it does, is not documented (finding F-1); the design removes only MCP
  connectors and keeps GitHub.
- A routine session's permission mode, effort and whether the auto-mode classifier
  acts there are not documented; rows 17 and 11 record them as shown or "not
  visible".
- Whether a routine can be saved with no trigger is not documented; the fallback
  is a far-future schedule.
- Whether a Postgres function can read a custom request header via
  `request.headers` is standard PostgREST behaviour (not from an allowed source);
  row 3 confirms it.
- Whether GitHub auto-merge can be enabled through the proxy is not documented;
  row 8 observes it, and W-C01-15 carries the part to C03 test 5 if C01 cannot
  show it.
- The Anthropic-hosted clone depth is not documented; the probe-a unshallow step
  (item 3) covers a shallow clone, and row 9 records the shallow fact.
