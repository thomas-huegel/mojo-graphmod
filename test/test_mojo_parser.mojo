# Copyright 2025 Thomas Hügel.
# This file is part of Mojo Graphmod.
# SPDX-License-Identifier: GPL-3.0-only

from testing import assert_true

from dependency_path import DependencyPath
from parsers.mojo import MojoParser


fn test_it_parses_mojo_dependencies() raises:
    var mojo_program = """
from python import Python

from hashlib.hasher import Hasher

from .brother import Something

from ..uncle.cousin import SomethingElse

from project.mylib import MyLib

fn main():
    from mylib import MyLib
    """

    var expected_dependencies = {
        DependencyPath(["python"]),
        DependencyPath(["hashlib", "hasher"]),
        DependencyPath(["current", "directory", "brother"]),
        DependencyPath(["current", "uncle", "cousin"]),
        DependencyPath(["mylib"]),
    }

    var computed_dependencies = MojoParser.parse_dependencies(
        mojo_program, ["current", "directory"], "root_directory", "project"
    )

    for dep in computed_dependencies:
        print(String(".").join(dep.value))

    assert_true(computed_dependencies == expected_dependencies)
