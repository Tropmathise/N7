(* Evaluation des expressions simples *)


(* Module abstrayant les expressions *)
module type ExprSimple =
sig
  type t
  val const : int -> t
  val plus : t -> t -> t
  val mult : t-> t -> t
end

(* Module *)
module type ExprVar =
sig 
  type t
  val def : (string * t) -> t -> t
  val var : string -> t
end

module type Expr =
sig 
  include ExprSimple
  include (ExprVar with type t := t)
end

(* Module réalisant l'évaluation d'une expression *)
module EvalSimple : ExprSimple with type t = int =
struct
  type t = int
  let const c = c
  let plus e1 e2 = e1 + e2
  let mult e1 e2 = e1 * e2
end

(* Solution 1 pour tester *)
(* A l'aide de foncteur *)

(* Définition des expressions *)
module ExemplesSimples (E:ExprSimple) =
struct
  (* 1+(2*3) *)
  let exemple1  = E.(plus (const 1) (mult (const 2) (const 3)) )
  (* (5+2)*(2*3) *)
  let exemple2 =  E.(mult (plus (const 5) (const 2)) (mult (const 2) (const 3)) )
end

(* Solution 2 pour tester *)
(* A l'aide de foncteur *)
module ExemplesVar (E:Expr) =
struct
  (* “let x = 1+2 in x*3” *)
  let exemple3  = E.(def ("x", (plus (const 1) (const 2))) (mult (var "x") (const 3) ))
end 


(* Module d'évaluation des exemples *)
module EvalExemples =  ExemplesSimples (EvalSimple)

let%test _ = (EvalExemples.exemple1 = 7)
let%test _ = (EvalExemples.exemple2 = 42)

(* EXERCICE 1 *)
(* Module réalisant la convertion d'une expression en chaine de caractere *)
module PrintSimple : ExprSimple with type t = string =
struct 
  type t = string
  let const c = string_of_int c
  let plus e1 e2 = "("^e1^"+"^e2^")"
  let mult e1 e2 = "("^e1^"*"^e2^")"
end

module PrintExemples = ExemplesVar
(* EXERCIE 2 *)
(* Module réalisant le compte des opérations d'une expression *)
module CompteSimple : ExprSimple with type t = int =
struct 
  type t = int 
  let const c = 0
  let plus e1 e2 = e1 + e2 + 1
  let mult e1 e2 = e1 + e2 + 1
end

module CompteExemples = ExemplesSimples(CompteSimple)

let%test _ = (CompteExemples.exemple1 = 2)
let%test _ = (CompteExemples.exemple2 = 3)

(* EXERCICE 4 *)
(* Module réalisant la convertion d'une expression avec variable en chaine de caractere *)
module PrintVar : ExprVar with type t = string =
struct
type t = string
  let var v = v
  let def (v, e1) e2 = "let "^v^" = "^e1^" in "^e2
end 

module Print : Expr with type t = string =
struct
  include PrintSimple
  include (PrintVar : ExprVar with type t:=t)
end 

(* Module d'évaluation des exemples *)
module PrintExemples2 = ExemplesVar(Print)

let%test _ = (PrintExemples2.exemple3 = "let x=(1+2 in (x*3)")

module PrintExemples3 = ExemplesSimples(Print)

let%test _ = (PrintExemples3.exemple1 = "(1+(2*3))")
let%test _ = (PrintExemples3.exemple2 = "((5+2)*(2*3))")





