open Graph
open Tools

type 'a flow_path = 'a arc list

let update_graph graph flow_path flow = 
  let rec aux graph flow_path flow = 
    match flow_path with 
    | [] -> graph
    | a :: rest-> add_arc (add_arc (aux graph rest flow) a.tgt a.src flow) a.src a.tgt (-flow)
  in 
  aux graph flow_path flow

let find_flow flow_path = List.fold_left (fun acu arc -> min acu arc.lbl) max_int flow_path

(*functions to find a flow path*)

(*We visit a node*)
let rec visit_node graph node tgt flow_path = 

  (*If we reach the target, we return the flow_path*)
  if (node = tgt) then Some flow_path

  else 

    (*To find the new node to visit*)
    let rec find_visit out_arcs flow_path  = 

      match out_arcs with 
        | [] -> None (*We didn't find anything so flow_path is not updated*)
        | arc::rest -> 

          (*the target node has not been visited yet*)
          if (not (List.mem arc flow_path) && arc.lbl > 0) then 
            match visit_node graph arc.tgt tgt (List.cons arc flow_path) with 
              | None -> find_visit rest flow_path (* If we didn't find a solution we continue to iterate*)
              | Some fp -> Some fp
          else (*we continue to iterate on the list*)
            find_visit rest flow_path 
    in 
      find_visit (out_arcs graph node) flow_path 


let search_flow_path graph src tgt = 
  match visit_node graph src tgt [] with 
    | None -> None 
    | Some fp -> Some (List.rev fp)

let print_edge g = 
  Printf.printf "\n";
  e_iter g (fun arc -> Printf.printf "[ %d -> %d ]" arc.src arc.tgt);
  Printf.printf "\n"

(*Ford-Flukerson algo*)
let rec main_loop graph src tgt = 

  let fpath = search_flow_path graph src tgt in 
    match fpath with 
    | None -> graph
    | Some fp -> main_loop (update_graph graph fp (find_flow fp)) src tgt


let ford_fulkerson graph src tgt = 
  main_loop graph src tgt


