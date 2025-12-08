open Gfile
open Algo
open Tools

    
let () =

  (*(* Check the number of command-line arguments *)
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

  ()*)

  (* TEST EXPORT

  export "../test1.svg" (clone_nodes (from_file "./graphs/graph1.txt"));
  export "../test2.svg" (gmap (from_file "./graphs/graph1.txt") (fun a -> a^"&"));
  export "../test3.svg" (gmap(add_arc (gmap (from_file "./graphs/graph1.txt") (fun s -> int_of_string s)) 3 4 1000) (fun n -> string_of_int n))*)


  (*TEST SEARCH FLOW PATH*)


  (*(e_iter (from_file "./graphs/graph1.txt") (fun e -> printf "%d %d %s" e.src e.tgt ))*)


  (*export "../test.svg" (from_file "./graphs/graph2.txt");

  let print =  
    match search_flow_path (from_file "./graphs/graph2.txt") 0 12 with 
    | None -> Printf.printf "No path found"
    | Some l -> List.iter (fun arc -> Printf.printf "[ %d -> %d ]" arc.src arc.tgt) l
  in 
  print
    *)


  (*TEST FORD-FULKERSON*)

  let graph = from_file "./graphs/graph2.txt" in

    export "../graph.svg" graph;

    export "../result.svg" (gmap (ford_fulkerson (gmap graph (fun x -> int_of_string x)) 0 12) (fun x -> string_of_int x));