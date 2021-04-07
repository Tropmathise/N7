(* Module de la passe de gestion des identifiants *)
module PasseTdsRat : Passe.Passe with type t1 = Ast.AstSyntax.programme and type t2 = Ast.AstTds.programme =
struct

  open Tds
  open Exceptions
  open Ast
  open AstTds

  type t1 = Ast.AstSyntax.programme
  type t2 = Ast.AstTds.programme
 
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
  | AstSyntax.Ident nom ->
    begin
        match (chercherGlobalement tds nom) with 
          | Some info_ast -> begin
                              match (info_ast_to_info info_ast) with 
                              | InfoVar _ -> AstTds.Ident info_ast
                              | InfoConst (_,v) -> AstTds.Entier v
                              | _ -> raise (MauvaiseUtilisationIdentifiant (nom));
                            end
          | None -> raise (IdentifiantNonDeclare (nom))
    end
  | AstSyntax.True -> AstTds.True
  | AstSyntax.False -> AstTds.False
  | AstSyntax.Entier int -> AstTds.Entier int 
  | AstSyntax.Binaire (operateur,exp1,exp2) -> AstTds.Binaire(operateur,(analyse_tds_expression tds exp1),(analyse_tds_expression tds exp2))

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
      begin
        match chercherGlobalement tds n with
        | None -> 
          (* L'identifiant n'est pas trouvé dans la tds globale. *) 
          raise (IdentifiantNonDeclare n)
        | Some info -> 
          (* L'identifiant est trouvé dans la tds globale, 
          il a donc déjà été déclaré. L'information associée est récupérée. *) 
          begin
            match info_ast_to_info info with
            | InfoVar _ -> 
              (* Vérification de la bonne utilisation des identifiants dans l'expression *)
              (* et obtention de l'expression transformée *) 
              let ne = analyse_tds_expression tds e in
              (* Renvoie de la nouvelle affectation où le nom a été remplacé par l'information 
              et l'expression remplacée par l'expression issue de l'analyse *)
               Affectation (ne, info)
            |  _ ->
              (* Modification d'une constante ou d'une fonction *)  
              raise (MauvaiseUtilisationIdentifiant n) 
          end
      end
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
  match chercherLocalement maintds n with 
    | None -> begin 
      let tdsfonc = creerTDSFille maintds in 
      let lt = fst (List.split lp) in 
      let info_f = InfoFun(n, t, lt) in 
      let info_ast_f = info_to_info_ast info_f in
      ajouter maintds n info_ast_f;
      ajouter tdsfonc n info_ast_f;
      let nlp = List.map(analyse_tds_parametre tdsfonc) lp in
      let nli = List.map(analyse_tds_instruction tdsfonc) li in
      let ne = analyse_tds_expression tdsfonc e in 
      Fonction(t,info_ast_f, nlp, nli, ne)
      end
    | Some _ -> raise(DoubleDeclaration n)
    
(* analyser : AstSyntax.ast -> AstTds.ast *)
(* Paramètre : le programme à analyser *)
(* Vérifie la bonne utilisation des identifiants et tranforme le programme
en un programme de type AstTds.ast *)
(* Erreur si mauvaise utilisation des identifiants *)
let analyser (AstSyntax.Programme (fonctions,prog)) =
  let tds = creerTDSMere () in
  let nf = List.map (analyse_tds_fonction tds) fonctions in
  let nb = analyse_tds_bloc tds prog in
  Programme (nf,nb)

end
