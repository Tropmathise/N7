{

(* Partie recopiée dans le fichier CaML généré. *)
(* Ouverture de modules exploités dans les actions *)
(* Déclarations de types, de constantes, de fonctions, d'exceptions exploités dans les actions *)

  open ParserProcessus
  exception LexicalError

}

(* Déclaration d'expressions régulières exploitées par la suite *)
let chiffre = ['0' - '9']
let minuscule = ['a' - 'z']
let majuscule = ['A' - 'Z']
let lettre = minuscule | majuscule
let lettre_chiffre = lettre | chiffre | '_'
let commentaire =
  (* Commentaire bloc à la C/C++/C#/Java/etc *)
  ("/*" [^ '*']* '*'* ([^ '*' '/'] [^ '*']* '*'*)* '/')
  (* Commentaire fin de ligne à la C/C++/C#/Java/etc  *)
  |  "//" [^'\n']*

rule main = parse
  | ['\n' '\t' ' ']+				{ main lexbuf }
  | commentaire					{ (main lexbuf) }
  | "process"					{ PROCESS }
  | "activity"					{ ACTIVITY }
  | "starts"					{ STARTS }
  | "finishes"					{ FINISHES }
  | "if"					{ IF }
  | "started"					{ STARTED }
  | "finished"				       	{ FINISHED }
  | "{"						{ LEFT_BRACE }
  | "}"						{ RIGHT_BRACE }
  | chiffre+ as texte				{ (NUMBER (int_of_string texte)) }
  | ('_' | lettre) lettre_chiffre* as texte	{ (IDENTIFIER texte) }
  | eof						{ END }
  | _ as texte				 	{ (print_string "Erreur lexicale : ");(print_char texte);(print_newline ()); (main lexbuf) }

{

}
