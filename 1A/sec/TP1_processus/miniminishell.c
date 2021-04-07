#include <stdio.h> /* printf */
#include <unistd.h> /* fork */
#include <stdlib.h> /* EXIT_SUCCESS */
#include <sys/wait.h> /* wait */

int main() {
    char buf[30]; /* contient la commande saisie au clavier*/
    pid_t pidFils, idFils;
    int codeTerm, comm;
    char * args[] = {"miniminishell", NULL};

    while (1) {
        printf("miniminishell@user:~$ ");
        comm = scanf("%s", buf);  /* lit et range dans buf la chaine entréee au clavier*/
        if (comm < 0) {
	    exit(comm);
	}
	pidFils=fork();
        if (pidFils==-1) {
            printf("Erreur fork\n");
            exit(1);
        } else if (pidFils==0) { //fils
	    args[0]=buf;
            execvp(buf, args);
            exit(2);
        } else {  //pere
            idFils=wait(&codeTerm);
            if (idFils==-1) {
                printf("error");
                exit(2);
            } else {
                if (WIFEXITED(codeTerm)) {
                    printf("\nLa commande %s est fini avec le code d'erreur %d\n", buf, WEXITSTATUS(codeTerm));
                } else if (WIFSIGNALED(codeTerm)) {
                    printf("\nLa commande %s a été tué par %d\n", buf, WTERMSIG(codeTerm));
                }
            }
        }
    }
    exit(EXIT_SUCCESS); 
}