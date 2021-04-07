/* Exemple d'illustration des primitives Unix : Un père et ses fils */
/* 1 fichier : plusieurs ouvertures, écritures concurrentes */

#include <stdio.h>    /* entrées sorties */
#include <unistd.h>   /* pimitives de base : fork, ...*/
#include <stdlib.h>   /* exit */
#include <sys/wait.h> /* wait */
#include <string.h>   /* opérations sur les chaines */
#include <fcntl.h>    /* opérations sur les fichiers */

#define NB_FILS 3     /* nombre de fils */

int main()
{
    int fils, retour, desc_fic, fils_termine, wstatus, ifor;
    int duree_sommeil = 3;

    char fichier[] = "fic_res_ouv_sep.txt";
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
            desc_fic = open(fichier, O_WRONLY | O_CREAT | O_TRUNC, 0640);
            /* traiter systématiquement les retours d'erreur des appels */
            if (desc_fic < 0) {
                printf("Erreur ouverture %s\n", fichier);
                exit(1);
            }

            /* decaler les écritures des differents fils : fils 3, fils 2, fils 1, ... */
            sleep(NB_FILS - fils);

            /* effectuer 4 ecritures dans le fichier */
            for (ifor = 1; ifor <= 4; ifor++) {
                bzero(buffer, sizeof(buffer));
                sprintf(buffer, "%d-%d\n", fils,ifor);
                write(desc_fic, buffer, strlen(buffer));
                printf("     Processus fils numero %d a ecrit %s\n", 
                        fils, buffer);
                sleep(duree_sommeil);
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
