.SUFFIXES: .f90 .o .mod

#FC = gfortran
FC = ifort

OBJETS = mat_tridiag.o appli.o

all : appli

appli : $(OBJETS)
	$(FC) $(OPTF) -o appli $(OBJETS)

appli.o : mat_tridiag.o mat_tridiag.mod

.f90.o :
	$(FC) $(OPTF) -c $*.f90

.f90$(.mod):
	$(FC) -c $<

clean:
	rm -f *.o *.mod appli
