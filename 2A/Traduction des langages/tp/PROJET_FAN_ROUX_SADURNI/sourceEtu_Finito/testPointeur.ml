
open Compilateur
open Exceptions


(* Changer le chemin d'accès du jar. *)
let runtamcmde = "java -jar ../../runtam.jar"
(* let runtamcmde = "java -jar /mnt/n7fs/.../tools/runtam/runtam.jar" *)

(* Execute the TAM code obtained from the rat file and return the ouptut of this code *)
let runtamcode cmde ratfile =
  let tamcode = compiler ratfile in
  let (tamfile, chan) = Filename.open_temp_file "test" ".tam" in
  output_string chan tamcode;
  close_out chan;
  let ic = Unix.open_process_in (cmde ^ " " ^ tamfile) in
  let printed = input_line ic in
  close_in ic;
  (*Sys.remove tamfile; *)  (* à commenter si on veut étudier le code TAM. *)
  String.trim printed

(* Compile and run ratfile, then print its output *)
let runtam ratfile =
  print_string (runtamcode runtamcmde ratfile)

exception ErreurNonDetectee;;

let%test_unit "testPointeur1" = 
    let _ = compiler "../../fichiersRat/rat-pointeur-test/testPointeur1.rat" in ()

let%test_unit "testPointeur2" = 
    let _ = compiler "../../fichiersRat/rat-pointeur-test/testPointeur2.rat" in ()

let%test_unit "testPointeur3" = 
    try
    let _ = compiler "../../fichiersRat/rat-pointeur-test/testPointeur3.rat"
     in raise ErreurNonDetectee
    with 
    | TypeInattendu(Pointeur Undefined,Int) -> ()

let%test_unit "testPointeur4" =
  try
    let _ = compiler "../../fichiersRat/rat-pointeur-test/testPointeur4.rat"
      in raise ErreurNonDetectee
  with
  | NotAPointer -> ()

let%expect_test "testPointeurPointeur" =
  runtam "../../fichiersRat/rat-pointeur-test/testPointeur5.rat";
  [%expect{| [6/7]18 |}]

let%expect_test "testPointeurPrint" =
  runtam "../../fichiersRat/rat-pointeur-test/testPointeurPrint.rat";
  [%expect{| 15 |}]

let%expect_test "testFonction" =
  runtam "../../fichiersRat/rat-pointeur-test/testFonction.rat";
  [%expect{| 1517 |}]




