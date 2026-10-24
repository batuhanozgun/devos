"""Synthetic regression for the G1 MCP-name bug. NOT a Codex launcher.

Requires Python 3.11+ (standard-library tomllib); no dependency installation.
No config file read, subprocess, network, credentials, or project mutation.
Only TOML source syntax and a conservative candidate CLI spelling are tested.
Actual effective configuration and model/tool isolation remain separate checks.
"""
import re
import tomllib
import unittest
from collections.abc import Mapping


def server_ids(text: str) -> tuple[str, ...]:
    """Get only direct mcp_servers children; never return values or nested paths."""
    if len(text.encode('utf-8')) > 1_048_576:
        raise ValueError('Input too large')
    try:
        document = tomllib.loads(text)
    except tomllib.TOMLDecodeError:
        raise ValueError('Invalid TOML; content intentionally omitted') from None
    servers = document.get('mcp_servers', {})
    if not isinstance(servers, Mapping):
        raise ValueError('mcp_servers must be a table')
    if any(not isinstance(value, Mapping) for value in servers.values()):
        raise ValueError('Each MCP entry must be a table')
    return tuple(sorted(servers))


def candidate_disable_overrides(ids: tuple[str, ...]) -> tuple[str, ...]:
    """Conservative subset only; do not invent quoting for ambiguous CLI keys.

    Not a statement that these names enumerate all effective managed/plugin
    sources, nor that disabled entries bypass validation of their transport.
    """
    if any(re.fullmatch(r'[A-Za-z0-9_@/-]+', key) is None for key in ids):
        raise ValueError('Unverified CLI identifier syntax; do not emit overrides')
    return tuple('mcp_servers.' + key + '.enabled=false' for key in ids)


def old_extraction_for_demonstration(text: str) -> tuple[str, ...]:
    result=[]
    for line in text.splitlines():
        match=re.match(r'^\[mcp_servers\.([^\]]+)\]$',line.strip())
        if match: result.append(match.group(1).strip('"'))
    return tuple(sorted(set(result)))


class Regression(unittest.TestCase):
    def test_old_bug_reproduced_and_new_selection(self):
        source='[mcp_servers.node_repl]\ncommand="synthetic-noop"\n[mcp_servers.node_repl.env]\nLABEL="synthetic"\n'
        self.assertEqual(old_extraction_for_demonstration(source),('node_repl','node_repl.env'))
        self.assertEqual(server_ids(source),('node_repl',))
        self.assertEqual(candidate_disable_overrides(server_ids(source)),('mcp_servers.node_repl.enabled=false',))

    def test_quoted_at_slash(self):
        source='[mcp_servers."@21st-dev/magic"]\ncommand="synthetic-noop"\n'
        self.assertEqual(server_ids(source),('@21st-dev/magic',))
        self.assertEqual(candidate_disable_overrides(server_ids(source)),('mcp_servers.@21st-dev/magic.enabled=false',))

    def test_inline_table(self):
        self.assertEqual(server_ids('mcp_servers={node_repl={command="noop",env={LABEL="synthetic"}}}'),('node_repl',))

    def test_nested_tool_is_not_server(self):
        source='[mcp_servers.example]\ncommand="noop"\n[mcp_servers.example.tools.search]\napproval_mode="prompt"'
        self.assertEqual(server_ids(source),('example',))

    def test_comments_not_servers(self):
        self.assertEqual(server_ids('# [mcp_servers.fake]\n[mcp_servers.real] # comment\ncommand="noop"'),('real',))

    def test_absence_does_not_invent_fallback_servers(self):
        self.assertEqual(server_ids('model="synthetic"'),())

    def test_single_quoted_name(self):
        self.assertEqual(server_ids("[mcp_servers.'my-server']\ncommand='noop'"),('my-server',))

    def test_literal_dotted_name_not_nested(self):
        ids=server_ids('[mcp_servers."node.repl"]\ncommand="noop"')
        self.assertEqual(ids,('node.repl',))
        with self.assertRaises(ValueError): candidate_disable_overrides(ids)

    def test_malformed_input_does_not_fallback_to_regex(self):
        with self.assertRaisesRegex(ValueError,'Invalid TOML'): server_ids('[mcp_servers.broken')

    def test_wrong_table_type(self):
        with self.assertRaises(ValueError): server_ids('mcp_servers=false')
        with self.assertRaises(ValueError): server_ids('mcp_servers={bad=false}')

    def test_env_values_preserved_and_not_returned(self):
        source='[mcp_servers.s]\ncommand="noop"\n[mcp_servers.s.env]\nTEST_VALUE="SYNTHETIC-SECRET-LIKE-TEXT"'
        before=tomllib.loads(source)
        result=candidate_disable_overrides(server_ids(source))
        self.assertEqual(result,('mcp_servers.s.enabled=false',))
        self.assertNotIn('SYNTHETIC-SECRET-LIKE-TEXT',repr(result))
        self.assertEqual(tomllib.loads(source),before)

    def test_existing_disabled_server_remains_real_entry(self):
        self.assertEqual(server_ids('[mcp_servers.s]\ncommand="noop"\nenabled=false'),('s',))

    def test_empty_ambiguous_cli_name_rejected(self):
        self.assertEqual(server_ids('[mcp_servers.""]\ncommand="noop"'),('',))
        with self.assertRaises(ValueError): candidate_disable_overrides(('',))

    def test_multiline_string_is_not_header(self):
        source='note="""\n[mcp_servers.ghost]\n"""\n[mcp_servers.real]\ncommand="noop"'
        self.assertIn('ghost',old_extraction_for_demonstration(source))
        self.assertEqual(server_ids(source),('real',))

if __name__=='__main__':
    unittest.main(verbosity=2)
