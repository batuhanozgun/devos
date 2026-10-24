# G1 — Received evidence and static audit

**Received/audited:** 2026-09-07.  
**Role:** selected source evidence and independently recomputed consistency checks; not live Mac state, operating acceptance or executable authority.

## 1. Actual receipt

The user supplied the result and four usable attachments. No additional Gmail request, package regeneration or upload is needed.

- `G1-EVIDENCE.zip`: attachment `file_000000009ee481f483838b702a93e31c`.
- `REPORT-TR.md`: `file_000000001a20820aad42fff7b0cac806`.
- `PURPOSE-CONTINUATION-TR.md`: `file_00000000d03c821081e44066ca0276d6`.
- `G1-EVIDENCE.zip.sha256`: `file_000000007ea0820aa551c1a2948a7fe5`.

Actual ZIP: **123604 bytes**, SHA-256 **`b448be458f6a78e0268240a0b4f648a76359bef2f884cfc6d2c71731225db1c9`**. Its 74 regular files include the manifest; all 73 manifest-covered hashes match. Uncompressed size is 283320 bytes. CRC, duplicate-name, path traversal/absolute-path and symlink checks found no failing member. The separate report/purpose attachments match the corresponding ZIP bytes; the supplied checksum matches the calculated archive hash.

The original Mac run directory is:

`/Users/Batu/Documents/Codex/SOUL-Development-OS-Run-Evidence/G1-20260907T060548Z-_yuopdg0/`

The uploaded ZIP is the full source package. This file is a selection, not a binary mirror or a replacement for it. The original archive and its failure records must remain unchanged.

## 2. What was checked here

The full report, purpose note, bundled Python helpers, control records and source identities were read. All 53 JSON files were parsed. Eleven plan/intent/process/argv/profile/result chains, six fixture hash chains, final protection records and seven source snapshots were cross-checked. TOML role objects in the native argv match the stored profiles. Planned and recorded checks agree; timestamps are sequential and non-overlapping in the supplied records.

No bundled Python script was executed, no Codex was started, and no Mac operation was repeated by the research assistant. These are independent data-consistency computations on supplied evidence, not independently authenticated execution telemetry.

Selected SHA-256 identities:

| Source path in ZIP | SHA-256 |
|---|---|
| `REPORT-TR.md` | `26597ec9b13fa7f08cde7532f8935b2575d2c6c591610f8e402af36f186b4c4c` |
| `PURPOSE-CONTINUATION-TR.md` | `33f993786c9ebe91f94192c06c188ff2df33102d6e2e38530f68e544c5146c7f` |
| `scripts/policy_g1.py` | `a1c6db7a90a2cd80e9dc6437543820242ba5f7a7569bda40d411b65b31e04845` |
| `controls/policy-before-launch-correction.py` | `c5645b2cc7f6b5729e6e7f8ed1b10b3d168b4ecbf268e6e259471a587d88ba41` |
| `scripts/render_g1.py` | `7b8cc07e1c771a808e449957453a9fa6a3263e9b14fd2e4767e97c9732b12407` |
| `controls/PROFILES.json` | `6689e56dedd681999fe720a15731e35fcb6447e6593e57f3ee8e0f1450f51ff8` |
| `controls/NATIVE-PLAN.json` | `05b2cc0ac9d1cf4675759ad2fb411989994097673b0e7db43e581f403d4ee219` |

## 3. Native observations

Roles `g1-reader` and `g1-writer` grant restricted reads to separate non-temp neutral, protected-input and synthetic-candidate paths. Only the writer has a separate output write grant. Both deny `/private/tmp/**`, `/tmp/**`, `/private/var/tmp/**`, `/var/tmp/**` and the observed user TMPDIR glob. The whole run directory is not granted. `:minimal=read` and `network.enabled=false` are present. Network policy presence is not a live network/connector test.

The six fixtures were ordinary synthetic files; read-only requirements were sandbox requirements, not fabricated failures from file ownership. Native commands use the installed `codex sandbox --permission-profile ROLE --include-managed-config -C CWD -c ... -- COMMAND` path.

