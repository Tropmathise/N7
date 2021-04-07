# compilateur
CC=gcc
# options de compilation
CFLAGS=-Wextra -Werror -pedantic -c -g
LDFLAGS=

all: minishell

minishell: color.o handlers.o readcmd.o list_process.o utils.o minishell.o
	$(CC) $(LDFLAGS) $^ -o minishell

depend:
	makedepend *.c -Y

clean:
	rm *.o minishell

.PHONY: clean all

