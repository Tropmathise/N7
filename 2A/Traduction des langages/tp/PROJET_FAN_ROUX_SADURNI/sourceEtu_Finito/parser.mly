/* Imports. */

%{

open Type
open Ast.AstSyntax
%}


%token <int> ENTIER
%token <string> ID
%token RETURN
%token PV
%token AO
%token AF
%token PF
%token PO
%token EQUAL
%token CONST
%token PRINT
%token IF
%token ELSE
%token WHILE
%token BOOL
%token INT
%token RAT
%token CALL 
%token CO
%token CF
%token SLASH
%token NUM
%token DENOM
%token TRUE
%token FALSE
%token PLUS
%token MULT
%token INF
%token EOF
%token NEW
%token NULL
%token ADR
%token <string> TID
%token ENUM
%token VIRG
%token SWITCH
%token CASE
%token BRK
%token DFLT
%token DP

(* Type de l'attribut synthétisé des non-terminaux *)
%type <(fonction list)*(instruction list)> prog
%type <fonction> fonc
%type <instruction list> is
%type <instruction> i
%type <typ> typ
%type <(typ*string) list> dp
%type <expression> e 
%type <expression list> cp
%type <affectable> a
%type <enumeration> enum
%type <expression> b 
%type <expression *(instruction list) * expression> case


(* Type et définition de l'axiome *)
%start <Ast.AstSyntax.programme> main

%%

main : en=enums lfi=prog EOF     {let (lf,li)=lfi in Programme (en,lf,li)}

enums : /* lambda mot vide */ {[]}
  | en1=enum enl=enums                {en1::enl}

enum : ENUM n=TID AO l=ids AF PV {Enumeration(n,l)}

ids : n=TID {[n]}
      | n=TID VIRG l=ids {n::l}

prog :
| lf = fonc  lfi = prog   {let (lf1,li)=lfi in  (lf::lf1,li)}
| ID li = bloc            {([],li)}

fonc : t=typ n=ID PO p=dp PF AO li=is RETURN exp=e PV AF {Fonction(t,n,p,li,exp)}

bloc : AO li = is AF      {li}

is :
|                         {[]}
| i1=i li=is              {i1::li}

i :
| t=typ n=ID EQUAL e1=e PV          {Declaration (t,n,e1)}
| a1=a EQUAL e1=e PV                {Affectation (a1,e1)}
| CONST n=ID EQUAL e=ENTIER PV      {Constante (n,e)}
| PRINT e1=e PV                     {Affichage (e1)}
| IF exp=e li1=bloc ELSE li2=bloc   {Conditionnelle (exp,li1,li2)}
| WHILE exp=e li=bloc               {TantQue (exp,li)}
| SWITCH PO exp=e PF AO lc=lcase AF  {SwitchCase(exp,lc)}

lcase : /* lambda mot vide */   {[]}
    | cas=case l=lcase {cas::l}

case : CASE elt=TID DP li=is brk=b {((Tide elt),li,brk)}
  | CASE elt=ENTIER DP li=is brk=b    {(Entier(elt),li,brk)}
  | CASE TRUE DP li=is brk=b {(True,li,brk)}
  | CASE FALSE DP li=is brk=b {(False,li,brk)}
  | DFLT DP li=is brk=b {(Default,li,brk)}

b : /* lambda mot vide */   {False}
   | BRK PV                 {True}

dp :
|                         {[]}
| t=typ n=ID lp=dp        {(t,n)::lp}

typ :
| BOOL    {Bool}
| INT     {Int}
| RAT     {Rat}
| pt=typ MULT {Pointeur pt}
| n=TID {Tid n}

e : 
| CALL n=ID PO lp=cp PF   {AppelFonction (n,lp)}
| CO e1=e SLASH e2=e CF   {Rationnel(e1,e2)}
| NUM e1=e                {Numerateur e1}
| DENOM e1=e              {Denominateur e1}
| TRUE                    {True}
| FALSE                   {False}
| e=ENTIER                {Entier e}
| PO e1=e PLUS e2=e PF    {Binaire (Plus,e1,e2)}
| PO e1=e MULT e2=e PF    {Binaire (Mult,e1,e2)}
| PO e1=e EQUAL e2=e PF   {Binaire (Equ,e1,e2)}
| PO e1=e INF e2=e PF     {Binaire (Inf,e1,e2)}
| PO exp=e PF             {exp}
| a1=a                    {Affectable (a1)}
| NULL                    {Null}
| PO NEW pt=typ PF        {New (pt)}
| ADR n=ID                {Adresse (n)}
| n=TID                   {Tide (n)}

cp :
|               {[]}
| e1=e le=cp    {e1::le}

a : 
| n=ID                    {Ident n}
| PO MULT a1=a PF         {Valeur (a1)}