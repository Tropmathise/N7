(** Exercice à rendre **)
(* Exercice 5 *)
(* PGCD -> pgcd.ml *)
(** 
   pgcd : int -> int -> int
   calcule la le pcgd de a b 
   Parametres
   - a : int, le premier entier
   - b : int, le deuxieme entier 
   Resultat : int, pgcd de (a,b)
   Précondition : a>0 et b>0
*)
let rec pgcd a b =
  if a = b 
     then a
  else if a>b 
     then pgcd (a-b) b
  else pgcd a (b-a)

let%test _ = pgcd 5 15 = 5
let%test _ = pgcd 26 7 = 1
let%test _ = pgcd 5 60 = 17
let%test _ = pgcd 36 8 = 4

