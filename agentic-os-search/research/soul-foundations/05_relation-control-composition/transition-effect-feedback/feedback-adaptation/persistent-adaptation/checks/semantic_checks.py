"""Constructive semantic checks, not SOUL/LLM efficacy or empirical replication.

Each case is a declared toy construction. It demonstrates a possible distinction;
it does not estimate its frequency or identify hidden mechanisms in real systems.
Run: python semantic_checks.py
"""
from __future__ import annotations

import json
import math
from dataclasses import dataclass, replace
from typing import Callable

@dataclass(frozen=True)
class Agent:
    lessons: tuple[str, ...] = ()
    connected: bool = True
    episode_alarm: bool = False

    def response(self, case: str) -> str:
        if self.episode_alarm:
            return 'pause'
        if self.connected and 'check-rare' in self.lessons and case == 'rare':
            return 'check'
        return 'continue'

    def next_episode(self) -> 'Agent':
        return replace(self, episode_alarm=False)


def vector(a: Agent) -> tuple[str, ...]:
    return tuple(a.response(q) for q in ('ordinary', 'rare'))


def check(name: str, fn: Callable[[], dict]) -> dict:
    return {'name': name, 'status': 'PASS', 'observed': fn()}


def inert_record():
    a = Agent(); b = Agent(('check-rare',), connected=False)
    assert a.lessons != b.lessons and vector(a) == vector(b)
    return {'stored_change': True, 'response_changed': False}


def fixed_code_external_carrier():
    a = Agent(); b = Agent(('check-rare',))
    assert a.response.__func__ is b.response.__func__
    assert vector(a) == ('continue', 'continue')
    assert vector(b) == ('continue', 'check')
    assert a.response('ordinary') == b.response('ordinary')
    return {'same_code': True, 'before': vector(a), 'after': vector(b)}


def parameter_change_without_behavior():
    f = lambda x, p: x * sum(p)
    p0, p1 = (1, 2), (0, 3)
    assert p0 != p1 and all(f(x, p0) == f(x, p1) for x in range(-5, 6))
    return {'parameters_changed': True, 'tested_inputs': 11, 'different_outputs': 0}


def declared_restart():
    a = Agent(('check-rare',))
    encoded = json.dumps({'lessons': a.lessons})
    b = Agent(tuple(json.loads(encoded)['lessons']))
    not_restored = Agent()
    assert vector(a) == vector(b) != vector(not_restored)
    return {'with_restore': vector(b), 'without_restore': vector(not_restored)}


def partial_propagation():
    workers = (Agent(('check-rare',)), Agent())
    outcomes = [a.response('rare') for a in workers]
    assert outcomes == ['check', 'continue']
    return {'workers': outcomes, 'all_paths_changed': False}


def transient_episode_state():
    a = Agent(episode_alarm=True)
    assert a.response('ordinary') == 'pause'
    assert vector(a.next_episode()) == vector(Agent())
    return {'during_episode': 'pause', 'later_vector': vector(a.next_episode())}


def declared_horizon():
    retained = lambda n: 0.8 ** n
    # These criterion and horizons are part of this toy, not universal thresholds.
    threshold = 0.5
    assert retained(2) >= threshold and retained(10) < threshold
    return {'threshold': threshold, 'after_2_opportunities': retained(2),
            'after_10_opportunities': retained(10)}


def latent_cancellation():
    # Original qualitative construction; not the empirical paper's fitted model.
    slow, fast = 1.0, -1.0
    before = slow + fast
    after = 0.99 * slow + 0.5 * fast
    assert before == 0 and after == 0.49
    return {'initial_output': before, 'following_output': after,
            'initial_latent_states': [slow, fast]}


def probe_changes_target():
    before = Agent()
    frozen_probe = before.response('rare')
    after_probe_training = Agent(before.lessons + ('check-rare',))
    assert frozen_probe == 'continue'
    assert after_probe_training.response('rare') == 'check'
    return {'before_probe_update': frozen_probe, 'after_probe_update': 'check'}


