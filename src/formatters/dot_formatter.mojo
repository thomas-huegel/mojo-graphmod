# Copyright 2025 Thomas Hügel.
# This file is part of Mojo Graphmod.
# SPDX-License-Identifier: GPL-3.0-only

from collections import Deque, Set

from dependencies import FilePath
from dependencies_graph import DependenciesGraph
from formatter import Formatter
from formatters.colors import make_gray, make_pseudorandom_color
from trie import Trie


alias OUTPUT_SEPARATOR = "::"
alias CLUSTER_SEPARATOR = "___"


fn _cluster_id(path: String) -> String:
    return CLUSTER_SEPARATOR.join(path.split(OUTPUT_SEPARATOR))


fn _show_vertices(trie: DependenciesGraph, dirname: String, basename: String, level: UInt) raises -> String:
    var path = "" if not basename else dirname + OUTPUT_SEPARATOR + basename
    var indentation = "  " * level
    if len(trie.children) == 0:
        return String("{}\"{}\"[label=\"{}\",style=\"filled\",fillcolor=\"{}\"]\n").format(
            indentation,
            path,
            basename,
            make_pseudorandom_color(dirname)
        )
    else:
        var result = String("{}subgraph cluster_{} {{\n").format(indentation, _cluster_id(path))
            + String("{}label=\"{}\"\n").format(indentation, basename)
            + String("{}color=\"{}\"\n").format(indentation, make_gray(level))
            + String("{}style=\"filled\"\n").format(indentation)
        for child in trie.children.items():
            res = _show_vertices(child.value, path, child.key, level + 1)
            result += res
        return result + String("{}}}\n").format(indentation)
    

fn _make_vertex(path: FilePath) -> String:
    return OUTPUT_SEPARATOR + OUTPUT_SEPARATOR.join(path.value)


fn _make_arrow(
    trie: DependenciesGraph,
    current_path: FilePath,
    dependency: FilePath,
) raises -> Optional[String]:
    if len(dependency) == 0:
        return None
    else:
        return String('"{}" -> "{}"').format(
            _make_vertex(current_path), _make_vertex(dependency)
        )


fn _show_dependencies_from_vertex(
    current_trie: DependenciesGraph,
    whole_trie: DependenciesGraph,
    current_path: FilePath,
) raises -> Optional[String]:
    var result = List[String]()
    if not current_trie.value:
        return None
    else:
        for dependency in current_trie.value.value().value:
            var arrow = _make_arrow(whole_trie, current_path, dependency)
            if arrow:
                result.append(arrow.value())
        return String("\n").join(result)

fn _show_arcs(
    current_trie: DependenciesGraph,
    whole_trie: DependenciesGraph,
    path: FilePath,
) raises -> String:
    var result = _show_dependencies_from_vertex(
        current_trie,
        whole_trie,
        path,
    ).or_else("")

    for child in current_trie.children.items():
        var new_path = path + FilePath([child.key])
        var arcs = _show_arcs(child.value, whole_trie, new_path)
        if arcs:
            result += arcs + "\n"

    return result

struct DotFormatter(Formatter):
    @staticmethod
    fn show(trie: DependenciesGraph) raises -> String:
        return "digraph dependencies {\n"
            + _show_vertices(trie, "", "", 1)
            + _show_arcs(trie, trie, FilePath([]))
            + "\n}\n"


