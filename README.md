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
### Functions dealing with the Ford-Fulkerson algorithm 
*update_graph* updates a residual graph with a flow path, which is the path chosen by the algorithm between the source and the sink, and with the max flow corresponding to this flow path. 

*find_flow* finds the max flow allowed by the capacities of edges contained on the flow path. 

*search_flow_path* returns a *flow_path option* to tell if it found a flow path for the given residual graph. It uses a Depth-first search algorithm to do so and use the function *visit_node* to compute what we do when we enter a node.

*ford_fulkerson* executes the Ford-Fulkerson algorithm. It uses the function *ford_flukerson_loop* that runs the previous functions until there is no more flow path found and updates to do. Then, we have a residual graph with the optimal flow. 

### Functions dealing with the transformation of graphs
*string_of_tuple* transforms, as the name suggests, a tuple into string. It is used when we want to export a flow graph with a tuple of int as label.

*add_other_arc* adds an arc in the other direction than the existing arc between two nodes of a graph. It is used in the *add_other_arc_for_all* function, which applies it on all existing arcs in a graph. We use the latter function when transforming the graph resulting from the Ford-Fulkerson algorithm into a proper residual graph.

*res_to_flow_gr* takes the original graph (on which we apply the Ford-Fulkerson algorithm) and its final residual graph (created by the *add_other_arc_for_all* function), and creates the max flow graph. It finds all the arcs that are in the original graph, and updates, for each of them, their labels with information from the arc in the other direction that can only be found in the resdiual graph. The new label contains now information on the final flow and the capacity of the arc.

## How to test the functions in Algo
1. Go to the ftest.ml file
2. Replace the last line with a function from test.ml and its arguments
3. Compile and execute the ftest.exe file with the wanted arguments

## The hosts and guests problem
We implemented some features to solve the hosts and guests problem. 

To do so, you provide a compatibility graph. Those graphs bring another information compared to regular graph that we called capacity which is how many people can a host host and how many guests have the same constraints and are represented by the same node. 

To be able to compute this new information, we create a new type, the *extended_graph* that contains the graph and a list of tupple gathering a node and its capacity. 

To solve this problem, we implement *prepare_hosts_graph* that add a source, a sink and the edges depending on the related capacity. Then, we can use our other functions to use Ford-Fulkerson algorithm to find a solution. The function *solve_hosts_problem* in test.ml gathers all these steps.

**Warning**: The arguments are different to execute *solve_hosts_problem*. Because we create the source and the sink, we don't need to give them as arguments. However, we need to know the number of guests and hosts to be able to link the right amount of nodes to the sink and to the source. So, when calling *solve_hosts_problem*, the arguments will be 
- *infile* : the file containing the graph
- *source* : put the *number of guests* instead of the source
- *sink* : put the *number of hosts* instead of the sink
- *outfile* : the output file.



