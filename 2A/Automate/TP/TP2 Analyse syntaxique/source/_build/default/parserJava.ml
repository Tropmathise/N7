
module MenhirBasics = struct
  
  exception Error
  
  type token = 
    | VOID
    | VIRG
    | VIDE
    | TYPEIDENT of (
# 14 "parserJava.mly"
       (string)
# 14 "parserJava.ml"
  )
    | TANTQUE
    | STRING
    | SINON
    | SI
    | RETOUR
    | PTVIRG
    | PAROUV
    | PARFER
    | OPSUPEG
    | OPSUP
    | OPPT
    | OPPLUS
    | OPOU
    | OPNONEG
    | OPNON
    | OPMULT
    | OPMOINS
    | OPMOD
    | OPINFEG
    | OPINF
    | OPET
    | OPEG
    | OPDIV
    | NOUVEAU
    | INT
    | IMPORT
    | IDENT of (
# 14 "parserJava.mly"
       (string)
# 45 "parserJava.ml"
  )
    | FLOTTANT of (
# 21 "parserJava.mly"
       (float)
# 50 "parserJava.ml"
  )
    | FLOAT
    | FIN
    | ENTIER of (
# 20 "parserJava.mly"
       (int)
# 57 "parserJava.ml"
  )
    | CROOUV
    | CROFER
    | CHAR
    | CHAINE of (
# 24 "parserJava.mly"
       (string)
# 65 "parserJava.ml"
  )
    | CARACTERE of (
# 23 "parserJava.mly"
       (char)
# 70 "parserJava.ml"
  )
    | BOOLEEN of (
# 22 "parserJava.mly"
       (bool)
# 75 "parserJava.ml"
  )
    | BOOL
    | ASSIGN
    | ACCOUV
    | ACCFER
  
end

include MenhirBasics

let _eRR =
  MenhirBasics.Error

type _menhir_env = {
  _menhir_lexer: Lexing.lexbuf -> token;
  _menhir_lexbuf: Lexing.lexbuf;
  _menhir_token: token;
  mutable _menhir_error: bool
}

and _menhir_state = 
  | MenhirState112
  | MenhirState108
  | MenhirState103
  | MenhirState100
  | MenhirState98
  | MenhirState95
  | MenhirState87
  | MenhirState84
  | MenhirState78
  | MenhirState74
  | MenhirState67
  | MenhirState66
  | MenhirState65
  | MenhirState64
  | MenhirState59
  | MenhirState58
  | MenhirState56
  | MenhirState37
  | MenhirState36
  | MenhirState34
  | MenhirState33
  | MenhirState32
  | MenhirState30
  | MenhirState25
  | MenhirState14
  | MenhirState12
  | MenhirState11
  | MenhirState3
  | MenhirState0

# 1 "parserJava.mly"
  

(* Partie recopiee dans le fichier CaML genere. *)
(* Ouverture de modules exploites dans les actions *)
(* Declarations de types, de constantes, de fonctions, d'exceptions exploites dans les actions *)

(* let nbrVariables = ref 0;; *)


# 137 "parserJava.ml"

let rec _menhir_goto_expression2 : _menhir_env -> 'ttv_tail -> _menhir_state -> (unit) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState67 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_3 : (unit)) = _v in
        let ((_menhir_stack, _menhir_s), _, (_2 : (unit))) = _menhir_stack in
        let _1 = () in
        let _v : (unit) = 
# 138 "parserJava.mly"
                                      ( (print_endline "expression2 : VIRG expression") )
# 151 "parserJava.ml"
         in
        _menhir_goto_expression2 _menhir_env _menhir_stack _menhir_s _v
    | MenhirState65 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_2 : (unit)) = _v in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        let _1 = () in
        let _v : (unit) = 
# 130 "parserJava.mly"
                             ( (print_endline "suffixe : (expression2") )
# 163 "parserJava.ml"
         in
        _menhir_goto_suffixe _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        _menhir_fail ()

and _menhir_goto_instruction : _menhir_env -> 'ttv_tail -> _menhir_state -> (unit) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_stack = Obj.magic _menhir_stack in
    assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ASSIGN ->
        _menhir_run55 _menhir_env (Obj.magic _menhir_stack) MenhirState108
    | OPDIV ->
        _menhir_run54 _menhir_env (Obj.magic _menhir_stack) MenhirState108
    | OPEG ->
        _menhir_run53 _menhir_env (Obj.magic _menhir_stack) MenhirState108
    | OPET ->
        _menhir_run52 _menhir_env (Obj.magic _menhir_stack) MenhirState108
    | OPINF ->
        _menhir_run51 _menhir_env (Obj.magic _menhir_stack) MenhirState108
    | OPINFEG ->
        _menhir_run50 _menhir_env (Obj.magic _menhir_stack) MenhirState108
    | OPMOD ->
        _menhir_run49 _menhir_env (Obj.magic _menhir_stack) MenhirState108
    | OPMOINS ->
        _menhir_run48 _menhir_env (Obj.magic _menhir_stack) MenhirState108
    | OPMULT ->
        _menhir_run47 _menhir_env (Obj.magic _menhir_stack) MenhirState108
    | OPNON ->
        _menhir_run46 _menhir_env (Obj.magic _menhir_stack) MenhirState108
    | OPNONEG ->
        _menhir_run45 _menhir_env (Obj.magic _menhir_stack) MenhirState108
    | OPOU ->
        _menhir_run44 _menhir_env (Obj.magic _menhir_stack) MenhirState108
    | OPPLUS ->
        _menhir_run43 _menhir_env (Obj.magic _menhir_stack) MenhirState108
    | OPPT ->
        _menhir_run42 _menhir_env (Obj.magic _menhir_stack) MenhirState108
    | OPSUP ->
        _menhir_run41 _menhir_env (Obj.magic _menhir_stack) MenhirState108
    | OPSUPEG ->
        _menhir_run40 _menhir_env (Obj.magic _menhir_stack) MenhirState108
    | PAROUV ->
        _menhir_run37 _menhir_env (Obj.magic _menhir_stack) MenhirState108
    | RETOUR ->
        _menhir_run103 _menhir_env (Obj.magic _menhir_stack) MenhirState108
    | SI ->
        _menhir_run35 _menhir_env (Obj.magic _menhir_stack) MenhirState108
    | BOOLEEN _ | CARACTERE _ | ENTIER _ | FLOTTANT _ | IDENT _ | NOUVEAU | VIDE ->
        _menhir_reduce66 _menhir_env (Obj.magic _menhir_stack) MenhirState108
    | ACCFER ->
        _menhir_reduce43 _menhir_env (Obj.magic _menhir_stack) MenhirState108
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState108

and _menhir_goto_elsebloc : _menhir_env -> 'ttv_tail -> (unit) -> 'ttv_return =
  fun _menhir_env _menhir_stack _v ->
    let _menhir_stack = Obj.magic _menhir_stack in
    let _menhir_stack = Obj.magic _menhir_stack in
    let (_6 : (unit)) = _v in
    let (((_menhir_stack, _menhir_s), _, (_3 : (unit))), _, (_5 : (unit))) = _menhir_stack in
    let _4 = () in
    let _2 = () in
    let _1 = () in
    let _v : (unit) = 
# 98 "parserJava.mly"
                                                         ( (print_endline "SI PAROUV expression PARFER bloc") )
# 235 "parserJava.ml"
     in
    _menhir_goto_instruction _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce25 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _v : (unit) = 
# 137 "parserJava.mly"
                                      ( (print_endline "expression2 : /* Lambda, mot vide */") )
# 244 "parserJava.ml"
     in
    _menhir_goto_expression2 _menhir_env _menhir_stack _menhir_s _v

and _menhir_run66 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ASSIGN ->
        _menhir_run55 _menhir_env (Obj.magic _menhir_stack) MenhirState66
    | OPDIV ->
        _menhir_run54 _menhir_env (Obj.magic _menhir_stack) MenhirState66
    | OPEG ->
        _menhir_run53 _menhir_env (Obj.magic _menhir_stack) MenhirState66
    | OPET ->
        _menhir_run52 _menhir_env (Obj.magic _menhir_stack) MenhirState66
    | OPINF ->
        _menhir_run51 _menhir_env (Obj.magic _menhir_stack) MenhirState66
    | OPINFEG ->
        _menhir_run50 _menhir_env (Obj.magic _menhir_stack) MenhirState66
    | OPMOD ->
        _menhir_run49 _menhir_env (Obj.magic _menhir_stack) MenhirState66
    | OPMOINS ->
        _menhir_run48 _menhir_env (Obj.magic _menhir_stack) MenhirState66
    | OPMULT ->
        _menhir_run47 _menhir_env (Obj.magic _menhir_stack) MenhirState66
    | OPNON ->
        _menhir_run46 _menhir_env (Obj.magic _menhir_stack) MenhirState66
    | OPNONEG ->
        _menhir_run45 _menhir_env (Obj.magic _menhir_stack) MenhirState66
    | OPOU ->
        _menhir_run44 _menhir_env (Obj.magic _menhir_stack) MenhirState66
    | OPPLUS ->
        _menhir_run43 _menhir_env (Obj.magic _menhir_stack) MenhirState66
    | OPPT ->
        _menhir_run42 _menhir_env (Obj.magic _menhir_stack) MenhirState66
    | OPSUP ->
        _menhir_run41 _menhir_env (Obj.magic _menhir_stack) MenhirState66
    | OPSUPEG ->
        _menhir_run40 _menhir_env (Obj.magic _menhir_stack) MenhirState66
    | PAROUV ->
        _menhir_run37 _menhir_env (Obj.magic _menhir_stack) MenhirState66
    | BOOLEEN _ | CARACTERE _ | ENTIER _ | FLOTTANT _ | IDENT _ | NOUVEAU | VIDE ->
        _menhir_reduce66 _menhir_env (Obj.magic _menhir_stack) MenhirState66
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState66

