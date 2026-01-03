open Graph

(* For flow graphs with tuple labels *)
val string_of_tuple : int * int -> string
val create_tuple_graph : int graph -> (int*int) graph

(* For creating residual graphs *)
val add_other_arc : int graph -> int arc -> int graph
val add_other_arc_for_all : int graph -> int graph

(* For the tranformation of res graph to flow graph *)
val res_to_flow_gr: int graph -> int graph -> (int*int) graph

