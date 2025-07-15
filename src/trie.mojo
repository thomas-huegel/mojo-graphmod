# Copyright 2025 Thomas Hügel.
# This file is part of Mojo Graphmod.
# SPDX-License-Identifier: GPL-3.0-only

from collections import Deque


# @fieldwise_init
# struct NodeKind(Copyable, EqualityComparable, Movable, Stringable):
#     var value: Int

#     alias none = Self(0)
#     alias leaf = Self(1)
#     alias internal = Self(2)

#     fn __eq__(self, other: Self) -> Bool:
#         return self.value == other.value

#     fn __ne__(self, other: Self) -> Bool:
#         return self.value != other.value

#     fn __str__(self) -> String:
#         return String(self.value)


# @fieldwise_init
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

    # fn __repr__(self) -> String:
    #     return (
    #         "Trie(value="
    #         + self.value.__str__()
    #         + ", children="
    #         + self.children.__str__()
    #         + ")"
    #     )

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

    fn insert2(mut self, owned k: List[K], owned v: V) raises:
        self.insert(Deque(elements=k^), v^)

    # fn get_longest_prefix(self, k: List[K]) raises -> (List[K], NodeKind):
    #     var n = len(k)
    #     var bound = 0
    #     var trie = self
    #     while trie.children.get(k[bound]):
    #         trie = trie.children[k[bound]]
    #         bound += 1
    #         if bound == n:
    #             break
    #     var kind: NodeKind
    #     if bound == 0:
    #         kind = NodeKind.none
    #     elif not trie.children:
    #         kind = NodeKind.leaf
    #     else:
    #         kind = NodeKind.internal
    #     return (k[0:bound], kind)
