# Copyright 2025 Thomas Hügel.
# This file is part of Mojo Graphmod.
# SPDX-License-Identifier: GPL-3.0-only

from hashlib.hasher import Hasher

@fieldwise_init
struct DependencyPath(
    Copyable, EqualityComparable, Hashable, Movable, Sized
):
    var value: List[String]

    fn append(mut self, element: String):
        self.value.append(element)

    fn __eq__(self, other: Self) -> Bool:
        return self.value == other.value

    fn __ne__(self, other: Self) -> Bool:
        return self.value != other.value

    fn __hash__[Hasher: Hasher](self, mut hasher: Hasher):
        hasher.update(String("::::").join(self.value))

    fn __add__(self, owned other: Self) -> Self:
        return Self(self.value + other.value)

    fn __len__(self) -> Int:
        return len(self.value)
