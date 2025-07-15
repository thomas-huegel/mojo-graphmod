pixi run mojo run src/main.mojo src 0 > modules.dot
tred modules.dot | dot -Tpdf > modules.pdf
tred modules.dot | dot -Tsvg > modules.svg
