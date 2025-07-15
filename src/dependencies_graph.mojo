# Copyright 2025 Thomas Hügel.
# This file is part of Mojo Graphmod.
# SPDX-License-Identifier: GPL-3.0-only

from collections import Set

from dependencies import DependencyPath
from trie import Trie


fn _make_default_set_of_dependency_path() -> Set[DependencyPath]:
    return {}


# At each node, the value represents the full path from the root, and the dependencies read at this node.
alias DependenciesGraph = Trie[
    String,
    Set[DependencyPath],
    _make_default_set_of_dependency_path,
    Set[DependencyPath].union,
]
