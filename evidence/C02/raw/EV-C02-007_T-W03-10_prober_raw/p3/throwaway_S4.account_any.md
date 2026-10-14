| object | migration (version name) | probe-kind name scan |
|---|---|---|
| extension pgcrypto | accepted (break copy: no lookup) | - |
| function devos_api.deployment_drift(expected jsonb) | accepted (break copy: no lookup) | - |
| function public.w03_fixture_probe_public_f() | accepted (break copy: no lookup) | PROBE-KIND NAME |
| schema devos_api | accepted (break copy: no lookup) | - |
| schema devos_private | accepted (break copy: no lookup) | - |
| schema w03_fixture | accepted (break copy: no lookup) | - |
| table devos_private.function_deployment | accepted (break copy: no lookup) | - |
| table public.w03_fixture_probe_public_t | accepted (break copy: no lookup) | PROBE-KIND NAME |
| table w03_fixture.apply_check | accepted (break copy: no lookup) | - |
| view public.w03_fixture_probe_public_v | accepted (break copy: no lookup) | PROBE-KIND NAME |
| view w03_fixture.apply_check_view | accepted (break copy: no lookup) | - |
objects=11 unaccounted=0 [] probe-kind names=['function public.w03_fixture_probe_public_f()', 'table public.w03_fixture_probe_public_t', 'view public.w03_fixture_probe_public_v']
account step result: GREEN (every object accounted)
break check on planted objects with no migration: flagged 0/4 -> FAIL: the step accepts a planted object with no migration
