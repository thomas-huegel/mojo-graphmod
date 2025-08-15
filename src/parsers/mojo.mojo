# Copyright 2025 Thomas Hügel.
# This file is part of Mojo Graphmod.
# SPDX-License-Identifier: GPL-3.0-only

from collections import Set
from os.os import isdir
from os.path import join

from dependency_path import DependencyPath
from parser import Parser


fn _compute_nb_dots(word: StringSlice) -> (Int, String):
    var counter = 0
    while counter < len(word) and word[counter] == ".":
        counter += 1
    return (counter, String(word[counter:]))


fn _join_path(elements: List[String]) -> String:
    var result = String()
    for element in elements:
        result = join(result, element)
    return result


struct MojoParser(Parser):
    @staticmethod
    fn parse_dependencies(
        file_contents: String,
        current_directory: List[String],
        root_directory: String,
        project_name: String,
    ) -> Set[DependencyPath]:
        var dependencies = Set[DependencyPath]()
        for line in file_contents.splitlines():
            var words = line.lstrip().split(" ", 2)
            if (
                len(words) >= 3
                and words[0] == "from"
                and words[2].startswith("import")
            ):
                var without_project_name = words[1][
                    len(project_name) + 1 :
                ] if words[1].startswith(project_name + ".") else words[1]
                var (nb_dots, remainder) = _compute_nb_dots(
                    without_project_name
                )
                var dep_path = List[String]()
                if nb_dots == 1:
                    dep_path = current_directory
                elif nb_dots > 1:
                    dep_path = current_directory[: -nb_dots + 1]
                var dependency_path = DependencyPath(dep_path)
                for element in remainder.split("."):
                    dependency_path.append(String(element))
                if isdir(
                    join(root_directory, _join_path(dependency_path.value))
                ):
                    dependency_path.append("__init__")
                dependencies.add(dependency_path)
        return dependencies^
