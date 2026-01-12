open Graph

type 'a flow_path = 'a arc list

val update_graph : int graph -> 'a flow_path -> int -> int graph
val find_flow : int flow_path -> int
val search_flow_path : int graph -> id -> id -> int flow_path option
val ford_fulkerson : int graph -> id -> id -> int graph

(* For flow graphs with tuple labels *)
val string_of_tuple : int * int -> string

(* For creating residual graphs *)
val add_other_arc : int graph -> int arc -> int graph
val add_other_arc_for_all : int graph -> int graph

(* For the tranformation of res graph to flow graph *)
val res_to_flow_gr: int graph -> int graph -> (int*int) graph
