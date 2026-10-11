*Filed verbatim from the practice reader's final report for W-C01-42 (workflow run wf_f172f804-e71, fresh-context subagent of working session session_01XyxvJd3RayQk4HCrjurbVH, 2026-10-11; read only; taken with tools/subagent_audit.py last; DISCIPLINES OK with the tool as W-C01-43 fixed it). EV-C01-004 S1 and section 5 rest on it.*

**Question.** What established practice keeps evaluation and review credible when the evaluated system and its evaluators share infrastructure? Which of these practices fit DevOS at low cost with all three environments in one account (D-020 (a)), and which are more than it needs? This serves W-C01-42 conditions 1 to 3: the order of preference, and calling detection "detection" rather than prevention.

## Disciplines (D1–D9)
D1: yes: The papers guard against test data leaking into model training, while DevOS's risk is a session reading a shared store, so I marked where each practice does and does not carry over and named the one assumption everything rests on (that each environment's credential stays in its own environment).
D2: yes: Batu's choice of (a), his "do not overdo it" and the earlier recommendation of (c) all pulled on the weighing, so I judged fit by need and cost only and did not let detection measures look as if they shrink the residual he accepted.
D3: yes: I kept to a short survey plus a fit judgement mapped to W-C01-42's order of preference, and did not design the structure, which is the executor's work.
D4: yes: The subject is exam credibility, so I kept apart secrecy (withholding answers), integrity (commitments) and detection (canaries), and noted that GitHub's rule against approving your own pull request gives no independence when all environments share one GitHub identity.
D5: yes: I read the full text for GSM1k, BIG-bench and the GPT-4 footnote, and I mark the sources I read only as abstracts or third-party copies.
D6: no
D7: no
D8: yes: I confirmed HEAD is e7717e8 and read D-020, W-C01-42 and plan 6.7, 7.3 and the environment table before the survey.
D9: yes: The research library is not attached in this environment, so I could not consult it; this is listed under Open, and these findings are new outside research with candidate status.

