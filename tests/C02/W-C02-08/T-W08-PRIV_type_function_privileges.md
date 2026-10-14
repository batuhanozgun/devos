# T-W08-PRIV · No one but its owner holds a privilege on a type or a function of `devos_private` (in `devos-test`)

Synthetic test data (plan Section 8 item 13): the only objects made are seven planted inside one rolled-back transaction, each named `w08_fixture_*` and commented `SYNTHETIC W-C02-08 fixture of T-W08-PRIV (rolled back)`: the enum types `devos_private.w08_fixture_type_closed`, `_public`, `_anon` and `_default` (one label, `SYNTHETIC W-C02-08`) and the functions `devos_private.w08_fixture_fn_closed()`, `_public()` and `_default()` (each returns 1). Everything else is a read of the catalogue. No personal or business data, no credential.

Written by: test-designer, agent `aba5f66121ca4ad02` (filled by the executor at filing).

**When it was written, and what it is.** It was written after W-C02-08's build was seen: its twelve migrations on branch `claude/c02-w08-apply` at `abe97e5` (merged into `main` at `48da19a`), and CHK-C02-070, verdict (ii), with its condition C2. It observes a property that was already read in `devos`. CHK-C02-070's table (point 4, `devos` column) reports the read-only connector's catalogue read K: non-array types (K:67), 0 usable types (K:73), and functions owner-only (K:74–82). This designer read that verdict, not K itself. The test is added because no route reads `devos-test`'s catalogue: the executor reaches `devos-test` only through the migration job's output. It changes no acceptance condition. W-C02-08 point 4 and CHK-C02-070 C2 stand as written, and this file is the instrument C2 names: "the migration job's output of a merged test".

**Serves.** W-C02-08 point 4, its ✘ look in the catalogue: "no privilege on `devos_private` or its objects for an application role or PUBLIC". This test covers that look's `devos-test` part for types and functions. CHK-C02-070 C2, verbatim: "It is met when raw output from devos-test shows three things: no grantee other than the owner on any non-array type of devos_private; has_type_privilege USAGE false on every type there for public, anon, authenticated, authenticator and service_role; and refuse_change's ACL owner-only. The raw output may come from a read-only catalog read by a route the guard allows, or from the migration job's output of a merged test. How it is shown: a fresh-context verdict reads that output." Appendix B principle 1. W-C02-07's README section 8.1: "No application role has EXECUTE on the owner-only functions (fixed: B:46; EV3:293)". The migrations the rule lives in:
- `20261014170205_w08_append_only_views_access.sql`: `refuse_change`, and EXECUTE revoked on every `devos_private` function;
- `20261014190402_w08_type_privileges.sql`: USAGE revoked on every type that keeps privileges of its own.

This is not an Appendix C test.

