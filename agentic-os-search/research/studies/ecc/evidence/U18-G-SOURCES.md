# U18-G — Desktop dashboard source ledger

**2026-09-23 · Q08d1 / MR47.** Fixed ECC `8321021c54d670126ce3b2969d5deb880b4b0c2a`. [Note46](../notes/46-DESKTOP-DASHBOARD-DISCOVERY-AND-ACTION-BOUNDARIES.md), [round](../ROUND-U18-G.md), [STATE](../STATE.md). SOURCE OBSERVATION, TARGET CLAIM/INSTRUCTION, TEST SOURCE INSPECTED and conditional INFERENCE. No target execution, E11, GUI/browser/server/terminal/model launch, installation or actual user-configuration mutation.

## Exact sources and actual coverage

Target paths resolve under [the fixed ECC commit](https://github.com/affaan-m/ECC/tree/8321021c54d670126ce3b2969d5deb880b4b0c2a). Ranges are inclusive requested ranges; an oversized final request ends at actual EOF. FULL describes the body, not every dependency or installed behavior.

| Handle | Path | Git blob | Reading and role |
|---|---|---|---|
| GUI | ecc_dashboard.py | b7e3f93f562775958190c0839c4e371bf589cf57 | FULL1–270,271–540,541–810,811–1100/EOF. All loaders/fallbacks, initialization, tabs/details/filter/refresh/path callbacks, terminal/document actions, appearance and main |
| RUNTIME | scripts/lib/ecc_dashboard_runtime.py | 549552466cd4f50bde51f0f33a877ae60c3a5396 | FULL1–280/EOF. Tk-independent maximize fallback, platform-specific terminal argv, path qualification and actual Popen consumer |
| TEST | tests/scripts/ecc-dashboard.test.js | d30146c354316cb7b27d457744662ba3d1bc2688 | FULL1–270/EOF. Python-snippet harness; Linux argv, simulated Windows kwargs, invalid directory and fake-window assertions. INSPECTED, NOT RUN |
| TROUBLE | docs/TROUBLESHOOTING.md | 608a11d27071c577c99751a3865b66f971288e73 | FULL1–190/EOF. Only the dashboard section is load-bearing: Tkinter, browser alternative and full-clone launch requirement. Other provider/security/bug claims are not independently adopted or validated |
| PACKAGE | package.json | 87487a914c0fd739ea62107e7bf9e56b127207a5 | REUSED full same-conversation U18-F1–180/181–470/471–650/EOF. dashboard/dashboard:web scripts and distribution declarations; no new pack result |
| SAMPLE | skills/nanoclaw-repl/SKILL.md | 3d162bb5b0bfe62ad6a13e2cda8440ed6075e6ca | REUSED full U18-F. Concrete same-pin frontmatter-opening example for GUI's description parser, not a new NanoClaw inquiry |
| PACK-TEST | tests/scripts/npm-publish-surface.test.js | 0ca2fc05fb428b479ebad3e8250506023d9aa393 | SELECTED1–160 only. Allowlist construction/comparison and beginning of offline pack test. No full suite/result claim |
| WEB-LEAD | scripts/dashboard-web.js | 5524853bd73fb1881ab47e0cdb217d6a027ed09b | SELECTED1–140 only. HTTP/host/port/root entry, loopback-helper imports, different loaders and MCP/hooks projection lead. Next-source qualification, not complete routes/actions/security inquiry |

Four newly full-read target bodies, two reused full bodies, and two explicitly selected bodies. The former GUI1–100 lead is superseded by the complete GUI read, not independent corroboration. No source code was executed or imported by the research. Current source files, a built package and an installed/runtime UI are different objects.

## Claim-to-chain bindings

1. **Role:** GUI main constructs Tkinter; complete tabs and callbacks provide component browsing, settings, manual refresh and OS/document dispatch. They do not implement agent invocation, installation or Rust/Node work-store supervision. PACKAGE differentiates Python and browser commands. TROUBLE's full-clone requirement prevents inferring a universal plugin/npm GUI availability promise.
2. **Source/fallback:** GUI loaders scan differing finite file/directory shapes and supply hard-coded examples on empty results. Counts and Ready are derived from returned lists without observed/fallback provenance. Generic activation and slash-usage text is not validated against installed host state or the command registry.
3. **Fallback callback counterpart:** load_skills fallback records omit path; on_skill_select accesses it directly. With an empty-root refresh followed by selecting a fallback skill, KeyError follows. TEST imports only RUNTIME and does not exercise this shape mismatch.
4. **Metadata counterpart:** GUI skill description accepts the first nonempty non-heading line; SAMPLE's opening '---' therefore becomes its short description. Agent/command parsing differs; no all-parser equivalence or host misreading is inferred.
5. **Root binding:** browse_path edits the entry, while list data remain from the previous load. Terminal/docs read the current entry. A→B without refresh can show A while targeting B. Refresh replaces lists/tabs/status but not every option set/count/filter; source enumeration is not a current installed-state snapshot.
6. **Terminal controls:** GUI canonicalizes and RUNTIME checks isdir. Windows uses cwd; macOS a separate path argument; Linux a positional argument and quoted expansion in a fixed explicit bash script. Outer Popen does not request shell=True, but an explicit Linux shell still exists. No returned process handle is retained or polled/waited; creation and successful terminal readiness are separate.
7. **Document controls:** fixed document names plus canonical commonpath containment prevent the inspected outside-target form; existence precedes file-URI dispatch. The result of webbrowser.open is ignored. This is useful scoped path handling, not arbitrary immutable filesystem containment or observed reader success.
8. **Test scope:** four runtime-helper definitions compare Linux args, Windows-like kwargs, a missing directory and fake-window calls. No GUI/source/fallback/refresh/launch-completion test is defined in that file. Dangerous-looking fixture text is only an argv value, not an executed command. No global test-absence claim follows.
9. **Separate browser responsibility:** WEB-LEAD introduces HTTP/loopback and helper dependencies rather than sharing the desktop GUI body. Remaining routes/guards/content/actions/test consumers are genuine unread source under Q08d2/U18-H. Q08d1 is the bounded desktop answer; Q08d overall remains PARTIAL.

## Source deductions and boundaries

The fallback/path-key, frontmatter delimiter and A/B refresh counterparts are conditional code-path deductions. No user interaction, lost work, exploit, false live capability or quantified failure rate was observed. The Tkinter import error, directory refusal, path containment and argument separation are useful controls within their scope. No test was run; no E11 exists. Q08d3 retains stronger installed Python/Tk/OS/terminal/browser, parsing/locale/platform, permissions/symlinks/concurrency, complete view/target fidelity and accepted user outcomes.

## Narrow primary external contracts

Checked2026-09-23:

- PY-PROC: https://docs.python.org/3/library/subprocess.html — selected Popen security, poll, wait and returncode sections. Process creation is distinct from observing later termination; direct list arguments do not implicitly request a shell. Used narrowly, not as a guarantee about every external terminal or the explicit bash invocation.
- PY-BROWSER: https://docs.python.org/3/library/webbrowser.html — selected open() contract: boolean launch result and browser/OS dependence. Used to explain the ignored result, not actual document visibility.

The pages displayed Python3.14.7; this is documentation identity, not the ECC runtime. Irrelevant search hits were discarded; the direct official pages supplied the contracts. No external app, package registry, hosted service or operating-system terminal implementation was evaluated.

## Discovery and work provenance

Connected GitHub searches ecc_dashboard_runtime(topn8) and ecc_dashboard.py(topn6), scoped to affaan-m/ECC, returned default-branch bf70150eb2df8070024e5bdf08e4aa08959e2735 leads. These are path discovery only; every new substantive target body above was fetched at the fixed research pin. No exhaustive fixed-pin repository inventory is claimed.

Fresh AGENT/main-ref recovery matched the unchanged router and preceding handoffd50f247d38b5c329b74e524dc460ab3102291a3c. R01–R03 were fully reread with clipped/overlap recovery; full same-conversation R04–R09 and checked project context remained active. MR47 opened63666a6d472b0ead15878997a80c528aa955735f. Activation207061842682b963793c8d0f8eff9fe91a11f816 was fully read back as STATEd21bee6e96298762f004889a352b5287dd7f761c before inquiry. Note46 creation15d840198b8d497d70ee080294c187edc843fa62 does not itself establish checked publication.

No auxiliary working-container source acquisition was attempted in this unit. Historical DNS failures, rejected transfer candidates and corrected publications remain historical. Note46/ledger/MR47 and entries/catalogue/receipt/final STATE must undergo actual correspondence checks. Original Notes01–45, experiments/E06 exclusion/E05 histories/E10 recovery, METHOD/WHY, historical inventories and unrelated project/control sources remain outside mutation. No new branch/PR or upstream change is implied.
