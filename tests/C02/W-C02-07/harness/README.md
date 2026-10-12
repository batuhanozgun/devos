# W-C02-07's break harness

Synthetic test data (plan Section 8 item 13): the harness builds throwaway PostgreSQL clusters, writes only synthetic data into them (the tests' fixtures, labelled in each file), and deletes them after each run. It holds no credential of any kind.

**What it is for.** Plan Section 8 item 3 as PC-42 place 3 words it: "A database rule is broken on a throwaway PostgreSQL database built for the run from `supabase/migrations/`, of the projects' major version, never on `devos-test` or `devos`". It runs every break patch under `tests/C02/W-C02-07/breaks/` (all four groups'), W-C02-03's breaks B1 to B4 (`--w03`; T-W03-06 and T-W03-07 name "W-C02-07's break harness"), and its own canary. W-C02-13's prober runs it (W-C02-13 point 3); the test designers use it for self-checks, which are never results (README 10). Owner: Group B (`GROUPS.md` section 2).

**Command.**
```
python3 -I tests/C02/W-C02-07/harness/run_breaks.py --pg-bin <PostgreSQL 17 bin directory> [--patch <file>]... [--w03]
python3 -I tests/C02/W-C02-07/harness/run_breaks.py --canary --pg-bin <bin directory>
```
Run it as a user other than root (initdb refuses root), or as root with `--os-user <user>`. Without `--patch`, every `breaks/B-*.sql` is run. Python standard library only. It needs the server, `initdb`, `pg_ctl` and `psql` of one PostgreSQL version 14 or later (for the abstract socket).

## How a run goes (README 5.2)

For each patch, three fresh clusters, each built the same way:
1. `initdb` with a local superuser `w07_superuser` and trust authentication; the server starts with `listen_addresses = ''` (no TCP) on a Linux abstract-namespace socket whose name is random, so no file path and nothing outside this run can be reached.
2. **Stand-ins** for what Supabase supplies and the migrations use (N-244 item (2)), listed here since the run's output does not repeat them: the roles `anon`, `authenticated`, `authenticator` and `service_role` without login; a login `postgres` that is **not** a superuser (as Supabase's), with `createdb` and `createrole`, a member of the four roles; a database `w07_throwaway` owned by `postgres`, with the settings `w07.throwaway = 'yes'` and `w03.throwaway = 'yes'`; the schema `extensions` with `pgcrypto` where the server has it; and `supabase_migrations.schema_migrations`, filled with each applied file's version and name as Supabase's command-line tool would. **It never creates `supabase_admin`**: W-C02-03's patches and W-C02-07's refuse to run where that role exists.
3. Every top-level `supabase/migrations/*.sql`, in name order, applied as `postgres` with `psql -X -q -v ON_ERROR_STOP=1`.

Then:
- **(1) Positive control**: the patch's test files on the unpatched cluster. Each must PASS; before the build exists each gives COULD NOT CHECK, and the break is then "could not check".
- **(2) Break**: exactly this patch is applied as `postgres`, and the same files run. The break is **shown** only when every file ends in FAIL and the set of cases that turned `bad` equals the patch's `expect-red` list (W-C02-03's: the built-in list from T-W03-06 and T-W03-07). A patch that does not apply, a file that ends with an error and no result, or a different red set, is **not shown** (W-C02-13 point 3: "A failure from anything else ... is not a break shown").
- **(3) Restore**: a fresh unpatched cluster runs the files again; each must PASS.

A file's cases are read from its result rows (`case_id`, `outcome`, `detail`; a case ID is the first word of `case_id`), and its result from its last `... PASS (`, `... FAIL (` or `... COULD NOT CHECK (` message.

**Output.** One JSON line per patch: the patch, its verdict, `expect_red`, `red`, both controls' states, `server_version`, `counts`, and per phase each file's result, bad cases and, for a file without a result, the end of its error. The last line is `HARNESS PASS (...)`, `HARNESS FAIL (...)` or `HARNESS COULD NOT CHECK (...)`, with exit codes 0, 1 and 3. A run whose server's major version is not `--expected-major` (17, `devos`'s observed version, EV-C02-002 section 5) says `counts: no: self-check on <version>` on every line: such a run never counts as W-C02-13's result.

