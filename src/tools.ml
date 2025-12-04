open Graph

(* Returns a new graph having the same nodes than gr, but no arc*)
let clone_nodes gr = n_fold gr new_node empty_graph 

(* Maps all arcs of gr by function f.*)
let gmap gr f = Graph.e_fold gr (fun b a -> new_arc b {src = a.src; tgt = a.tgt; lbl = f a.lbl}) (clone_nodes gr)

(* Adds n to the value of the arc between id1 and id2. If the arc does not exist, it is created.*)
let add_arc g id1 id2 n = 
    match Graph.find_arc g id1 id2 with 
    | None -> Graph.new_arc g {src = id1; tgt = id2; lbl = n}
    | Some a -> Graph.new_arc g {src = a.src; tgt = a.tgt; lbl = (a.lbl + n)}