/* Exemple d'illustration des primitives Unix : Un père et ses fils */
/* Calcul distribué du maximum d'un tableau : communication par fichier */

#include <stdio.h>    /* entrées sorties */
#include <unistd.h>   /* pimitives de base : fork, ...*/
#include <stdlib.h>   /* exit */
#include <sys/wait.h> /* wait */
#include <string.h>   /* opérations sur les chaines */
#include <fcntl.h>    /* opérations sur les fichiers */

#define NB_FILS 3     /* nombre de fils */
#define NB_FLEM_FILS 100000
#define NB_ELEM NB_FILS*NB_FLEM_FILS

/* calcul du max d'un sous-tableau */
int cal_max_tab(int tab[], int i1, int i2) {
    int i, max;

    max = tab[i1];

    for (i = i1 + 1; i < i2; i++) {
        if (tab[i]>max) {
            max = tab[i];
        }
    }
    return max;
}

int main()
{
    int fils, retour, desc_fic, fils_termine, wstatus, max, max_lu;

    int tab[NB_ELEM];

    char fichier[] = "fic_3f_maxtab";

    /* initialiser le tableau */
    for (int i=0; i < NB_ELEM; i++) {
        tab[i] = i+1;
    }

    /* ouvrir le fichier en écriture */
    desc_fic = open(fichier, O_WRONLY | O_CREAT | O_TRUNC, 0640);
    /* traiter systématiquement les retours d'erreur des appels */
    if (desc_fic < 0) {
        printf("Erreur ouverture %s\n", fichier);
        exit(1);
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
            /* calculer le max du sous-tableau */
            max = cal_max_tab(tab, (fils-1)*NB_FLEM_FILS, fils*NB_FLEM_FILS);
            /* enregistrer le max en binaire */
            write(desc_fic, &max, sizeof(int));
            /* Important : terminer un processus par exit */
            exit(EXIT_SUCCESS);   /* Terminaison normale (0 = sans erreur) */
        }

        /* pere */
        else {
            printf("\nProcessus de pid %d a cree un fils numero %d, de pid %d \n", 
                    getpid(), fils, retour);
        }
    }

    /* fermer le fichier ouvert en ecriture */
    close(desc_fic);

    /* ouvrir le fichier en lecture */
    desc_fic = open(fichier, O_RDONLY);
    /* traiter systématiquement les retours d'erreur des appels */
    if (desc_fic < 0) {
        printf("Erreur ouverture %s\n", fichier);
        exit(1);
    }

    max = 0;
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
        /* lire les nouvelles valeurs communiquées par les fils */
        /* et calculer le max intermédiaire */
        while (read(desc_fic, &max_lu, sizeof(int))>0) {
            if (max_lu > max) {
                max = max_lu;
            }
        }
    }
    close(desc_fic);
    printf("\nProcessus Principal termine. Max = %d\n", max);
    return EXIT_SUCCESS;
}
