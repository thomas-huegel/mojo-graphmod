# Copyright 2025 Thomas Hügel.
# This file is part of Mojo Graphmod.
# SPDX-License-Identifier: GPL-3.0-only

from pathlib.path import Path

from files_reader import build_dependencies_trie
from formatters.dot_formatter import display


fn mojo_graphmod(directory: Path) raises -> String:
    var trie = build_dependencies_trie(directory)
    return display(trie)
