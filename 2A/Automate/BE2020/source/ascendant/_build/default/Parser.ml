
module MenhirBasics = struct
  
  exception Error
  
  type token = 
    | UL_TO
    | UL_STATE
    | UL_STARTS
    | UL_REGION
    | UL_PT
    | UL_ON
    | UL_MACHINE
    | UL_IDENT of (
# 17 "Parser.mly"
       (string)
# 18 "Parser.ml"
  )
    | UL_FROM
    | UL_FIN
    | UL_EVENT
    | UL_ENDS
    | UL_ACCOUV
    | UL_ACCFER
  
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
  | MenhirState39
  | MenhirState30
  | MenhirState27
  | MenhirState25
  | MenhirState21
  | MenhirState16
  | MenhirState13
  | MenhirState6
  | MenhirState3

# 1 "Parser.mly"
  

(* Partie recopiee dans le fichier CaML genere. *)
(* Ouverture de modules exploites dans les actions *)
(* Declarations de types, de constantes, de fonctions, d'exceptions exploites dans les actions *)


# 60 "Parser.ml"

let rec _menhir_goto_regions : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_regions -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState13 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv173) * _menhir_state * 'tv_regions) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | UL_ACCFER ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv169) * _menhir_state * 'tv_regions) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv167) * _menhir_state * 'tv_regions) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _, (_2 : 'tv_regions)) = _menhir_stack in
            let _3 = () in
            let _1 = () in
            let _v : 'tv_regionvoid = 
# 69 "Parser.mly"
                                          ( (print_endline "regionvoid : UL_ACCOUV regions UL_ACCFER"))
# 84 "Parser.ml"
             in
            _menhir_goto_regionvoid _menhir_env _menhir_stack _v) : 'freshtv168)) : 'freshtv170)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv171) * _menhir_state * 'tv_regions) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv172)) : 'freshtv174)
    | MenhirState16 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv177 * _menhir_state * 'tv_region) * _menhir_state * 'tv_regions) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv175 * _menhir_state * 'tv_region) * _menhir_state * 'tv_regions) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s, (_1 : 'tv_region)), _, (_2 : 'tv_regions)) = _menhir_stack in
        let _v : 'tv_regions = 
# 72 "Parser.mly"
                            ((print_endline "regions : region regions"))
# 103 "Parser.ml"
         in
        _menhir_goto_regions _menhir_env _menhir_stack _menhir_s _v) : 'freshtv176)) : 'freshtv178)
    | _ ->
        _menhir_fail ()

and _menhir_goto_etats : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_etats -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState6 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv161 * _menhir_state) * (
# 17 "Parser.mly"
       (string)
# 118 "Parser.ml"
        ))) * _menhir_state * 'tv_etats) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | UL_ACCFER ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv157 * _menhir_state) * (
# 17 "Parser.mly"
       (string)
# 128 "Parser.ml"
            ))) * _menhir_state * 'tv_etats) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv155 * _menhir_state) * (
# 17 "Parser.mly"
       (string)
