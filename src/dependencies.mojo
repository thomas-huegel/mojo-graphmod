# Copyright 2025 Thomas Hügel.
# This file is part of Mojo Graphmod.
# SPDX-License-Identifier: GPL-3.0-only

from hashlib.hasher import Hasher

# @fieldwise_init
# struct FilePath(Copyable, Movable, Representable, Sized):
#     var value: List[String]

#     fn __repr__(self) -> String:
#         return "FilePath(value=" + self.value.__str__() + ")"

#     fn __add__(self, owned other: Self) -> Self:
#         return Self(self.value + other.value)

#     fn __len__(self) -> Int:
#         return len(self.value)


# @fieldwise_init
# struct FilePathList(Copyable, Defaultable, Movable, Representable):
#     var value: List[FilePath]

#     fn __init__(out self):
#         self.value = []

#     fn __init__(out self, paths: List[List[String]]):
#         self.value = []
#         for path in paths:
#             self.value.append(FilePath(path))

#     fn __repr__(self) -> String:
#         return "FilePathList(value=" + self.value.__str__() + ")"


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

    # fn __str__(self) -> String:
    #     return self.value.__str__()

    fn __add__(self, owned other: Self) -> Self:
        return Self(self.value + other.value)

    fn __len__(self) -> Int:
        return len(self.value)

    # fn __repr__(self) -> String:
    #     return "DependencyPath(value=" + self.value.__str__() + ")"
