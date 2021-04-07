/* Exemple d'illustration des primitives Unix : Un père et ses fils */
/* Traitement du signal SIGINT : SIG_IGN et SIG_DFL avec exec */

#include <stdio.h>    /* entrées sorties */
#include <unistd.h>   /* pimitives de base : fork, ...*/
#include <stdlib.h>   /* exit */
#include <signal.h>   /* traitement des signaux */

#define NB_FILS 3     /* nombre de fils */

/* Traitant du signal SIGINT */
void handler_sigint(int signal_num) {
    printf("\n     Processus de pid %d : J'ai reçu le signal %d\n", 
            getpid(),signal_num);
    return;
}

/* dormir pendant nb_secondes secondes  */
/* à utiliser à la palce de sleep(duree), car sleep s'arrête */
/* dès qu'un signal non ignoré est reçu */
void dormir(int nb_secondes)
{
    int duree = 0;
    while (duree < nb_secondes) {
        sleep(1);
        duree++;
    }
}

int main()
{
    int fils, retour;
    int duree_sommeil = 300;

    char ref_exec[]="./dormir"; /* exécutable  */
    char arg0_exec[]="je dors";	/* argument0 du exec : nom donnée au processus */
    char arg1_exec[]="300";	    /* argument0 du exec : durée de sommeil */

    /* associer un traitant au signal SIGINT */
    signal(SIGINT, handler_sigint);

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
            if (fils == 1) {
                signal(SIGINT, SIG_IGN);
            }
            else if (fils == 2) {
                signal(SIGINT, SIG_DFL);
            }
            printf("\n     Processus fils numero %d, de pid %d, de pere %d.\n", 
                    fils, getpid(), getppid());
            execl(ref_exec, arg0_exec, arg1_exec, NULL);
            /* on ne se retrouve ici que si exec échoue */
            printf("\n     Processus fils numero %d : ERREUR EXEC\n", fils);
            /* perror : affiche un message relatif à l'erreur du dernier appel systàme */
            perror("     exec ");
            exit(fils);   /* sortie avec le numéro di fils qui a échoué */ 
        }

        /* pere */
        else {
            printf("\nProcessus de pid %d a cree un fils numero %d, de pid %d \n", 
                    getpid(), fils, retour);
        }
    }
    dormir(duree_sommeil+2);
    return EXIT_SUCCESS;
}