and _menhir_goto_suffixe : _menhir_env -> 'ttv_tail -> _menhir_state -> (unit) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState64 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_4 : (unit)) = _v in
        let ((_menhir_stack, _menhir_s), _, (_2 : (unit))) = _menhir_stack in
        let _3 = () in
        let _1 = () in
        let _v : (unit) = 
# 148 "parserJava.mly"
                                              ( (print_endline "expression : (expression) suffixe"))
# 308 "parserJava.ml"
         in
        _menhir_goto_expressionapresunaire _menhir_env _menhir_stack _menhir_s _v
    | MenhirState87 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_2 : (unit)) = _v in
        let (_menhir_stack, _menhir_s, (_1 : (
# 14 "parserJava.mly"
       (string)
# 318 "parserJava.ml"
        ))) = _menhir_stack in
        let _v : (unit) = 
# 147 "parserJava.mly"
                           ( (print_endline "expression : ident suffixe") )
# 323 "parserJava.ml"
         in
        _menhir_goto_expressionapresunaire _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        _menhir_fail ()

and _menhir_goto_expression : _menhir_env -> 'ttv_tail -> _menhir_state -> (unit) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState58 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | PARFER ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | CROOUV ->
                _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState64
            | PAROUV ->
                _menhir_run65 _menhir_env (Obj.magic _menhir_stack) MenhirState64
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState64)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState66 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | VIRG ->
            _menhir_run66 _menhir_env (Obj.magic _menhir_stack) MenhirState67
        | CROFER | OPPLUS | PARFER | PTVIRG ->
            _menhir_reduce25 _menhir_env (Obj.magic _menhir_stack) MenhirState67
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState67)
    | MenhirState65 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | PARFER ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s), _, (_2 : (unit))) = _menhir_stack in
            let _3 = () in
            let _1 = () in
            let _v : (unit) = 
# 129 "parserJava.mly"
                                   ( (print_endline "suffixe : (expression)") )
# 385 "parserJava.ml"
             in
            _menhir_goto_suffixe _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState74 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | CROFER ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s), _, (_2 : (unit))) = _menhir_stack in
            let _3 = () in
            let _1 = () in
            let _v : (unit) = 
# 131 "parserJava.mly"
                                   ( (print_endline "suffixe : [expression]") )
# 409 "parserJava.ml"
             in
            _menhir_goto_suffixe _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState78 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s), _, (_2 : (unit))) = _menhir_stack in
        let _1 = () in
        let _v : (unit) = 
# 150 "parserJava.mly"
                                    ()
# 426 "parserJava.ml"
         in
        _menhir_goto_expressionapresunaire _menhir_env _menhir_stack _menhir_s _v
    | MenhirState84 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | CROFER ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((_menhir_stack, _menhir_s), (_2 : (
# 14 "parserJava.mly"
       (string)
# 441 "parserJava.ml"
            ))), _, (_4 : (unit))) = _menhir_stack in
            let _5 = () in
            let _3 = () in
            let _1 = () in
            let _v : (unit) = 
# 146 "parserJava.mly"
                                                    ( (print_endline "expression : new ident [expression]") )
# 449 "parserJava.ml"
             in
            _menhir_goto_expressionapresunaire _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState56 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | OPPLUS ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | ASSIGN ->
                _menhir_run55 _menhir_env (Obj.magic _menhir_stack) MenhirState95
            | OPDIV ->
                _menhir_run54 _menhir_env (Obj.magic _menhir_stack) MenhirState95
            | OPEG ->
                _menhir_run53 _menhir_env (Obj.magic _menhir_stack) MenhirState95
            | OPET ->
                _menhir_run52 _menhir_env (Obj.magic _menhir_stack) MenhirState95
            | OPINF ->
                _menhir_run51 _menhir_env (Obj.magic _menhir_stack) MenhirState95
            | OPINFEG ->
                _menhir_run50 _menhir_env (Obj.magic _menhir_stack) MenhirState95
            | OPMOD ->
                _menhir_run49 _menhir_env (Obj.magic _menhir_stack) MenhirState95
            | OPMOINS ->
                _menhir_run48 _menhir_env (Obj.magic _menhir_stack) MenhirState95
            | OPMULT ->
                _menhir_run47 _menhir_env (Obj.magic _menhir_stack) MenhirState95
            | OPNON ->
                _menhir_run46 _menhir_env (Obj.magic _menhir_stack) MenhirState95
            | OPNONEG ->
                _menhir_run45 _menhir_env (Obj.magic _menhir_stack) MenhirState95
            | OPOU ->
                _menhir_run44 _menhir_env (Obj.magic _menhir_stack) MenhirState95
            | OPPLUS ->
                _menhir_run43 _menhir_env (Obj.magic _menhir_stack) MenhirState95
            | OPPT ->
                _menhir_run42 _menhir_env (Obj.magic _menhir_stack) MenhirState95
            | OPSUP ->
                _menhir_run41 _menhir_env (Obj.magic _menhir_stack) MenhirState95
            | OPSUPEG ->
                _menhir_run40 _menhir_env (Obj.magic _menhir_stack) MenhirState95
            | PAROUV ->
                _menhir_run37 _menhir_env (Obj.magic _menhir_stack) MenhirState95
            | BOOLEEN _ | CARACTERE _ | ENTIER _ | FLOTTANT _ | IDENT _ | NOUVEAU | VIDE ->
                _menhir_reduce66 _menhir_env (Obj.magic _menhir_stack) MenhirState95
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState95)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState95 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s, (_1 : (unit))), _, (_3 : (unit))) = _menhir_stack in
        let _2 = () in
        let _v : (unit) = 
# 149 "parserJava.mly"
                                   ()
# 522 "parserJava.ml"
         in
        _menhir_goto_expressionapresunaire _menhir_env _menhir_stack _menhir_s _v
    | MenhirState36 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | PARFER ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | ACCOUV ->
                _menhir_run33 _menhir_env (Obj.magic _menhir_stack) MenhirState98
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState98)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState103 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | PTVIRG ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s), _, (_2 : (unit))) = _menhir_stack in
            let _3 = () in
            let _1 = () in
            let _v : (unit) = 
# 99 "parserJava.mly"
                                         ( (print_endline "instruction : RETURN expression PTVIRG") )
# 562 "parserJava.ml"
             in
            _menhir_goto_instruction _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState34 | MenhirState108 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | PTVIRG ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, (_1 : (unit))) = _menhir_stack in
            let _2 = () in
            let _v : (unit) = 
# 97 "parserJava.mly"
                                ( (print_endline "instruction : expression PTVIRG") )
# 585 "parserJava.ml"
             in
            _menhir_goto_instruction _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        _menhir_fail ()

and _menhir_goto_instructions : _menhir_env -> 'ttv_tail -> _menhir_state -> (int) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState34 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | ACCFER ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((_menhir_stack, _menhir_s), _, (_2 : (int))), _, (_3 : (int))) = _menhir_stack in
            let _4 = () in
            let _1 = () in
            let _v : (unit) = 
# 85 "parserJava.mly"
                                            ( (print_endline "bloc : ACCOUV variables instructions ACCFER"); (print_string "Nombre de variables = "); (print_int _2); (print_newline ()) )