# 135 "Parser.ml"
            ))) * _menhir_state * 'tv_etats) = Obj.magic _menhir_stack in
            ((let (((_menhir_stack, _menhir_s), (_2 : (
# 17 "Parser.mly"
       (string)
# 140 "Parser.ml"
            ))), _, (_4 : 'tv_etats)) = _menhir_stack in
            let _5 = () in
            let _3 = () in
            let _1 = () in
            let _v : 'tv_region = 
# 55 "Parser.mly"
                                                      ( (print_endline "region : UL_REGION UL_IDENT UL_ACCOUV etats UL_ACCFER ") )
# 148 "Parser.ml"
             in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv153) = _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let (_v : 'tv_region) = _v in
            ((let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
            match _menhir_s with
            | MenhirState16 | MenhirState13 ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv147 * _menhir_state * 'tv_region) = Obj.magic _menhir_stack in
                ((assert (not _menhir_env._menhir_error);
                let _tok = _menhir_env._menhir_token in
                match _tok with
                | UL_REGION ->
                    _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState16
                | UL_ACCFER ->
                    let (_menhir_env : _menhir_env) = _menhir_env in
                    let (_menhir_stack : 'freshtv145 * _menhir_state * 'tv_region) = Obj.magic _menhir_stack in
                    ((let (_menhir_stack, _menhir_s, (_1 : 'tv_region)) = _menhir_stack in
                    let _v : 'tv_regions = 
# 71 "Parser.mly"
                 ((print_endline "regions : region"))
# 171 "Parser.ml"
                     in
                    _menhir_goto_regions _menhir_env _menhir_stack _menhir_s _v) : 'freshtv146)
                | _ ->
                    assert (not _menhir_env._menhir_error);
                    _menhir_env._menhir_error <- true;
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState16) : 'freshtv148)
            | MenhirState39 | MenhirState3 ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv151 * _menhir_state * 'tv_region) = Obj.magic _menhir_stack in
                ((let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv149 * _menhir_state * 'tv_region) = Obj.magic _menhir_stack in
                ((let (_menhir_stack, _menhir_s, (_1 : 'tv_region)) = _menhir_stack in
                let _v : 'tv_composant = 
# 48 "Parser.mly"
                     ((print_endline "composant : region");)
# 187 "Parser.ml"
                 in
                _menhir_goto_composant _menhir_env _menhir_stack _menhir_s _v) : 'freshtv150)) : 'freshtv152)
            | _ ->
                _menhir_fail ()) : 'freshtv154)) : 'freshtv156)) : 'freshtv158)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv159 * _menhir_state) * (
# 17 "Parser.mly"
       (string)
# 199 "Parser.ml"
            ))) * _menhir_state * 'tv_etats) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv160)) : 'freshtv162)
    | MenhirState21 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv165 * _menhir_state * 'tv_etat) * _menhir_state * 'tv_etats) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv163 * _menhir_state * 'tv_etat) * _menhir_state * 'tv_etats) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s, (_1 : 'tv_etat)), _, (_2 : 'tv_etats)) = _menhir_stack in
        let _v : 'tv_etats = 
# 58 "Parser.mly"
                     ((print_endline "etats : etat etats");)
# 212 "Parser.ml"
         in
        _menhir_goto_etats _menhir_env _menhir_stack _menhir_s _v) : 'freshtv164)) : 'freshtv166)
    | _ ->
        _menhir_fail ()

and _menhir_goto_regionvoid : _menhir_env -> 'ttv_tail -> 'tv_regionvoid -> 'ttv_return =
  fun _menhir_env _menhir_stack _v ->
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : ((('freshtv143 * _menhir_state) * (
# 17 "Parser.mly"
       (string)
# 224 "Parser.ml"
    )) * 'tv_startsvoid) * 'tv_endsvoid) = Obj.magic _menhir_stack in
    let (_v : 'tv_regionvoid) = _v in
    ((let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : ((('freshtv141 * _menhir_state) * (
# 17 "Parser.mly"
       (string)
# 231 "Parser.ml"
    )) * 'tv_startsvoid) * 'tv_endsvoid) = Obj.magic _menhir_stack in
    let ((_5 : 'tv_regionvoid) : 'tv_regionvoid) = _v in
    ((let ((((_menhir_stack, _menhir_s), (_2 : (
# 17 "Parser.mly"
       (string)
# 237 "Parser.ml"
    ))), (_3 : 'tv_startsvoid)), (_4 : 'tv_endsvoid)) = _menhir_stack in
    let _1 = () in
    let _v : 'tv_etat = 
# 60 "Parser.mly"
                                                        ((print_endline "etat : UL_STATE UL_IDENT startsvoid endsvoid regionvoid");)
# 243 "Parser.ml"
     in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv139) = _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let (_v : 'tv_etat) = _v in
    ((let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv137 * _menhir_state * 'tv_etat) = Obj.magic _menhir_stack in
    ((assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | UL_STATE ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState21
    | UL_ACCFER ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv135 * _menhir_state * 'tv_etat) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, (_1 : 'tv_etat)) = _menhir_stack in
        let _v : 'tv_etats = 
# 57 "Parser.mly"
             ((print_endline "etats : etat");)
# 264 "Parser.ml"
         in
        _menhir_goto_etats _menhir_env _menhir_stack _menhir_s _v) : 'freshtv136)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState21) : 'freshtv138)) : 'freshtv140)) : 'freshtv142)) : 'freshtv144)

and _menhir_goto_endsvoid : _menhir_env -> 'ttv_tail -> 'tv_endsvoid -> 'ttv_return =
  fun _menhir_env _menhir_stack _v ->
    let _menhir_stack = (_menhir_stack, _v) in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : ((('freshtv133 * _menhir_state) * (
# 17 "Parser.mly"
       (string)
# 279 "Parser.ml"
    )) * 'tv_startsvoid) * 'tv_endsvoid) = Obj.magic _menhir_stack in
    ((assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | UL_ACCOUV ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv127) = Obj.magic _menhir_stack in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | UL_REGION ->
            _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState13
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState13) : 'freshtv128)
    | UL_ACCFER | UL_STATE ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv129) = Obj.magic _menhir_stack in
        ((let _v : 'tv_regionvoid = 
# 68 "Parser.mly"
                                    ( (print_endline "regionvoid : lambda mot vide"))
# 302 "Parser.ml"
         in
        _menhir_goto_regionvoid _menhir_env _menhir_stack _v) : 'freshtv130)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv131 * _menhir_state) * (
# 17 "Parser.mly"
       (string)
# 312 "Parser.ml"
        )) * 'tv_startsvoid) * 'tv_endsvoid) = Obj.magic _menhir_stack in
        ((let ((((_menhir_stack, _menhir_s), _), _), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv132)) : 'freshtv134)

and _menhir_fail : unit -> 'a =
  fun () ->
    Printf.fprintf stderr "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

and _menhir_goto_startsvoid : _menhir_env -> 'ttv_tail -> 'tv_startsvoid -> 'ttv_return =
  fun _menhir_env _menhir_stack _v ->
    let _menhir_stack = (_menhir_stack, _v) in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : (('freshtv125 * _menhir_state) * (
# 17 "Parser.mly"
       (string)
# 329 "Parser.ml"
    )) * 'tv_startsvoid) = Obj.magic _menhir_stack in
    ((assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | UL_ENDS ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv119) = Obj.magic _menhir_stack in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv117) = Obj.magic _menhir_stack in
        ((let _1 = () in
        let _v : 'tv_endsvoid = 
# 66 "Parser.mly"
                      ( (print_endline "endsvoid : UL_ENDS"))
# 344 "Parser.ml"
         in
        _menhir_goto_endsvoid _menhir_env _menhir_stack _v) : 'freshtv118)) : 'freshtv120)
    | UL_ACCFER | UL_ACCOUV | UL_STATE ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv121) = Obj.magic _menhir_stack in
        ((let _v : 'tv_endsvoid = 
# 65 "Parser.mly"
                                  ( (print_endline "startsvoid : lambda mot vide"))
# 353 "Parser.ml"
         in
        _menhir_goto_endsvoid _menhir_env _menhir_stack _v) : 'freshtv122)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv123 * _menhir_state) * (
# 17 "Parser.mly"
       (string)
# 363 "Parser.ml"
        )) * 'tv_startsvoid) = Obj.magic _menhir_stack in
        ((let (((_menhir_stack, _menhir_s), _), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv124)) : 'freshtv126)

and _menhir_goto_nomqualifie : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_nomqualifie -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState27 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv91 * _menhir_state * (
# 17 "Parser.mly"
       (string)
# 377 "Parser.ml"
        ))) * _menhir_state * 'tv_nomqualifie) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv89 * _menhir_state * (
# 17 "Parser.mly"
       (string)
# 383 "Parser.ml"
        ))) * _menhir_state * 'tv_nomqualifie) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s, (_1 : (
