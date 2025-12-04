open Tools
open Graph

(* Adds an arc between two nodes, in the other direction than existing node*)
let add_other_arc gr a = add_arc gr (a.tgt) (a.src) (a.lbl)

(* Applies the above function on the whole graph *)
let add_other_arc_for_all gr = e_fold gr (add_other_arc) gr