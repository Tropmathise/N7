.SUFFIXES: .f90 .o

FC = gfortran
#FC = ifort

OBJETS = mod_mat_tridiag.o appli.o

all : appli

appli : $(OBJETS)
	$(FC) $(OPTF) -o appli $(OBJETS)

appli.o : mod_mat_tridiag.o

.f90.o :
	$(FC) $(OPTF) -c $*.f90

clean:
	rm -f *.o *.mod appli
