# Copyright 2025 Thomas Hügel.
# This file is part of Mojo Graphmod.
# SPDX-License-Identifier: GPL-3.0-only

from dependencies import DependencyPath, FilePath
from dependencies_graph import DependenciesGraph

trait DependencyProcessor:
    fn compute_target(
        trie: DependenciesGraph,
        file_path: Path,
        dependency: DependencyPath,
        pkg_name: String,
    ) -> FilePath;

