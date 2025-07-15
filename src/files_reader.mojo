# Copyright 2025 Thomas Hügel.
# This file is part of Mojo Graphmod.
# SPDX-License-Identifier: GPL-3.0-only

from os.os import isdir, listdir
from os.path import join
from pathlib.path import Path

from dependencies_graph import DependenciesGraph
from filter import Filter
from parser import Parser


fn build_dependencies_trie[
    extension: StaticString, Filter: Filter, Parser: Parser
](
    mut trie: DependenciesGraph,
    mut path_from_root: List[String],
    path_to_explore: String,
    filter: Filter,
) raises:
    if isdir(path_to_explore):
        for file in listdir(path_to_explore):
            path_from_root.append(String(file.rstrip(extension)))
            build_dependencies_trie[extension, Filter, Parser](
                trie, path_from_root, join(path_to_explore, file), filter
            )
            _ = path_from_root.pop()
    else:
        with open(path_to_explore, "r") as contents:
            var dependencies = Parser.parse_dependencies(contents.read())
            trie.insert(
                filter.filter_source_paths(path_from_root),
                filter.filter_dependencies(dependencies),
            )
