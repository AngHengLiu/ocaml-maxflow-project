open Tools
open Graph

(* Turns tuple into string for exporting graphs *)
let string_of_tuple t = match t with
    |(a,b) -> string_of_int(a) ^ "/" ^ string_of_int(b)

(* Transforms int flow graph into tuple flow graph *)
let create_tuple_graph gr = gmap gr (fun a -> (0,a))

(* Adds an arc between two nodes, in the other direction than existing node*)
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


        