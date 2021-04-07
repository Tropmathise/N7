
module MenhirBasics = struct
  
  exception Error
  
  type token = 
    | XXXX
    | NAME of (
# 2 "parser.mly"
       (string)
# 12 "parser.ml"
  )
    | INT of (
# 1 "parser.mly"
       (int)
# 17 "parser.ml"
  )
    | EOF
  
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
  | MenhirState8
  | MenhirState0

let rec _menhir_goto_main : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 10 "parser.mly"
       ((int*string*int*int) list)
# 42 "parser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState0 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv37) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : (
# 10 "parser.mly"
       ((int*string*int*int) list)
# 53 "parser.ml"
        )) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv35) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let ((_1 : (
# 10 "parser.mly"
       ((int*string*int*int) list)
# 61 "parser.ml"
        )) : (
# 10 "parser.mly"
       ((int*string*int*int) list)
# 65 "parser.ml"
        )) = _v in
        (Obj.magic _1 : 'freshtv36)) : 'freshtv38)
    | MenhirState8 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv41 * _menhir_state * (
# 7 "parser.mly"
      ((int*string*int*int))
# 73 "parser.ml"
        )) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : (
# 10 "parser.mly"
       ((int*string*int*int) list)
# 79 "parser.ml"
        )) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv39 * _menhir_state * (
# 7 "parser.mly"
      ((int*string*int*int))
# 85 "parser.ml"
        )) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((m : (
# 10 "parser.mly"
       ((int*string*int*int) list)
# 91 "parser.ml"
        )) : (
# 10 "parser.mly"
       ((int*string*int*int) list)
# 95 "parser.ml"
        )) = _v in
        ((let (_menhir_stack, _menhir_s, (stat : (
# 7 "parser.mly"
      ((int*string*int*int))
# 100 "parser.ml"
        ))) = _menhir_stack in
        let _v : (
# 10 "parser.mly"
       ((int*string*int*int) list)
# 105 "parser.ml"
        ) = 
# 16 "parser.mly"
                        ( stat :: m)
# 109 "parser.ml"
         in
        _menhir_goto_main _menhir_env _menhir_stack _menhir_s _v) : 'freshtv40)) : 'freshtv42)

and _menhir_goto_ligne : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 7 "parser.mly"
      ((int*string*int*int))
# 116 "parser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv33 * _menhir_state * (
# 7 "parser.mly"
      ((int*string*int*int))
# 124 "parser.ml"
    )) = Obj.magic _menhir_stack in
    ((assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | EOF ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv31 * _menhir_state * (
# 7 "parser.mly"
      ((int*string*int*int))
# 134 "parser.ml"
        )) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState8 in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv29 * _menhir_state * (
# 7 "parser.mly"
      ((int*string*int*int))
# 141 "parser.ml"
        )) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        ((let (_menhir_stack, _menhir_s, (stat : (
# 7 "parser.mly"
      ((int*string*int*int))
# 147 "parser.ml"
        ))) = _menhir_stack in
        let _2 = () in
        let _v : (
# 10 "parser.mly"
       ((int*string*int*int) list)
# 153 "parser.ml"
        ) = 
# 15 "parser.mly"
                   ( [stat] )
# 157 "parser.ml"
         in
        _menhir_goto_main _menhir_env _menhir_stack _menhir_s _v) : 'freshtv30)) : 'freshtv32)
    | INT _v ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState8 _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState8) : 'freshtv34)

