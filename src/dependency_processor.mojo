from dependencies import DependencyPath, FilePath
from dependencies_graph import DependenciesGraph

trait DependencyProcessor:
    fn compute_target(
        trie: DependenciesGraph,
        file_path: Path,
        dependency: DependencyPath,
        pkg_name: String,
    ) -> FilePath;

