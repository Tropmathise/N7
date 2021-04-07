#include "main.h"

#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <assert.h>

bool init_main(t_main* la_main, int N){
    assert(N <= (NB_CARTES-1)/2);
    la_main->main = malloc(N*sizeof(carte));
    la_main->nb = N;
    return (la_main==NULL); //allocation réussie ?
}

void afficher_main(t_main la_main){
    for (int k=0; k<la_main.nb; k++){
        afficher_carte(la_main.main[k]);
    }
    printf("\n");
}

void distribuer_mains(jeu le_jeu, int N, t_main* m1, t_main* m2){
    assert(N <= (NB_CARTES-1)/2);

    //Initialiser les mains de N cartes
    bool errA = init_main(m1, N);
    bool errB = init_main(m2, N);
    assert(!errA && !errB);
    
    //Distribuer les cartes
    for (int i=0; i<N; i++){
        // ajout d'une carte dans la main m1
        copier_carte(&(m1->main[i]), le_jeu[2*i]);
        // ajout d'une carte dans la main m2
        copier_carte(&(m2->main[i]), le_jeu[2*i+1]);
        //mise à jour de presente à false dans le_jeu
        le_jeu[2*i].presente = false;
        le_jeu[2*i+1].presente = false;
    }
}

bool est_presente_main(t_main main, carte c){
    int i = 0;
    while (i < main.nb && !est_egale(main.main[i], c)) {
        i++;
    }
    return !(i == main.nb);
}

carte * piocher(jeu le_jeu, t_main* main){
    // Recherche une carte presente dans le jeu.
    carte *carte_piochee = le_jeu;
    int i = 0;
    while(i < NB_CARTES && carte_piochee->presente == false){
        carte_piochee = carte_piochee + 1;
        i++;
    }
    if (i == NB_CARTES) {
        carte_piochee = NULL;
    } else {
        // Inserer la carte dans la main
        carte *tmp = realloc(main->main, (1+main->nb)*sizeof(carte));
        if (tmp) {
            main->main = tmp;
            copier_carte(&(main->main[main->nb]), *carte_piochee);
            main->nb = main->nb + 1;
            // La supprimer du jeu (on a un pointeur!)
            carte_piochee->presente = false;
        } else {
            // Echec de reallocation
            carte_piochee = NULL;
        }
    }
    return carte_piochee;
}