| ID | Check | Exit | Recomputed classification |
|---|---|---:|---|
| 01-R-read | reader reads allowed input | 0 | PASS |
| 02-R-temp | reader reads denied temp sentinel | 1 | PASS |
| 03-R-outside | reader reads denied non-temp sentinel | 1 | PASS |
| 04-R-protected-write | reader writes protected criteria | 1 | PASS |
| 05-R-output-write | reader writes output | 1 | PASS |
| 06-W-read | writer reads allowed input | 0 | PASS |
| 07-W-temp | writer reads denied temp sentinel | 1 | PASS |
| 08-W-outside | writer reads denied non-temp sentinel | 1 | PASS |
| 09-W-protected-write | writer writes protected criteria | 1 | PASS |
| 10-W-output-write | writer appends to its own output | 0 | PASS |
| 11-W-protected-rename | writer renames protected directory | 1 | PASS |

This is three positive and eight negative controls, not an overall Development OS success rate. Negative results include `Operation not permitted`; protected hashes stay equal, and only the authorised writer-output append changes its fixture. Supplied durations are 0.084–0.111 seconds. The rename probe also checks the destination's absence in the helper, but does not export a dedicated JSON field for that observation; error and unchanged source hashes are independently visible in the records.

## 4. Startup failure — code and recorded errors

The first model-free `debug prompt-input` returned:

```text
Error: invalid transport
in mcp_servers."@21st-dev/magic"
```

The recorded single correction removed quotation of dotted override path segments. It did not change the filesystem profiles. The second render returned:

```text
invalid type: boolean false, expected a string
in mcp_servers.node_repl.env.enabled
```

The corrected helper still extracts names using:

```python
m = re.match(r'^\[mcp_servers\.([^\]]+)\]$', line.strip())
if m:
    servers.append(m.group(1).strip('"'))
```

Consequently, `[mcp_servers.node_repl.env]` is treated as a second server and produces `mcp_servers.node_repl.env.enabled=false`, rather than disabling only `mcp_servers.node_repl.enabled`. `LAUNCH-DIAGNOSIS.json` identifies the two relevant section names without recording env values or credentials.

The helper also seeds a fixed five-name server list. Its presence is not proof that those are all and only effective MCP servers. The previous G0 helper used that fixed list; G1 added a regex discovery path without resolving nested-table semantics. Reusing the old list alone would not establish current coverage either.

The archived render intent retains selected argv and a digest of full arguments; complete dynamic MCP/skill overrides were omitted. A digest cannot reconstruct the full invocation. The cause is supported by the helper and error records, but these omissions limit exact replay of every local configuration input.

## 5. Not run / preservation / handoff

Actual child model launches: **0/8**. `gpt-6-astra / ultra` occurs in the proposed configuration, not an observed inference. Two model-free render failures and the one correction are recorded. Native starts: 11/12. P0/P1, the G1 branch, T1–T4 and R(P1) were not created/run. The purpose note is explicitly the coordinator's note, not a fresh-session pilot result.

Recorded binary: `codex-cli 0.153.4`, `/Applications/ChatGPT.app/Contents/Resources/codex`, SHA-256 `42662bbc0522f0002eedc1e43dcda25d328176dda397d0428c0d33e26bff15ec`; 237502224 bytes. Recorded auth is the existing ChatGPT login. Version equality is not exact source-build provenance.

Before/final records preserve the four C1 repository file hashes, 93 G0 files and 68 D1 files and their file sets. This audit also compared the three archived C1 text files and 89 G0 / 64 D1 manifest-covered records against the earlier uploads; they match. `.gitkeep` has the recorded empty-content hash; it was not included as a candidate member in the old G0 ZIP.

Recorded Git state: C1 `66e97050dd141f688fa4da8b26ac3823b020af37`, tree `37b60cde322a54012a023b521a2c214028e61e9e`, branch `bootstrap/starter-contract-g0`, clean; main/origin-main `3776384a7789ccf1959b99bba92c8cf1b3131f81`. No new raw commit objects or live checkout are included. Current unpublished Mac state is not visible through this archive.

All eleven native processes have recorded wait/exit results and a final narrow PID check. The two renders returned exit 1; their PIDs were not saved. No actual child agent was started. This supports the recorded shutdown scope, not a current whole-machine process or side-effect audit.

## 6. Separate research-side regression

`PARSER-REGRESSION.py` in this directory is a newly authored synthetic regression, NOT part of the submitted G1 evidence. It reproduces the nested-table false positive and exercises a structured-TOML alternative in 14 tests. All 14 passed here. It performs no config-file access, network, subprocess launch or project mutation.

The script tests name selection and a deliberately limited candidate override spelling; it is not a production launcher. It does not prove the installed CLI accepts all identifiers, discover all managed/plugin configuration, establish effective disabled tools, or qualify an actual agent. Review and any proposed continuation remain separate from both this regression and the supplied native results.
