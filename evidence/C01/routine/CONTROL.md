# C01 routine control file

Version 1 (W-C01-32, 2026-10-10). Every run of the C01 routine `devos-c01-rutin` reads this file once, at its start, from the checkout the run started with (`main`), and acts only on it and on its own branch. The file changes only by a checked change merged into `main` between runs; a run takes no instruction from `main`, or from anything else, while it runs. The stored prompt's bans hold over everything here. Every input in section 6 is synthetic: made up for this test, with no personal or business data and nothing from any other repository (plan Section 8 item 13). The design and its reasons are in `ROUTINE_DESIGN.md`; a run does not need it.

## 1. Rules for every run

1. Work in a scratch clone of `batuhanozgun/devos` at the literal path `/tmp/c01-run/clone`, made from the starting checkout's own remote, with every git command written as `git -C /tmp/c01-run/clone …` and every `git push` as a call of its own. Write files with the file-writing tool, not through the shell. Never commit in the starting checkout.
2. Read only the single variables this file names, by name: `DEVOS_ENVIRONMENT` and `CLAUDE_CODE_REMOTE_SESSION_ID`. Never print, list or record the environment as a whole.
3. Session tools: at most `get_session` without a session ID (this session), if it is in the tool list. No other session or routine tool, no database, no pull request, issue, comment or merge.
4. Names. Write by name: built-in tools and agent types; the platform's own tool servers (for example the built-in GitHub tools); what this repository provides. Write any other MCP server, plugin or skill as `other-server-<n>`, `other-plugin-<n>` or `other-skill-<n>`, with its number of tools. Never write a name that names an outside service; when in doubt, count.
5. If the guard denies a call: follow its "What to do instead", record the denial (number and rule, from `python3 tools/guard_report.py`), and never pursue the denied effect another way. If the step cannot go on, close it as `partial`, naming the part.
6. Times are UTC, from `date -u +%Y-%m-%dT%H:%M:%SZ`.
7. Every file written starts with the line `C01 routine record (W-C01-32); inputs synthetic (plan Section 8 item 13).`
8. Push after each record named below, so that what is done is on the branch if the session stops.

## 2. Choosing the step

