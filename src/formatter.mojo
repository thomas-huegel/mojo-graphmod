# Copyright 2025 Thomas Hügel.
# This file is part of Mojo Graphmod.
# SPDX-License-Identifier: GPL-3.0-only


from dependencies_graph import DependenciesGraph


trait Formatter:
    @staticmethod
    fn display(trie: DependenciesGraph) raises -> String:
        pass
