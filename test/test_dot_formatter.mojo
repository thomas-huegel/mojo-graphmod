# Copyright 2025 Thomas Hügel.
# This file is part of Mojo Graphmod.
# SPDX-License-Identifier: GPL-3.0-only


from collections import Deque
from testing import assert_equal

from dependencies_graph import DependenciesGraph
from dependency_path import DependencyPath
from formatter import Formatter
from formatters.dot_formatter import DotFormatter


fn _make_trie() raises -> DependenciesGraph:
    var trie = DependenciesGraph()
    _ = trie.insert(
        ["lib"],
        {},
    )
    _ = trie.insert(
        ["abc"], {DependencyPath(["foo", "mod"]), DependencyPath(["lib"])}
    )
    _ = trie.insert(["def"], {DependencyPath(["foo", "bar"])})
    _ = trie.insert(
        ["foo", "bar"], {DependencyPath(["abc"]), DependencyPath(["std"])}
    )
    _ = trie.insert(["foo", "mod"], {DependencyPath(["foo", "bar"])})
    return trie


fn test_it_outputs_to_dot() raises:
    var trie = _make_trie()
    var result = DotFormatter.display(trie)
    var expected = """digraph dependencies {
  subgraph cluster_ {
  label=""
  color="#eeeeee"
  style="filled"
    "::lib"[label="lib",style="filled",fillcolor="#e3f38b"]
    "::abc"[label="abc",style="filled",fillcolor="#e3f38b"]
    "::def"[label="def",style="filled",fillcolor="#e3f38b"]
    subgraph cluster____foo {
    label="foo"
    color="#dddddd"
    style="filled"
      "::foo::bar"[label="bar",style="filled",fillcolor="#dbcbb3"]
      "::foo::mod"[label="mod",style="filled",fillcolor="#dbcbb3"]
    }
  }
"::abc" -> "::foo::mod"
"::abc" -> "::lib"
"::def" -> "::foo::bar"
"::foo::bar" -> "::abc"
"::foo::bar" -> "::std"
"::foo::mod" -> "::foo::bar"


}
"""
    assert_equal(result, expected)
