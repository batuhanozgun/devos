"""Finite revision counterexamples and one published-example reperformance.
Run with Python 3.10+; standard library only. No network or production mutation.
"""
from __future__ import annotations
import hashlib
import itertools
import json
from pathlib import Path
import platform
import sqlite3
from typing import Callable

Order = list[set[str]]  # most plausible tier first

def revise(order: Order, admitted: set[str], mode: str) -> Order:
    if not admitted or not admitted <= set().union(*order):
        raise ValueError('Admitted worlds must be a nonempty subset of the domain')
    if mode == 'natural':
        best = next(tier & admitted for tier in order if tier & admitted)
        return [best] + [tier - best for tier in order if tier - best]
    if mode == 'lex':
        return ([tier & admitted for tier in order if tier & admitted]
                + [tier - admitted for tier in order if tier - admitted])
    raise ValueError('Unknown revision mode')

def closure(facts: set[str], rules: list[tuple[set[str], str]]) -> set[str]:
    result = set(facts)
    while True:
        added = {q for premises, q in rules if premises <= result} - result
        if not added:
            return result
        result |= added

def order_view(order: Order) -> list[list[str]]:
    return [sorted(tier) for tier in order]

def c01() -> dict:
    left = [{'00'}, {'10'}, {'11'}, {'01'}]
    right = [{'00'}, {'11'}, {'10'}, {'01'}]
    admitted = {'10', '11'}
    l, r = revise(left, admitted, 'lex'), revise(right, admitted, 'lex')
    assert left[0] == right[0] == {'00'}
    assert l[0] == {'10'} and r[0] == {'11'}
    return dict(old_beliefs=sorted(left[0]), left_next=sorted(l[0]), right_next=sorted(r[0]))

def c02() -> dict:
    sources = {'direct': 'q', 'other': 'a'}
    rules = [({'a'}, 'q')]
    after_source = closure({v for k,v in sources.items() if k != 'direct'}, rules)
    after_all = closure(set(), rules)
    assert 'q' in after_source and 'q' not in after_all and 'not-q' not in after_all
    return dict(after_direct_removal=sorted(after_source), after_all_support_removed=sorted(after_all))

def c03() -> dict:
    rules = [({'a'}, 'b'), ({'b'}, 'a')]
    old = closure({'a'}, rules)
    recomputed = closure(set(), rules)
    faulty = closure(old - {'a'}, rules)
    assert old == faulty == {'a', 'b'} and recomputed == set()
    return dict(before=sorted(old), grounded_after=sorted(recomputed), recycled_after=sorted(faulty))

def c04() -> dict:
    old = {(0,1), (1,0)}
    learned = {w for w in old if w[0] == 1}
    updated = {(1, w[1]) for w in old}
    rejected_by_added_invariant = {w for w in updated if sum(w) != 1}
    assert learned == {(1,0)} and updated == {(1,0),(1,1)}
    assert rejected_by_added_invariant == {(1,1)}
    return dict(learned=sorted(learned), after_set_a=sorted(updated), rejected_if_exclusivity_invariant=sorted(rejected_by_added_invariant))

def c05() -> dict:
    allowed = [s for n in range(3) for s in itertools.combinations(['a','b'],n) if len(s) < 2]
    repairs = [s for s in allowed if len(s) == max(map(len, allowed))]
    pick_a = max(repairs, key=lambda s: sum({'a':2,'b':1}[v] for v in s))
    pick_b = max(repairs, key=lambda s: sum({'a':1,'b':2}[v] for v in s))
    assert repairs == [('a',),('b',)] and pick_a == ('a',) and pick_b == ('b',)
    return dict(tied_repairs=repairs, a_priority=pick_a, b_priority=pick_b)

