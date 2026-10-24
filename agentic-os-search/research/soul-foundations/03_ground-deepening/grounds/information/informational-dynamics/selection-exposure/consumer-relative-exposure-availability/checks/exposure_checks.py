"""Six bounded exposure checks. Only temporary files and loopback HTTP.
Run: python exposure_checks.py. Writes sibling RESULT.json, including failures.
No external service, credentials, live model or repository writes are used.
"""
from __future__ import annotations

import hashlib
import itertools
import json
import platform
import tempfile
import threading
import urllib.error
import urllib.request
import zlib
from collections import deque
from contextlib import contextmanager
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path
from typing import Iterator

Contact = tuple[str, str, int]
NODES = ('A', 'B', 'C')
V1 = b'{"version":1,"decision":"HOLD"}'
V2 = b'{"version":2,"decision":"REVIEW"}'
ACK = b'{"accepted":true,"result":"/result"}'


def require(ok: bool, message: str) -> None:
    if not ok:
        raise AssertionError(message)


def digest(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def forward(contacts: set[Contact], deadline: int = 2) -> bool:
    reached = {'A'}
    for time in range(1, deadline + 1):
        previous = reached.copy()
        reached |= {v for u, v, t in contacts if t == time and u in previous}
    return 'C' in reached


def expanded(contacts: set[Contact], deadline: int = 2) -> bool:
    graph = {(node, t): [] for node in NODES for t in range(deadline + 1)}
    for t in range(1, deadline + 1):
        for node in NODES:
            graph[node, t - 1].append((node, t))  # retained custody permits waiting
    for u, v, t in contacts:
        if 1 <= t <= deadline:
            graph[u, t - 1].append((v, t))
    todo, seen = deque([('A', 0)]), {('A', 0)}
    while todo:
        node = todo.popleft()
        for successor in graph[node]:
            if successor not in seen:
                seen.add(successor)
                todo.append(successor)
    return ('C', deadline) in seen


def static_path(contacts: set[Contact]) -> bool:
    todo, seen = ['A'], {'A'}
    while todo:
        node = todo.pop()
        for u, v, _ in contacts:
            if u == node and v not in seen:
                seen.add(v)
                todo.append(v)
    return 'C' in seen


def x01() -> dict:
    possible = [(u, v, t) for t in (1, 2) for u in NODES for v in NODES if u != v]
    disagreements, reachable, static_false_positives = [], 0, 0
    for mask in range(1 << len(possible)):
        contacts = {edge for i, edge in enumerate(possible) if mask & (1 << i)}
        a, b = forward(contacts), expanded(contacts)
        if a != b:
            disagreements.append(mask)
        reachable += int(a)
        static_false_positives += int(static_path(contacts) and not a)
    reverse = {('A', 'B', 2), ('B', 'C', 1)}
    ordered = {('A', 'B', 1), ('B', 'C', 2)}
    require(not disagreements, 'Temporal algorithms disagree')
    require(static_path(reverse) and not forward(reverse), 'Reverse witness failed')
    require(forward(ordered) and not forward(ordered, 1), 'Ordered/deadline witness failed')
    snapshots = [static_path({edge for edge in ordered if edge[2] == t}) for t in (1, 2)]
    require(snapshots == [False, False], 'Instantaneous-path distinction failed')
    return dict(schedules=4096, disagreements=disagreements, reachable=reachable,
                static_false_positives=static_false_positives,
                reverse_static=True, reverse_temporal=False,
                ordered_temporal=True, ordered_deadline_one=False,
                ordered_instantaneous_paths=snapshots)


@contextmanager
def local_http(ready: bool = True) -> Iterator[tuple[str, dict]]:
    state = {'ready': ready, 'allowed': True, 'content': V1}
    lock = threading.Lock()

    class Handler(BaseHTTPRequestHandler):
        def log_message(self, fmt: str, *args: object) -> None:
            pass

        def reply(self, status: int, body: bytes) -> None:
            self.send_response(status)
            self.send_header('Content-Type', 'application/json')
            self.send_header('Content-Length', str(len(body)))
            self.end_headers()
            self.wfile.write(body)

        def do_POST(self) -> None:
            self.rfile.read(int(self.headers.get('Content-Length', 0)))
            self.reply(202 if self.path == '/jobs' else 404,
                       ACK if self.path == '/jobs' else b'{"error":"missing"}')

        def do_GET(self) -> None:
            with lock:
                if self.path == '/result':
                    status, body = (200, state['content']) if state['ready'] else (404, b'{"error":"pending"}')
                elif self.path == '/document':
                    status, body = (200, state['content']) if state['allowed'] else (403, b'{"error":"denied"}')
                else:
                    status, body = 404, b'{"error":"missing"}'
            self.reply(status, body)

    server = ThreadingHTTPServer(('127.0.0.1', 0), Handler)
    server.daemon_threads = True
    thread = threading.Thread(target=server.serve_forever, kwargs={'poll_interval': 0.01}, daemon=True)
    thread.start()
    try:
        yield f'http://127.0.0.1:{server.server_address[1]}', state
    finally:
        server.shutdown()
        server.server_close()
        thread.join(timeout=5)
        require(not thread.is_alive(), 'HTTP server did not stop')


def request(base: str, path: str, method: str = 'GET') -> tuple[int, bytes]:
    # Do not use environment-configured proxies even for this loopback fixture.
    opener = urllib.request.build_opener(urllib.request.ProxyHandler({}))
    req = urllib.request.Request(base + path, data=b'{}' if method == 'POST' else None, method=method)
    try:
        with opener.open(req, timeout=5) as response:
            return response.status, response.read()
    except urllib.error.HTTPError as exc:
        with exc:
            return exc.code, exc.read()


def x02() -> dict:
    observations = []
    for ready in (True, False):
        with local_http(ready) as (base, _):
            ack, result = request(base, '/jobs', 'POST'), request(base, '/result')
            observations.append(dict(ack_status=ack[0], ack_body=ack[1].decode(),
                                     result_status=result[0], content_present=result == (200, V1)))
    require(all((r['ack_status'], r['ack_body']) == (202, ACK.decode()) for r in observations), 'Ack differs')
    require([r['result_status'] for r in observations] == [200, 404], 'Endpoint status mismatch')
    require([r['content_present'] for r in observations] == [True, False], 'Endpoint identity mismatch')
    statuses = {r['content_present'] for r in observations}
    verdict = 'TRUE' if statuses == {True} else 'FALSE' if statuses == {False} else 'UNKNOWN'
    require(verdict == 'UNKNOWN', 'Observation ambiguity lost')
    return dict(observations=observations, ack_only_verdict=verdict)


def x03() -> dict:
    with local_http() as (base, state):
        first_status, retained = request(base, '/document')
        state['content'] = V2  # changed after the prior request completed
        next_status, latest = request(base, '/document')
    require((first_status, next_status) == (200, 200), 'Document requests failed')
    require(retained == V1 and latest == V2 and retained != latest, 'Retained-view distinction failed')
    return dict(retained=retained.decode(), latest=latest.decode(),
                retained_historical_match=retained == V1, retained_current_match=retained == V2)


def x04() -> dict:
    with tempfile.TemporaryDirectory(prefix='exposure-copy-') as directory:
        saved = Path(directory) / 'consumer.json'
        with local_http() as (base, state):
            status, content = request(base, '/document')
            require(status == 200, 'Initial source read failed')
            saved.write_bytes(content)
            state['allowed'] = False
            blocked, _ = request(base, '/document')
            retained = saved.read_bytes()
        require(blocked == 403 and retained == V1, 'Route/copy separation failed')
    return dict(new_read_status=blocked, retained_copy_present=True, retained_sha256=digest(retained))


def x05() -> dict:
    payload = b'{"decision":"HOLD","reason":"dependency"}'
    encoded = zlib.compress(payload)
    with tempfile.TemporaryDirectory(prefix='exposure-format-') as directory:
        path = Path(directory) / 'payload.bin'
        path.write_bytes(encoded)
        received = path.read_bytes()
    plain_failure = None
    try:
        json.loads(received.decode('utf-8'))
    except (UnicodeDecodeError, json.JSONDecodeError) as exc:
        plain_failure = type(exc).__name__
    recovered = json.loads(zlib.decompress(received).decode('utf-8'))
    require(received == encoded and plain_failure is not None, 'Byte/format distinction failed')
    require(recovered == {'decision': 'HOLD', 'reason': 'dependency'}, 'Supported decoding failed')
    return dict(equal_bytes=True, encoded_sha256=digest(encoded), plain_reader_error=plain_failure,
                recovered=recovered, decoded_sha256=digest(zlib.decompress(received)))


def x06() -> dict:
    metadata = {'id': 'research-item-1', 'data': 'data.txt'}
    with tempfile.TemporaryDirectory(prefix='exposure-metadata-') as directory:
        root = Path(directory)
        (root / 'metadata.json').write_text(json.dumps(metadata), encoding='utf-8')
        data = root / metadata['data']
        data.write_text('bounded research evidence', encoding='utf-8')
        data.unlink()
        observed = json.loads((root / 'metadata.json').read_text(encoding='utf-8'))
        error = None
        try:
            data.read_bytes()
        except FileNotFoundError as exc:
            error = type(exc).__name__
    require(observed == metadata and error == 'FileNotFoundError', 'Metadata/data separation failed')
    return dict(metadata=observed, metadata_accessible=True, data_reader_error=error, data_accessible=False)


def run() -> dict:
    data, cases = {}, []
    for function in (x01, x02, x03, x04, x05, x06):
        key = function.__name__.upper()
        try:
            data[key] = function()
            cases.append({'id': key, 'passed': True, 'observed': data[key]})
        except Exception as exc:
            cases.append({'id': key, 'passed': False, 'error': f'{type(exc).__name__}: {exc}'})
    false_rules = [
        ('static_path_guarantees_timely_access', lambda: data['X01']['reverse_temporal']),
        ('acceptance_proves_presence', lambda: all(r['content_present'] for r in data['X02']['observations'])),
        ('source_update_refreshes_old_view', lambda: data['X03']['retained_current_match']),
        ('source_revocation_removes_copy', lambda: not data['X04']['retained_copy_present']),
        ('equal_bytes_guarantee_decoded_view', lambda: data['X05']['plain_reader_error'] is None),
        ('metadata_proves_data_access', lambda: data['X06']['data_accessible']),
    ]
    controls = []
    for name, predicate in false_rules:
        try:
            controls.append({'id': name, 'rejected': not predicate()})
        except Exception as exc:
            controls.append({'id': name, 'rejected': False, 'error': f'{type(exc).__name__}: {exc}'})
    here = Path(__file__).resolve()
    return dict(scope='Six bounded cases and same-fixture controls; loopback/file execution, not live-agent validation',
                python=platform.python_version(), zlib=zlib.ZLIB_RUNTIME_VERSION,
                script_sha256=digest(here.read_bytes()), spec_sha256=digest(here.with_name('SPEC.md').read_bytes()),
                cases=cases, controls=controls,
                all_passed=all(c['passed'] for c in cases) and all(c['rejected'] for c in controls))


if __name__ == '__main__':
    result = run()
    target = Path(__file__).with_name('RESULT.json')
    target.write_text(json.dumps(result, sort_keys=True, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
    print(json.dumps({'all_passed': result['all_passed'], 'cases': len(result['cases']),
                      'controls': len(result['controls']), 'result_sha256': digest(target.read_bytes())}))
    raise SystemExit(0 if result['all_passed'] else 1)