# 616 "parserJava.ml"
             in
            let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
            (match _menhir_s with
            | MenhirState98 ->
                let _menhir_stack = Obj.magic _menhir_stack in
                assert (not _menhir_env._menhir_error);
                let _tok = _menhir_env._menhir_token in
                (match _tok with
                | SINON ->
                    let _menhir_stack = Obj.magic _menhir_stack in
                    let _menhir_env = _menhir_discard _menhir_env in
                    let _tok = _menhir_env._menhir_token in
                    (match _tok with
                    | ACCOUV ->
                        _menhir_run33 _menhir_env (Obj.magic _menhir_stack) MenhirState100
                    | _ ->
                        assert (not _menhir_env._menhir_error);
                        _menhir_env._menhir_error <- true;
                        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState100)
                | ACCFER | ASSIGN | BOOLEEN _ | CARACTERE _ | ENTIER _ | FLOTTANT _ | IDENT _ | NOUVEAU | OPDIV | OPEG | OPET | OPINF | OPINFEG | OPMOD | OPMOINS | OPMULT | OPNON | OPNONEG | OPOU | OPPLUS | OPPT | OPSUP | OPSUPEG | PAROUV | RETOUR | SI | VIDE ->
                    let _menhir_stack = Obj.magic _menhir_stack in
                    let _v : (unit) = 
# 101 "parserJava.mly"
                                   ( (print_endline "elsebloc : /* Lambda, mot vide */") )
# 641 "parserJava.ml"
                     in
                    _menhir_goto_elsebloc _menhir_env _menhir_stack _v
                | _ ->
                    assert (not _menhir_env._menhir_error);
                    _menhir_env._menhir_error <- true;
                    let _menhir_stack = Obj.magic _menhir_stack in
                    let (_menhir_stack, _menhir_s, _) = _menhir_stack in
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
            | MenhirState100 ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_stack = Obj.magic _menhir_stack in
                let (_menhir_stack, _, (_2 : (unit))) = _menhir_stack in
                let _1 = () in
                let _v : (unit) = 
# 102 "parserJava.mly"
                     ( (print_endline "elsebloc : SINON BLOC") )
# 658 "parserJava.ml"
                 in
                _menhir_goto_elsebloc _menhir_env _menhir_stack _v
            | MenhirState32 ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_stack = Obj.magic _menhir_stack in
                let ((_menhir_stack, _menhir_s, (_1 : (unit))), _, (_2 : (unit))) = _menhir_stack in
                let _v : (unit) = 
# 74 "parserJava.mly"
                        ( (print_endline "fonction : entete bloc") )
# 668 "parserJava.ml"
                 in
                let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
                let _menhir_stack = Obj.magic _menhir_stack in
                assert (not _menhir_env._menhir_error);
                let _tok = _menhir_env._menhir_token in
                (match _tok with
                | BOOL ->
                    _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState30
                | CHAR ->
                    _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState30
                | FLOAT ->
                    _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState30
                | INT ->
                    _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState30
                | STRING ->
                    _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState30
                | TYPEIDENT _v ->
                    _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState30 _v
                | VOID ->
                    _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState30
                | FIN ->
                    _menhir_reduce47 _menhir_env (Obj.magic _menhir_stack) MenhirState30
                | _ ->
                    assert (not _menhir_env._menhir_error);
                    _menhir_env._menhir_error <- true;
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState30)
            | _ ->
                _menhir_fail ())
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState108 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s, (_1 : (unit))), _, (_2 : (int))) = _menhir_stack in
        let _v : (int) = 
# 94 "parserJava.mly"
                                   ( (print_endline "instructions : instruction"); (_2 + 1) )
# 710 "parserJava.ml"
         in
        _menhir_goto_instructions _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        _menhir_fail ()

and _menhir_goto_binaire : _menhir_env -> 'ttv_tail -> _menhir_state -> (unit) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = Obj.magic _menhir_stack in
    let _menhir_stack = Obj.magic _menhir_stack in
    let (_1 : (unit)) = _v in
    let _v : (unit) = 
# 135 "parserJava.mly"
                     ( (print_endline "expression : BINAIRE") )
# 724 "parserJava.ml"
     in
    _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v

and _menhir_run65 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ASSIGN ->
        _menhir_run55 _menhir_env (Obj.magic _menhir_stack) MenhirState65
    | OPDIV ->
        _menhir_run54 _menhir_env (Obj.magic _menhir_stack) MenhirState65
    | OPEG ->
        _menhir_run53 _menhir_env (Obj.magic _menhir_stack) MenhirState65
    | OPET ->
        _menhir_run52 _menhir_env (Obj.magic _menhir_stack) MenhirState65
    | OPINF ->
        _menhir_run51 _menhir_env (Obj.magic _menhir_stack) MenhirState65
    | OPINFEG ->
        _menhir_run50 _menhir_env (Obj.magic _menhir_stack) MenhirState65
    | OPMOD ->
        _menhir_run49 _menhir_env (Obj.magic _menhir_stack) MenhirState65
    | OPMOINS ->
        _menhir_run48 _menhir_env (Obj.magic _menhir_stack) MenhirState65
    | OPMULT ->
        _menhir_run47 _menhir_env (Obj.magic _menhir_stack) MenhirState65
    | OPNON ->
        _menhir_run46 _menhir_env (Obj.magic _menhir_stack) MenhirState65
    | OPNONEG ->
        _menhir_run45 _menhir_env (Obj.magic _menhir_stack) MenhirState65
    | OPOU ->
        _menhir_run44 _menhir_env (Obj.magic _menhir_stack) MenhirState65
    | OPPLUS ->
        _menhir_run43 _menhir_env (Obj.magic _menhir_stack) MenhirState65
    | OPPT ->
        _menhir_run42 _menhir_env (Obj.magic _menhir_stack) MenhirState65
    | OPSUP ->
        _menhir_run41 _menhir_env (Obj.magic _menhir_stack) MenhirState65
    | OPSUPEG ->
        _menhir_run40 _menhir_env (Obj.magic _menhir_stack) MenhirState65
    | PARFER ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_s = MenhirState65 in
        let _menhir_env = _menhir_discard _menhir_env in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        let _2 = () in
        let _1 = () in
        let _v : (unit) = 
# 128 "parserJava.mly"
                        ( (print_endline "suffixe : ()") )
# 777 "parserJava.ml"
         in
        _menhir_goto_suffixe _menhir_env _menhir_stack _menhir_s _v
    | PAROUV ->
        _menhir_run37 _menhir_env (Obj.magic _menhir_stack) MenhirState65
    | VIRG ->
        _menhir_run66 _menhir_env (Obj.magic _menhir_stack) MenhirState65
    | BOOLEEN _ | CARACTERE _ | ENTIER _ | FLOTTANT _ | IDENT _ | NOUVEAU | VIDE ->
        _menhir_reduce66 _menhir_env (Obj.magic _menhir_stack) MenhirState65
    | CROFER | PTVIRG ->
        _menhir_reduce25 _menhir_env (Obj.magic _menhir_stack) MenhirState65
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState65

and _menhir_run74 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ASSIGN ->
        _menhir_run55 _menhir_env (Obj.magic _menhir_stack) MenhirState74
    | OPDIV ->
        _menhir_run54 _menhir_env (Obj.magic _menhir_stack) MenhirState74
    | OPEG ->
        _menhir_run53 _menhir_env (Obj.magic _menhir_stack) MenhirState74
    | OPET ->
        _menhir_run52 _menhir_env (Obj.magic _menhir_stack) MenhirState74
    | OPINF ->
        _menhir_run51 _menhir_env (Obj.magic _menhir_stack) MenhirState74
    | OPINFEG ->
        _menhir_run50 _menhir_env (Obj.magic _menhir_stack) MenhirState74
    | OPMOD ->
        _menhir_run49 _menhir_env (Obj.magic _menhir_stack) MenhirState74
    | OPMOINS ->
        _menhir_run48 _menhir_env (Obj.magic _menhir_stack) MenhirState74
    | OPMULT ->
        _menhir_run47 _menhir_env (Obj.magic _menhir_stack) MenhirState74
    | OPNON ->
        _menhir_run46 _menhir_env (Obj.magic _menhir_stack) MenhirState74
    | OPNONEG ->
        _menhir_run45 _menhir_env (Obj.magic _menhir_stack) MenhirState74
    | OPOU ->
        _menhir_run44 _menhir_env (Obj.magic _menhir_stack) MenhirState74
    | OPPLUS ->
        _menhir_run43 _menhir_env (Obj.magic _menhir_stack) MenhirState74
    | OPPT ->
        _menhir_run42 _menhir_env (Obj.magic _menhir_stack) MenhirState74
    | OPSUP ->
        _menhir_run41 _menhir_env (Obj.magic _menhir_stack) MenhirState74
    | OPSUPEG ->
        _menhir_run40 _menhir_env (Obj.magic _menhir_stack) MenhirState74
    | PAROUV ->
        _menhir_run37 _menhir_env (Obj.magic _menhir_stack) MenhirState74
    | BOOLEEN _ | CARACTERE _ | ENTIER _ | FLOTTANT _ | IDENT _ | NOUVEAU | VIDE ->
        _menhir_reduce66 _menhir_env (Obj.magic _menhir_stack) MenhirState74
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState74

and _menhir_goto_expressionapresunaire : _menhir_env -> 'ttv_tail -> _menhir_state -> (unit) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = Obj.magic _menhir_stack in
    let _menhir_stack = Obj.magic _menhir_stack in
    let (_2 : (unit)) = _v in
    let (_menhir_stack, _menhir_s, (_1 : (unit))) = _menhir_stack in
    let _v : (unit) = 
# 134 "parserJava.mly"
                                              ( (print_endline "expression : unairebloc") )
# 849 "parserJava.ml"
     in
    _menhir_goto_expression _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce43 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _v : (int) = 
