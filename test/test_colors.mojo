# Copyright 2025 Thomas Hügel.
# This file is part of Mojo Graphmod.
# SPDX-License-Identifier: GPL-3.0-only

from testing import assert_equal

from formatters.colors import make_gray, make_pseudorandom_color


fn test_it_makes_gray() raises:
    assert_equal(make_gray(2), "#dddddd")


fn test_it_makes_a_pseudorandom_color() raises:
    assert_equal(make_pseudorandom_color("::foo::bar"), "#cc88ee")
