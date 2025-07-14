from dependencies_graph import DependenciesGraph


trait Formatter:
    @staticmethod
    fn show(trie: DependenciesGraph) raises -> String:
        pass
