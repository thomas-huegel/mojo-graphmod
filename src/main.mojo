# Copyright 2025 Thomas Hügel.
# This file is part of Mojo Graphmod.
# SPDX-License-Identifier: GPL-3.0-only

from pathlib.path import Path
from sys import argv

from app_builder import mojo_graphmod


fn main() raises:
    var args = argv()
    if len(args) != 2:
        print("Please specify the directory to examine!")
    else:
        print(mojo_graphmod(Path(args[1])))
