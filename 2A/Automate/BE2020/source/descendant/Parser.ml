open Tokens

(* Type du résultat d'une analyse syntaxique *)
type parseResult =
  | Success of inputStream
  | Failure
;;

(* accept : token -> inputStream -> parseResult *)
(* Vérifie que le premier token du flux d'entrée est bien le token attendu *)
(* et avance dans l'analyse si c'est le cas *)
let accept expected stream =
  match (peekAtFirstToken stream) with
    | token when (token = expected) ->
      (Success (advanceInStream stream))
    | _ -> Failure
;;

(* Définition de la monade  qui est composée de : *)
(* - le type de donnée monadique : parseResult  *)
(* - la fonction : inject qui construit ce type à partir d'une liste de terminaux *)
(* - la fonction : bind (opérateur >>=) qui combine les fonctions d'analyse. *)

(* inject inputStream -> parseResult *)
(* Construit le type de la monade à partir d'une liste de terminaux *)
let inject s = Success s;;

(* bind : 'a m -> ('a -> 'b m) -> 'b m *)
(* bind (opérateur >>=) qui combine les fonctions d'analyse. *)
(* ici on utilise une version spécialisée de bind :
   'b  ->  inputStream
   'a  ->  inputStream
    m  ->  parseResult
*)
(* >>= : parseResult -> (inputStream -> parseResult) -> parseResult *)
let (>>=) result f =
  match result with
    | Success next -> f next
    | Failure -> Failure
;;


(* parseMachine : inputStream -> parseResult *)
(* Analyse du non terminal Programme *)
let rec parseMachine stream =
  (print_string "Machine -> ...");
  (match (peekAtFirstToken stream) with
    (* regle 1 *)
    | UL_MACHINE -> (print_endline "machine ident {Sc}");
      inject stream >>=
      accept UL_MACHINE >>= 
      accept UL_IDENT >>=
      accept UL_ACCOUV >>=
      parseSC >>=
      accept UL_ACCFERM
    | _ -> Failure)

and parseSC stream = 
    (print_string "Sc -> ...");
    (match (peekAtFirstToken stream) with
      (* regle 2 *)
      | UL_ACCFERM -> (print_endline "lambda");
        inject stream
      (* regle 3 *)
      | (UL_EVENT | UL_FROM | UL_REGION) -> (print_endline "event from region");
        inject stream >>=
        parseC >>=
        parseSC
      | _ -> Failure)

and parseC stream =
    (print_string "C -> ...");
    (match (peekAtFirstToken stream) with
    (* regle 4 *)
      | UL_EVENT -> (print_endline "event");
        inject stream >>=
        accept UL_EVENT >>=
        accept UL_IDENT >>=
      | _ -> Failure)

and parseSE stream = 
  (print_string "Se -> ...");
    (match (peekAtFirstToken stream) with
    (*regle 11 *)
    | UL_ACCFERM -> 
      inject stream
    (*regle 12 *)
    | UL_STATE -> 
      inject stream >>=
      parseE >>=
      parseSE
    | _ -> Failure)

and parseE stream =
    (print_string "E -> ...");
    (match (peekAtFirstToken stream) with
      (*regle 13 *)
      | UL_STATE ->
        inject stream >>=
        accept UL_STATE >>=
        accept UL_IDENT >>=
        parseES >>=
        parseEE >>=
        parseEC
      | _ -> Failure)

and parseES stream =
    (print_string "ES -> ...");
    (match (peekAtFirstToken stream) with
    | (UL_ENDS | UL_ACCOUV | UL_ACCFERM | UL_STATE) -> 
      inject stream 
    |UL_STARTS -> 
      inject stream >>=
      accept UL_STARTS
    | _ -> Failure)

and parseEE stream =
    (print_string "EE -> ...");
    (match (peekAtFirstToken stream) with
    | (UL_ACCOUV | UL_ACCFERM | UL_STATE) -> 
      inject stream 
    | UL_ENDS -> 
      inject stream >>=
      accept UL_ENDS
    | _ -> Failure)

and parseEC stream =
    (print_string "EC -> ...");
    (match (peekAtFirstToken stream) with
    | (UL_ACCFERM | UL_STATE) -> 
      inject stream
    | UL_ACCOUV -> 
      inject stream >>=
      accept UL_ACCOUV >>=
      parseR >>=
      parseSR >>=
      accept UL_ACCFERM
    | _ -> Failure)




      





;;
