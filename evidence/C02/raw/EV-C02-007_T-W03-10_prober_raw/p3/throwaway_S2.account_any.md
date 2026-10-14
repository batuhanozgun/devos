| object | migration (version name) | probe-kind name scan |
|---|---|---|
| function devos_api.deployment_drift(expected jsonb) | accepted (break copy: no lookup) | - |
| function w03_fixture_probe.f() | accepted (break copy: no lookup) | PROBE-KIND NAME |
| role w03_fixture_probe_role | accepted (break copy: no lookup) | PROBE-KIND NAME |
| schema devos_api | accepted (break copy: no lookup) | - |
| schema devos_private | accepted (break copy: no lookup) | - |
| schema w03_fixture | accepted (break copy: no lookup) | - |
| schema w03_fixture_probe | accepted (break copy: no lookup) | PROBE-KIND NAME |
| table devos_private.function_deployment | accepted (break copy: no lookup) | - |
| table w03_fixture.apply_check | accepted (break copy: no lookup) | - |
| table w03_fixture_probe.token_hashes | accepted (break copy: no lookup) | PROBE-KIND NAME |
| view w03_fixture.apply_check_view | accepted (break copy: no lookup) | - |
| view w03_fixture_probe.token_hashes_view | accepted (break copy: no lookup) | PROBE-KIND NAME |
objects=12 unaccounted=0 [] probe-kind names=['function w03_fixture_probe.f()', 'role w03_fixture_probe_role', 'schema w03_fixture_probe', 'table w03_fixture_probe.token_hashes', 'view w03_fixture_probe.token_hashes_view']
account step result: GREEN (every object accounted)
break check on planted objects with no migration: flagged 0/5 -> FAIL: the step accepts a planted object with no migration
