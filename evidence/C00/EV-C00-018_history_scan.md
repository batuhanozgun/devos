# EV-C00-018 · The one-time history scan of `devos` against the research library (N-084)

**What this is.** The record of the scan that plan 0.5 (the second PC-07 note: "When the fingerprints first exist, the whole history of `devos` is scanned once, because earlier sessions read the library") and note N-084 on `plan/work/C00.md` require, with its classification and the executor's decisions. Commit IDs, paths, line numbers and counts only; no matched text, and no service name.

## 1. How it ran

- **Library:** the read-only clone `/home/user/agentic-os-search` at `941f027d3a15497b90e60d752303c0463a9feab5`, attached on 2026-10-06 (D-014, L-155). 2,388,238 fingerprints of 8-word runs, built in memory only: nothing dropped, no file written, the store untouched.
- **Tool:** `python3 -B tools/leak_fingerprints.py history` (PR #179, merged at `e42257a`; judged by CHK-C00-049), which reads every commit as the guard's L1 reads a pushed commit: its message, its paths and the lines it adds against its first parent (a root commit against the empty tree). It ran at about 06:55Z in 19 seconds.
- **Scope** (CHK-C00-049 condition 2): (a) every commit reachable from `main` at `e42257a6792a6d968ef312d588f6e73f490d73b7`, 524 commits, through all parents (`evidence/C00/history_scan/main.txt`, verbatim); (b) every commit outside it that GitHub still publishes: all remote branches and all 178 pull-request heads (`refs/pull/*/head`), fetched into a scratch clone: 103 commits on 54 tips, each tip scanned with `history --rev` and only the commits outside `main` kept (`evidence/C00/history_scan/outside.txt`, the output of a scratchpad script that runs the tool and filters its lines). Not covered: commits that no branch or pull request reaches any more (for example ones replaced by a force push before any pull request was opened); GitHub may still serve them by ID, and nothing lists them.
- **Classification:** a researcher subagent read each reported line and located its run in the library (file names only), and sorted every match into classes A to F (`evidence/C00/history_scan/classification.md`, its final message verbatim).

## 2. How to read the figures (CHK-C00-049 condition 1)

- **(a) Merges.** The 70 commits on `main` with library matches include 34 merge commits, which repeat the matches their branch brought in (a merge is read against its first parent, as L1 reads it); the separate introductions are 36 non-merge commits plus the current tree. Of the 16 commits with service-name matches, 7 are merges (9 introductions). Outside `main`: 12 commits with library matches (10 introductions, 2 merges), 2 with service-name matches.
- **(b) Counts.** Run counts per commit and per file count every occurrence, not distinct runs; the tree line gives both (7,276 runs, 7,223 distinct, equal to the 7,223 runs `build` excluded at 06:03Z).
- **(c) Service names.** The figure counts commits whose message, paths or added lines name a service, not commits whose tree holds a name; so it cannot be set beside D-013's measurement (36 of 461 commits whose tree held a name, OI-012). D-013 is decided (a): the names stay in history (L-156).
- **(d) Blind spot.** As in L1, an 8-word run formed partly by a commit's added lines and partly by unchanged lines is not seen in the history section; the tree section covers that case for the current tree only. Paraphrase is outside any fingerprint check (plan 0.5, the second PC-07 note).

## 3. Result

| Class (classification.md) | What it is | Introductions | On `main` now | Decision (executor, technical) |
|---|---|---|---|---|
| A. Batu's own writing | the twelve `briefs/w-c00-12/BATU_*_TR.md` texts he had written from his own thinking and gave to the builder on 2026-10-02 (the library holds the same texts in its `publications/` folder, as LinkedIn analogy drafts), and the SOUL definition, labelled as his decision in the plan | 15 + tree; about 98.7% of the tree's matching runs | yes | **Stays.** They are his own words, given by him to the builder as input and recorded verbatim, as the ledger's rule 1 allows for his words; the library's copy is his own publications folder, not research content. He was told in one line (D-015 and PC-14: a matter that asks nothing of him is information, not a question); he may object. |
| B. Identifiers | repository, folder and file names, IDs, URLs, commands, label lists | 17 + tree; 5 outside | some | **No change.** Source identifiers are allowed (plan 0.5 item 1). |
| C. Generic code | import lists, idioms of module loading, `subprocess` and `git` | 6 + tree; 5 outside | some | **No change.** Not library content; the false-positive class of note N-090 (C04). |
| D. DevOS's own earlier design text that the library also holds | four lines of the Turkish plan v2.1 and Appendix A in the first commit `333d1b2`; the library keeps copies of earlier DevOS reports | 1 | no | **No change.** DevOS's own text, history only. |
| E. Research content of the library | two short phrases from two library studies, in builder working files of W-C00-12 that are no longer on `main` (`33001df`, `f362e95`, `0616482`; merges `483ca01`, `08459af`) | 3 (2 phrases) | no | **No change, recorded.** The only library research text found in public history: two short phrases, gone from the current tree since `plan/builder/` was retired. Rewriting history for them would break every commit reference in the records while the old commits stay reachable through pull requests and copies (the reasoning of D-013); the risk is small and stated here. |
| F. The adaptation of the library's agent protocols in Appendix D | the Turkish Appendix D v1.1 in `333d1b2` adapted the protocols' wording (history only); one rule sentence still on `main` (Appendix D line 65, quoted in PC-08 and CHK-C00-017) shares about nine words with the library's `AGENT.md` | 4 + tree (8 runs) | one sentence | **No change.** Plan 0.5 makes `agent/protocols` the source of Appendix D ("used through Appendix D"); the adaptation is declared in Appendix D section 1. |

**Service names:** the commit IDs and counts are in `evidence/C00/history_scan/classification.md`; no name and no line number is recorded (N-084). D-013 decided that they stay.

## 4. Who was told, and what follows

- **Batu**, in the working session at about 07:20Z, in Turkish, in one short paragraph: nearly all matches are his own LinkedIn analogy texts, which stay because they are his; two short phrases of research text remain in old records only, not in the current files, and history is not rewritten for them.
- **N-084** is closed by this record. The fingerprint layer's limits that the scan showed (generic code matches, N-090; paraphrase not caught) belong to C04 task 5.
- **Reopen if:** a class E match is found on `main`; Batu objects to his texts being public; the semantic layer of C04 finds paraphrased research content in public records (D-014 premise P7 named earlier sessions' paraphrased summaries).
