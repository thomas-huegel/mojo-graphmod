# Copyright 2025 Thomas Hügel.
# This file is part of Mojo Graphmod.
# SPDX-License-Identifier: GPL-3.0-only

from collections import Set

from dependency_path import DependencyPath


trait Parser:
    @staticmethod
    fn parse_dependencies(
        file_contents: String,
        current_directory: List[String],
        root_directory: String,
        project_name: String,
    ) -> Set[DependencyPath]:
        pass
