
(* Module de la passe code rat to tam *)
module PasseCodeRatToTam : Passe.Passe with type t1 = Ast.AstPlacement.programme and type t2 = string =
struct

    open Tds
    open Type
    open Ast
    open Ast.AstType
    open AstPlacement
    open Code
    open Exceptions

    type t1 = Ast.AstPlacement.programme
    type t2 = string

    (* analyse la valeur du pointeur, fonction récursive pour les pointeurs de pointeurs *)
    let rec analyse_ident_val_affectable a =
        match a with 
            | AstType.Ident info -> begin 
                match info_ast_to_info info with 
                    | InfoVar(_, Pointeur t, dep, reg) -> 
                        (t, "LOAD (1) "^(string_of_int dep)^"["^reg^"]\n")
                    | _ -> raise (ErreurInterne)
                    end
            | AstType.Valeur aff -> 
                let (typ,str) = analyse_ident_val_affectable aff in 
                begin match typ with 
                | Pointeur t -> (t, str^"LOADI (1)\n")
                | _ -> raise(ErreurInterne)
                end

    (* analyse_code_affectable : AstPlacement.affectable *)
    (* Paramètre a: l'affectable à analyser *)
    (* Construit le code tam *)
    (* analyse à droite *)
    (* Ici on LOAD les données *)
    let analyse_code_affectable a = 
        match a with 
        | AstType.Ident info -> begin
            match info_ast_to_info info with 
            | InfoVar(_,t,dep,reg) -> "LOAD ("^(string_of_int (getTaille t))^") "^(string_of_int dep)^"["^reg^"]\n"
            | InfoEltEnum(nt,_,dep,reg) -> "LOAD ("^(string_of_int (getTaille (Tid nt)))^") "^(string_of_int dep)^"["^reg^"]\n"
            | InfoConst(_,v) -> "LOADL "^(string_of_int v)^"\n"
            | _ -> raise(ErreurInterne)
            end
        | AstType.Valeur v -> 
            begin 
            let (typ,str) = analyse_ident_val_affectable v in 
            str^"LOADI ("^(string_of_int (getTaille typ))^")\n"
            end

    (* analyse à gauche *)
    (* Ici on stock les données *)
    let analyse_code_affectable_2 a =
        match a with 
        | AstType.Ident info -> begin 
            match info_ast_to_info info with    
                | InfoVar(_,t,dep,reg)-> "STORE ("^(string_of_int (getTaille t))^") "^(string_of_int dep)^"["^reg^"]\n"
                | InfoEltEnum(nt,_,dep,reg) -> "STORE ("^(string_of_int (getTaille (Tid nt)))^") "^(string_of_int dep)^"["^reg^"]\n"
                | _ -> raise(ErreurInterne)
            end
        | AstType.Valeur v -> 
            let (typ,str) = analyse_ident_val_affectable v in 
            str^"STOREI ("^(string_of_int (getTaille typ))^")\n"

    (* analyse_code_expression : AstPlacement.expression *)
    (* Paramètre e: l'expression à analyser *)
    (* Construit le code tam correspondant *)
    let rec analyse_code_expression e = 
        match e with 
            | AstType.AppelFonction(info, le) -> 
            begin
                (* on regarde le type des paramètres pour renommer la fonction dans le CALL *)
                match info_ast_to_info info with 
                | InfoFun(n,_,_) -> begin
                          let ltp = List.map (fun expr ->
                                begin
                                match expr with
                                 | AppelFonction (inf,_) ->
                                        begin
                                        match info_ast_to_info inf with
                                            | InfoFun(_,tr,_) -> tr
                                            | _ -> raise ErreurInterne
                                        end
                                | Rationnel _ -> Rat
                                | Numerateur _ | Denominateur _ -> Int 
                                | True -> Bool
                                | False -> Bool
                                | Entier _ -> Int
                                | Binaire(op,_,_) -> 
                                    begin match op with 
                                        | PlusInt | MultInt -> Int
                                        | PlusRat | MultRat -> Rat
                                        | EquInt | EquBool | EquEnum | Inf -> Bool 
                                    end
                                | New typ -> typ
                                | Affectable a ->
                                    let rec type_affectable aff =
                                    begin
                                    match aff with 
                                    | Ident asta -> begin 
                                        match info_ast_to_info asta with 
                                            | InfoConst _ -> Int
                                            | InfoVar(_,t,_,_) -> t
                                            | InfoEnum(s,_) -> Tid s
                                            | InfoEltEnum(nt,_,_,_) -> Tid nt
                                            | InfoFun _ -> failwith "Identifiant sur une fonction utilisé comme paramètre d'une fonction"
                                            end
                                    | Valeur v -> begin match v with 
                                        | Ident id -> begin match info_ast_to_info id with 
                                            | InfoVar(_,Pointeur t,_,_) -> t
                                            | _ -> raise(ErreurInterne)
                                            end
                                        | Valeur v2 -> type_affectable v2
                                        end     
                                    end in
                                    type_affectable a;
                                | Adresse info -> begin 
                                    match info_ast_to_info info with 
                                        | InfoConst _ -> Int
                                        | InfoVar(_,t,_,_) -> t
                                        | InfoEnum(s,_) -> Tid s
                                        | InfoEltEnum(nt,_,_,_) -> Tid nt
                                        | InfoFun _ -> failwith "ca ne peut pas marcher"
                                    end
                                | Tide info -> begin
                                     match info_ast_to_info info with
                                        | InfoEltEnum (nt,_,_,_) -> Tid nt
                                        | _ -> failwith "hmmmm bizarre quand même" (* on avait pas d'idée de failwith *)
                                    end 
                                | _ -> failwith "hmmmm tant pis" (* ici nous plus *)
                                end) le in
                            (* ici on call les fonctions *)
                          (List.fold_left (fun ac e -> ac ^ analyse_code_expression e) "" le) ^"CALL (ST) "^n^
                          "_"^(List.fold_right (fun tete queuetraitee -> (string_of_type tete)^"_"^queuetraitee) ltp "")^"\n"
                            end
                | _ -> raise(ErreurInterne)
                end
            | AstType.Rationnel(e1,e2)-> analyse_code_expression e1 ^ analyse_code_expression e2
            | AstType.Numerateur(e) -> analyse_code_expression e ^ "POP (0) 1\n"
            | AstType.Denominateur(e) -> analyse_code_expression e ^ "POP (1) 1\n"
            | AstType.True -> "LOADL 1\n"
            | AstType.False -> "LOADL 0\n"
            | AstType.Entier(i) -> "LOADL " ^ (string_of_int i) ^ "\n"
            | AstType.Binaire(b,e1,e2) -> 
                begin 
                let code1 = analyse_code_expression e1 in 
                let code2 = analyse_code_expression e2 in
                match b with
                    | PlusInt -> code1^code2^"SUBR IAdd\n"
                    | PlusRat -> code1^code2^"CALL (ST) RAdd\n"
                    | MultInt -> code1^code2^"SUBR IMul\n"
                    | MultRat -> code1^code2^"CALL (ST) RMul\n"
                    | EquBool -> code1^code2^"SUBR IEq\n"
                    | EquInt -> code1^code2^"SUBR IEq\n"
                    | EquEnum -> code1^code2^"SUBR IEq\n" 
                    | Inf -> code1^code2^"SUBR ILss\n"
                end 
            | AstType.Affectable a -> analyse_code_affectable a
            | AstType.Null -> "LOADL 0\n"
            | AstType.New t -> "LOADL "^(string_of_int (getTaille t))^"\nSUBR MAlloc\n"
            | AstType.Adresse add -> begin 
                match info_ast_to_info add with 
                    | InfoVar(_,_,dep,reg)-> "LOADA "^(string_of_int dep)^"["^reg^"]\n"
                    | _ -> raise(ErreurInterne)
                end
            | AstType.Tide n -> begin 
                match info_ast_to_info n with 
                    | InfoEltEnum (_,_,dep,_)-> "LOADL "^(string_of_int dep)^"\n"
                    | _ -> raise(ErreurInterne)
                end
            | AstType.Default -> ""

    (* analyse_code_instruction: AstPlacement.instruction -> string *)
    (* Paramètre i : l'instruction à analyser *)
    (* Analyse les expressions et construit le code tam de l'instruction *)
    let rec analyse_code_instruction i =
        match i with 
            | AstType.Declaration(e,info) -> begin 
                match info_ast_to_info info with 
                    | InfoVar(_,t,dep,reg) -> begin
                        let codeE = analyse_code_expression e in 
                        "PUSH "^(string_of_int (getTaille t))^"\n"^codeE^"STORE ("^(string_of_int (getTaille t))^") "^(string_of_int dep)^"["^reg^"]\n"
                        end
                    | _ -> raise(ErreurInterne)
                    end
            | AstType.Affectation(aff,e)-> 
                let codeE = analyse_code_expression e in 
                let codeA = analyse_code_affectable_2 aff in 
                codeE^codeA
            | AstType.AffichageInt e -> let codeE = analyse_code_expression e in codeE^"SUBR IOut\n"
            | AstType.AffichageRat e -> let codeE = analyse_code_expression e in codeE^"CALL (ST) ROut\n"
            | AstType.AffichageBool e -> let codeE = analyse_code_expression e in codeE^"SUBR BOut\n"
            | AstType.AffichageTid e -> let codeE = analyse_code_expression e in codeE^"SUBR IOut\n"
            | AstType.Conditionnelle (cond,thenn,elsee) -> begin 
                let codeCond = analyse_code_expression cond in 
                let codeThen = analyse_code_bloc thenn in 
                let codeElse = analyse_code_bloc elsee in 
                let etiquette = getEtiquette () in
                let etiquette2 = getEtiquette () in 
                codeCond^"JUMPIF (0) "^etiquette^"\n"^codeThen^"JUMP "^etiquette2^"\n\n"^etiquette^"\n"^codeElse^"\n"^etiquette2^"\n"
                end
            | AstType.TantQue(c,b) -> begin
                let codeC = analyse_code_expression c in 
                let codeB = analyse_code_bloc b in 
                let debut = getEtiquette() in 
                let fin = getEtiquette() in 
                "\n"^debut^"\n"^codeC^"JUMPIF (0) "^fin^"\n"^codeB^"JUMP "^debut^"\n\n"^fin^"\n" 
                end
            | Empty -> ""
            | AstType.SwitchCase(e,l) -> begin
                let codeE = analyse_code_expression e in
                let etiquetteJUMP = getEtiquette() in
                let lr = List.rev l in (* on reverse pour l'ordre *)
                (analyse_code_case codeE lr etiquetteJUMP "")^"\n"^etiquetteJUMP^"\n"
            end
    
    (* analyse le swith  *)
    (* Paramètre expr : l'expression à l'interieur du switch *)
    (* Paramètre l : la liste des blocs *)
    (* Paremèrre et : etiquette des JUMPIF *)
    (* Paramètre etdef : etiquette du default *)
    and analyse_code_case expr l et etdef = 
        match l with
        | [] -> "JUMP "^(if etdef = "" then et else etdef)^"\n" (* on JUMP à la fin du switch lorsque les cases sont finis ou si il y a le default *)
        | firstcase::r ->
            let c,li,b = firstcase in
            (* analyse de la liste d'instruction *)
            let codeLI = analyse_code_bloc li in
            let etiquette = getEtiquette() in
            begin match c with 
                (* si le case est un default ou pas *)
                | AstType.Default -> 
                    let etdef = etiquette in 
                    begin match b with 
                        (* en fonction de la presence d'un break ou non *)
                        | True -> (analyse_code_case expr r et etdef)^"\n"^etiquette^"\n"^codeLI^"JUMP "^et^"\n"
                        | False -> (analyse_code_case expr r et etdef)^"\n"^etiquette^"\n"^codeLI^"\n" 
                        | _ -> raise(ErreurInterne)
                    end
                | _ -> 
                    let valeurcase case = begin 
                        (* on regarde le type du case *)
                        match case with
                            | AstType.Entier (n) -> n
                            | AstType.True -> 1
                            | AstType.False -> 0
                            | AstType.Tide n -> begin
                                match info_ast_to_info n with 
                                    | InfoEltEnum (_,_,dep,_)-> dep
                                    | _ -> raise(ErreurInterne)
                                end
                            | _ -> raise(ErreurInterne)
                            end in 
                    let valeur = valeurcase c in
                    match b with 
                    (* pareil, on regarde s'il y a un break ou pas *)
                        | True -> expr^"JUMPIF ("^(string_of_int valeur)^") "^etiquette^"\n"^(analyse_code_case expr r et etdef)^"\n"^etiquette^"\n"^codeLI^"JUMP "^et^"\n"
                        | False -> expr^"JUMPIF ("^(string_of_int valeur)^") "^etiquette^"\n"^(analyse_code_case expr r et etdef)^"\n"^etiquette^"\n"^codeLI^"\n" 
                        | _ -> raise(ErreurInterne)
                end
    (* analyse_code_bloc: AstPlacement.bloc -> string *)
    (* Paramètre li : le bloc à analyser *)
    (* Analyse les instructions du bloc et pop l'espace à la fin *)
    and analyse_code_bloc li =
        let taille = List.fold_right (fun i ti -> (taille_variables_declarees i)+ ti) li 0 in 
        let popfinal = "POP (0)" ^ (string_of_int taille) ^ "\n" in
        (analyse_code_li li) ^ popfinal

    and analyse_code_li li = String.concat "" (List.map analyse_code_instruction li)

    (* analyse_code_fonction: AstPlacement.fonction -> string *)
    (* Paramètre fonction(info,lp,li,e) : la fonction à analyser *)
    (* Analyse le bloc d'instruction et les expressions de la fonction et renvoie le code tam correspondant *)
    let analyse_code_fonction (Fonction(info,infoastp,li,e)) =
        let (nom,typeRet,typeParams) = begin
        match info_ast_to_info info with 
            | InfoFun(n,tr,_) -> begin 
                let infop = List.map info_ast_to_info infoastp in 
                (* on analyse la liste de tout les paramètres des fonctions déclarées *)
                let typep = List.map(
                    fun i-> begin 
                        match i with 
                            | InfoConst _ -> Int 
                            | InfoVar(_,t,_,_) -> t 
                            | _ -> raise(ErreurInterne)
                            end
                ) infop in
                (n,tr,typep)  
            end
            | _ -> raise(ErreurInterne)
        end in
        let taille_locale = List.fold_right (fun i ti -> (taille_variables_declarees i)+ ti) li 0 in
        let taille_params = List.fold_right (fun t qt -> (getTaille t) + qt) typeParams 0 in 
        (* on renomme les fonctions en fonction du type de leurs paramètres : pour la surcharge *)
        nom^"_"^(List.fold_right(fun tete queuetraitee -> (string_of_type tete)^"_"^queuetraitee) typeParams "" )^"\n"^
        (List.fold_right (fun t qt -> (analyse_code_instruction t)^"\n"^qt) li "")^"\n"^
        (analyse_code_expression e)^
        "POP ("^(string_of_int (getTaille typeRet))^") "^(string_of_int taille_locale)^"\n"^
        "RETURN ("^(string_of_int (getTaille typeRet))^") "^(string_of_int taille_params)^"\n"

    (* analyser : AstPlacement.programme -> string *)
    (* Paramètre : le programme à analyser *)
    (* Analyse le programme *)
    let analyser (Programme(_,fonctions, prog)) =
    let fonc = List.fold_left (fun t qt -> t ^ analyse_code_fonction qt ^ "\n") "" fonctions
    and main = "LABEL main\n" ^ (analyse_code_bloc prog) ^ "HALT\n" in
    getEntete () ^ fonc ^ main
end
