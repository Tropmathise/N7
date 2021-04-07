#include "UNO.h"

#include <assert.h>
#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>

void test_piocher(){
    jeu le_jeu; // le jeu de cartes
    t_main main_A, main_B; // les deux mains
    carte last; // la derniere carte posee
   
    //Préparer le jeu, les deux mains de 7 cartes et la carte last
    int retour = preparer_jeu_UNO(le_jeu, 7, &main_A, &main_B, &last);
    printf("\n Les deux mains : \n");
    afficher_main(main_A);
    afficher_main(main_B);

    int mem_taille = main_A.nb;
    
    //Le joueur A pioche une carte dans le_jeu
    carte *c_piochee = piocher(le_jeu, &main_A);
    
    // Une carte a-t-elle été piochée ?
    assert(c_piochee);
    assert(c_piochee->presente==false); // absence du jeu ?
    assert(est_presente_main(main_A, *c_piochee));
    assert(main_A.nb = mem_taille + 1);

    // Affichage
    printf("\n\n ***** APRES la pioche : ");
    printf("\n La carte piochee : ");
    afficher_carte(*c_piochee);
    printf("\n La nouvelle main A après pioche : \n");
    afficher_main(main_A);
    printf("\n Le nouveau jeu après pioche : \n");
    afficher_jeu(le_jeu);

    //Détruire la mémoire allouée dynamiquement
    free(main_A.main);
    free(main_B.main);
    main_A.main = NULL;
    main_B.main = NULL;
}

int main(void) {
  
    test_piocher();
    
    printf("%s", "\n Bravo ! Tous les tests passent.\n");
    return EXIT_SUCCESS;
}