# 93 "parserJava.mly"
                                      ( (print_endline "instructions : /* Lambda, mot vide */"); 0 )
# 858 "parserJava.ml"
     in
    _menhir_goto_instructions _menhir_env _menhir_stack _menhir_s _v

and _menhir_run35 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | PAROUV ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | ASSIGN ->
            _menhir_run55 _menhir_env (Obj.magic _menhir_stack) MenhirState36
        | OPDIV ->
            _menhir_run54 _menhir_env (Obj.magic _menhir_stack) MenhirState36
        | OPEG ->
            _menhir_run53 _menhir_env (Obj.magic _menhir_stack) MenhirState36
        | OPET ->
            _menhir_run52 _menhir_env (Obj.magic _menhir_stack) MenhirState36
        | OPINF ->
            _menhir_run51 _menhir_env (Obj.magic _menhir_stack) MenhirState36
        | OPINFEG ->
            _menhir_run50 _menhir_env (Obj.magic _menhir_stack) MenhirState36
        | OPMOD ->
            _menhir_run49 _menhir_env (Obj.magic _menhir_stack) MenhirState36
        | OPMOINS ->
            _menhir_run48 _menhir_env (Obj.magic _menhir_stack) MenhirState36
        | OPMULT ->
            _menhir_run47 _menhir_env (Obj.magic _menhir_stack) MenhirState36
        | OPNON ->
            _menhir_run46 _menhir_env (Obj.magic _menhir_stack) MenhirState36
        | OPNONEG ->
            _menhir_run45 _menhir_env (Obj.magic _menhir_stack) MenhirState36
        | OPOU ->
            _menhir_run44 _menhir_env (Obj.magic _menhir_stack) MenhirState36
        | OPPLUS ->
            _menhir_run43 _menhir_env (Obj.magic _menhir_stack) MenhirState36
        | OPPT ->
            _menhir_run42 _menhir_env (Obj.magic _menhir_stack) MenhirState36
        | OPSUP ->
            _menhir_run41 _menhir_env (Obj.magic _menhir_stack) MenhirState36
        | OPSUPEG ->
            _menhir_run40 _menhir_env (Obj.magic _menhir_stack) MenhirState36
        | PAROUV ->
            _menhir_run37 _menhir_env (Obj.magic _menhir_stack) MenhirState36
        | BOOLEEN _ | CARACTERE _ | ENTIER _ | FLOTTANT _ | IDENT _ | NOUVEAU | VIDE ->
            _menhir_reduce66 _menhir_env (Obj.magic _menhir_stack) MenhirState36
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState36)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run103 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ASSIGN ->
        _menhir_run55 _menhir_env (Obj.magic _menhir_stack) MenhirState103
    | OPDIV ->
        _menhir_run54 _menhir_env (Obj.magic _menhir_stack) MenhirState103
    | OPEG ->
        _menhir_run53 _menhir_env (Obj.magic _menhir_stack) MenhirState103
    | OPET ->
        _menhir_run52 _menhir_env (Obj.magic _menhir_stack) MenhirState103
    | OPINF ->
        _menhir_run51 _menhir_env (Obj.magic _menhir_stack) MenhirState103
    | OPINFEG ->
        _menhir_run50 _menhir_env (Obj.magic _menhir_stack) MenhirState103
    | OPMOD ->
        _menhir_run49 _menhir_env (Obj.magic _menhir_stack) MenhirState103
    | OPMOINS ->
        _menhir_run48 _menhir_env (Obj.magic _menhir_stack) MenhirState103
    | OPMULT ->
        _menhir_run47 _menhir_env (Obj.magic _menhir_stack) MenhirState103
    | OPNON ->
        _menhir_run46 _menhir_env (Obj.magic _menhir_stack) MenhirState103
    | OPNONEG ->
        _menhir_run45 _menhir_env (Obj.magic _menhir_stack) MenhirState103
    | OPOU ->
        _menhir_run44 _menhir_env (Obj.magic _menhir_stack) MenhirState103
    | OPPLUS ->
        _menhir_run43 _menhir_env (Obj.magic _menhir_stack) MenhirState103
    | OPPT ->
        _menhir_run42 _menhir_env (Obj.magic _menhir_stack) MenhirState103
    | OPSUP ->
        _menhir_run41 _menhir_env (Obj.magic _menhir_stack) MenhirState103
    | OPSUPEG ->
        _menhir_run40 _menhir_env (Obj.magic _menhir_stack) MenhirState103
    | PAROUV ->
        _menhir_run37 _menhir_env (Obj.magic _menhir_stack) MenhirState103
    | BOOLEEN _ | CARACTERE _ | ENTIER _ | FLOTTANT _ | IDENT _ | NOUVEAU | VIDE ->
        _menhir_reduce66 _menhir_env (Obj.magic _menhir_stack) MenhirState103
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState103

and _menhir_run40 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _1 = () in
    let _v : (unit) = 
# 126 "parserJava.mly"
                  ( (print_endline "binaire : >=") )
# 975 "parserJava.ml"
     in
    _menhir_goto_binaire _menhir_env _menhir_stack _menhir_s _v

and _menhir_run41 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _1 = () in
    let _v : (unit) = 
# 124 "parserJava.mly"
                ( (print_endline "binaire : >") )
# 987 "parserJava.ml"
     in
    _menhir_goto_binaire _menhir_env _menhir_stack _menhir_s _v

and _menhir_run42 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _1 = () in
    let _v : (unit) = 
# 113 "parserJava.mly"
               ( (print_endline "binaire : .") )
# 999 "parserJava.ml"
     in
    _menhir_goto_binaire _menhir_env _menhir_stack _menhir_s _v

and _menhir_run43 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ASSIGN | BOOLEEN _ | CARACTERE _ | ENTIER _ | FLOTTANT _ | IDENT _ | NOUVEAU | OPDIV | OPEG | OPET | OPINF | OPINFEG | OPMOD | OPMOINS | OPMULT | OPNON | OPNONEG | OPOU | OPPLUS | OPPT | OPSUP | OPSUPEG | PAROUV | VIDE ->
        _menhir_reduce63 _menhir_env (Obj.magic _menhir_stack)
    | CROFER | PARFER | PTVIRG | VIRG ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        let _1 = () in
        let _v : (unit) = 
# 114 "parserJava.mly"
                 ( (print_endline "binaire : +") )
# 1018 "parserJava.ml"
         in
        _menhir_goto_binaire _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run44 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _1 = () in
    let _v : (unit) = 
# 119 "parserJava.mly"
               ( (print_endline "binaire : ||") )
# 1036 "parserJava.ml"
     in
    _menhir_goto_binaire _menhir_env _menhir_stack _menhir_s _v

and _menhir_run45 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _1 = () in
    let _v : (unit) = 
# 122 "parserJava.mly"
                  ( (print_endline "binaire : !=") )
# 1048 "parserJava.ml"
     in
    _menhir_goto_binaire _menhir_env _menhir_stack _menhir_s _v

and _menhir_run47 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _1 = () in
    let _v : (unit) = 
# 116 "parserJava.mly"
                 ( (print_endline "binaire : *") )
# 1060 "parserJava.ml"
     in
    _menhir_goto_binaire _menhir_env _menhir_stack _menhir_s _v

and _menhir_run48 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ASSIGN | BOOLEEN _ | CARACTERE _ | ENTIER _ | FLOTTANT _ | IDENT _ | NOUVEAU | OPDIV | OPEG | OPET | OPINF | OPINFEG | OPMOD | OPMOINS | OPMULT | OPNON | OPNONEG | OPOU | OPPLUS | OPPT | OPSUP | OPSUPEG | PAROUV | VIDE ->
        _menhir_reduce64 _menhir_env (Obj.magic _menhir_stack)
    | CROFER | PARFER | PTVIRG | VIRG ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        let _1 = () in
        let _v : (unit) = 
# 115 "parserJava.mly"
                  ( (print_endline "binaire : -") )
# 1079 "parserJava.ml"
         in
        _menhir_goto_binaire _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run49 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _1 = () in
    let _v : (unit) = 
# 118 "parserJava.mly"
                ( (print_endline "binaire : %") )
# 1097 "parserJava.ml"
     in
    _menhir_goto_binaire _menhir_env _menhir_stack _menhir_s _v

and _menhir_run50 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _1 = () in
    let _v : (unit) = 
# 125 "parserJava.mly"
                  ( (print_endline "binaire : <=") )
# 1109 "parserJava.ml"
     in
    _menhir_goto_binaire _menhir_env _menhir_stack _menhir_s _v

and _menhir_run51 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _1 = () in
    let _v : (unit) = 
# 123 "parserJava.mly"
                ( (print_endline "binaire : <") )
# 1121 "parserJava.ml"
     in
    _menhir_goto_binaire _menhir_env _menhir_stack _menhir_s _v

and _menhir_run52 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _1 = () in
    let _v : (unit) = 
# 120 "parserJava.mly"
               ( (print_endline "binaire : &&") )
