type typ = Bool | Int | Rat | Tid of string | Pointeur of typ | Undefined | Def

let rec string_of_type t = 
  match t with
  | Bool ->  "Bool"
  | Int  ->  "Int"
  | Rat  ->  "Rat"
  | Pointeur typ -> "Pointeur"^(string_of_type typ)
  | Undefined -> "Undefined"
  | Tid n -> "Tid"^n
  | Def -> "Def"


let rec est_compatible t1 t2 =
  match t1, t2 with
  | Bool, Bool -> true
  | Int, Int -> true
  | Rat, Rat -> true 
  | Tid s, Tid s2 -> s=s2
  | Pointeur pt1, Pointeur pt2 -> est_compatible pt1 pt2
  | _ -> false 

let est_compatible_list lt1 lt2 =
  try
    List.for_all2 est_compatible lt1 lt2
  with Invalid_argument _ -> false

let rec est_compatible_infofun lt llt = 
  match llt with
    | [] -> None
    | ltyp::q ->
      begin
      if (est_compatible_list ltyp lt) then
        Some ltyp
      else
        est_compatible_infofun lt q
      end

let getTaille t =
  match t with
  | Int -> 1
  | Bool -> 1
  | Rat -> 2
  | Pointeur _ -> 1
  | Undefined -> 0
  | Tid _ -> 1
  | Def -> 0
  
