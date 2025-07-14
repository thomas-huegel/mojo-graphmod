# Copyright 2025 Thomas Hügel.
# This file is part of Mojo Graphmod.
# SPDX-License-Identifier: GPL-3.0-only

from pathlib.path import Path


# ascii(0) = 48 and ascii(a) = 97
# n must be in 0:15
fn _make_hexadecimal_digit(n: Int) -> String:
    if n < 10:
        return chr(n + 48)
    else:
        return chr(n + 87)


fn _make_pseudorandom_hexagonal_digit[prime: Int](n: Int) -> String:
    return _make_hexadecimal_digit(15 - n * prime % 8)


fn make_gray(level: Int) -> String:
    var l = 0 if level > 16 else 15 - level
    return "#" + _make_hexadecimal_digit(l) * 6


fn make_pseudorandom_color(dirname: Path) -> String:
    var n = 4
    for char in String(dirname).codepoints():
        n += Int(char)
    var red = _make_pseudorandom_hexagonal_digit[71](n)
    var green = _make_pseudorandom_hexagonal_digit[131](n)
    var blue = _make_pseudorandom_hexagonal_digit[29](n)
    return "#" + red * 2 + green * 2 + blue * 2
