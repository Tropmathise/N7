CC=gcc
CFLAGS=-Wextra -Werror -pedantic -c -g
LDFLAGS=

all: shell shelldynamic

shell: readcmd.o minishell.o
	$(CC) $(LDFLAGS) $^ -o shell

shelldynamic: readcmd.o minishell_dynamique.o
	$(CC) $(LDFLAGS) $^ -o shelldynamic

depend:
	makedepend *.c -Y

clean:
	rm *.o shell shelldynamic

.PHONY: clean all
