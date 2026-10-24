# E05 — Config protection decision-chain probe

Prepared before execution for U06-A on 2026-09-18. Target pin: `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`.

## Question and evidence boundary

What does the original config-protection hook decide when invoked by its original profile-aware runner? Does a refusal on an incomplete payload imply every unavailable/invalid check fails closed? Does a path-based guard establish protection of all aliases of the same file?

Execute exact copies of config-protection.js, run-with-flags.js, hook-flags.js and pretooluse-visible-output.js, verified against Git blob IDs before and after. Source bytes were recovered from full GitHub connector text after auxiliary raw-network DNS failure. No rewritten target logic, mocked target dependencies or package installation. Temporary files and symlinks exist only under the probe's own temporary directory. No actual Write/Edit tool is invoked and no proposed content is applied. This measures exit/stdout/stderr decisions, not host enforcement, a bypass incident, operator authentication or protection against every writer.

## Predeclared cases

| ID | Fixture / expected original-runner result |
|---|---|
| C00 | Ordinary source path: exit 0 with unchanged raw input |
| C01 | Existing protected file, same proposed bytes: exit 2 |
| C02 | Same file, stronger rule proposal: exit 2; guard does not inspect semantic intent |
| C03 | Absent protected filename: exit 0 |
| C04 | Protected filename is a dangling symlink: exit 2 |
| C05 | Unprotected alias symlink resolves to C01's existing protected file: exit 0; no actual write is performed |
| C06 | Protected filename under a regular-file parent, lstat ENOTDIR: exit 2 |
| C07 | Malformed JSON below size limit: exit 0, parser supplies empty object |
| C08 | Truthy non-string file_path: exit 0 with run-error diagnostic from wrapper |
| C09 | Valid JSON exceeding runner size cap: exit 2, empty stdout |
| C10 | Existing protected target, minimal profile: exit 0 |
| C11 | Existing protected target, hooks explicitly disabled: exit 0 |
| C12 | Existing protected target, dry-run: exit 0 plus preview |
| C13 | Managed hook config selects minimal, no explicit profile: exit 0 |
| C14 | Explicit standard profile overrides managed minimal: exit 2 |

Record exact input/environment overrides, child stdout/stderr/status, fixture path identity and source hashes. For C05, record realpath/inode equality without writing via the alias. Record symlink capability failures as failures/limitations, not passing cases. Preserve unexpected results. No post-result change of expectations. Match counts characterize predicates, not product security quality. Source-only bootstrap, host timeout, other hooks, shell writers, approval/admission and concurrency remain untested. Earlier E01–E04 are not rerun.
