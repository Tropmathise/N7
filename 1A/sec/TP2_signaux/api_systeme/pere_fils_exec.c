/* Exemple d'illustration des primitives Unix : Un père et ses fils */
/* execl */

#include <stdio.h>    /* entrées sorties */
#include <unistd.h>   /* pimitives de base : fork, ...*/
#include <stdlib.h>   /* exit */
#include <sys/wait.h> /* wait */

#define NB_FILS 3     /* nombre de fils */

int main()
{
    int fils, retour, wstatus, fils_termine;

    char ref_exec[]="./dormir"; /* exécutable  */
    char arg0_exec[]="dodo";	/* argument0 du exec : nom donnée au processus */
    char arg1_exec[]="10";	    /* argument0 du exec : durée de sommeil */

    printf("Je suis le processus principal de pid %d\n", getpid());
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

			/* mettre un executable inexistant pour le fils 2 */
            if (fils == 2) {
                ref_exec[3] = 'a';
            }

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
            fflush(stdout);
        }
    }
    sleep(3);   /* pour les besoins de l'outil de validation automatique */

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
