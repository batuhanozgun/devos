# CHK-C02-115 C4: the second count (N-279 (8), K2), 2026-10-19

Raw record (L-429). Read-only, through the read-only database connector on the `devos` project, by the executor.

**Where it ran** (working order "Where a result ran", PC-52): the control on the project's database, `PostgreSQL 17.6 on aarch64-unknown-linux-gnu, compiled by gcc (GCC) 15.2.0, 64-bit`, database `postgres` (`select version()` at 2026-10-19 21:31:53Z); the counts on the project's logs stream through the connector's log-query tool (ClickHouse SQL over the `logs` table). No interpreter in the session's container was involved.

**(1) The positive control**, at 2026-10-19T21:31:48Z (session clock, just after the call), through the same connection:

```
select ('permission denied ' || 'to create temporary tables' || ' (SYNTHETIC control, N-279 K2 second count, CHK-C02-115 C4, 2026-10-19)')::int as control
```

Result: failed, `ERROR: 22P02: invalid input syntax for type integer`, the message holding "permission denied to create temporary tables (SYNTHETIC control, N-279 K2 second count, CHK-C02-115 C4, 2026-10-19)".

**(2) The count**, after a two-minute wait for the control to reach the stream (from 21:31:56Z to 21:33:56Z), with the `LIKE` form that found the first count's control (L-410), window 2026-10-18T21:34:00Z to 2026-10-19T21:34:00Z:

```
select source, count(*) as n, countIf(event_message like '%SYNTHETIC control, N-279 K2%') as control_n from logs where event_message like '%permission denied to create temporary tables%' group by source order by source
```

Result: one row, `postgres_logs` n 2, control_n 2. No row for any other source.

Line totals per source over the same window:

```
select source, count(*) as n from logs group by source order by source
```

Result: `edge_logs` 1; `pgbouncer_logs` 11590; `postgres_logs` 223; `postgrest_logs` 84; `supavisor_logs` 543.

**(3) The window covered:** 2026-10-18T21:34:00Z to 2026-10-19T21:34:00Z (24 hours). It overlaps the first count's window (2026-10-18T21:30Z to 2026-10-19T09:45Z, L-410), which covers the four minutes before it, and reaches past 24 hours after M09-02's `devos` apply (2026-10-18T21:30:38Z). Both controls fall inside it: the first count's (2026-10-19T09:37:26Z, L-410) and this one (21:31:48Z); each line carries the label "SYNTHETIC control, N-279 K2", so `control_n` 2 equals `n` 2.

**Reading** (the executor's, for the check to judge): `postgres_logs` equals the controls (2, both labelled synthetic) and every other source is 0 (edge, pgbouncer, postgrest, supavisor present, none matching). Nothing beyond the controls.