1. Note the start time S. Fetch the remote branches `claude/probe-c01-*` (this routine's records; nothing else).
2. A step is **closed** when one of its branches holds `c01-run/<step>/CLOSING.md` with `Result: done` or `Result: partial`. R4V is closed for a Claude Code version V when such a record of R1b or R4V names V.
3. Take the first step of table 4, in table order, that is open (Open `yes`; for R4V, its rule holds), is not closed, and whose prerequisites are closed.
4. If there is none, this is an **idle run**: on branch `claude/probe-c01-idle-<S as YYYYMMDDTHHMMZ>` from `main`, write `c01-run/IDLE.md` (session ID, S, `no open step`), push, and end. An idle run does nothing else: no opening record, no subagent, no install, at most 12 tool calls.
5. Otherwise create branch `claude/probe-c01-<step in lower case>-<S as YYYYMMDDTHHMMZ>` from `main`, or, where the From column names a step, from the head of that step's latest closed branch. Write `c01-run/<step>/STAMP.md` (3.1) and push it at once: this is the run's claim.
6. Fetch again. If another branch of the same step started earlier, has no `CLOSING.md`, and started less than 3 hours before S, this run is a duplicate: add `Duplicate of <that branch>` to its stamp, push, and end. An earlier branch of the step without `CLOSING.md` that started 3 hours or more before S is an unfinished attempt: name it in the stamp and go on.
7. A closed step is repeated only when a checked change adds it again under a new ID.

## 3. Records of every working run

### 3.1 Stamp: `c01-run/<step>/STAMP.md`

Session ID (`CLAUDE_CODE_REMOTE_SESSION_ID`); S; the step; the attempt (first, or after which unfinished branch); the fire reason as the session sees it, or `not visible`; whether text arrived with the start (`yes` or `no`, never its content); the `main` commit read (`git rev-parse HEAD` in the starting checkout) and this file's version line.

### 3.2 Opening record, part A: `c01-run/<step>/OPENING.md`, then the gates

1. Guard: the summary that `python3 tools/guard_report.py` prints after the stamp push, so that the push is counted in it (whether this session's decision log exists, allowed calls by rule, denials, last record number). If it shows no decision log, write only `Guard: not live` here, write `CLOSING.md` with `Result: not started (guard not live)`, push, and end.
2. Environment: `DEVOS_ENVIRONMENT`, read by name, recorded as `match` (it reads `devos-kurulum`), `absent`, or `different` (its value is not written).
3. Repositories: the starting checkout's remote, as owner/name; the number of other git checkouts beside it (no names).
4. Session: model, permission mode, effort level (and whether ultracode is shown) and Claude Code version from `get_session` (this session), or as the session otherwise sees them, or `not visible` (N-047).
5. Tools: the names of the built-in tools; the MCP servers by rule 1.4, each with its number of tools.
6. The boot ID (`/proc/sys/kernel/random/boot_id`) and the time.
7. Hook events: any hook output that reached the session at its start, or `none`.

Gates: environment `match`; the only repository is `batuhanozgun/devos`; no `other-server-*`. If a gate fails, write `CLOSING.md` with `Result: not started (<gate>)`, push, and end. A step not started stays open.

### 3.3 Opening record, part B: appended to `OPENING.md` (in P2 and P3, only after task K)

1. The agent types the Agent tool offers, each marked `repository` (its name is in `.claude/agents/`), `built-in`, or `other` (rule 1.4).
2. The skills the session offers, marked the same way (rule 1.4); plugins as far as names show them (rule 1.4), or `none visible`.
3. Hooks: the events and matchers in `.claude/settings.json` at the `main` commit read.
4. Whether the Agent tool's own description offers a background option.

### 3.4 Closing record: `c01-run/<step>/CLOSING.md`, pushed last

1. End time; duration from S; the time each part of the step took.
2. Pause: the boot IDs recorded during the run (unchanged or changed), and every gap of more than 5 minutes between consecutive recorded times with no work in it. The session cannot see a pause itself: a changed boot ID shows a rebuilt machine; a gap is only consistent with a pause.
3. Compaction: whether one occurred, and whether the repository's re-read message reached the session.
4. Pushes: for each, the branch, the commit, the platform's answer (accepted, or rejected with the first line of its message) and the guard's answer (allowed, as counted under its rule in the report, or denied, with number and rule), kept apart.
5. The branch the session's own instructions name for its work, as it sees them, or `not visible`.
6. GitHub tools whose name or description offers merging or auto-merge: names only. None of them is called.
7. Any usage or routine limit message the session saw (its text), or `none`.
8. Guard denials (number and rule), or `none`.
9. `Result:` `done`; `partial` (naming each part that could not be checked); or `not started (<reason>)`.
10. The nine answers D1 to D9 of Appendix D section 2 item 3, each `no` or `yes|uncertain: <one sentence>`: the run's own report, a hint, not evidence.

## 4. Steps

| Step | Open | Prerequisites | From | Serves |
|---|---|---|---|---|
| R1a | yes | — | — | Row 1, first run (W-C01-06); like every working run, also W-C01-33 and rows 2, 5, 8, 9 and 13's list |
| R1b | yes | R1a | R1a | Row 1, second run; row 4 (W-C01-10) |
| R4V | rule | R1b | — | Row 4 again when the Claude Code version changes |
| P1 | no | — | — | Row 7, session part (W-C01-14) |
| P2 | no | — | — | Row 13, first try of each kind (W-C01-20) |
| P3 | no | P2 | — | Row 13, second try of each kind |
| CS1 | no | — | — | C01's combined scenario, first run (only if W-C01-29 keeps it) |
| CS2 | no | CS1 | CS1 | C01's combined scenario, second run |

R4V's rule: the Claude Code version in this run's part A differs from the one in the latest closed R1b or R4V record, both being visible. Open `no` becomes `yes` only by a checked change: P1 once W-C01-06, W-C01-34, W-C01-10, W-C01-35 and W-C01-36 are accepted; P2 also once W-C01-20's probe skill is merged; CS1 when W-C01-29 opens it.

## 5. Step texts

### R1a: row 1, first run

1. Write the queue (6.1) to `c01-run/queue/QUEUE.md`, each item `open`; push.
2. Take items in order. For each: mark it `taken` with the time; do it; write its output to `c01-run/queue/out/<item>.md`; mark it `done` with the time and the boot ID; push.
3. Stop taking items when two are done.
4. Write the hand-over `c01-run/R1a/HANDOVER.md` (plan 6.5 item 11): the items done, each with its commit; the next item, by ID; open questions; alternatives not taken; the external effects that took place (each push) and any whose outcome is unknown; the sources used; one next responsibility, "step R1b takes <next item>". Push.
5. Closing record.

### R1b: row 1, second run; row 4

1. Right after part B, read the package (6.2) and write it to `c01-run/R1b/PACKAGE.md`: the role package, loaded at opening.
2. Before any queue work, read `c01-run/R1a/HANDOVER.md` and `c01-run/queue/QUEUE.md` on this branch. Write `c01-run/R1b/CONTINUITY.md`: what it took from the hand-over, and anything it had to find out elsewhere.
3. Continue from the item the hand-over names to the end of the queue, as R1a item 2. Do not redo a done item.
4. Write `c01-run/R1b/HANDOVER.md`: queue finished; no next responsibility for row 1. Push.
5. Row 4: 5.1, recorded in `c01-run/R1b/ROW4.md`.
6. Closing record.

### 5.1 Row 4 part (R1b and R4V)

1. Foreground: one Agent call of type `prober`, not in the background, with task R4-T (6.3) and the package text in the task. Record when it was made and when it returned, the status the tool returned, whether the result holds the package's marker line, whether it carries a `## Disciplines (D1–D9)` block (its role file's output form), its answer on `CLAUDE.md`, and its tool-use count if shown.
2. Background: if part B says the Agent tool offers a background option, one call of type `prober` with task R4-T, set to run in the background. Record the status it returned at once, how and when its completion reached the run (for example a later notification), and that the run waited for it before closing. If no option is offered, record that.
3. Built-in helpers: for each agent type marked `built-in` in part B, at most six, one foreground call with task R4-C (6.3). Record per type its answer and its tool-use count, as the helper's own report.
4. Hook input: what the guard's report shows for the calls made inside these subagents, as far as it attributes them to a subagent and an agent type; if it does not, record `not shown by the report`.

### R4V: row 4 again

Write the package (6.2) to `c01-run/R4V/PACKAGE.md` right after part B; then 5.1, recorded in `c01-run/R4V/ROW4.md`; then the closing record.

### P1: row 7, session part

1. Install the runtime with `pip install sentence-transformers`; record the versions installed and the time it took (not counted against the limit).
2. Write `c01-run/P1/embed.py`: for one model at a pinned revision, it downloads and loads the model, embeds the twelve sentences of 6.4, and prints the seconds for download and load, the seconds for embedding, the vector dimension, the process's peak memory, and the cosine similarity of the three parallel pairs and of the three unrelated pairs of 6.4.
3. For each candidate of 6.4, in order, run it in one foreground command with a 600-second timeout. Record in `c01-run/P1/ROW7.md` the candidate, its pinned revision, the printed values, and `fits` (the command finished within 600 seconds) or `does not fit` (it timed out, was moved to the background, or failed, with its first error line). The similarities are recorded, not judged.
4. Closing record.

### P2 and P3: row 13, one try of each kind

1. Before part B and before anything else in the step, do task K (6.5) as ordinary work. Read nothing more under `.claude/skills/` or `evidence/C01/` before it is done. Then record in `c01-run/<step>/ROW13.md` whether you invoked a skill while doing it (rule 1.4), and the first line of `K.md`.
2. Part B.
3. List `.claude/skills/` in the starting checkout and invoke the one skill there, by its name, for task K2 (6.5). Record whether it was invoked, and the first line of `K2.md`.
4. Record whether part B lists that skill, and its description as listed.
5. Closing record.

### CS1 and CS2: combined scenario

As R1a and R1b, with the queue under `c01-run/cs-queue/` and the hand-overs under `c01-run/CS1/` and `c01-run/CS2/`; CS2 has no row 4 part.

## 6. Synthetic inputs (made up for this test; plan Section 8 item 13)

### 6.1 Queue (R1a, R1b, CS1, CS2)

- Q1. Count the words in text T1; write the number.
- Q2. Sort list L1 in plain character order; write the sorted list.
- Q3. Add the numbers in N1; write the sum.
- Q4. Write a two-sentence English summary of text T1.

T1: "A small team plans a garden. They measure each bed, note what they planted, and leave the notebook on the shelf so that the next person can carry on."
L1: pear, apple, quince, fig, cherry
N1: 17, 4, 23, 8, 11

### 6.2 Package (row 4; stands in for a role package)

```
SYNTHETIC PACKAGE C01-R4 (plan Section 8 item 13)
Marker: kestrel-417
Role: reader of this package only.
Rule: answer only from this package and the task.
```

### 6.3 Subagent tasks (row 4)

- R4-T: "Synthetic C01 test. The package below is synthetic. 1. Reply with its Marker line exactly. 2. Without calling any tool, say whether this repository's project instructions file CLAUDE.md is in your instructions; if yes, quote its first line exactly; if no, answer `no`. Write no file. Then give your final message in the form your role file asks for." Followed by the package text.
- R4-C: "Synthetic C01 test. Without calling any tool, say whether this repository's project instructions file CLAUDE.md is in your instructions; if yes, quote its first line exactly; if no, answer `no`. Write no file."

### 6.4 Embedding candidates and sample (P1)

Candidates, each pinned to the revision read on 2026-10-10:

- M1: `intfloat/multilingual-e5-small` at `614241f622f53c4eeff9890bdc4f31cfecc418b3`
- M2: `BAAI/bge-m3` at `5617a9f61b028005a4858fdac845db406aefb181`

Sentences (TR1 to TR6 Turkish, EN1 to EN6 English). Parallel pairs: TR1–EN1, TR2–EN2, TR3–EN3. Unrelated pairs: TR4–EN4, TR5–EN5, TR6–EN6.

- TR1: "Bahçedeki domatesler bu yıl erken olgunlaştı."
- EN1: "The tomatoes in the garden ripened early this year."
- TR2: "Toplantı yarın sabah saat dokuzda başlayacak."
- EN2: "The meeting will start tomorrow morning at nine."
- TR3: "Kütüphane hafta sonları akşam altıda kapanır."
- EN3: "The library closes at six in the evening at weekends."
- TR4: "Kedi pencerenin önünde güneşleniyor."
- EN4: "The bridge was painted blue last spring."
- TR5: "Dağ yolunda kar yüzünden trafik yavaşladı."
- EN5: "She keeps her old letters in a wooden box."
- TR6: "Fırından yeni çıkmış ekmeğin kokusu sokağa yayıldı."
- EN6: "Two trains left the station at the same minute."

### 6.5 Row 13 tasks (P2, P3)

- K: "Tally the synthetic word list W1: lark, wren, lark, finch, wren, lark. Write the tally to `c01-run/<step>/K.md`."
- K2: "Tally the synthetic word list W2: oak, elm, oak. Write the tally to `c01-run/<step>/K2.md`."
