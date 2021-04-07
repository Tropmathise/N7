/* Exemple d'illustration des primitives Unix : Un père et ses fils */
/* Redirection et fflush */

#include <stdio.h>    /* entrées sorties */
#include <unistd.h>   /* pimitives de base : fork, ...*/
#include <stdlib.h>   /* exit */

#define NB_FILS 3     /* nombre de fils */

int main()
{
    int fils, retour;
    int duree_sommeil = 2;

    printf("\nJe suis le processus principal de pid %d\n", getpid());

    /* Vidange du tampon de sortie pour que le fils le récupère vide        */
    /* D'après le standard ISO le comportement du printf présente 2 cas :   */
    /* - sortie interactive (terminal) : flot géré par ligne et \n provoque */
    /*   la vidange du tampon langage */
    /* - sortie dans un fichier : flot géré par bloc et \n est traité comme */
    /*   un caractère ordinaire. fflush(stdout) force la vidange du tampon. */

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
            sleep(duree_sommeil);
            /* Important : terminer un processus par exit */
            exit(EXIT_SUCCESS);   /* Terminaison normale (0 = sans erreur) */
        }

        /* pere */
        else {
            printf("\nProcessus de pid %d a cree un fils numero %d, de pid %d \n", 
                    getpid(), fils, retour);
            /* vidange du tampon de sortie pour que le fils le récupère vide */
            fflush(stdout);
        }
    }
    sleep(duree_sommeil);
    return EXIT_SUCCESS;
}
