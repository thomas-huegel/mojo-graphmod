# Copyright 2025 Thomas Hügel.
# This file is part of Mojo Graphmod.
# SPDX-License-Identifier: GPL-3.0-only

from pathlib.path import Path

from dependencies_graph import DependenciesGraph
from files_reader import build_dependencies_trie
from filters.depth import DepthFilter
from formatters.dot_formatter import DotFormatter
from parsers.mojo import MojoParser


fn mojo_graphmod(directory: Path, given_depth: Int) raises -> String:
    var depth = 9999 if given_depth <= 0 else given_depth
    var trie = DependenciesGraph()
    var path_from_root = List[String]()
    build_dependencies_trie[[".mojo", ".🔥", ".py"], DepthFilter, MojoParser](
        trie, path_from_root, String(directory), DepthFilter(depth)
    )
    return DotFormatter.display(trie)
