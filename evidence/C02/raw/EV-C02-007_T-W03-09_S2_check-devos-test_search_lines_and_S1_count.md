# T-W03-09: S2's `check-devos-test` search lines, S2 `check-devos`'s line for S1, and S1's printed-plant count (CHK-C02-065 C1)

Read by the executor through the GitHub MCP `get_job_logs` on 2026-10-14 between about 15:45Z and 15:56Z. Lines copied verbatim with their
timestamps. Each log also holds the plant, in its base64 form in the step environments (`W03_PLANT_B64`) and, in the
`check-devos-test` jobs, in its plain form on the one line step `plant` prints. Those lines are not copied here, and the plant
is named only by its tag, 20261013T0213Z (FR-07 item 3).

## (a) S2, run 38516392605, job 115696046711 (`check-devos-test (compare and search; applies nothing)`): the search's lines

The last 290 lines of the job's log (`original_length` 1550) were read. The search step's output begins with its repository line:

```
2026-10-14T05:24:07.5225057Z repository: 504 refs, 10340 objects read
2026-10-14T05:24:07.5225740Z logs: run 38455614435: the credential counted in all its files, the plant in its top-level files (2 top-level, 2 in folders)
2026-10-14T05:24:07.5226426Z logs: run 38371262081: the credential counted in all its files, the plant in its top-level files (2 top-level, 2 in folders)
2026-10-14T05:24:07.5227080Z logs: run 38371046806: the credential counted in all its files, the plant in its top-level files (2 top-level, 2 in folders)
2026-10-14T05:24:07.5227734Z logs: run 38367799155: the credential counted in all its files, the plant in its top-level files (2 top-level, 2 in folders)
2026-10-14T05:24:07.5228391Z logs: run 38367427286: the credential counted in all its files, the plant in its top-level files (2 top-level, 2 in folders)
2026-10-14T05:24:07.5229106Z logs: run 38363215668: the credential counted in all its files, the plant in its top-level files (2 top-level, 2 in folders)
2026-10-14T05:24:07.5229767Z logs: run 38363081389: the credential counted in all its files, the plant in its top-level files (2 top-level, 2 in folders)
2026-10-14T05:24:07.5230408Z logs: run 38360556244: the credential counted in all its files, the plant in its top-level files (2 top-level, 2 in folders)
2026-10-14T05:24:07.5231070Z logs: run 38356623539: the credential counted in all its files, the plant in its top-level files (2 top-level, 2 in folders)
2026-10-14T05:24:07.5231716Z logs: run 38356419903: the credential counted in all its files, the plant in its top-level files (2 top-level, 2 in folders)
2026-10-14T05:24:07.5232498Z logs: run 38343064563: the credential counted in all its files, the plant in its top-level files (2 top-level, 2 in folders)
2026-10-14T05:24:07.5233113Z logs: run 38338397428: the credential counted in all its files, the plant in its top-level files (2 top-level, 2 in folders)
2026-10-14T05:24:07.5234161Z logs: run 38334216555: the credential counted in all its files, the plant in its top-level files (2 top-level, 2 in folders)
2026-10-14T05:24:07.5234792Z logs: run 38334121865: the credential counted in all its files, the plant in its top-level files (2 top-level, 2 in folders)
2026-10-14T05:24:07.5235393Z logs: run 38332873603: the credential counted in all its files, the plant in its top-level files (2 top-level, 2 in folders)
2026-10-14T05:24:07.5235991Z logs: run 38332726619: the credential counted in all its files, the plant in its top-level files (2 top-level, 2 in folders)
2026-10-14T05:24:07.5236595Z logs: run 38328877217: the credential counted in all its files, the plant in its top-level files (2 top-level, 2 in folders)
2026-10-14T05:24:07.5237206Z logs: run 38319371450: the credential counted in all its files, the plant in its top-level files (2 top-level, 2 in folders)
2026-10-14T05:24:07.5237828Z logs: run 38316669047: the credential counted in all its files, the plant in its top-level files (2 top-level, 2 in folders)
2026-10-14T05:24:07.5238574Z logs: run 38315433827: the credential counted in all its files, the plant in its top-level files (2 top-level, 2 in folders)
2026-10-14T05:24:07.5239021Z logs: 20 of 20 earlier runs of migrate.yml read
2026-10-14T05:24:07.5239317Z search credential | repository: history | plain: 0
2026-10-14T05:24:07.5239603Z search credential | repository: history | percent: 0
2026-10-14T05:24:07.5239904Z search credential | repository: current trees | plain: 0
2026-10-14T05:24:07.5240210Z search credential | repository: current trees | percent: 0
2026-10-14T05:24:07.5240487Z search credential | issue #6 | plain: 0
2026-10-14T05:24:07.5240721Z search credential | issue #6 | percent: 0
2026-10-14T05:24:07.5240953Z search credential | issue #308 | plain: 0
2026-10-14T05:24:07.5241188Z search credential | issue #308 | percent: 0
2026-10-14T05:24:07.5241498Z search credential | logs of migrate.yml's earlier runs | plain: 0
2026-10-14T05:24:07.5241864Z search credential | logs of migrate.yml's earlier runs | percent: 0
2026-10-14T05:24:07.5242184Z search plant | repository: history | plain: 0
2026-10-14T05:24:07.5242550Z search plant | repository: history | percent: 1
2026-10-14T05:24:07.5242819Z search plant | repository: current trees | plain: 1
2026-10-14T05:24:07.5243102Z search plant | repository: current trees | percent: 0
2026-10-14T05:24:07.5243366Z search plant | issue #6 | plain: 0
2026-10-14T05:24:07.5243583Z search plant | issue #6 | percent: 0
2026-10-14T05:24:07.5243798Z search plant | issue #308 | plain: 1
2026-10-14T05:24:07.5244014Z search plant | issue #308 | percent: 0
2026-10-14T05:24:07.5244281Z search plant | logs of migrate.yml's earlier runs | plain: 1
2026-10-14T05:24:07.5244613Z search plant | logs of migrate.yml's earlier runs | percent: 0
2026-10-14T05:24:07.5245167Z search: none found by that method in: repository: history; repository: current trees; issue #6; issue #308; logs of migrate.yml's earlier runs
2026-10-14T05:24:07.5562525Z W03REPORT {"project":"devos-test","event":"schedule","run_id":"38516392605","commit":"44b37abfc9f629f2a7ac7854aa99ac6e93fdf2e3","head":"yes","credential_present":"yes","connection":"yes","listing_count":null,"result":"no_difference","differences":[],"applied_versions":["20261012184638","20261012231841"]}
```

