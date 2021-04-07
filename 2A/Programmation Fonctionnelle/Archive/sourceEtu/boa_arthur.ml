
(* module abstrayant les regles de réécriture *)
module type Regle =
sig
  (* type des identifiants *)
  type tid = int
  (* type des termes *)
  type td
  (** retourner l'identifiant
      signature : tid
      parametre : unit
      retour : l'identifiant de la regle *)
  val id : tid
  (** appliquer la regle sur un mot
      signature : td -> td list
      parametre : terme
      retour : une liste de terme *)
  val appliquer : td -> td list
end

module Regle1 : Regle with type td = char list =
struct
  type tid = int
  type td = char list

  let id = 1

  let rec appliquer terme =
    match terme with
    | [] -> []
    | [el] -> if el = 'O' then
                [[el;'A']]
              else
                [[]]
    | t::q -> List.map (fun e -> t::e) (appliquer q)
end

module Regle2 : Regle with type td = char list =
struct
  type tid = int
  type td = char list

  let id = 2

  let rec appliquer terme =
    match terme with
    | [] -> []
    | t::q -> if t = 'B' then
                [terme@q]
              else
                [terme]
end

module Regle3 : Regle with type td = char list =
struct
  type tid = int
  type td = char list

  let id = 3

  let rec appliquer terme =
    match terme with
    | [] -> []
    | [e] -> []  
    | [t1;t2] -> []
    | [t1;t2;t3] -> if ([t1;t2;t3] = ['O';'O';'O'] || [t1;t2;t3] = ['A';'O';'A']) then
                      [['A']]
                    else 
                      []
    | t1::t2::t3::q -> if ([t1;t2;t3] = ['O';'O';'O'] || [t1;t2;t3] = ['A';'O';'A']) then
                        ('A'::q)::(List.map (fun e -> t1::e) (appliquer (t2::t3::q)))
                       else 
                        List.map (fun e -> t1::e) (appliquer (t2::t3::q))
end

module Regle4 : Regle with type td = char list =
struct
  type tid = int
  type td = char list

  let id = 4

  let rec appliquer terme =
    match terme with
    | [] -> []
    | [e] -> []  
    | [t1;t2] -> if [t1;t2] = ['A';'A'] then
                      [[]]
                    else 
                      []
    | t1::t2::q -> if [t1;t2] = ['A';'A'] then
                        q::List.map (fun e -> t1::e) (appliquer (t2::q))
                       else 
                        List.map (fun e -> t1::e) (appliquer (t2::q))

end


module type ArbreReecriture =
sig
  type tid = int
  type td
  type arbre_reecriture = Noeud of td * branche list
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
  type arbre_reecriture = Noeud of td * branche list
                          and branche = int * arbre_reecriture

  let creer_noeud terme brl = Noeud (terme, brl)

  let racine (Noeud (terme, _)) = terme
  let fils (Noeud (_, brl)) = brl

  let rec appartient terme a = 
    if racine a = terme then
      true
    else
      match fils a with
      | [] -> false
      | (_, ta)::q -> appartient terme ta || appartient terme (creer_noeud (racine a) q)

  let br1 = [(1,Noeud(['B';'O';'O';'O';'O';'A'],[])); (2,Noeud(['B';'O';'O';'O';'O';'O';'O';'O';'O'], [])); 
            (3,Noeud(['B';'A';'O'],[])); (3,Noeud(['B';'O';'A'],[]))]
  let f1 = Noeud (['B';'O';'O';'O'], br1)
  let br2 = [(2, Noeud(['B';'O';'O';'A';'O';'O';'A'],[]))]
  let f2 = Noeud (['B';'O';'O';'A'], br2)
  let a1 = Noeud (['B';'O';'O'], [(1,f2);(2,f1)])

  let%test _ = racine a1 = ['B';'O';'O']
  let%test _ = fils a1 = [(1,f2);(2,f1)]
  let%test _ = appartient ['B';'O';'A'] a1
  let%test _ = appartient ['B';'O';'O';'A'] a1
  let%test _ = not (appartient ['B';'A';'O';'O';'O'] a1)

end