# 17 "Parser.mly"
       (string)
# 388 "Parser.ml"
        ))), _, (_3 : 'tv_nomqualifie)) = _menhir_stack in
        let _2 = () in
        let _v : 'tv_nomqualifie = 
# 53 "Parser.mly"
                                           ((print_endline "nomqualifie : ident UL_PT nomqualifie");)
# 394 "Parser.ml"
         in
        _menhir_goto_nomqualifie _menhir_env _menhir_stack _menhir_s _v) : 'freshtv90)) : 'freshtv92)
    | MenhirState25 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv97 * _menhir_state) * _menhir_state * 'tv_nomqualifie) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | UL_TO ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv93 * _menhir_state) * _menhir_state * 'tv_nomqualifie) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | UL_IDENT _v ->
                _menhir_run26 _menhir_env (Obj.magic _menhir_stack) MenhirState30 _v
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState30) : 'freshtv94)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv95 * _menhir_state) * _menhir_state * 'tv_nomqualifie) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv96)) : 'freshtv98)
    | MenhirState30 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv115 * _menhir_state) * _menhir_state * 'tv_nomqualifie)) * _menhir_state * 'tv_nomqualifie) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | UL_ON ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv111 * _menhir_state) * _menhir_state * 'tv_nomqualifie)) * _menhir_state * 'tv_nomqualifie) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | UL_IDENT _v ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (((('freshtv107 * _menhir_state) * _menhir_state * 'tv_nomqualifie)) * _menhir_state * 'tv_nomqualifie)) = Obj.magic _menhir_stack in
                let (_v : (
# 17 "Parser.mly"
       (string)
# 440 "Parser.ml"
                )) = _v in
                ((let _menhir_env = _menhir_discard _menhir_env in
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (((('freshtv105 * _menhir_state) * _menhir_state * 'tv_nomqualifie)) * _menhir_state * 'tv_nomqualifie)) = Obj.magic _menhir_stack in
                let ((_6 : (
# 17 "Parser.mly"
       (string)
# 448 "Parser.ml"
                )) : (
# 17 "Parser.mly"
       (string)
# 452 "Parser.ml"
                )) = _v in
                ((let (((_menhir_stack, _menhir_s), _, (_2 : 'tv_nomqualifie)), _, (_4 : 'tv_nomqualifie)) = _menhir_stack in
                let _5 = () in
                let _3 = () in
                let _1 = () in
                let _v : 'tv_transition = 
# 50 "Parser.mly"
                                                                  ( (print_endline "transition : From NQ to NQ on ident ") )
# 461 "Parser.ml"
                 in
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv103) = _menhir_stack in
                let (_menhir_s : _menhir_state) = _menhir_s in
                let (_v : 'tv_transition) = _v in
                ((let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv101) = Obj.magic _menhir_stack in
                let (_menhir_s : _menhir_state) = _menhir_s in
                let (_v : 'tv_transition) = _v in
                ((let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv99) = Obj.magic _menhir_stack in
                let (_menhir_s : _menhir_state) = _menhir_s in
                let ((_1 : 'tv_transition) : 'tv_transition) = _v in
                ((let _v : 'tv_composant = 
# 47 "Parser.mly"
                         ((print_endline "composant : transition");)
# 478 "Parser.ml"
                 in
                _menhir_goto_composant _menhir_env _menhir_stack _menhir_s _v) : 'freshtv100)) : 'freshtv102)) : 'freshtv104)) : 'freshtv106)) : 'freshtv108)
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (((('freshtv109 * _menhir_state) * _menhir_state * 'tv_nomqualifie)) * _menhir_state * 'tv_nomqualifie)) = Obj.magic _menhir_stack in
                ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv110)) : 'freshtv112)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv113 * _menhir_state) * _menhir_state * 'tv_nomqualifie)) * _menhir_state * 'tv_nomqualifie) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv114)) : 'freshtv116)
    | _ ->
        _menhir_fail ()

and _menhir_goto_listecomposants : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_listecomposants -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState3 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv83) * (
# 17 "Parser.mly"
       (string)
# 507 "Parser.ml"
        ))) * _menhir_state * 'tv_listecomposants) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | UL_ACCFER ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv79) * (
# 17 "Parser.mly"
       (string)
# 517 "Parser.ml"
            ))) * _menhir_state * 'tv_listecomposants) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | UL_FIN ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (((('freshtv75) * (
# 17 "Parser.mly"
       (string)
# 527 "Parser.ml"
                ))) * _menhir_state * 'tv_listecomposants)) = Obj.magic _menhir_stack in
                ((let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (((('freshtv73) * (
# 17 "Parser.mly"
       (string)
# 533 "Parser.ml"
                ))) * _menhir_state * 'tv_listecomposants)) = Obj.magic _menhir_stack in
                ((let ((_menhir_stack, (_2 : (
# 17 "Parser.mly"
       (string)
# 538 "Parser.ml"
                ))), _, (_4 : 'tv_listecomposants)) = _menhir_stack in
                let _6 = () in
                let _5 = () in
                let _3 = () in
                let _1 = () in
                let _v : (
# 24 "Parser.mly"
      (unit)
# 547 "Parser.ml"
                ) = 
# 41 "Parser.mly"
                                                                          ( (print_endline "machine : MACHINE IDENT { ... } FIN ") )
# 551 "Parser.ml"
                 in
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv71) = _menhir_stack in
                let (_v : (
# 24 "Parser.mly"
      (unit)
# 558 "Parser.ml"
                )) = _v in
                ((let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv69) = Obj.magic _menhir_stack in
                let (_v : (
# 24 "Parser.mly"
      (unit)
# 565 "Parser.ml"
                )) = _v in
                ((let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv67) = Obj.magic _menhir_stack in
                let ((_1 : (
# 24 "Parser.mly"
      (unit)
# 572 "Parser.ml"
                )) : (
# 24 "Parser.mly"
      (unit)
# 576 "Parser.ml"
                )) = _v in
                (Obj.magic _1 : 'freshtv68)) : 'freshtv70)) : 'freshtv72)) : 'freshtv74)) : 'freshtv76)
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (((('freshtv77) * (
# 17 "Parser.mly"
       (string)
# 586 "Parser.ml"
                ))) * _menhir_state * 'tv_listecomposants)) = Obj.magic _menhir_stack in
                ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv78)) : 'freshtv80)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv81) * (
# 17 "Parser.mly"
       (string)
# 597 "Parser.ml"
            ))) * _menhir_state * 'tv_listecomposants) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv82)) : 'freshtv84)
    | MenhirState39 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv87 * _menhir_state * 'tv_composant) * _menhir_state * 'tv_listecomposants) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv85 * _menhir_state * 'tv_composant) * _menhir_state * 'tv_listecomposants) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s, (_1 : 'tv_composant)), _, (_2 : 'tv_listecomposants)) = _menhir_stack in
        let _v : 'tv_listecomposants = 
