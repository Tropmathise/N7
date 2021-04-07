/* Exemple d'illustration des primitives Unix : Un père et ses fils */
/* utilisation de SIGCHLD pour prendre connaissance de la fin des fils */

#include <stdio.h>    /* entrées sorties */
#include <unistd.h>   /* pimitives de base : fork, ...*/
#include <stdlib.h>   /* exit */
#include <sys/wait.h> /* wait */
#include <signal.h>   /* opérations sur les signaux */

#define NB_FILS 3     /* nombre de fils */

int nb_fils_termines; /* variable globale car modifiée par le traitant */

/* Traitant du signal SIGCHLD */
void handler_sigchld(int signal_num) {
    int wstatus, fils_termine;

    fils_termine = wait(&wstatus);
    nb_fils_termines++;
    if WIFEXITED(wstatus) {   /* fils terminé avec exit */
        printf("\nMon fils de pid %d a termine avec exit %d\n", 
                fils_termine, WEXITSTATUS(wstatus));
    }
    else if WIFSIGNALED(wstatus) {  /* fils tué par un signal */
        printf("\nMon fils de pid %d a ete tue par le signal %d\n", 
                fils_termine, WTERMSIG(wstatus));
    }
    return;
}

int main()
{
    int fils, retour;
    int duree_sommeil = 300;

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
            sleep(2 + duree_sommeil * (fils -1));
            exit(fils);  /* normalement exit(0), mais on veut illustrer WEXITSTATUS */
        }

        /* pere */
        else {
            printf("\nProcessus de pid %d a cree un fils numero %d, de pid %d \n", 
                    getpid(), fils, retour);
        }
    }

    /* faire ce qu'on jusqu'à la terminaison de tous les fils */
    do {
        /* faire ce qu'on veut */

    } while (nb_fils_termines < NB_FILS);
    printf("\nProcessus Principal termine\n");
    return EXIT_SUCCESS;
}
