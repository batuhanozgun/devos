Checker package (installation helper; W-C02-23)
Precedence: `.claude/agents/checker.md` and `CLAUDE.md` bind; this package informs and never overrides them. Where the two differ, the role file holds, and the difference goes to the executor as a finding. It adds methods and recorded cases only; the role file's rules are not repeated here.

**[1] Methods (how, beyond what the role file requires)**
- M1 Size before reading. Before any deep read, decide which failure classes in [2] are live for this target. If none is, a short check is the right depth; say which classes you ruled out and why.
- M2 Which error turns it red? Ask it of every check you plan. A check that no plausible defect would turn red is not evidence: drop it, or state what it does show.
- M3 Pin the run. Next to each run write the interpreter and git versions, and confirm `git rev-parse --is-shallow-repository` says false: a shallow clone hides the ancestry that a gate or a revert check reads.
- M4 Own breaks. One local commit per break in the scratch clone, reset after each; each break names the defect it models and the rule ID or test that must turn red. A red shows sensitivity to that one defect only; say so.
- M5 Over-blocking. For every gate or deny rule, run the sound case that must pass: a correct task, a minimal route, a records-only change, the revert route. A rule that blocks needed work is a defect of the same weight as a hole.
- M6 Product-only question. Can a reader holding only this target and its binding texts act correctly at its first step? Write those findings before you open the design texts.
- M7 Re-read the ground. For each cited ID, check that it resolves at the target revision and that the cited place shows what it is cited for; an ID that resolves to something else is a finding, not a pass.
- M8 Anchoring. Write your own pass down before you read a triage, the producer's rationale or an earlier verdict, and give in `read:` when you read each, so the order can be checked. EV-C02-021 names this class FC8; no case is recorded yet.
- M9 Conditions. Write the observation that would show a condition met, never the fix's wording; check each line against the condition grammar before you hand over. Write the conditions markers even with `conditions: none`, and leave them empty (CHK-C02-127 R1-9 found the template silent on this).
- M10 Claim scope. Name what the evidence does not show: loaded, read or used; another environment; a later head.

**[2] Known failure classes, each with its recorded case**
Numbering follows EV-C02-021 and CHK-C02-127, so that "FC9" in a task means the same class here; FC8 is method M8.
- FC1 D9 "no" by default; Ek A 3.2 (c) not asked. Case: CHK-C02-075 answered "D9: no" with no library clone; 235 of 242 D9 lines said "no" (EV-C02-020 section 4 (3)). Ask: did the work touch an area of my map?
- FC2 Full depth everywhere; record nits made blocking. Case: CHK-C02-079 K1, a filing condition on the verdict's own filing; L-426 (5). Ask: what real step does this condition block?
- FC3 A weak proxy made binding without naming its weakness. Case: CHK-C02-115 C4, a passive 24-hour window; N-314; L-426 (6). Ask: does it discriminate, and is a stronger check available now?
- FC4 An offline green taken for the counted environment. Case: CHK-C02-113 ran "all offline" with the interpreter unnamed; the job's Python 3.12 then failed (L-415). Ask: which environment counts, and did I run there?
- FC5 Multiplicity taken for independence. Case: CHK-C02-045 and CHK-C01-112 aggregated same-model lens splits. Ask: what does the second view not share with the first?
- FC6 Causal depth stops at the artefact. Case: a test-to-build mismatch recurred about eight times while the loop limit counted only FAILs (EV-C02-020 section 4). Ask: has this class recurred? Name it.
- FC7 Writing the product by proxy. Case: CHK-C02-115 C5 and CHK-C02-117 Q2 dictated wording. Ask: does my condition name an observation or a text?
- FC9 Judging under the text being judged: your own role's package, or a role file the target changes. Case: EV-C02-021, the round that named FC9; CHK-C02-127 declares it. Ask: does the target change my own file or package? Declare it in the verdict.
- FC10 A format gate's green taken for fitness. Case: CHK-C02-127 R2-2: the condition limited its script to form, so the meaning had to be carried by a reading. Ask: which part of the claim does only a reading carry?

**[3] Examples from this installation**
- Good: CHK-C00-033 F3. The checker's own planted commits (control bytes in a commit message, a binary before a secret file) showed the leak check's parser dropping files; it named the cause and the negative tests and left the fix to the producer.
- Good: CHK-C02-127. Four own breaks on the real head, each red with its own check ID; two readings kept apart; the claim limited to "present and fit as text"; a guard denial recorded, not worked around (R2-14).
- Bad: CHK-C02-115 C4. Exact and careful, but it made a passive window binding, and the wait that followed added little (N-314; L-421 to L-425, corrected by L-426 (6)).
- Why it is bad: it never asked whether the window could tell a working mechanism from a broken one, or whether a stronger check was available at once, so a long wait became a blocking condition with no evidence that it would discriminate.

**[4] Tools and limits**
- Bash for reads and test runs: `python3 -I` scripts, `bash tools/test_tool_allowlist.sh`, `python3 tools/test_merge_gate.py`, `python3 tools/leak_fingerprints.py scan <file>` (line numbers only, never the text).
- `python3 -I tools/subagent_audit.py calls <agent id>` runs from a checker subagent (observed 2026-10-20). It prints paths for Read, Write and Edit calls and only the input keys for Bash, so a file written by a script is not traced: list such paths as untraced.
- The guard matches some command-line tool names inside command text: a read-only heredoc that held the GitHub command line's short name was denied (B7). Keep such names out of text you pass to Bash.
- Scratch clone: a full clone under your scratch directory, literal paths, no shell variables (a variable in a path was denied: CHK-C02-127 R2-14, B5).
- When the task's budget cannot cover the floor, name the floor item left unmet in `unsure:`; never thin it silently.
- What you write in `own_breaks:` is the only record that the breaks ran: give each command and its result.
