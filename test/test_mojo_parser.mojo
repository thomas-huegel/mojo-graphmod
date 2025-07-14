# Copyright 2025 Thomas Hügel.
# This file is part of Mojo Graphmod.
# SPDX-License-Identifier: GPL-3.0-only

from testing import assert_equal

from dependencies import DependencyPath
from parsers.mojo_parser import MojoParser


fn test_it_parses_mojo_dependencies() raises:
    var mojo_program = """
from python import Python

from hashlib.hasher import Hasher

fn main():
    from mylib import MyLib
    """

    var dependencies = [
        DependencyPath(["python"]),
        DependencyPath(["hashlib", "hasher"]),
        DependencyPath(["mylib"]),
    ]

    assert_equal(MojoParser.parse_dependencies(mojo_program), dependencies)
