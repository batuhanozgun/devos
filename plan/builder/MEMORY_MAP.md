# Builder memory map: the one home of every record family

**Status:** see `plan/ledger.md`, Governing documents. **Scope:** installation only. **What it is:** the home table of `plan/builder/design/02_memory.md` §3, moved here byte-identical in tranche 1c so that it has one home (M-R1). Both roots of the root chain point here (`02_memory.md` §4, M-R18): `CLAUDE.md` names this file, and `tools/boot_map` prints this table at every session start. `tools/check_records.py chain` reads it (M-R4). Boot order: `CLAUDE.md`, then `plan/Builder_Operating_Model.md` §3.1.

Each fact kind has exactly one authoritative home. Everything else points to it or is generated from it (`02_memory.md` §6).

| Family | ID pattern | Authoritative home | Form | Ek B family at C02 |
|---|---|---|---|---|
| Work item | `W-<stage>-nn` (children `W-<stage>-nn.m`) | `plan/work/<ID>.md` | front matter + body: the acceptance block (verbatim, with dated changes), open notes, history | Work, WorkStanding, Relation |
| Open note | `N-nnn` | the file of the work item it concerns (§3, M-R3) | a block inside the item | Need, Inquiry |
| Decision | `D-nnn`, `PC-nn`, `K<n>`, `B<n>`, frame reviews `FR-nn` | `plan/decisions/<ID>.md` | front matter + Batu's words verbatim + interpretation + conditions and reopen triggers | Decision |
| Evidence and test result | `EV-…`, `T-…`, `P-…`, `R-…` | `evidence/<stage>/…` (unchanged) | one file per claim; pre-registration before the result | Review, Verdict, Observation |
| Log entry | `L-nnn` | `plan/ledger/<stage>-log.md` (unchanged, append-only) | an entry + a **Record changes** block (§5) | Event |
| Failure pattern (heritage) | `FP-nn` | `plan/builder/heritage/FAILURE_PATTERNS.md` | lens, question to ask, source entries, status `candidate` or `qualified`, `qualified_by` | Learning |
| Premise | `BP-nn` | the premise table of the governing builder document | origin, status, from-scratch test | Premise |
| Governing document status | — | `plan/ledger.md`, section "Governing documents", only | one row per document: path, version, status, accepted by | Release |
| Owned session and routine IDs | session, trigger and reminder IDs | `.claude/hooks/owned_ids.txt`, written only by the recorder hook | append-only lines | SessionRecord, LaunchRecord |
| Current state | — | `plan/ledger.md` §1: stage, run lock, usage, waiting for Batu, the issue cursor (`answers seen through`), `summary_tr` | short table | live state in the database from C02 |
