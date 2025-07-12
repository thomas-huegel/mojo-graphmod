# Copyright 2025 Thomas Hügel.
# This file is part of Mojo Graphmod.
# SPDX-License-Identifier: GPL-3.0-only

from collections import Deque


@fieldwise_init
struct NodeKind(Copyable, EqualityComparable, Movable, Stringable):
    var value: Int

    alias none = Self(0)
    alias leaf = Self(1)
    alias internal = Self(2)

    fn __eq__(self, other: Self) -> Bool:
        return self.value == other.value

    fn __ne__(self, other: Self) -> Bool:
        return self.value != other.value

    fn __str__(self) -> String:
        return String(self.value)


# @fieldwise_init
struct Trie[
    K: KeyElement & Representable, V: Copyable & Movable & Representable
](Copyable, Movable, Representable):
    var value: Optional[V]
    var children: Dict[K, Trie[K, V]]

    fn __init__(out self):
        self.value = None
        self.children = Dict[K, Trie[K, V]]()

    fn __repr__(self) -> String:
        return (
            "Trie(value="
            + self.value.__str__()
            + ", children="
            + self.children.__str__()
            + ")"
        )

    fn insert(mut self, mut k: Deque[K], v: V) raises -> Optional[V]:
        if not k:
            var old_value = self.value
            self.value = v
            return old_value
        else:
            var elt = k.popleft()
            if self.children.get(elt):
                return self.children[elt].insert(k, v)
            else:
                var trie = Trie[K, V]()
                var value = trie.insert(k, v)
                self.children[elt] = trie^
                return value

    fn get_longest_prefix(self, k: List[K]) raises -> (List[K], NodeKind):
        var n = len(k)
        var bound = 0
        var trie = self
        while trie.children.get(k[bound]):
            trie = trie.children[k[bound]]
            bound += 1
            if bound == n:
                break
        var kind: NodeKind
        if bound == 0:
            kind = NodeKind.none
        elif not trie.children:
            kind = NodeKind.leaf
        else:
            kind = NodeKind.internal
        return (k[0:bound], kind)
