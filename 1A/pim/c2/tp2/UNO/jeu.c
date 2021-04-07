#include "jeu.h"

#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>

void init_jeu(jeu le_jeu){
    int k=0;
    for (int i=0 ; i<4 ; i++){
        for (int j=0 ; j<NB_VALEURS ; j++){
            init_carte(&(le_jeu[k]), i, j, true);
            k++;
        }
    }
}

void afficher_jeu(jeu le_jeu){
    for (int k=0; k<NB_CARTES; k++){
        afficher_carte(le_jeu[k]);
    }
    printf("\n");
}

void melanger_jeu(jeu le_jeu){
    for (int k=0; k<1000; k++){
        // Choisir deux cartes aléatoirement
        int i = rand()%NB_CARTES;
        int j = rand()%NB_CARTES;        
        // Les échanger
        carte mem;
        copier_carte(&mem, le_jeu[i]); 
        copier_carte(&(le_jeu[i]), le_jeu[j]); 
        copier_carte(&(le_jeu[j]), mem); 
    }
}