All ten credential lines read 0. The plant lines read history percent 1, current trees plain 1, issue #308 plain 1, logs plain 1, and
the other six 0: the same as job `check-devos`'s (`EV-C02-007_T-W03-09_S2_run38516392605_devos_job115696047003_search_lines.md`).
After these lines the job ran step `plant`, which printed its one line at 05:24:07.5865867Z (not copied).

## (b) S2, job 115696047003 (`check-devos`): the per-run line for S1, above the window filed before

The last 152 lines of the job's log (`original_length` 1467) were read:

```
2026-10-14T05:24:05.1344279Z repository: 504 refs, 10340 objects read
2026-10-14T05:24:05.1345679Z logs: run 38455614435: the credential counted in all its files, the plant in its top-level files (2 top-level, 2 in folders)
2026-10-14T05:24:05.1347433Z logs: run 38371262081: the credential counted in all its files, the plant in its top-level files (2 top-level, 2 in folders)
2026-10-14T05:24:05.1348980Z logs: run 38371046806: the credential counted in all its files, the plant in its top-level files (2 top-level, 2 in folders)
2026-10-14T05:24:05.1350719Z logs: run 38367799155: the credential counted in all its files, the plant in its top-level files (2 top-level, 2 in folders)
2026-10-14T05:24:05.1351695Z logs: run 38367427286: the credential counted in all its files, the plant in its top-level files (2 top-level, 2 in folders)
2026-10-14T05:24:05.1352616Z logs: run 38363215668: the credential counted in all its files, the plant in its top-level files (2 top-level, 2 in folders)
2026-10-14T05:24:05.1353524Z logs: run 38363081389: the credential counted in all its files, the plant in its top-level files (2 top-level, 2 in folders)
2026-10-14T05:24:05.1354453Z logs: run 38360556244: the credential counted in all its files, the plant in its top-level files (2 top-level, 2 in folders)
2026-10-14T05:24:05.1355360Z logs: run 38356623539: the credential counted in all its files, the plant in its top-level files (2 top-level, 2 in folders)
2026-10-14T05:24:05.1356243Z logs: run 38356419903: the credential counted in all its files, the plant in its top-level files (2 top-level, 2 in folders)
2026-10-14T05:24:05.1357141Z logs: run 38343064563: the credential counted in all its files, the plant in its top-level files (2 top-level, 2 in folders)
```

(the lines from 38338397428 on are in the file filed before). No per-run line in either job reads "(0 top-level, 0 in folders)".

## (c) S1, run 38455614435, job 115497430283 (`check-devos-test`): the printed plant line, as a count

- **Direct reading.** The last 19 lines of the job's log (`original_length` 1551) hold the job's last step, step 13, "point 9's positive
  control p4: print the synthetic plant once, if one is set (holds no secret)", 19:32:40Z: one printed line, at
  2026-10-13T19:32:40.7712696Z, of the form "synthetic plant (T-W03-09 p4; made up for that test, not a credential): " followed by the
  plant (tag 20261013T0213Z). Its step is the only step of `migrate.yml` that prints the plain plant (the plant is otherwise held only
  as base64 in `W03_PLANT_B64`), and it prints once by its code (`print(... + value, flush=True)`, one call, no loop).
- **The fixed-string count.** S2's search (lines in (a) and (b)) counts with `data.count(needle)`, a fixed-string count of the plain
  plant over the top-level files of each earlier run's log archive (`migrate.yml` at `44b37ab`, the search's step `count` and its
  section "3. The logs of migrate.yml's earlier runs"). Over the 20 earlier runs it gives `search plant | logs of migrate.yml's earlier
  runs | plain: 1`. Of those 20 runs, step `plant` ran only in S1: it exists from H1-prime's merge `1c0dbcf` (2026-10-13T07:31:37Z),
  runs only in `check-devos-test`, which runs only on a schedule, and S1 is the only scheduled run between that merge and S2 (the
  scheduled-run listing, `EV-C02-007_T-W03-09_schedule_runs_S1_S3_20261014.md`). So the count of the plain plant in S1's
  `check-devos-test` log is **1**, by the workflow's own fixed-string count, and the printed line read above is that one.
