
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


let%expect_test "testSujet" =
  runtam "../../fichiersRat/rat-enum-test/testSujet.rat";
  [%expect{| falsetrue |}]

let%expect_test "testEgalite" =
  runtam "../../fichiersRat/rat-enum-test/testEgalite.rat";
  [%expect{| false |}]

let%test_unit "TestEnumSujet" = 
  let _ = compiler "../../fichiersRat/rat-enum-test/testSujet.rat" in ()

let%test_unit "TestEnumMauvaisType" = 
  try 
  let _ = compiler "../../fichiersRat/rat-enum-test/testMauvaisType.rat"
  in raise(ErreurNonDetectee)
  with 
  | TypeInattendu _ -> ()

let%test_unit "TestEnumDoubleDeclaration1" = 
  try 
  let _ = compiler "../../fichiersRat/rat-enum-test/testDoubleDeclaration1.rat"
  in raise(ErreurNonDetectee)
  with 
  | DoubleDeclaration ("Mois") -> ()

let%test_unit "TestEnumDoubleDeclaration2" = 
  try 
  let _ = compiler "../../fichiersRat/rat-enum-test/testDoubleDeclaration2.rat"
  in raise(ErreurNonDetectee)
  with 
  | DoubleDeclaration ("Fevrier") -> ()
