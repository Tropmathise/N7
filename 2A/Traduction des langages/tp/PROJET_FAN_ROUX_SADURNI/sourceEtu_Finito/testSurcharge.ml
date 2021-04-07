
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

exception ErreurNonDetectee 

(* Tests surcharge *)
let%test_unit "testSurcharge1" = 
  try
  let _ = compiler "../../fichiersRat/rat-surcharge-test/testSurcharge1.rat"
  in  raise ErreurNonDetectee
  with
  | DoubleDeclaration "f" -> ()

let%test_unit "testSurcharge2"= 
  let _ = compiler   "../../fichiersRat/rat-surcharge-test/testSurcharge2.rat" in ()

let%test_unit "testSurcharge3" = 
  let _ = compiler   "../../fichiersRat/rat-surcharge-test/testSurcharge3.rat" in ()

let%expect_test "testSurcharge4" =
  runtam "../../fichiersRat/rat-surcharge-test/testSurcharge2.rat";
  [%expect{| 12 |}]

let%expect_test "testSurchargePointeurEnum" = 
  runtam "../../fichiersRat/rat-surcharge-test/testSurchargePointeurEnum.rat";
  [%expect{| 123 |}]



