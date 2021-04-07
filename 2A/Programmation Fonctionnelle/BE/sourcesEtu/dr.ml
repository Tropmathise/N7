(*  Module qui permet la décomposition et la recomposition de données **)
(*  Passage du type t1 vers une liste d'éléments de type t2 (décompose) **)
(*  et inversement (recopose).**)
module type DecomposeRecompose =
sig
  (*  Type de la donnée **)
  type mot
  (*  Type des symboles de l'alphabet de t1 **)
  type symbole

  val decompose : mot -> symbole list
  val recompose : symbole list -> mot
end

(* decompose recompose pour un string *)
module DRString : DecomposeRecompose with type mot = string and type symbole = char =
struct 
  type mot = string
  type symbole = char
  let decompose mot = 
    let rec decompose_c i accu =
      if i < 0 then accu
      else decompose_c (i-1) (mot.[i]::accu)
    in decompose_c (String.length mot - 1) []
  let recompose sl = List.fold_right (fun t q -> String.make 1 t ^ q) sl ""
end 

module DRNat : DecomposeRecompose with type mot = int and type symbole = int =
struct
  type mot = int
  type symbole = int 
  (** On decompose un mot (ici un entier) en une liste d'entier 
    ex : 248 -> [2;4;8]
    int -> int list 
    parametre : l'entier a décomposer 
    resultat : une liste d'entier 
    les tests unitaires se trouvent dans chaines.ml 
    sous le nom decompose_entier *)
  let decompose mot =     
    let rec decompose_e i accu =
        if i < 10 then i::accu
        else decompose_e (i/10) ((i mod 10)::accu) 
    in decompose_e mot []
  (** On recompose une liste d'entier en un entier
    ex [2;4;8] -> 248 
    int list -> int 
    parametre : une liste d'entier 
    resultat : un entier
    les tests unitaires se trouvent dans chaines.ml
    sous le nom recompose_entier *)
  let recompose sl = 
    let rev = List.rev(sl) in
    List.fold_right (fun e n -> e + n * 10) rev 0
end

