(* interfarce pour la création d'une regle de réécriture *)
module type Regle =
sig
  (* type identifiants *)
  type tid = int
  (* type des termnes *)
  type td
  (** Renvoie l'itentifiant de la regle 
      signature : tid 
      parametre : unit
      resultat : l'identifiant de la regle *)
  val id : tid
  (** Applique la regle sur la chaine donnée
    signature : td -> td list 
    parametre : terme 
    resultats : une liste de terme  *)
  val appliquer : td -> td list
end 

module Regle1 : Regle with type td = char list = 
struct
  type tid = int 
  type td = char list 
  let id = 1
  let rec appliquer terme = match terme with
    | [] -> []
    | [elt] -> if elt='O' then [[elt;'A']]
              else [[]]
    | t::q -> List.map(fun e -> t::e) (appliquer q)
end 

module Regle2 : Regle with type td = char list = 
struct
  type tid = int 
  type td = char list 
  let id = 2
  let appliquer terme = match terme with
    | [] -> []
    | t::q -> if t='B' then [terme@q]
              else [terme]
end 

module Regle3 : Regle with type td = char list = 
struct
  type tid = int 
  type td = char list 
  let id = 3
  let rec appliquer terme = match terme with
    | [] -> []
    | [_] -> []
    | [_;_] ->  []
    | [t1;t2;t3] -> if ([t1;t2;t3] = ['O';'O';'O'] || [t1;t2;t3] = ['A';'O';'A']) then
                      [['A']]
                    else 
                      []
    | e1::e2::e3::q -> if ([e1;e2;e3] = ['O';'O';'O'] || [e1;e2;e3] = ['A';'O';'A']) then
                      ('A'::q)::(List.map (fun e -> e1::e) (appliquer (e2::e3::q)))
                      else List.map(fun e -> e1::e)(appliquer (e2::e3::q))
end 

module type ArbreReecriture =
sig
  (*
  type tid = int
  type td
  type arbre_reecriture = ...

  val creer_noeud : ...

  val racine : ...
  val fils : ..

  val appartient : td -> arbre_reecriture -> bool
  *)
end