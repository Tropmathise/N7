
module PasseTypeRat : Passe.Passe with type t1 = Ast.AstTds.programme and type t2 = Ast.AstType.programme =
struct 

    open Tds
    open Exceptions
    open Ast 
    open AstType 
    open Type

    type t1 = AstTds.programme
    type t2 = AstType.programme

    (* analyse_type_enumeration : AstTds.enumeration -> AstType.enumeration *)
    (* Paramètre enum: l''énumeration' à analyser *)
    (* Vérifie la bonne utilisation du type et tranforme l'énumeration
    en une énumeration de type AstType.enumeration *)
    (* Erreur si problème de typage *)
    let analyse_type_enumeration (AstTds.Enumeration(info,linfo)) =
        Enumeration(info,linfo)

    let anaylse_type_enumerations = List.map analyse_type_enumeration


    (* analyse_type_affectable : AstSyntax.affectable -> AstType.affectable *)
    (* Paramètre a: l'affectable à analyser *)
    (* Vérifie la bonne utilisation du type et tranforme l'affectable
    en un affectable de type AstType.affectable et renvoie aussi le type de l'affectable *)
    (* Erreur si problème de typage *)
    let rec analyse_type_affectable aff = 
        match aff with 
            | AstTds.Ident info -> begin 
                match info_ast_to_info info with 
                    | InfoVar(_,t,_,_) -> (Ident info, t)
                    | InfoConst _ -> (Ident info, Int)
                    | InfoEltEnum (nt,_,_,_) -> (Ident info, Tid nt)
                    | _ -> raise(ErreurInterne)
                    end
            | AstTds.Valeur(aff) -> begin
                match analyse_type_affectable aff with 
                    | (naff,Pointeur t) -> (Valeur(naff),t)
                    | _ -> raise(NotAPointer)
                    end
                    
    (* analyse_type_expression : AstTds.expression -> Type.typ * AstType.expression *)
    (* Paramètre : e -> expression à analyser *)
    (* Vérifie la bonne utilisation des identifiants et tranforme l'expression
    en une expression de type AstTds.expression *)
    (* Erreur si mauvaise utilisation des types *)
    let rec analyse_type_expression e =
        match e with
            | AstTds.AppelFonction (info,le) ->
            begin
            match (info_ast_to_info info) with
                | InfoFun (_,typeRet,lltp) ->
                    let split = List.split (List.map analyse_type_expression le) in
                    let nle = fst split in 
                    let ltype = snd split in begin
                    (* regarde si les types de parametres appelés et stockés sont les mêmes *)
                    match est_compatible_infofun ltype lltp with 
                        | None -> raise (TypesParametresInattendus (ltype,lltp))
                        | Some _ -> (AppelFonction (info,nle),typeRet)
                        end
                | _ -> raise ErreurInterne
                end
        | AstTds.Rationnel (e1,e2) ->
            let (ne1,t1) = analyse_type_expression e1 in
            let (ne2,t2) = analyse_type_expression e2 in
            if (t1 != Int) then
                raise (TypeInattendu(t1,Int))
            else if (t2 != Int) then
                raise (TypeInattendu(t2,Int))
            else (Rationnel(ne1,ne2),Rat)
        | AstTds.Numerateur e1 ->
            let (ne1,t1) = analyse_type_expression e1 in
            if est_compatible t1 Rat then
              (Numerateur ne1, Int)
            else 
                raise (TypeInattendu(t1,Rat))
         | AstTds.Denominateur e1 ->
              let (ne1,t1) = analyse_type_expression e1 in
              if (t1 = Rat) then
                (Denominateur ne1, Int)
              else 
                raise (TypeInattendu(t1,Rat))
        | AstTds.Binaire (op_binaire, e1, e2) ->
            begin
            let (ne1, te1) = analyse_type_expression e1 in
            let (ne2, te2) = analyse_type_expression e2 in
            match op_binaire with
                | Plus -> 
                    begin
                    match (te1, te2) with 
                    | (Int, Int) ->  (Binaire (PlusInt, ne1,  ne2),Int)
                    | (Rat, Rat) -> (Binaire (PlusRat, ne1,  ne2),Rat)
                    | _ -> raise (TypeBinaireInattendu (Plus, te1, te2))
                    end
                | Mult ->
                    begin
                    match (te1, te2) with 
                    | (Int, Int) ->  (Binaire (MultInt, ne1,  ne2),Int)
                    | (Rat, Rat) -> (Binaire (MultRat, ne1,  ne2),Rat)
                    | _ -> raise (TypeBinaireInattendu (Mult, te1, te2))
                    end
                | Equ -> 
                    begin
                    match (te1, te2) with 
                    | (Int, Int) ->  (Binaire (EquInt, ne1,  ne2), Bool)
                    | (Bool, Bool) -> (Binaire (EquBool, ne1,  ne2), Bool)
                    | (Tid s, Tid s2) -> if s=s2 then (Binaire (EquEnum, ne1,ne2), Bool) else raise(TypeBinaireInattendu(Equ,te1,te2))
                    | _ -> raise (TypeBinaireInattendu (Equ, te1, te2))
                    end
                | Inf -> 
                    begin
                    if est_compatible te1 Int && est_compatible te2 Int
                    then 
                        (Binaire (Inf, ne1,  ne2), Bool)
                    else 
                        raise (TypeBinaireInattendu (Inf, te1, te2)) 
                    end
            end
        | AstTds.True -> (True, Bool)
        | AstTds.False -> (False, Bool)
        | AstTds.Entier(i) -> (Entier i, Int)
        | AstTds.Null -> (Null,Pointeur Undefined)
        | AstTds.New t -> New t, Pointeur t
        | AstTds.Adresse info -> begin 
            match info_ast_to_info info with
                | InfoVar(_,t,_,_) -> (Adresse info, Pointeur t)
                | _ -> raise(ErreurInterne)
            end
        | AstTds.Affectable a -> let (na,t)= analyse_type_affectable a in (Affectable na, t)
        | AstTds.Tide info -> begin
            match info_ast_to_info info with 
                | InfoEltEnum (nt,_,_,_) -> (Tide info, Tid nt)
                | _ -> raise(TypeEnumInattendu)
            end
        | AstTds.Default -> (Default,Def)
    

    (* analyse_type_instruction : AstTds.instruction -> AstType.instruction *)
    (* Paramètre : i -> instruction à analyser *)
    (* Vérifie la bonne utilisation des identifiants et tranforme l'instruction en une instruction de type AstType.instruction *)
    (* Erreur si mauvaise utilisation des types *)
    let rec analyse_type_instruction i = 
    match i with 
        | AstTds.Declaration (t,e,info) -> begin 
            let (ne,te) = analyse_type_expression e in 
            if est_compatible t te then 
                let _ = modifier_type_info t info in
                Declaration(ne,info)
            else 
                raise(TypeInattendu(te,t))
        end
        | AstTds.Affectation(aff, e) ->
            let (naff, taff) = analyse_type_affectable aff in
            let (ne, texp) = analyse_type_expression e in
            if est_compatible texp taff then Affectation(naff, ne)
            else raise (TypeInattendu(texp, taff))
        | AstTds.Affichage e -> 
            let (ne,te) = analyse_type_expression e in 
        begin
          match te with 
          | Int -> AffichageInt ne
          | Rat -> AffichageRat ne
          | Bool -> AffichageBool ne
          | Tid _ -> raise(TypeNonAffichable) (* on pourrait mettre AffichageInt *)
          | Pointeur _ -> AffichageInt ne
          | Undefined -> raise (TypeInattendu(te,te))
          | Def -> raise (TypeNonAffichable) (* on ne peut pas afficher ce type *)
        end

        | AstTds.Conditionnelle(c,t,e) -> 
            let (nc,tc) = analyse_type_expression c in 
            if not (est_compatible Bool tc) then 
                raise (TypeInattendu(tc,Type.Bool))
            else 
                let nt = analyse_type_bloc t in
                let ne = analyse_type_bloc e in 
                Conditionnelle(nc,nt,ne)
        | AstTds.TantQue(c,b) -> 
            let (nc,tc) = analyse_type_expression c in 
            if not (est_compatible Bool tc) then 
                raise (TypeInattendu(tc, Bool))
            else 
            let nb = analyse_type_bloc b in 
            TantQue(nc,nb)
        | AstTds.Empty -> Empty
        | AstTds.SwitchCase (e,l) ->
            let (ne,te) = analyse_type_expression e in
            (* split3 qui split l en 3 *)
            let lc,lli,lb = split3 l in
            (* on analyse la liste des cas *)
            let nlca = List.map analyse_type_expression lc in
            (* on analyse la liste des booleens (break ou pas break) *)
            let nlba = List.map analyse_type_expression lb in
            let nlb,nltb = List.split nlba in
            let nlc,nltc = List.split nlca in
            (* on verifie que tout les types des cases sont les memes *)
            List.iter (fun x -> if (not (est_compatible te x) && x!=Def)  then raise (TypeInattendu(te,x))) nltc;
            (* on verifie que tout les types des booleens du break sont des booleens *)
            List.iter (fun x -> if not (est_compatible Bool x) then raise (TypeInattendu(Bool,x))) nltb;
            (* on analyse les blocs *)
            let nlli = List.map analyse_type_bloc lli in
            (* on recombine le tout *)
            let nl = merge3 (nlc,nlli,nlb) in
            SwitchCase (ne,nl)

        
    (* analyse_type_bloc : AstTds.bloc -> AstType.bloc *)
    (* Paramètre : li -> liste des instructions à analyser *)
    (* Vérifie la bonne utilisation des identifiants et tranforme le bloc
    en un bloc de type AstType.bloc *)
    (* Erreur si mauvaise utilisation des types *)
    and analyse_type_bloc li =
    List.map analyse_type_instruction li

    (* analyse_type_fonction : AstTds.fonction -> AstType.fonction *)
    (* Paramètre : f -> fonction à analyser *)
    (* Vérifie la bonne utilisation des identifiants et transforme la fonction
    en une fonction de type AstType.fonction *)
    (* Erreur si mauvaise utilisation des types *)
    let analyse_type_fonction (AstTds.Fonction(t,info,lp,li,e))  =
        match info_ast_to_info info with
        | InfoFun(n,_,llt) ->   let split = List.split lp in 
                                let lt = fst split in 
                                let lastp = snd split in 
                                let match_types = List.fold_right (fun tete qt -> (tete=lt)::qt) llt [] in 
                                (* si une fonction a deja le meme nom et les memes parametres : il faut forcement que length > 1 *)
                                if List.mem true match_types && List.length llt > 1 then
                                    (*une fonction a deja exactement la meme signature *)
                                    raise (DoubleDeclaration n)
                                else (* fonction surchargée, ajouter les types de parametres à la liste *)
                                    ajouter_lt_info lt info; 
                                let nli = List.map analyse_type_instruction li in
                                let (ne,te) = analyse_type_expression e in
                                if not (est_compatible te t) then
                                    raise (TypeInattendu (te,t))
                                else
                                Fonction(info,lastp,nli,ne)
        | _ -> raise ErreurInterne


    (* analyser : AstTds.ast -> AstType.ast *)
    (* Paramètre : le programme à analyser *)
    (* Vérifie la bonne utilisation des types et tranforme le programme
    en un programme de type AstType.ast *)
    (* Erreur si mauvaise utilisation des types *)
    let analyser (AstTds.Programme(enums, fonctions, prog)) =
        let nle = anaylse_type_enumerations enums in
        let nfcts = List.map analyse_type_fonction fonctions in
        let nprog = analyse_type_bloc prog in
        Programme(nle,nfcts, nprog)
end