**Command.** The file is staged as `tests/C02/W-C02-08/job/w08_priv_types_functions.sql`. The executor copies it byte for byte to `supabase/migrations/tests/w08_priv_types_functions.sql` (W-C02-07's README 5.1 (c); W-C02-08 point 6 (a) to (d) by analogy). The migration job's test step then runs that copy in `devos-test` as `postgres`, with `psql -X -v ON_ERROR_STOP=1 -f supabase/migrations/tests/w08_priv_types_functions.sql`. It passes only on its notice `W08_PRIV_TYPES_FUNCTIONS PASS (`.

The break runs on the throwaway database with W-C02-07's harness: `python3 -I tests/C02/W-C02-07/harness/run_breaks.py --patch tests/C02/W-C02-08/breaks/B-W08P-1_anon_usage_on_decision_status.sql --pg-bin <PostgreSQL 17 bin>`.

**Time added on the critical path.**
- The test itself adds none: it takes seconds in the job and waits on no schedule or limit.
- C2 is met only once the copy is merged and a push run's output is filed. That route is the executor's to state (plan 6.12 item 1; PC-23). The job runs on every push to `main` and every six hours (README 5.1 (c)).

**Interface assumed.**
- The schema `devos_private`.
- The job's role may create objects in that schema, since it owns it (it plants the controls there).
- PostgreSQL 14 or later, for `pg_type.typsubscript`. `devos-test` runs 17.6 (CHK-C02-070, T:1683).
- The roles `anon`, `authenticated`, `authenticator` and `service_role` by name. `public` is PostgreSQL's pseudo-role, which every role belongs to.
- No owner is assumed: each object's owner is read and printed.
- **By design, no type or function of `devos_private` is granted to anyone** (B principle 1; B:46; EV3:293 as README 8.1 cites them). A later item that grants one by design, with its reason, needs this file revised by the test designer. The grant is then listed by name with its reason, as T-W07-5A's `w07_granted_reads` does. The revision comes before that item's first result (README 8), or under ledger rule 3 after one. The builder never makes it.
- `devos_api` is not read: W-C02-09 grants some of its functions to roles by design.

## Where it lives
`tests/C02/W-C02-08/`. The test belongs to W-C02-08 and was written after its build for a condition of its verdict (ii). It is neither one of W-C02-07's tests, which were written before the build, nor one of W-C02-14's. It follows W-C02-07's README sections 1 to 6 by analogy, as `tests/C02/W-C02-14/` does:
- this specification, `T-W08-<ID>_<slug>.md`;
- a staged SQL file, `job/w08_<id>_<slug>.sql`, whose copy goes in `supabase/migrations/tests/`;
- a break patch outside `supabase/migrations/`;
- the verdict line named by the file.

The patch keeps the header `-- w07-break:` and the guard `w07.throwaway`, because that is the only form the harness reads. The harness accepts a test file named by its path from the repository root.

## Cases
Every case's outcome is `ok`, `bad` or `could_not_check` (README section 3). One loop reads every type and every function of `devos_private`, real and planted alike. It takes two readings of each object:
- **(R1) the ACL:** `aclexplode(coalesce(typacl, acldefault('T', typowner)))`, or `aclexplode(coalesce(proacl, acldefault('f', proowner)))` for a function. A grantee other than the owner is listed as `GRANTEE PRIVILEGE`, with `WITH GRANT OPTION` where it applies.
- **(R2) PostgreSQL's own check** for each of the five roles that exists: `has_type_privilege(role, type, 'USAGE')`, or `has_function_privilege(role, function, 'EXECUTE')`.

R1 is not read for a true array type (`typelem <> 0` and `typsubscript = array_subscript_handler`, PostgreSQL's own test). Such a type keeps no privileges of its own: PostgreSQL refuses GRANT and REVOKE on it (0LP01) and checks its element type instead. R2 reads it. R1 is read for every other type, a multirange type and a domain over an array included, since each keeps its own ACL (both observed on 16.15; see "Self-check" 5).

- **PRIV-pre:** `could_not_check` when the schema `devos_private` does not exist. The file then gives COULD NOT CHECK.
- **PRIV-pos (positive control):** the readings see real objects. `ok` when at least one type with privileges of its own and at least one function were seen. Otherwise `could_not_check`, since the checks below would then hold vacuously. The detail gives:
  - the count of types by kind (enum, composite, domain, true array, and so on);
  - the count of types with privileges of their own;
  - the count of true array types;
  - the count and names of the functions.
- **PRIV-tacl:\<type name\>:** one case per real type with privileges of its own (C2's first thing). `ok` when R1 lists no grantee other than the owner, `bad` otherwise. The detail shows the owner, the ACL as stored (or "null (the default …)") and the grantees other than the owner.
- **PRIV-tuse:\<role\>:** one case for each of `public`, `anon`, `authenticated`, `authenticator` and `service_role` (C2's second thing). `ok` when R2 is false for that role on every real type of `devos_private`, arrays included. `bad` names each type R2 is true on. `could_not_check` when the role does not exist, never `ok`.
- **PRIV-facl:\<function signature\>:** one case per real function, today `refuse_change()` (C2's third thing). `ok` when R1 lists no grantee other than the owner.
- **PRIV-fexec:\<role\>:** the same five roles. `ok` when R2 (EXECUTE) is false on every real function of `devos_private`. `could_not_check` when the role does not exist.
- **PRIV-ctl-type-public, -type-anon, -type-default, -function-public, -function-default (negative controls):** synthetic objects planted in `devos_private`, read by the same loop and the same readings.
  - *-public:* closed (below), then USAGE or EXECUTE granted to PUBLIC. It must read bad: R1 lists `PUBLIC USAGE` or `PUBLIC EXECUTE`, and R2 gives `public` the privilege, on the type's array too.
  - *-type-anon:* closed, then USAGE granted to `anon` (the break's form). It must read bad: R1 lists `anon USAGE`, and R2 gives `anon` the privilege, but not `public`, on the type and its array.
  - *-default:* left as created. R1 must list PUBLIC exactly when R2 gives `public` the privilege. Under PostgreSQL's built-in default (a null ACL) both do, and the readings give bad, which exercises `coalesce(…, acldefault(…))`. A database whose default privileges gave a new object no PUBLIC grant would show "not exercised" in the detail.

  A control row is `ok` when the control held, and its detail says "readings: bad". When the control does not hold, the row is `could_not_check`.
- **PRIV-ctl-type-closed, -function-closed (positive controls of the readings):** synthetic objects planted the same way, revoked from PUBLIC and from the four roles where they exist (as the migrations close theirs). Each differs from its *-public* twin only in the one grant. They must read ok: no grantee other than the owner, and no role holds the privilege, on the type's array either. Otherwise `could_not_check`: readings that refuse everything cannot pass the test.
- A plant that cannot be made, or that the loop does not select, makes its control `could_not_check`, with the reason.

**Control pattern chosen:** that of `supabase/migrations/tests/w03_fixture_apply_read.sql`. There, a planted variant run through the same comparison must be red, and "not red as it must be" gives COULD NOT CHECK, never a pass. Here that rule is written as case rows, so the job's output shows each control.

**Expected outcome, fixed before any run:** every case `ok`. At the twelve migrations of `abe97e5` that is 83 cases:

| Cases | Count |
|---|---|
| `PRIV-tacl:*` (the 32 enum types and the 32 row types of 27 tables and 5 views) | 64 |
| `PRIV-tuse:*` | 5 |
| `PRIV-facl:refuse_change()` | 1 |
| `PRIV-fexec:*` | 5 |
| `PRIV-pos` | 1 |
| `PRIV-ctl-*` | 7 |

The count grows with the types and functions that later migrations add to `devos_private`.

## Form C0
| Field | Content |
|---|---|
| **ID and claim** | T-W08-PRIV. In `devos-test`, no privilege on a type or a function of `devos_private` is held by anyone but the object's owner. (1) No grantee but the owner is in the ACL of any type that keeps privileges of its own. (2) USAGE is held on no type, arrays included, and (3) EXECUTE on no function, for `public`, `anon`, `authenticated`, `authenticator` and `service_role`, by PostgreSQL's own check. No grantee but the owner is in any function's ACL. |
| **Failure class rule** | **[Designer's addition: not an Appendix C entry]** A privilege on a type or a function of `devos_private` held by a role other than the object's owner, by any route: PostgreSQL's built-in default left in place (a null ACL: USAGE or EXECUTE to PUBLIC); an explicit grant to PUBLIC or to an application role, with or without grant option; a grant to any other role; a project default privilege applied at creation; or a privilege reached through membership, or because an application role owns the object (R2 shows these). |
| **Examples** | (1) The original finding, CHK-C02-068 C2: USAGE on `devos_private`'s types left at PostgreSQL's default PUBLIC USAGE, which migration `20261014190402` closed. Cases: PRIV-tacl:\* and PRIV-tuse:public; planted as PRIV-ctl-type-default and PRIV-ctl-type-public. (2) A grant to an application role: the break B-W08P-1 (anon on `decision_status`) turns PRIV-tacl:decision_status and PRIV-tuse:anon red; planted as PRIV-ctl-type-anon. (3) A function left at the default PUBLIC EXECUTE, or granted to PUBLIC: PRIV-facl:\* and PRIV-fexec:\*; planted as PRIV-ctl-function-default and PRIV-ctl-function-public. |
| **Negative control** | The five open plants above are made inside the rolled-back transaction, in `devos_private`, as owner. The same loop and the same two readings must give bad on each (the detail says "readings: bad"). The control row is then `ok`, so it never fails the run. If a reading does not give bad, the row is `could_not_check` and the run is COULD NOT CHECK. Nothing stays: the file ends in `rollback`. |
| **Positive control** | PRIV-pos: real objects are seen. Its counts must be above zero, or the run gives COULD NOT CHECK; its detail lists the counts by kind and the function names. PRIV-ctl-type-closed and PRIV-ctl-function-closed are owner-only plants that differ from the *-public* plants only in the one grant, and they must read ok. So the readings are not a check that refuses everything. |
| **Break attempt** | (1) Removed: part of migration `20261014190402_w08_type_privileges.sql`'s closing of the types. USAGE on `devos_private.decision_status` is granted to `anon`, and nothing else changes. (2) Path: `breaks/B-W08P-1_anon_usage_on_decision_status.sql`, applied by W-C02-07's harness on the throwaway database (README 5.2). (3) Red: PRIV-tacl:decision_status and PRIV-tuse:anon, and the file ends in FAIL. Every other case stays as it was. The function rule (migration `20261014170205`'s revocation on `refuse_change`) has no patch here. Its readings are shown to be sensitive in every run by PRIV-ctl-function-public and -default. A second patch is open (see "Not covered" 7). |
| **Stage and environment** | C02. `devos-test`: the migration job's test step, as `postgres`, once the copy is merged. The break runs on the throwaway database (PostgreSQL 17, the projects' major version; README 5.2). The PostgreSQL facts it relies on were all observed in this designer's self-check on 16.15, not on 17 ("Self-check" 1 and 5):
- GRANT on a true array type is refused with 0LP01;
- `has_type_privilege` on an array follows its element type;
- GRANT on a multirange type and on a domain over an array is accepted, and `has_type_privilege` on a multirange reads the multirange's own ACL, not its range type's;
- `has_type_privilege` and `has_function_privilege` accept `public`.

If 17 handled multiranges otherwise, a multirange in `devos_private` would read as bad, a loud error rather than a silent pass. `devos_private` has no multirange today. |
| **Independence level** | Written by the test designer, a fresh-context subagent of type `test-designer` (written by: test-designer, agent `aba5f66121ca4ad02`). It was written after the build was seen: the designer read migrations `20261014170205` and `20261014190402` and CHK-C02-070. Run by the migration job in `devos-test`, whose step log is the output. Assessed by a fresh-context checker that wrote neither this test nor the build, from that raw output (C2: "a fresh-context verdict reads that output"). Shared: model lineage, W-C02-08's migrations and record, CHK-C02-070, and W-C02-07's README. The designer's runs on 16.15 are self-checks, never results. |
| **Evidence layer** | Structural: the catalogue's ACLs and PostgreSQL's privilege functions as they answer in `devos-test`. It does not show what any role can do through a function, anything in `devos`, `devos_api`'s grants, or any content. |
| **Evidence envelope** | README section 4's fields. Fixed before the run: every case `ok`, 83 cases at `abe97e5` (table above); the break's red cases as listed; one transaction, rolled back; statement timeout 60 s. The run records its observation in the job's `dbtests` step log: lines prefixed `w08_priv_types_functions.sql:`, the case table, a notice `W08_PRIV server: PostgreSQL <version>, database <name>, session user <role>, current user <role>, read at <time> UTC`, and the verdict line. Name the run ID, job and step. The raw log is filed under `evidence/C02/raw/` (W-C02-08's record, EV-C02-012). `criterion_version` is the commit that merges this file; it is not an ancestor of W-C02-08's build, which this test follows (above). |

## C2, clause by clause
| CHK-C02-070 C2 (verbatim) | Case IDs | Note |
|---|---|---|
| "no grantee other than the owner on any non-array type of devos_private" | PRIV-tacl:\* (64 today) | Selector: every type except the true array types, the one kind PostgreSQL keeps no privileges for (0LP01). This contains every type `typcategory <> 'A'` selects, multiranges included. It also contains any category-`A` type that is not a true array, such as a domain over an array, which keeps its own ACL: on 16.15 it showed category `A`, no element type, and an accepted GRANT ("Self-check" 5), so `typcategory <> 'A'` alone would miss it. Today `devos_private` has no domain and no multirange, so both selectors give the same 64 types: the self-check's PRIV-pos saw 32 composite, 32 enum and 64 true array. |
| "has_type_privilege USAGE false on every type there for public, anon, authenticated, authenticator and service_role" | PRIV-tuse:public, :anon, :authenticated, :authenticator, :service_role | All 128 types today, arrays included. A missing role is `could_not_check`. |
| "and refuse_change's ACL owner-only" | PRIV-facl:refuse_change() | Every function of `devos_private` is read, so a function a later migration adds is covered. Added, as the task asks: PRIV-fexec:\* (`has_function_privilege` for the same five roles). |
| "The raw output may come … from the migration job's output of a merged test" | the whole file | Each case row, with its ACL or its role list, and the verdict line are printed in the job's step log. |

## Could not check
The file gives COULD NOT CHECK when any of these holds:
- PRIV-pre fails;
- PRIV-pos sees no type with privileges of its own, or no function;
- one of the four named roles does not exist (its PRIV-tuse and PRIV-fexec);
- a plant cannot be made, for example when the job's role cannot create objects in `devos_private`;
- the loop does not select a plant;
- a control does not hold.

A `bad` case makes it FAIL, whatever the controls show. Each COULD NOT CHECK or FAIL raises, so the job's step fails and `go` is not `yes`. Once the file is copied, `devos` then receives no further migration until the cause is fixed (README 5.1 (c)).

## Self-check (not a result; README section 10)
2026-10-14, 20:18:07Z to 20:18:13Z, on the file as staged here. PostgreSQL 16.15 in the session's container, under `unshare -U`, so counts: no (not the projects' 17). The cluster ran from the twelve top-level migrations of `supabase/migrations/` at `abe97e5`, applied as a non-superuser `postgres`. The stand-ins were those of the earlier offline runs (`anon`, `authenticated`, `service_role` NOLOGIN NOINHERIT; `authenticator` LOGIN NOINHERIT and a member of the other three; `postgres` a member of all four). The harness builds its own clusters and stand-ins (README 5.2). Every cluster was removed afterwards. The outcomes above were written in the file and in the patch's header before these runs.
1. The staged file gave `W08_PRIV_TYPES_FUNCTIONS PASS (83/83)`. PRIV-pos read: "the readings saw 128 types of devos_private (32 composite, 32 enum, 64 true array), 64 of them with privileges of their own and 64 true array types, and 1 function(s): refuse_change()". Each open control read bad and each closed one ok.
2. Two scratch mutants outside the repository show that the controls guard the readings:
   - M1, R1 without `coalesce(acldefault)`: COULD NOT CHECK (2 of 83), with PRIV-ctl-type-default and -function-default `could_not_check`.
   - M2, R2 replaced by "nobody holds it": COULD NOT CHECK (5 of 83), with every open control `could_not_check`.
3. With B-W08P-1 applied to the same cluster: FAIL (2 bad, 0 could not check, of 83), with exactly PRIV-tacl:decision_status and PRIV-tuse:anon bad. PRIV-tuse:authenticator stayed `ok`: it is a NOINHERIT member of `anon`.
4. W-C02-07's harness with `--patch` B-W08P-1 gave the verdict "shown": red equal to `expect-red`, positive control PASS, restore PASS, `HARNESS PASS (1/1 breaks shown)`, `counts: no: self-check on 16.15`.
5. A probe on a separate throwaway 16.15 cluster with a synthetic schema of its own, 20:16Z:
   - GRANT on an enum's array type: `0LP01 cannot set privileges of array types`;
   - GRANT USAGE to PUBLIC on a range's multirange type: accepted; after REVOKE on the range itself from PUBLIC, `has_type_privilege('public', …)` read true on the multirange and false on its range;
   - a domain over `text[]`: category `A`, no element type, GRANT accepted.

   This corrected the designer's first selector, which skipped multiranges in R1 on the belief that they follow their range type. That selector was in the file between 20:13Z and 20:16Z, and the self-check of 20:13Z ran on it, with the same outcomes as 1 to 4 (`devos_private` has no multirange). It is superseded, and no result of this test existed then.

## Not covered
1. **`devos_api`'s functions and types.** W-C02-09 grants some of them to roles by design. Their role lists are T-W07-5B's (W-C02-10).
2. **The schema, relations and columns of `devos_private`.** T-W07-5A's 5A-cat-priv and 5A-cat-grantees cover them in `devos-test`. CHK-C02-070 C1 (b) asks for the columns in `devos`.
3. **`devos`.** A pass in `devos-test` closes nothing there (plan Section 8 item 9). `devos` was read through the read-only connector (K, as CHK-C02-070 reports).
4. **Roles other than the five in R2.** R1 sees every grantee, Supabase's own roles included, and flags any that is not the owner. That is stricter than 5A-cat-grantees on relations, which admits `postgres`, `service_role` and `supabase_admin`, because C2 asks for owner-only. Who owns each object is printed but not judged; an application role that owned one would show in PRIV-tuse or PRIV-fexec.
5. **Default privileges for types and functions** (`pg_default_acl` of kinds `T` and `f`) are not a case. Their effect on a new object is caught when a migration adds one, since the test runs on every push. The *-default* controls show what a new object gets in the database tested.
6. **Behaviour.** The test does not show whether a privilege would matter through a function, such as a `devos_api` function that takes a `devos_private` type. This is structural evidence only (plan Section 8 item 10).
7. **A break of the function rule.** Only B-W08P-1, on a type, exists. A patch that grants EXECUTE on `refuse_change` to PUBLIC, with red PRIV-facl:refuse_change() and every PRIV-fexec:\*, is open. Every run's PRIV-ctl-function-* show that the function readings see such grants.
8. **The break on PostgreSQL 17.** It ran only in this designer's self-check on 16.15, which counts: no. Its run on 17 is the prober's (W-C02-13 point 3; W-C02-08 "Not covered" (a)).
9. **W-C02-07's pattern scan** covers `tests/C02/W-C02-07/**`, not this folder. These files hold no token, key, commit hash or credential, but no pattern scan with planted controls was run over them.