def changed_situation_without_adaptation():
    fixed = lambda difficulty: 10 - difficulty
    before, after = fixed(8), fixed(2)
    assert after > before
    assert fixed(8) == 2
    return {'observed_before': before, 'observed_after': after,
            'response_function_changed': False}


def occurrence_without_benefit():
    cases = ('bad', 'good')
    old = lambda q: 'reject' if q == 'bad' else 'accept'
    new = lambda q: 'reject'
    old_scores = sum(old(q) == ('reject' if q == 'bad' else 'accept') for q in cases)
    new_scores = sum(new(q) == ('reject' if q == 'bad' else 'accept') for q in cases)
    assert [old(q) for q in cases] != [new(q) for q in cases]
    assert new_scores < old_scores
    return {'before_correct': old_scores, 'after_correct': new_scores,
            'responses_changed': True}


def redundant_carriers():
    responds = lambda a, b: 'check' if a or b else 'continue'
    assert responds(True, True) == responds(False, True) == responds(True, False)
    assert responds(False, False) != responds(True, True)
    return {'single_removal_changes_response': False,
            'joint_removal_changes_response': True}


def same_mean_different_distribution():
    old = {0: 0.5, 4: 0.5}; new = {2: 1.0}
    mean = lambda d: sum(x * p for x, p in d.items())
    assert old != new and math.isclose(mean(old), mean(new))
    return {'mean_before': mean(old), 'mean_after': mean(new),
            'distributions_equal': False}


def latent_update_rule():
    current = 0.0
    alpha_before, alpha_after = 0.1, 0.9
    step = lambda x, alpha, feedback: x + alpha * (feedback - x)
    assert current == 0.0
    later_before = step(current, alpha_before, 1.0)
    later_after = step(current, alpha_after, 1.0)
    assert later_before != later_after
    return {'current_output_both': current,
            'after_identical_future_feedback': [later_before, later_after]}


def functional_restore_not_bytes():
    old_representation = {'rare': 'check', 'ordinary': 'continue'}
    new_representation = [('ordinary', 'continue'), ('rare', 'check')]
    assert json.dumps(old_representation) != json.dumps(new_representation)
    assert all(old_representation[q] == dict(new_representation)[q]
               for q in ('ordinary', 'rare'))
    return {'bytes_same': False, 'declared_response_class_preserved': True}


def neutral_controls():
    # Incorrect universal rules must fail on already declared counterexamples.
    bad_rules = {
        'any_durable_record_proves_response_change': lambda: vector(Agent()) != vector(Agent(('check-rare',), False)),
        'every_input_must_show_change': lambda: all(Agent().response(q) != Agent(('check-rare',)).response(q) for q in ('ordinary', 'rare')),
        'one_carrier_ablation_always_detects_contribution': lambda: (True or True) != (False or True),
        'same_mean_proves_same_distribution': lambda: {0: .5, 4: .5} == {2: 1.0},
    }
    rejected = []
    for name, rule in bad_rules.items():
        if rule():
            raise AssertionError(f'Incorrect rule unexpectedly passed: {name}')
        rejected.append(name)
    return rejected


def main() -> None:
    cases = [inert_record, fixed_code_external_carrier,
             parameter_change_without_behavior, declared_restart,
             partial_propagation, transient_episode_state, declared_horizon,
             latent_cancellation, probe_changes_target,
             changed_situation_without_adaptation, occurrence_without_benefit,
             redundant_carriers, same_mean_different_distribution,
             latent_update_rule, functional_restore_not_bytes]
    results = [check(fn.__name__, fn) for fn in cases]
    print(json.dumps({'kind': 'constructed_semantic_counterexamples',
                      'empirical_or_live_agent_test': False,
                      'cases': results,
                      'passed': len(results),
                      'negative_rules_rejected': neutral_controls()},
                     ensure_ascii=False, indent=2))

if __name__ == '__main__':
    main()
