# U01-B local probes — pre-execution SPEC

Date: 2026-09-12. Status at creation: specified, not run.

## Targets and exclusions

Study the published TerminalBench optimizer's result parsing/selection and selected agent's environment-snapshot formation. This is not a live Harbor, model, remote sandbox or paper reproduction. No credentials, dependency installation or upstream quick-start execution. Only standard-library Python, native source excerpts copied from exact pinned GitHub reads, and a byte-verified shell wrapper run against a fake `uv` command in an isolated temporary directory. No upstream module-level imports or `.env` from the real project are executed.

Source pins: framework 0cbc31e97c9e6d24232d1dc754827c02e1ec415c; selected artifact 57fefdb2ff84af3fd81b69d67814acbe69bd0743. Source parent identities and exact selected functions/ranges must be recorded before running. Excerpt execution is not whole-file identity verification. Record any copying or setup correction separately from source behavior.

## Questions, fixtures and predeclared observations

B01: Parse two expected synthetic tasks, two trials each. Reward-one plus existing missing/corrupt trial files must produce zeros for those existing directories. Compare to an external four-attempt manifest; the implementation knows only directories.
B02: Remove one expected trial directory and then an entire expected task. Record returned population, warnings and average against that same four-attempt manifest. The claim under test is whether absent directories are counted, not whether all real Harbor jobs omit them.
B03: Supply extra trial directories, a stale top-level result, positive fractional rewards, and non-dict JSON. Record whether extra attempts are included, top-level score ignored, reward>0 converted to success, and unsupported schemas rejected or crash. No universal result-schema validity is inferred.
B04: Run native frontier update and summary writer with a prior score 0.60 and candidate 0.75. Independently check that persisted delta uses the pre- or post-update comparator. Retest same name with a worse score; record historical best retention and identity carried.
B05: Feed partial stdout to native `_gather_env_snapshot`: `@@PWD@@`, a directory, `@@LS@@` and no listing; use nonzero return_code. Record empty-label and omitted-section behavior, and capture actual exec command/timeouts without executing that command.
B06: Give no session, raised exec error, fully formed stdout, and >25 listing lines. Record fallback, successful parse and truncation. Returned output is not proof of actual capability or first model consumption.
B07: Run exact shell wrapper with fake `uv` capturing argv/environment. Test default parameters, an isolated local `.env` overriding inherited HARBOR_MODEL, and invalid environment. Mock uv prevents validation/Harbor/model work; this probes shell assembly/precedence only.
B08: Execute the snapshot's exact compound command under Bash in a temporary cwd with PATH-only fake `ls` returning failure. No real diagnostic programs are allowed in PATH. Record whether later sections execute and whether final `|| true` makes exit zero. This tests shell short-circuit, not a real container's properties.

## Negative controls and oracle limits

Use deliberate local source mutations ONLY in memory to ensure selected probes detect changed semantics: missing-result default changed to one; threshold `r > 0` changed to `r >= 0`; source comparator changed from post-update to predeclared 0.60; incomplete LS label suppressed; shell `.env` sourcing removed. Record which assertion each mutation breaks; do not sum these as product-quality tests. Guards may be simpler than full behavioral validators and must be described as such.

All fixtures are authored here and synthetic; source expectations are chosen after reading source, so findings are source-informed diagnostics, not blinded confirmatory replication. No threshold tuning after outcomes. Do not call a same-model second run independent verification.

## Outputs

Store executable probe, native excerpts with exact provenance, result JSON, negative-control outcomes and content hashes. Re-run to check deterministic observations with runtime/timestamps excluded from equality checks. Preserve failed attempts if any. Do not modify upstream, Foundation, other studies or agent-control.
