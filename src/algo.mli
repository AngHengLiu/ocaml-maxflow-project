open Graph

type 'a flow_path = 'a arc list

val update_graph : int graph -> 'a flow_path -> int -> int graph
val search_flow_path : 'a graph -> id -> id -> 'a flow_path option