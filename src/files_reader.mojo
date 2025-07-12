# Copyright 2025 Thomas Hügel.
# This file is part of Mojo Graphmod.
# SPDX-License-Identifier: GPL-3.0-only

from os.os import listdir
from pathlib.path import Path

from trie import Trie

fn build_dependencies_trie(directory: Path) raises -> Trie:
    for file in listdir(directory):
        print(file)
    return Trie()


# pub fn build_dependencies_trie<LanguageParser: Parser>(
#     path: &Path,
#     trie: &mut DependenciesGraph,
#     skip_length: usize,
# ) -> Result<()> {
#     if path.is_file() {
#         if let Some(Some(EXTENSION)) = path.extension().map(|e| e.to_str()) {
#             let contents = read_to_string(path)?;
#             let components = path
#                 .with_extension("")
#                 .iter()
#                 .skip(skip_length)
#                 .map(|s| s.to_string_lossy().into())
#                 .collect::<VecDeque<_>>();
#             let dependencies = LanguageParser::parse_dependencies(&contents);
#             trie.insert(components.clone(), dependencies);
#         }
#     } else if path.is_dir() {
#         for entry in path.read_dir().expect("read_dir call failed").flatten() {
#             build_dependencies_trie::<LanguageParser>(&entry.path(), trie, skip_length)?;
#         }
#     } else {
#         read_to_string(path)?;
#     }
#     Ok(())
# }