## Findings (all web sources read 2026-10-11)
1. **Withhold the answers (held-out set).**
   - GSM1k was kept unreleased to prevent contamination, with release promised only once set conditions are met. On the public set it measured accuracy drops of up to 8% and signs that some models had partly memorised it (stated; https://arxiv.org/html/2405.00332v4, Introduction, section 3, appendix B).
   - The plan already takes this form: answer keys sit where only the exam credential reaches, and in a Supabase schema readable only by the exam token if `devos-evals` turns out to be reachable (stated; /home/user/devos/plan/DevOS_Kurulum_Plani.md:812).
   - Interpretation: under (a) this is W-C01-42's first preference, "remove the need". It is the only item here that prevents rather than detects.
2. **Do not reuse public items.**
   - Jacovi et al. (EMNLP 2023) advise avoiding test data that appears online with its solution, encrypting published test data with a public key under a licence, and demanding that providers exclude test data from training (stated, abstract only; https://arxiv.org/abs/2305.10160).
   - Fit (inference): writing exam items fresh, never copied from public benchmarks, is cheap and fits, because the shared model may already know public items.
   - Encryption at rest is needed only if exam files must sit in a store the shared GitHub identity reaches. With the keys in Supabase it adds nothing.
   - Training exclusion does not apply: DevOS trains no model.
3. **Canary markers.**
   - BIG-bench puts one unique identifier in every task file, so trainers can filter the data out and anyone can check later whether a model saw it (stated; https://arxiv.org/html/2206.04615, section 2.4).
   - Counter-evidence: the GPT-4 report says parts of BIG-bench were mixed into training by accident anyway (stated; https://arxiv.org/html/2303.08774v6, section 4, footnote 4).
   - Fit (interpretation): a random marker per exam set. It goes only in material the exam environment alone holds (answer keys, grading notes), never in the task text the working environment receives. The exam environment searches other environments' records, branches and pull requests for it at scoring time.
   - This is detection, verbatim matches only, and it holds only if someone runs the search. It must not become a new guard rule (W-C01-42 condition 2).
4. **Commit before, check after.**
   - Preregistration means committing to the analysis steps before the outcomes are known. It guards against presenting hindsight as prediction and against picking results selectively (stated; Nosek et al. 2018, PNAS 115(11):2600–2606, read via https://pmc.ncbi.nlm.nih.gov/articles/PMC5856500/).
   - The plan already requires each pass criterion to be written before the set's first run (stated; /home/user/devos/plan/work/C05.md:42).
   - Fit (inference): before each run, the exam environment records a salted hash of each answer key in an append-only record that other environments can read. The salt is a random value kept with the key, so the hash reveals nothing about short answers. After scoring, anyone can confirm the key was not changed.
   - This protects the key's integrity, not its secrecy. Cost: one field and one check.
5. **Rotation and limited feedback.**
   - LiveBench adds new questions monthly from recent sources and releases them all. It relies on freshness instead of secrecy (stated, abstract; https://arxiv.org/abs/2406.19314v2).
   - Blum and Hardt show that repeatedly checking scores against the same held-out set overfits it. The usual simple remedies are less precise answers and fewer resubmissions (stated; https://arxiv.org/abs/1502.04585).
   - The plan already says sets are renewed regularly and records "learning to the exam" (stated; DevOS_Kurulum_Plani.md:815).
   - Fit (inference): retire an item once its answer has been seen outside the exam environment. Give the tested role pass/fail per exam, not per-item answers. Limit reruns of the same set.
6. **Separation of duties.**
   - NIST: no single user should hold enough privilege to misuse a system alone. The forms are static separation and dynamic separation (the two-person rule) (stated; https://csrc.nist.gov/glossary/term/separation_of_duty).
   - SP 800-53r5 control AC-5 says, among other things, that those who administer access control should not also administer audit (stated, via a third-party copy: https://www.stigviewer.com/controls/nist-800-53/AC-5).
   - GitHub: "Pull request authors cannot approve their own pull requests" (stated; https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/reviewing-changes-in-pull-requests/approving-a-pull-request-with-required-reviews).
   - Interpretation: every DevOS environment acts on GitHub as the same machine account (plan line 812). So GitHub's approval rule keeps no two environments apart. The separation rests on the database checking the environment token (plan line 708), which is already planned.
   - Tension (inference): if the audit environment reviewed live exam sets, it would see the answers. Review retired items only.
7. **Append-only records.**
   - NIST AU-9 requires protecting audit information from unauthorised change and deletion. Its enhancements include write-once media, storage on separate systems, read-only access and dual authorisation (stated, via a third-party copy: https://csf.tools/reference/nist-sp-800-53/r5/au/au-9/).
   - Fit (inference from plan line 706, "agents call only `devos_api` functions"): verdict, commitment and score records are written only by functions that insert and never update or delete. A correction is a new row. The existing backup is the second copy.

## Counter-evidence and alternatives
- Only items 1 and 6 prevent anything. Items 3, 4, 5 and 7 are detection or integrity and must be named that way.
- All of them assume that each environment's credential stays in its own environment inside one account. The documentation does not state this (D-020 P1/P3).
- The literature's threat is training contamination, so it carries over to DevOS only in part.
- None of this replaces the account separation in (c). It makes some breaches visible inside the residual Batu accepted.

## Open
- The research library is not attached here and was not read.
- AC-5 and AU-9 were read from third-party copies, not NIST's own catalogue.
- Jacovi and LiveBench were read as abstracts only.
- Whether each environment's secrets are visible only in that environment is a documentation question for W-C01-42. I did not read it.

## For the decision
Nothing here changes D-020 (a). For W-C01-42:
- **Fits at low cost:**
  - withholding (already planned);
  - freshly written items;
  - database role checks (already planned);
  - a canary search on the exam side;
  - a salted commitment of each answer key;
  - insert-only records;
  - retiring an item once its answer is exposed;
  - pass/fail feedback only.
- **More than the need:**
  - encryption (unless exam files must sit in git);
  - training exclusion;
  - the Ladder algorithm or statistical methods for reusing held-out sets;
  - a fixed monthly rotation;
  - write-once hardware or separate systems;
  - an outside proctor (it costs money).

## Guard denials
- Rule B5 ("no shell writes into guarded directories"): `pdftotext` on the NIST PDF that WebFetch had cached under `~/.claude`. Decision log #1153 in `/tmp/devos-guard/session_01XyxvJd3RayQk4HCrjurbVH.jsonl`. I did not try again on that path and read AC-5 from a web copy instead. I am read-only, so I could not record this with `tools/guard_report.py`; the executor should record it.
