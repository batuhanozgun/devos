| object | migration (version name) | probe-kind name scan |
|---|---|---|
| function w03_fixture_probe.f() | accepted (break copy: no lookup) | PROBE-KIND NAME |
| role w03_fixture_probe_role | accepted (break copy: no lookup) | PROBE-KIND NAME |
| schema w03_fixture_probe | accepted (break copy: no lookup) | PROBE-KIND NAME |
| table w03_fixture_probe.token_hashes | accepted (break copy: no lookup) | PROBE-KIND NAME |
| view w03_fixture_probe.token_hashes_view | accepted (break copy: no lookup) | PROBE-KIND NAME |
objects=5 unaccounted=0 [] probe-kind names=['function w03_fixture_probe.f()', 'role w03_fixture_probe_role', 'schema w03_fixture_probe', 'table w03_fixture_probe.token_hashes', 'view w03_fixture_probe.token_hashes_view']
account step result: GREEN (every object accounted)
break check on planted objects with no migration: flagged 0/5 -> FAIL: the step accepts a planted object with no migration
