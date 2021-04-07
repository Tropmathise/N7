{

(* Partie recopiée dans le fichier CaML généré. *)
(* Ouverture de modules exploités dans les actions *)
(* Déclarations de types, de constantes, de fonctions, d'exceptions exploités dans les actions *)

  open Parser 
  exception LexicalError

}

(* Déclaration d'expressions régulières exploitées par la suite *)
let chiffre = ['0' - '9']
let minuscule = ['a' - 'z']
let majuscule = ['A' - 'Z']
let alphabet = minuscule | majuscule
let alphanum = alphabet | chiffre | '_'
let commentaire =
  (* Commentaire fin de ligne *)
  "#" [^'\n']*

rule lexer = parse
  | ['\n' '\t' ' ']+					{ (lexer lexbuf) }
  | commentaire						{ (lexer lexbuf) }
  | "{"							{ UL_ACCOUV }
  | "}"							{ UL_ACCFER }
  | "."             {UL_PT}
  | "machine"				{ UL_MACHINE }
  | "ident"         {UL_IDENT} 
  | "event"         {UL_EVENT}
  | "from"          {UL_FROM}
  | "to"            {UL_TO}
  | "on"            {UL_ON}
  | "starts"        {Ul_START}
  | "ends"          {UL_ENDS}
  | "region"        {UL_REGION}
  | "state"         {UL_STATE}
  | eof							{ UL_FIN }
  | _ as texte				 		{ (print_string "Erreur lexicale : ");(print_char texte);(print_newline ()); raise LexicalError }

{

}
