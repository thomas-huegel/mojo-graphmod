# Copyright 2025 Thomas Hügel.
# This file is part of Mojo Graphmod.
# SPDX-License-Identifier: GPL-3.0-only

from collections import Set

from dependencies import DependencyPath
from parser import Parser

alias INPUT_SEPARATOR = "::"


struct MojoParser(Parser):
    @staticmethod
    fn parse_dependencies(file_contents: String) -> Set[DependencyPath]:
        var dependencies = Set[DependencyPath]()
        for line in file_contents.splitlines():
            var words = line.lstrip().split(" ", 2)
            if (
                len(words) >= 3
                and words[0] == "from"
                and words[2].startswith("import")
                and not words[1].startswith(".")
            ):
                var dependency_path = DependencyPath([])
                for element in words[1].split("."):
                    dependency_path.append(String(element))
                dependencies.add(dependency_path)
        return dependencies^