## Its refusals (what it will not do)

- It accepts no host, port, connection string or credential; it clears every `PG*` variable and `DATABASE_URL` from its children's environment, so it cannot reach `devos-test` or `devos` (EV-C02-002 A2 item 3).
- It refuses a patch without the guard block (the `w07.throwaway` or `w03.throwaway` check and the `supabase_admin` check), a patch under `supabase/migrations/`, a patch whose first line is not a `w07-break` header (W-C02-03's four excepted), and any migration, test or patch with a line that starts a `psql` meta-command (EV-C02-001 section 10).
- It refuses to run as root without `--os-user`.

Each refusal gives `HARNESS COULD NOT CHECK (refused: ...)` and exit 3, never a pass.

## Its own positive control: the canary

`--canary` runs `canary/w07_canary.sql` (claim: `w07_canary.t` refuses `x <= 0` and accepts `x > 0`) on a cluster built from `canary/migrations/`, with the patch `canary/B-CANARY-1_check_dropped.sql` (expect-red `CANARY-neg`). It needs no build, so it shows the machinery works (build, stand-ins, apply, run, parse, compare, restore, clean up) before any build exists, and a harness change that breaks the comparison turns it red. Self-check, 2026-10-12, PostgreSQL 16.15 in the session's container, run as an unprivileged user through `unshare -U`: positive control PASS, break shown (`red = expect_red = [CANARY-neg]`), restore PASS, `HARNESS PASS (1/1 breaks shown)`, clusters removed.

## Run time (W-C02-13's run; plan 6.12 item 1)

Measured by phase C3's self-check on 2026-10-12, PostgreSQL 16.15 in the session's container (`counts: no`): the canary, one patch through all three phases, took 4 s; two patches with no build took 9 s. So the harness's own cost is about 4 to 5 s a patch, about 6 minutes for the 85 patches (81 of W-C02-07's and W-C02-03's B1 to B4). With the build each patch adds three applies of its migrations and three runs of its named files: seconds for an SQL file, about 1 minute a run of Concurrency (54 s on Group A's stub), so B-CONC-1 and B-CONC-2 add about 3 minutes each. The build's apply time is not known before the build exists; W-C02-13 states the measured total with its date. The time is the designer's own measure, with no plan reason to check against Batu's later decisions.

## Limits (plan Section 8 item 14)

- **Version.** Results count only on the projects' major version, 17 (`devos` runs 17.6, observed 2026-10-12; EV-C02-002 sections 5 and 14). `devos-test`'s version is read before the first break result counts, and if it differs each version is run. The container used for the self-checks has 16.15 only, so every self-check here is labelled `counts: no` (the executor's decision 7).
- **Supabase is not reproduced.** The stand-ins are roles and empty schemas. There is no Data API, no `request.headers` from a proxy, no `pgsodium` or Supabase extension and no real `postgres` role attributes. A migration that needs them fails to apply, which the harness reports as not shown, never as shown. The tests set `request.headers` themselves (transport `throwaway`).
- **What a shown break shows.** That the test turns red when that rule is removed and green when it is restored, on this server. Not that the build in either project passes (README 5.2), and not that the patch removed the rule in the form the build deploys beyond what the red cases show.
- **Scenario files** (`scenarios/`) commit and run only here, never in `devos-test`; their claims rest on this transport alone (T-W07-N28 part B).
- **The Data API programs** (`supabase/migrations/tests/w07_*.py` that call the Data API) do not run under the harness. Their rules' breaks are shown by the SQL test of the same rule (T-W07-DM19B part A). The database programs (Concurrency, DM47) do: a patch names them in its `test=` list, and the harness runs them as the job does (README 5.1 (b) and 5.2), with N-255's one JSON object on standard input (exactly `endpoint`, `apikey`, `tokens` and `revoked_token`, here null or empty) and, for a program that declares `# w07-needs-database: yes` among its first ten lines, the throwaway database's socket as its only libpq environment; a program without the declaration gets no environment at all, as under the job's `env -i`.
- **Version.** It runs PostgreSQL 17 (`--pg-bin`, default `/usr/lib/postgresql/17/bin`). A run on another major version, such as the session container's 16.15, is a self-check that never counts (the executor's decision); the harness labels it `counts: no`.
