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

(*Ford-Flukerson algo*)
let rec ford_flukerson_loop graph src tgt = 

  let fpath = search_flow_path graph src tgt in 
    match fpath with 
    | None -> graph
    | Some fp -> ford_flukerson_loop (update_graph graph fp (find_flow fp)) src tgt


let ford_fulkerson graph src tgt = 
  ford_flukerson_loop graph src tgt

(* ================== For dealing with different types of graphs ====================== *)

(* Turns tuple into string for exporting graphs *)
let string_of_tuple t = match t with
    |(a,b) -> string_of_int(a) ^ "/" ^ string_of_int(b)

(* Adds an arc between two nodes, in the other direction than existing node *)
let add_other_arc gr a = add_arc gr a.tgt a.src 0

(* Applies the above function on the whole graph *)
let add_other_arc_for_all gr = e_fold gr add_other_arc gr

(* Residual to (max) flow graph *)
let res_to_flow_gr org_gr res_gr = 
    
    let flow_gr = clone_nodes org_gr in (* new graph <- nodes of original graph*)

    let update_label a_flow_gr a_res_arc =
        match (find_arc org_gr a_res_arc.src a_res_arc.tgt) with
            | Some org_arc -> new_arc a_flow_gr {src = a_res_arc.src; tgt = a_res_arc.tgt; lbl = 
                match (find_arc res_gr a_res_arc.tgt a_res_arc.src) with 
                    | None -> failwith "There is something wrong with the residual graph!"
                    | Some other_res_arc -> (other_res_arc.lbl,org_arc.lbl)}
            | None -> a_flow_gr in 
    
    e_fold res_gr update_label flow_gr



(* ================== For hosts and guests problem ====================== *)

(*return the list of nodes of guests *)
let rec get_guests = function 
  | 0 -> []
  | nb -> (nb - 1)::(get_guests (nb - 1)) 

(*return the list of nodes of hosts *)
let rec get_hosts nb_guests = function 
  | 0 -> []
  | nb -> (nb_guests + nb - 1)::(get_hosts nb_guests (nb - 1)) 

(*add source and sink to solve the problem*)
let prepare_hosts_graph extended_graph nb_guests nb_hosts = 
  
  let src = nb_guests + nb_hosts in 
  let sink = nb_guests + nb_hosts + 1 in 

  let add_nodes_graph = 
    (* add sink and source*)
    (new_node (new_node extended_graph.graph src) sink)
  in 
    let add_edges_to_src_graph = 
      (* add edgdes from src to nodes of guests. The capacity tolds which lbl to add in each edge *)
      List.fold_left (fun graph node -> add_arc graph src node (find_capacity extended_graph.capacity node)) add_nodes_graph (get_guests nb_guests) 
    in 
      (* add edgdes from nodes of hoststo sink. The capacity tolds which lbl to add in each edge *)
      List.fold_left (fun graph node -> add_arc graph node sink (find_capacity extended_graph.capacity node)) add_edges_to_src_graph (get_hosts nb_guests nb_hosts)
    
    