# Copyright 2025 Thomas Hügel.
# This file is part of Mojo Graphmod.
# SPDX-License-Identifier: GPL-3.0-only

from collections import Deque


struct Trie[
    K: KeyElement & Representable,
    V: Copyable & Movable,
    default: fn () -> V,
    merge: fn (V, V) -> V,
](Copyable, Movable):
    var value: V
    var children: Dict[K, Trie[K, V, default, merge]]

    fn __init__(out self):
        self.value = default()
        self.children = Dict[K, Trie[K, V, default, merge]]()

    fn insert(mut self, owned k: Deque[K], owned v: V) raises:
        if not k:
            self.value = merge(self.value, v^)
        else:
            var elt = k.popleft()
            if self.children.get(elt):
                self.children[elt].insert(k^, v^)
            else:
                var trie = Trie[K, V, default, merge]()
                trie.insert(k^, v^)
                self.children[elt] = trie^
