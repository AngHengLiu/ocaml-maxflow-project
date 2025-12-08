open Graph

type 'a flow_path = 'a arc list

val update_graph : int graph -> 'a flow_path -> int -> int graph
val find_flow : int flow_path -> int
val search_flow_path : int graph -> id -> id -> int flow_path option
val ford_fulkerson : int graph -> id -> id -> int graph