# 1133 "parserJava.ml"
     in
    _menhir_goto_binaire _menhir_env _menhir_stack _menhir_s _v

and _menhir_run53 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _1 = () in
    let _v : (unit) = 
# 121 "parserJava.mly"
               ( (print_endline "binaire : ==") )
# 1145 "parserJava.ml"
     in
    _menhir_goto_binaire _menhir_env _menhir_stack _menhir_s _v

and _menhir_run54 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _1 = () in
    let _v : (unit) = 
# 117 "parserJava.mly"
                ( (print_endline "binaire : /") )
# 1157 "parserJava.ml"
     in
    _menhir_goto_binaire _menhir_env _menhir_stack _menhir_s _v

and _menhir_run55 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _1 = () in
    let _v : (unit) = 
# 112 "parserJava.mly"
                 ( (print_endline "binaire : =") )
# 1169 "parserJava.ml"
     in
    _menhir_goto_binaire _menhir_env _menhir_stack _menhir_s _v

and _menhir_run33 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BOOL ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState33
    | CHAR ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState33
    | FLOAT ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState33
    | INT ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState33
    | STRING ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState33
    | TYPEIDENT _v ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState33 _v
    | ACCFER | ASSIGN | BOOLEEN _ | CARACTERE _ | ENTIER _ | FLOTTANT _ | IDENT _ | NOUVEAU | OPDIV | OPEG | OPET | OPINF | OPINFEG | OPMOD | OPMOINS | OPMULT | OPNON | OPNONEG | OPOU | OPPLUS | OPPT | OPSUP | OPSUPEG | PAROUV | RETOUR | SI | VIDE ->
        _menhir_reduce69 _menhir_env (Obj.magic _menhir_stack) MenhirState33
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState33

and _menhir_goto_unairebloc : _menhir_env -> 'ttv_tail -> _menhir_state -> (unit) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState108 | MenhirState34 | MenhirState103 | MenhirState95 | MenhirState56 | MenhirState84 | MenhirState78 | MenhirState74 | MenhirState65 | MenhirState66 | MenhirState58 | MenhirState36 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | ASSIGN ->
            _menhir_run55 _menhir_env (Obj.magic _menhir_stack) MenhirState56
        | BOOLEEN _v ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_s = MenhirState56 in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_1 : (
# 22 "parserJava.mly"
       (bool)
# 1217 "parserJava.ml"
            )) = _v in
            let _v : (unit) = 
# 143 "parserJava.mly"
                     ( (print_endline "expression : BOOLEEN") )
# 1222 "parserJava.ml"
             in
            _menhir_goto_expressionapresunaire _menhir_env _menhir_stack _menhir_s _v
        | CARACTERE _v ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_s = MenhirState56 in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_1 : (
# 23 "parserJava.mly"
       (char)
# 1233 "parserJava.ml"
            )) = _v in
            let _v : (unit) = 
# 142 "parserJava.mly"
                       ( (print_endline "expression : CARACTERE") )
# 1238 "parserJava.ml"
             in
            _menhir_goto_expressionapresunaire _menhir_env _menhir_stack _menhir_s _v
        | ENTIER _v ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_s = MenhirState56 in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_1 : (
# 20 "parserJava.mly"
       (int)
# 1249 "parserJava.ml"
            )) = _v in
            let _v : (unit) = 
# 140 "parserJava.mly"
                              ( (print_endline "expression : ENTIER") )
# 1254 "parserJava.ml"
             in
            _menhir_goto_expressionapresunaire _menhir_env _menhir_stack _menhir_s _v
        | FLOTTANT _v ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_s = MenhirState56 in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_1 : (
# 21 "parserJava.mly"
       (float)
# 1265 "parserJava.ml"
            )) = _v in
            let _v : (unit) = 
# 141 "parserJava.mly"
                      ( (print_endline "expression : FLOTTANT") )
