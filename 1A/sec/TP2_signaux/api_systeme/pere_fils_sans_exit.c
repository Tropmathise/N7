/* Exemple d'illustration des primitives Unix : Un père et ses fils */
/* Absence du exit dans le fils, et conséquences */

#include <stdio.h>    /* entrées sorties */
#include <unistd.h>   /* pimitives de base : fork, ...*/
#include <stdlib.h>   /* exit */

#define NB_FILS 3     /* nombre de fils */

int main()
{
    int fils, retour;
    int duree_sommeil = 3;

    printf("\nJe suis le processus principal de pid %d\n", getpid());

    for (fils = 1; fils <= NB_FILS; fils++) {
        retour = fork();

        /* Bonne pratique : tester systématiquement le retour des appels système */
        if (retour < 0) { 
            printf("Erreur fork\n");
            /* Convention : s'arrêter avec une valeur > 0 en cas d'erreur */
            exit(1);
        }

        /* fils */
        if (retour == 0) {
            printf("\n     Processus fils numero %d, de pid %d, de pere %d.\n", 
                    fils, getpid(), getppid());
            /* Le fils ne s'arrete pas ici */
        }

        /* pere */
        else {
            printf("\nProcessus de pid %d a cree un fils numero %d, de pid %d \n", 
                    getpid(), fils, retour);
        }
    }
    sleep(duree_sommeil);
    return EXIT_SUCCESS;
}
