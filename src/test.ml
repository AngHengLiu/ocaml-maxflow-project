open Graph
open Gfile 
open Tools
open Algo

(* TEST TOOLS *)

let test_clone_nodes infile outfile = 
  export outfile (clone_nodes (from_file infile).graph)
;;

let test_gmap infile outfile = 
  export outfile (gmap (from_file infile).graph (fun a -> a^"&"));
;;

let test_add_arc infile outfile src sink nb = 
  export outfile (gmap(add_arc (gmap (from_file infile).graph (fun s -> int_of_string s)) src sink nb) (fun n -> string_of_int n))
;;


(*TEST SEARCH FLOW PATH*)

let test_search_flow_path infile src sink = 
  match search_flow_path (gmap (from_file infile).graph (fun s -> int_of_string s)) src sink with 
    | None -> Printf.printf "No path found"
    | Some l -> List.iter (fun (arc : 'a Graph.arc) -> Printf.printf "[ %d -> %d ]" arc.src arc.tgt) l
  

(*TEST FORD-FULKERSON*)

(* Writing a graph text file to be tranformed to a string graph by from_file of the final residual graph *)
let test_ford_fulkerson infile outfile src sink = 
  let graph = from_file infile in
    export outfile (gmap (ford_fulkerson (gmap graph.graph (fun x -> int_of_string x)) src sink) (fun x -> string_of_int x))
;;

(* Turns the graph that is a result of the algo into a proper residual graph *)
let test_add_other_arc_for_all infile outfile src sink =
  let graph = gmap (from_file infile).graph (fun s -> int_of_string s) in
  let result_gr = ford_fulkerson graph src sink in
    export outfile (gmap (add_other_arc_for_all result_gr) (fun n -> string_of_int n))
;;

(* Takes the residual graph and transforms it into a flow graph *)
let test_res_to_flow_gr infile outfile src sink =
  let org_gr = gmap (from_file infile).graph (fun s -> int_of_string s) in
  let res_gr = add_other_arc_for_all (ford_fulkerson org_gr src sink) in
    export outfile (gmap (res_to_flow_gr org_gr res_gr) (fun t -> string_of_tuple t))
;;

let solve_hosts_problem infile outfile nb_guests nb_hosts = 
  let infile_graph = from_file infile in 
  let int_graph = {graph = (gmap infile_graph.graph int_of_string); capacity = infile_graph.capacity} in 
    let (graph, src, sink) = prepare_hosts_graph int_graph nb_guests nb_hosts in 
    export outfile (gmap (res_to_flow_gr graph (add_other_arc_for_all((ford_fulkerson graph src sink)))) (fun x -> string_of_tuple x))
;;
  
(*export outfile (gmap (res_to_flow_gr (add_other_arc_for_all((ford_fulkerson graph src sink))) graph ) (fun x -> string_of_tuple x)) *)