-- Synthetic (plan Section 8 item 13): the harness's canary test (harness/README.md, "Its own positive control").
-- Claim: w07_canary.t refuses x <= 0 and accepts x > 0. Same form as the W-C02-07 SQL tests (README 5.1 (a)).
begin;
set local search_path = pg_catalog, pg_temp;
create temp table w07_results (case_id text primary key, outcome text not null, detail text not null);
do $$
declare err text;
begin
  begin insert into w07_canary.t values (-1); exception when others then err := sqlstate; end;
  insert into w07_results values ('CANARY-neg', case when err = '23514' then 'ok' else 'bad' end, 'x = -1: ' || coalesce(err, 'written'));
  err := null;
  begin insert into w07_canary.t values (1); exception when others then err := sqlstate; end;
  insert into w07_results values ('CANARY-pos', case when err is null then 'ok' else 'bad' end, 'x = 1: ' || coalesce(err, 'written'));
end $$;
select case_id, outcome, detail from w07_results order by case_id;
do $$
declare nb int; n int;
begin
  select count(*) filter (where outcome = 'bad'), count(*) into nb, n from w07_results;
  if nb > 0 then raise exception 'W07_CANARY FAIL (% bad of %)', nb, n; end if;
  raise notice 'W07_CANARY PASS (%/%)', n, n;
end $$;
rollback;
