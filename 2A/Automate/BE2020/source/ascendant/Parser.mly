%{

(* Partie recopiee dans le fichier CaML genere. *)
(* Ouverture de modules exploites dans les actions *)
(* Declarations de types, de constantes, de fonctions, d'exceptions exploites dans les actions *)

%}

/* Declaration des unites lexicales et de leur type si une valeur particuliere leur est associee */

%token UL_MACHINE
%token UL_ACCOUV UL_ACCFER
%token UL_PT 

/* Defini le type des donnees associees a l'unite lexicale */

%token <string> UL_IDENT

/* Unite lexicale particuliere qui represente la fin du fichier */

%token UL_FIN

/* Type renvoye pour le nom terminal document */
%type <unit> machine

/* Le non terminal document est l'axiome */
%start machine

/* token rajoutés */
%token UL_TO
%token UL_STARTS
%token UL_REGION
%token UL_EVENT
%token UL_STATE
%token UL_ON
%token UL_ENDS
%token UL_FROM

%% /* Regles de productions */

machine : UL_MACHINE UL_IDENT UL_ACCOUV listecomposants  UL_ACCFER UL_FIN { (print_endline "machine : MACHINE IDENT { ... } FIN ") }

listecomposants : /* lambda, mot vide */ {(print_endline "LC : lambda mot vide");}
         | composant listecomposants {(print_endline "LC : composant LC");}

composant : UL_IDENT UL_EVENT {(print_endline "composant : UL_IDENT UL_EVENT");} 
            | transition {(print_endline "composant : transition");}
            | region {(print_endline "composant : region");}

transition : UL_FROM nomqualifie UL_TO nomqualifie UL_ON UL_IDENT { (print_endline "transition : From NQ to NQ on ident ") }

nomqualifie : UL_IDENT {(print_endline "nomqualifie : ident");}
              | UL_IDENT UL_PT nomqualifie {(print_endline "nomqualifie : ident UL_PT nomqualifie");}

region : UL_REGION UL_IDENT UL_ACCOUV etats UL_ACCFER { (print_endline "region : UL_REGION UL_IDENT UL_ACCOUV etats UL_ACCFER ") }

etats : etat {(print_endline "etats : etat");}
        | etat etats {(print_endline "etats : etat etats");}

etat : UL_STATE UL_IDENT startsvoid endsvoid regionvoid {(print_endline "etat : UL_STATE UL_IDENT startsvoid endsvoid regionvoid");}

startsvoid : /* lambda, mot vide */ { (print_endline "startsvoid : lambda mot vide")}
            | UL_STARTS {( print_endline "startsvoid : UL_STARTS")}

endsvoid : /* lambda, mot vide */ { (print_endline "startsvoid : lambda mot vide")}
            | UL_ENDS { (print_endline "endsvoid : UL_ENDS")}

regionvoid : /* lambda, mot vide */ { (print_endline "regionvoid : lambda mot vide")}
            | UL_ACCOUV regions UL_ACCFER { (print_endline "regionvoid : UL_ACCOUV regions UL_ACCFER")}

regions : region {(print_endline "regions : region")}
          | region regions  {(print_endline "regions : region regions")}

%%
