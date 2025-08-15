pixi run mojo run src/main.mojo src 0 mojo-graphmod > modules.dot
tred modules.dot | dot -Tpdf > modules.pdf
tred modules.dot | dot -Tsvg > modules.svg