def c06() -> dict:
    with sqlite3.connect(':memory:') as db:
        db.execute('CREATE TABLE states(value TEXT, valid_from INT, valid_to INT, known_from INT, known_to INT)')
        db.executemany('INSERT INTO states VALUES(?,?,?,?,?)', [('ready',10,100,10,20),('blocked',10,100,20,100)])
        def at(v:int, k:int) -> list[str]:
            return [r[0] for r in db.execute('SELECT value FROM states WHERE valid_from<=? AND ?<valid_to AND known_from<=? AND ?<known_to ORDER BY value',(v,v,k,k))]
        old, corrected = at(15,15), at(15,25)
        rows = db.execute('SELECT COUNT(*) FROM states').fetchone()[0]
        assert old == ['ready'] and corrected == ['blocked'] and rows == 2
        return dict(as_known_15=old, as_known_25=corrected, same_reference_time=15, retained_rows=rows)

def c07() -> dict:
    with sqlite3.connect(':memory:') as db:
        db.execute('CREATE TABLE versions(id TEXT, received INT, begins INT, ends INT)')
        db.executemany('INSERT INTO versions VALUES(?,?,?,?)', [('v1',10,0,30),('v2',12,30,100)])
        arrival = db.execute('SELECT id FROM versions ORDER BY received DESC LIMIT 1').fetchone()[0]
        def current(t:int) -> list[str]:
            return [r[0] for r in db.execute('SELECT id FROM versions WHERE begins<=? AND ?<ends ORDER BY id',(t,t))]
        at15, at35 = current(15), current(35)
        assert arrival == 'v2' and at15 == ['v1'] and at35 == ['v2']
        return dict(arrival_latest=arrival, applicable_15=at15, applicable_35=at35)

def c08() -> dict:
    with sqlite3.connect(':memory:') as db:
        db.execute('CREATE TABLE current(id INT PRIMARY KEY, version INT, value TEXT)')
        db.execute("INSERT INTO current VALUES(1,1,'unreviewed')")
        base = db.execute('SELECT version FROM current WHERE id=1').fetchone()[0]
        db.execute("UPDATE current SET version=2,value='blocked-by-new-evidence' WHERE id=1")
        changed = db.execute("UPDATE current SET version=3,value='ready' WHERE id=1 AND version=?",(base,)).rowcount
        kept = db.execute('SELECT version,value FROM current').fetchone()
        assert changed == 0 and kept == (2,'blocked-by-new-evidence')
        db.execute("UPDATE current SET version=3,value='ready' WHERE id=1")
        lost = db.execute('SELECT version,value FROM current').fetchone()
        assert lost == (3,'ready')
        return dict(stale_write_rows=changed, protected=kept, unconditional=lost)

def c09() -> dict:
    with sqlite3.connect(':memory:') as db:
        db.execute('CREATE TABLE object(version INT)'); db.execute('INSERT INTO object VALUES(1)')
        db.execute('CREATE TABLE policy(version INT, allowed INT)'); db.execute('INSERT INTO policy VALUES(1,1)')
        db.execute('UPDATE policy SET version=2,allowed=0')
        object_ok = db.execute('SELECT version=1 FROM object').fetchone()[0] == 1
        closure_ok = db.execute('SELECT o.version=1 AND p.version=1 AND p.allowed=1 FROM object o CROSS JOIN policy p').fetchone()[0] == 1
        assert object_ok and not closure_ok
        return dict(focal_version_pass=object_ok, declared_dependency_check_pass=closure_ok)

def c10() -> dict:
    events = [('e1',1),('e1',1)]
    raw = sum(delta for _,delta in events)
    seen, dedup = set(), 0
    for identity, delta in events:
        if identity not in seen:
            dedup += delta; seen.add(identity)
    absolute = 0
    for _ in events:
        absolute = 1
    assert raw == 2 and dedup == absolute == 1
    return dict(unqualified_delta_replay=raw, identity_deduplicated=dedup, absolute_assignment=absolute)

def c11() -> dict:
    all_contexts = [set(c) for n in range(3) for c in itertools.combinations(['a','b'],n)]
    valid = [c for c in all_contexts if not {'a','b'} <= c]
    results = [closure(c,[({'a'},'p'),({'b'},'not-p')]) for c in valid]
    assert all(not {'p','not-p'} <= result for result in results)
    merged = set().union(*results)
    assert {'p','not-p'} <= merged
    return dict(compatible_contexts=[sorted(c) for c in valid], contextual_results=[sorted(r) for r in results], invalid_unconditional_union=sorted(merged))

