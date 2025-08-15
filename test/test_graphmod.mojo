# Copyright 2025 Thomas Hügel.
# This file is part of Mojo Graphmod.
# SPDX-License-Identifier: GPL-3.0-only

from testing import assert_equal

from app_builder import mojo_graphmod


fn test_it_generates_the_graphmod_graph() raises:
    var output = mojo_graphmod("src", 16, "mojo-graphmod") + "\n"
    with open("modules.dot", "r") as golden_master:
        assert_equal(output, golden_master.read())
