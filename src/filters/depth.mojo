# Copyright 2025 Thomas Hügel.
# This file is part of Mojo Graphmod.
# SPDX-License-Identifier: GPL-3.0-only

from collections import Deque, Set

from dependency_path import DependencyPath
from filter import Filter


@fieldwise_init
struct DepthFilter(Filter):
    var depth: Int

    fn filter_dependencies(
        self, dependencies: Set[DependencyPath]
    ) -> Set[DependencyPath]:
        var result = Set[DependencyPath]()
        for dependency in dependencies:
            result.add(DependencyPath(dependency.value[0 : self.depth]))
        return result^

    fn filter_source_paths(self, path_from_root: List[String]) -> Deque[String]:
        var result = Deque[String]()
        for element in path_from_root[0 : self.depth]:
            result.append(element)
        return result^