# 44 "Parser.mly"
                                     ((print_endline "LC : composant LC");)
# 610 "Parser.ml"
         in
        _menhir_goto_listecomposants _menhir_env _menhir_stack _menhir_s _v) : 'freshtv86)) : 'freshtv88)
    | _ ->
        _menhir_fail ()

and _menhir_run7 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | UL_IDENT _v ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv63 * _menhir_state) = Obj.magic _menhir_stack in
        let (_v : (
# 17 "Parser.mly"
       (string)
# 628 "Parser.ml"
        )) = _v in
        ((let _menhir_stack = (_menhir_stack, _v) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | UL_STARTS ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv57) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv55) = Obj.magic _menhir_stack in
            ((let _1 = () in
            let _v : 'tv_startsvoid = 
# 63 "Parser.mly"
                        (( print_endline "startsvoid : UL_STARTS"))
# 644 "Parser.ml"
             in
            _menhir_goto_startsvoid _menhir_env _menhir_stack _v) : 'freshtv56)) : 'freshtv58)
        | UL_ACCFER | UL_ACCOUV | UL_ENDS | UL_STATE ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv59) = Obj.magic _menhir_stack in
            ((let _v : 'tv_startsvoid = 
# 62 "Parser.mly"
                                    ( (print_endline "startsvoid : lambda mot vide"))
# 653 "Parser.ml"
             in
            _menhir_goto_startsvoid _menhir_env _menhir_stack _v) : 'freshtv60)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv61 * _menhir_state) * (
# 17 "Parser.mly"
       (string)
# 663 "Parser.ml"
            )) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv62)) : 'freshtv64)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv65 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv66)