# 1270 "parserJava.ml"
             in
            _menhir_goto_expressionapresunaire _menhir_env _menhir_stack _menhir_s _v
        | IDENT _v ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_s = MenhirState56 in
            let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | CROOUV ->
                _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState87
            | PAROUV ->
                _menhir_run65 _menhir_env (Obj.magic _menhir_stack) MenhirState87
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState87)
        | NOUVEAU ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_s = MenhirState56 in
            let _menhir_stack = (_menhir_stack, _menhir_s) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | IDENT _v ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_stack = (_menhir_stack, _v) in
                let _menhir_env = _menhir_discard _menhir_env in
                let _tok = _menhir_env._menhir_token in
                (match _tok with
                | CROOUV ->
                    let _menhir_stack = Obj.magic _menhir_stack in
                    let _menhir_env = _menhir_discard _menhir_env in
                    let _tok = _menhir_env._menhir_token in
                    (match _tok with
                    | ASSIGN ->
                        _menhir_run55 _menhir_env (Obj.magic _menhir_stack) MenhirState84
                    | OPDIV ->
                        _menhir_run54 _menhir_env (Obj.magic _menhir_stack) MenhirState84
                    | OPEG ->
                        _menhir_run53 _menhir_env (Obj.magic _menhir_stack) MenhirState84
                    | OPET ->
                        _menhir_run52 _menhir_env (Obj.magic _menhir_stack) MenhirState84
                    | OPINF ->
                        _menhir_run51 _menhir_env (Obj.magic _menhir_stack) MenhirState84
                    | OPINFEG ->
                        _menhir_run50 _menhir_env (Obj.magic _menhir_stack) MenhirState84
                    | OPMOD ->
                        _menhir_run49 _menhir_env (Obj.magic _menhir_stack) MenhirState84
                    | OPMOINS ->
                        _menhir_run48 _menhir_env (Obj.magic _menhir_stack) MenhirState84
                    | OPMULT ->
                        _menhir_run47 _menhir_env (Obj.magic _menhir_stack) MenhirState84
                    | OPNON ->
                        _menhir_run46 _menhir_env (Obj.magic _menhir_stack) MenhirState84
                    | OPNONEG ->
                        _menhir_run45 _menhir_env (Obj.magic _menhir_stack) MenhirState84
                    | OPOU ->
                        _menhir_run44 _menhir_env (Obj.magic _menhir_stack) MenhirState84
                    | OPPLUS ->
                        _menhir_run43 _menhir_env (Obj.magic _menhir_stack) MenhirState84
                    | OPPT ->
                        _menhir_run42 _menhir_env (Obj.magic _menhir_stack) MenhirState84
                    | OPSUP ->
                        _menhir_run41 _menhir_env (Obj.magic _menhir_stack) MenhirState84
                    | OPSUPEG ->
                        _menhir_run40 _menhir_env (Obj.magic _menhir_stack) MenhirState84
                    | PAROUV ->
                        _menhir_run37 _menhir_env (Obj.magic _menhir_stack) MenhirState84
                    | BOOLEEN _ | CARACTERE _ | ENTIER _ | FLOTTANT _ | IDENT _ | NOUVEAU | VIDE ->
                        _menhir_reduce66 _menhir_env (Obj.magic _menhir_stack) MenhirState84
                    | _ ->
                        assert (not _menhir_env._menhir_error);
                        _menhir_env._menhir_error <- true;
                        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState84)
                | PAROUV ->
                    let _menhir_stack = Obj.magic _menhir_stack in
                    let _menhir_env = _menhir_discard _menhir_env in
                    let _tok = _menhir_env._menhir_token in
                    (match _tok with
                    | PARFER ->
                        let _menhir_stack = Obj.magic _menhir_stack in
                        let _menhir_env = _menhir_discard _menhir_env in
                        let _menhir_stack = Obj.magic _menhir_stack in
                        let ((_menhir_stack, _menhir_s), (_2 : (
# 14 "parserJava.mly"
       (string)
# 1358 "parserJava.ml"
                        ))) = _menhir_stack in
                        let _4 = () in
                        let _3 = () in
                        let _1 = () in
                        let _v : (unit) = 
# 145 "parserJava.mly"
                                          ( (print_endline "expression : new ident()") )
# 1366 "parserJava.ml"
                         in
                        _menhir_goto_expressionapresunaire _menhir_env _menhir_stack _menhir_s _v
                    | _ ->
                        assert (not _menhir_env._menhir_error);
                        _menhir_env._menhir_error <- true;
                        let _menhir_stack = Obj.magic _menhir_stack in
                        let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
                        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
                | _ ->
                    assert (not _menhir_env._menhir_error);
                    _menhir_env._menhir_error <- true;
                    let _menhir_stack = Obj.magic _menhir_stack in
                    let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let _menhir_stack = Obj.magic _menhir_stack in
                let (_menhir_stack, _menhir_s) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
        | OPDIV ->
            _menhir_run54 _menhir_env (Obj.magic _menhir_stack) MenhirState56
        | OPEG ->
            _menhir_run53 _menhir_env (Obj.magic _menhir_stack) MenhirState56
        | OPET ->
            _menhir_run52 _menhir_env (Obj.magic _menhir_stack) MenhirState56
        | OPINF ->
            _menhir_run51 _menhir_env (Obj.magic _menhir_stack) MenhirState56
        | OPINFEG ->
            _menhir_run50 _menhir_env (Obj.magic _menhir_stack) MenhirState56
        | OPMOD ->
            _menhir_run49 _menhir_env (Obj.magic _menhir_stack) MenhirState56
        | OPMOINS ->
            _menhir_run48 _menhir_env (Obj.magic _menhir_stack) MenhirState56
        | OPMULT ->
            _menhir_run47 _menhir_env (Obj.magic _menhir_stack) MenhirState56
        | OPNON ->
            _menhir_run46 _menhir_env (Obj.magic _menhir_stack) MenhirState56
        | OPNONEG ->
            _menhir_run45 _menhir_env (Obj.magic _menhir_stack) MenhirState56
        | OPOU ->
            _menhir_run44 _menhir_env (Obj.magic _menhir_stack) MenhirState56
        | OPPLUS ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_s = MenhirState56 in
            let _menhir_stack = (_menhir_stack, _menhir_s) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | ASSIGN ->
                _menhir_run55 _menhir_env (Obj.magic _menhir_stack) MenhirState78
            | OPDIV ->
                _menhir_run54 _menhir_env (Obj.magic _menhir_stack) MenhirState78
            | OPEG ->
                _menhir_run53 _menhir_env (Obj.magic _menhir_stack) MenhirState78
            | OPET ->
                _menhir_run52 _menhir_env (Obj.magic _menhir_stack) MenhirState78
            | OPINF ->
                _menhir_run51 _menhir_env (Obj.magic _menhir_stack) MenhirState78
            | OPINFEG ->
                _menhir_run50 _menhir_env (Obj.magic _menhir_stack) MenhirState78
            | OPMOD ->
                _menhir_run49 _menhir_env (Obj.magic _menhir_stack) MenhirState78
            | OPMOINS ->
                _menhir_run48 _menhir_env (Obj.magic _menhir_stack) MenhirState78
            | OPMULT ->
                _menhir_run47 _menhir_env (Obj.magic _menhir_stack) MenhirState78
            | OPNON ->
                _menhir_run46 _menhir_env (Obj.magic _menhir_stack) MenhirState78
            | OPNONEG ->
                _menhir_run45 _menhir_env (Obj.magic _menhir_stack) MenhirState78
            | OPOU ->
                _menhir_run44 _menhir_env (Obj.magic _menhir_stack) MenhirState78
            | OPPLUS ->
                _menhir_run43 _menhir_env (Obj.magic _menhir_stack) MenhirState78
            | OPPT ->
                _menhir_run42 _menhir_env (Obj.magic _menhir_stack) MenhirState78
            | OPSUP ->
                _menhir_run41 _menhir_env (Obj.magic _menhir_stack) MenhirState78
            | OPSUPEG ->
                _menhir_run40 _menhir_env (Obj.magic _menhir_stack) MenhirState78
            | PAROUV ->
                _menhir_run37 _menhir_env (Obj.magic _menhir_stack) MenhirState78
            | BOOLEEN _ | CARACTERE _ | ENTIER _ | FLOTTANT _ | IDENT _ | NOUVEAU | VIDE ->
                _menhir_reduce63 _menhir_env (Obj.magic _menhir_stack)
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState78)
        | OPPT ->
            _menhir_run42 _menhir_env (Obj.magic _menhir_stack) MenhirState56
        | OPSUP ->
            _menhir_run41 _menhir_env (Obj.magic _menhir_stack) MenhirState56
        | OPSUPEG ->
            _menhir_run40 _menhir_env (Obj.magic _menhir_stack) MenhirState56
        | PAROUV ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_s = MenhirState56 in
            let _menhir_stack = (_menhir_stack, _menhir_s) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | ASSIGN ->
                _menhir_run55 _menhir_env (Obj.magic _menhir_stack) MenhirState58
            | BOOL ->
                _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState58
            | CHAR ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState58
            | FLOAT ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState58
            | INT ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState58
            | OPDIV ->
                _menhir_run54 _menhir_env (Obj.magic _menhir_stack) MenhirState58
            | OPEG ->
                _menhir_run53 _menhir_env (Obj.magic _menhir_stack) MenhirState58
            | OPET ->
                _menhir_run52 _menhir_env (Obj.magic _menhir_stack) MenhirState58
            | OPINF ->
                _menhir_run51 _menhir_env (Obj.magic _menhir_stack) MenhirState58
            | OPINFEG ->
                _menhir_run50 _menhir_env (Obj.magic _menhir_stack) MenhirState58
            | OPMOD ->
                _menhir_run49 _menhir_env (Obj.magic _menhir_stack) MenhirState58
            | OPMOINS ->
                _menhir_run48 _menhir_env (Obj.magic _menhir_stack) MenhirState58
            | OPMULT ->
                _menhir_run47 _menhir_env (Obj.magic _menhir_stack) MenhirState58
            | OPNON ->
                _menhir_run46 _menhir_env (Obj.magic _menhir_stack) MenhirState58
            | OPNONEG ->
                _menhir_run45 _menhir_env (Obj.magic _menhir_stack) MenhirState58
            | OPOU ->
                _menhir_run44 _menhir_env (Obj.magic _menhir_stack) MenhirState58
            | OPPLUS ->
                _menhir_run43 _menhir_env (Obj.magic _menhir_stack) MenhirState58
            | OPPT ->
                _menhir_run42 _menhir_env (Obj.magic _menhir_stack) MenhirState58
            | OPSUP ->
                _menhir_run41 _menhir_env (Obj.magic _menhir_stack) MenhirState58
            | OPSUPEG ->
                _menhir_run40 _menhir_env (Obj.magic _menhir_stack) MenhirState58
            | PAROUV ->
                _menhir_run37 _menhir_env (Obj.magic _menhir_stack) MenhirState58
            | STRING ->
                _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState58
            | TYPEIDENT _v ->
                _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState58 _v
            | BOOLEEN _ | CARACTERE _ | ENTIER _ | FLOTTANT _ | IDENT _ | NOUVEAU | VIDE ->
                _menhir_reduce66 _menhir_env (Obj.magic _menhir_stack) MenhirState58
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState58)
        | VIDE ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_s = MenhirState56 in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let _1 = () in
            let _v : (unit) = 
# 144 "parserJava.mly"
                  ( (print_endline "expression : VIDE") )
# 1530 "parserJava.ml"
             in
            _menhir_goto_expressionapresunaire _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState56)
    | MenhirState59 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s, (_1 : (unit))), _, (_2 : (unit))) = _menhir_stack in
        let _v : (unit) = 
# 110 "parserJava.mly"
                            ( (print_endline "unairebloc : unaire uanirebloc") )
# 1544 "parserJava.ml"
         in
        _menhir_goto_unairebloc _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        _menhir_fail ()

and _menhir_goto_variables : _menhir_env -> 'ttv_tail -> _menhir_state -> (int) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState33 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | ASSIGN ->
            _menhir_run55 _menhir_env (Obj.magic _menhir_stack) MenhirState34
        | OPDIV ->
            _menhir_run54 _menhir_env (Obj.magic _menhir_stack) MenhirState34
        | OPEG ->
            _menhir_run53 _menhir_env (Obj.magic _menhir_stack) MenhirState34
        | OPET ->
            _menhir_run52 _menhir_env (Obj.magic _menhir_stack) MenhirState34
        | OPINF ->
            _menhir_run51 _menhir_env (Obj.magic _menhir_stack) MenhirState34
        | OPINFEG ->
            _menhir_run50 _menhir_env (Obj.magic _menhir_stack) MenhirState34
        | OPMOD ->
            _menhir_run49 _menhir_env (Obj.magic _menhir_stack) MenhirState34
        | OPMOINS ->
            _menhir_run48 _menhir_env (Obj.magic _menhir_stack) MenhirState34
        | OPMULT ->
            _menhir_run47 _menhir_env (Obj.magic _menhir_stack) MenhirState34
        | OPNON ->
            _menhir_run46 _menhir_env (Obj.magic _menhir_stack) MenhirState34
        | OPNONEG ->
            _menhir_run45 _menhir_env (Obj.magic _menhir_stack) MenhirState34
        | OPOU ->
            _menhir_run44 _menhir_env (Obj.magic _menhir_stack) MenhirState34
        | OPPLUS ->
            _menhir_run43 _menhir_env (Obj.magic _menhir_stack) MenhirState34
        | OPPT ->
            _menhir_run42 _menhir_env (Obj.magic _menhir_stack) MenhirState34
        | OPSUP ->
            _menhir_run41 _menhir_env (Obj.magic _menhir_stack) MenhirState34
        | OPSUPEG ->
            _menhir_run40 _menhir_env (Obj.magic _menhir_stack) MenhirState34
        | PAROUV ->
            _menhir_run37 _menhir_env (Obj.magic _menhir_stack) MenhirState34
        | RETOUR ->
            _menhir_run103 _menhir_env (Obj.magic _menhir_stack) MenhirState34
        | SI ->
            _menhir_run35 _menhir_env (Obj.magic _menhir_stack) MenhirState34
        | BOOLEEN _ | CARACTERE _ | ENTIER _ | FLOTTANT _ | IDENT _ | NOUVEAU | VIDE ->
            _menhir_reduce66 _menhir_env (Obj.magic _menhir_stack) MenhirState34
        | ACCFER ->
            _menhir_reduce43 _menhir_env (Obj.magic _menhir_stack) MenhirState34
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState34)
    | MenhirState112 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s, (_1 : (unit))), _, (_2 : (int))) = _menhir_stack in
        let _v : (int) = 
