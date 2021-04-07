
OCAMLLEX = ocamllex
OCAMLYACC = menhir
OCAMLC = ocamlc
OCAMLLD = ocamlc


.SUFFIXES: .ml .mli .cmo .cmi .mll .mly

%.cmi : %.mli
	$(OCAMLC) -c $<

%.cmo : %.ml %.cmi
	$(OCAMLC) -c $<

%.cmo : %.ml
	$(OCAMLC) -c $<

%.cmo : %.cmi
	$(OCAMLC) -c $<

%.ml : %.mll
	$(OCAMLLEX) $<

%.mli %.ml : %.mly
	$(OCAMLYACC) $<

all : mainProcessus

lexerProcessus.ml : parserProcessus.cmi

mainProcessus : lexerProcessus.cmo parserProcessus.cmo mainProcessus.cmo
	$(OCAMLC) -o MainProcessus lexerProcessus.cmo parserProcessus.cmo mainProcessus.cmo

clean :
	-rm -f *.cmo *.cmi lexerProcessus.ml parserProcessus.ml MainProcessus
