
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

let%test_unit "testSujet1" = 
    let _ = compiler "../../fichiersRat/rat-case-test/testSujet1.rat" in ()

let%test_unit "testSujet2" = 
    let _ = compiler "../../fichiersRat/rat-case-test/testSujet2.rat" in ()

let%test_unit "testSujet3" = 
    let _ = compiler "../../fichiersRat/rat-case-test/testSujet3.rat" in ()

let%test_unit "testTypeSwitch" = 
try
    let _ = compiler "../../fichiersRat/rat-case-test/testTypeSwitch.rat" 
    in raise ErreurNonDetectee
  with 
  | TypeInattendu(Int,Bool) -> ()

let%expect_test "testSujet3" =
  runtam "../../fichiersRat/rat-case-test/testSujet3.rat";
  [%expect{| 19 |}]

let%expect_test "test" =
  runtam "../../fichiersRat/rat-case-test/test.rat";
  [%expect{| 12 |}]

let%expect_test "testcall" =
  runtam "../../fichiersRat/rat-case-test/testCall.rat";
  [%expect{| 11 |}]

let%expect_test "testSujet2 x = 1" =
  runtam "../../fichiersRat/rat-case-test/testSujet2.1.rat";
  [%expect{| 4278 |}]

let%expect_test "testSujet2 x = 2" =
  runtam "../../fichiersRat/rat-case-test/testSujet2.2.rat";
  [%expect{| 78 |}]

let%expect_test "testSujet2 x = 3" =
  runtam "../../fichiersRat/rat-case-test/testSujet2.3.rat";
  [%expect{| 3 |}]

let%expect_test "testSujet2 x = 4" =
  runtam "../../fichiersRat/rat-case-test/testSujet2.4.rat";
  [%expect{| 7 |}]

let%expect_test "testSujet2 x = 5" =
  runtam "../../fichiersRat/rat-case-test/testSujet2.5.rat";
  [%expect{| 2096 |}]

let%expect_test "testSujet2 x = autre" =
  runtam "../../fichiersRat/rat-case-test/testSujet2.rat";
  [%expect{| 96 |}]