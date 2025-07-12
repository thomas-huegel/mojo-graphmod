# Copyright 2025 Thomas Hügel.
# This file is part of Mojo Graphmod.
# SPDX-License-Identifier: GPL-3.0-only

from trie import Trie

# At each node, the value represents the full path from the root, and the dependencies read at this node.
alias DependenciesGraph = Trie[String, List[DependencyPath]]
