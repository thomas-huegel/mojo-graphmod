# Copyright 2025 Thomas Hügel.
# This file is part of Mojo Graphmod.
# SPDX-License-Identifier: GPL-3.0-only

from collections import Deque, Set

from dependencies import DependencyPath


trait Filter:
    fn filter_dependencies(
        self, dependencies: Set[DependencyPath]
    ) -> Set[DependencyPath]:
        pass

    fn filter_source_paths(self, path_from_root: List[String]) -> Deque[String]:
        pass
