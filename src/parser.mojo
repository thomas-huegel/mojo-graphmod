# Copyright 2025 Thomas Hügel.
# This file is part of Mojo Graphmod.
# SPDX-License-Identifier: GPL-3.0-only


from dependencies import DependencyPath


trait Parser:
    @staticmethod
    fn parse_dependencies(file_contents: String) -> List[DependencyPath]:
        pass
