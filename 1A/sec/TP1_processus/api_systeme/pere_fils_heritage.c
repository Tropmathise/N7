/* Exemple d'illustration des primitives Unix : Un père et ses fils */
/* Héritage et dupplication des données */

#include <stdio.h>    /* entrées sorties */
#include <unistd.h>   /* pimitives de base : fork, ...*/
#include <stdlib.h>   /* exit */

#define NB_FILS 4     /* nombre de fils */

int main()
{
    int fils, retour;
    int cagnotte, patrimoine_fils;
    int duree_sommeil = 4;
    cagnotte = 10000 * NB_FILS;
    patrimoine_fils = cagnotte / NB_FILS;

    printf("\nJe suis le processus principal de pid %d\n", getpid());
    printf("Je dispose de %d Euros, que je partage entre mes futurs fils\n", cagnotte);

    for (fils = 1; fils <= NB_FILS; fils++) {
        retour = fork();

        /* Bonne pratique : tester systématiquement le retour des appels système */
        if (retour < 0) {   /* échec du fork */
            printf("Erreur fork\n");
            exit(1);
        }

        /* fils */
        if (retour == 0) {
            printf("\n    Processus fils numero %d : mon pere m'a offert %d Euros\n", 
                    fils, patrimoine_fils);
            patrimoine_fils = patrimoine_fils * (fils + 1);   
            sleep(duree_sommeil);
            printf("\n    Processus fils numero %d - j'ai augmente mon patrimoine a %d Euros\n", 
                    fils, patrimoine_fils);
            exit(EXIT_SUCCESS);   /* Te:rminaison normale (0 = sans erreur) */
        }

        /* pere */
        else {
            printf("\nProcessus de pid %d a cree un fils numero %d, de pid %d \n", 
                    getpid(), fils, retour);
        }
    }
    sleep(duree_sommeil+1);

    printf("\nProcessus Principal - le patrimoine total de mes fils est de %d\n", patrimoine_fils*NB_FILS);
    return EXIT_SUCCESS;
}
