/* Exemple d'illustration des primitives Unix : Un père et ses fils */
/* Création de fils : fork et exit */

#include <stdio.h>    /* entrées sorties */
#include <unistd.h>   /* pimitives de base : fork, ...*/
#include <stdlib.h>   /* exit */
#include <string.h>   /* manipulation des chaines */

#define NB_FILS 3     /* nombre de fils */

int main(int argc, char *argv[])
{
    int fils, retour;
    int duree_sommeil = 3;
    char progname[]="pere_fils.c";

    if (argc > 1) {
        write(atoi(argv[1]), progname, strlen(progname));
    }

    printf("\nJe suis le processus principal de pid %d\n", getpid());

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
            printf("\n     Processus fils numero %d, de pid %d, de pere %d\n", 
                    fils, getpid(), getppid());
            sleep(duree_sommeil);
            /* Important : terminer un processus par exit */
            exit(EXIT_SUCCESS);   /* Terminaison normale (0 = sans erreur) */
        }

        /* pere */
        else {
            printf("\nProcessus de pid %d a cree un fils numero %d, de pid %d \n", 
                    getpid(), fils, retour);
        }
    }
    sleep(duree_sommeil + 1);
    return EXIT_SUCCESS;
}
