# Définition des Variables (à compléter)
CC = GCC
CFLAGS = -Wall -o
LDFLAGS = #edition de lien
EXE = file

# Règles (à compléter avec des variables automatiques)
all: file.c test_file.c exemple_file.c
		c99 -Wextra -pedantic -c file.c
		gcc -Wall -o test_file test_file.c
		gcc -Wall -o exemple_file exemple_file.c

test_file: test_file.c
		gcc -Wall -o test_file test_file.c

exemple_file: exemple_file.c
		gcc -Wall -o exemple_file exemple_file.c

makedepend:
		makedepend *.c -Y

clean: 
		rm -f *.o

.PHONY: clean all makedepend

# DO NOT DELETE

exemple_file.o: file.h
file.o: file.h
test_file.o: file.h