and _menhir_goto_composant : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_composant -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv53 * _menhir_state * 'tv_composant) = Obj.magic _menhir_stack in
    ((assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | UL_FROM ->
        _menhir_run25 _menhir_env (Obj.magic _menhir_stack) MenhirState39
    | UL_IDENT _v ->
        _menhir_run23 _menhir_env (Obj.magic _menhir_stack) MenhirState39 _v
    | UL_REGION ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState39
    | UL_ACCFER ->
        _menhir_reduce9 _menhir_env (Obj.magic _menhir_stack) MenhirState39
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState39) : 'freshtv54)

and _menhir_run26 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 17 "Parser.mly"
       (string)
# 699 "Parser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | UL_PT ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv47 * _menhir_state * (
# 17 "Parser.mly"
       (string)
# 711 "Parser.ml"
        )) = Obj.magic _menhir_stack in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | UL_IDENT _v ->
            _menhir_run26 _menhir_env (Obj.magic _menhir_stack) MenhirState27 _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState27) : 'freshtv48)
    | UL_ON | UL_TO ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv49 * _menhir_state * (
# 17 "Parser.mly"
       (string)
# 727 "Parser.ml"
        )) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, (_1 : (
# 17 "Parser.mly"
       (string)
# 732 "Parser.ml"
        ))) = _menhir_stack in
        let _v : 'tv_nomqualifie = 
