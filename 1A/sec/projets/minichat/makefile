CC = gcc
CFLAGS = -W -Wall -Wextra -Wno-unused-parameter -g

all: console serveur chatmmap

chatmmap : chatmmap.o
	$(CC) -o $@ $^ $(CFLAGS)

console : console.o
	$(CC) -o $@ $^ $(CFLAGS)

serveur : serveur.o
	$(CC) -o $@ $^ $(FLAGS)

%.o: %.c
	$(CC) -o $@ -c $< $(CFLAGS)

clean:
	-rm -rf *.o
	-rm -rf console
	-rm -rf serveur
	-rm -rf chatmmap
