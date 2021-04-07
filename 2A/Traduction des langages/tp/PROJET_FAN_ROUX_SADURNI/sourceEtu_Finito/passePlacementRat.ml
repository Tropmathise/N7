
(* Module de la passe de gestion de placement mémoire  *)
module PassePlacementRat : Passe.Passe with type t1 = Ast.AstType.programme and type t2 = Ast.AstPlacement.programme =
struct

    open Tds
    open Exceptions
    open Type
    open Ast
    open AstPlacement

    type t1 = Ast.AstType.programme
    type t2 = Ast.AstPlacement.programme

    (* analyse_placement_instruction : AstType.instruction -> AstPlacement.instruction *)
    (* Paramètre : i -> instruction à analyser *)
    (* Paramètre : base ->  deplacement *)
    (* Paramètre : reg -> registre d'activation *)
    (* Ajoute le deplacement et le registre à l'instruction *)
    let rec analyse_placement_instruction i base reg = 
        match i with 
            | AstType.Declaration(_, info) -> begin
                match info_ast_to_info info with 
                    | InfoVar(_,t,_,_) ->
                        let _ = modifier_adresse_info base reg info in 
                        getTaille t
                    | _-> raise (ErreurInterne)
                end
            | AstType.Conditionnelle(_,t,e) -> 
                begin 
                    analyse_placement_bloc t base reg; 
                    analyse_placement_bloc e base reg;
                    0
                end
            | AstType.TantQue(_,b) -> begin
                analyse_placement_bloc b base reg;
                0;
                end
            | AstType.SwitchCase(_,l) -> begin 
                let _,lli,_ = split3 l in 
                List.iter(fun b -> analyse_placement_bloc b base reg) lli;
                0;
                end
            | _ -> 0

    (* analyse_placement_bloc: AstType.bloc -> AstPlacement.bloc *)
    (* Paramètre : i -> instruction à analyser *)
    (* Paramètre : base ->  deplacement *)
    (* Paramètre : reg -> registre d'activation *)
    (* Analyse le bloc *)
    and analyse_placement_bloc li base reg = 
        match li with 
            | [] -> ()
            | t::q -> 
                let taille = analyse_placement_instruction t base reg in 
                analyse_placement_bloc q (base+taille) reg

    let analyse_placement_parametre info base =
        match info_ast_to_info info with
            | InfoVar(_,t,_,_) ->
                let _ = modifier_adresse_info (base - getTaille t) "LB" info in getTaille t
            | _ -> raise(ErreurInterne)

    (* analyse_placement_parametres: AstType.parametre -> AstPlacement.parametres *)
    (* Paramètre : lp -> liste des parametres *)
    (* Analyse les parametres *)
    let analyse_placement_parametres lp =
    (*inversion de la liste pour placer le dernier param`etre en sommet de pile
    puis les autres en−dessous *)
    List.fold_left(fun d p -> d + analyse_placement_parametre p (-d)) 0 (List.rev lp)

    (* analyse_placement_fonction: AstType.bloc -> AstPlacement.fonction *)
    (* Paramètre : i -> instruction à analyser *)
    (* Paramètre : base ->  deplacement *)
    (* Paramètre : reg -> registre d'activation *)
    (* Analyse le bloc *)
    let analyse_placement_fonction (AstType.Fonction(info,lp,li,e))=
        let _ = analyse_placement_parametres lp in 
        let _ = analyse_placement_bloc li 3 "LB" in 
        Fonction(info,lp,li,e)

    let analyser(AstType.Programme(enum,fonctions,prog))=
        let nfonctions = List.map analyse_placement_fonction fonctions in 
        let _ = analyse_placement_bloc prog 0 "SB" in 
        Programme(enum,nfonctions, prog)

end 