and _menhir_errorcase : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    match _menhir_s with
    | MenhirState8 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv25 * _menhir_state * (
# 7 "parser.mly"
      ((int*string*int*int))
# 175 "parser.ml"
        )) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv26)
    | MenhirState0 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv27) = Obj.magic _menhir_stack in
        (raise _eRR : 'freshtv28)

and _menhir_run1 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 1 "parser.mly"
       (int)
# 187 "parser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | NAME _v ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv21 * _menhir_state * (
# 1 "parser.mly"
       (int)
# 199 "parser.ml"
        )) = Obj.magic _menhir_stack in
        let (_v : (
# 2 "parser.mly"
       (string)
# 204 "parser.ml"
        )) = _v in
        ((let _menhir_stack = (_menhir_stack, _v) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | INT _v ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv9 * _menhir_state * (
# 1 "parser.mly"
       (int)
# 215 "parser.ml"
            )) * (
# 2 "parser.mly"
       (string)
# 219 "parser.ml"
            )) = Obj.magic _menhir_stack in
            let (_v : (
# 1 "parser.mly"
       (int)
# 224 "parser.ml"
            )) = _v in
            ((let _menhir_stack = (_menhir_stack, _v) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | INT _v ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (('freshtv5 * _menhir_state * (
# 1 "parser.mly"
       (int)
# 235 "parser.ml"
                )) * (
# 2 "parser.mly"
       (string)
# 239 "parser.ml"
                )) * (
# 1 "parser.mly"
       (int)
# 243 "parser.ml"
                )) = Obj.magic _menhir_stack in
                let (_v : (
# 1 "parser.mly"
       (int)
# 248 "parser.ml"
                )) = _v in
                ((let _menhir_env = _menhir_discard _menhir_env in
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (('freshtv3 * _menhir_state * (
# 1 "parser.mly"
       (int)
# 255 "parser.ml"
                )) * (
# 2 "parser.mly"
       (string)
# 259 "parser.ml"
                )) * (
# 1 "parser.mly"
       (int)
# 263 "parser.ml"
                )) = Obj.magic _menhir_stack in
                let ((nb : (
# 1 "parser.mly"
       (int)
# 268 "parser.ml"
                )) : (
# 1 "parser.mly"
       (int)
# 272 "parser.ml"
                )) = _v in
                ((let (((_menhir_stack, _menhir_s, (sexe : (
# 1 "parser.mly"
       (int)
# 277 "parser.ml"
                ))), (prenom : (
# 2 "parser.mly"
       (string)
# 281 "parser.ml"
                ))), (annee : (
# 1 "parser.mly"
       (int)
# 285 "parser.ml"
                ))) = _menhir_stack in
                let _v : (
# 7 "parser.mly"
      ((int*string*int*int))
# 290 "parser.ml"
                ) = 
# 19 "parser.mly"
                                                ((sexe,prenom,annee,nb))
# 294 "parser.ml"
                 in
                _menhir_goto_ligne _menhir_env _menhir_stack _menhir_s _v) : 'freshtv4)) : 'freshtv6)
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (('freshtv7 * _menhir_state * (
# 1 "parser.mly"
       (int)
# 304 "parser.ml"
                )) * (
# 2 "parser.mly"
       (string)
# 308 "parser.ml"
                )) * (
# 1 "parser.mly"
       (int)
# 312 "parser.ml"
                )) = Obj.magic _menhir_stack in
                ((let (((_menhir_stack, _menhir_s, _), _), _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv8)) : 'freshtv10)
        | XXXX ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv17 * _menhir_state * (
# 1 "parser.mly"
       (int)
# 321 "parser.ml"
            )) * (
# 2 "parser.mly"
       (string)
# 325 "parser.ml"
            )) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | INT _v ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (('freshtv13 * _menhir_state * (
# 1 "parser.mly"
       (int)
# 335 "parser.ml"
                )) * (
# 2 "parser.mly"
       (string)
# 339 "parser.ml"
                ))) = Obj.magic _menhir_stack in
                let (_v : (
# 1 "parser.mly"
       (int)
# 344 "parser.ml"
                )) = _v in
                ((let _menhir_env = _menhir_discard _menhir_env in
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (('freshtv11 * _menhir_state * (
# 1 "parser.mly"
       (int)
# 351 "parser.ml"
                )) * (
# 2 "parser.mly"
       (string)
# 355 "parser.ml"
                ))) = Obj.magic _menhir_stack in
                let ((nb : (
# 1 "parser.mly"
       (int)
# 360 "parser.ml"
                )) : (
# 1 "parser.mly"
       (int)
# 364 "parser.ml"
                )) = _v in
                ((let ((_menhir_stack, _menhir_s, (sexe : (
# 1 "parser.mly"
       (int)
# 369 "parser.ml"
                ))), (prenom : (
# 2 "parser.mly"
       (string)
# 373 "parser.ml"
                ))) = _menhir_stack in
                let _3 = () in
                let _v : (
# 7 "parser.mly"
      ((int*string*int*int))
# 379 "parser.ml"
                ) = 
# 20 "parser.mly"
                                         ((sexe,prenom,-1,nb))
# 383 "parser.ml"
                 in
                _menhir_goto_ligne _menhir_env _menhir_stack _menhir_s _v) : 'freshtv12)) : 'freshtv14)
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (('freshtv15 * _menhir_state * (
# 1 "parser.mly"
       (int)
# 393 "parser.ml"
                )) * (
# 2 "parser.mly"
       (string)
# 397 "parser.ml"
                ))) = Obj.magic _menhir_stack in
                ((let ((_menhir_stack, _menhir_s, _), _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv16)) : 'freshtv18)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv19 * _menhir_state * (
# 1 "parser.mly"
       (int)
# 408 "parser.ml"
            )) * (
# 2 "parser.mly"
       (string)
# 412 "parser.ml"
            )) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s, _), _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv20)) : 'freshtv22)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv23 * _menhir_state * (
# 1 "parser.mly"
       (int)
# 423 "parser.ml"
        )) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv24)

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

and main : (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (
# 10 "parser.mly"
       ((int*string*int*int) list)
# 443 "parser.ml"
) =
  fun lexer lexbuf ->
    let _menhir_env =
      let (lexer : Lexing.lexbuf -> token) = lexer in
      let (lexbuf : Lexing.lexbuf) = lexbuf in
      ((let _tok = Obj.magic () in
      {
        _menhir_lexer = lexer;
        _menhir_lexbuf = lexbuf;
        _menhir_token = _tok;
        _menhir_error = false;
      }) : _menhir_env)
    in
    Obj.magic (let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv1) = ((), _menhir_env._menhir_lexbuf.Lexing.lex_curr_p) in
    ((let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | INT _v ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState0 _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState0) : 'freshtv2))

# 269 "<standard.mly>"
  

# 472 "parser.ml"