# 88 "parserJava.mly"
                                      ( (print_endline "variables : variable variables"); (_2 + 1) )
# 1612 "parserJava.ml"
         in
        _menhir_goto_variables _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        _menhir_fail ()

and _menhir_goto_suiteParsFormels : _menhir_env -> 'ttv_tail -> _menhir_state -> (unit) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState14 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_4 : (unit)) = _v in
        let (((_menhir_stack, _menhir_s), _, (_2 : (unit))), (_3 : (
# 14 "parserJava.mly"
       (string)
# 1628 "parserJava.ml"
        ))) = _menhir_stack in
        let _1 = () in
        let _v : (unit) = 
# 83 "parserJava.mly"
                                                          ( (print_endline "suiteParsFormels : VIRG typeStruct IDENT suiteParsFormels") )
# 1634 "parserJava.ml"
         in
        _menhir_goto_suiteParsFormels _menhir_env _menhir_stack _menhir_s _v
    | MenhirState11 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_3 : (unit)) = _v in
        let ((_menhir_stack, _menhir_s, (_1 : (unit))), (_2 : (
# 14 "parserJava.mly"
       (string)
# 1644 "parserJava.ml"
        ))) = _menhir_stack in
        let _v : (unit) = 
# 80 "parserJava.mly"
                                                ( (print_endline "parsFormels : typeStruct IDENT suiteParsFormels") )
# 1649 "parserJava.ml"
         in
        _menhir_goto_parsFormels _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        _menhir_fail ()

and _menhir_goto_entete : _menhir_env -> 'ttv_tail -> _menhir_state -> (unit) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_stack = Obj.magic _menhir_stack in
    assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ACCOUV ->
        _menhir_run33 _menhir_env (Obj.magic _menhir_stack) MenhirState32
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState32

and _menhir_reduce66 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _v : (unit) = 
# 109 "parserJava.mly"
                                     ( (print_endline "unairebloc : /* Lambda, mot vide */") )
# 1674 "parserJava.ml"
     in
    _menhir_goto_unairebloc _menhir_env _menhir_stack _menhir_s _v

and _menhir_run37 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BOOL ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState37
    | CHAR ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState37
    | FLOAT ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState37
    | INT ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState37
    | STRING ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState37
    | TYPEIDENT _v ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState37 _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState37

and _menhir_reduce63 : _menhir_env -> 'ttv_tail * _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_stack, _menhir_s) = _menhir_stack in
    let _1 = () in
    let _v : (unit) = 
# 105 "parserJava.mly"
                 ( (print_endline "unaire : +") )
# 1708 "parserJava.ml"
     in
    _menhir_goto_unaire _menhir_env _menhir_stack _menhir_s _v

and _menhir_run46 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _1 = () in
    let _v : (unit) = 
# 107 "parserJava.mly"
                ( (print_endline "unaire : ! ") )
# 1720 "parserJava.ml"
     in
    _menhir_goto_unaire _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce64 : _menhir_env -> 'ttv_tail * _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_stack, _menhir_s) = _menhir_stack in
    let _1 = () in
    let _v : (unit) = 
# 106 "parserJava.mly"
                  ( (print_endline "unaire : - ") )
# 1731 "parserJava.ml"
     in
    _menhir_goto_unaire _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce69 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _v : (int) = 
# 87 "parserJava.mly"
                                   ( (print_endline "variables : /* Lambda, mot vide */"); 0 )
# 1740 "parserJava.ml"
     in
    _menhir_goto_variables _menhir_env _menhir_stack _menhir_s _v

and _menhir_reduce53 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _v : (unit) = 
# 82 "parserJava.mly"
                                          ( (print_endline "suiteParsFormels : /* Lambda, mot vide */") )
# 1749 "parserJava.ml"
     in
    _menhir_goto_suiteParsFormels _menhir_env _menhir_stack _menhir_s _v

and _menhir_run12 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BOOL ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState12
    | CHAR ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState12
    | FLOAT ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState12
    | INT ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState12
    | STRING ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState12
    | TYPEIDENT _v ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState12 _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState12

and _menhir_goto_parsFormels : _menhir_env -> 'ttv_tail -> _menhir_state -> (unit) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState3 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | PARFER ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((_menhir_stack, _menhir_s), (_2 : (
# 14 "parserJava.mly"
       (string)
# 1792 "parserJava.ml"
            ))), _, (_4 : (unit))) = _menhir_stack in
            let _5 = () in
            let _3 = () in
            let _1 = () in
            let _v : (unit) = 
# 77 "parserJava.mly"
                                              ( (print_endline "entete : VOID IDENT PAROUV parsFormels PARFER") )
# 1800 "parserJava.ml"
             in
            _menhir_goto_entete _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState25 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | PARFER ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((_menhir_stack, _menhir_s, (_1 : (unit))), (_2 : (
# 14 "parserJava.mly"
       (string)
# 1821 "parserJava.ml"
            ))), _, (_4 : (unit))) = _menhir_stack in
            let _5 = () in
            let _3 = () in
            let _v : (unit) = 
# 76 "parserJava.mly"
                                                    ( (print_endline "entete : typeStruct IDENT PAROUV parsFormels PARFER") )
# 1828 "parserJava.ml"
             in
            _menhir_goto_entete _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        _menhir_fail ()

and _menhir_fail : unit -> 'a =
  fun () ->
    Printf.fprintf stderr "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

and _menhir_goto_unaire : _menhir_env -> 'ttv_tail -> _menhir_state -> (unit) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_stack = Obj.magic _menhir_stack in
    assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | OPMOINS ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_s = MenhirState59 in
        let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _menhir_env = _menhir_discard _menhir_env in
        _menhir_reduce64 _menhir_env (Obj.magic _menhir_stack)
    | OPNON ->
        _menhir_run46 _menhir_env (Obj.magic _menhir_stack) MenhirState59
    | OPPLUS ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_s = MenhirState59 in
        let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _menhir_env = _menhir_discard _menhir_env in
        _menhir_reduce63 _menhir_env (Obj.magic _menhir_stack)
    | PAROUV ->
        _menhir_run37 _menhir_env (Obj.magic _menhir_stack) MenhirState59
    | ASSIGN | BOOLEEN _ | CARACTERE _ | ENTIER _ | FLOTTANT _ | IDENT _ | NOUVEAU | OPDIV | OPEG | OPET | OPINF | OPINFEG | OPMOD | OPMULT | OPNONEG | OPOU | OPPT | OPSUP | OPSUPEG | VIDE ->
        _menhir_reduce66 _menhir_env (Obj.magic _menhir_stack) MenhirState59
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState59

and _menhir_goto_declTab : _menhir_env -> 'ttv_tail -> (unit) -> 'ttv_return =
  fun _menhir_env _menhir_stack _v ->
    let _menhir_stack = Obj.magic _menhir_stack in
    let _menhir_stack = Obj.magic _menhir_stack in
    let (_2 : (unit)) = _v in
    let (_menhir_stack, _menhir_s, (_1 : (unit))) = _menhir_stack in
    let _v : (unit) = 
# 62 "parserJava.mly"
                              ( (print_endline "typeStruct : typeBase declTab") )