# 52 "Parser.mly"
                       ((print_endline "nomqualifie : ident");)
# 737 "Parser.ml"
         in
        _menhir_goto_nomqualifie _menhir_env _menhir_stack _menhir_s _v) : 'freshtv50)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv51 * _menhir_state * (
# 17 "Parser.mly"
       (string)
# 747 "Parser.ml"
        )) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv52)

and _menhir_errorcase : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    match _menhir_s with
    | MenhirState39 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv29 * _menhir_state * 'tv_composant) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv30)
    | MenhirState30 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv31 * _menhir_state) * _menhir_state * 'tv_nomqualifie)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv32)
    | MenhirState27 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv33 * _menhir_state * (
# 17 "Parser.mly"
       (string)
# 770 "Parser.ml"
        ))) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv34)
    | MenhirState25 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv35 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv36)
    | MenhirState21 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv37 * _menhir_state * 'tv_etat) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv38)
    | MenhirState16 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv39 * _menhir_state * 'tv_region) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv40)
    | MenhirState13 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv41) = Obj.magic _menhir_stack in
        (raise _eRR : 'freshtv42)
    | MenhirState6 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv43 * _menhir_state) * (
# 17 "Parser.mly"
       (string)
# 798 "Parser.ml"
        ))) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv44)
    | MenhirState3 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv45) * (
# 17 "Parser.mly"
       (string)
# 807 "Parser.ml"
        ))) = Obj.magic _menhir_stack in
        (raise _eRR : 'freshtv46)

and _menhir_reduce9 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _v : 'tv_listecomposants = 
# 43 "Parser.mly"
                                         ((print_endline "LC : lambda mot vide");)
# 816 "Parser.ml"
     in
    _menhir_goto_listecomposants _menhir_env _menhir_stack _menhir_s _v

and _menhir_run4 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | UL_IDENT _v ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv25 * _menhir_state) = Obj.magic _menhir_stack in
        let (_v : (
# 17 "Parser.mly"
       (string)
# 832 "Parser.ml"
        )) = _v in
        ((let _menhir_stack = (_menhir_stack, _v) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | UL_ACCOUV ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv21 * _menhir_state) * (
# 17 "Parser.mly"
       (string)
# 843 "Parser.ml"
            )) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | UL_STATE ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState6
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState6) : 'freshtv22)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv23 * _menhir_state) * (
# 17 "Parser.mly"
       (string)