def c12() -> dict:
    # Transcribed from Schwind et al. (2022), Figure 1; bottom tier is most plausible.
    order = [{'111','110'},{'101','100'},{'001'},{'011'},{'000','010'}]
    worlds = set().union(*order)
    mu = {w for w in worlds if (w[0] == '1') == (w[1] == '0')}
    q = {w for w in worlds if w[1] == '1'}
    natural_1 = revise(order,mu,'natural'); lex_1 = revise(order,mu,'lex')
    natural_2 = revise(natural_1,q,'natural'); lex_2 = revise(lex_1,q,'lex')
    assert natural_1[0] == lex_1[0] == {'100','101'}
    assert natural_2[0] == {'110','111'} and lex_2[0] == {'011'}
    return dict(source='Schwind et al. KR2022 p322 Example5 Figure1', initial=order_view(order), natural_1=order_view(natural_1), lex_1=order_view(lex_1), natural_2_beliefs=sorted(natural_2[0]), lex_2_beliefs=sorted(lex_2[0]))

CASES: list[Callable[[],dict]] = [c01,c02,c03,c04,c05,c06,c07,c08,c09,c10,c11,c12]

def run() -> dict:
    outcomes, data = [], {}
    for fn in CASES:
        name = fn.__name__.upper()
        try:
            data[name] = fn()
            outcomes.append(dict(id=name, passed=True, observed=data[name]))
        except Exception as exc:
            outcomes.append(dict(id=name, passed=False, error=f'{type(exc).__name__}: {exc}'))
    # False rules are assessed against independently specified expectations in SPEC,
    # not used as alternative definitions of success.
    controls = []
    wrong_rules = [
        ('current_belief_only', lambda: data['C01']['left_next'] == data['C01']['right_next']),
        ('direct_delete_removes_all_support', lambda: 'q' not in data['C02']['after_direct_removal']),
        ('recycle_unseeded_cycle', lambda: data['C03']['grounded_after'] == data['C03']['recycled_after']),
        ('learn_equals_world_update', lambda: data['C04']['learned'] == data['C04']['after_set_a']),
        ('minimal_change_is_unique', lambda: len(data['C05']['tied_repairs']) == 1),
        ('latest_receipt_is_current', lambda: [data['C07']['arrival_latest']] == data['C07']['applicable_15']),
        ('focal_check_covers_all_dependencies', lambda: data['C09']['focal_version_pass'] == data['C09']['declared_dependency_check_pass']),
        ('all_replay_idempotent', lambda: data['C10']['unqualified_delta_replay'] == data['C10']['identity_deduplicated']),
    ]
    for name, rule in wrong_rules:
        try:
            controls.append(dict(id=name,rejected=not rule()))
        except Exception as exc:
            controls.append(dict(id=name,rejected=False,error=str(exc)))
    here=Path(__file__).resolve().parent
    return dict(scope='Synthetic finite/native checks; one published mathematical example reperformed; not live or independent Foundation validation', environment=dict(python=platform.python_version(),sqlite=sqlite3.sqlite_version), spec_sha256=hashlib.sha256((here/'SPEC.md').read_bytes()).hexdigest(), script_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(), cases=outcomes, negative_controls=controls, all_passed=all(c['passed'] for c in outcomes) and all(c['rejected'] for c in controls))

if __name__ == '__main__':
    result=run()
    output=Path(__file__).resolve().with_name('RESULT.json')
    output.write_text(json.dumps(result,ensure_ascii=False,indent=2,sort_keys=True)+'\n',encoding='utf-8')
    print(json.dumps(dict(cases=len(result['cases']),negative_controls=len(result['negative_controls']),all_passed=result['all_passed'],result_sha256=hashlib.sha256(output.read_bytes()).hexdigest())))
    raise SystemExit(0 if result['all_passed'] else 1)
