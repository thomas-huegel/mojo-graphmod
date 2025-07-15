# Copyright 2025 Thomas Hügel.
# This file is part of Mojo Graphmod.
# SPDX-License-Identifier: GPL-3.0-only

from collections import Deque
from testing import assert_equal

from trie import NodeKind, Trie


# fn test_it_builds_a_one_branch_trie() raises:
#     var trie = Trie[Int, Int]()
#     var k = Deque(elements=Optional[List[Int]]([1, 2]))
#     _ = trie.insert(k^, 10)
#     assert_true(
#         trie 
#         (
#             "Trie(value=None, children={1: Trie(value=None, children={2:"
#             " Trie(value=10, children={})})})"
#         ),
#     )


# fn test_it_builds_a_two_branch_trie() raises:
#     var trie = Trie[Int, Int]()
#     var k2 = Deque(elements=Optional[List[Int]]([1, 2]))
#     var k3 = Deque(elements=Optional[List[Int]]([1, 3]))
#     _ = trie.insert(k2^, 20)
#     _ = trie.insert(k3^, 30)
#     assert_equal(
#         repr(trie),
#         (
#             "Trie(value=None, children={1: Trie(value=None, children={2:"
#             " Trie(value=20, children={}), 3: Trie(value=30, children={})})})"
#         ),
#     )


# fn test_it_computes_the_longest_prefix() raises:
#     var trie = Trie[Int, Int]()
#     var k2 = Deque(elements=Optional[List[Int]]([1, 2]))
#     var k3 = Deque(elements=Optional[List[Int]]([1, 3]))
#     _ = trie.insert(k2^, 20)
#     _ = trie.insert(k3^, 30)
#     var a1 = [1, 3, 4]
#     var prefix1 = trie.get_longest_prefix(a1)
#     assert_equal(prefix1[0], a1[0:2])
#     assert_equal(prefix1[1], NodeKind.leaf)

#     var a2 = [1, 4]
#     var prefix2 = trie.get_longest_prefix(a2)
#     assert_equal(prefix2[0], a2[0:1])
#     assert_equal(prefix2[1], NodeKind.internal)

#     var a3 = [4]
#     var prefix3 = trie.get_longest_prefix(a3)
#     assert_equal(prefix3[0], a3[0:0])
#     assert_equal(prefix3[1], NodeKind.none)
