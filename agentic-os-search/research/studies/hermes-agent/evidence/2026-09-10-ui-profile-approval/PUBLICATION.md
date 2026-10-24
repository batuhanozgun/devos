# AP delivery reconciliation and publication

Date: 2026-09-10. Publication base: `634ab66f195130d551d58dfc062639e0feec23fa`. This record closes the known third M3 delivery omission; it is not new HERMES research or an experiment rerun.

## Exact object

Original ZIP `hermes-ui-profile-approval-2026-09-10.zip`: 25054 bytes; SHA-256 `fccfac09b4b104ee46e43eb750fc3d02e62ae7e1ab1a84fe964dd3f361d5dfb2`. CRC check returned no bad member. All 14 entries in DELIVERY-MANIFEST were checked for size, SHA-256 and Git blob; the manifest itself is the fifteenth original file. Evidence manifest entries were also checked through the delivery manifest and file identities.

The 15 files retain their ZIP-relative layout under `original/`. Local tree `afbe1e767ddaf7e570b72197c7300d20d91f21d4` equals the GitHub-created and recursively read-back tree (`truncated:false`). The evidence subtree is `aff95fa6b5970134c005812a7c0ae396124eb7d5`. These are transfer checks, not correctness or behavior verification.

## Three distinct records, one overlapping mechanism

| Record | Original run UTC | Cases | Canonical location |
|---|---|---|---|
| UI/A | 2026-09-10T05:42:55.258536+00:00 | A01–A08 | `../2026-09-10-ui-profile/` |
| M3-S/SA | 2026-09-10T05:12:08.954654+00:00 | SA01–SA08 | `../2026-09-10-pending-caller/` |
| AP | 2026-09-10T05:40:37.183963+00:00 | AP01–AP06 | `original/evidence/` |

All use slash_access.py blob `07204201e411f29f912bb9bba6beec0566acab9d`, 5666 bytes. The test scripts, cases and outputs differ. Common observations include disabled gate without admins, command-family granularity, administrator scope and DM command fallback. AP06 distinguishes a missing principal from missing policy; AP03 checks the literal `memory approve` entry against canonical `memory`. SA additionally records profile-only/config sensitivity and empty chat_type. A additionally records an always-allow semantic mutant. That mutant is not attributed to AP or SA.

The counts are not added into a product PASS score, coverage percentage or independent replications. AP imports one actual upstream module with synthetic config/source/user values. It does not run real ingress, CLI/gateway pending handlers, profile routing, memory mutation or requests. All previous experiments retain their original scope.

## What was missing and what this repairs

At base `634ab66`, UI/A and M3-S/SA were present. AP result blob `45b0c836ff19d3bc73df5bbfd4bbde27f114e97f` was absent from the complete returned HERMES tree. The previous broad statement that every delivery had been reconciled exceeded that evidence. This publication retains AP rather than substituting similar findings or rewriting history.

A create_tree request referencing not-yet-existing AP blobs returned GitHub 422 (`not a valid blob`). The missing content was then uploaded through create_blob/create_tree, and exact tree equality was obtained. This is a distinct object-existence error, not the historical `Resource not found` tool-binding error. No cause of those earlier errors is established here; no permission or application setting was changed.

The original draft 12 is not promoted over notes 12/13. It stays under `original/`. New note 14 and the current package routers identify AP. Old NOT PUBLISHED/v0.9 statements describe the original delivery, not current work. Previous evidence directories are untouched. Final main publication still requires commit/ref and file readback; the containing commit history identifies the publication.
