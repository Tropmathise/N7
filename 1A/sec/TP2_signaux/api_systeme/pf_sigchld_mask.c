/* Exemple d'illustration des primitives Unix : Un père et ses fils */
/* masquage et démasquage de SIGCHLD  */

#include <stdio.h>    /* entrées sorties */
#include <unistd.h>   /* pimitives de base : fork, ...*/
#include <stdlib.h>   /* exit */
#include <sys/wait.h> /* wait */
#include <signal.h>   /* opérations sur les signaux */

#define NB_FILS 3     /* nombre de fils */
#define DELAI 10

int nb_fils_termines; /* variable globale car modifiée par le traitant */

/* Traitant du signal SIGCHLD */
void handler_sigchld(int signal_num) {
    int fils_termine, wstatus;

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
        }
    }
    return;
}

int main()
{
    int fils, retour;
    int duree_sommeil = 2;

    sigset_t ens_signaux;

    sigemptyset(&ens_signaux);

    /* ajouter SIGCHLD à ens_signaux */
    sigaddset(&ens_signaux, SIGCHLD);

    nb_fils_termines = 0;
    /* associer traitant sigchld à SIGCHLD */
    signal(SIGCHLD, handler_sigchld);

    printf("\nJe suis le processus principal de pid %d\n", getpid());
    /* Vidange du tampon de sortie pour que le fils le récupère vide        */
    fflush(stdout);

    for (fils = 1; fils <= NB_FILS; fils++) {
        retour = fork();

        /* Bonne pratique : tester systématiquement le retour des appels système */
        if (retour < 0) {   /* échec du fork */
            printf("Erreur fork\n");
            /* Convention : s'arrêter avec une valeur > 0 en cas d'erreur */
            exit(1);
        }

        /* fils */
        if (retour == 0) {
            printf("\n     Processus fils numero %d, de pid %d, de pere %d.\n", 
                    fils, getpid(), getppid());
            sleep(duree_sommeil * fils);
			printf("\n     Processus fils numero %d : je m\'arrête.\n", fils);
            exit(fils);  /* normalement exit(0), mais on veut illustrer WEXITSTATUS */
        }

        /* pere */
        else {
            printf("\nProcessus de pid %d a cree un fils numero %d, de pid %d \n", 
                    getpid(), fils, retour);
        }
    }

    /* faire ce qu'on veut jusqu'à la terminaison de tous les fils */
    do {
        /* période durant laquelle on ne veut pas être embêté par SIGCHLD */
        printf("\nProcessus de pid %d : Je masque SIGCHLD durant %d secondes\n", getpid(), DELAI);
        /* masquer les signaux définis dans ens_signaux : SIGCHLD */
        sigprocmask(SIG_BLOCK, &ens_signaux, NULL);
        sleep(DELAI);

        /* période durant laquelle on peut traiter le signal SIGCHLD */
        printf("\nProcessus de pid %d : Je démasque SIGCHLD\n", getpid());
        /* démasquer les signaux définis dans ens_signaux : SIGCHLD */
        sigprocmask(SIG_UNBLOCK, &ens_signaux, NULL);
        sleep(2);

    } while (nb_fils_termines < NB_FILS);
    printf("\nProcessus Principal termine\n");
    return EXIT_SUCCESS;
}
