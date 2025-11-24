(* Yes, we have to repeat open Graph. *)
open Graph

(* assert false is of type ∀α.α, so the type-checker is happy. *)
let clone_nodes gr = n_fold new_node empty_graph gr
let gmap gr f = Graph.e_fold gr (fun b a -> new_arc b {src = a.src; tgt = a.tgt; lbl = f a.lbl}) clone_nodes
(* Replace _gr and _f by gr and f when you start writing the real function. *)
let add_arc g id1 id2 n = 
    match Graph.find_arc g id1 id2 with 
    | None -> Graph.new_arc g {src = id1; tgt = id2; lbl = n}
    | Some a -> Graph.new_arc g {src = a.src; tgt = a.tgt; lbl = (a.lbl + n)}