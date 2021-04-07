open ParserProcessus

(* Fonction d'affichage des unités lexicales et des données qu'elles contiennent *)
let printToken t =
  (print_endline
     (match t with
       | PROCESS -> "process"
       | IDENTIFIER (texte) -> texte
       | ACTIVITY -> "activity"
       | STARTS -> "starts"
       | FINISHES -> "finishes"
       | IF -> "if"
       | STARTED -> "started"
       | FINISHED -> "finished"
       | LEFT_BRACE -> "{"
       | RIGHT_BRACE -> "}"
       | NUMBER (texte) -> (string_of_int texte)
       | END -> "EOF"
       ));;

(* Analyse lexicale du fichier passé en paramètre de la ligne de commande *)
if (Array.length Sys.argv > 1)
then
  let lexbuf = (Lexing.from_channel (open_in Sys.argv.(1))) in
  let token = ref (LexerProcessus.main lexbuf) in
  while ((!token) != END) do
    (printToken (!token));
    (token := (LexerProcessus.main lexbuf))
  done
else
  (print_endline "MainMuProcessus fichier");;

(* Analyse lexicale, syntaxique et sémantique du fichier passé en paramètre de la ligne de commande *)
if (Array.length Sys.argv > 1)
then
  let lexbuf = (Lexing.from_channel (open_in Sys.argv.(1))) in
  (ParserProcessus.fichier LexerProcessus.main lexbuf)
else
  (print_endline "MainProcessus fichier");;
