/* Exemple d'illustration des primitives Unix : Un père et ses fils */
/* SIGCHLD et waitpid pour prendre connaissance de la fin des fils  */

#include <stdio.h>    /* entrées sorties */
#include <unistd.h>   /* pimitives de base : fork, ...*/
#include <stdlib.h>   /* exit */
#include <sys/wait.h> /* wait */
#include <signal.h>   /* opérations sur les signaux */
#include <string.h> 

#define NB_FILS 4     /* nombre de fils */

int nb_fils_termines; /* variable globale car modifiée par le traitant */

/* Traitant du signal SIGCHLD */
void handler_chld(int signal_num) {
	int fils_termine, wstatus;
	printf("\nJ'ai reçu le signal %d\n",  signal_num);
	if (signal_num == SIGCHLD) {
		while ((fils_termine = (int) waitpid(-1, &wstatus, WNOHANG | WUNTRACED | WCONTINUED)) > 0) {
			if WIFEXITED(wstatus) {
				printf("\nMon fils de pid %d s'est arrete avec exit %d\n",  fils_termine, WEXITSTATUS(wstatus));
				nb_fils_termines++;
			}
			else if WIFSIGNALED(wstatus) {
				printf("\nMon fils de pid %d a recu le signal %d\n",  fils_termine, WTERMSIG(wstatus));
				nb_fils_termines++;
			}
			else if (WIFCONTINUED(wstatus)) {
				printf("\nMon fils de pid %d a ete relance \n",  fils_termine);
			}
			else if (WIFSTOPPED(wstatus)) {
				printf("\nMon fils de pid %d a ete suspendu \n", fils_termine);
			}
			sleep(1);
		}
	}
	
}

/* Programme principal : Un pere qui cree 3 fils */

int main()
{
	int fils, pid;
	int duree_sommeil = 2;
	
	signal(SIGCHLD, handler_chld);

	printf("Je suis le processus principal %d, de pere %d\n", getpid(), getppid());
	nb_fils_termines = 0;
		
	for (fils=1; fils<=NB_FILS; fils++) {
		pid = fork();
		if (pid<0) { // erreur fork
				printf("Erreur fork\n");
				exit(1);
		}
		else if (pid==0) { //fils
				printf("\n     Processus fils num %d, de pid %d, de pere %d.\n", fils, getpid(), getppid());
				if (fils == 4) {
					duree_sommeil = 300;
				}
				sleep(duree_sommeil);
				printf("\n     Processus fils num %d termine\n", fils);
				exit(fils);  /* normalement 0, mais on veut illustrer WEXITSTATUS */
		}
		else {//pere
				printf("\nProcessus pere de pid %d a cree un fils numero %d, de pid %d \n", getpid(), fils, pid);
		}
	}
	
	/* faire ce qu'on jusqu'à la terminaison de tous les fils */
    do {
        /* faire ce qu'on veut */

    } while (nb_fils_termines < NB_FILS);
	printf("\nProcessus Principal termine\n");
	return EXIT_SUCCESS;
}
