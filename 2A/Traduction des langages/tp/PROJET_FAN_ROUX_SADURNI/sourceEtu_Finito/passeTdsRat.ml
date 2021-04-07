
(* Module de la passe de gestion des identifiants *)
module PasseTdsRat : Passe.Passe with type t1 = Ast.AstSyntax.programme and type t2 = Ast.AstTds.programme =
struct

  open Tds
  open Exceptions
  open Ast
  open AstTds

  type t1 = Ast.AstSyntax.programme
  type t2 = Ast.AstTds.programme


(* ajouter_enum_info : ajouter les éléments de la liste énuméréé dans
l'ast. Double déclaration si déjà déclarée. *)
let ajouter_enum_info tds nt ne i =
   match chercherLocalement tds ne with 
    | None -> 
          let info = InfoEltEnum(nt,ne,i,"SB") in 
          let info_ast = info_to_info_ast info in
          ajouter tds ne info_ast;
          info_ast
    | Some _ -> raise (DoubleDeclaration ne)

(* analyse_tds_enumeration : AstSyntax.enumeration -> AstTds.enumeration *)
(* Paramètre tds : la table des symboles courante *)
(* Paramètre enum : l''enumeration à analyser *)
(* Vérifie la bonne utilisation des identifiants et tranforme l'énumération
en une énumeration de type AstTds.enumeration *)
(* Erreur si mauvaise utilisation des identifiants *)
let analyse_tds_enumeration tds (AstSyntax.Enumeration(n,l)) = 
  if l == [] then raise(EnumVide n)
  else 
    match chercherLocalement tds n with 
      | None -> 
            let info = InfoEnum(n,l) in 
            let info_ast = info_to_info_ast info in
            (* ajout de l'enum *)
            ajouter tds n info_ast;
            (* ajout de chaque enum de la liste *)
            let nl = List.fold_right(fun tete qt -> (ajouter_enum_info tds n tete (List.length qt))::qt) l [] in
            Enumeration(info_ast,nl)
      | Some _ -> raise (DoubleDeclaration n)

let analyse_tds_enumerations tds le =
  let nle = List.map (analyse_tds_enumeration tds) le in 
  nle

(* analyse_tds_affectable : AstSyntax.affectable -> AstTds.affectable *)
(* Paramètre tds : la table des symboles courante *)
(* Paramètre modif : précise si l'affectable est à gauche ou à droite *)
(* Paramètre a : l'affectable à analyser *)
(* Vérifie la bonne utilisation des identifiants et tranforme l'affectable
en un affectable de type AstTds.affectable *)
(* Erreur si mauvaise utilisation des identifiants *)
let rec analyse_tds_affectable tds modif a =
  match a with 
    | AstSyntax.Ident(n) -> begin
      match chercherGlobalement tds n with 
        | None -> raise (IdentifiantNonDeclare n)
        | Some info -> begin
          match info_ast_to_info info with 
            | InfoFun (_,_,_) -> raise(MauvaiseUtilisationIdentifiant n)
            | InfoVar (_,_,_,_) -> Ident(info)
            | InfoConst (_,_) -> 
                if modif then raise(MauvaiseUtilisationIdentifiant n)
                else Ident(info)
            | InfoEnum(_,_) -> Ident(info)
            | InfoEltEnum _ -> Ident(info)
            end 
    end 
    | AstSyntax.Valeur(v) -> AstTds.Valeur(analyse_tds_affectable tds modif v)

(* analyse_tds_expression : AstSyntax.expression -> AstTds.expression *)
(* Paramètre tds : la table des symboles courante *)
(* Paramètre e : l'expression à analyser *)
(* Vérifie la bonne utilisation des identifiants et tranforme l'expression
en une expression de type AstTds.expression *)
(* Erreur si mauvaise utilisation des identifiants *)
let rec analyse_tds_expression tds e = match e with
  | AstSyntax.AppelFonction (nom,listparam) ->
      begin
      match (chercherGlobalement tds nom) with 
        | Some info_ast -> begin
                            match (info_ast_to_info info_ast) with 
                            | InfoFun _ -> let ne = (List.map (analyse_tds_expression tds) listparam) in
                                            AstTds.AppelFonction(info_ast,ne)
                            | _ -> raise (MauvaiseUtilisationIdentifiant (nom));
                           end
        | None -> raise (IdentifiantNonDeclare (nom))
      end
  | AstSyntax.Rationnel (exp1,exp2) -> AstTds.Rationnel (analyse_tds_expression tds exp1, analyse_tds_expression tds exp2)
  | AstSyntax.Numerateur exp ->AstTds.Numerateur (analyse_tds_expression tds exp)
  | AstSyntax.Denominateur exp -> AstTds.Denominateur (analyse_tds_expression tds exp)
  | AstSyntax.True -> AstTds.True
  | AstSyntax.False -> AstTds.False
  | AstSyntax.Entier int -> AstTds.Entier int 
  | AstSyntax.Binaire (operateur,exp1,exp2) -> AstTds.Binaire(operateur,(analyse_tds_expression tds exp1),(analyse_tds_expression tds exp2))
  | AstSyntax.Affectable aff -> Affectable (analyse_tds_affectable tds false aff)
  | AstSyntax.Null -> Null 
  | AstSyntax.New t -> New t
  | AstSyntax.Adresse n -> begin 
    match chercherGlobalement tds n with 
    | None -> raise(IdentifiantNonDeclare n)
    | Some info -> begin 
      match info_ast_to_info info with 
        | InfoEnum _ -> raise(MauvaiseUtilisationIdentifiant n)
        | InfoEltEnum _ -> Adresse info
        | InfoVar _ -> Adresse info
        | InfoConst (_,_) -> raise(MauvaiseUtilisationIdentifiant n)
        | InfoFun _ -> raise(MauvaiseUtilisationIdentifiant n)
      end 
    end 
  | AstSyntax.Tide n -> begin
        match (chercherGlobalement tds n) with 
          | Some info_ast -> begin
              match (info_ast_to_info info_ast) with 
                    | InfoEltEnum _ -> AstTds.Tide info_ast
                    | _ -> raise (MauvaiseUtilisationIdentifiant (n));
                end
          | None -> raise (IdentifiantNonDeclare (n))
    end
  | AstSyntax.Default -> Default 

(* analyse_tds_instruction : AstSyntax.instruction -> tds -> AstTds.instruction *)
(* Paramètre tds : la table des symboles courante *)
(* Paramètre i : l'instruction à analyser *)
(* Vérifie la bonne utilisation des identifiants et tranforme l'instruction
en une instruction de type AstTds.instruction *)
(* Erreur si mauvaise utilisation des identifiants *)
let rec analyse_tds_instruction tds i =
  match i with
  | AstSyntax.Declaration (t, n, e) ->
      begin
        match chercherLocalement tds n with
        | None ->
            (* L'identifiant n'est pas trouvé dans la tds locale, 
            il n'a donc pas été déclaré dans le bloc courant *)
            (* Vérification de la bonne utilisation des identifiants dans l'expression *)
            (* et obtention de l'expression transformée *) 
            let ne = analyse_tds_expression tds e in
            (* Création de l'information associée à l'identfiant *)
            let info = InfoVar (n,Undefined, 0, "") in
            (* Création du pointeur sur l'information *)
            let ia = info_to_info_ast info in
            (* Ajout de l'information (pointeur) dans la tds *)
            ajouter tds n ia;
            (* Renvoie de la nouvelle déclaration où le nom a été remplacé par l'information 
            et l'expression remplacée par l'expression issue de l'analyse *)
            Declaration (t, ne, ia) 
        | Some _ ->
            (* L'identifiant est trouvé dans la tds locale, 
            il a donc déjà été déclaré dans le bloc courant *) 
            raise (DoubleDeclaration n)
      end
  | AstSyntax.Affectation (n,e) ->
      Affectation (analyse_tds_affectable tds true n, analyse_tds_expression tds e)
  | AstSyntax.Constante (n,v) -> 
      begin
        match chercherLocalement tds n with
        | None -> 
        (* L'identifiant n'est pas trouvé dans la tds locale, 
        il n'a donc pas été déclaré dans le bloc courant *)
        (* Ajout dans la tds de la constante *)
        ajouter tds n (info_to_info_ast (InfoConst (n,v))); 
        (* Suppression du noeud de déclaration des constantes devenu inutile *)
        Empty
        | Some _ ->
          (* L'identifiant est trouvé dans la tds locale, 
          il a donc déjà été déclaré dans le bloc courant *) 
          raise (DoubleDeclaration n)
      end
  | AstSyntax.Affichage e -> 
      (* Vérification de la bonne utilisation des identifiants dans l'expression *)
      (* et obtention de l'expression transformée *)
      let ne = analyse_tds_expression tds e in
      (* Renvoie du nouvel affichage où l'expression remplacée par l'expression issue de l'analyse *)
      Affichage (ne)
  | AstSyntax.Conditionnelle (c,t,e) -> 
      (* Analyse de la condition *)
      let nc = analyse_tds_expression tds c in
      (* Analyse du bloc then *)
      let tast = analyse_tds_bloc tds t in
      (* Analyse du bloc else *)
      let east = analyse_tds_bloc tds e in
      (* Renvoie la nouvelle structure de la conditionnelle *)
      Conditionnelle (nc, tast, east)
  | AstSyntax.TantQue (c,b) -> 
      (* Analyse de la condition *)
      let nc = analyse_tds_expression tds c in
      (* Analyse du bloc *)
      let bast = analyse_tds_bloc tds b in
      (* Renvoie la nouvelle structure de la boucle *)
      TantQue (nc, bast)  
  | AstSyntax.SwitchCase (e,l) ->
      let ne = analyse_tds_expression tds e in
      let lc,lli,lb = split3 l in
      let nlc = List.map (analyse_tds_expression tds) lc in
      let nlb = List.map (analyse_tds_expression tds) lb in
      let nlli = List.map (analyse_tds_bloc tds) lli in
      let nl = merge3 (nlc,nlli,nlb) in
      SwitchCase (ne,nl)

(* analyse_tds_bloc : AstSyntax.bloc -> AstTds.bloc *)
(* Paramètre tds : la table des symboles courante *)
(* Paramètre li : liste d'instructions à analyser *)
(* Vérifie la bonne utilisation des identifiants et tranforme le bloc
en un bloc de type AstTds.bloc *)
(* Erreur si mauvaise utilisation des identifiants *)
and analyse_tds_bloc tds li =
  (* Entrée dans un nouveau bloc, donc création d'une nouvelle tds locale 
  pointant sur la table du bloc parent *)
  let tdsbloc = creerTDSFille tds in
  (* Analyse des instructions du bloc avec la tds du nouveau bloc 
  Cette tds est modifiée par effet de bord *)
   let nli = List.map (analyse_tds_instruction tdsbloc) li in
   (* afficher_locale tdsbloc ;*) (* décommenter pour afficher la table locale *)
   nli


(* analyse_tds_parametre : AstSyntax.parametre -> AstTds.parametre *)
(* Paramètre tdsfonc : la table des symboles d'une fonction *)
(* Paramètre (ptype, pnom) : le paramètre à analyser (son type, son nom) *)
(* Vérie que le nom du paramètre est unique et crée une infoVar associé  *)
(* Erreur si double déclaration du paramètre *)
let analyse_tds_parametre tdsfonc (type_p, nom_p) = 
  match chercherLocalement tdsfonc nom_p with 
    | None -> 
      begin
        let info  = InfoVar(nom_p, type_p, 0, "") in
        let pia = info_to_info_ast info in
        ajouter tdsfonc nom_p pia;
        (type_p, pia)
      end      
    | Some _ -> raise (DoubleDeclaration nom_p)
  
(* analyse_tds_fonction : AstSyntax.fonction -> AstTds.fonction *)
(* Paramètre tds : la table des symboles courante *)
(* Paramètre : la fonction à analyser *)
(* Vérifie la bonne utilisation des identifiants et transforme la fonction
en une fonction de type AstTds.fonction *)
(* Erreur si mauvaise utilisation des identifiants *)
let analyse_tds_fonction maintds (AstSyntax.Fonction(t,n,lp,li,e))  =
  let tdsfonc = creerTDSFille maintds in 
  let lt = fst (List.split lp) in
  let info_ast_f =
  begin
  match chercherLocalement maintds n with 
    (* si elle n'est pas présente on l'ajoute *)
    | None ->
      let info_f = InfoFun(n, t, [lt]) in
      info_to_info_ast info_f
    (* si elle est présente on renvoie la meme info *)
    | Some info_old -> info_old
  end in
  (* ajout dans les tds *)
  ajouter maintds n info_ast_f;
  ajouter tdsfonc n info_ast_f;
  let nlp = List.map(analyse_tds_parametre tdsfonc) lp in
  let nli = List.map(analyse_tds_instruction tdsfonc) li in
  let ne = analyse_tds_expression tdsfonc e in
  Fonction(t,info_ast_f, nlp, nli, ne)
  
(* analyser : AstSyntax.ast -> AstTds.ast *)
(* Paramètre : le programme à analyser *)
(* Vérifie la bonne utilisation des identifiants et tranforme le programme
en un programme de type AstTds.ast *)
(* Erreur si mauvaise utilisation des identifiants *)
let analyser (AstSyntax.Programme (le, fonctions,prog)) =
  let tds = creerTDSMere () in
  let nle = analyse_tds_enumerations tds le in
  let nf = List.map (analyse_tds_fonction tds) fonctions in
  let nb = analyse_tds_bloc tds prog in
  Programme (nle,nf,nb)

end
