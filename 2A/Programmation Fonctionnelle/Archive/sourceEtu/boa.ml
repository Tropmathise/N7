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

module Regle4 : Regle with type td = char list = 
struct
  type tid = int 
  type td = char list 
  let id = 4
  let rec appliquer terme = match terme with
    | [] -> []
    | [elt] -> []
    | [e1;e2]-> if [e1;e2]=['A';'A'] then [[]]
              else []
    | e1::e2::q -> if [e1;e2]=['A';'A'] then 
              q::List.map(fun e -> e1::e) (appliquer (e2::q))
              else 
                List.map(fun e -> e1::e) (appliquer (e2::q))
end 

module type ArbreReecriture =
sig
  type tid = int
  type td
  type arbre_reecriture = Noeud of td *((branche) list)
  and branche = int * arbre_reecriture

  val creer_noeud : td -> branche list -> arbre_reecriture

  val racine : arbre_reecriture -> td
  val fils : arbre_reecriture -> branche list

  val appartient : td -> arbre_reecriture -> bool
end

module ArbreReecritureBOA : ArbreReecriture with type td = char list =
struct 
  type tid = int
  type td = char list
  type arbre_reecriture = Noeud of td *((branche) list)
  and branche = int * arbre_reecriture
  let creer_noeud td brl = Noeud(td, brl)
  let racine (Noeud(terme, _)) = terme
  let fils (Noeud(_, fi)) = fi
  let rec appartient terme arbre = match (racine arbre) with 
    | terme -> true 
    | _ -> match fils arbre with 
      | [] -> false 
      | t::q -> appartient terme (snd t)

end
