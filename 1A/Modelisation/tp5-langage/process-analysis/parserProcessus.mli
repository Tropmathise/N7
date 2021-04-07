
(* The type of tokens. *)

type token = 
  | STARTS
  | STARTED
  | RIGHT_BRACE
  | PROCESS
  | NUMBER of (int)
  | LEFT_BRACE
  | IF
  | IDENTIFIER of (string)
  | FINISHES
  | FINISHED
  | END
  | ACTIVITY

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val fichier: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (unit)
