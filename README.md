Base project for Ocaml project on Ford-Fulkerson. This project contains some simple configuration files to facilitate editing Ocaml in VSCode.

To use, you should install the *OCaml Platform* extension in VSCode.
Then open VSCode in the root directory of this repository (command line: `code path/to/ocaml-maxflow-project`).

Features :
 - full compilation as VSCode build task (Ctrl+Shift+b)
 - highlights of compilation errors as you type
 - code completion
 - view of variable types


A [`Makefile`](Makefile) provides some useful commands:

 - `make build` to compile. This creates an `ftest.exe` executable
 - `make demo` to run the `ftest` program with some arguments
 - `make format` to indent the entire project
 - `make edit` to open the project in VSCode
 - `make clean` to remove build artifacts

In case of trouble with the VSCode extension (e.g. the project does not build, there are strange mistakes), a common workaround is to (1) close vscode, (2) `make clean`, (3) `make build` and (4) reopen vscode (`make edit`).

## Functions in Algo
### Functions dealing with the ford-fulkerson algorithm 

### Functions dealing with the transformation of graphs
*string_of_tuple* transforms, as the name suggests, a tuple into string. It is used when we want to export a flow graph with a tuple of int as label.

*add_other_arc* adds an arc in the other direction than the existing arc between two nodes of a graph. It is used in the *add_other_arc_for_all* function, which applies it on all existing arcs in a graph. We use the latter function when transforming the graph resulting from the Ford-Fulkerson algorithm into a proper residual graph.

*res_to_flow_gr* takes the original graph (on which we apply the Ford-Fulkerson algorithm) and its final residual graph (created by the *add_other_arc_for_all* function), and creates the max flow graph. It finds all the arcs that are in the original graph, and updates, for each of them, their labels with information from the arc in the other direction that can only be found in the resdiual graph. The new label contains now information on the final flow and the capacity of the arc.

## How to test the functions in Algo
1. Go to the ftest.ml file
2. Replace the last line with a function from test.ml and its arguments
3. Compile and execute the ftest.exe file with the wanted arguments