# 1884 "parserJava.ml"
     in
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState25 | MenhirState3 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | IDENT _v ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = (_menhir_stack, _v) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | VIRG ->
                _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState11
            | PARFER ->
                _menhir_reduce53 _menhir_env (Obj.magic _menhir_stack) MenhirState11
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState11)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState12 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | IDENT _v ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = (_menhir_stack, _v) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | VIRG ->
                _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState14
            | PARFER ->
                _menhir_reduce53 _menhir_env (Obj.magic _menhir_stack) MenhirState14
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState14)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState30 | MenhirState0 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | IDENT _v ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = (_menhir_stack, _v) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | PAROUV ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_env = _menhir_discard _menhir_env in
                let _tok = _menhir_env._menhir_token in
                (match _tok with
                | BOOL ->
                    _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState25
                | CHAR ->
                    _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState25
                | FLOAT ->
                    _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState25
                | INT ->
                    _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState25
                | STRING ->
                    _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState25
                | TYPEIDENT _v ->
                    _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState25 _v
                | PARFER ->
                    _menhir_reduce45 _menhir_env (Obj.magic _menhir_stack) MenhirState25
                | _ ->
                    assert (not _menhir_env._menhir_error);
                    _menhir_env._menhir_error <- true;
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState25)
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let _menhir_stack = Obj.magic _menhir_stack in
                let ((_menhir_stack, _menhir_s, _), _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState33 | MenhirState112 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | IDENT _v ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = (_menhir_stack, _v) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | PTVIRG ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_env = _menhir_discard _menhir_env in
                let _menhir_stack = Obj.magic _menhir_stack in
                let ((_menhir_stack, _menhir_s, (_1 : (unit))), (_2 : (
# 14 "parserJava.mly"
       (string)
# 2002 "parserJava.ml"
                ))) = _menhir_stack in
                let _3 = () in
                let _v : (unit) = 
# 90 "parserJava.mly"
                                   ( (print_endline "variable : typeStruct IDENT PTVIRG") )
# 2008 "parserJava.ml"
                 in
                let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
                let _menhir_stack = Obj.magic _menhir_stack in
                assert (not _menhir_env._menhir_error);
                let _tok = _menhir_env._menhir_token in
                (match _tok with
                | BOOL ->
                    _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState112
                | CHAR ->
                    _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState112
                | FLOAT ->
                    _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState112
                | INT ->
                    _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState112
                | STRING ->
                    _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState112
                | TYPEIDENT _v ->
                    _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState112 _v
                | ACCFER | ASSIGN | BOOLEEN _ | CARACTERE _ | ENTIER _ | FLOTTANT _ | IDENT _ | NOUVEAU | OPDIV | OPEG | OPET | OPINF | OPINFEG | OPMOD | OPMOINS | OPMULT | OPNON | OPNONEG | OPOU | OPPLUS | OPPT | OPSUP | OPSUPEG | PAROUV | RETOUR | SI | VIDE ->
                    _menhir_reduce69 _menhir_env (Obj.magic _menhir_stack) MenhirState112
                | _ ->
                    assert (not _menhir_env._menhir_error);
                    _menhir_env._menhir_error <- true;
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState112)
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let _menhir_stack = Obj.magic _menhir_stack in
                let ((_menhir_stack, _menhir_s, _), _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        _menhir_fail ()

and _menhir_goto_programme : _menhir_env -> 'ttv_tail -> _menhir_state -> (int) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState0 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | FIN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, (_1 : (int))) = _menhir_stack in
            let _2 = () in
            let _v : (unit) = 
# 57 "parserJava.mly"
                        ( (print_endline "fichier : programme FIN"); (print_string "Nombre de méthodes = "); (print_int _1); (print_newline ()) )
# 2065 "parserJava.ml"
             in
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_1 : (unit)) = _v in
            Obj.magic _1
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState30 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s, (_1 : (unit))), _, (_2 : (int))) = _menhir_stack in
        let _v : (int) = 
# 60 "parserJava.mly"
                               ( (print_endline "programme : fonction programme"); (_2 + 1) )
# 2084 "parserJava.ml"
         in
        _menhir_goto_programme _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        _menhir_fail ()

and _menhir_reduce45 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _v : (unit) = 
# 79 "parserJava.mly"
                                     ( (print_endline "parsFormels : /* Lambda, mot vide */") )
# 2095 "parserJava.ml"
     in
    _menhir_goto_parsFormels _menhir_env _menhir_stack _menhir_s _v

and _menhir_goto_typeBase : _menhir_env -> 'ttv_tail -> _menhir_state -> (unit) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState33 | MenhirState112 | MenhirState30 | MenhirState0 | MenhirState25 | MenhirState3 | MenhirState12 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | CROOUV ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | CROFER ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_env = _menhir_discard _menhir_env in
                let _menhir_stack = Obj.magic _menhir_stack in
                let _2 = () in
                let _1 = () in
                let _v : (unit) = 
# 72 "parserJava.mly"
                        ( (print_endline "declTab : CROOUV CROFER") )
# 2122 "parserJava.ml"
                 in
                _menhir_goto_declTab _menhir_env _menhir_stack _v
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let _menhir_stack = Obj.magic _menhir_stack in
                raise _eRR)
        | IDENT _ ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _v : (unit) = 
# 71 "parserJava.mly"
                                 ( (print_endline "declTab : /* Lambda, mot vide */") )
# 2135 "parserJava.ml"
             in
            _menhir_goto_declTab _menhir_env _menhir_stack _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState58 | MenhirState37 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | PARFER ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s), _, (_2 : (unit))) = _menhir_stack in
            let _3 = () in
            let _1 = () in
            let _v : (unit) = 
# 104 "parserJava.mly"
                                ( (print_endline "unaire : (typebase)") )
# 2159 "parserJava.ml"
             in
            _menhir_goto_unaire _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        _menhir_fail ()

and _menhir_errorcase : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    match _menhir_s with
    | MenhirState112 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState108 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState103 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState100 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        raise _eRR
    | MenhirState98 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState95 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState87 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState84 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState78 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState74 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState67 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState66 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState65 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState64 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState59 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState58 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState56 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState37 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState36 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState34 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState33 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState32 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState30 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState25 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s, _), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState14 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s, _), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState12 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState11 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s, _), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState3 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState0 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        raise _eRR

and _menhir_reduce47 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _v : (int) = 
# 59 "parserJava.mly"
                                   ( (print_endline "programme : /* Lambda, mot vide */"); 0 )
# 2294 "parserJava.ml"
     in
    _menhir_goto_programme _menhir_env _menhir_stack _menhir_s _v

and _menhir_run1 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | IDENT _v ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = (_menhir_stack, _v) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | PAROUV ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | BOOL ->
                _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState3
            | CHAR ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState3
            | FLOAT ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState3
            | INT ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState3
            | STRING ->
                _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState3
            | TYPEIDENT _v ->
                _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState3 _v
            | PARFER ->
                _menhir_reduce45 _menhir_env (Obj.magic _menhir_stack) MenhirState3
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState3)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run4 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 14 "parserJava.mly"
       (string)
# 2349 "parserJava.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let (_1 : (
# 14 "parserJava.mly"
       (string)
# 2357 "parserJava.ml"
    )) = _v in
    let _v : (unit) = 
# 69 "parserJava.mly"
                     ( (print_endline "typeBase : TYPEIDENT") )
# 2362 "parserJava.ml"
     in
    _menhir_goto_typeBase _menhir_env _menhir_stack _menhir_s _v

and _menhir_run5 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _1 = () in
    let _v : (unit) = 
# 68 "parserJava.mly"
                  ( (print_endline "typeBase : STRING") )
# 2374 "parserJava.ml"
     in
    _menhir_goto_typeBase _menhir_env _menhir_stack _menhir_s _v

and _menhir_run6 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _1 = () in
    let _v : (unit) = 
# 64 "parserJava.mly"
               ( (print_endline "typeBase : INT") )
# 2386 "parserJava.ml"
     in
    _menhir_goto_typeBase _menhir_env _menhir_stack _menhir_s _v

and _menhir_run7 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _1 = () in
    let _v : (unit) = 
# 65 "parserJava.mly"
                 ( (print_endline "typeBase : FLOAT") )
# 2398 "parserJava.ml"
     in
    _menhir_goto_typeBase _menhir_env _menhir_stack _menhir_s _v

and _menhir_run8 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _1 = () in
    let _v : (unit) = 
# 67 "parserJava.mly"
                ( (print_endline "typeBase : CHAR") )
# 2410 "parserJava.ml"
     in
    _menhir_goto_typeBase _menhir_env _menhir_stack _menhir_s _v

and _menhir_run9 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _1 = () in
    let _v : (unit) = 
# 66 "parserJava.mly"
                ( (print_endline "typeBase : BOOL") )
# 2422 "parserJava.ml"
     in
    _menhir_goto_typeBase _menhir_env _menhir_stack _menhir_s _v

and _menhir_discard : _menhir_env -> _menhir_env =
  fun _menhir_env ->
    let lexer = _menhir_env._menhir_lexer in
    let lexbuf = _menhir_env._menhir_lexbuf in
    let _tok = lexer lexbuf in
    {
      _menhir_lexer = lexer;
      _menhir_lexbuf = lexbuf;
      _menhir_token = _tok;
      _menhir_error = false;
    }

and fichier : (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (unit) =
  fun lexer lexbuf ->
    let _menhir_env = let _tok = Obj.magic () in
    {
      _menhir_lexer = lexer;
      _menhir_lexbuf = lexbuf;
      _menhir_token = _tok;
      _menhir_error = false;
    } in
    Obj.magic (let _menhir_stack = ((), _menhir_env._menhir_lexbuf.Lexing.lex_curr_p) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BOOL ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | CHAR ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | FLOAT ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | INT ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | STRING ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | TYPEIDENT _v ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState0 _v
    | VOID ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | FIN ->
        _menhir_reduce47 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState0)

# 151 "parserJava.mly"
  

# 2475 "parserJava.ml"

# 269 "<standard.mly>"
  

# 2480 "parserJava.ml"
