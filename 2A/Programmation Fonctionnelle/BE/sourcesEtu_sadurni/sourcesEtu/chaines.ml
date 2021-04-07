(******************************************************************************)
(*                                                                            *)
(*      fonction de décomposition pour les chaînes de caractères              *)
(*                                                                            *)
(*   signature : decompose_chaine : string -> char list = <fun>               *)
(*                                                                            *)
(*   paramètre(s) : une chaîne de caractères                                  *)
(*   résultat     : la liste des caractères composant la chaîne paramètre     *)
(*                                                                            *)
(******************************************************************************)
let decompose_chaine s =
  let rec decompose i accu =
    if i < 0 then accu
    else decompose (i-1) (s.[i]::accu)
  in decompose (String.length s - 1) []

let%test _ = decompose_chaine "" = []
let%test _ = decompose_chaine "a" = ['a']
let%test _ = decompose_chaine "aa" = ['a';'a']
let%test _ = decompose_chaine "ab" = ['a';'b']
let%test _ = decompose_chaine "abcdef" = ['a'; 'b'; 'c'; 'd'; 'e'; 'f']

(******************************************************************************)
(*                                                                            *)
(*      fonction de recomposition pour les chaînes de caractères              *)
(*                                                                            *)
(*   signature : recompose_chaine : char list -> string = <fun>               *)
(*                                                                            *)
(*   paramètre(s) : une liste de caractères                                   *)
(*   résultat     : la chaîne des caractères composant la liste paramètre     *)
(*                                                                            *)
(******************************************************************************)
let recompose_chaine lc =
  List.fold_right (fun t q -> String.make 1 t ^ q) lc ""

let%test _ = recompose_chaine [] = ""
let%test _ = recompose_chaine ['a'] = "a"
let%test _ = recompose_chaine ['a';'a'] = "aa"
let%test _ = recompose_chaine ['a';'b'] = "ab"
let%test _ = recompose_chaine ['a'; 'b'; 'c'; 'd'; 'e'; 'f'] = "abcdef"

(******************************************************************************)
(*                                                                            *)
(*      fonction de lecture d'une chaîne                                      *)
(*                                                                            *)
(*   signature : lit_chaine : unit -> string = <fun>                          *)
(*                                                                            *)
(*   paramètre(s) : aucun                                                     *)
(*   résultat     : une chaîne                                                *)
(*                                                                            *)
(******************************************************************************)
let lit_chaine = read_line

(******************************************************************************)
(*                                                                            *)
(*      procédure d'affichage d'une chaîne                                    *)
(*                                                                            *)
(*   signature : affiche_chaine : string -> unit = <fun>                      *)
(*                                                                            *)
(*   paramètre(s) : une chaîne                                                *)
(*   résultat     : aucun                                                     *)
(*                                                                            *)
(******************************************************************************)
let affiche_chaine s = let () = print_string s in print_newline ()

let decompose_entier mot =     
    let rec decompose_e i accu =
        if i < 10 then i::accu
        else decompose_e (i/10) ((i mod 10)::accu) 
    in decompose_e mot []

let%test _ = decompose_entier 1 = [0]
let%test _ = decompose_entier 12 = [1;2]
let%test _ = decompose_entier 248 = [2;4;8]


let recompose_entier sl = 
    let rev = List.rev(sl) in
    List.fold_right (fun e n -> e + n * 10) rev 0

let%test _ = recompose_entier [] = 0
let%test _ = recompose_entier [1] = 1
let%test _ = recompose_entier [1;2] = 12
let%test _ = recompose_entier [2;4;8] = 248
