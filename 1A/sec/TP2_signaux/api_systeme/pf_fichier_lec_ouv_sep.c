/* Exemple d'illustration des primitives Unix : Un père et ses fils */
/* Fichiers : lecture partagée avec ouvertures séparées */

#include <stdio.h>    /* entrées sorties */
#include <unistd.h>   /* pimitives de base : fork, ...*/
#include <stdlib.h>   /* exit */
#include <sys/wait.h> /* wait */
#include <string.h>   /* opérations sur les chaines */
#include <fcntl.h>    /* opérations sur les fichiers */

#define NB_FILS 3     /* nombre de fils */

int main()
{
    int fils, retour, desc_fic, fils_termine, wstatus;
    int duree_sommeil = 3;

    char fichier[] = "fic_centaines.txt";
    char buffer[8];     /* buffer de lecture */

    bzero(buffer, sizeof(buffer));

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
            /* ouverture du fichier en lecture */
            desc_fic = open(fichier, O_RDONLY);
            /* traiter systématiquement les retours d'erreur des appels */
            if (desc_fic < 0) {
                printf("Erreur ouverture %s\n", fichier);
                exit(1);
            }

            sleep(NB_FILS - fils);

            /* lire le fichier par blocs de 4 octets */
            while (read(desc_fic, buffer, 4)>0) {

                printf("     Processus fils numero %d a lu %s\n", 
                        fils, buffer);
                sleep(duree_sommeil);
                bzero(buffer, sizeof(buffer));
            }

            close(desc_fic);

            /* Important : terminer un processus par exit */
            exit(EXIT_SUCCESS);   /* Terminaison normale (0 = sans erreur) */
        }

        /* pere */
        else {
            printf("\nProcessus de pid %d a cree un fils numero %d, de pid %d \n", 
                    getpid(), fils, retour);
        }
    }
    /* attendre la fin des fils */
    for (fils = 1; fils <= NB_FILS; fils++) {
        /* attendre la fin d'un fils */
        fils_termine = wait(&wstatus);

        if WIFEXITED(wstatus) {   /* fils terminé avec exit */
            printf("\nMon fils de pid %d a termine avec exit %d\n", 
                    fils_termine, WEXITSTATUS(wstatus));
        }
        else if WIFSIGNALED(wstatus) {  /* fils tué par un signal */
            printf("\nMon fils de pid %d a ete tue par le signal %d\n", 
                    fils_termine, WTERMSIG(wstatus));
        }
    }

    printf("\nProcessus Principal termine\n");
    return EXIT_SUCCESS;
}
