
open Compilateur

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

let%test_unit "testUltime" = 
    let _ = compiler "../../fichiersRat/rat-testultime-test/testFinal.rat" in ()

let%expect_test "test" =
  runtam "../../fichiersRat/rat-testultime-test/testFinal.rat";
  [%expect{| [15/1][8/12][8/1][15/1][8/1][15/2] |}]

let%expect_test "testpetit" =
  runtam "../../fichiersRat/rat-testultime-test/testFinalPetit.rat";
  [%expect{| [15/1] |}]