# 861 "Parser.ml"
            )) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv24)) : 'freshtv26)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv27 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv28)

and _menhir_run23 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 17 "Parser.mly"
       (string)
# 876 "Parser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | UL_EVENT ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv17 * _menhir_state * (
# 17 "Parser.mly"
       (string)
# 888 "Parser.ml"
        )) = Obj.magic _menhir_stack in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv15 * _menhir_state * (
# 17 "Parser.mly"
       (string)
# 895 "Parser.ml"
        )) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, (_1 : (
# 17 "Parser.mly"
       (string)
# 900 "Parser.ml"
        ))) = _menhir_stack in
        let _2 = () in
        let _v : 'tv_composant = 
# 46 "Parser.mly"
                              ((print_endline "composant : UL_IDENT UL_EVENT");)
# 906 "Parser.ml"
         in
        _menhir_goto_composant _menhir_env _menhir_stack _menhir_s _v) : 'freshtv16)) : 'freshtv18)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv19 * _menhir_state * (
# 17 "Parser.mly"
       (string)
# 916 "Parser.ml"
        )) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv20)

and _menhir_run25 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | UL_IDENT _v ->
        _menhir_run26 _menhir_env (Obj.magic _menhir_stack) MenhirState25 _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState25

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

and machine : (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (
# 24 "Parser.mly"
      (unit)
# 949 "Parser.ml"
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
    let (_menhir_stack : 'freshtv13) = ((), _menhir_env._menhir_lexbuf.Lexing.lex_curr_p) in
    ((let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | UL_MACHINE ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv9) = Obj.magic _menhir_stack in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | UL_IDENT _v ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv5) = Obj.magic _menhir_stack in
            let (_v : (
# 17 "Parser.mly"
       (string)
# 980 "Parser.ml"
            )) = _v in
            ((let _menhir_stack = (_menhir_stack, _v) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | UL_ACCOUV ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : ('freshtv1) * (
# 17 "Parser.mly"
       (string)
# 991 "Parser.ml"
                )) = Obj.magic _menhir_stack in
                ((let _menhir_env = _menhir_discard _menhir_env in
                let _tok = _menhir_env._menhir_token in
                match _tok with
                | UL_FROM ->
                    _menhir_run25 _menhir_env (Obj.magic _menhir_stack) MenhirState3
                | UL_IDENT _v ->
                    _menhir_run23 _menhir_env (Obj.magic _menhir_stack) MenhirState3 _v
                | UL_REGION ->
                    _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState3
                | UL_ACCFER ->
                    _menhir_reduce9 _menhir_env (Obj.magic _menhir_stack) MenhirState3
                | _ ->
                    assert (not _menhir_env._menhir_error);
                    _menhir_env._menhir_error <- true;
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState3) : 'freshtv2)
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : ('freshtv3) * (
# 17 "Parser.mly"
       (string)
# 1015 "Parser.ml"
                )) = Obj.magic _menhir_stack in
                (raise _eRR : 'freshtv4)) : 'freshtv6)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv7) = Obj.magic _menhir_stack in
            (raise _eRR : 'freshtv8)) : 'freshtv10)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv11) = Obj.magic _menhir_stack in
        (raise _eRR : 'freshtv12)) : 'freshtv14))

# 74 "Parser.mly"
  

# 1034 "Parser.ml"

# 269 "<standard.mly>"
  

# 1039 "Parser.ml"
