
(* TEST TOOLS *)
val test_clone_nodes : string -> string -> unit

val test_gmap : string -> string -> unit 

val test_add_arc : string -> string -> int -> int -> int -> unit 


(*TEST SEARCH FLOW PATH*)
val test_search_flow_path : string -> int -> int -> unit 
  
(*TEST FORD-FULKERSON*)
val test_ford_fulkerson : string -> string -> int -> int -> unit 

val test_add_other_arc_for_all : string -> string -> int -> int -> unit

val test_res_to_flow_gr : string -> string -> int -> int -> unit 
  