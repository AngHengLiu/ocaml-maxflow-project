open Gfile
open Algo
open Tools

    
let () =

  (* Check the number of command-line arguments *)
  if Array.length Sys.argv <> 5 then
    begin
      Printf.printf
        "\n ✻  Usage: %s infile source sink outfile\n\n%s%!" Sys.argv.(0)
        ("    🟄  infile  : input file containing a graph\n" ^
         "    🟄  source  : identifier of the source vertex (used by the ford-fulkerson algorithm)\n" ^
         "    🟄  sink    : identifier of the sink vertex (ditto)\n" ^
         "    🟄  outfile : output file in which the result should be written.\n\n") ;
      exit 0
    end ;


  (* Arguments are : infile(1) source-id(2) sink-id(3) outfile(4) *)
  
  let infile = Sys.argv.(1)
  and outfile = Sys.argv.(4)
  
  (* These command-line arguments are not used for the moment. *)
  and _source = int_of_string Sys.argv.(2)
  and _sink = int_of_string Sys.argv.(3)
  in

  (* Open file *)
  let graph = from_file infile in

  (* Rewrite the graph that has been read. *)
  let () = write_file outfile graph in

  () (*<===== WE HAVE TO REPLACE IT*)
;;

  (* TEST TOOLS *)

  let test_clone_nodes infile outfile = 
    export outfile (clone_nodes (from_file infile))
  ;;

  let test_gmap infile outfile = 
    export outfile (gmap (from_file infile) (fun a -> a^"&"));
  ;;

  let test_add_arc infile outfile src sink nb = 
    export outfile (gmap(add_arc (gmap (from_file infile) (fun s -> int_of_string s)) src sink nb) (fun n -> string_of_int n))
  ;;


  (*TEST SEARCH FLOW PATH*)

  let test_search_flow_path infile src sink = 
    match search_flow_path (gmap (from_file infile) (fun s -> int_of_string s)) src sink with 
    | None -> Printf.printf "No path found"
    | Some l -> List.iter (fun (arc : 'a Graph.arc) -> Printf.printf "[ %d -> %d ]" arc.src arc.tgt) l
  
    

  (*TEST FORD-FULKERSON*)

(* Writing a graph text file to be tranformed to a string graph by from_file of the final residual graph *)
  let test_ford_fulkerson infile outfile src sink = 
    let graph = from_file infile in
      export outfile (gmap (ford_fulkerson (gmap graph (fun x -> int_of_string x)) src sink) (fun x -> string_of_int x))
  ;;

 (* Turns the graph that is a result of the algo into a proper residual graph *)
  let test_add_other_arc_for_all infile outfile =
    let graph = from_file infile in
      export outfile (gmap (add_other_arc_for_all (gmap graph (fun s -> int_of_string s))) (fun n -> string_of_int n))
  ;;

  (* Takes the residual graph and transforms it into a flow graph *)
  let test_res_to_flow_gr infile outfile src sink =
    let org_gr = gmap (from_file infile) (fun s -> int_of_string s) in
    let res_gr = add_other_arc_for_all (ford_fulkerson org_gr src sink) in
      export outfile (gmap (res_to_flow_gr org_gr res_gr) (fun t -> string_of_tuple t))
  ;;
  
  (*let test_res_to_flow_gr infile outfile = 
    let graph = from_file infile in
      export outfile (gmap (res_to_flow_gr (gmap graph (fun s -> int_of_string s)) (gmap (from_file outfile) (fun s -> int_of_string s))) (fun t -> string_of_tuple t))
  ;;*)
  
  (*let test_add_other_arc infile outfile src sink nb = 
    export outfile (gmap(add_other_arc (gmap (from_file infile) (fun s -> int_of_string s)) src sink nb) (fun n -> string_of_int n))
  ;;*)

  (* The functions take int graphs as arguments, whereas the files take string graphs*)

  (*let test_create_tuple_graph infile outfile =
    export outfile (gmap (create_tuple_graph (gmap (from_file infile) (fun s -> int_of_string s))) (fun n -> string_of_tuple n))
  ;;*)

  (* Creates residual graph *)
  (*let org_gr = gmap (from_file "./graphs/graph1.txt") (fun s -> int_of_string s)
  let res_gr = add_other_arc_for_all (gmap (from_file "./graphs/graph1.txt") (fun s -> int_of_string s))*)

  (*export "./res_to_flow_test.txt" (gmap (res_to_flow_gr (gmap (from_file "./graphs/graph1.txt") (fun s -> int_of_string s)) (add_other_arc_for_all (gmap (from_file "./graphs/graph1.txt") (fun s -> int_of_string s)))) (fun t -> string_of_tuple t))*)
