(****** Algorithmes combinatoires et listes ********)

(*** Ajouter un element dans un ensemble***)
(* CONTRAT 
Fonction qui ajoute un element dans une liste de liste
Parametre : l'element a inserer
Parametre : l'ensemble dans lequel inserer l'element
*)
let rec ajouter element ensemble =
  match ensemble with 
  | []->[]
  | tete::queue -> (element::tete)::(ajouter element queue)


(*** Combinaisons d'une liste ***)
(* CONTRAT 
Fonction qui prend en argument une liste l et un entier positif k, et qui renvoie
la liste de toutes les combinaisons possibles de k éléments dans l.
exemple : combinaison 3 [1;2;3;4] = [[1;2;3]; [1;2;4]; [1;3;4]; [2;3;4]]
Parametre k : le nombre de combinaison
Parametre l : la liste
Resultat : la liste des listes de combinaison possible
*)
let rec combinaison k l = 
match k,l with
| 0,_ -> [[]]
| _,[] -> []
| k, t::q -> (ajouter t (combinaison (k-1) q)) @ (combinaison k q)

(* TESTS *)
let%test _ = combinaison 3 [1;2;3;4] = [[1;2;3]; [1;2;4]; [1;3;4]; [2;3;4]]
let%test _ = combinaison 0 [1;2;3;4] = [[]]
let%test _ = combinaison 2 [] = []
let%test _ = combinaison 4 ['a';'b';'c';'d';'e'] = [['a'; 'b'; 'c'; 'd']; ['a'; 'b'; 'c'; 'e']; ['a'; 'b'; 'd'; 'e']; ['a'; 'c'; 'd'; 'e']; ['b'; 'c'; 'd'; 'e']]