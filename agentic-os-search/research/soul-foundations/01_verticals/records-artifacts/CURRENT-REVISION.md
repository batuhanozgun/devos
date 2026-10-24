# Records — Current Revision Binding

**Document role:** CURRENT_REVISION_MANIFEST  
**Revision:** `records-foundation-2026-09-01-r2`  
**Purpose:** bind the preferred current reading surfaces to exact repository blobs so derived views cannot silently drift apart.

## Revision rule

This revision is current only while the listed current-surface blobs match these SHA values.

If a current substantive/routing surface changes materially:

1. update all affected derived surfaces;
2. re-run the bounded cold-read/currentness check;
3. update this exact-blob binding;
4. change the revision identifier when the meaning/routing contract materially changes.

Historical/audit/source files are not required to share this revision identifier; their role is classified in `DOCUMENT-STATUS.md`.

This manifest binds **Records-local surfaces only**. Parent project authorization and next responsibility are intentionally not SHA-bound here; read `../../STATE.md` and `../../INDEX.md` for those.

## Status / routing surfaces

| File | Blob SHA |
|---|---|
| `README.md` | `15bedacb37bdc2eda5971cf542a6a387d5ab67a9` |
| `STATE.md` | `941ac8707a18d6e9384707d2165cb9dd5bf317b1` |
| `INDEX.md` | `8df2cb201a35e8cea4e3f51ef0a8777bb802e40c` |
| `DOCUMENT-STATUS.md` | `8d090bf1d82cb3ed67a1ce4f8671f954f6ec9bd3` |
| `synthesis/README.md` | `8588c4a5ed2b6f06b7f18eb1c88e9cf443eed9a3` |
| `synthesis/current/README.md` | `0f54413a9282d026beb2f6d55afb25286d7807fd` |
| `sources/README.md` | `e3e79da6a8b68b137c80647aee3aa87fdffdae69` |

## L0 / L1 / L2

| Layer | File | Blob SHA |
|---|---|---|
| L0 | `KEY.md` | `9050bf3ea76e0b983a1c93f3bafa0c55f15625d6` |
| L1 | `FINDINGS-MAP.md` | `4e020b465fe97dff745ed8c10d3afac55d141124` |
| L2 | `synthesis/RECORDS-VERTICAL-SYNTHESIS.md` | `76fb18f2538aceeccf353a807a777cd1e91c9d3a` |

## L3 — current topic syntheses

| Topic | File | Blob SHA |
|---|---|---|
| object / identity | `synthesis/current/OBJECT-IDENTITY.md` | `64296b4356f842dae49d9e6083766aa0b1ce66b1` |
| preservation closure | `synthesis/current/PRESERVATION-CLOSURE.md` | `bb255435ad69a678326988931b3dd5d4af682810` |
| change / time / standing | `synthesis/current/CHANGE-TIME-STANDING.md` | `bee8197ff3490f94316c1b32cb6df40c1f116017` |
| organisation / retrieval | `synthesis/current/ORGANISATION-RETRIEVAL.md` | `94d5152050bf5cf501e86128c90e802e72f056b8` |
| requirement derivation | `synthesis/current/REQUIREMENT-DERIVATION.md` | `491c40143ede4bba16047796a5d5bd972e2f21f4` |
| mechanism landscape | `synthesis/current/MECHANISM-LANDSCAPE.md` | `9e2fe2fcafe802ec1f8b5be7dbc4d58e531df60c` |
| retention / disposition | `synthesis/current/RETENTION-DISPOSITION.md` | `244adcbd9108e8b0617e4caf8340bf81ddbb4ce3` |
| failure surfaces | `synthesis/current/FAILURE-SURFACES.md` | `73c9f99bfb052b87eb8b576ad8ec4a121248ff74` |
| completeness | `synthesis/current/COMPLETENESS.md` | `0a7add99862bdc054410e9e21b0ee0066aea4952` |

## Bounded residual / deferred records

| File | Blob SHA |
|---|---|
| `OPEN-QUESTIONS.md` | `2634cc4639a8798f8d4f60f73aca76e5621a693d` |
| `DEFERRED-RELATIONS.md` | `caea5a5502e7ade5e1c6bc35dfecdd86e2d7cce5` |

## Interpretation

The SHA binding establishes **which derived view/version is current in this repository revision**. It does not make the view primary evidence or independently verified truth.

The Records-local state records that the completed research has been user-evaluated and is closed for selective recovery. Current parent-level purpose, authorization and next responsibility live only in `../../STATE.md` and `../../INDEX.md`.

If a listed SHA no longer matches the current path, treat this manifest as stale until repaired; do not silently infer that the newer file is part of this revision.
